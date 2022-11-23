Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF673636187
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbiKWOVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237621AbiKWOUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:20:51 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300BA65863
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:20:39 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id z26so17462991pff.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxhkKuZvqbaLoVEzfi+iXfk1DD9YbSKqrCN+Rkf9lGA=;
        b=mBP5+fAXxuAxdCSP7zz4tcSWzEJr0hKfXx05l9u3poc8f2lajrRDJ4om5XYRcd98cX
         NLSa3uq9HOym2r1qyYi9iYHEmbhSlyJKl/FNE5lZxwm0dzVo81wicYiH1ou3HUtugTqI
         rP4v9oD7NDJQfw2siOAoyIh7gfzl0Dgj2wrGWTbppytIC4j0Fn4EiXlXR82cRpZWKLHQ
         kujHqPeRV95YUrZxHUOXGG0YPe58U6En1STNS1KBld/YP6FHULqFQuAqRyTc8gkPuM+Q
         IlUhPgEsBIvmc5Uvd+rlFDrV3xE4ZTN2k34MiRwlB+AP0XFGtCEjv5+QbMRAUb4GpeyD
         gjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxhkKuZvqbaLoVEzfi+iXfk1DD9YbSKqrCN+Rkf9lGA=;
        b=lx7C8w6tw/tZ332wVv1JpRXHXx18d2rQ5L87t5iOR+G9z0DxDMj/Hvi2O8obutjtJD
         n8i82QmJv9ndj+R2QgwoQWlkcwJel5NUndJHgadU9uwFjiL0O912r07IA1y9laXNknpp
         /8NkPOnVDqSZYYog29uHUoL9ookxJlmCX/NkSKF8o2qcMKwrNAbIqQSxBRQa52tiVtgg
         SuDYD6K4gNeBVU4E17Gmt8+jnho99mraP7KdX4R5VcoiOctcUYuMGUs0eQglNFsT1tUS
         ha6fz8FbFO6hQe/Gsaqm/Jzi+KT0htMQRzfdJl9HoNKr5xRg+d5JhOYapjgXvBhS0YQf
         YlPQ==
X-Gm-Message-State: ANoB5pkLX9ob4dyRn4UIabV7Adii6jAj6N9Lc/fwnHEtoAVOR8wSCA0y
        GlQ0rEPTl+qaCdEjUXoVpR+CBj69wn0=
X-Google-Smtp-Source: AA0mqf7RhWSNHw9CyAtO67HOD5j0yS9Nu9HyQl1/3A0ZHyi4rX2EzsGLfDFDlpbeW9YxJh5zKL+jtw==
X-Received: by 2002:a63:4909:0:b0:462:8605:7fe7 with SMTP id w9-20020a634909000000b0046286057fe7mr8277358pga.445.1669213238663;
        Wed, 23 Nov 2022 06:20:38 -0800 (PST)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903120c00b0016c5306917fsm14516732plh.53.2022.11.23.06.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:20:38 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
To:     guoren@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, peterz@infradead.org, jolsa@redhat.com,
        bp@suse.de, jpoimboe@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH 1/2] riscv/ftrace: add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
Date:   Wed, 23 Nov 2022 22:20:24 +0800
Message-Id: <20221123142025.1504030-2-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221123142025.1504030-1-suagrfillet@gmail.com>
References: <20221123142025.1504030-1-suagrfillet@gmail.com>
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

This patch adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RISC-V.

select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide the
register_ftrace_direct[_multi] interfaces allowing users to register
the customed trampoline (direct_caller) as the mcount for one or
more target functions. And modify_ftrace_direct[_multi] are also
provided for modifying direct_caller.

To make the direct_caller and the other ftrace hooks (eg. function/fgraph
tracer, k[ret]probes) co-exist, a temporary register is nominated to
store the address of direct_caller in ftrace_regs_caller. After the
setting of the address direct_caller by direct_ops->func and the
RESTORE_REGS in ftrace_regs_caller, direct_caller will be jumped to
by the `jr` inst.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 arch/riscv/Kconfig              | 1 +
 arch/riscv/include/asm/ftrace.h | 6 ++++++
 arch/riscv/kernel/mcount-dyn.S  | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 39ec8d628cf6..d083ec08d0b6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -278,6 +278,7 @@ config ARCH_RV64I
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-fpatchable-function-entry=8)
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 01bebb28eabe..be4d57566139 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -114,6 +114,12 @@ struct ftrace_regs;
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs);
 #define ftrace_graph_func ftrace_graph_func
+
+static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
+{
+		regs->t1 = addr;
+}
+
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index 466c6ef217b1..b89c85a58569 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -233,6 +233,7 @@ ENDPROC(ftrace_caller)
 #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 ENTRY(ftrace_regs_caller)
 	SAVE_ABI_REGS 1
+	REG_S	x0, PT_T1(sp)
 	PREPARE_ARGS
 
 ftrace_regs_call:
@@ -241,7 +242,10 @@ ftrace_regs_call:
 
 
 	RESTORE_ABI_REGS 1
+	bnez	t1,.Ldirect
 	jr t0
+.Ldirect:
+	jr t1
 ENDPROC(ftrace_regs_caller)
 
 ENTRY(ftrace_caller)
-- 
2.20.1

