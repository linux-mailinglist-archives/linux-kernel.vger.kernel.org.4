Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D296A1CAC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjBXNG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBXNG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:06:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CB576AB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:06:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EF45618D9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8011AC433EF;
        Fri, 24 Feb 2023 13:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677243984;
        bh=Gd+b31B6Tap7aA3jtuFUlatJg/pv2hwU9Z6ZAY7YshA=;
        h=From:To:Cc:Subject:Date:From;
        b=eudlguZ9ZKNCvlYoITFAFiXnh7t7I81egbws5/uWoZzRcj1gWRV2wWYR2BTshLaR1
         zpZ2DmJFhl3APhXfEKJ1L2QE1UlZ/rrcY8xZ4oCJej6mnKOC/1FMlbjjCo9XGf8l9n
         3kAeKalZIHeMuqpWRm5v2QrIxjkEoGfm47h5J7i+infY8EdiQLuQwUMDlyWAg8os07
         QK3a/w8/8aLBsipani4FPggpGsmmpHaIdobicVUtScyOVUT975J42Bc7CpECeSaUmD
         Gv5GPi4WJIMZL89Y+uIQRbPyyKWl08vMUlecDIfrukXV6IUKoXVCsequuMoQPmZ+rO
         QB14OKnZUqp4w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pVXmW-0007Fb-95; Fri, 24 Feb 2023 14:06:36 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] genirq/msi: Drop dead domain name assignment
Date:   Fri, 24 Feb 2023 14:05:09 +0100
Message-Id: <20230224130509.27814-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d59f6617eef0 ("genirq: Allow fwnode to carry name
information only") an IRQ domain is always given a name during
allocation (e.g. used for the debugfs entry).

Drop the unused fallback name assignment when creating MSI domains.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 kernel/irq/msi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 783a3e6a0b10..10d29bc87eb2 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -830,11 +830,8 @@ static struct irq_domain *__msi_create_irq_domain(struct fwnode_handle *fwnode,
 	domain = irq_domain_create_hierarchy(parent, flags | IRQ_DOMAIN_FLAG_MSI, 0,
 					     fwnode, &msi_domain_ops, info);
 
-	if (domain) {
-		if (!domain->name && info->chip)
-			domain->name = info->chip->name;
+	if (domain)
 		irq_domain_update_bus_token(domain, info->bus_token);
-	}
 
 	return domain;
 }
-- 
2.39.2

