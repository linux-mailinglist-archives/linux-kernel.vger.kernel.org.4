Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71572675EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjATUg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjATUg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:36:26 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id DC600891F7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:36:24 -0800 (PST)
Received: (qmail 47262 invoked by uid 1000); 20 Jan 2023 15:36:24 -0500
Date:   Fri, 20 Jan 2023 15:36:24 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
Message-ID: <Y8r7SBdfuZX/y1cd@rowland.harvard.edu>
References: <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
 <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <20230118200601.GH2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8hclxuhpGm+krkz@rowland.harvard.edu>
 <20230119000214.GM2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8q6v3BZ8dlyoTxo@rowland.harvard.edu>
 <20230120175804.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8rff3HJ2o9wUyGT@rowland.harvard.edu>
 <20230120192032.GR2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120192032.GR2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 11:20:32AM -0800, Paul E. McKenney wrote:
> On Fri, Jan 20, 2023 at 01:37:51PM -0500, Alan Stern wrote:
> > srcu_read_unlock() does not need a full smp_mb().
> 
> That is quite possible, and that is what we are looking into.  And testing
> thus far agrees with you.  But the grace-period ordering constraints
> are quite severe, so this requires careful checking and severe testing.

If you're interested, I can provide a simple argument to show that the 
Fundamental Law of RCU would continue to hold with only a release fence.  
There is an added requirement: merely that synchronize_srcu() must have 
an smp_mb() somewhere after its final read of the unlock counters -- 
which your version of the algorithm already has.

Alan
