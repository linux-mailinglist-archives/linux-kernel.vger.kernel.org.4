Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7766B73675B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjFTJNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjFTJNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:13:18 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2103.outbound.protection.outlook.com [40.107.215.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A6C1FC1;
        Tue, 20 Jun 2023 02:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8YmLW+74gNG9KxZ7NhyB3wpnok+a6iNTSTONClCH8/rUTM1AeIab6P2fd9/JLJAkwNERLGh5yWn6iJZIztzrYvNI1TSDkJxnmIonsY00dNX9TQ9W7pjmQwQ1Y93tGgvQL16TzrsRkYr8UrgQcfXqwYRt5Xr2sbH3nur63P1TOCY2+rgAjktQ/I7OUnaA70uJNp7zKhO29vPGU2Y/gZZ+XYXH6+Zbsk7ohtLVQ81VbmT0DhboII1F1lkWMF+v0/BTp5Xs6cWscbAWSyKvmQdhRDhvgucCrH+RNQtdxx8nm54ztxnxU8f65Foyp8JdvBrhGV+E8eKhBFy/x9H9nZcbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bk4+vwP2LX5ms3J7DsZ/rzhNLWz2N6SaCmE9A+Op7eE=;
 b=erOKMFgSITBvmQOM067DyG1DTaOeEzOXkG6o7u2rILHTmbE+Ki5PNM7MmMPhi2TanmBsmsuVg0EGxXs4j/OKndgwVBt/hDaSuUtnYStrz4tk0x9wMlxD+zL7Fc4BQls7IoQCrBdDxfdtN3v758TURjx9wNK1lZgv3np1HpMHCNgwhfxcQr5DYO8dk3GTaX7h0zfl5eL318em1RrENoAhmfZ7hFWppe4bKOse+GFQVYK1A+RXWs/1CzhtztaWLqVsEJ2/s+g4OjJqNtFHx9xAzctnwNgwTGULHbFkImZx4YTPe+FKSCCzPrgDmyz7VeKyabix4VP5658iCc0rcSohtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bk4+vwP2LX5ms3J7DsZ/rzhNLWz2N6SaCmE9A+Op7eE=;
 b=LnXw6r3X2mAGg1hSCKVWe4W8NCBE3rmVCs3bi4e44i/LWhfhjMFTx6wqqai3xrC9bBuoUNB0AeC+Wwa/p7KrCfS+OcWPSEGMo+dQf3u42sKe9S9NKJLmwwD51YCOo7Fg1FHADaznHG/yYEB4Y1rI+utWki8b8e33GtDWRVrlYiQwQuCXGFaue3dXxtfyqzq0omLhsxyc+QknkwAx6E57IxrucOQEgR13w5pLrMMTa+47BzXThP+nY1JVfFvfX9KOVUOixGX/lO6zFqZamLMRH7ndnjMb6pBhcPL8oGpBrpCFMyAuoMvCflNeOaP5vVWs02Q6LItPfT197gNUhVk1YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4510.apcprd06.prod.outlook.com (2603:1096:400:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Tue, 20 Jun
 2023 09:11:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:11:50 +0000
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
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, f.fainelli@gmail.com,
        niklas.soderlund+renesas@ragnatech.se
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v4 10/11] thermal/drivers/mediatek/lvts_thermal: remove redundant msg
Date:   Tue, 20 Jun 2023 17:07:31 +0800
Message-Id: <20230620090732.50025-10-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230620090732.50025-1-frank.li@vivo.com>
References: <20230620090732.50025-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f507d90-2c9e-4e88-72f4-08db716e61b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 98xNMy8CPrBD7lcQBYCnX7cuct7muGp2DVw15PBPZFtgQNOidRUa8VrWXRYgPDiLlK4JgGGMIXhcXGDPa65SJ/1kKzDWFjcoNG8iBcWZyyp17zE/e0L2bufOgIPa6ZTUSTEvBfAMMtOaGiErovuNapwoDnK8dBYJ6i13HRSBlbAP3kx2OLCw3lOCPtK9ydxGBg7WYQE0qYua3SJTjqugxYwmNJtyt0xuXtO9MNbuyZ2AgAN29ntTuYPMJtybUEdFbIeYZRXUs6C0bL0ZLrAEyWTIDU97dZ9AW0L+GqsLkrL/8OntI+7axzXWEpB+/CSw7MC3JOYgv5lREvQIl58e3giw/kCyOwqqjMuAcoFhlnriE2OxpSaXmKQkycMljOPswmlFZetp3PDtpczKwjT+Rveza1A0csP5aFjnD2AbKSC+0VbLCWKPU6i3FRFdvTCXtLZGWs2XLBSR/h4+dxMANWw814NCtB4PMJ8L+qjVh2RAc+0NW/5+NjKEZwv3WR5dmM6fK68ErdJJUwuVPl6dNCp6ydWYlVvNHcqqvmaN2t8uOsJ3ANEcyNqCYbdIP/DJ24um1StzeClshW5ZfwOljV7sQ9hOvUV7DKR/U7i8XIUiaHlSmHzPRCbUdGfPEvDVdt1kTWxKTMkk1/k/kZqYXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(39850400004)(396003)(451199021)(478600001)(52116002)(6666004)(6486002)(921005)(5660300002)(8936002)(8676002)(36756003)(4744005)(41300700001)(2906002)(86362001)(7416002)(7406005)(38100700002)(38350700002)(66476007)(66556008)(316002)(66946007)(4326008)(107886003)(26005)(1076003)(6512007)(6506007)(186003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hvc5rrY5YsBkQgLUei1P25en7pCVz0Xvaql/CECRIiX3lRk//0hmG/SEpOr8?=
 =?us-ascii?Q?Zkav9obpoklmR8eH8s4X/rNbPZwXlFwNUEmCvlwHtc4ZEMOZlqMYvw5eQFvY?=
 =?us-ascii?Q?QzL53QEIah7x/8EsSgQ2fuFAC58kn3JkQy/59AN/U5FaiAi/j6sK/FSbsVTx?=
 =?us-ascii?Q?P9XsNWPLa9x7lAYXG+9Z+SsSDxv/qQDxrMSJlGPOWdCpgGh/reKRsGXYVQ/O?=
 =?us-ascii?Q?GDIuWb/C8Tm0fS/q6ToZUM9JC+LEE4IYuJDrerinyjGF206b1DSq/RIWha8L?=
 =?us-ascii?Q?ZbOHLZDtpcENnKCjPSONAKqTU6ayMMCuG1bAHZrELwoytg33bN4GbXq4eACC?=
 =?us-ascii?Q?VCMpg2QEb0wMJiryZvk3MNDTL83I/ZkemADTCqZlCBNJvuIUxegcM86zEJni?=
 =?us-ascii?Q?3OJJD3Jlb/LSMJiq9Am5J+P+r26GtA9GVGWNtsWLNri9LpnoOYASoORr5NeE?=
 =?us-ascii?Q?Z0yXVEhi8blodg4L78oExuo0WNZRuKF4K958skWarpBvML8DRshn0wMYihTu?=
 =?us-ascii?Q?KWaccaLUemxA0WIeoJit2ikJJyaJ8EmzQ3D/j65+3DRp/Z/5nmwnHLs2PjBw?=
 =?us-ascii?Q?7Nj3T9SrEcw4qrEY1R7iJcaXOUg5rbmqCfPfg8w3vh5a1xV6QUUJQBYgS/r2?=
 =?us-ascii?Q?1kd+vSMQ6y68BDyDEmg8p51QxT7EdEBvLg21mAXt9tEoUxcVzjTkWQDCH1R0?=
 =?us-ascii?Q?kVsjwFfpjmtz0yN+mfdWbSH1KzASG+37WwN++qKkU5YwxxJsW9NkW9kyIzg4?=
 =?us-ascii?Q?25OL3xxopBGafUSICMjjzi9s/s5m+1MbWXwqZUfKmSFN7w1ZuHmUyo8oGuXH?=
 =?us-ascii?Q?JSW3C+uWHKmYdMTIU0xLMCrpHi2S4qq1pcXhA9vGHODFZBu9L8ZXboq1QiJf?=
 =?us-ascii?Q?4O4uH9dcqkmwBNSPP84D8M5bkEuUnv/WENEpB9achMQujPuCF7IAMO8sXBN+?=
 =?us-ascii?Q?+tTm1m3ucf4cIOUqqC3rkumziwvq1vLuyMuth4kmMaoFEuDGYLjEJzLi0Xoi?=
 =?us-ascii?Q?5EVIBEE75weoeS/qV/HfmndnGKv8K+XnxkpIQSY+GOwQ1+YYHdklbYzoJsO1?=
 =?us-ascii?Q?St85g8ZeJObIAcnLUOHtfaVJLE8PZKSpYtSb03jJRD5nkOobqqWveSFK6X/D?=
 =?us-ascii?Q?R1/ik8SOK/RFJ9dIyQ3gXOoI/QkQvk6zDUFrPz1o3DwM4VbOnwFaFnaQLdoJ?=
 =?us-ascii?Q?uyoFwvH5FQ+cjgjWYEkcpeUCUC5ymBKFcPSwvEl6gjKZFLHcya/N2P4kh+Xl?=
 =?us-ascii?Q?SlX8ivOOi+MYk07fG9+N9z4MJGqlHG+G15ulTWcKftxTZ5/6t1E06Xxn/123?=
 =?us-ascii?Q?CHRxGq5IxBYq9mkmEZ3VX2XxXseYpkm6+MSt9w+7TMa8GFVdCgt5ZlDe+bqV?=
 =?us-ascii?Q?2y8Q/Qh0lxt6M09V+Z1M88ksxDVmvySoz+w8IOTcIUIr2UiTfQM2G6/v1/p9?=
 =?us-ascii?Q?5vJvgUoCVE6YLs78RMEASrY3Uv7J31s/Q3s3OYL3V8e2+wYCxlA/SDlKUueX?=
 =?us-ascii?Q?eI0HtGk4kBPdeR6HGPgFnEsPBMh46zsyLNC3AOEFWBR5jDZHsOgWbIDLK5gZ?=
 =?us-ascii?Q?Qd2EMtvsGOxzFq4FmnS676FaSwqz1t1Jo0G8AVfB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f507d90-2c9e-4e88-72f4-08db716e61b1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 09:11:50.4541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7t1Iwqjx/XhS9AeBeq3VKcBvnzKfcCu6maFck1arsI93XdkWGbZCTnivxTS0EoXy/oV1lLrtD1EVgdQa/9Q6FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4510
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
 drivers/thermal/mediatek/lvts_thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 1e11defe4f35..b693fac2d677 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -998,8 +998,7 @@ static int lvts_ctrl_start(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 			return PTR_ERR(tz);
 		}
 
-		if (devm_thermal_add_hwmon_sysfs(dev, tz))
-			dev_warn(dev, "zone %d: Failed to add hwmon sysfs attributes\n", dt_id);
+		devm_thermal_add_hwmon_sysfs(dev, tz);
 
 		/*
 		 * The thermal zone pointer will be needed in the
-- 
2.39.0

