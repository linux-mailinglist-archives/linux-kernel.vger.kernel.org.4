Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75F963D11D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbiK3IwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbiK3Iv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:51:58 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E022C2C12B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:51:57 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NMXy34ZBbz8RV7J;
        Wed, 30 Nov 2022 16:51:55 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AU8piTn089749;
        Wed, 30 Nov 2022 16:51:44 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 30 Nov 2022 16:51:46 +0800 (CST)
Date:   Wed, 30 Nov 2022 16:51:46 +0800 (CST)
X-Zmail-TransId: 2af9638719a2ffffffffbbbdd223
X-Mailer: Zmail v1.0
Message-ID: <202211301651462590168@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <akpm@linux-foundation.org>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBtbS9odWdlX21lbW9yeTogYWRkIFRSQU5TUEFSRU5UX0hVR0VQQUdFX05FVkVSIGZvciBUSFA=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AU8piTn089749
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 638719AB.001 by FangMail milter!
X-FangMail-Envelope: 1669798315/4NMXy34ZBbz8RV7J/638719AB.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638719AB.001/4NMXy34ZBbz8RV7J
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Sometimes we may need the /sys/kernel/mm/transparent_hugepage/enabled to
default as [never] at the first time.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 mm/Kconfig       | 5 +++++
 mm/huge_memory.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index ff7b209dec05..ded8c1da6267 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -797,6 +797,11 @@ choice
 	  madvise(MADV_HUGEPAGE) but it won't risk to increase the
 	  memory footprint of applications without a guaranteed
 	  benefit.
+
+	config TRANSPARENT_HUGEPAGE_NEVER
+		bool "never"
+	help
+	  Disabling Transparent Hugepage.
 endchoice

 config THP_SWAP
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c0c57828110d..3571417aa70a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -60,6 +60,8 @@ unsigned long transparent_hugepage_flags __read_mostly =
 #endif
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE_MADVISE
 	(1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)|
+#endif
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE_NEVER
 #endif
 	(1<<TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG)|
 	(1<<TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG)|
-- 
2.25.1
