Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96129661DB4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 05:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbjAIELW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 23:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbjAIEJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 23:09:20 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34E41275B
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 20:05:34 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j16-20020a05600c1c1000b003d9ef8c274bso1298569wms.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 20:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfV0+BbqBCHc7EQiUZ+3x3ezowa350wrKopm7UjQ5hk=;
        b=H8MrO667zzrqCt24dyR/DZlosHSRmVCw2V8Ehjr6mDnaDebp3Q1q6+HIoVmluedeal
         sPu/Dhy4Crz74rm5PNUaWXe5BzXwIj0Z6PuSYjMXhDfHm72NBi9Anma+aoJ8xrXZfVa6
         80DfU3dOVdFOnYIwgScrSsraA3d/J85lBQbOE3LetifbZuonaTmYiwx9KLlf0wVEfp8w
         RvIwnSLDZYHl/SLes0MprVS1qto9I4Gaa/PzycDNmwTg2kWVE4i2AfmmkA4BISFgGopc
         EkCNpjFvyKgb78nQw2XPTBdOZ5i2Lt4PmYtOKIctRBeQMNWM17FwkHE0sAO2JrITI4HB
         fhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfV0+BbqBCHc7EQiUZ+3x3ezowa350wrKopm7UjQ5hk=;
        b=Rtjs5u72kt4uMlknwYl9LoCp57dRJIuRr3tvdyaHkfdX1o8t1vvIt1cw0JANYAshJO
         rsmageHKzoZf2CQqM+g/wg3yYKqPEExAAxUuxvq7dxoUBBbINiNzxdQFfvXeEPuGmr02
         3SID/qCgP9I2qT1JkMLloHhUsnmjA0GI0FPjRrBd8XdJ2cj+YyfjXkvDKAIWFEElYuKJ
         gqIvyFBFkTar5ztSRgWB8Sr7cjDv5hGK8nYz5xGkef7IKHPXOtRhPgDYVyTURwyToAhc
         G/KDSvrF7HKfHvJhrSKuxng7z+lwoQhLPNeqlyyxXVTXNCUDeIx6ATzj5QQvNIxainvx
         jqEQ==
X-Gm-Message-State: AFqh2kpT4OEAwBDp2qD2YCQDniLoA3rPBcrPhu1K8FEcGXv4ncc4hLxW
        4FdjaCjWd6rWZBViowBkveaACLJ9ya++aUFN
X-Google-Smtp-Source: AMrXdXvSLpCQZzAIozzIJ2RKeGs4DdGJyGPixYudN2yV5cvwGMDkzaEEqjNzsdAJTbsRH/CRHXThMA==
X-Received: by 2002:a05:600c:1e10:b0:3d3:404a:8a1b with SMTP id ay16-20020a05600c1e1000b003d3404a8a1bmr44407005wmb.8.1673237133095;
        Sun, 08 Jan 2023 20:05:33 -0800 (PST)
Received: from solpc.. (67.pool90-171-92.dynamic.orange.es. [90.171.92.67])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b003d1f3e9df3csm15416054wmo.7.2023.01.08.20.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 20:05:32 -0800 (PST)
From:   Joan Bruguera <joanbrugueram@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Wake-up from suspend to RAM broken under `retbleed=stuff`
Date:   Mon,  9 Jan 2023 04:05:31 +0000
Message-Id: <20230109040531.7888-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230108030748.158120-1-joanbrugueram@gmail.com>
References: <20230108030748.158120-1-joanbrugueram@gmail.com>
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

This fixes wakeup for me on both QEMU and real HW
(just a proof of concept, don't merge)

diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index ffea98f9064b..8704bcc0ce32 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -7,6 +7,7 @@
 #include <linux/memory.h>
 #include <linux/moduleloader.h>
 #include <linux/static_call.h>
+#include <linux/suspend.h>
 
 #include <asm/alternative.h>
 #include <asm/asm-offsets.h>
@@ -150,6 +151,10 @@ static bool skip_addr(void *dest)
 	if (dest >= (void *)hypercall_page &&
 	    dest < (void*)hypercall_page + PAGE_SIZE)
 		return true;
+#endif
+#ifdef CONFIG_PM_SLEEP
+	if (dest == restore_processor_state)
+		return true;
 #endif
 	return false;
 }
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 236447ee9beb..e667894936f7 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -281,6 +281,9 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 /* Needed by apm.c */
 void notrace restore_processor_state(void)
 {
+	/* Restore GS before calling anything to avoid crash on call depth accounting */
+	native_wrmsrl(MSR_GS_BASE, saved_context.kernelmode_gs_base);
+
 	__restore_processor_state(&saved_context);
 }
 #ifdef CONFIG_X86_32
