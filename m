Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF172707EEB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjERLJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjERLJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:09:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601D32683;
        Thu, 18 May 2023 04:08:37 -0700 (PDT)
Date:   Thu, 18 May 2023 11:08:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684408084;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DDrie1cOrSTy8hqwWcIdLpLvCM2cPcYwzeoDx6sC2kg=;
        b=El1p1inTGcqDn7LQQLop654NpQp8sIv4EyD0MgnMLD2KfsTVq9Ys3n/8TVhMs7q58PLzD7
        fN/luGBHV2j6jW/se2dXHAbWTisVl+NgQped5FGrsbObBfRf1Nkx6Cf+jwQokIid6U4YC9
        dIS06ngrVKmioHnwBU8s8yONaVSjVE5TxcvpJFvI7ot5WHaCASWMdlJYWdVY2S6DXCIiHB
        LjsxOsFF7kgRQ5om1F3cRnY/QDkxOsSj0HZ2JWKdGg3MQ5kTyD8mzJTmYTvojDFxznitlb
        cbH1QMEKai1bYlZvwhsYg7q5nWKK3kTDVcn9tWNRq9d4HUxB4LN6P5sWMz+iRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684408084;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DDrie1cOrSTy8hqwWcIdLpLvCM2cPcYwzeoDx6sC2kg=;
        b=SULRuuQB232AlMs0oNflsT5tfyr2/NpfuPDHIeb2uVNnU2/hdqWw08NrhyMUOLQBw4zHM7
        MHZbwX3a21crwFCw==
From:   "tip-bot2 for Jiapeng Chong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/unwind/orc: Use swap() instead of open coding it
Cc:     Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230330020014.40489-1-jiapeng.chong@linux.alibaba.com>
References: <20230330020014.40489-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <168440808427.404.1399705978286968537.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     95f0e3a209b0045a56a06987d85981280f523270
Gitweb:        https://git.kernel.org/tip/95f0e3a209b0045a56a06987d85981280f523270
Author:        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
AuthorDate:    Thu, 30 Mar 2023 10:00:14 +08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 16 May 2023 06:06:56 -07:00

x86/unwind/orc: Use swap() instead of open coding it

Swap is a function interface that provides exchange function. To avoid
code duplication, we can use swap function.

./arch/x86/kernel/unwind_orc.c:235:16-17: WARNING opportunity for swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4641
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Link: https://lore.kernel.org/r/20230330020014.40489-1-jiapeng.chong@linux.alibaba.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/unwind_orc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 3ac50b7..5fbcb22 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -219,7 +219,6 @@ static struct orc_entry *cur_orc_table = __start_orc_unwind;
 static void orc_sort_swap(void *_a, void *_b, int size)
 {
 	struct orc_entry *orc_a, *orc_b;
-	struct orc_entry orc_tmp;
 	int *a = _a, *b = _b, tmp;
 	int delta = _b - _a;
 
@@ -231,9 +230,7 @@ static void orc_sort_swap(void *_a, void *_b, int size)
 	/* Swap the corresponding .orc_unwind entries: */
 	orc_a = cur_orc_table + (a - cur_orc_ip_table);
 	orc_b = cur_orc_table + (b - cur_orc_ip_table);
-	orc_tmp = *orc_a;
-	*orc_a = *orc_b;
-	*orc_b = orc_tmp;
+	swap(*orc_a, *orc_b);
 }
 
 static int orc_sort_cmp(const void *_a, const void *_b)
