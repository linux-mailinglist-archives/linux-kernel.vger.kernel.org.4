Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A70B72E1A3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242203AbjFML1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241352AbjFML1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:27:21 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3834F1;
        Tue, 13 Jun 2023 04:26:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kt0o51Vo8yaJOjDd1Tnl94aZiMn6DeyVf+kfeVBvH/SsTieN9/jr61rkzwzWzeVxAVHffNQ9w/96GxsNLpKyibpqZFF6EcO60pT1dvi/xY7FtYl78y+aE0t38ao40Vix5rWpDlU7ZiqiftjAqqESOkbyoJQ7mdRMHHQLFz4GMuasiptBkVvaiNpj9NMS8lDVK+6FOvGRrVv4ZskO0Eguaerynnxjisd4yr/IVglTHN6j8L2tGtoQJggotzPWAulWxdFJTt7b2vOe7R7kE1ey8hKbgYVrojvSV11MuNpYhlPLru4Cnrv45x/qoYBSJ5TzjGcBggA1SM9+C1u5We6ESQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25yS9m4vQlfv/fnahWmrmdpCB3WkBhgEYTx2ZWk8iKw=;
 b=AR3u/cMZqdCHlrcsi4zehR5HNZ/S51ubuRlxMB69b89iNuU43kVSgP3wAcLs8oHxK/gayhNL8AaD/w8v6GmqDYKjQTJT+i5CicUWSJqQLn1cD4yW243F+iaaatEzXtrYDcvwJ3Ov1Yh5NRDdhRC4f65mX259SqQbBm3M2wKnZDH6wHGyro5iT8vCDnt6kCB3l+ys+OjDiS/j2sbexSgvqrfHnZmu+D8G0STmjBrxAHpvGBQ5w4Itmzc4QlsXHaJzIr8iIXgTxty/f6a29ShIpdpQYWDdiKnsglo3i4hmjxxfNr7TxtqftC4pR+esSnNe8t3mXD7SfofoJk+1hosxMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25yS9m4vQlfv/fnahWmrmdpCB3WkBhgEYTx2ZWk8iKw=;
 b=JxHNbXKZOPmPiXMevcdke9IJdEwGo38YYEFulOnifQXqDKMvz7ldOmgKlZOfcDTEoq4t6np04kwbz29UTLAiPtQKwhqIalStrT6KU5G+pBXeLn+H76lxZgxoh1KaBe4YYdPcPeu8v2jbZiriz4G4qF476TqYmYg9JAM35QnIxEpTZ+E8szBeFSAQRyXJwAPOpRrZkD+3qJ9y6UIErX2ZX98S44s7Mf0Ba8kyzLtfpCODm6vrsSahdzFUGbbBzkkgUt9XPHmFlbB8cRBSFKA8ddycvyUlX3IsHIf651s5IxmdTy6TNyfwbqFrjbrMOyQfXtxp0YIW/P5jRilWybvJ4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYSPR06MB6793.apcprd06.prod.outlook.com (2603:1096:400:473::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 11:26:24 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 11:26:24 +0000
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
        Chen-Yu Tsai <wenst@chromium.org>,
        Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2 10/11] thermal/drivers/generic-adc: Register thermal zones as hwmon sensors
