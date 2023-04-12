Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A396DFDDD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjDLSpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjDLSpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:45:18 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0842B5B8D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:45:15 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1878a0bf68fso324251fac.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681325114; x=1683917114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9jW8lTjmlnLP+VaTuDA/cPZo6I/NjUdF+u0UYf+p20=;
        b=ChDtRmpS13uPH3Dv861bG+B2sL8tWVRy7GRpQmfuTTZCZlMDYKwSR6qtBTeOI62nvy
         jbs85WVcDZ9235GtwFnK3iMZxxy41JM44CrQuti5ws0GgBPHWLXig18nviJyCCdZou5D
         lfzOPN84k2YI0JSqg+JLBX8gBxsrQxRVqxF5jE7opuA7F0guOlaNb6rIVpqBPt669JHx
         7PCog0ZqwIAeih6+gKh4nS8hzwx5r3XNsNS+FiAUVJyKCPV1FAv7VCyuEtUKRH1qOed/
         7v2BS0rpVsjF+4QT3qNX0Eyn9rPckIgEcbHil1Mqu+a46qgg6hQpnmjEmeCbFVqRoua9
         kZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681325114; x=1683917114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9jW8lTjmlnLP+VaTuDA/cPZo6I/NjUdF+u0UYf+p20=;
        b=OZB3hg+96QCcjGBTEDjp6Hvgb738Z6jHvRo5jietZNpabl+5uzkZvWXcGCbqL+L249
         GbM15CexMGZzY6YDV0aeq7x8VUJcb86EKWIxLCb0tlXccg9J8+7KNHjVDeyufu2NToV1
         FGhI13KaPA7lhd7HV/u2kUIPYSbOP5qTratqKriK/k4IkBpQlnwZv1uog0sLyOvbraNu
         3tGd+uWAhKnjer5mv+M44yTkefOdr8NY3pZh5Dw1KX1YnN0Sw1HzRK9H3pDVt4pfKEN5
         ArlFgwRAdbOey1POotmX4pQR7GJ+AEdNQYEgC7W6XyoyqOHEHn49GUok4fLC6puww6IQ
         jZKA==
X-Gm-Message-State: AAQBX9eH2ZdyEPDtc5mtDJ2PXhWg+96kGcQ3k2ujzOiA/4/H9YQgg7O2
        SyhthdSa/qoVJd+yOnpsVGx1yX7erA==
X-Google-Smtp-Source: AKy350YohM5+e/jy0IztChAnlEb/v6rW9tdJCM42oFCfh9/d+HGmufr2GnbmOLQ8xyNkAYtH5FcmKQ==
X-Received: by 2002:a05:6870:a116:b0:187:860f:ea31 with SMTP id m22-20020a056870a11600b00187860fea31mr776207oae.44.1681325114174;
        Wed, 12 Apr 2023 11:45:14 -0700 (PDT)
Received: from citadel.. (075-129-116-198.res.spectrum.com. [75.129.116.198])
        by smtp.gmail.com with ESMTPSA id w24-20020a9d77d8000000b00690e990e61asm6706020otl.14.2023.04.12.11.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:45:13 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 5/6] x86/boot: Use copied boot data in __startup_64()
Date:   Wed, 12 Apr 2023 14:45:01 -0400
Message-Id: <20230412184502.145289-6-brgerst@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412184502.145289-1-brgerst@gmail.com>
References: <20230412184502.145289-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the copied version instead of the original real mode data.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/setup.h | 2 +-
 arch/x86/kernel/head64.c     | 4 ++--
 arch/x86/kernel/head_64.S    | 2 --
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 47eac5d877a8..f6c04b137d67 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -49,7 +49,7 @@ extern unsigned long saved_video_mode;
 
 extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
-extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
+extern unsigned long __startup_64(unsigned long physaddr);
 extern void startup_64_setup_env(unsigned long physbase);
 extern void early_setup_idt(void);
 extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 9be8ce41d021..c7d3976a04d6 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -176,9 +176,9 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
  * boot-time crashes. To work around this problem, every global pointer must
  * be adjusted using fixup_pointer().
  */
-unsigned long __head __startup_64(unsigned long physaddr,
-				  struct boot_params *bp)
+unsigned long __head __startup_64(unsigned long physaddr)
 {
+	struct boot_params *bp = fixup_pointer(&boot_params, physaddr);
 	unsigned long load_delta, *p;
 	unsigned long pgtable_flags;
 	pgdval_t *pgd;
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 83fb0dc97ba5..c7b2ef379f42 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -113,9 +113,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * programmed into CR3.
 	 */
 	leaq	_text(%rip), %rdi
-	pushq	%rsi
 	call	__startup_64
-	popq	%rsi
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
 	addq	$(early_top_pgt - __START_KERNEL_map), %rax
-- 
2.39.2

