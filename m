Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EB372E232
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242301AbjFMLus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242257AbjFMLug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:50:36 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2120.outbound.protection.outlook.com [40.107.255.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC44BE47;
        Tue, 13 Jun 2023 04:50:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPGnaglkTyMb9ANyv9A+jPzN2jX0vhkkTwUjosuf+aH1Sm9PR0kMaY1L7z7gI9SyLs+zWkZu23LpT7+q8j+kYshMjDdHlfWe9VJ1l7kajM6kPdKs0Kyu5MYJ4rdcKf6VFDBIJqx1RvjG40lb6VZxhtzN7RlvnTfJs2pVk40lTjxJBOYyTKAqPtze5r6aioWyFofU7cbr3ohF4juZdT4WTO1u/oM1htDvEmij/kDx88lrQddJ2Zxrjk5X8Lx5LFbYoN4sRuHR16tuSuJjs7aXZmaHs+5/S7FmHHWD3mga24Y2j0Is2yzH+02Iyg77FN60/A8jCotohZ6vjfu3hjPVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MIJeHIAZZfXJqZUnLCI8QVcKNIxIIiXPANVgZtGEcM=;
 b=gPZYZz7D13plYdX7dttMjk3PgjVlG+YH4J6OOwH9wyj+J3UfmJ8Mh+F9ZdcHS/5SDFGk39wvhwF/mBaUbADLga4/LJPOTJhzZVV+A/vg8/wiWDvYOop75lQ2QO4AJBR2h9wabU0YkAnlOwyk0u9QOzn+eqXDNchEoLA/V38jyX37WRDXBivJ0J31epxq1I8lORoBICrcEBSVtdWx13TJBROFJrtSkgfS5l3vUzikgK5c/B7rzi/n5UmNCvKxGIy1a02Ba0B33/oRZy+S3a0fffhwuEpMNIQ4OEf7kuyiSM0d0ro3AfzMDPifKIPrlpw1WhKmdFzCmMyPNN2odpmWwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MIJeHIAZZfXJqZUnLCI8QVcKNIxIIiXPANVgZtGEcM=;
 b=OcfbgD7zyTUo68FyCLO+HiiFsA6O1CearxYd+4yZhr0hXmQ2mqNpIkiM/HgDFwFabvoT8O7/6jShmSp2nL47PuWhHqzKnpoYLx3cFomD9l7H6tN7MG3dnLxJQcEfbQ+8Lkrxv94iHL16r7f9jiqxOgaOZ5p/Gc8cc+W1UIr+FzwIPepaUYVCUikwN0IS6s3SnEldaVHoLNMoQC/wspyeZhPJh5YhNSyj+CBWYRLK1Q6lEZQmPgXs2lxHyQWQE2K0kvIkWWy+yMf/iDDBrcqU1jcVTrB+o0CgxcHKW4CU6PX2spX9IGEs0eUzEKTcw6IfhaWL7TTYRYYu6OekkjOCsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by JH0PR06MB6416.apcprd06.prod.outlook.com (2603:1096:990:d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 11:50:18 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 11:50:17 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     glaroque@baylibre.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, thara.gopinath@gmail.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        anarsoul@gmail.com, tiny.windzz@gmail.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        edubezval@gmail.com, j-keerthy@ti.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, bchihi@baylibre.com,
        niklas.soderlund+renesas@ragnatech.se, wenst@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v3 11/12] thermal/drivers/generic-adc: Register thermal zones as hwmon sensors
Date:   Tue, 13 Jun 2023 19:49:03 +0800
Message-Id: <20230613114904.15749-11-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230613114904.15749-1-frank.li@vivo.com>
References: <20230613114904.15749-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|JH0PR06MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f8d20f0-8476-4135-51de-08db6c045b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZaQ4oDwCEe3OIlaHOOfj2WTXT9UZkSK/IOx4DXZKYLtH2nBVUAPwtjCLnDntWFOlRFcPHPO1Po5n2Fdk9Y8UvWu50maEY7bGwm77ZFhKyFX4mSQZgbtNN8+IqlwkyzEUFgj12e/RP9vyiGPJcZlvTDV/SLcoDBCl5Sd0hXh9YdcwlTXVR6ZHr35QgN8Owy89pbBMHa+/w3ow8tUZaTU1SvLDS/uXnQaWdn1nTJ/4qny7Qhf0zMD6vlH4S3Qx/7SRZj9Z3yltPirVSiLICfhZypjBlc7GITckKMfkH/J9qjgH0KKjY0qQSi6y6hHYVefl3CIrxAaQc5D5tsiqp262xTB+uZDX/t98cMjN6bftfwipldVh1j2IbZHMYRHgQ3YTYNtvNEEMQqz+wMdco4UnPSQDXKJBzAjtPEWoOD2kSZmSKxffEKvzpaez4YQEjnbWJXGExzbUmdVcEc2uAQ+UdXM88qIe8aEGDv5dl1F6XQFlAitiN+F8nw2wClsWs4USsFBM655AxIn8vzO5iEBIE7L8N/MrAHzMNaWJB5YtT5vhrsKI6S+swHisoJmxexllHGimlj+XQxxWdAHoyl03kY75ZkUR3OljkO8EbZfiE1+8Etj92elpY/uHRIq+MTGJbPzs1z8BHzOjripByzOyuKrZVzJfTTuQNYwsj6y/jE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(36756003)(2906002)(5660300002)(86362001)(7406005)(7416002)(38100700002)(52116002)(6666004)(6486002)(1076003)(6506007)(186003)(6512007)(26005)(107886003)(478600001)(921005)(316002)(41300700001)(66556008)(66476007)(66946007)(4326008)(8936002)(8676002)(38350700002)(2616005)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a5V34HLvUWEVeM/gkYrV+RzQhBgEqt+aKtEaGr6iPcRb3gwmQcBeYWV4HsKq?=
 =?us-ascii?Q?ibEWJD0wOccnXahUy0fjXOuHKX58wbBv8xGqsu5+qQDvp20X8bLffnzSBKV/?=
 =?us-ascii?Q?Yr6XDb/FlGjZoMj3CVG+dqqraTjwOttVnUuKod4dr3PtsIPUNAySoRfb1FoU?=
 =?us-ascii?Q?fgTVRamUU9E7TCVAV5BnSUAC1d1+n8uG5+SXZYdJBPSryQsmKJD6nlMYQtfN?=
 =?us-ascii?Q?1rOfS4CKSa3S3VzAxJ2V/ZWGbl9V6WPnUvfQ0c6znYLlDyn+2ja7bFMV3bW1?=
 =?us-ascii?Q?R7JJd0eH7v2Z7yfGh8DdZqX3KolDPueS6WEBjvk80VQTrpIncV4yJdxpX9RX?=
 =?us-ascii?Q?uTP7+uy5FPuEGO4ZMIrAVcueFKhprNaXKGIaaurlz0N7nuRzX79Lt2WyTQ2a?=
 =?us-ascii?Q?Q4cv20svOyFk0SqXRG+jPvzBtv11F52bjV86mREfevCIY4xXU0GvgHjRW3eb?=
 =?us-ascii?Q?Jnsgcf0KF1qZw3cqD9rb+4XJO1bUkw3/Mb/8DTNQSn8t+kqWuBUzyoQCZGG1?=
 =?us-ascii?Q?MTZRVslHHd1iFCSLkOh5cr3hrfwrJ4YmbuLzie9rtitfF2esYl5Q96/LIXQ0?=
 =?us-ascii?Q?eyacTHg0Faq0X+wyuBn5wLnZZVFAB4cs9Ia8+ahUX0y07r+yEplIcRpn0O2H?=
 =?us-ascii?Q?aBu+rp9FQzGSV4t2WWISEpMS3C+sJhiESPwIvPkQm4TWOZz2ztxxZWeTgmOi?=
 =?us-ascii?Q?X05GAPYQePSBeFi2lEOioO2kKqBSkSEsS6Gg1W1wfAjrPJUNSpF4q59diJ2M?=
 =?us-ascii?Q?Ld73zp//L4Ie+Y4z8JBMKCmUIWNk7ucJ6VX/r1/FRS8o6qLY0N9FHpRoQCr+?=
 =?us-ascii?Q?8C35kke+I3lj6XmfwVKvLxscFJjZCNa6DupVBQI7oMWo5HAmrbXnnTNePq0f?=
 =?us-ascii?Q?ulRtPzG5QEmI+jBCGTrIpwvCiuKif3uUBCnaelt9Cs32eDekRvKCwdgX9kCK?=
 =?us-ascii?Q?Jtc3z+AYpQflarYIeUciS+S3cLB2ADFv31sV+Y21yLYeB8EhHihnX5CEf0/K?=
 =?us-ascii?Q?fSFVlEEveFK8JquZcfGK0U28UfF/BiLMWYOTKEfA3Hr3D9MdMFbA0QLM8yMa?=
 =?us-ascii?Q?7DJMENAa5JIu9MC1FLkzdBnGqjDgZLpyY9RxkBjYAj3+XKfu9xKwMp7EZu6E?=
 =?us-ascii?Q?5gg3R7c46+La2vSr1rkuIi+QO9fXPAh54OxOObxCAFVXN6osHFcuz8o+6kL2?=
 =?us-ascii?Q?Vm4U3pudJfrDxvWcvaARbcbIDyc3M+QE3t+vE1WGmDc64ovYU97ixUDxuWLR?=
 =?us-ascii?Q?YK4kSl2sdORCuGWhq6IY66zfpOBIFeQNaHccgCWn0oejkdEm4tKzoBW3UwHr?=
 =?us-ascii?Q?/DG0hlK396cbhoZ67h1AgWyTpkAMmDP9Jx8jq8NF8A5GvvinWUia1FpuFUNi?=
 =?us-ascii?Q?AjOIFhyIhGiSAz/G/aMoM21eepGY3/G5rCoq24CmMrsjNaI2EKXi3dwdLLmf?=
 =?us-ascii?Q?p/hzcvWhMRf0639pwimYg0VUY0hJDUbjBRDkzgGGivEg2fZaHLFiwHrUXHRn?=
 =?us-ascii?Q?e+sKVzvaESW+vQkdwKmDzmXFwoNztudPwvoXTX4IV+Sa7ypTGr75thtBudTD?=
 =?us-ascii?Q?eDe1R6DFUyrebCxrpSB1nWlT4xPUaAxJhdbIN268?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8d20f0-8476-4135-51de-08db6c045b3d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:50:17.1148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxtVkAGwvuJ44knJxC+rT/WrwUQQ+3NbYiqUF4hnf4/L/yNpskODuVVbm/o04MS6xGLU9xGawBEDPpnPoaIi7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6416
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wenst@chromium.org>

Register thermal zones as hwmon sensors to let userspace read
temperatures using standard hwmon interface.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
[Yangtao change to use dev_warn and remove return]
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/thermal-generic-adc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index 017b0ce52122..9531bc2f2ce7 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -13,6 +13,8 @@
 #include <linux/slab.h>
 #include <linux/thermal.h>
 
+#include "thermal_hwmon.h"
+
 struct gadc_thermal_info {
 	struct device *dev;
 	struct thermal_zone_device *tz_dev;
@@ -153,6 +155,9 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (devm_thermal_add_hwmon_sysfs(&pdev->dev, gti->tz_dev))
+		dev_warn(&pdev->dev, "Failed to add hwmon sysfs attributes\n");
+
 	return 0;
 }
 
-- 
2.39.0

