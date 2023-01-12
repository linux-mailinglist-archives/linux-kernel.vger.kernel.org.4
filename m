Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9289A66792A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbjALP0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240342AbjALP0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:26:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FDC3D1CF;
        Thu, 12 Jan 2023 07:18:41 -0800 (PST)
Date:   Thu, 12 Jan 2023 15:18:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673536719;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6rolIEIiO2ig4S+v+S9Rws09BZuTxVnYBcgHmCQBLzI=;
        b=20wsGnWpG3xJDrp5YPfg4/0hYoub/Ijg4ZbCMqwtlvoTwqWdK5vtftOJMjf+fA2ZEkuDIe
        T18SduXhF67rW1zojbeTuFuzQ4PVc9r7DNHtfCGqu8v2JXBXs0SB9KTtHRPJIQI+jClfhb
        wupz/uy7X2qLMOqUDUW7OoP0380IMjtCjWRFJCQRktMG6liWP2jG65CMFUXP0W5F7p7NBt
        hnMx9OP/Y6XSZV4FThki7WaABOY5+/N1J71XpUd30y+XBdtGyL4FfQvN0QECHEHM6Eu3YD
        Dm2HmQKXjUkKaE589F4OJubTXKyYS2Nq53z+qwAtU0RwxBOB9awlpuTqbb5Rpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673536719;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6rolIEIiO2ig4S+v+S9Rws09BZuTxVnYBcgHmCQBLzI=;
        b=njY+LU9qPrhfNmuBLswoWytKDQP5CKUBWj21Qqnt9WIBnkoVdOm8O53E9dUwjmRVknSRsH
        pGBu7Pn3bD8YHcDQ==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq: Increase AT_VECTOR_SIZE_BASE to match rseq
 auxvec entries
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230104192054.34046-1-mathieu.desnoyers@efficios.com>
References: <20230104192054.34046-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <167353671841.4906.17789590364136749401.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     28c8e088427ad30b4260953f3b6f908972b77c2d
Gitweb:        https://git.kernel.org/tip/28c8e088427ad30b4260953f3b6f908972b77c2d
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Wed, 04 Jan 2023 14:20:54 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 12 Jan 2023 11:22:22 +01:00

rseq: Increase AT_VECTOR_SIZE_BASE to match rseq auxvec entries

Two new auxiliary vector entries are introduced for rseq without
matching increment of the AT_VECTOR_SIZE_BASE, which causes failures
with CONFIG_HARDENED_USERCOPY=y.

Fixes: 317c8194e6ae ("rseq: Introduce feature size and alignment ELF auxiliary vector entries")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20230104192054.34046-1-mathieu.desnoyers@efficios.com
---
 include/linux/auxvec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/auxvec.h b/include/linux/auxvec.h
index f68d0ec..407f700 100644
--- a/include/linux/auxvec.h
+++ b/include/linux/auxvec.h
@@ -4,6 +4,6 @@
 
 #include <uapi/linux/auxvec.h>
 
-#define AT_VECTOR_SIZE_BASE 20 /* NEW_AUX_ENT entries in auxiliary table */
+#define AT_VECTOR_SIZE_BASE 22 /* NEW_AUX_ENT entries in auxiliary table */
   /* number of "#define AT_.*" above, minus {AT_NULL, AT_IGNORE, AT_NOTELF} */
 #endif /* _LINUX_AUXVEC_H */
