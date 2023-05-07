Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744136F9AEE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 20:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjEGSeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 14:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEGSeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 14:34:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024D36E82;
        Sun,  7 May 2023 11:34:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C0C460FB1;
        Sun,  7 May 2023 18:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F72FC433A1;
        Sun,  7 May 2023 18:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683484456;
        bh=BANIf+ASt30mN5iS/NWLlkQ2ov0wGoxCBBMNfEgEvLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iI2gauWXX+FpvZGeuZivJ5XIu/c/TN8lfj5WAK9mc72mvIoGhJH2S9uYQDOJymWlE
         LulXx6JEDOKWhOmWkm7ja3YdWQHbNavQi1lD0RN7dvxG8QSXcuyUX0ecMFHWUJ8HTO
         OoN3SPK/P+sGNQHeOzRFx4kXJmF/y3Gr2muWMdu2FKCJWiJSK0jsnib5zH5siuLnOO
         7HITT5jeGH4riYtTIBC35hmL1GsO0GU0ZlnKYhCbOJcrp/xXMa7bgArhNC9LnfHqXh
         tNUJe8EbpWaj8kXhIthunrRBkly54fbXcirV3z//8Z9Ol1HTI4LTT7FyVxoiJxahnq
         iw3IQNL5k9ZwA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Subject: [PATCH 1/5] irqchip/sifive-plic: Support T-HEAD's C910 PLIC
Date:   Mon,  8 May 2023 02:23:00 +0800
Message-Id: <20230507182304.2934-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230507182304.2934-1-jszhang@kernel.org>
References: <20230507182304.2934-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The T-HEAD's C910 PLIC still needs the delegation bit settingto allow
access from S-mode, but it doesn't need the edge quirk.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 4 ++++
 drivers/irqchip/irq-sifive-plic.c                             | 1 +
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index f75736a061af..64b43a3c3748 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -62,6 +62,10 @@ properties:
               - starfive,jh7110-plic
               - canaan,k210-plic
           - const: sifive,plic-1.0.0
+      - items:
+          - enum:
+              - thead,light-plic
+          - const: thead,c910-plic
       - items:
           - enum:
               - allwinner,sun20i-d1-plic
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index e1484905b7bd..71afa2a584d9 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -569,6 +569,7 @@ static int __init plic_init(struct device_node *node,
 }
 
 IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
+IRQCHIP_DECLARE(thead_c910_plic, "thead,c910-plic", plic_init);
 IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
 
 static int __init plic_edge_init(struct device_node *node,
-- 
2.40.0

