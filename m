Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3D673FAE5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjF0LRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjF0LQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:16:57 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B336F270B;
        Tue, 27 Jun 2023 04:16:46 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso3526120a12.1;
        Tue, 27 Jun 2023 04:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687864606; x=1690456606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ne0PfVTRcVEKKxj4M4FGiBreoIJtV1Je4xxVE1tvmME=;
        b=csDpxKTkeKlIZd1ZxV9bVmVvcOZzBlSSK9G20YV0iihRsK85x5dXSh8ZlyKFUbDdUH
         qfaRLEWNb407VgQMScSD4pdJ5KI+KQROQ9k40WhCHWYwDzbPcFl64wQqUveoDyCdCcGo
         yJERQPG0K9LMc8/tONvLSZAZMcRbK4CkgPN+o3jp7D5dOsGSOTuxtg2du6Pa6sTN2L6z
         OIbd2UFdSe5nmdJSH+hHGRUUUQnweL8xJc81YnFAwztsabVW56GntuKG2sttJgp/OaZE
         R/wLak3RIpWDAgyrnbftSHraraJ43Aq5oTdVxxIF4Q1K/VF8j5Duog41CmJydTbspLCE
         AXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687864606; x=1690456606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ne0PfVTRcVEKKxj4M4FGiBreoIJtV1Je4xxVE1tvmME=;
        b=hiIYE9tLgA7xnUncwulE0Ae128wkAV/fzbzEQ65T1YV4yi6SxnCz4fdotk69YtX6L3
         r+RlZSCowPLK55sTgEmyD8P1WHh9Bem0ANxaNvxw9DiAA74ucSHZ+riFiH0WRgTHJ9Ra
         0Yu5F/rDQmPF1fAt4L3Q/KU4fn/8yS82nPKVEL9j6+PYXv1NGKAR698syCmHEyYuNAvi
         eDrJmhD6liNA/SSui694Lz9jBPql/ib67+zjpeGsLS6BRWVZPllFkE6JrvcI2muWMMNY
         EKK9mVFisc1yvxrIGJ9FfNoGWe+WnFJEdogjIjnuh92V3mcBqOUwdTjVROuCgyvujfGn
         Cl1Q==
X-Gm-Message-State: AC+VfDwj3Ne4KyvdRt2qOmP6tSNys3H2lYCoZo7InVtos454bi7QQrfv
        jnN20N2K2Z7+1DnnVu2XsJI=
X-Google-Smtp-Source: ACHHUZ4oXZcb8Nk19kBuR0qLl7TVQDc3WCmmlEl4KaAJtE3CwtrguhJyvOlLyNRYjFiJyVh45TW/Bg==
X-Received: by 2002:a17:90a:19d6:b0:262:cef9:84f6 with SMTP id 22-20020a17090a19d600b00262cef984f6mr7992734pjj.22.1687864605991;
        Tue, 27 Jun 2023 04:16:45 -0700 (PDT)
Received: from localhost.localdomain ([58.240.82.166])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a004800b00262d6ac0140sm5438658pjb.9.2023.06.27.04.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 04:16:45 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, guoren@kernel.org, suagrfillet@gmail.com,
        bjorn@rivosinc.com, jszhang@kernel.org, conor.dooley@microchip.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, songshuaishuai@tinylab.org
