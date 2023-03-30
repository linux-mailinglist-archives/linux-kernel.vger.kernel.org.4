Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B896CF8FA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 04:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjC3CA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 22:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjC3CAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 22:00:24 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620F710D7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 19:00:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Veyf.ZL_1680141614;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Veyf.ZL_1680141614)
          by smtp.aliyun-inc.com;
          Thu, 30 Mar 2023 10:00:20 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jpoimboe@kernel.org
Cc:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] x86/unwind/orc: Use swap() instead of open coding it
Date:   Thu, 30 Mar 2023 10:00:14 +0800
Message-Id: <20230330020014.40489-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Swap is a function interface that provides exchange function. To avoid
code duplication, we can use swap function.

./arch/x86/kernel/unwind_orc.c:235:16-17: WARNING opportunity for swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4641
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/x86/kernel/unwind_orc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 3ac50b7298d1..5fbcb229f707 100644
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
-- 
2.20.1.7.g153144c

