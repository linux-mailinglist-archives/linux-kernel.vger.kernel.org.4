Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBC274C3ED
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 13:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjGIL5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 07:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGIL5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 07:57:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8341719A
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 04:57:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688903824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1kWrvpmhbHCJ21kyLibA+w+bJszSzuk/ADgUYUUWBsg=;
        b=g/6eGCvzQr9G5hHaE8Q5s6e6A8jKolY2cBKfEoXIr/NhT3usFNvdaAXirbEJzZoo4V1n4h
        n1mzGGisfOoGrUFhoomrCSkzDDmhnvOEkrEsZRqRih3u5cfxB52Ee3j/pc5ZGnr1oxr+P9
        LQXIgriOs2RM1Sm6KnqgS4nRGfM9U0RYs1p2tOPIlaV7rjL5jxCS5lYV4sBL4e69XAm+k5
        Lj8kwzt1dm+h2FO0gT3pKCEFZ+YmPS8lIKS/IyfRePqjVPvFNYJ5KhKQyMFEbj2NUsfMHq
        /AWGbc7diUJfZpdqDQFjkwOgkW+Fi9NfL30tRkT0JiRa4i8j3XhW3DPdq69Zmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688903824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1kWrvpmhbHCJ21kyLibA+w+bJszSzuk/ADgUYUUWBsg=;
        b=EyYSOIXytp7ei7fRWLLgINmcTOhc1EhoVOvHGWswjddJpVoaEC1MM0nxFW6PLQXgDSUe6n
        4N5j3hcfuA++tbCA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/core for v6.5-rc1
Message-ID: <168890380261.187070.2103277819790991312.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun,  9 Jul 2023 13:57:03 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2023-07=
-09

up to:  b1472a60a584: x86/smp: Don't send INIT to boot CPU


A single fix for the mechanism to park CPUs with an INIT IPI.

On shutdown or kexec, the kernel tries to park the non-boot CPUs with an
INIT IPI. But the same code path is also used by the crash utility. If the
CPU which panics is not the boot CPU then it sends an INIT IPI to the boot
CPU which resets the machine. Prevent this by validating that the CPU which
runs the stop mechanism is the boot CPU. If not, leave the other CPUs in
HLT.


Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      x86/smp: Don't send INIT to boot CPU


 arch/x86/kernel/smpboot.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 4ee43396b910..7417d9b55b21 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1473,6 +1473,14 @@ bool smp_park_other_cpus_in_init(void)
 	if (apic->wakeup_secondary_cpu_64 || apic->wakeup_secondary_cpu)
 		return false;
=20
+	/*
+	 * If this is a crash stop which does not execute on the boot CPU,
+	 * then this cannot use the INIT mechanism because INIT to the boot
+	 * CPU will reset the machine.
+	 */
+	if (this_cpu)
+		return false;
+
 	for_each_present_cpu(cpu) {
 		if (cpu =3D=3D this_cpu)
 			continue;

