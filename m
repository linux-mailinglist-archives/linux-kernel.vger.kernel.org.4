Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668526F1E03
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346475AbjD1S2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjD1S2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:28:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B782E5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:28:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b96ee51ee20so14438276.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682706522; x=1685298522;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6QMZhDexxfLA2RQm0j2+ddKdXUKAWu/zoiDOxn4nNp0=;
        b=eGuGclpc9YdkQ55iylhcpFpKDIDB1qtK+qNyaGX+Zrug29FfoCVq1V4jOJjTnEFQvC
         YYmyGGwqYf/O/NMyOjjDNnMSa32sEzYlpgPM16T9wInkHaSj42BRPPDeaUXuYkRyLT5f
         rFGnGA77a2skM9iKQPI4F0+0ZVnGdY2/oJMD7HBscHhC/XzNOERZ9WIWIiuBlu7NNV3L
         i8KDtNOzE/V2ddHpOC5BSL4qvkxMDF+P/Oea+7d4d+iX9nLr8TsjMU08fTVRPaxnnHQg
         Hs4hEx4TVEnJmvPHVn7uSXXsScegWDkY7Gpx1iHfRKbDuKVOSMecmZTlJtUUHYGz1kAK
         e7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682706522; x=1685298522;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6QMZhDexxfLA2RQm0j2+ddKdXUKAWu/zoiDOxn4nNp0=;
        b=cIbwcHp0DjDm6wGbuMOTOUOHA3M4/EkdEMLmHF+wVv5s2OLPHbepVVfFa3mDZRQs9e
         pKnrK+U9pytpGTbcti8r0hPVZ8TawxYdhTvHyuHQsZDTQGJntW/iPlbhZb+99hcAJxQS
         FaG4APM/8xNYH4g5BZ2OWpwrPCu852KDM85Jxm2luCp14Y0S/brkIJnSdcwbGJJyBqjh
         FhY3KCelN0HfN+6vRtIaKWeTW2ASOpHUIE5W3Hu886O0/UfObm3pbIZTphwXFIHGREbo
         AicXIzD3sefYA2Asg+xb3hnLnhZpysCJZY0V7LBiUfOnqfZoStK1kgJ/YFCFiHF+fb8K
         3vXg==
X-Gm-Message-State: AC+VfDyHWAqBj8bDlLpf7Te1RjnlYWr6A3P3YgqZpFEjblWH+Bnt43Hf
        eVvcfJGQ0Wemr95OivECQAymbJUQ25cIMbSTWHk=
X-Google-Smtp-Source: ACHHUZ5idZkiCKz1EASMYbM/j7+zkwXFRJf1BxJBqhW+ZeS3z8V2nM2ANgbXZ3SvrzrKtWFu8y+4WqTlKCaaigOgti8=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:7fbc:5712:e6b1:f733])
 (user=ndesaulniers job=sendgmr) by 2002:a25:c04b:0:b0:b8f:4696:8fa1 with SMTP
 id c72-20020a25c04b000000b00b8f46968fa1mr3494622ybf.10.1682706522647; Fri, 28
 Apr 2023 11:28:42 -0700 (PDT)
Date:   Fri, 28 Apr 2023 11:28:17 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEAQTGQC/1WNzQ6DIBCEX8XsuTSKxJ+e+h6NB8BVSSqYxVAbw
 7sXvDVz+mYmMyd4JIMeHsUJhMF442wCfitAL9LOyMyYGHjJ61LwjsnPwXRbT0KN2PZaQGoq6ZE
 pklYvubtKvyPlYCOczHHNv4bEi/G7o+/1Fqrs/g+HiiVNoi951yjZ8Ofs3PzGu3YrDDHGH5o7+ 2OwAAAA
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682706521; l=2902;
 i=ndesaulniers@google.com; s=20220923; h=from:subject:message-id;
 bh=dTA9ynq73YQ/e9h+i1pEgv2IYWGxww8jCupOBbep0Wk=; b=5emz5BsCicOnQUdl7fVcK6+ZNZyTu3YFpE7YTmPGddTU7ZbUO8M6Hke1drny3VKssnBapXLq7qqK
 bSVTFj/TAKr79xqt9rrUkE94aToiU0IpJJor4JUFOMxTLyp7YaGL
