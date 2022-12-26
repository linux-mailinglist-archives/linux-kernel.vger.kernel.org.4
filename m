Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956436561BD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 10:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiLZJ6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 04:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiLZJ6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 04:58:05 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417D5267F;
        Mon, 26 Dec 2022 01:58:04 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BQ9vo1x078249;
        Mon, 26 Dec 2022 03:57:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672048670;
        bh=EhrgxjMr+d+cFtBbp3yJIKjSN0BrfSAFflBEkgd14AM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ioqaHRLumQfn/Offg7Xgn+W2uwYO0hj9QnivKsZ6QFOM01hDCaEKMd07+XHMx4U80
         D+2u1yaROj7PfOHgNHD+33Za7ghzqg2Rx87VW8Zwfi4h9N5383AS2jpyeZ/cRvhOFo
         qkhUvXEJ+/6K7VxCUqZBXgyLiF2lOA55+2Js0BAo=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BQ9voZV126102
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Dec 2022 03:57:50 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 26
 Dec 2022 03:57:49 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 26 Dec 2022 03:57:49 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BQ9vmbc088703;
        Mon, 26 Dec 2022 03:57:49 -0600
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Tomi Valkeinen <tomba@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Linux Clock List <linux-clk@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH 2/2] clk: fixed-factor: Re-introduce support for clocks to set parent clock-rate
Date:   Mon, 26 Dec 2022 15:27:45 +0530
Message-ID: <20221226095745.19757-3-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221226095745.19757-1-a-bhatia1@ti.com>
References: <20221226095745.19757-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the clock "ti,k3-am62-oldi-clk-div".
Also add support for this clock to propagate the clock set request to
its parent clock, by setting the CLK_SET_RATE_PARENT flag.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 drivers/clk/clk-fixed-factor.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index f734e34735a9..1a78e2d870dd 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -245,10 +245,16 @@ struct clk_hw *devm_clk_hw_register_fixed_factor(struct device *dev,
 EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor);
 
 #ifdef CONFIG_OF
+static const struct of_device_id set_rate_parent_matches[] = {
+	{ .compatible = "ti,k3-am62-oldi-clk-div" },
+	{ /* Sentinel */ },
+};
+
 static struct clk_hw *_of_fixed_factor_clk_setup(struct device_node *node)
 {
 	struct clk_hw *hw;
 	const char *clk_name = node->name;
+	unsigned long flags = 0;
 	u32 div, mult;
 	int ret;
 
@@ -264,10 +270,13 @@ static struct clk_hw *_of_fixed_factor_clk_setup(struct device_node *node)
 		return ERR_PTR(-EIO);
 	}
 
+	if (of_match_node(set_rate_parent_matches, node))
+		flags |= CLK_SET_RATE_PARENT;
+
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
 	hw = __clk_hw_register_fixed_factor(NULL, node, clk_name, NULL, NULL, 0,
-					    0, mult, div, false);
+					    flags, mult, div, false);
 	if (IS_ERR(hw)) {
 		/*
 		 * Clear OF_POPULATED flag so that clock registration can be
-- 
2.39.0