Subject: [PATCH V11 5/5] samples: ftrace: Make the riscv samples support RV32I
Date:   Tue, 27 Jun 2023 19:16:12 +0800
Message-Id: <20230627111612.761164-6-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230627111612.761164-1-suagrfillet@gmail.com>
References: <20230627111612.761164-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit f32b4b467ebd ("RISC-V: enable dynamic ftrace for
RV32I") enables dynamic ftrace for RV32I, make these riscv samples
also support RV32I.

Link: https://lore.kernel.org/all/mhng-29a592bf-1b25-4c6c-8f37-0d05d39bc093@palmer-ri-x1c9a/
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 samples/ftrace/ftrace-direct-modify.c       | 27 +++++++++--------
 samples/ftrace/ftrace-direct-multi-modify.c | 33 +++++++++++----------
 samples/ftrace/ftrace-direct-multi.c        | 17 ++++++-----
 samples/ftrace/ftrace-direct-too.c          | 25 ++++++++--------
 samples/ftrace/ftrace-direct.c              | 17 ++++++-----
 5 files changed, 62 insertions(+), 57 deletions(-)

diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index e90ca7b68314..071cf4093a24 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -23,32 +23,33 @@ extern void my_tramp2(void *);
 static unsigned long my_ip = (unsigned long)schedule;
 
 #ifdef CONFIG_RISCV
+#include <asm/asm.h>
 
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp1, @function\n"
 "	.globl		my_tramp1\n"
 "   my_tramp1:\n"
-"	addi	sp,sp,-16\n"
-"	sd	t0,0(sp)\n"
-"	sd	ra,8(sp)\n"
+"	addi	sp,sp,-2*"SZREG"\n"
+"	"REG_S"	t0,0*"SZREG"(sp)\n"
+"	"REG_S"	ra,1*"SZREG"(sp)\n"
 "	call	my_direct_func1\n"
-"	ld	t0,0(sp)\n"
-"	ld	ra,8(sp)\n"
-"	addi	sp,sp,16\n"
+"	"REG_L"	t0,0*"SZREG"(sp)\n"
+"	"REG_L"	ra,1*"SZREG"(sp)\n"
+"	addi	sp,sp,2*"SZREG"\n"
 "	jr	t0\n"
 "	.size		my_tramp1, .-my_tramp1\n"
-
 "	.type		my_tramp2, @function\n"
 "	.globl		my_tramp2\n"
+
 "   my_tramp2:\n"
-"	addi	sp,sp,-16\n"
-"	sd	t0,0(sp)\n"
-"	sd	ra,8(sp)\n"
+"	addi	sp,sp,-2*"SZREG"\n"
+"	"REG_S"	t0,0*"SZREG"(sp)\n"
+"	"REG_S"	ra,1*"SZREG"(sp)\n"
 "	call	my_direct_func2\n"
-"	ld	t0,0(sp)\n"
-"	ld	ra,8(sp)\n"
-"	addi	sp,sp,16\n"
+"	"REG_L"	t0,0*"SZREG"(sp)\n"
+"	"REG_L"	ra,1*"SZREG"(sp)\n"
+"	addi	sp,sp,2*"SZREG"\n"
 "	jr	t0\n"
 "	.size		my_tramp2, .-my_tramp2\n"
 "	.popsection\n"
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index 5a81af7b3af3..b754803d0a50 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -21,38 +21,39 @@ extern void my_tramp1(void *);
 extern void my_tramp2(void *);
 
 #ifdef CONFIG_RISCV
+#include <asm/asm.h>
 
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp1, @function\n"
 "	.globl		my_tramp1\n"
 "   my_tramp1:\n"
-"       addi	sp,sp,-24\n"
-"       sd	a0,0(sp)\n"
-"       sd	t0,8(sp)\n"
-"       sd	ra,16(sp)\n"
+"       addi	sp,sp,-3*"SZREG"\n"
+"       "REG_S"	a0,0*"SZREG"(sp)\n"
+"       "REG_S"	t0,1*"SZREG"(sp)\n"
+"       "REG_S"	ra,2*"SZREG"(sp)\n"
 "       mv	a0,t0\n"
 "       call	my_direct_func1\n"
-"       ld	a0,0(sp)\n"
-"       ld	t0,8(sp)\n"
-"       ld	ra,16(sp)\n"
-"       addi	sp,sp,24\n"
+"       "REG_L"	a0,0*"SZREG"(sp)\n"
+"       "REG_L"	t0,1*"SZREG"(sp)\n"
+"       "REG_L"	ra,2*"SZREG"(sp)\n"
+"       addi	sp,sp,3*"SZREG"\n"
 "	jr	t0\n"
 "	.size		my_tramp1, .-my_tramp1\n"
 
 "	.type		my_tramp2, @function\n"
 "	.globl		my_tramp2\n"
 "   my_tramp2:\n"
-"       addi	sp,sp,-24\n"
-"       sd	a0,0(sp)\n"
-"       sd	t0,8(sp)\n"
-"       sd	ra,16(sp)\n"
+"       addi	sp,sp,-3*"SZREG"\n"
+"       "REG_S"	a0,0*"SZREG"(sp)\n"
+"       "REG_S"	t0,1*"SZREG"(sp)\n"
+"       "REG_S"	ra,2*"SZREG"(sp)\n"
 "       mv	a0,t0\n"
 "       call	my_direct_func2\n"
-"       ld	a0,0(sp)\n"
-"       ld	t0,8(sp)\n"
-"       ld	ra,16(sp)\n"
-"       addi	sp,sp,24\n"
+"       "REG_L"	a0,0*"SZREG"(sp)\n"
+"       "REG_L"	t0,1*"SZREG"(sp)\n"
+"       "REG_L"	ra,2*"SZREG"(sp)\n"
+"       addi	sp,sp,3*"SZREG"\n"
 "	jr	t0\n"
 "	.size		my_tramp2, .-my_tramp2\n"
 "	.popsection\n"
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index 0e9bb94edade..a31f43ace85c 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -16,22 +16,23 @@ void my_direct_func(unsigned long ip)
 extern void my_tramp(void *);
 
 #ifdef CONFIG_RISCV
+#include <asm/asm.h>
 
 asm (
 "       .pushsection    .text, \"ax\", @progbits\n"
 "       .type           my_tramp, @function\n"
 "       .globl          my_tramp\n"
 "   my_tramp:\n"
-"       addi	sp,sp,-24\n"
-"       sd	a0,0(sp)\n"
-"       sd	t0,8(sp)\n"
-"       sd	ra,16(sp)\n"
+"       addi	sp,sp,-3*"SZREG"\n"
+"       "REG_S"	a0,0*"SZREG"(sp)\n"
+"       "REG_S"	t0,1*"SZREG"(sp)\n"
+"       "REG_S"	ra,2*"SZREG"(sp)\n"
 "       mv	a0,t0\n"
 "       call	my_direct_func\n"
-"       ld	a0,0(sp)\n"
-"       ld	t0,8(sp)\n"
-"       ld	ra,16(sp)\n"
-"       addi	sp,sp,24\n"
+"       "REG_L"	a0,0*"SZREG"(sp)\n"
+"       "REG_L"	t0,1*"SZREG"(sp)\n"
+"       "REG_L"	ra,2*"SZREG"(sp)\n"
+"       addi	sp,sp,3*"SZREG"\n"
 "       jr	t0\n"
 "       .size           my_tramp, .-my_tramp\n"
 "       .popsection\n"
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index 5c319db48af2..a1f86dd48847 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -18,25 +18,26 @@ void my_direct_func(struct vm_area_struct *vma,
 extern void my_tramp(void *);
 
 #ifdef CONFIG_RISCV
+#include <asm/asm.h>
 
 asm (
 "       .pushsection    .text, \"ax\", @progbits\n"
 "       .type           my_tramp, @function\n"
 "       .globl          my_tramp\n"
 "   my_tramp:\n"
-"       addi	sp,sp,-40\n"
-"       sd	a0,0(sp)\n"
-"       sd	a1,8(sp)\n"
-"       sd	a2,16(sp)\n"
-"       sd	t0,24(sp)\n"
-"       sd	ra,32(sp)\n"
+"       addi	sp,sp,-5*"SZREG"\n"
+"       "REG_S"	a0,0*"SZREG"(sp)\n"
+"       "REG_S"	a1,1*"SZREG"(sp)\n"
+"       "REG_S"	a2,2*"SZREG"(sp)\n"
+"       "REG_S"	t0,3*"SZREG"(sp)\n"
+"       "REG_S"	ra,4*"SZREG"(sp)\n"
 "       call	my_direct_func\n"
-"       ld	a0,0(sp)\n"
-"       ld	a1,8(sp)\n"
-"       ld	a2,16(sp)\n"
-"       ld	t0,24(sp)\n"
-"       ld	ra,32(sp)\n"
-"       addi	sp,sp,40\n"
+"       "REG_L"	a0,0*"SZREG"(sp)\n"
+"       "REG_L"	a1,1*"SZREG"(sp)\n"
+"       "REG_L"	a2,2*"SZREG"(sp)\n"
+"       "REG_L"	t0,3*"SZREG"(sp)\n"
+"       "REG_L"	ra,4*"SZREG"(sp)\n"
+"       addi	sp,sp,5*"SZREG"\n"
 "       jr	t0\n"
 "       .size           my_tramp, .-my_tramp\n"
 "       .popsection\n"
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index ca95506b0350..fe6b7ef0a2d5 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -15,21 +15,22 @@ void my_direct_func(struct task_struct *p)
 extern void my_tramp(void *);
 
 #ifdef CONFIG_RISCV
+#include <asm/asm.h>
 
 asm (
 "       .pushsection    .text, \"ax\", @progbits\n"
 "       .type           my_tramp, @function\n"
 "       .globl          my_tramp\n"
 "   my_tramp:\n"
-"       addi	sp,sp,-24\n"
-"       sd	a0,0(sp)\n"
-"       sd	t0,8(sp)\n"
-"       sd	ra,16(sp)\n"
+"       addi	sp,sp,-3*"SZREG"\n"
+"       "REG_S"	a0,0*"SZREG"(sp)\n"
+"       "REG_S"	t0,1*"SZREG"(sp)\n"
+"       "REG_S"	ra,2*"SZREG"(sp)\n"
 "       call	my_direct_func\n"
-"       ld	a0,0(sp)\n"
-"       ld	t0,8(sp)\n"
-"       ld	ra,16(sp)\n"
-"       addi	sp,sp,24\n"
+"       "REG_L"	a0,0*"SZREG"(sp)\n"
+"       "REG_L"	t0,1*"SZREG"(sp)\n"
+"       "REG_L"	ra,2*"SZREG"(sp)\n"
+"       addi	sp,sp,3*"SZREG"\n"
 "       jr	t0\n"
 "       .size           my_tramp, .-my_tramp\n"
 "       .popsection\n"
-- 
2.20.1

