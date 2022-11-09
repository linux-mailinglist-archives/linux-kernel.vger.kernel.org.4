Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2C26230C4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiKIQ4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiKIQzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:55:07 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E789329C9A;
        Wed,  9 Nov 2022 08:54:00 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9EDNjU027347;
        Wed, 9 Nov 2022 10:53:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=PbgpNffsH6yRXzQNXNDtOnf8nTURcBJoWScHT08Ed6Q=;
 b=aHl5/FYsB6Lo4X/iwT7k8cJTRaduWd/jZddWKU9nRmjjDnKc7g0m5WMHlQOEv7muuk+M
 sfIvpc7QPLYRlEKsqLdlDhYhH7d9BEBjcx9S/nfIM05UZyWNvKMrt3sZKZ2VLAzUYkEY
 jZz9mC58L72/EH8GdggD+hK3YMnFVllUHnhoU8sk0ttlLy57JcsaOwd5jUmy2NOCOCLh
 hhq80cS0bEvvAyTcbt8wswld+wjBbPnSJICQ9j8bS4J5C+E9e3X3g0tpeV9zm5+ukF8L
 zneGM2ry1Q9uW1oBX9bdGG5BUimr7XlTWH2GnxDhEFdQ4HWmosPdtwl+kAITnBhRrYoo 4w== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3knm8pde7v-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 10:53:37 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Wed, 9 Nov
 2022 10:53:36 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.15 via Frontend Transport; Wed, 9 Nov 2022 10:53:36 -0600
Received: from debianA11184.ad.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.92])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 881E0478;
        Wed,  9 Nov 2022 16:53:35 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <broonie@kernel.org>, <tglx@linutronix.de>, <maz@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 07/12] regulator: arizona-micsupp: Don't use a common regulator name
Date:   Wed, 9 Nov 2022 16:53:26 +0000
Message-ID: <20221109165331.29332-8-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221109165331.29332-1-rf@opensource.cirrus.com>
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JnpQQAGo045iAXegME2a1rfJrvmbhA6H
X-Proofpoint-GUID: JnpQQAGo045iAXegME2a1rfJrvmbhA6H
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Arizona and Madera codecs all have a datasheet name of "MICVDD"
for the regulator output. But future codecs with a regulator that
can be controlled by this driver have different naming convention
for the output of the regulator.

Move the setting of the supply name from arizona_micsupp_common_init()
to arizona_micsupp_probe() and madera_micsupp_probe().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/regulator/arizona-micsupp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
index 21c36972a8e9..596ecd8041cd 100644
--- a/drivers/regulator/arizona-micsupp.c
+++ b/drivers/regulator/arizona-micsupp.c
@@ -262,7 +262,6 @@ static int arizona_micsupp_common_init(struct platform_device *pdev,
 	INIT_WORK(&micsupp->check_cp_work, arizona_micsupp_check_cp);
 
 	micsupp->init_data.consumer_supplies = &micsupp->supply;
-	micsupp->supply.supply = "MICVDD";
 	micsupp->supply.dev_name = dev_name(micsupp->dev);
 	micsupp->desc = desc;
 
@@ -319,6 +318,8 @@ static int arizona_micsupp_probe(struct platform_device *pdev)
 	micsupp->dapm = &arizona->dapm;
 	micsupp->dev = arizona->dev;
 
+	micsupp->supply.supply = "MICVDD";
+
 	/*
 	 * Since the chip usually supplies itself we provide some
 	 * default init_data for it.  This will be overridden with
@@ -354,6 +355,8 @@ static int madera_micsupp_probe(struct platform_device *pdev)
 	micsupp->dev = madera->dev;
 	micsupp->init_data = arizona_micsupp_ext_default;
 
+	micsupp->supply.supply = "MICVDD";
+
 	return arizona_micsupp_common_init(pdev, micsupp, &madera_micsupp,
 					   &madera->pdata.micvdd);
 }
-- 
2.30.2

