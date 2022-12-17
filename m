Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFE064FBEB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 19:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiLQS5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 13:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiLQSzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:55:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168BD183;
        Sat, 17 Dec 2022 10:55:38 -0800 (PST)
Date:   Sat, 17 Dec 2022 18:55:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671303334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3MasCZ2uf5KqBvBdLCXR1OewEYcomc6VBLd/xJm78ik=;
        b=wzyZdSiADceCew/ze/zkV57XRl1I5KgeZ4Q39Mw3QUbMYlEIkYyOC+EHlJWjm9J+mUCEew
        /6gsjm65wOiIBpvDFk4d68SixbrKBaGIaXAltfOo/bwDvyx9vUYn9vF1VGor9pSgzasxPp
        y21uGZWpNseujj0HsvY8/QKuVfCkJZ6rfohMXM7f5IQRkd2AKSHMY6F3gz+GWq3Q5cjzbb
        xTCP5so7Cz69LNPSVKlNPUer+SlqjmkbRVaaQLdkJSJhrXcF12nyZ/hCBc6Pum+4IJWrL6
        FXdb/SCK4Vx6ZFA/1iZDpVq/VGVgG2V6HdIIF5ZE3hyPl3kAPT/jewPkyXyRPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671303334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3MasCZ2uf5KqBvBdLCXR1OewEYcomc6VBLd/xJm78ik=;
        b=Swo9M+H17r7PDMw6LNlDYe9txocWYYUcQcNridY6JI7MKWGyMnFsh7sI/dhNYqXPh+AxWF
        0SyQAvpjt1EV9CAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] sh/mm: Make pmd_t similar to pte_t
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167130333386.4906.10282697984630646518.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     0862ff059c9e29f023e617b134f9ea332cae50b8
Gitweb:        https://git.kernel.org/tip/0862ff059c9e29f023e617b134f9ea332cae50b8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 26 Nov 2020 17:05:55 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Dec 2022 10:37:27 -08:00

sh/mm: Make pmd_t similar to pte_t

Just like 64bit pte_t, have a low/high split in pmd_t.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221022114424.645657294%40infradead.org
---
 arch/sh/include/asm/pgtable-3level.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/pgtable-3level.h b/arch/sh/include/asm/pgtable-3level.h
index cdced80..a889a3a 100644
--- a/arch/sh/include/asm/pgtable-3level.h
+++ b/arch/sh/include/asm/pgtable-3level.h
@@ -28,9 +28,15 @@
 #define pmd_ERROR(e) \
 	printk("%s:%d: bad pmd %016llx.\n", __FILE__, __LINE__, pmd_val(e))
 
-typedef struct { unsigned long long pmd; } pmd_t;
+typedef struct {
+	struct {
+		unsigned long pmd_low;
+		unsigned long pmd_high;
+	};
+	unsigned long long pmd;
+} pmd_t;
 #define pmd_val(x)	((x).pmd)
-#define __pmd(x)	((pmd_t) { (x) } )
+#define __pmd(x)	((pmd_t) { .pmd = (x) } )
 
 static inline pmd_t *pud_pgtable(pud_t pud)
 {
