Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19CC6F06FB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243734AbjD0OH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243731AbjD0OHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:07:25 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06BC4491
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:07:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f1738d0d4cso56049135e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682604435; x=1685196435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ljaeRoUOTvHIOJot1r8A0oYKDFB5aJ471vIxa1FpUA=;
        b=n2vmdIIcATMu0p/U3Y9qlWt92NaIMfpiymvMTwLsveBJ6eMt1rIB+zLqcdVH3hDZ/M
         xGhPa6SClrcyLbDeaoPAFNn1+84tAUrDY1bYDCCON3INglGx9mdkH2IPSN+k2Dx9h1dG
         xwSyV2P5U9DY3WcxB2z6EnPeAhaWNWHKoQmQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682604435; x=1685196435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ljaeRoUOTvHIOJot1r8A0oYKDFB5aJ471vIxa1FpUA=;
        b=klU1PdkLyQcGlVuXkP6YjR0bDrVaa5y+bKtf2wmO77Vcj304lpp0+byNIUIhCZJJeF
         0S48b67F/NBYKgJrKezn5ag0xIsynZ39WL8HXJlSdVCh5PN6X5n3JZD7Sdys5M4KQ+YW
         BVDGpNN4oYQRWz3YFt26ELdTmNhuE+Wxim9EJURJrSqkzi6FUBUGdLvnK5L4kDef+3YX
         Yot0Fv+oMoCRrjg/5DGt/ntBTTMqSY6BVLFFYfirGacPUzyLnNHe/7D+oKtMoFWIni9Z
         y7NB68BndJB9udTMkSvyDi77NBYTNt0wrJJt02t9AphLgit5u1AuVT85G1ENk3znPah7
         v4Rg==
X-Gm-Message-State: AC+VfDy93Mpp9q2mW0Je36jRQgbe0SJrs75y07jJa1AjUDaFTKRohoQL
        XiMDKZY8iHzniIk3DCwStevZPg==
X-Google-Smtp-Source: ACHHUZ63aLZF9qLE/R+yf6CA+SBXn8FRQZNn/+Wxaq8wFNNi0ft9sxhrCC0qJXmBGxwOotWT7veVqw==
X-Received: by 2002:a05:600c:2046:b0:3f1:9134:f28b with SMTP id p6-20020a05600c204600b003f19134f28bmr1665373wmg.19.1682604435148;
        Thu, 27 Apr 2023 07:07:15 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:a66d:4f2c:7ce5:e8ea])
        by smtp.gmail.com with ESMTPSA id c21-20020a7bc855000000b003f17300c7dcsm21285075wml.48.2023.04.27.07.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 07:07:14 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        kpsingh@kernel.org, xukuohai@huaweicloud.com,
        Florent Revest <revest@chromium.org>, stable@vger.kernel.org
Subject: [PATCH 1/2] samples: ftrace: Save required argument registers in sample trampolines
Date:   Thu, 27 Apr 2023 16:06:59 +0200
Message-ID: <20230427140700.625241-2-revest@chromium.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
In-Reply-To: <20230427140700.625241-1-revest@chromium.org>
References: <20230427140700.625241-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ftrace-direct-too sample traces the handle_mm_fault function whose
signature changed since the introduction of the sample. Since:
commit bce617edecad ("mm: do page fault accounting in handle_mm_fault")
handle_mm_fault now has 4 arguments. Therefore, the sample trampoline
should save 4 argument registers.

s390 saves all argument registers already so it does not need a change
but x86_64 needs an extra push and pop.

This also evolves the signature of the tracing function to make it
mirror the signature of the traced function.

Cc: stable@vger.kernel.org
Fixes: bce617edecad ("mm: do page fault accounting in handle_mm_fault")
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Florent Revest <revest@chromium.org>
---
 samples/ftrace/ftrace-direct-too.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index f28e7b99840f..71ed4ee8cb4a 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -5,14 +5,14 @@
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
 
-extern void my_direct_func(struct vm_area_struct *vma,
-			   unsigned long address, unsigned int flags);
+extern void my_direct_func(struct vm_area_struct *vma, unsigned long address,
+			   unsigned int flags, struct pt_regs *regs);
 
-void my_direct_func(struct vm_area_struct *vma,
-			unsigned long address, unsigned int flags)
+void my_direct_func(struct vm_area_struct *vma, unsigned long address,
+		    unsigned int flags, struct pt_regs *regs)
 {
-	trace_printk("handle mm fault vma=%p address=%lx flags=%x\n",
-		     vma, address, flags);
+	trace_printk("handle mm fault vma=%p address=%lx flags=%x regs=%p\n",
+		     vma, address, flags, regs);
 }
 
 extern void my_tramp(void *);
@@ -34,7 +34,9 @@ asm (
 "	pushq %rdi\n"
 "	pushq %rsi\n"
 "	pushq %rdx\n"
+"	pushq %rcx\n"
 "	call my_direct_func\n"
+"	popq %rcx\n"
 "	popq %rdx\n"
 "	popq %rsi\n"
 "	popq %rdi\n"
-- 
2.40.1.495.gc816e09b53d-goog

