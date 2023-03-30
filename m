Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AF76CFDFA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjC3IRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjC3IQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:16:47 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ED372B1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:16:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o2so17386738plg.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680164182; x=1682756182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOI7aF7UFpggKDWXdppF1ANUfbw7Suxw6cG2yN/yOEM=;
        b=CieFy9DLNJ6vTy/qq9cI1yNZ5APxTLFi+sxUwDVTaTts3ukMIaD1avDKCbi++RVffn
         SuRcDl5yykEfAIRvIWB3QVZdFyEUsKk3/Jk/7v3N0ZJ0v+atSYfhc/Fa3OM/lIJal5ef
         aeOgSbclMbDKzCbGDtj4rpv2j/cjNNgmPgYZra6lgV0jrRxJUBuDCU8iY4VGogaVnOfx
         HGjDLXA0fR8OQ//l79Goq875dfMG/A5UTUwOcoEWRAqbrq4bjoduHwGbN1E0CAqEFO/B
         H3daZ4DAzSciC2z52E/7LHJnXwYzCId6+d7eH1npqd0/6xkTglDnJS5hv3Jl9+KQUXvb
         xbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680164182; x=1682756182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOI7aF7UFpggKDWXdppF1ANUfbw7Suxw6cG2yN/yOEM=;
        b=s6tsMHOdngkqm8403k+Wrfr5RoDALD7nvVtS2g69zI1lUB3wuMXMoHSmpMpCmvB47K
         ScBN7xBPQxKJMlkdSW7RnRT8h644Xj1QLQ5FmrTCVqiMPwIW0pI1gnOE5DLpZZNzvtHe
         lMfbPRV26WkqU2HCQrN+Yt0dd+4X7xReGb3DHh69Bk7rzJw4o8YV4tsS9PcOThjyfn9F
         Bu7U2AVmPorqrnY07O/KOCqKG5FASltEeAaRKhF5oFPCwRoCjQzxA9EcuPWl4L6+3rAL
         LR4fH/w6/4VDRTPRUInlqeY5RB53CxEPpJw6fiwEtU2TSwKa8T6FeejSRGzhDAf6sB55
         mgBg==
X-Gm-Message-State: AAQBX9d72xS8JN4btXYED+tG3fdzvdojTP3DkUT9ekdawR10WIyZx2zP
        yxq7vCAW9kdwWrfihn1V2HfCdw==
X-Google-Smtp-Source: AKy350Yqu7hmaUw8MirSerQ/CNo66w01b1tkcSZghu3wKhX8v/8a5eY9bbStNfEYtL5xXpBsP3ptFw==
X-Received: by 2002:a17:90a:788f:b0:23d:2b53:1ae2 with SMTP id x15-20020a17090a788f00b0023d2b531ae2mr1491639pjk.3.1680164182265;
        Thu, 30 Mar 2023 01:16:22 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id i13-20020a17090a138d00b0023cd53e7706sm2630837pja.47.2023.03.30.01.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 01:16:21 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     peterz@infradead.org, keescook@chromium.org, jpoimboe@kernel.org,
        dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
        tglx@linutronix.de, rostedt@goodmis.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 2/2] x86: make __get_wchan() use arch_stack_walk()
Date:   Thu, 30 Mar 2023 16:15:52 +0800
Message-Id: <20230330081552.54178-3-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230330081552.54178-1-zhengqi.arch@bytedance.com>
References: <20230330081552.54178-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make __get_wchan() use arch_stack_walk() directly to
avoid open-coding of unwind logic.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/x86/kernel/process.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 3ab62ac98c2c..a6ff18fa6d5d 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -1000,6 +1000,17 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
 	return randomize_page(mm->brk, 0x02000000);
 }
 
+static bool get_wchan_cb(void *arg, unsigned long pc)
+{
+	unsigned long *addr = arg;
+
+	if (in_sched_functions(pc))
+		return true;
+
+	*addr = pc;
+	return false;
+}
+
 /*
  * Called from fs/proc with a reference on @p to find the function
  * which called into schedule(). This needs to be done carefully
@@ -1008,21 +1019,12 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
  */
 unsigned long __get_wchan(struct task_struct *p)
 {
-	struct unwind_state state;
 	unsigned long addr = 0;
 
 	if (!try_get_task_stack(p))
 		return 0;
 
-	for (unwind_start(&state, p, NULL, NULL); !unwind_done(&state);
-	     unwind_next_frame(&state)) {
-		addr = unwind_get_return_address(&state);
-		if (!addr)
-			break;
-		if (in_sched_functions(addr))
-			continue;
-		break;
-	}
+	arch_stack_walk(get_wchan_cb, &addr, p, NULL);
 
 	put_task_stack(p);
 
-- 
2.20.1

