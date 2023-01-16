Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1798A66C049
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjAPNv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjAPNup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:50:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202B321972;
        Mon, 16 Jan 2023 05:50:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 86905CE1161;
        Mon, 16 Jan 2023 13:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F39C433F1;
        Mon, 16 Jan 2023 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673877040;
        bh=8NK6cMAg/Gp7SlI9n2MjOR/D97yEutmk49eysprJ2C4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PjndJlSRpc1AnDOK4A7FI2Z6RWqNy6J9qyKZmOdPvNenH5WFdsKvUMZHDUCeh9/kS
         PA0jeJtbIeypY/8vQqex1EAw5WbNKZVhUmQmEePAm5WC17QIPH/4GBs6i4K3ps/L6P
         XgiFidY+Yg+6FafT2Dd2v8IxrjaH6zzHRqpBZSoSXLA5fDMeRg4jvk+EPUVze3MbqE
         OUu4iInoSzrbZYCsOXa/I0y0M4Pmds7Vj+8lwmUDrTpAhEUueX9lRvcOvNwdiEuhy1
         SHvHTZKc5iDS0sGAqx68AmQXRRj6ZHMJnxoltE5upKUY0IRk0g/Kn1YseplcgiXfvB
         hyIZp2C4lxgcg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pHPt5-0003uu-TT; Mon, 16 Jan 2023 14:50:59 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH v4 05/19] irqdomain: Fix disassociation race
Date:   Mon, 16 Jan 2023 14:50:30 +0100
Message-Id: <20230116135044.14998-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230116135044.14998-1-johan+linaro@kernel.org>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The global irq_domain_mutex is held when mapping interrupts from
non-hierarchical domains but currently not when disposing them.

This specifically means that updates of the domain mapcount is racy
(currently only used for statistics in debugfs).

Make sure to hold the global irq_domain_mutex also when disposing
mappings from non-hierarchical domains.

Fixes: 9dc6be3d4193 ("genirq/irqdomain: Add map counter")
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 kernel/irq/irqdomain.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index b2087f55a1ac..23f5919e58b7 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -537,6 +537,9 @@ static void irq_domain_disassociate(struct irq_domain *domain, unsigned int irq)
 		return;
 
 	hwirq = irq_data->hwirq;
+
+	mutex_lock(&irq_domain_mutex);
+
 	irq_set_status_flags(irq, IRQ_NOREQUEST);
 
 	/* remove chip and handler */
@@ -556,6 +559,8 @@ static void irq_domain_disassociate(struct irq_domain *domain, unsigned int irq)
 
 	/* Clear reverse map for this hwirq */
 	irq_domain_clear_mapping(domain, hwirq);
+
+	mutex_unlock(&irq_domain_mutex);
 }
 
 static int __irq_domain_associate(struct irq_domain *domain, unsigned int virq,
-- 
2.38.2

