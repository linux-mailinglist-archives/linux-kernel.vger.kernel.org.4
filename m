Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA356787A9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjAWUZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjAWUZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:25:02 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 3E504212E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:25:01 -0800 (PST)
Received: (qmail 139858 invoked by uid 1000); 23 Jan 2023 15:25:00 -0500
Date:   Mon, 23 Jan 2023 15:25:00 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     paulmck@kernel.org, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org, viktor@mpi-sws.org
Subject: Re: [PATCH] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y87tHNcvb5E+t3da@rowland.harvard.edu>
References: <20230117193159.22816-1-jonas.oberhauser@huaweicloud.com>
 <Y8hN7vs/w8LhMasT@rowland.harvard.edu>
 <c22ec058-b058-0b6e-718b-348ff5cb5004@huaweicloud.com>
 <Y8i1QNjnZwim5uMq@rowland.harvard.edu>
 <1180fe22-5e1d-ec8b-8012-b6578b1ca7c0@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1180fe22-5e1d-ec8b-8012-b6578b1ca7c0@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 07:25:48PM +0100, Jonas Oberhauser wrote:
> Alright, after some synchronization in the other parts of this thread I am
> beginning to prepare the next iteration of the patch.
> 
> On 1/19/2023 4:13 AM, Alan Stern wrote:
> > On Wed, Jan 18, 2023 at 10:38:11PM +0100, Jonas Oberhauser wrote:
> > > 
> > > On 1/18/2023 8:52 PM, Alan Stern wrote:
> > > > On Tue, Jan 17, 2023 at 08:31:59PM +0100, Jonas Oberhauser wrote:
> > > > > -	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
> > > > > -	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
> > > > > -		fencerel(After-unlock-lock) ; [M])
> > > > > +	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M])
> > > > Shouldn't the po case of (co | po) remain intact here?
> > > You can leave it here, but it is already covered by two other parts: the
> > > ordering given through ppo/hb is covered by the po-unlock-lock-po & int in
> > > ppo, and the ordering given through pb is covered by its inclusion in
> > > strong-order.
> > What about the ordering given through
> > A-cumul(strong-fence)/cumul-fence/prop/hb?  I suppose that might be
> > superseded by pb as well, but it seems odd not to have it in hb.
> 
> How should we resolve this?
> My current favorite (compromise :D) solution would be to
> 1. still eliminate both po and co cases from first definition of
> strong-fence which is used in ppo,
> 2. define a relation equal to the strong-order in this patch (with po|rf)

Wouldn't it need to have po|co?  Consider:

	Wx=1	Rx=1		Ry=1		Rz=1
		lock(s)		lock(s)		lock(s)
		unlock(s)	unlock(s)	unlock(s)
		Wy=1		Wz=1		smp_mb__after_unlock_lock
						Rx=0

With the co term this is forbidden.  With only the rf term it is 
allowed, because po-unlock-lock-po isn't A-cumulative.

> but call it strong-fence for now (in response to Andrea's valid criticism
> that this patch is doing maybe more than just fix ppo)
> 3. use the extended strong-fence in the definition of cumul-fence and pb
> 
> So I'd still simplify po|co to po|rf and drop the po case from ppo, but
> return both of those cases in cumul-fence, to be consistent with the idea
> that cumul-fence should deal with the weak properties of the fences
> including this after-unlock-lock fence.
> 
> 
> Would that be acceptable?

Subject to the point mentioned above, yes.

Alan
