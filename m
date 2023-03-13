Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1136B85EA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 00:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCMXLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 19:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCMXLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 19:11:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7679128E51
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 16:11:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E9B461547
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 23:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F951C433EF;
        Mon, 13 Mar 2023 23:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678749112;
        bh=9NHRvmhtPUz+5vpXWJk461ltzBS6zXAulxvWTFWZMes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzV8zQ1UiE7II665/IZ0NrvonIRqktGBH3aQdT2wkG4ShppnKQS7wUui3zYuw5RMy
         VimMA+rFcdWSLCtX2g8hgsdC6v+GfeX3roDADxjhzBdr1LiTep1KP1Xo1EE6m7uDEA
         1paTlQmGKYRW90MgdR1ZkoZRyiw2tKZPH7GAFOTCMlKll5ainF60ts7+euXnYrLeoY
         TuurtHTGU2vZK3ot26yREO3xR10NIpHfQxyOIu1Jfkb0ZIXDxtPpydOYhxe831aWEq
         FBpHpmVjvCIjJDt5bDcPR43DcU+oBUBJWEA6QZVoaqQj9Y/j7O5eNRinO8utzkF+Q/
         dqHLS1t7J3QrQ==
Date:   Tue, 14 Mar 2023 00:11:49 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.3-rc2
Message-ID: <ZA+ttVOPBvNOYHoC@lothringen>
References: <CAHk-=wii6BZtVKYfvQCQqbE3+t1_yAb-ea80-3PcJ4KxgpfHkA@mail.gmail.com>
 <d915df60-d06b-47d4-8b47-8aa1bbc2aac7@roeck-us.net>
 <CAHk-=wi8xQw6eTRncbJfWWYHHi0UBG2B_AfHrzZbPr=k0V_WYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wi8xQw6eTRncbJfWWYHHi0UBG2B_AfHrzZbPr=k0V_WYQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 11:21:44AM -0700, Linus Torvalds wrote:
> On Mon, Mar 13, 2023 at 8:53 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Warning backtraces in calls from ct_nmi_enter(),
> > seen randomly.
> 
> Hmm.
> 
> I suspect this one is a bug in the warning, not in the kernel,
> although I have no idea why it would have started happening now.
> 
> This happens from an irq event, but that check is not *supposed* to
> happen at all from interrupts:
> 
>          * We dont accurately track softirq state in e.g.
>          * hardirq contexts (such as on 4KSTACKS), so only
>          * check if not in hardirq contexts:
> 
> but I think that the ct_nmi_enter() function was called before the
> hardirq count had even been incremented.

Indeed, ct_nmi_enter() is called very early on irq_enter(), before
HARDIRQ_OFFSET is added and the warning triggers at:

	if (!hardirq_count()) {
		if (softirq_count()) {
			/* like the above, but with softirqs */
			DEBUG_LOCKS_WARN_ON(current->softirqs_enabled); <---- HERE
		}

So the hardirq interrupted some code that has softirqs disabled (or
servicing) from the preempt mask POV but not from lockdep POV.

It says softirqs were last enabled/disabled at some random point, but the
function looks ok:

	 [   28.765386] softirqs last  enabled at (6328): [<c0103814>] vfp_sync_hwstate+0x48/0x8c
	 [   28.765575] softirqs last disabled at (6326): [<c01037cc>] vfp_sync_hwstate+0x0/0x8c

It would be interesting to see what the IRQ is interrupting. For example does it
happen while softirqs are serviced or just disabled? Or are we even outside any
of that? Any chance we can have a deeper stack trace? If not at least a print of
preempt_count() would be helpful.

Both would be awesome.

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 50d4863974e7..a7d1a65e5425 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5523,6 +5523,7 @@ static noinstr void check_flags(unsigned long flags)
 	 */
 	if (!hardirq_count()) {
 		if (softirq_count()) {
+			printk("preempt_count(): %x", preempt_count());
 			/* like the above, but with softirqs */
 			DEBUG_LOCKS_WARN_ON(current->softirqs_enabled);
 		} else {


Thanks.
