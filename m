Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E716470E4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiLHNgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiLHNgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:36:18 -0500
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931DC89AD1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 05:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1670506574; x=1673098574;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4mTJX+4tizOW8u7atOWh+4YTNETI5lpnDT3sT0CjBI4=;
        b=Y2kVhgk0YyN97zSIgeEZ7P4oVuEYTiuHyJJ+nq7iAgzPZeDiLoSVMOfnW+ZeEe5E
        UQgXH2hSgDcx0TIpZwYlaHQ2aZdU+RCXiK08j0VhV6f7vB9LYOgsX+IHCs9ZOB0y
        ECiXKMiynP11Ytp4WJC95Oz8rIpLLcGQXPohlY/Ycz8=;
X-AuditID: ac14000a-83bf370000003940-38-6391e84e6c14
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id CB.A8.14656.E48E1936; Thu,  8 Dec 2022 14:36:14 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 8 Dec
 2022 14:36:13 +0100
From:   Wadim Egorov <w.egorov@phytec.de>
To:     <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <upstream@phytec.de>
CC:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: rv3028: Use IRQ flags obtained from device tree if available
Date:   Thu, 8 Dec 2022 14:36:05 +0100
Message-ID: <20221208133605.4193907-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHLMWRmVeSWpSXmKPExsWyRpKBR9fvxcRkgzndfBZLLl5lt2h/t4zd
        4vKuOWwWx1ZfYXNg8Zi3ptpj+ryfTB6fN8kFMEdx2aSk5mSWpRbp2yVwZdx8s5S5YBVXRdcc
        gQbGeRxdjJwcEgImEm9X/2LtYuTiEBJYzCRxbM0PRpCEkMBjRomNfVogNpuAusSdDd+Aijg4
        RATCJR53pIOEmQWsJR42/2EFsYUFgiTu79sJZrMIqEh87+kDs3kFLCXO/97BCrFLXmLmpe/s
        EHFBiZMzn7BAzJGXaN46mxnClpA4+OIFM8QJ8hIvLi1ngemddu41M4QdKnFk02qmCYwCs5CM
        moVk1CwkoxYwMq9iFMrNTM5OLcrM1ivIqCxJTdZLSd3ECApTEQauHYx9czwOMTJxMB5ilOBg
        VhLhXbZsYrIQb0piZVVqUX58UWlOavEhRmkOFiVx3vs9TIlCAumJJanZqakFqUUwWSYOTqkG
        xp2G+l6PT9ZKyZ3cJhfTvDG1Xb6UZXv2P954o5h9X9/wRHAzWdxmnX36d7Z0zy7e91eKZ8/U
        CDJtmGSxYpLFTf0NDUKfWTbeXHfv7I6fwhvk1FOjwj3fyr4qFJAym5Rx7d0S76d7Az9f3ZPh
        8C3v3HuZKf8cXaQLS/yPGe7v5N8hwrpH4O1vWSWW4oxEQy3mouJEAOBe8/5BAgAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the interrupt pin of the RV3028 usable with GPIO controllers
without level type IRQs support, such as the TI Davinci GPIO controller.

Therefore, allow the IRQ type to be passed from the device tree if
available.

Based on commit d4785b46345c ("rtc: pcf2127: use IRQ flags obtained from device tree if available")

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 drivers/rtc/rtc-rv3028.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
index dd170e3efd83..b0099e26e3b0 100644
--- a/drivers/rtc/rtc-rv3028.c
+++ b/drivers/rtc/rtc-rv3028.c
@@ -902,9 +902,20 @@ static int rv3028_probe(struct i2c_client *client)
 		return PTR_ERR(rv3028->rtc);
 
 	if (client->irq > 0) {
+		unsigned long flags;
+
+		/*
+		 * If flags = 0, devm_request_threaded_irq() will use IRQ flags
+		 * obtained from device tree.
+		 */
+		if (dev_fwnode(&client->dev))
+			flags = 0;
+		else
+			flags = IRQF_TRIGGER_LOW;
+
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL, rv3028_handle_irq,
-						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						flags | IRQF_ONESHOT,
 						"rv3028", rv3028);
 		if (ret) {
 			dev_warn(&client->dev, "unable to request IRQ, alarms disabled\n");
-- 
2.34.1

