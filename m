Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B4E66E134
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjAQOrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjAQOrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:47:31 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6B534C1B;
        Tue, 17 Jan 2023 06:47:29 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B1FCF240013;
        Tue, 17 Jan 2023 14:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673966848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/cUfcf/QAMo2QYFX45p/y6/QB8475Ld6Zy/Yz1xqXFw=;
        b=Mq+6FxmjcHlOqY5XywZGT2jCVdK0oUcGNv5QalgRxYRvmbE6w2Kc+pKimT7Uv5+BHEyWXG
        LwwpgTBRPexNHsKUcdYcw4BVQwT9YROK2IiYG2ji6L93rm52wPxNBUfBl5sk8+GcyRPzez
        LzIXBHOji8Uo9UgFR32ZRo2OxVHwFFeUF4ShSDr362vkHN+IqgS7XT+F+9U/0oVjJCorTh
        R/clqcpuUDTjwH9evgegoBIpkdElW2ORr3KgRhC61Jg0eJo57rsDgB38QGavBd+HVTFEYO
        mXdMe2NS2oewxs8zVUWpOSy9HynfxycbKJSqcvys5fIccy7Hnh8zcMg2x53fCA==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] of/irq: add missing of_node_put() for interrupt parent node
Date:   Tue, 17 Jan 2023 15:49:29 +0100
Message-Id: <20230117144929.423089-1-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After calling of_irq_parse_one(), the node provided in the of_phandle_args
has a refcount increment by one. Add missing of_node_put in of_irq_get()
to decrement the refcount once used.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---

While debugging a refcount problem with OF_DYNAMIC enabled (which is
actually the only case were node refcount are really used), I noticed that
platform_get_irq() was actually incrementing the refcount of an interrupt
controller node. Digging into that function shows that it calls
of_irq_get() which calls of_irq_parse_one() and finally of_irq_parse_raw().
Since it seems sane that the node returned in the of_phandle_args has a
refcount incremented, I thought it is better to put the of_node_put() in
the user even though it was hard to find any user doing so.

 drivers/of/irq.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index e9bf5236ed89..174900072c18 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -438,10 +438,16 @@ int of_irq_get(struct device_node *dev, int index)
 		return rc;
 
 	domain = irq_find_host(oirq.np);
-	if (!domain)
-		return -EPROBE_DEFER;
+	if (!domain) {
+		rc = -EPROBE_DEFER;
+		goto out;
+	}
 
-	return irq_create_of_mapping(&oirq);
+	rc = irq_create_of_mapping(&oirq);
+out:
+	of_node_put(oirq.np);
+
+	return rc;
 }
 EXPORT_SYMBOL_GPL(of_irq_get);
 
-- 
2.39.0

