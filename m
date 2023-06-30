Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4892743CD1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjF3Ncj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbjF3Ncf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:32:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7341B359E;
        Fri, 30 Jun 2023 06:32:21 -0700 (PDT)
Date:   Fri, 30 Jun 2023 13:32:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688131940;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Ct27fAT+6XX7UPKXfhBWOCjOGHDjnQ44IBDaz+qjbw=;
        b=hfRme7N5dKXKo5O1TO8gz0XfuS+yInortheRRP39ifAjWip5iS8uieiiZ/+Tro9hYD4DRn
        Cj6BL2SaWZ09364aGxDA9D2a/pGZwDhLL+JLdnw9s6gowhiQE/BR+JLaqAHw6ohBNFE4Zp
        h+147ndUyUHUJMDa3lFxjjrckmEMSNY29oCuwFsq/Bn3zQwF7LfqHhQQJm0xgi6/JJzqgr
        Z8/38yj9CX9XYzP/HVBwdaSsfEbgfNUVFLpSz0+32b/tpQ+V38m2BJzpuPCfWkghd1IlKg
        rtUf2ADO233Zimskvr6niaXfrblijGnjJwJ27LAye7kb/Eq7qJGJXK4/eePT0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688131940;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Ct27fAT+6XX7UPKXfhBWOCjOGHDjnQ44IBDaz+qjbw=;
        b=aqIZJQLhieGpMxed3LDBpQb2BhQrZARAV4obijh/ckkjZiqQf5VdwzRK6yXAYiefxbBr24
        HlLZnoBeC4DVY5Cg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/efi: Make efi_set_virtual_address_map IBT safe
Cc:     pinkflames.linux@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87jzvm12q0.ffs@tglx>
References: <87jzvm12q0.ffs@tglx>
MIME-Version: 1.0
Message-ID: <168813193932.404.2885732890333911092.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0303c9729afc4094ef53e552b7b8cff7436028d6
Gitweb:        https://git.kernel.org/tip/0303c9729afc4094ef53e552b7b8cff7436=
028d6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 29 Jun 2023 21:35:19 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 30 Jun 2023 15:26:24 +02:00

x86/efi: Make efi_set_virtual_address_map IBT safe

Nikl=C4=81vs reported a boot regression on an Alderlake machine and bisected =
it
to commit 9df9d2f0471b ("init: Invoke arch_cpu_finalize_init() earlier").

By moving the invocation of arch_cpu_finalize_init() further down he
identified that efi_enter_virtual_mode() is the function which causes the
boot hang.

The main difference of the earlier invocation is that the boot CPU is
already fully initialized and mitigations and alternatives are applied.

But the only really interesting change turned out to be IBT, which is now
enabled before efi_enter_virtual_mode(). "ibt=3Doff" on the kernel command
line cured the problem.

Inspection of the involved calls in efi_enter_virtual_mode() unearthed that
efi_set_virtual_address_map() is the only place in the kernel which invokes
an EFI call without the IBT safe wrapper. This went obviously unnoticed so
far as IBT was enabled later.

Use arch_efi_call_virt() instead of efi_call() to cure that.

Fixes: fe379fa4d199 ("x86/ibt: Disable IBT around firmware")
Fixes: 9df9d2f0471b ("init: Invoke arch_cpu_finalize_init() earlier")
Reported-by: Nikl=C4=81vs Ko=C4=BCes=C5=86ikovs <pinkflames.linux@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217602
Link: https://lore.kernel.org/r/87jzvm12q0.ffs@tglx

---
 arch/x86/platform/efi/efi_64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 232acf4..77f7ac3 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -853,9 +853,9 @@ efi_set_virtual_address_map(unsigned long memory_map_size,
=20
 	/* Disable interrupts around EFI calls: */
 	local_irq_save(flags);
-	status =3D efi_call(efi.runtime->set_virtual_address_map,
-			  memory_map_size, descriptor_size,
-			  descriptor_version, virtual_map);
+	status =3D arch_efi_call_virt(efi.runtime, set_virtual_address_map,
+				    memory_map_size, descriptor_size,
+				    descriptor_version, virtual_map);
 	local_irq_restore(flags);
=20
 	efi_fpu_end();
