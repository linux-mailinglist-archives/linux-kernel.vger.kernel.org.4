Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8836816E0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbjA3Quo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237729AbjA3Quj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:50:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FAA3D914
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:50:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A706B80C9B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 16:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F412C433D2;
        Mon, 30 Jan 2023 16:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675097432;
        bh=cqZfJm/B7m8Rcf0XZgQtIIXF8A/wdT9uLk38KO8wBSE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YZk+A9x8rA2Off1chRn5spMuXLfa2IGI7YT4OFcleZrEh9FtUVcOUZEaz0tC1L51W
         CgGtJLbnF6H2g0cjIBlemixUOHVsMmGfrYth8fziiDNb4iEg1DRm17Yr6UMpw/nB62
         idl04sMj/UYGwmSjKAXKKif3jrv58s20mdTr6iOB0BVe/7cD3c3B7kelnJGas0Uyrk
         wkJLq93XahHKZ+4jKOy4xB4oIYmsycqQItPjwfg06IA9xlqDCX5Kk+CnHpwbxqgnPu
         nbDYSlg4zwDy5JNBOjx6TQE9g+JjBFe+I6/2NqzOxrK/p4imVYr+Em6/3OEhwdhNSN
         ZVB3Kew05bkLg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B9C985C084D; Mon, 30 Jan 2023 08:50:31 -0800 (PST)
Date:   Mon, 30 Jan 2023 08:50:31 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        Andrea Parri <parri.andrea@gmail.com>, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tools/memory-model: Make ppo a subrelation of po
Message-ID: <20230130165031.GS2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230126134604.2160-3-jonas.oberhauser@huaweicloud.com>
 <Y9Kr+GntQyGKPH3K@rowland.harvard.edu>
 <47acbaa7-8280-48f2-678f-53762cf3fe9d@huaweicloud.com>
 <Y9V+CyKIjg8sgVAC@rowland.harvard.edu>
 <Y9WeOTmGCCfjMUtG@andrea>
 <Y9Wo6OttHC4sUxCS@rowland.harvard.edu>
 <0da94668-c041-1d59-a46d-bd13562e385e@huaweicloud.com>
 <Y9ct1aAnOTGCy9n2@rowland.harvard.edu>
 <20230130043645.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9f0tlBSgtYeiaiL@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9f0tlBSgtYeiaiL@rowland.harvard.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 11:47:50AM -0500, Alan Stern wrote:
> On Sun, Jan 29, 2023 at 08:36:45PM -0800, Paul E. McKenney wrote:
> > On Sun, Jan 29, 2023 at 09:39:17PM -0500, Alan Stern wrote:
> > > On Sun, Jan 29, 2023 at 11:19:32PM +0100, Jonas Oberhauser wrote:
> > > > I see now. Somehow I thought stores must execute in program order, but I
> > > > guess it doesn't make sense.
> > > > In that sense, W ->xbstar&int X always means W propagates to X's CPU before
> > > > X executes.
> > > 
> > > It also means any write that propagates to W's CPU before W executes 
> > > also propagates to X's CPU before X executes (because it's the same CPU 
> > > and W executes before X).
> > > 
> > > > > Ideally we would fix this by changing the definition of po-rel to:
> > > > > 
> > > > > 	[M] ; (xbstar & int) ; [Release]
> > > > > 
> > > > > (This is closely related to the use of (xbstar & int) in the definition
> > > > > of vis that you asked about.)
> > > > 
> > > > This misses the property of release stores that any po-earlier store must
> > > > also execute before the release store.
> > > 
> > > I should have written:
> > > 
> > > 	[M] ; (po | (xbstar & int)) ; [Release]
> > > 
> > > > Perhaps it could be changed to the old  po-rel | [M] ; (xbstar & int) ;
> > > > [Release] but then one could instead move this into the definition of
> > > > cumul-fence.
> > > > In fact you'd probably want this for all the propagation fences, so
> > > > cumul-fence and pb should be the right place.
> > > > 
> > > > > Unfortunately we can't do this, because
> > > > > po-rel has to be defined long before xbstar.
> > > > 
> > > > You could do it, by turning the relation into one massive recursive
> > > > definition.
> > > 
> > > Which would make pretty much the entire memory model one big recursion.  
> > > I do not want to do that.
> > > 
> > > > Thinking about what the options are:
> > > > 1) accept the difference and run with it by making it consistent inside the
> > > > axiomatic model
> > > > 2) fix it through the recursive definition, which seems to be quite ugly but
> > > > also consistent with the power operational model as far as I can tell
> > > > 3) weaken the operational model... somehow
> > > > 4) just ignore the anomaly
> > > > 5) ???
> > > > 
> > > > Currently my least favorite option is 4) since it seems a bit off that the
> > > > reasoning applies in one specific case of LKMM, more specifically the data
> > > > race definition which should be equivalent to "the order of the two races
> > > > isn't fixed", but here the order isn't fixed but it's a data race.
> > > > I think the patch happens to almost do 1) because the xbstar&int at the end
> > > > should already imply ordering through the prop&int <= hb rule.
> > > > What would remain is to also exclude rcu-fence somehow.
> > > 
> > > IMO 1) is the best choice.
> > > 
> > > Alan
> > > 
> > > PS: For the record, here's a simpler litmus test to illustrates the 
> > > failing.  The idea is that Wz=1 is reordered before the store-release, 
> > > so it ought to propagate before Wy=1.  The LKMM does not require this.
> > 
> > In PowerPC terms, would this be like having the Wz=1 being reorders
> > before the Wy=1, but not before the lwsync instruction preceding the
> > Wy=1 that made it be a release store?
> 
> No, it would be like having the Wz=1 reordered before the Rx=1, 
> therefore before the lwsync.  Obviously this can't ever happen on 
> PowerPC.

Whew!!!  ;-)

							Thanx, Paul

> Alan
> 
> > If so, we might have to keep this quirk.
> > 
> > 							Thanx, Paul
> > 
> > > C before-release
> > > 
> > > {}
> > > 
> > > P0(int *x, int *y, int *z)
> > > {
> > > 	int r1;
> > > 
> > > 	r1 = READ_ONCE(*x);
> > > 	smp_store_release(y, 1);
> > > 	WRITE_ONCE(*z, 1);
> > > }
> > > 
> > > P1(int *x, int *y, int *z)
> > > {
> > > 	int r2;
> > > 
> > > 	r2 = READ_ONCE(*z);
> > > 	WRITE_ONCE(*x, r2);
> > > }
> > > 
> > > P2(int *x, int *y, int *z)
> > > {
> > > 	int r3;
> > > 	int r4;
> > > 
> > > 	r3 = READ_ONCE(*y);
> > > 	smp_rmb();
> > > 	r4 = READ_ONCE(*z);
> > > }
> > > 
> > > exists (0:r1=1 /\ 2:r3=1 /\ 2:r4=0)
