Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB026043B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiJSLq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiJSLq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:46:28 -0400
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78455136401
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:25:47 -0700 (PDT)
Received: from dev011.ch-qa.sw.ru ([172.29.1.16])
        by relay.virtuozzo.com with esmtp (Exim 4.95)
        (envelope-from <alexander.atanasov@virtuozzo.com>)
        id 1ol5lc-00B8K8-Jy;
        Wed, 19 Oct 2022 11:56:31 +0200
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc:     kernel@openvz.org,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 4/8] mm: Display inflated memory in logs
Date:   Wed, 19 Oct 2022 12:56:16 +0300
Message-Id: <20221019095620.124909-5-alexander.atanasov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221019095620.124909-1-alexander.atanasov@virtuozzo.com>
References: <20221019095620.124909-1-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add InflatedTotal and InflatedFree to show_mem(...) so
it is visible in the logs.

Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
---
 lib/show_mem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/show_mem.c b/lib/show_mem.c
index 0d7585cde2a6..20b5964d498e 100644
--- a/lib/show_mem.c
+++ b/lib/show_mem.c
@@ -7,6 +7,9 @@
 
 #include <linux/mm.h>
 #include <linux/cma.h>
+#ifdef CONFIG_MEMORY_BALLOON
+#include <linux/balloon.h>
+#endif
 
 void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 {
@@ -41,4 +44,9 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 #ifdef CONFIG_MEMORY_FAILURE
 	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
 #endif
+#ifdef CONFIG_MEMORY_BALLOON
+	printk("Balloon InflatedTotal:%ldkB InflatedFree:%ldkB\n",
+		atomic_long_read(&mem_balloon_inflated_total_kb),
+		atomic_long_read(&mem_balloon_inflated_free_kb));
+#endif
 }
-- 
2.31.1

