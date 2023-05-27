Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19497132A7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 07:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjE0Frd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 01:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjE0Frb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 01:47:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCAC12A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 22:47:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A991660EF4
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 05:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031ECC433D2;
        Sat, 27 May 2023 05:47:26 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 1/2] genirq/msi, platform-msi: Adjust return value of msi_domain_prepare_irqs()
Date:   Sat, 27 May 2023 13:46:32 +0800
Message-Id: <20230527054633.704916-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230527054633.704916-1-chenhuacai@loongson.cn>
References: <20230527054633.704916-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust the return value semanteme of msi_domain_prepare_irqs(), which
allows us to modify the input nvec by overriding the msi_domain_ops::
msi_prepare(). This is necessary for the later patch.

Before:
0 on success, others on error.

After:
= 0: Success;
> 0: The modified nvec;
< 0: Error code.

Callers are also updated.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/base/platform-msi.c |  2 +-
 kernel/irq/msi.c            | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index f37ad34c80ec..e4a517c144e7 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -298,7 +298,7 @@ __platform_msi_create_device_domain(struct device *dev,
 
 	platform_msi_set_proxy_dev(&data->arg);
 	err = msi_domain_prepare_irqs(domain->parent, dev, nvec, &data->arg);
-	if (err)
+	if (err < 0)
 		goto free_domain;
 
 	return domain;
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 7a97bcb086bf..d151936aec05 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1058,6 +1058,12 @@ bool msi_match_device_irq_domain(struct device *dev, unsigned int domid,
 	return ret;
 }
 
+/*
+ * Return Val:
+ * = 0: Success;
+ * > 0: The modified nvec;
+ * < 0: Error code.
+ */
 int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
 			    int nvec, msi_alloc_info_t *arg)
 {
@@ -1260,8 +1266,10 @@ static int __msi_domain_alloc_irqs(struct device *dev, struct irq_domain *domain
 	int i, ret, virq;
 
 	ret = msi_domain_prepare_irqs(domain, dev, ctrl->nirqs, &arg);
-	if (ret)
+	if (ret < 0)
 		return ret;
+	if (ret > 0)
+		ctrl->nirqs = ret;
 
 	/*
 	 * This flag is set by the PCI layer as we need to activate
-- 
2.39.1

