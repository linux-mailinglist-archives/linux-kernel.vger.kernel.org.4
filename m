Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E10771388D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 09:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjE1HxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 03:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjE1HxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 03:53:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9D4D8
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 00:53:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685260383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0CiayCmuynXWyLDPAGrYgKcXEb7S6XZxZQEc7fj0LTk=;
        b=EqZHdEGKKe6vzfzDVdTndGRcMdPrvBz2D6ZYFjHEvCKsOYfvLYiBffHixCIZJ13LPXXJM2
        zdLDkueuoZzE3VaAa325bKG63ZPgxYJBtylQiCphP3aqFg/HiciQI1SYTxtZT9r9KrP7W2
        fStrwlw1EaDELdA6u84F9sBxAG68azKbF5m9n8K93UWPH5iZL3Jqdd1cCcOLVM3o0iVSGa
        6e5ew3g82HtWIavzo4wo4426IgpSIer0GYMd7Nyq9xeW3NfCnsYkjb3oVkGOwq7sPZBQPW
        BzfF6F5YtIPgoIMDKHSoV+IILHWxE2lpaGuIzZ2XE/3wNFgpXY6mZgWHbczyfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685260383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0CiayCmuynXWyLDPAGrYgKcXEb7S6XZxZQEc7fj0LTk=;
        b=QbtPYb4ueYuVWsBo2lmr+PVRHaSA5we1SIWwL7JawuvYMi4/pgVRWvXtMA9Q6rmm/Rg9eh
        NMId5Os97rfNMNDw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for 6.4-rc4
References: <168526035526.3457722.14103350194452732675.tglx@xen13>
Message-ID: <168526036137.3457722.17274974250309862601.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 28 May 2023 09:53:02 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-=
05-28

up to:  edc0a2b59576: x86/topology: Fix erroneous smp_num_siblings on Intel H=
ybrid platforms


A single fix for x86:

 - Prevent a bogus setting for the number of HT siblings, which is caused
   by the CPUID evaluation trainwreck of X86. That recomputes the value
   for each CPU, so the last CPU "wins". That can cause completely bogus
   sibling values.

Thanks,

	tglx

------------------>
Zhang Rui (1):
      x86/topology: Fix erroneous smp_num_siblings on Intel Hybrid platforms


 arch/x86/kernel/cpu/topology.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 5e868b62a7c4..0270925fe013 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -79,7 +79,7 @@ int detect_extended_topology_early(struct cpuinfo_x86 *c)
 	 * initial apic id, which also represents 32-bit extended x2apic id.
 	 */
 	c->initial_apicid =3D edx;
-	smp_num_siblings =3D LEVEL_MAX_SIBLINGS(ebx);
+	smp_num_siblings =3D max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
 #endif
 	return 0;
 }
@@ -109,7 +109,8 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 	 */
 	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
 	c->initial_apicid =3D edx;
-	core_level_siblings =3D smp_num_siblings =3D LEVEL_MAX_SIBLINGS(ebx);
+	core_level_siblings =3D LEVEL_MAX_SIBLINGS(ebx);
+	smp_num_siblings =3D max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
 	core_plus_mask_width =3D ht_mask_width =3D BITS_SHIFT_NEXT_LEVEL(eax);
 	die_level_siblings =3D LEVEL_MAX_SIBLINGS(ebx);
 	pkg_mask_width =3D die_plus_mask_width =3D BITS_SHIFT_NEXT_LEVEL(eax);

