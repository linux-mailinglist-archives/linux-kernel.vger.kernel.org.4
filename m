Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1F961616A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiKBLGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiKBLGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:06:33 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F9029C9A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 04:06:28 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id v18-20020a056402349200b004622e273bbbso11777352edc.14
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 04:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dk/dhHPL0qFVshysQ/N4gnrAp81kLluhRpZpiN1N26A=;
        b=BRXuAvLOHF3g9+gYxk6eLf0iLGvj05paMev0jUBgMnN/5twd8iGLllzv5YJfGiXvxo
         bbpa22yuLIs03sydQwA6d6FHWh1ns4oA9GlUYXwh/RQbSpseclTQoxYM356MlrCxyM/d
         l7xAksNUDe2qS9tRUGAgfy+pCWc4utGI5Aty2dyjLc/3QuuQjIB0MOtKWoWhtakZ6Yli
         rzVdmRwM0RTjlvJ/Zf6eD8WP9SwZrTA2aldlm9B/FxucwGXrXuxw2IjQDm4QRRrggsYe
         oNPE1SV5IP9wsvvEx/aHSu69q3tQhoACudVb+Jy9nLyKvCVO3Fknl0VsdVPh0u+lG1Ta
         aVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dk/dhHPL0qFVshysQ/N4gnrAp81kLluhRpZpiN1N26A=;
        b=TElqPd5Npt1rUPN5Kuxr5T9TD7OkEcegoxFibIKREEkDY2W7Z0t4It0QBf5R1Lh0Z2
         MhQdqeWKgAvu7+xaNvOxgMTWKqGQL1Mw+jwgpTB9I2N9YhLbFKhXaPiGUAWTPI3ZGMyS
         qf2864yDg5RmM3mbdbxNDRRq50PE7MuVv4L1AqMhD4dKta7we73OmOaEGzmpNwguxNJC
         ydKxI7ic5eQrv89bA9b9kOLshPo0bLUqJFAOdjyGykXNQcGU8mxQ+k0K1oAnGzsYemEJ
         pLqitAOZLnUDbkDw3KoquEnZYkhhQE8Cx+GbvwaYZc0LULx4PLqmkBLPYYOtWt99rzwB
         /lwA==
X-Gm-Message-State: ACrzQf1dlAUOmR9kWRWL0ZKHMgy1Pb336soJoPpSWCJiKh2xU3Wn4fjx
        FQfUnrpZs+GNAZrJLQzhoZ/PDUmQAIM=
X-Google-Smtp-Source: AMsMyM4fUfxUdb/RWuOeQOt7gjfxrb6bfUNzqz8xTAK3dw9fr/vhi9KtZr6+Qf+4LF3jQ4Jn/CWpERzPtqA=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:7f41:af20:8:a96d])
 (user=glider job=sendgmr) by 2002:a17:907:a80f:b0:7ae:3f7:b612 with SMTP id
 vo15-20020a170907a80f00b007ae03f7b612mr2514087ejc.421.1667387186488; Wed, 02
 Nov 2022 04:06:26 -0700 (PDT)
Date:   Wed,  2 Nov 2022 12:06:11 +0100
In-Reply-To: <20221102110611.1085175-1-glider@google.com>
Mime-Version: 1.0
References: <20221102110611.1085175-1-glider@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221102110611.1085175-5-glider@google.com>
Subject: [PATCH 5/5] x86/traps: avoid KMSAN bugs originating from handle_bug()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a case in exc_invalid_op handler that is executed outside the
irqentry_enter()/irqentry_exit() region when an UD2 instruction is used
to encode a call to __warn().

In that case the `struct pt_regs` passed to the interrupt handler is
never unpoisoned by KMSAN (this is normally done in irqentry_enter()),
which leads to false positives inside handle_bug().

Use kmsan_unpoison_entry_regs() to explicitly unpoison those registers
before using them.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 arch/x86/kernel/traps.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 178015a820f08..d3fdec706f1d2 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -15,6 +15,7 @@
 #include <linux/context_tracking.h>
 #include <linux/interrupt.h>
 #include <linux/kallsyms.h>
+#include <linux/kmsan.h>
 #include <linux/spinlock.h>
 #include <linux/kprobes.h>
 #include <linux/uaccess.h>
@@ -301,6 +302,12 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 {
 	bool handled = false;
 
+	/*
+	 * Normally @regs are unpoisoned by irqentry_enter(), but handle_bug()
+	 * is a rare case that uses @regs without passing them to
+	 * irqentry_enter().
+	 */
+	kmsan_unpoison_entry_regs(regs);
 	if (!is_valid_bugaddr(regs->ip))
 		return handled;
 
-- 
2.38.1.273.g43a17bfeac-goog

