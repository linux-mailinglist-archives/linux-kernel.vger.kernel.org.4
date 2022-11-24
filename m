Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F31C63737B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiKXINE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiKXIMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:12:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD44DB87D;
        Thu, 24 Nov 2022 00:12:01 -0800 (PST)
Date:   Thu, 24 Nov 2022 08:11:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669277520;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CskZbCqKrwexy97HjUI29JgnA5O45r1vBW03Gc0+UEE=;
        b=veo983jkg9RsBcru3v9EXXgmCv1/4Z+q+PLuzNtkQSgkXw4cdrNVC6t4mzuJePYAPlSWO/
        Huu61fQWPanp10vLiERr+ylpqgqDT5VZ8etJF2eTXbvcxVE44CbaEBxWgter8xddrx8WUY
        QtfLRm1cyXKPbALHrcHXVLlb5UcD5CMZak6j9zP4SCFGTHwIT3N6OKh2QSQuDWlmoFlGPo
        Hgk6FLVEtoFLYQp63SXNo1aJDlgyvWWdaItsCKjlHqmjgaPOV+qFINr3p+ccpvX5lf73RN
        eT0YFfBQiMZ6Db4e1YoKVmOkP1l2CLI+fTCt8nvA4zgXuvgRvTCfR4PJ3cpx+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669277520;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CskZbCqKrwexy97HjUI29JgnA5O45r1vBW03Gc0+UEE=;
        b=pHcUyV2Z73akOeBj0E6S+sNkJh9uw+vqDaXrQ7aVy1n1CE5m99Rk8Twa6U8Dk1ZBYKEju3
        badW+s0vkuRYKyDw==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed: Only build mem_encrypt.S if
 AMD_MEM_ENCRYPT=y
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221122161017.2426828-17-ardb@kernel.org>
References: <20221122161017.2426828-17-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <166927751915.4906.5763903520238092711.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     61de13df95901bc58456bc5acdbd3c18c66cf859
Gitweb:        https://git.kernel.org/tip/61de13df95901bc58456bc5acdbd3c18c66cf859
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 22 Nov 2022 17:10:16 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 24 Nov 2022 08:57:41 +01:00

x86/boot/compressed: Only build mem_encrypt.S if AMD_MEM_ENCRYPT=y

Avoid building the mem_encrypt.o object if memory encryption support is
not enabled to begin with.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221122161017.2426828-17-ardb@kernel.org
---
 arch/x86/boot/compressed/Makefile      | 2 +-
 arch/x86/boot/compressed/mem_encrypt.S | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index cd1a629..3dc5db6 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -100,7 +100,7 @@ vmlinux-objs-$(CONFIG_RANDOMIZE_BASE) += $(obj)/kaslr.o
 ifdef CONFIG_X86_64
 	vmlinux-objs-y += $(obj)/ident_map_64.o
 	vmlinux-objs-y += $(obj)/idt_64.o $(obj)/idt_handlers_64.o
-	vmlinux-objs-y += $(obj)/mem_encrypt.o
+	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/mem_encrypt.o
 	vmlinux-objs-y += $(obj)/pgtable_64.o
 	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/sev.o
 endif
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index e696745..32f7cc8 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -307,7 +307,6 @@ SYM_FUNC_END(startup32_check_sev_cbit)
 
 	.data
 
-#ifdef CONFIG_AMD_MEM_ENCRYPT
 	.balign	8
 SYM_DATA(sme_me_mask,		.quad 0)
 SYM_DATA(sev_status,		.quad 0)
@@ -323,4 +322,3 @@ SYM_DATA_START_LOCAL(boot32_idt_desc)
 	.word	. - boot32_idt - 1
 	.long	0
 SYM_DATA_END(boot32_idt_desc)
-#endif
