Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A501E5F5146
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 11:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJEJDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 05:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiJEJD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 05:03:27 -0400
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65715D132
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 02:03:25 -0700 (PDT)
Received: from dev011.ch-qa.sw.ru ([172.29.1.16])
        by relay.virtuozzo.com with esmtp (Exim 4.95)
        (envelope-from <alexander.atanasov@virtuozzo.com>)
        id 1og0GP-007ckN-Nc;
        Wed, 05 Oct 2022 11:02:50 +0200
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc:     kernel@openvz.org,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/7] Display inflated memory in logs
Date:   Wed,  5 Oct 2022 12:01:55 +0300
Message-Id: <20221005090158.2801592-6-alexander.atanasov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221005090158.2801592-1-alexander.atanasov@virtuozzo.com>
References: <20221005090158.2801592-1-alexander.atanasov@virtuozzo.com>
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
it is seen in the logs.

Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
---
 lib/show_mem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/show_mem.c b/lib/show_mem.c
index 1c26c14ffbb9..1c022b9d7ac5 100644
--- a/lib/show_mem.c
+++ b/lib/show_mem.c
@@ -7,6 +7,9 @@
 
 #include <linux/mm.h>
 #include <linux/cma.h>
+#ifdef CONFIG_MEMORY_BALLOON
+#include <linux/balloon.h>
+#endif
 
 void show_mem(unsigned int filter, nodemask_t *nodemask)
 {
@@ -41,4 +44,9 @@ void show_mem(unsigned int filter, nodemask_t *nodemask)
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