X-Mailer: b4 0.12.2
Message-ID: <20230428-awx-v2-1-b197ffa16edc@google.com>
Subject: [PATCH v2] arm64: kernel: remove SHF_WRITE|SHF_EXECINSTR from .idmap.text
From:   ndesaulniers@google.com
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Greg Thelen <gthelen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit d54170812ef1 ("arm64: fix .idmap.text assertion for large kernels")
modified some of the section assembler directives that declare
.idmap.text to be SHF_ALLOC instead of
SHF_ALLOC|SHF_WRITE|SHF_EXECINSTR.

This patch fixes up the remaining stragglers that were left behind.  Add
Fixes tag so that this doesn't precede related change in stable.

Fixes: d54170812ef1 ("arm64: fix .idmap.text assertion for large kernels")
Reported-by: Greg Thelen <gthelen@google.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes in v2:
- Drop irrelevant paragraph.
- Pick up Ard's RB tag.
- Link to v1: https://lore.kernel.org/r/20230428-awx-v1-1-1f490286ba62@google.com
---
 arch/arm64/kernel/cpu-reset.S | 2 +-
 arch/arm64/kernel/sleep.S     | 2 +-
 arch/arm64/mm/proc.S          | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
index 6b752fe89745..c87445dde674 100644
--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -14,7 +14,7 @@
 #include <asm/virt.h>
 
 .text
-.pushsection    .idmap.text, "awx"
+.pushsection    .idmap.text, "a"
 
 /*
  * cpu_soft_restart(el2_switch, entry, arg0, arg1, arg2)
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index 2ae7cff1953a..2aa5129d8253 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -97,7 +97,7 @@ SYM_FUNC_START(__cpu_suspend_enter)
 	ret
 SYM_FUNC_END(__cpu_suspend_enter)
 
-	.pushsection ".idmap.text", "awx"
+	.pushsection ".idmap.text", "a"
 SYM_CODE_START(cpu_resume)
 	mov	x0, xzr
 	bl	init_kernel_el
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 91410f488090..c2cb437821ca 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -167,7 +167,7 @@ alternative_else_nop_endif
 SYM_FUNC_END(cpu_do_resume)
 #endif
 
-	.pushsection ".idmap.text", "awx"
+	.pushsection ".idmap.text", "a"
 
 .macro	__idmap_cpu_set_reserved_ttbr1, tmp1, tmp2
 	adrp	\tmp1, reserved_pg_dir
@@ -201,7 +201,7 @@ SYM_FUNC_END(idmap_cpu_replace_ttbr1)
 
 #define KPTI_NG_PTE_FLAGS	(PTE_ATTRINDX(MT_NORMAL) | SWAPPER_PTE_FLAGS)
 
-	.pushsection ".idmap.text", "awx"
+	.pushsection ".idmap.text", "a"
 
 	.macro	kpti_mk_tbl_ng, type, num_entries
 	add	end_\type\()p, cur_\type\()p, #\num_entries * 8
@@ -400,7 +400,7 @@ SYM_FUNC_END(idmap_kpti_install_ng_mappings)
  * Output:
  *	Return in x0 the value of the SCTLR_EL1 register.
  */
-	.pushsection ".idmap.text", "awx"
+	.pushsection ".idmap.text", "a"
 SYM_FUNC_START(__cpu_setup)
 	tlbi	vmalle1				// Invalidate local TLB
 	dsb	nsh

---
base-commit: 22b8cc3e78f5448b4c5df00303817a9137cd663f
change-id: 20230428-awx-c73f4bde79c4

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

