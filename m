Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA9772DE7C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241303AbjFMJ5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240450AbjFMJ5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:57:43 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2106.outbound.protection.outlook.com [40.107.255.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4011BDC;
        Tue, 13 Jun 2023 02:57:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khbyOLYBVUPX93GhKQ169V9J5VenjcpeEmO8RBkycbF0E6gSAgKU6Gm+qf4lrMg9P64BRDMieDWnKTNs7/+ogt2PjSAG83tnew21FfM0wR8juKEX0X0/tlkWEJrPzBEHTq5ejYMcXYM95Ohd63uBak7duZRZVZ3XtWC2jPKES4IaiZRRgaz1Y0WIkY9Iq+FnjbTJEDAQvebOXwFdQAndNdtNCbswX1XDdsFkAigEeq6kqY7Oqtac5kNaf7RgLtY3lSb0hP44fPCY7C5KO/4uxOwdrV0UiCHl3Rz5og6uVcQsxzhL7yQCF9wODlpFtQQdLxZgXTr6xhKbencOujdVuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3OBtGY/5chd6gxnhXKVzWiME3BSs4Qa259qqbn6U0M=;
 b=cxBJ42t+80G+QPLqo3pLLuCg82GP7uy801jvkq9CrOtmEp6cp4WTBS1y3X1RkMzJYezJueETspjwFIbY5xOLkhub1Xz/vT2ArJT3JhyNScwxqhH2SSwBbnq7jMCiOGxqCn3VSc+myoF8AR/gHqpD+jOhzRf8Yz1ZuZZflzEkQrMD3LWMNdtr3SESdTdiLTZBtsSige8GRluUE+IbEvb1p0k16TCd3bhBAzgEPBJg7X5ojLPGD1mctrCDgsU2AdLpafIyN3uMvgDSl93c9UNGkJXt9VoPfGEtj6eJa79l5sV0s0B0B5XSCoarKnxhn8kLjlBMChLYat5xnbfJmG/ltQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3OBtGY/5chd6gxnhXKVzWiME3BSs4Qa259qqbn6U0M=;
 b=TwUcDeBUef26bO4uCt6sh5yKBTpgUeGePhzCOGb1LZ/4r7yTbEKfFcN30nMIcF0kWaVth0BVdjuSU1PEaSUFCVEiDOO2lKTnXwvaXTTTbmQeAK0XY2ZK5dvy/DKEzKxAHUZksvu/4O/bmlvWtfhhJsGpCXErV0XAm4WalmvsGX1IRcnyHqw6lGQ9AMXjUkHefpfTzgRJ1gShAoZy1ZaCNDeTA0/fft7rusDt517vTXNlQQEfvl8UjzKoCqwITAY/sS+FUdoPxVjPsrB55Yet67HaW8pRumSFZnv0tPv6aGBAUK9NvvE/aar4I8rM0gITmig9kwig0qn4ouXe0DY2Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4012.apcprd06.prod.outlook.com (2603:1096:4:f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 09:56:55 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 09:56:55 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     glaroque@baylibre.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, thara.gopinath@gmail.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        anarsoul@gmail.com, tiny.windzz@gmail.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        edubezval@gmail.com, j-keerthy@ti.com, f.fainelli@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RESEND 3/9] thermal/drivers/amlogic: remove redundant msg in amlogic_thermal_probe()
Date:   Tue, 13 Jun 2023 17:56:18 +0800
Message-Id: <20230613095624.78789-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230613095624.78789-1-frank.li@vivo.com>
References: <20230613095624.78789-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:3:18::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4012:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2232c5-7e3b-4b7f-3968-08db6bf48534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fsjus5dFmEBfFKA4qpq9GakphRC06lbP0mje3pPnghpm785wWLbCf60cmkCMb7lVix0rhMp9gAn4uL8AYdZ4EVAsJdkyW9gipzAoDT37uTFQ9xCJ/dJpJw+Vh4kymBCoKz6YZR3ArdKUoQErtInjMl8yy6Up9Sj7F2YEvyoqMi6/eT+5Kmwxm2Drgq4FZKxMJgM4EcGsk77yrAIfqu53Dwq4pJ16x0E9h+DSYPuzB/h5Iq3IR2KnlUrXswvENxdoqWx8Xx93/DafPPZNTBsL3nfccwXKV3xuRlK3yUqG/ka40yJdUJykXHG92GQtq0jw3F0WwobxaeC1G0K5JcoGyFbmgDU5Mvp0onRFJxKsB/L6uXMMYnAOzeEBQdvo/1a6KH+vdoLUn1OMoP40+uJd3BHIAMsApTCbV/U2HSTNUutmXVlNqIj1q1jL7VT1BP2opbIplL84xXlsZGbWl82LqVH8QBulAGqtTzKvkzxeDSBu4r5oyOjJAST7slXxBFcfOPp/oqe5iIUfEuRyfJfPyT+l2gDBLL2QpUW1o6y+GLBmgYojhtNnLHLULrAGhZ0W1MflVEB8362CMmczy4we3MT3umYis/rhhrXYfmEGhGDqro5SE5/EHQxtNUQjDd263PB/JvNcrbasRy/ywD3nxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199021)(4326008)(8936002)(66556008)(316002)(7406005)(7416002)(66476007)(41300700001)(186003)(2906002)(66946007)(54906003)(4744005)(478600001)(8676002)(5660300002)(6666004)(52116002)(6486002)(1076003)(921005)(6506007)(6512007)(26005)(36756003)(83380400001)(86362001)(38100700002)(2616005)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gTX90PoWwoMxRelS+WiGSTCbhJAeBjo9ZNisLX6mslHPOS3vINt6vW8dyrjE?=
 =?us-ascii?Q?NSN1/VdgXH2ScIBr23JLgQA249Fj5+qURDjc2D+TOVh4HPKaWl3bUsT5FHJy?=
 =?us-ascii?Q?o+GC1YjQXjQ5N6xXWv4KVr+Qn/v1IL/a0BH2HIC3oQ9iL5R0fpjqVzjEqeVp?=
 =?us-ascii?Q?rFRIhpryTLNSlAMuT4O/Sdv1hxqAWCGd4XV1JGUL0pd1oPooClHRN3yaS1+n?=
 =?us-ascii?Q?MWlcir0YtLGuEIkAXAqQLsVEgeIRz9qxuXbroM3NxBelJdTAUR+NCq//SPHl?=
 =?us-ascii?Q?VEweQqd3hK9Ry4/nvh3EKrnd6alLK2VP/UlTNl3pA3oSUWKiN52iL7iNgoTf?=
 =?us-ascii?Q?eDaCR6c59bL/YhNgI/1NGYv0WCjl/RNL7+c3Osxn4S0KUCVU1BXYnRxTspOM?=
 =?us-ascii?Q?tk/IhV0d3+O8UBkRYEQ9PFkk+HGGAv7/+d9WBnpRU7o3jIUuIskW7600zb66?=
 =?us-ascii?Q?1/uSS8cyjZTo93S1h6Hf3PY4dAJqs7N8sfToI0Sa2KG3AXlkjotGLNeyZab2?=
 =?us-ascii?Q?ftICW8uqGJ1jj5HRG5ysza3nr7UrLhKktJZhHold4Eozqo78e3cw+iPBNzq2?=
 =?us-ascii?Q?9By3mRfxo1dUirL49BDNa4bjgPpkqFV3j7MGvMcA8gOOJAkiBRQvk5NFrcjs?=
 =?us-ascii?Q?+7wSsh4YccOV6Hn4V6cfaiOimWpuHRnNpK/nh3XlnhzTEYBcDxJXkFQdMw5V?=
 =?us-ascii?Q?rn/WujNLuqduY8bm5266T2U0A4EPWfzeRBqLoIya0f0lPt4TPdDxZp3f8OKJ?=
 =?us-ascii?Q?kY9RIyHHhhnS8ImT8k7rns3sEuNmkLqEuH6x2/dN9UP4IeI53AjbRq/pW9h9?=
 =?us-ascii?Q?q4nfyYOP+H9azhEn4ORQDnaW3EkNieIJjHx6ygo2edIZtB/GKm2jfEfvZBXA?=
 =?us-ascii?Q?WJfWG2kfg/2/W8nnbDT8hDIC1vgTQuu0Oo3rGY0xg23dMezQyF6f520fOfrD?=
 =?us-ascii?Q?bBvxhQLGbtAdzpTJnQm9J9BtBWxUxbnS6wCkxFyFYLg3B6yrRUIyCwyAtpJH?=
 =?us-ascii?Q?MhmIS22ea0FL88Sd0vLLQ06yKllwfUNq20o8DhbndakIFpy/5pP9bBCV5/x0?=
 =?us-ascii?Q?Wxupz9NhEPjP4dsO4hpZ38YL+I45t8Xe2TWHwFv1CDuDAbPKf9eDFg/A2Wlo?=
 =?us-ascii?Q?BD4ycS4482nj1ScbY7LXyycZLS9CQnGEy5yUpxHjNPyCPj4RgK1LPuP6if6N?=
 =?us-ascii?Q?KB1L3N3ylriwaKqzVTgTJd5jJ1JvKREYdb2aHVOQ+VgHZ0+BSLnv5oITQdlK?=
 =?us-ascii?Q?50YZujG3TG1rctVZ7bBebBi5EbenAMHglgB3S91i3fH7dUPDZAkTErMVkEvc?=
 =?us-ascii?Q?g3hfX0R0aa2ezkzilDjucvm73jSnt7jpEzv8l6yCykfeyifH/v/LVKD4U0nq?=
 =?us-ascii?Q?dtOkrzKfrup/I7CY0jDF9jzVmKFrsCR2YVhdoANqmcDNLfnqXYzM9aR18w/g?=
 =?us-ascii?Q?Ma82t10iDbgYgU+03MzJlvhrKaTADw4LsKuBt6MOVqR578/TYmDtHlzyT0CN?=
 =?us-ascii?Q?Gmwsqccdnci+/uVWGKAsFwxQW8NrrOW/JFuohs8/N7hAjmQGEKI5MdAn806d?=
 =?us-ascii?Q?yy9iBRrY7HCZSV/gVEUu4LHk/RKqqDiZFFkip8Du?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2232c5-7e3b-4b7f-3968-08db6bf48534
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 09:56:55.6621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0qq/9W4wI/CoxCKo6g+84999w6STuBnPcH/SLaRw88OyIzRgxON9XvrWTYkfREiNkoQOfMEEo8R6XvLAn7GSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4012
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper-layer devm_thermal_add_hwmon_sysfs() function can directly
print error information.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/thermal/amlogic_thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index 3abc2dcef408..756b218880a7 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -282,8 +282,7 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (devm_thermal_add_hwmon_sysfs(&pdev->dev, pdata->tzd))
-		dev_warn(&pdev->dev, "Failed to add hwmon sysfs attributes\n");
+	devm_thermal_add_hwmon_sysfs(&pdev->dev, pdata->tzd);
 
 	ret = amlogic_thermal_initialize(pdata);
 	if (ret)
-- 
2.39.0

