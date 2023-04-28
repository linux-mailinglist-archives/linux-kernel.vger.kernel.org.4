Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F906F1DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346341AbjD1SJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjD1SJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:09:34 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C30126BA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:09:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-55605fd3e19so3123137b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682705372; x=1685297372;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=szMrRB+6uNQ8eyciuRiQr527CZbWdvgob9TY/kwfLGs=;
        b=jEnM8h2WmRSYHOV7JrVXCdH7EBqADBVIVINDIxCdBx1grlEFJxiRlEBBigmN2JQXfN
         16i3etlXVKLhvp9qsaKWCaO0lYp4/FqCGDwplm5MZr/+LKSek+WK0Q4pgoiMkJme0RLm
         M6hsvWI4GyHkus7zmtDEGioT2PW8jBf8JqsNfNWxWYLQOLBUfOgVZslYNEodffOyBL1U
         B4XG88dh5csyvULX3rBHAbHa7yxNTnHfV3Dmh4cYo0V9L+K3Y+Bd7eFkt2P/0uSW/sij
         WAufZ06cW0+hbORLORjZx2i3XULQpPyas8KwYHLmKGlyrgU517TSRa/TViT6QEEOp/Yd
         Vzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682705372; x=1685297372;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=szMrRB+6uNQ8eyciuRiQr527CZbWdvgob9TY/kwfLGs=;
        b=LAu1P5Ay8Y5sK3uIUBU5IsMmPwkeAzfX29BgT0hxaJOH/j64qGDb6gzrOSegNH3q5f
         oV4/kikx4moShIiu7OoKwQa0yWXZUiafPw8ckUyHzjQkG+KEr180rz2rhaFqKnGWX75P
         oGdc05NKgznX6sAgJg7dDKmEv3Vi8/cyjXrw5Ivid8aCQayc/IL1HgCrEi0zkvbGj4E2
         Q1Wo5FXH6Lae8YTrwgAcw3r1cuET6H8roOWEeBm6lN8gvMO6THVxajfTVEVcpadKo3GY
         kepE4BxgLoHBG5aO6m4NHIQyuZZmqG0rZfq3GA49C+U7XZG15NFUMy8Sl+qxlvfyNev2
         hi6Q==
X-Gm-Message-State: AC+VfDxGQ2S6hAWEISbY/JGCWzhZ8J42aM0GsMUusqu70ClhO+jVau60
        6sfzRXWh58O5x9jfFktNQz0VuFuvr43OCbFfup4=
X-Google-Smtp-Source: ACHHUZ4Dh0ZhHgHRrQTm+kfQrvOqSe4pbWS2GUqcJ1c3wpAvIoGqdFFanowzodwW/xY1NsQc1gIGkCeFZc77UL3yDP8=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:7fbc:5712:e6b1:f733])
 (user=ndesaulniers job=sendgmr) by 2002:a81:4011:0:b0:54f:9e1b:971c with SMTP
 id l17-20020a814011000000b0054f9e1b971cmr3698136ywn.1.1682705372224; Fri, 28
 Apr 2023 11:09:32 -0700 (PDT)
Date:   Fri, 28 Apr 2023 11:09:25 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANQLTGQC/x2MSwqFMAwAryJZW9Ba8HMVcZHWqFlYJZH3BPHuV
 pfDDHOBkjApdNkFQj9W3mKCMs8gLBhnMjwmBlvYqnC2Mfg/TairyfmR6jY4SKVHJeMFY1jedkU 9SF6xC018fvt+uO8H78bmTG4AAAA=
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682705370; l=2976;
 i=ndesaulniers@google.com; s=20220923; h=from:subject:message-id;
 bh=OJwVNKGwwd9jKotxFOlwqnw1rAfDxwhSr52KJhekYzI=; b=ZgrE30nmkV43i/VkWMTHmOw+6R/JwtaexxX9U/Hudmwq3K8EiFhFYVBa7BfIE+CZyxrU2+j1A7mc
 rMoBi3cCDZ/RN9YoMdrI3vrTq1PDmJbcG7hwOG83crnzRZOfiqCW
X-Mailer: b4 0.12.2
Message-ID: <20230428-awx-v1-1-1f490286ba62@google.com>
Subject: [PATCH] arm64: kernel: remove SHF_WRITE|SHF_EXECINSTR from .idmap.text
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

This patch fixes up the remaining stragglers that were left behind.

Because .idmap.text is merged into .text, LLD will retain the
SHF_EXECINSTR on .text, in addition to the synthetic .got.  This doesn't
matter to the kernel loader, but syzkaller is having trouble symboling
such sections. Clean this up while we additionally fix up syzkaller. Add
Fixes tag so that this doesn't precede related change in stable.

Fixes: d54170812ef1 ("arm64: fix .idmap.text assertion for large kernels")
Reported-by: Greg Thelen <gthelen@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
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

