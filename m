Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD2272E172
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241998AbjFMLZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240319AbjFMLZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:25:13 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2100.outbound.protection.outlook.com [40.107.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E399DD1;
        Tue, 13 Jun 2023 04:25:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VICfmkJo++DKzQ6n6BT3qmKVzvdz5tDb+eS3m8J5OZsDlbK6njxLaOyb7vCSvuwE/j1Qc6qdfYsqHmMK9NfaHvOk9ywk43gpsmr2t6BBSJhXxasq27GAGO7zZQ10DSQsxfX41zUS1nT5tv4N3L1Zzs1fNF3mmQhkwkNGi44tu1+MGC7lGBy5CY8Usyc0A3pzuC7K/YnDdTZt+UH/A77YjwDUAHUMcSp9EFZyNYIa3PjPbvz9sEwApxq6isMXhUxvz8HeHCJtVu1xTEi8i6euxzTW5MRmkTN5pt/Fge1+fQhudeu/kV8llZpvWSmL+Cewn3854rw+wQBiEke22IqRFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdh5vOmUeNsam3N24Vb/ae/KnRPNs/UXo0w5JAbpOlA=;
 b=bIjjDc0sLa8z2dCi4Tvtt2+a1mCeXy13AthKWDNqSlDWK8jGydoQ9O3Tw1czN+iq+LAkRptS6dAGLB9TREbUQDUIOvm3qzPjDG+8+/90p0Bz5xgUaHabv5zVUsCL2uZsCGutjNBM2gCVF23csBIUQ0VfO1PLOSkTcUqwjTtGi+1Pq1Rxh4JboR6/8iBYR/CoTZN3BIceFquuQM3Dxn4Bn78+tAKmOEqiO4gvlNM5Idq9Hc5c+lHIzq7k+/J/Vdd/NcGP23S0ggA14p8k2/sTCq6g3RAnxGky2ISv9PpDIB/JB6qND+dgEe+GICd05iEndjd9d+RhiArF8AQJdr1XmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdh5vOmUeNsam3N24Vb/ae/KnRPNs/UXo0w5JAbpOlA=;
 b=PFkg8UwcWkAIzCgTNgGHOVFjEgGqrFwz51JtsZ1+OVfmf3xF1TwxreWkowIkVzvJ1Gdu2Es0mRG23IkpzIeNXSShvKNBvJ5yYdDsDj7KCbuiQMMZykzxMupcyn5zRcYvcYk2IegW+NRGZywH0a+1Zuhw92VG2duhsWpPB2enPKqsFPPnLnH13K9vb6wDfKgMJMmk30YZIeqjvq3Ux9AnU63tCwaCMsgTuA674ZzG1mRI5jp2rrm0FwCaLzUKDPproe5y3EPTSw6njQtBsgCe8zYbEzUDr8sRf4s7V6fs66ZAPhmIalnuM3oKPpZDAbgmD3oO7tTHszOhB5j8pKoJmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5920.apcprd06.prod.outlook.com (2603:1096:101:f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 11:25:05 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 11:25:05 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     glaroque@baylibre.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        thara.gopinath@gmail.com, anarsoul@gmail.com,
        tiny.windzz@gmail.com, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, edubezval@gmail.com, j-keerthy@ti.com,
        f.fainelli@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2 01/11] thermal/hwmon: Add error information printing for devm_thermal_add_hwmon_sysfs()
Date:   Tue, 13 Jun 2023 19:24:34 +0800
Message-Id: <20230613112444.48042-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e17ee7-8bf2-4478-54ce-08db6c00d5da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9wGME2FKpnULZJq+12pK6X+LK/p3rpDwE5SdkgiDxWepxFphwBX1yitOD9QIhIO4VpaYdgviMQaze6N9JNHpnlaCXll5krc27VV5WwOnTLFwA3krpoyw55HClhkIEeDsESqeji4o8cF74s062xNEcfJxZZ7V+vDKHgb2s8qSRUCZ+L1rY5Meh/STGSY30SMMuNCDDea0rLzaQugnHbgYdaFspWrzX9DTExpy0JYTeTSOG4ZejDppD1XQ+Zby9RzhsJ9sVgPXpAdzBCPn7JmoO8v2dLnX3rgPet3+YhNwEKIlfIgUpEC9cyT/iyEQst8jSCE85hhv+W7GhxDIm9tqmcI+9P7faxmJwcKd3HnJbRSXh8XBwyHITFNFmvR94CYQE0Drr55n+AbBr3myefn0FSXUNo3mchZKGqnXFNqfLDbXyPa3msQ8A+CrUKCYzQOA8M78JgVueys81xIlrWJcduQrgVjFdoFWZhcvOuXvCGXdw0t2VcuTrf8ZBmLDqpvbz2KjtkwNqjSLNlcALkR9yURptSRyugFgtF+3xZqXA5IhNI4BFfSPfRsEGlnrjbYjNi//gvSDm3afGV+D+aDSd8/eHNYqKPLpwsXk4VZg+kUB4Op746Orvtm/Dq8hKSnxJ0itpZh52MtHqrqhTYm8LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(66476007)(38100700002)(66556008)(66946007)(921005)(2616005)(6512007)(26005)(6486002)(6506007)(478600001)(52116002)(6666004)(36756003)(107886003)(86362001)(316002)(1076003)(4326008)(38350700002)(186003)(5660300002)(8936002)(2906002)(7416002)(7406005)(83380400001)(8676002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HUUwZWnnDUXr8cGVK8Xj9uZwmJdF39/oEsnAQWvYP7ZJwzDQqUr3jYVogWC3?=
 =?us-ascii?Q?2kNrEa1cpQ58k1jBWG5p9c1RahzEcaNBVcIpDZ5hp0CM7r0JRlJkJ3B0UdGk?=
 =?us-ascii?Q?eT6sCGst+InIWtsLZpvSHOm1uVUP2ntespWMz/dY+vhN3r3F0yea2X8pYTbY?=
 =?us-ascii?Q?Mw+QtHMGdk4wGlt7LSKEuMlrpTRWdFeX6Dy+dAea0j/rK3FidgLbmP2x8x01?=
 =?us-ascii?Q?z/kQcVXFmC8E2YC5FNE/gCG9VQRAkHhRzRKkUXu6gCNH/nILNcxMcyBItQnI?=
 =?us-ascii?Q?nmPUlmnR8F6UkJpeUQxSfXXqfaBg18Aux44giusrSujXtcLG9MnUjQbnCgH6?=
 =?us-ascii?Q?AAMycnjXCc5Kc1w3YkW3XLTZNQSZwWULAnsBOlg2oZMt7R9ppXmE+i4v7Cvj?=
 =?us-ascii?Q?6vD6uDsYGCKg4tzTPfz1KiiVoZBrcUYeKl0k/43Sje4iJLb91zWo812k+QDl?=
 =?us-ascii?Q?snL8TKH/kmZGmmVkeTue4BhYF+ExdWmAOTRan3VS0i6B2IVHhCZiJb3MqHG1?=
 =?us-ascii?Q?zIyDRUS8Y9lZun9a4CCeBvR74ngckJdhfs9Bk55GF4gEXKcD01wh2xNF8vYb?=
 =?us-ascii?Q?WL3ZIagRSi3TjzbLOK3vdzJwPYjpP1k4uDKkX28yQYd+0aAB3tzUWNDT5GUa?=
 =?us-ascii?Q?CcYWE+R1hfXhbcp5qHJLCp4aQ78Gl7iG90xMbkm3WAXc4agaSdSMXNVMfysm?=
 =?us-ascii?Q?lnxJKgIUZ0hsdECFFCje106YjSErNcV4Ov/cyDrc+3gK48sn2KA3mwiCGcuP?=
 =?us-ascii?Q?ZdtC7gKdgWPjNKSm+viQTxMYXmUycJdobmJX6k/vG5zpEiAgPPbA11Vk3rkr?=
 =?us-ascii?Q?3ftwrYAd9qUlUObDFB+w/y05N7XbhEty5I8jKFZfGgZ7BRY8Q4kHUZCRy3u1?=
 =?us-ascii?Q?91HnyMNffz6Z9eo/wgcmschRRsplOGUILsGo/V7BgvkrS9TLmyIUTxTWM3H+?=
 =?us-ascii?Q?6ixH5x4tyJzFtXo2wISaO8fqKqp9cE1A78UWJIwDQJ/aCR3OMaNe9aUa/Eh+?=
 =?us-ascii?Q?7qRgZ2+jO5Hg9XWmi/6Pt3ewL7Rq7Uwh3D5uJ1klAB9W8WXmERVO6MBCul9L?=
 =?us-ascii?Q?vRgRyVuuhg8HjF2mr7iLbq3KpIyYPRNdBi3pau/VWB2ycJkOclQGhQkqLmOy?=
 =?us-ascii?Q?1l3wJVUI3wA3LxyOj171G9y0+rilw52+lSXPrDQZXk9qdKkXAaFOklV1y0Q3?=
 =?us-ascii?Q?+0m5G3epP1wl5PmMznYPZhGTkjaCpp8VnnAkzcKnqD8SMoJF341kvToTTtnc?=
 =?us-ascii?Q?NV284z6cTQSOrlAH5K1V9pwVAC/tx3YY842Pn7Fb2rOHREtgz+apG9Kwzh0H?=
 =?us-ascii?Q?kCbQuv3X9rPpjSMX48AcoLbjxXilZka4JbwnruNP5O1QKi6ktiY6Fv28CBsP?=
 =?us-ascii?Q?9p/D2Y2ZSq/uCQQ5H+onkSKiREcJURRyMtN6dk5BnROWiCRFev69jEGC4WhG?=
 =?us-ascii?Q?gZli2piNwUyVCg1s3iKgunaaBnschPsVuwVT9NEAD9B9gRX+rY8PSGUyLtrp?=
 =?us-ascii?Q?OaXDlGYJTTKEBk6Zu0Q9iihmSI/IfS6r2mD/Pg+mR0+Vz12U2aiWqQt7wu+p?=
 =?us-ascii?Q?oN4yELNw+knNcudZxcJZfRWuXNh2/KQRZTboDwWm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e17ee7-8bf2-4478-54ce-08db6c00d5da
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:25:04.9478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wXoQaLmCv4dvz9uq9/fnEXhtHg04aIys8P5LEDG+yeCAKE6YUIOu4zZNzFgJHgLo+6T6k0QQh/7G5H7FmuB9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5920
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that all error handling branches print error information. In this
way, when this function fails, the upper-layer functions can directly
return an error code without missing debugging information. Otherwise,
the error message will be printed redundantly or missing.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2:
-convert to dev_warn
 drivers/thermal/thermal_hwmon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index fbe55509e307..c3ae44659b81 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -271,11 +271,14 @@ int devm_thermal_add_hwmon_sysfs(struct device *dev, struct thermal_zone_device
 
 	ptr = devres_alloc(devm_thermal_hwmon_release, sizeof(*ptr),
 			   GFP_KERNEL);
-	if (!ptr)
+	if (!ptr) {
+		dev_warn(dev, "Failed to allocate device resource data\n");
 		return -ENOMEM;
+	}
 
 	ret = thermal_add_hwmon_sysfs(tz);
 	if (ret) {
+		dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
 		devres_free(ptr);
 		return ret;
 	}
-- 
2.39.0