Date:   Tue, 13 Jun 2023 19:24:43 +0800
Message-Id: <20230613112444.48042-10-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230613112444.48042-1-frank.li@vivo.com>
References: <20230613112444.48042-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYSPR06MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: da8fcf9b-7e35-44fd-fe5d-08db6c010554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OYWBchiGvDMWjveKsx9fbHr5MdiIFPgstqEXjqW+oqC1JOqAn4JNvG0Xu0k2Lo0zG9DUv5P0X0Hb4/7LSmJB8B9p85VgcG63GwmKur6wwGaZFOEkOjuS/suIIirnXzhpagBfRw/g4N9s21RJUb17hTmmbP1w/NNq624ONt+Vu1nST+e3Svcn9r0XOCVA8ioJa2FxhlfJe/SYGaFHu468enzDajWXqVkqVfOSfmqUqQy1b8804EysvzTuo8wFe5is1VQlfacdY3DN7zWksPIM4/qh/hSp6URqM8/UocxjLAJ9RDRPD4Np1EFUpjLL4Q7c54LBazpROZV7qnK9HbR/Y4e+4p1Qqxwr7ftv0hd0DPQJan8Jdd8rcx8mqplGl/C2xYCIPSQf18Vuxc0AZtLDfE5ZHmPZWXb5mLMlfBydlBY/vqPYAXRuW4rNbCUxkm9j19DDngCpesWG/0XHVfCurVZrO7LsvR0DRq3EymL6Jf+DKoWfXNVE7B8EARP8HJL4czK9Dqaa8V1RdERVNqjcd5B43p1UMDZ65FUrsBeIwgIt71EzHWL6os1eHvRv496LEdPOHH8Oq2mTQPFzexVNi6JPEpyyOhzxB2Tlb33usbwFtAtT7DpY2F1OQ5uRzPfuh7m3fFgow7wFxFk7e90zRFQ81qdH+YbuebtRjiV55sU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199021)(921005)(6666004)(6486002)(38350700002)(38100700002)(52116002)(107886003)(2616005)(6506007)(26005)(186003)(6512007)(1076003)(36756003)(478600001)(316002)(41300700001)(66556008)(66946007)(66476007)(4326008)(7406005)(7416002)(86362001)(2906002)(8676002)(5660300002)(54906003)(8936002)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JxW7xoHeDQCrwtMqsWVea1o/F8tTFLnIuv2GnikqJBr6+YoBiIRi3ITIg0zm?=
 =?us-ascii?Q?rzXETj3ETfB2T5ardwFHtwBtjkInLDmYq1SUyDxJaQeV8pcnJOUO8t8JFfHK?=
 =?us-ascii?Q?jLkoPMkYcx1f7IVFVONWb0X+UqCcXIGWvV8KvnAkV/lz+G+nEG3DKlinOPPY?=
 =?us-ascii?Q?GnIeZQZibqhRDahQOtdYH9NEkDCHguNDQbx/dj1LSX5yHw/O111fYLFcZ63z?=
 =?us-ascii?Q?Nk56LpmxOPxE3e0wpqFcUti9SYCg3x9Bb+hl8aogXHDljZNcURdNtKy8p2yn?=
 =?us-ascii?Q?5aueSsyS9r/kl9iahmg/MKmJ+dD4T+GqAkseHnarNMNq5Bl/KZD5tT0rxpTW?=
 =?us-ascii?Q?nD8wV4T0pK8ZAfiG8juAtELgCnUOrHApEa90f6QOHYXmlxiU6e/9e2rU3sDX?=
 =?us-ascii?Q?e2BPU5QvIwC5BNCOsM1tZ4jug4SESSihKW6DtYeFWi/gBI82sfF77OU6d27R?=
 =?us-ascii?Q?fWlqlfT9+7XGvu/+nehATHWFZoxXk401GH1YKRqaPmoMrzpMCWuSAxYmgm/q?=
 =?us-ascii?Q?iFcXFu+s8+ZMkR81HeaqpSHfoL9DLmrrxAa37pqLiJNr4xvEnCD5GCBhzWi/?=
 =?us-ascii?Q?kvFwpG7erwcSAXTCVu+yd4LJpwkfKoYPuyavw6GmFr/gtbC6MlF9z2UxqOuI?=
 =?us-ascii?Q?lCAdev4UKXMQduoWp2R5xdQppvGWZYX0M4/lGCvln04cWSbJ853yZ2e+Ofhy?=
 =?us-ascii?Q?CwfL1YgrhrmZ0Af/L0IRDhp/cMLW98zrALrgvps/ylrQVoWd8ivoFhbRx9qk?=
 =?us-ascii?Q?MqJju66J7yPs5vXId5BJLk4+XpH3C5bpH0tLNTlfo4ZJlLZWUytLRllXucTZ?=
 =?us-ascii?Q?Cle/qJY2wv3oiXhdl1/JjI48+BaD/REwEw6kcXSGsUMFVyaeHDJ/4cfZ3T1c?=
 =?us-ascii?Q?Qi8b8t1l24C0sgp3T/5WZvvXL7e7mg6I8ZgfyTuMOeSIQNnhSS0Lbqfgdv3o?=
 =?us-ascii?Q?prFFGuUFs7PNa80dPMmhWLqmd64n06aJDl+rl4es2WTUJVxOFzNmvp3EgEmk?=
 =?us-ascii?Q?EwR06hIZDDka+M8NnVrVqla4nW8woomq6pHQZil7y6BLCPdOf+UaqDciULMj?=
 =?us-ascii?Q?Q+VDypWfv/gJ9U3GLH0gMOhEA7sPij82+P7mxB+xro4vVktSN7TcsNkhnf+A?=
 =?us-ascii?Q?mRbfNL12exMItYwA9xUtPafPfnJT9XF8K9W+jAn3qG8L6QaCQMcskLKew84Z?=
 =?us-ascii?Q?MwmglgLrlvSXW2fRtsSjl6ICANLgRNRZAXEp2XGOYMJJZMNfZ13Dh5hbBxOA?=
 =?us-ascii?Q?hTvhqZZWiWeYJCWqR3+VSFvg5lD9hVm7OnMCg8v8CV8E4RQLR2O6lBQ9zKRG?=
 =?us-ascii?Q?m6CKMfTnobzy0S+fb1zflvDfib7UKNCFJIW4CVuDwKfTBmPEqxOdfCPSQYL1?=
 =?us-ascii?Q?eND5gq/PS4EJ+ShKebHvnDjYD9Lrob3g0GmAhEz392ZYLXOaKDn4TxzBCteW?=
 =?us-ascii?Q?5I9X3VqJyYspdX71nnGwEEPGiGZ38KxB8je7l+Gw8OaFjO540+McEhLZe0dm?=
 =?us-ascii?Q?SwAqxc7XJ4jGg4HZt19JgzghFeDd+syrru2SXgyb8kN1gP0vBR9xDVOy+/bI?=
 =?us-ascii?Q?rYOY535+dM3rFMJBhrMRG1b1XDLzpw2o014UXOpK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8fcf9b-7e35-44fd-fe5d-08db6c010554
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:26:24.5464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYxpif6TxD/7WjbmuBmMMOTdzY5ASH7uT7PMrpqOy+28KsnCmrnnWN7hxEFF2a0ViZ5SS9ZgM46TIbuUjeHfxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6793
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
[Yangtao change to use dev_warn]
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/thermal-generic-adc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index 017b0ce52122..e7a82d5cabdb 100644
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
@@ -153,6 +155,12 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = devm_thermal_add_hwmon_sysfs(&pdev->dev, gti->tz_dev);
+	if (ret) {
+		dev_warn(&pdev->dev, "Failed to add hwmon sysfs attributes\n");
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.39.0

