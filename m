Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA9272E2B0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242244AbjFMMSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjFMMR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:17:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D98D10CC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:17:57 -0700 (PDT)
Message-ID: <20230613115353.599087484@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686658674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=+xkDu2ezsZFUK0UriVeN880YzwjasDfhm6+0tLf5Wqg=;
        b=bK72HX/UGPRhfy+hIwUqzr9tro3gQA9S+uXuH7t3vqXAK/DoM4H56/ieXpSfSTGvw/H52E
        avIKN0L1g0YeNRd7jg5mBW2R2LWcg+FCTURLtw1md52pCYdL5xhdUP7j22gId0hcfzPlPp
        Hw6gJSVPn/9SwKWYHH34KeA3hDLPfNLcwweNDt49d79lGuSKDMz2XPTx5wxLzJQ5IZmRrL
        mFC+I41WheWghH3/xQT125SGpc0cuSY8CzmIAqxjeENYrKGu3/x2HbAjvmlom5vziz0Dxv
        zLdBKOWw/meyb7uOiOWhb/70jE/irvid9i7YnM2ilUqdyqCLxbbOwh9dlhSPrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686658674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=+xkDu2ezsZFUK0UriVeN880YzwjasDfhm6+0tLf5Wqg=;
        b=kC7etQnYqwYKWNpRF3IIDMVI4RH3gfQAJKS4YSGnHY+2ULnNgl+g0rlN6iFKdGdos6aePg
        /z3d2SFcd5BOgeDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [patch V2 0/8] x86/smp: Cure stop_other_cpus() and kexec() troubles
Date:   Tue, 13 Jun 2023 14:17:54 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second version of the kexec() vs. mwait_play_dead()
series. Version 1 can be found here:

  https://lore.kernel.org/r/20230603193439.502645149@linutronix.de

Aside of picking up the correction of the original patch 5 this also
integrates a fix for intermittend reboot hangs reported by Tony:

  https://lore.kernel.org/r/3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com

which touches the same area. While halfways independent I added them here
as these changes conflict nicely.

So the two issues are:

  1) stop_other_cpus() continues after observing num_online_cpus() == 1.
     
     This is problematic because the to be stopped CPUs clear their online
     bit first and then invoke eventually WBINVD, which can take a long
     time. There seems to be an interaction between the WBINVD and the
     reboot mechanics as this intermittendly results in hangs.

  2) kexec() kernel can overwrite the memory locations which "offline" CPUs
     are monitoring. This write brings them out of MWAIT and they resume
     execution on overwritten text, page tables, data and stacks resulting
     in triple faults.

Cure them by:

  #1 Synchronizing stop_other_cpus() with an atomic variable which is
     decremented in stop_this_cpu() _after_ WBINVD completes.

  #2 Bringing offline CPUs out of MWAIT and move them into HLT before
     starting the kexec() kernel. Optionaly send them an INIT IPI so they
     go back into wait for startup state.

The series is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/kexec

Thanks,

	tglx
---
 include/asm/cpu.h |    2 
 include/asm/smp.h |    4 +
 kernel/process.c  |   16 +++++
 kernel/smp.c      |   79 ++++++++++++++++++----------
 kernel/smpboot.c  |  149 ++++++++++++++++++++++++++++++++++++++++--------------
 5 files changed, 183 insertions(+), 67 deletions(-)
