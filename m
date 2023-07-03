Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C969745804
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjGCJFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjGCJFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:05:25 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2101.outbound.protection.outlook.com [40.107.117.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A931E47;
        Mon,  3 Jul 2023 02:05:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0ckBMOWOx28Bh0EwAiK9hBH3TUa4nUXP0LYl6KWEqRU2rS7WlYw8/K7OCrEqzIc25ca1+NNEBkyU5JclZhZBdugsFIrfJOjy0+rXpa1g2HareRL9GspdX4FB0ePh9DS7Xb7XRka6grlLlD08LBXEx5/rZdmC50BijW+g7DTEgwegaRAumA0BSIMHjNASmGMEhRyCSmpi/N2gOFX+WCdaaC0CShbFdfPbBzBU7u60FDByG642toB0e3JcLbroeB/RL1yt9rIZXRJl2XbpMHViblRUeWo2u2HqX3MaWV8MiQhW2cyhmkRwn1hT4Kwc9ygJ8noWRwjPfZajEsZQvqCYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWVA0ByOKffyDSYcHumvNc3C1/Qhx+bH8OiRfeIFbdQ=;
 b=nGmmNOkvvClYQGtAy9RNGHvBg8yEJ0xTernb0FophIw6jLTDEof+sPprlmTbvt6u2xg9LBlw1bg47CEYG8FOyKjvcwWtBQe0x6NUitcsJQCscI4Rnf7y8DKyHehxzVxU3HpoNNrW6CfK+VdujqSNUdq3AROIa5eIsZzLkZ0PlPGpm1p+iuwCgd1V+U4IfaHWvyfVrwORVjzdm/Ow6YgT/rRQrUmgB+QpbIsJWnr0qZGsw4QiGbZqqxz/nrwY4RdytekI3M0w5SsICD1mVlJL4cKcUdJ5LoIzr3v9G8mVUFsnUdMF2MjUIXd5bBZPV/6mE1V6mfZsp+1AL4mA2f6gRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWVA0ByOKffyDSYcHumvNc3C1/Qhx+bH8OiRfeIFbdQ=;
 b=ZKMlthuSXz8Fl0Izf1e7hHEgCaoSrEPp4dO1phbZS5fhocUu9o7NQbMm2mdyZ2cgRrPBp1CfhGTkAknp+Mqvd5RHtKCYACw6QJ1n+bHpPh8iuFaEi/vm2RGBjDNJsSguxMIHwf5qLEvx1WY3aI+lPjb/eZVz9G1ojNlmJEMj7hU5u1H4+u/XlcOp69eeD89Td3B77Wveoy9/vbBZEDsKAEsJLko2TFGkIZb5MRljx9JpcY45JO0els5tluhhnvHwvvCizYxsyd9KdPCu8kulgLB4rs5AwverVwneSsctMzhuBrP5HakxBfxcwnHsB7Y8j7apzz3H96Emc/SqVS2RnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5850.apcprd06.prod.outlook.com (2603:1096:301:fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 09:05:19 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 09:05:19 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     miquel.raynal@bootlin.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, tglx@linutronix.de,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, frank.li@vivo.com, wenst@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 3/5] thermal/drivers/brcmstb_thermal: convert to use devm_request_threaded_irq_emsg()
Date:   Mon,  3 Jul 2023 17:04:52 +0800
Message-Id: <20230703090455.62101-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230703090455.62101-1-frank.li@vivo.com>
References: <20230703090455.62101-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4debbc-50ed-40a1-e24a-08db7ba4a024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wuLoRazj/shZywzQdiOiMWtrqjbJcVXZPOYmxYHqlahTgrhM2fhLVcTafdM3J8pk1rBlArdFGYD47JDVeB2MyqzUaFGyB4rKlO1ggF6GTU/2q9SppCOykuWBZa/97Ul1Fa5Hi3ciFAxp6K2BcZ2VTwjVEOqXejZD2OZcYZWtgznpaXERgpdV7bLbcrEhjzlM6Z6ZBl31TUMmqJJVCQDTSFtgINobifz9tNxIf/ticutYBKYsclIR1OtGqhtz+hxIG5nTFEhVpa6MPRwOkOkM01WD9RgLC53bkaqbX5hFFza/YxPOx1aCBANzvX7u1YQSpLvysuw/b4YqszNoMPT41VVLG98aklPUnVdqJ7aKL9nVF3Ew9yslQkdy/KIDdbC19zwijMEumsJoDsrq9O21gqxfNmapQg6ZHSWwvBhA6ZDNy31amumIgf6+dGCm+PLAnfR+uscUtuSn0BOIdQcN9xTLaQ/yhJ0jPrAZtfZEmMMVL8/99ZuBzDdbQRABj7EMSs6GpuSqLVlb/OicKrBZJiusN+72YwIkvzHNYD46jWTGjDZxzMMYjCQsemWkhd7tkFrNkoGvGYmBV+hUiD1iHFitujdjGhJnG6KLnlKLZntAeptAvIWYD3/jkI4yupkeWVDHhlqc43dG1zVYsCR7gA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(2906002)(41300700001)(5660300002)(8676002)(8936002)(7416002)(36756003)(86362001)(186003)(2616005)(478600001)(26005)(6512007)(6506007)(1076003)(6666004)(6486002)(52116002)(316002)(4326008)(66476007)(66556008)(66946007)(38100700002)(38350700002)(921005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oT5inER2najQLvCMYbWkikHhuwutwgBxoHeK/QhkGul7lV0EdR4b26pmYzME?=
 =?us-ascii?Q?boLC3QVRgOz5C50VUJmeqtK1jbl6Sw/Tz0cmNBHeWEDrkVCWfv1Q4SFkXE7S?=
 =?us-ascii?Q?cxclEsbDRnSNF5xhutjEjKWNdoOn4xNhhy3WYpNxbhj806ggXb7Qx3kYL77L?=
 =?us-ascii?Q?5BOTkAWGdhmQqEgNihpspWyLHjI3zHh/DhvrHDYx/PHOwuXyNS2Q1PfMsYeQ?=
 =?us-ascii?Q?Su7I8xZuPiHttoqvztZDMcoikvaOqxtdx09dP/ojWuTQES6mOeJ4jgKnZ9mi?=
 =?us-ascii?Q?bmsKwrJg7ktukX4KOTMq1ImgBsqKm/QEN/lDOV+I/73rMukLOfIf/VTKASH8?=
 =?us-ascii?Q?AYu0XdmoSk8wf5Yum5cM0e4HwV2Y2YxDb03M4a0L+VveRcxpAJyYds+wmu4P?=
 =?us-ascii?Q?uXkpBqVvCKzmJAwL4QPJHbUntbn2+b80D2v8tGge5QDi4nDyQY4Js+lKhjwU?=
 =?us-ascii?Q?atf/QPSL1vQCyiAiwqUpI7x6Fttj7pt55pFR2NooCxpOwdeGaV7rwhIsfiE7?=
 =?us-ascii?Q?FToiFjh0IEfc0YE2XpSF6lyLGdzyTTDp5PJB9+IAy1TH0svM6lXzJ6zTltTt?=
 =?us-ascii?Q?SjLeBkFh0/5g3QsbD5yykWByYsW5Ghui4UFImLyuYunJVT8tX/C63CPXsTnU?=
 =?us-ascii?Q?nMbdhSQ0exQTygABZjHg6Xp9DUZY1dob1Ouu4PE09LYs87TAqYIU8Ae5/e4K?=
 =?us-ascii?Q?aUenFMCGQzgpjsqNy8M6TisUGX+JX/IAI+MpLqGmMyZi6ydbzFGaGRLvyDkZ?=
 =?us-ascii?Q?gw5XGT2guKzEoSV4lCeIMflt8rp14L7mek4UG6r9FP12FYclyAIxSFOwGP8L?=
 =?us-ascii?Q?Ze52/KooDTuwBkoXNbL1h3YyT0xdfwDVUzvUvCyDjw/+x0q5xPMCju3bC495?=
 =?us-ascii?Q?hkhYxALKd6GcBiy6ZKghBzhIj2QkqiGLc1FyVlXyEQGzw604MDbvP7THI45l?=
 =?us-ascii?Q?s26p61GIZk1aePHNAz40roKoXwrf18630OjW50zPItl0mAq4oA1xhykG/FqI?=
 =?us-ascii?Q?gmbNA2U6nD1Xrc+HoHaVJE06J0IRFzzv9941ZpoaihEdxpCuGiVEQL9t4Q2f?=
 =?us-ascii?Q?uxEpDcIESbj5FNhGFhSscUog2lWYl3FASzqduyDI34H2JLrpvWnB0y98EBoE?=
 =?us-ascii?Q?cAWpfDfwvR+EFg+OlqXihUHIK9OC4NN/IzlheWVhEAARrK6dH+cU6PTUP1gF?=
 =?us-ascii?Q?wLamanKiX5cNnqj7kLtUONapS5m8GUnW4VUvSvbDthwJko/Oybg3n0DuAtyl?=
 =?us-ascii?Q?GuBsnh+xz4TV3y1zIRO9tVqFYe3HnjOgGEOGCCSEYO7Mf/7y/LSXKx/wb+Sr?=
 =?us-ascii?Q?LEBqUzQsWL+x/SGGVCEEZtOQWgqopzCl3eCI7tnzpaLscZiOFB0xkKvehcu+?=
 =?us-ascii?Q?SRzhzjG8WzvL1Utpz8GhnLjEnI6xmPK2d23T319e4OEUkqp8NImaUqseW3qd?=
 =?us-ascii?Q?oQ2aS4jV+Vzv2ozHQRegUe7IMlwiL5CqKVMmD3s3PeyPBnnJ5ZonpNhp4TMg?=
 =?us-ascii?Q?DHF3QIFrw7Wlsn3WYUKQqSQhUx7lfKA7OhQvb9f6H2n7gcmQPP62Ai5hnoU+?=
 =?us-ascii?Q?38wUFYehZ5P3VWjNoFFI3i8wEgBYvwqPMC40d10n?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4debbc-50ed-40a1-e24a-08db7ba4a024
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 09:05:19.6754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jaTWDdYIbLZPEIKG6nobFYOCDku0KWUF+xio7zu9TMvU9HeePauAqDou/SbhN8HR1qJIQiW+O5Rjdv7S3VqLhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5850
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more than 700 calls to the devm_request_threaded_irq method.
Most drivers only request one interrupt resource, and these error
messages are basically the same. If error messages are printed
everywhere, more than 1000 lines of code can be saved by removing the
msg in the driver.

And tglx point out that:

  If we actually look at the call sites of
  devm_request_threaded_irq() then the vast majority of them print more or
  less lousy error messages. A quick grep/sed/awk/sort/uniq revealed

     519 messages total (there are probably more)

     352 unique messages

     323 unique messages after lower casing

         Those 323 are mostly just variants of the same patterns with
         slight modifications in formatting and information provided.

     186 of these messages do not deliver any useful information,
         e.g. "no irq", "

     The most useful one of all is: "could request wakeup irq: %d"

  So there is certainly an argument to be made that this particular
  function should print a well formatted and informative error message.

  It's not a general allocator like kmalloc(). It's specialized and in the
  vast majority of cases failing to request the interrupt causes the
  device probe to fail. So having proper and consistent information why
  the device cannot be used _is_ useful.

Let's use devm_request_threaded_irq_emsg(), which ensure that all error
handling branches print error information. In this way, when this function
fails, the upper-layer functions can directly return an error code without
missing debugging information. Otherwise, the error message will be
printed redundantly or missing.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/broadcom/brcmstb_thermal.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 72d1dbe60b8f..b922f8278f62 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -349,14 +349,12 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq >= 0) {
-		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-						brcmstb_tmon_irq_thread,
-						IRQF_ONESHOT,
-						DRV_NAME, priv);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "could not request IRQ: %d\n", ret);
+		ret = devm_request_threaded_irq_emsg(&pdev->dev, irq, NULL,
+						     brcmstb_tmon_irq_thread,
+						     IRQF_ONESHOT,
+						     DRV_NAME, priv, NULL);
+		if (ret < 0)
 			return ret;
-		}
 	}
 
 	dev_info(&pdev->dev, "registered AVS TMON of-sensor driver\n");
-- 
2.39.0

