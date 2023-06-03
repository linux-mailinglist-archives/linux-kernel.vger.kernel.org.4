Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DC272125B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 22:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjFCUIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 16:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjFCUHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 16:07:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC82E74
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 13:07:24 -0700 (PDT)
Message-ID: <20230603193439.502645149@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685822815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=BQ88LTbW2bjMSOWAbmjSTzdR+6tslMVtAHZnogA/mqo=;
        b=0qD3zraSNnjHvv7+3PzzC8YBmPgbkc4VAPSWDD3ZIwZ1lTvtZfSogX4/icdtvTkiEuEXoy
        PTTcoG9sKMjxc8yCK90oq+DNWV+xWtPhLSOHkC9Ej3nC+ygWeCvNnCZ31mqB5I20ejOcN0
        u8l+t04Qubv2Ay1kJlP7hqBtEb8ErKxeA3k+H5ppphPU5vgyZ0kCvRSJ/O5dVsILif+e0T
        TekJrZqurz7/4iRyvOOmBctOY7MXnVqgJqxD2OmbqNSudj/+08LHZc5eu4MiLp4EGF+3lp
        mv+OmFK6/OMOCnd2iwF1l0qer/X84HdkZrtc5GKiGzeCKYHpBPLleLF0DePyhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685822815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=BQ88LTbW2bjMSOWAbmjSTzdR+6tslMVtAHZnogA/mqo=;
        b=lxD4ozVB09wBxSJ/zrGpYC+W/o/nQREh0+B4fpTD7AckMHnx1Nh5uRI91/5WIYecKvTOxC
        rbH+3YqTxvW/22DQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [patch 0/6] Cure kexec() vs. mwait_play_dead() troubles
Date:   Sat,  3 Jun 2023 22:06:54 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Ashok observed triple faults when executing kexec() on a kernel which has
'nosmt' on the kernel commandline and HT enabled in the BIOS.

'nosmt' brings up the HT siblings to the point where they initiliazed the
CPU and then rolls the bringup back which parks them in mwait_play_dead().
The reason is that all CPUs should have CR4.MCE set. Otherwise a broadcast
MCE will immediately shut down the machine.

Some detective work revealed that:

  1) The kexec kernel can overwrite text, pagetables, stack and data of the
     previous kernel.

  2) If the kexec kernel writes to the memory which is monitored by an
     "offline" CPU, that CPU resumes execution. That's obviously doomed
     when the kexec kernel overwrote text, pagetables, data or stack.

While on my test machine the first kexec() after reset always "worked", the
second one reliably ended up in a triple fault.

The following series cures this by:

  1) Bringing offline CPUs which are stuck in mwait_play_dead() out of
     mwait by writing to the monitored cacheline

  2) Let the woken up CPUs check the written control word and drop into
     a HLT loop if the control word requests so.

This is only half safe because HLT can resume execution due to NMI, SMI and
MCE. Unfortunately there is no real safe mechanism to "park" a CPU reliably,
but there is at least one which prevents the NMI and SMI cause: INIT.

  3) If the system uses the regular INIT/STARTUP sequence to wake up
     secondary CPUS, then "park" all CPUs including the "offline" ones
     by sending them INIT IPIs.

The INIT IPI brings the CPU into a wait for wakeup state which is not
affected by NMI and SMI, but INIT also clears CR4.MCE, so the broadcast MCE
problem comes back.

But that's not really any different from a CPU sitting in the HLT loop on
the previous kernel. If a broadcast MCE arrives, HLT resumes execution and
the CPU tries to handle the MCE on overwritten text, pagetables etc.

So parking them via INIT is not completely solving the problem, but it
takes at least NMI and SMI out of the picture.

The series is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/kexec

Thanks,

	tglx
---
 include/asm/smp.h |    4 +
 kernel/smp.c      |   62 +++++++++++++---------
 kernel/smpboot.c  |  151 ++++++++++++++++++++++++++++++++++++++++--------------
 3 files changed, 156 insertions(+), 61 deletions(-)

