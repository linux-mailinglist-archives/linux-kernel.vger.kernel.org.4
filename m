Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB4964CD1E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 16:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbiLNPeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 10:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238450AbiLNPeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:34:21 -0500
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE7262CB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1671032058; x=1673624058;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CdsLqucIqQu/6QTuqEdNHoOvo+wactKdqPwMX67jq6s=;
        b=NQqq9kYnfF6h27PG/PJuUL2h93pIW4L96zxwTKupoxEbUFiKz9YFyygxFg7ssJRQ
        BccWckEU6Gkvo3HrwdJnTCe8YHklIRLzTrxj5jwQRFcM2HqEUBei/4zHlwj2kEDx
        uk9lHaVn/RGXUlnq7dPEGt3ie3+gKkKXk/53YJi05Hc=;
X-AuditID: ac14000a-83bf370000003940-50-6399ecf9fcab
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 97.B2.14656.9FCE9936; Wed, 14 Dec 2022 16:34:17 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 14 Dec
 2022 16:34:17 +0100
From:   Wadim Egorov <w.egorov@phytec.de>
To:     <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <j-neanne@baylibre.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>, <tony@atomide.com>,
        <upstream@phytec.de>
Subject: [PATCH] regulator: tps65219: Report regulator name if devm_regulator_register fails
Date:   Wed, 14 Dec 2022 16:34:09 +0100
Message-ID: <20221214153409.1270213-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWyRpKBR/fXm5nJBu+/slhMffiEzeJn5ywW
        i29XOpgsNj2+xmpxedccNovZS/pZLPZf8XJg9/j2dRKLx/sbreweO2fdZffYtKqTzWPzknqP
        z5vkAtiiuGxSUnMyy1KL9O0SuDK+LJvJVrCMrWLtwhusDYyzWbsYOTkkBEwkLn/ZwQJiCwks
        ZpI4eZgTwn7CKLFqozGIzSagLnFnwzegeg4OEQEHiX0n2UDCzALzGCV+7wYbIywQI7F8xVRG
        EJtFQFXi66EWsJG8ApYSy7dNYoRYJS8x89J3doi4oMTJmU9YIObISzRvnc0MYUtIHHzxghni
        BHmJF5eWs8D0Tjv3mhnCDpXY+mU70wRGgVlIRs1CMmoWklELGJlXMQrlZiZnpxZlZusVZFSW
        pCbrpaRuYgQFuAgD1w7GvjkehxiZOBgPMUpwMCuJ8KpqTEsW4k1JrKxKLcqPLyrNSS0+xCjN
        waIkznu/hylRSCA9sSQ1OzW1ILUIJsvEwSnVwLjiX4a+3bnlv7jabzyWrbeUtzvDGW3pnXJ6
        8nadin8ti8MvH36c+doxUWa3sYh86osl240s4hgK8w7p7or0Kb+kdqw96QKj3JZpa7xOdLIu
        nRb9Z+2VM7cza1Mnmx4MrVZ21Z0ye/GEd5OPRy4Lvlyvy3br7b9HFxwXTA01POOTcKBNJyxt
        0y4lluKMREMt5qLiRAB+KO9sXgIAAA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the error message more useful by reporting the actual regulator
name if devm_regulator_register() fails.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 drivers/regulator/tps65219-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/tps65219-regulator.c b/drivers/regulator/tps65219-regulator.c
index c484c943e467..f294d3bc5e73 100644
--- a/drivers/regulator/tps65219-regulator.c
+++ b/drivers/regulator/tps65219-regulator.c
@@ -342,7 +342,7 @@ static int tps65219_regulator_probe(struct platform_device *pdev)
 					       &config);
 		if (IS_ERR(rdev)) {
 			dev_err(tps->dev, "failed to register %s regulator\n",
-				pdev->name);
+				regulators[i].name);
 			return PTR_ERR(rdev);
 		}
 		rdevtbl[i] = rdev;
-- 
2.34.1

