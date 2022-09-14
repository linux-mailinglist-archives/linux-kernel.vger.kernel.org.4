Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D525B8707
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiINLJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiINLJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:09:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F57248C3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 04:09:48 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MSHZ42r71zlVkh;
        Wed, 14 Sep 2022 19:05:48 +0800 (CST)
Received: from huawei.com (10.67.174.96) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 14 Sep
 2022 19:09:46 +0800
From:   Zhang Jianhua <chris.zjh@huawei.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <samuel@sholland.org>,
        <brgl@bgdev.pl>, <mark.rutland@arm.com>, <lvjianmin@loongson.cn>
CC:     <chris.zjh@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] genirq: Change can_request_irq() return value type to bool
Date:   Wed, 14 Sep 2022 19:06:15 +0800
Message-ID: <20220914110615.3570933-1-chris.zjh@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.96]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function can_request_irq() is used to judge whether the irq can be
allocated, so bool type would be more suitable for it.

Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
---
 include/linux/irq.h | 2 +-
 kernel/irq/manage.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index c3eb89606c2b..3a60c2313fb9 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -707,7 +707,7 @@ extern void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret);
 extern int noirqdebug_setup(char *str);
 
 /* Checks whether the interrupt can be requested by request_irq(): */
-extern int can_request_irq(unsigned int irq, unsigned long irqflags);
+extern bool can_request_irq(unsigned int irq, unsigned long irqflags);
 
 /* Dummy irq-chip implementations: */
 extern struct irq_chip no_irq_chip;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 40fe7806cc8c..d6940d15bf56 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -925,19 +925,19 @@ EXPORT_SYMBOL(irq_set_irq_wake);
  * particular irq has been exclusively allocated or is available
  * for driver use.
  */
-int can_request_irq(unsigned int irq, unsigned long irqflags)
+bool can_request_irq(unsigned int irq, unsigned long irqflags)
 {
 	unsigned long flags;
 	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
-	int canrequest = 0;
+	bool canrequest = false;
 
 	if (!desc)
-		return 0;
+		return false;
 
 	if (irq_settings_can_request(desc)) {
 		if (!desc->action ||
 		    irqflags & desc->action->flags & IRQF_SHARED)
-			canrequest = 1;
+			canrequest = true;
 	}
 	irq_put_desc_unlock(desc, flags);
 	return canrequest;
-- 
2.31.0

