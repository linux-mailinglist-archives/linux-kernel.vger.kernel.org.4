Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB807057CD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjEPTrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjEPTrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:47:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E6F4C2E
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:46:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A89563DB9
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3027C433EF;
        Tue, 16 May 2023 19:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684266413;
        bh=59a+rDii3+VCJ7DjAD80gdB2rcfLoV06qwulR+6qOKU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SVjQKWNaDZGvZzPKVniTWBUpgObglGb7Iejk4TddQM7giaq8FIdbQDsKxGtge98iB
         ZoggIBNEVg5yKHCl0Y574hiYlTSy9q9Jah/+YyTDYomiM6CdI3HK5r7+wfh//vFBoP
         eiavIsnsuw4ugo/US50pXEbsbKlrm4uR+qJGA/WfOouX4Wk0gcvNl6JtkuU8QiaYku
         RlX79eRRgLOWUlFqGRwWruK4DwYxMxK7XXZV5KJgaQUJawLIZKY7K3urxRMYOwRNzM
         fiWA5IF+nwEWu3q73mweCmoa/5axTxHKcihcpN1NIgA4NnwG5KFrEgUc5ccZPdprnX
         lEdgSKJzjUUbQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 651E4CE1143; Tue, 16 May 2023 12:46:53 -0700 (PDT)
Date:   Tue, 16 May 2023 12:46:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     oe-kbuild@lists.linux.dev, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: kernel/rcu/srcutree.c:1644 srcu_advance_state() warn:
 inconsistent returns '&ssp->srcu_sup->srcu_gp_mutex'.
Message-ID: <4de09952-297c-45c1-9cd9-b847293f5887@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <c0937326-1cf1-429a-9883-30d9d79b01d0@kili.mountain>
 <c33b0348-7f86-47ce-913c-f1ebc6431f93@paulmck-laptop>
 <30f2e760-e2f3-4941-be9b-b9c5624fd861@kili.mountain>
 <4bdbbcd3-6620-4320-ada5-02b71a54106c@paulmck-laptop>
 <782b3fa6-576d-4c26-888e-5dc151feaaa8@kili.mountain>
 <2ef061eb-e82d-4c16-a333-e499095a7162@paulmck-laptop>
 <0e191d4f-43ad-476a-92e0-d038715b25ca@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e191d4f-43ad-476a-92e0-d038715b25ca@kili.mountain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 03:21:55PM +0300, Dan Carpenter wrote:
> On Tue, May 16, 2023 at 05:17:57AM -0700, Paul E. McKenney wrote:
> > On Tue, May 09, 2023 at 06:13:02PM +0300, Dan Carpenter wrote:
> > > On Tue, May 09, 2023 at 07:08:05AM -0700, Paul E. McKenney wrote:
> > > > On Tue, May 09, 2023 at 08:40:33AM +0300, Dan Carpenter wrote:
> > > > > On Sat, May 06, 2023 at 11:45:35AM -0700, Paul E. McKenney wrote:
> > > > > > On Sat, May 06, 2023 at 10:22:04AM +0300, Dan Carpenter wrote:
> > > > > > > aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1632  	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) == SRCU_STATE_SCAN2) {
> > > > > > > 
> > > > > > > We don't mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex) if this if
> > > > > > > statement is false.
> > > > > > 
> > > > > > Hmmm...
> > > > > > 
> > > > > > I could make the above line read something like the following:
> > > > > > 
> > > > > > 	if (!WARN_ON_ONCE(rcu_seq_state(READ_ONCE(ssp->srcu_sup->srcu_gp_seq)) != SRCU_STATE_SCAN2)) {
> > > > > 
> > > > > Smatch ignores WARN_ON().  WARNings are triggered all the time, so it's
> > > > > not like a BUG() which stops the code flow.
> > > > > 
> > > > > > 
> > > > > > The theory is that there are only three legal values for ->srcu_gp_seq.
> > > > > > Because we hold ->srcu_gp_mutex, no one else can change it.   The first
> > > > > > "if" statement either returns or sets that state to SRCU_STATE_SCAN1.
> > > > > > The second "if" statement also either returns or sets that state to
> > > > > > SRCU_STATE_SCAN2.  So that statement should not be false.
> > > > > 
> > > > > Smatch can't figure out that the statement is true.  The issue there is
> > > > > that ssp->srcu_sup->srcu_gp_seq stores a value in the low bits and a
> > > > > different value in the high bits.  This seems like something that might
> > > > > be worth handling correctly at some point, but that point is in the
> > > > > distant future...
> > > > > 
> > > > > Just ignore this one.
> > > > 
> > > > Fair enough!  Yeah, I could imagine that this would be non-trivial.
> > > > 
> > > > Is there a not-reached annotation that Smatch pays attention to?
> > > 
> > > Hm...  Yeah.  If you wanted you could do this.  I'm not sure it improves
> > > the readability.  Also for some reason my private Smatch build doesn't
> > > print a warning...  I need to investigate why that is...
> > 
> > There does seem to be a fair number of instances of unreachable() in
> > the kernel, so why not?
> > 
> > May I add your Signed-off-by?
> 
> Sure.  I probably does make it more readable to some people as well.
> (It's a very narrow band of people who it helps).
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Except that this got me the following:

vmlinux.o: warning: objtool: process_srcu() falls through to next function same_state_synchronize_rcu()

Adding explicit return statements did not help.

Thoughts?

							Thanx, Paul
