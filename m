Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C6462FF74
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 22:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiKRVk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 16:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKRVky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 16:40:54 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA9F5E9FE;
        Fri, 18 Nov 2022 13:40:53 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 7DB7D1CF7;
        Fri, 18 Nov 2022 22:40:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1668807651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PCD/6dmFnGBLqWK1cint2zY12NZJUc/wLW+bw2dtkU8=;
        b=vUKLS4bqpaikYXvkQtVYN3r7XeWvcQJkx7QF1r/3prG0WQ2dzbJJx3wreaTe2wVNgT1BQC
        3oH7C6JxPRJKTDHo4yWCGQvtFJr5Fu5iPBAFUkQaPcxzsB3TTNshCHkAjoBZ3ubMO07wZE
        c+t3045n0vUKTTxoUVO6CBSJQUapB81ujl/LjWAucAJaPd7PN11pJQco4HYxw3Rik7eX+9
        xNdn0NKfB3HuvtCDgwONTzGhjkpYPoCtoH0Wl496fz1x8FBJ7SAcvforeLYa+2+H3QxDms
        OFsOaA1sVr3YTZbve7sq5kyKZq5wqh3aarK3M+VXZVhmg8nE12rtmAX1ZMGxtA==
From:   Michael Walle <michael@walle.cc>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH] of: property: special #nvmem-cell-cells handling
Date:   Fri, 18 Nov 2022 22:40:36 +0100
Message-Id: <20221118214036.1269005-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <8b976cf546bad3aa159a6f05cd3c15d1@walle.cc>
References: <8b976cf546bad3aa159a6f05cd3c15d1@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since recently, there is a new #nvmem-cell-cells. To be backwards
compatible this is optional. Therefore, we need special handling and
cannot use DEFINE_SIMPLE_PROP() anymore.

Signed-off-by: Michael Walle <michael@walle.cc>
---
This patch will be part of the following series:
https://lore.kernel.org/linux-arm-kernel/20221118185118.1190044-1-michael@walle.cc/

 drivers/of/property.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 967f79b59016..93c0ea662336 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1305,7 +1305,6 @@ DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
 DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cells")
 DEFINE_SIMPLE_PROP(hwlocks, "hwlocks", "#hwlock-cells")
 DEFINE_SIMPLE_PROP(extcon, "extcon", NULL)
-DEFINE_SIMPLE_PROP(nvmem_cells, "nvmem-cells", NULL)
 DEFINE_SIMPLE_PROP(phys, "phys", "#phy-cells")
 DEFINE_SIMPLE_PROP(wakeup_parent, "wakeup-parent", NULL)
 DEFINE_SIMPLE_PROP(pinctrl0, "pinctrl-0", NULL)
@@ -1381,6 +1380,22 @@ static struct device_node *parse_interrupts(struct device_node *np,
 	return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_args.np;
 }
 
+static struct device_node *parse_nvmem_cells(struct device_node *np,
+					     const char *prop_name, int index)
+{
+	struct of_phandle_args sup_args;
+
+	if (strcmp(prop_name, "nvmem-cells"))
+		return NULL;
+
+	if (of_parse_phandle_with_optional_args(np, prop_name,
+						"#nvmem-cell-cells", index,
+						&sup_args))
+		return NULL;
+
+	return sup_args.np;
+}
+
 static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_clocks, },
 	{ .parse_prop = parse_interconnects, },
-- 
2.30.2

