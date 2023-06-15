Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA57F7320F8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 22:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjFOUdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 16:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjFOUdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:33:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4856D2711
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:33:52 -0700 (PDT)
Message-ID: <20230615190036.898273129@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686861230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=5QOf0xPwncxqslzo3Jd+s/CMQaxshErQ6DKbtCWtqBQ=;
        b=4Gr4mvQnoLJdDX2MQg+Ox9t7CtsuphAHe5IzvobmwE0qfRjDMq+Yc/nabL6hEc52qaMYrE
        33aCsU53h23xBaBnopZayOz1om9k+vt/NeEmkM5s5pzwofLT3IosjXbm7G/mkq6vfzzU2F
        TTKfFh/H0UWeA+Fwa4iMPExyFC1vRQ7dN2mHdR+O4Bb8bF8n2HlAHZLG5pyB9wnDcX+/3E
        n6NX23HJRX1GvN0vlk3YqoymPRs0MWwCChw/ASGQJaRVaWPuqNCcx81rUeL55qaoAak8Jp
        W1h27PB16bY2POKShjO8gGsteWykn8F4Suh5g2gphNRrCWUzGRn66A7H7TrCzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686861230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=5QOf0xPwncxqslzo3Jd+s/CMQaxshErQ6DKbtCWtqBQ=;
        b=uGuFNY/aUpNc7kynBhAjP89XWOwPvER+YaN6l0b8JRxzh9mG9pFYFb0KZ/NPSDsJl+rAj4
        mxSNwDVBjcYyc4Ag==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [patch v3 0/7] x86/smp: Cure stop_other_cpus() and kexec() troubles
Date:   Thu, 15 Jun 2023 22:33:49 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the third version of the stop_other_cpus() / kexec()
vs. mwait_play_dead() series. Version 2 can be found here:

  https://lore.kernel.org/r/20230613115353.599087484@linutronix.de

The two issues addressed are:

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

  #1 Synchronizing stop_other_cpus() with a CPU mask which is updated in
     stop_this_cpu() _after_ WBINVD completes.

  #2 Bringing offline CPUs out of MWAIT and move them into HLT before
     starting the kexec() kernel. Optionaly send them an INIT IPI so they
     go back into wait for startup state.

Changes vs. V2:

  - Use a CPU mask instead of an atomic counter and send the NMI only to
    CPUs which did not report that they reached HLT. That's still not race
    free vs. a late handling of the reboot vector, but that's not fixable.

Interestingly enough testing the NMI mechanics unearthed that after soft
disabling the local APIC the CPU is _not_ handling the NMI despite the
SDM claiming:

  "The operation and response of a local APIC while in this software-disabled
   state is as follows:

   * The local APIC will respond normally to INIT, NMI, SMI, and SIPI messages."

I validated that even without handling the NMI, the CPU is kicked out of
HLT reliably.

It's unclear whether that's X2APIC specific and I neither verified that
behaviour on AMD. Nor is it clear what "respond normally" actually means.

The AMD APM is not helpful either:

  "SMI, NMI, INIT, Startup, and Remote Read interrupts may be accepted"

Oh well.

The series is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/kexec

Thanks,

	tglx
---
 include/asm/cpu.h |    2 
 include/asm/smp.h |    4 +
 kernel/process.c  |   25 +++++++--
 kernel/smp.c      |  111 +++++++++++++++++++++++++++++-----------
 kernel/smpboot.c  |  149 ++++++++++++++++++++++++++++++++++++++++--------------
 5 files changed, 220 insertions(+), 71 deletions(-)
