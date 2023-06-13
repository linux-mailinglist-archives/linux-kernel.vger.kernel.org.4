Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAEA72DE9C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241851AbjFMJ7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242061AbjFMJ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:58:55 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2093.outbound.protection.outlook.com [40.107.255.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964F410D9;
        Tue, 13 Jun 2023 02:58:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMl88LLGO+VkFA/LSEsI/1tXRg/rvu+fJ5QZlHJLYjFNqC2oa2Tz4dIPS1++joSQ8mfZC/1Ze1pkhran9Yo6UOzJ+tpr5g8h8vOyJKWgGA2OOBVmvvh0+MDr46uNcfLFNxzRvbp15cRjrk+5rm3enAR34KiNv//hMXZl5CRFIbcdFCXsKSoI7F9h2YDZ4puk0YvTc0fYXQCMxOngQeGgsxk2bsL2EHwwU4OsK72i1yO4S3qBzEuqCnrVMRx1+LBBCvihYZc9/GT51eCqcp1H5rprQZ+aNnOSvdWSztMgLbXERjXFFJv5pDUlcaJ4ETaW1P2/e/PVTt5V58b6JwCppA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tl2KpQYH7ric5OuONMrc2MSFADsGf5tu1y8+Hn5mUS0=;
 b=Lz9ra8pXf/BNe/rxnu13p/GjSpNNALAaDWdPRYTvNCItQSijm407rGZszQgfKaDLosevaf3n5D4PxcGAYAn0mXxVT9GCCGpLjzupFSKzwrLbMnl4bucJDhWgpvZD63SptgSLf89tzDjP0HTU+J3CEMq6cTu6HJxrVXLRTZhH8ZHpeqtbuhuWwyFlNse8uo5PhxB7mi7sZylyn+yXktKaDqJDs0xL5RmLp36J94F1h62fykLjttG168LPUGEywyLrQuzxjPpImHci9ozEaqoIvzYavUZhBAQPkvfFRTPE74gpeM6XtHvrKDThdo3sba+TmfY3vOslyEASkpMhM+DMzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tl2KpQYH7ric5OuONMrc2MSFADsGf5tu1y8+Hn5mUS0=;
 b=kUqZnjTvYVCK55xH3h13VQimbZQoUvlTPHYfU3wOZHcAVB8OvDpL7Yhc0GH/urkhR0C8svOEbnezn/ayAhPa5u7cRNvPIC3eWT+TpVNYb2VcBNqR7C0v7kX1kpqW18iTTrFZeLLfV/FrmzSG4bPtEfHL4f2X4yFRqy1omHEUHyeIDtuaeC0RbLHST3bc3Yt3Q1vGibbGIB9bridj/ypDv3MReip7JR3cleMIg5m4wUe8u6CweHJqsbRxh9jsiAHp3sbdEuqy7CZ+bTymN7SCHKCPmfPHExu8exRXNMe2T+oPq6fjyFo99UPqAmQnPHTak0CBWUSCoWY3sy9ZJV1P4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5784.apcprd06.prod.outlook.com (2603:1096:400:268::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 09:57:32 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 09:57:32 +0000
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
        Yangtao Li <frank.li@vivo.com>
Subject: [RESEND 9/9] thermal/drivers/qcom: remove redundant msg
Date:   Tue, 13 Jun 2023 17:56:24 +0800
Message-Id: <20230613095624.78789-9-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: e7a96475-04b6-46ae-2b5f-08db6bf49adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YH1gcID4KzpBHmfLrw/53c3yNWpGG7NxfTYjWNXdmbZuhEGXrlArXSJeNQJVHR36QI64Ln79q+7RgoERqwtHcvmqJKVcESMXLbKJTvjo8pDodnI249HEGHrLzytq287yJcgsBXrK9zmwxzJsnq+JDmo2pnxjmrBPQoHjNMP33Xobyj4yg0cLh8E5GGiLTq900+BYov1qZ4bf0sP5Loh5a5w8db+sjz+zffBzD9ybrlVcf0gAruj4LkA+AoC/g53KuUg9H1rWaXr9rsnRy5xhCWjjks+dAOPjaEGo/WaRrOJZy/OutlxG+FjPXhT0uJmqIhadKJBUZs/I2eOwKFcc/lVU1DBky+DWIEvxVtvBA9VxoPnpVm9qbL+avnCLYrl8ed3wBgOTMQqmluyr2IzBO2LyLo3qDgKn2LAOKIUUrgXLlvxyYIVFbIEE/SCJqgtS46xmbYDwUa2ggLRRxTTq1Mk7QV4QBbF11V1Z01N7alUxV5it8KqEFOPIj/KOXGKKbCymTMrSof6IzN/Y9ljxGQY6b6TYg3pnxC4Y+D6JxFmN/4rutJtC8bc8JCFmNVOKmi2VJw5Dyf5ehzLWyvb5JuNbX0OuXb/vvCcnI3wbSNpIRBaMPY2J3DfM+KuI14Z6jg1Lbc+vsft+k9LngZ7/eA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(376002)(396003)(346002)(366004)(451199021)(6666004)(478600001)(52116002)(6486002)(6506007)(107886003)(6512007)(26005)(1076003)(36756003)(83380400001)(186003)(38100700002)(38350700002)(86362001)(2616005)(921005)(4326008)(66946007)(66476007)(66556008)(316002)(8936002)(8676002)(7416002)(7406005)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oI6nI3PanyH/QdikFe3oKr6ruy+9+rk97UP/xay6bI82BM4hKGqyuVISkewF?=
 =?us-ascii?Q?dSkHV5i2JpffwTh9vg5oh3olxs5X0opM+PNzC7t5YB533WCj3t/OmmS9Pv2A?=
 =?us-ascii?Q?dlVCs9aVgJ+CQ6gHTuqjnZyCJmunTcdc83y16dAtkh63JyGk5FjD3X7IsUms?=
 =?us-ascii?Q?+mD/JmN3lUy1c1srSPVi+udZJ4q/tFKqqdAWYIhcBp04U2ajYqasaIoLTpHd?=
 =?us-ascii?Q?zktrsROh0+IKyou86XxkFUcloS3ORjBNfG+D1a071W340qKEeAWS3VwjyNx9?=
 =?us-ascii?Q?GbAJI+MvTnXyBLSYkHhvl1J5joTrThvzBQ0jCmNrBmOk98ymIZACutbJ/gl5?=
 =?us-ascii?Q?S8fmfvcjAGnUKKLCeQ28WQcvgnM2hIvwt44ijYQdZ/4x9YL9DFxWI6TfhPiE?=
 =?us-ascii?Q?ZC5IrWgoBb8TomEu6WUJN+/wJN9D6QSz9SxyqPsgcNKpErtuhJCCJQdSMWSJ?=
 =?us-ascii?Q?oDFTI6SoBpzZ7W2NfpaDMLhFXdlbY2nqBEbpR+7XG2t7E3fbvEcYWoj9oStJ?=
 =?us-ascii?Q?CJ00T5g2bVj57OLpUPQOoxLtusOPAMCmQ8HonHXctMOuFOLAZk1EkK30n6eY?=
 =?us-ascii?Q?cTlik52/0SisWxx7UUzf4shXKrP2u86HXqwT99joEdY2JUcq+KGgXaOtvB2V?=
 =?us-ascii?Q?lhVTvp/0z06fD1snXauBsDx9Kwm3ZOOWyLDuMlkow3mnn2aOTZNRaEpoQWlC?=
 =?us-ascii?Q?Gzqmro8GLazeQXvNHTINgacexgWsqDawj1AknLeAQB65L6jjv9/MkSQuC9Uj?=
 =?us-ascii?Q?OWjGbDsJUNekyLdk3gBzM8QYQDjScN/tPxv53/FT0NIlsSi5Twf/uIt+ESs1?=
 =?us-ascii?Q?203rXchtSjpazBYtog7t7NsT+sVpR/CiquB+igKUtvIsyCs6C5Tynm+gXCXU?=
 =?us-ascii?Q?RTSG2H/bpJ7f3/DpEie5cXuuA1SuEntWZAyDyxuQiGoWHqOngOuKEDRjqfAQ?=
 =?us-ascii?Q?4GzpeCWxhukySFVjRFa+MaKHqkglxdr+ReIUK4pMZ7k9pcF2wGFrgJSc0QNV?=
 =?us-ascii?Q?ZK5xUy4TF2NczvUcMui1zbzqdK0DKUcdi9l3qfHVcNsHxNsM2Eya8iL5hPCd?=
 =?us-ascii?Q?TCQntXdMd1OF8B9Y1FWO+BFUUCiPN24LS8nNceqXm3BEGjsfzK6gP967nTE+?=
 =?us-ascii?Q?lsiy9iYSdBwA4AxDbWB6aAwlPh0/TISD0/OGS1RcVgD3dUQ2q7glHqFbvuIl?=
 =?us-ascii?Q?fbTBdyrQND3qb/TvzZNKSSo14JWraOBpEE4qMb+m+0Z4gnTbYIkJsrrAFvsN?=
 =?us-ascii?Q?rMKn32TmcYb20kLEyYb3T1BH9eoyDNUiikC3zdHCCblDnWsHKKW6eOAsHEm4?=
 =?us-ascii?Q?P4+9JCc4TmOHZQe+joJq2VOUerJTkJTIxDl+wykxfu+mkWqwXIPIPd60J0G6?=
 =?us-ascii?Q?30yvPfSGlEG8TBlgRQPe91BJ12iP1nOiFMq2oDbEVjzAFLmWrDUwHY9CKRbw?=
 =?us-ascii?Q?Azz1M9At0DATY8a+YlXJnX3RDaTNTYiFSa3mLZxpE33BD25FG8vdvNNOwpzp?=
 =?us-ascii?Q?XJF9TEM5CctM0R7y1KeRukIhO6tWE1uQulRm9IXgIZ4WP5U/Cht2SKdUBqMA?=
 =?us-ascii?Q?OIKN3ymQkkgavvQveXtn9YnlPiDnAJLI2n7BRC1m?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a96475-04b6-46ae-2b5f-08db6bf49adf
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 09:57:31.9302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNRwwMsALAQPDLmT+02DGk92I2YOdDIiYUWM0GbjwmaJq9JVJXDQWa4mpn/9zREp666mrvVe3RLeuCQeLASakg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5784
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
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c    | 4 +---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 4 +---
 drivers/thermal/qcom/tsens.c                | 4 +---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index 5749149ae2e4..5ddc39b2be32 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -689,9 +689,7 @@ static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
 			return PTR_ERR(tzd);
 		}
 		adc_tm->channels[i].tzd = tzd;
-		if (devm_thermal_add_hwmon_sysfs(adc_tm->dev, tzd))
-			dev_warn(adc_tm->dev,
-				 "Failed to add hwmon sysfs attributes\n");
+		devm_thermal_add_hwmon_sysfs(adc_tm->dev, tzd);
 	}
 
 	return 0;
diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 0f88e98428ac..2a3b3e21260f 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -459,9 +459,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (devm_thermal_add_hwmon_sysfs(&pdev->dev, chip->tz_dev))
-		dev_warn(&pdev->dev,
-			 "Failed to add hwmon sysfs attributes\n");
+	devm_thermal_add_hwmon_sysfs(&pdev->dev, chip->tz_dev);
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, qpnp_tm_isr,
 					IRQF_ONESHOT, node->name, chip);
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index d3218127e617..f99b0539468b 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1189,9 +1189,7 @@ static int tsens_register(struct tsens_priv *priv)
 		if (priv->ops->enable)
 			priv->ops->enable(priv, i);
 
-		if (devm_thermal_add_hwmon_sysfs(priv->dev, tzd))
-			dev_warn(priv->dev,
-				 "Failed to add hwmon sysfs attributes\n");
+		devm_thermal_add_hwmon_sysfs(priv->dev, tzd);
 	}
 
 	/* VER_0 require to set MIN and MAX THRESH
-- 
2.39.0

