Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4804D6A4A03
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjB0Sla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjB0Sl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:41:27 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 02BBE25E37
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 10:41:25 -0800 (PST)
Received: (qmail 135175 invoked by uid 1000); 27 Feb 2023 13:41:25 -0500
Date:   Mon, 27 Feb 2023 13:41:25 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y/z5VXdhPFtbtd3V@rowland.harvard.edu>
References: <20230224183758.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230226010110.GA1576556@paulmck-ThinkPad-P17-Gen-1>
 <Y/rEH2r9i0BtfxEW@rowland.harvard.edu>
 <Y/rNUfW509AQYCYn@boqun-archlinux>
 <Y/rSQ2FNTJyj2bqR@rowland.harvard.edu>
 <a862ee59-ca12-b609-48cc-0784c7ce24af@huaweicloud.com>
 <Y/uOA3umovz06/SV@rowland.harvard.edu>
 <dd87369d-825f-e932-dd86-8e46e92d1a7e@huaweicloud.com>
 <Y/zXYXM1lgk7Msig@rowland.harvard.edu>
 <b07b75cd-0627-da3c-54e8-cc22088c148e@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b07b75cd-0627-da3c-54e8-cc22088c148e@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 05:50:15PM +0100, Jonas Oberhauser wrote:
> > So I don't see this as a valid argument for not using rw-xbstar in
> > rw-race.  Even theoretically.
> 
> There's nothing wrong with using rw-xbstar in rw-race, especially in current
> LKMM, and I'm not arguing against that.
> 
> I'm saying that the argument
> "if rw-xbstar links a read R to a plain write W, and that plain write is
> replaced by a read R', and in case R' reads a value different from W,
> followed by a store W' (with some dependency from R' to W')  by the
> compiler, then the fact that R and R' can't have a data race means that it's
> safe to use rw-xbstar in rw-race"
> is incomplete. (Of course that doesn't mean the claim is wrong.)
> To make the argument complete, you also need that W' is generated if
> necessary, and more crucially that W' is still ordered behind R!
> Otherwise you would now have a data race between R and W', like in the
> hypothetical example I mentioned, even though R and R' don't race.
> 
> And if you do that second step in LKMM (even with the change of
> w-pre-bounded we are discussing) you quickly find that W' is indeed still
> ordered, so rw-xbstar is perfectly fine.
> 
> Perhaps that step is so trivial to you that you don't feel it needs
> mentioning : ) But speaking about LKMM-like models in general, some might
> have some subtle case where rw-xbstar links R and W but would not R and W'.

Ah, okay.  Yes, it is a subtle point.  And by the reasoning I just used, 
if such a case did exist then one could conclude it would be an example 
demonstrating that rw-xbstar should not have linked R and W in the first 
place.

And it looks like I should write up and submit a patch allowing more 
dependencies in the definition of w-pre-bounded.

Alan
