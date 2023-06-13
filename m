Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7256872E221
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242112AbjFMLuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242056AbjFMLtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:49:53 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2098.outbound.protection.outlook.com [40.107.255.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3FD10FF;
        Tue, 13 Jun 2023 04:49:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1K5asienbEi/toZsPpm11ZgrPGny0xFK9ldHyJodhf7yF27mC/2S/ip8tQzk4rZM24seeExp+v4Jtv6EC+lVpyrA//eh8QcOk1KgwBlcJ6idm3pqEES3PcGNW31B1eaAeQAv2skTts3/NYBYQjQpvfVn3rIxzDOa2uR8nmqujZK8pUNdBO3r7E5hLq5KyTFwL8Wa0LQ2ZfOdhIn29egDxldzzIoYdROn4PanyqO2WUt3Deup0qbYkRNMEDL5OcVXAqHAIdnvk3XPmQkCaj86eePTxrsjdNb3qKURCnQFqCCwy+tyy7gXNq5bTov78eKPe5AJ2rqkIewgTa4ntXQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++scUHKfsZEh9T42bK/jWLT1eewDohfz3H5KcioCgI0=;
 b=DrhPrb0tdVB20yv8fxX56GG3ZvdV+UjHArRvUcOaHOmUwPzxUfWYvPzgesfQV78LrluYfLHjU0l6Yv1CJgJIHZJh3kuhK3/OovVaSH3KeS/XoVn/tSXjYchy9NBxniipzKzn0Z85OoaRUVfkTiqWMouqP5BQOoxXce9UFGtB2ODXWBuQxKfsIMdICKCdYJtbh45hljFPx3gQt8NVfVo2D3NHTfNhNr/m9KYn7onPMuN8WzaWB8ixDbNUD5w4ompsn+Ew1O15xu9LftKh4HBJAO0+bubi/DTsinBVKSDu4GfKfHrklQZw0Qdqy4ftRd39t4pHfn9pEV2c4hDqoY3iXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++scUHKfsZEh9T42bK/jWLT1eewDohfz3H5KcioCgI0=;
 b=HskVidAwh/oe4xAdDE/4PICRLaje9LIdofYBbRV9n/AO8Uu36uBArNGyUwUzY/Ky/lFrWtrixQcOhS+Kcq9kRHYACuKbmxqTmxaed3eIRGuA+RFC1Sbe6XSO/W8pVJQA+UWgjU8uUFZ3++lLgl+OGGwBHtKEo1EkNQxhAaGeqc5Yy4/vI2yrKxtXtyCRQZMs+a3koHVBJRIc94WMh30HqYCc8uv5q07pySvxy6/fHb60SWSt1TBrYwn/kKfX2zMpFsQQXV9BPrSnX4Oy8QyctDcI18N4FP3n+CUa54/zPZuVkDSfUshW6h8Jxo8oMPTsctmw4WTp4EuWpjRccO+rTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5315.apcprd06.prod.outlook.com (2603:1096:4:1ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 11:49:48 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 11:49:48 +0000
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
Subject: [PATCH v3 06/12] thermal/drivers/tegra: remove redundant msg in tegra_tsensor_register_channel()
Date:   Tue, 13 Jun 2023 19:48:58 +0800
Message-Id: <20230613114904.15749-6-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5315:EE_
X-MS-Office365-Filtering-Correlation-Id: 26c4e988-ddc0-4379-25e2-08db6c044a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2zW+oKWslcvsSElXt8I/a56gwukP2yajKTTlF93TTFKrLm5ck3uUW1hJKTUkljip0n8bnsqhG4lfxfaDcFLcJV0X/JjUQPalkVGBr841bs7CVjm0gTbc+Z4jk3Fs996scw3NCUW7PhhUQqdSM+gb7r7xzJd2mcqthjDWqaA+ppJoRIoDtA+nIj1CDtUolVvFbxqQojepNiRdwO6Ts75Ny0VBevCO5aE41r2k34DwH+kQKm2OkgKCXYDET16a9YEUtOdZSuFGnRNuykwrUEiIMX4UL4JRWvEGcBGkJMZo3qTZSS0yb8AZH9+ToLjrQM0v3xT59CG0/6nkJo+7SdrIaKnZWg55+Y4/1QtGCWSbeii3qpX7nev6COZPwJm0XYMGbn1pzBpmm/wGiZ/Yhlsezuv5xvJ3Ox5CTQbb2c3m2IP45kbaCq9SOxkyJI+D5jETB8zRGAmIwbksMX64wfuiURlf4E5AI5D+M49XxxTnoLb1dGCbCusOKKOtfjhCxIFjV1Lv/1tZrP1UF8ZZJg3T2JBgmMV89ggO4zpRpPbDeNm6B9sS5Zu9L/P3pRt+JQpVnRnYS+NwWWgCINmMwfAJqTREvdLpi5idQDaiacMVXceAP0beonompe+IErK0u7p2hXB4d3mDL4MQDDtiGLM9Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199021)(4326008)(8936002)(316002)(7406005)(7416002)(66476007)(41300700001)(478600001)(186003)(2906002)(4744005)(66946007)(8676002)(66556008)(5660300002)(6666004)(107886003)(52116002)(6486002)(1076003)(6506007)(6512007)(921005)(26005)(83380400001)(36756003)(86362001)(2616005)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p0UwV/+F1HWy4vXsaLyI5dhcpJagPmt65dgIww/QMJR4EHyHhssQDDQKFcH0?=
 =?us-ascii?Q?ZiREfsn7gVDy7UBLbe68HsTHq00IxD2f33m8KG2yj6Z1B9FMAAjWaVqSjxy6?=
 =?us-ascii?Q?eyE3mmxZOZMT9UIpqI7hdHJARngXT20Wd082uWSz4Z8foaKF947z4rc4WIv7?=
 =?us-ascii?Q?1thUDDFXY1/HYMpsAgrqXBl+ghpbwsoh/PiMXM9JRzaHwty81RtakDxPeaIj?=
 =?us-ascii?Q?SExH8VxyU2JpibyN/ecqE0w6MYKrJdUOSrQAdpdqIqxY5hPsysFcRHTDfztJ?=
 =?us-ascii?Q?7ynsKPOkJjaEy9OjvSDj+aPFVBoqH8w2519XbULLqzrEwvyPeihOXGhiM94d?=
 =?us-ascii?Q?yXrdJQWkRl82vLV8tz2SCmmCJlKff4Nn/QKQOcHhM5x6RO/SWkD+2QWxt6WB?=
 =?us-ascii?Q?slMylNaCtdiWnjiNk6DaBZwMZlp6p2QlUd12lu1O1KpEJEn3LgLypVNOzins?=
 =?us-ascii?Q?R1rGtZLg9jZ1dePR6HT2r/252qriOgQL3c+yFXu7zM3Eq4Tx2Q5BTrOJbUM0?=
 =?us-ascii?Q?g06JT+J1jUfqwhcpu3N9uI2Ja3x9VHtUTKitS7PF4NXDGK8otZ0NvrdRhXqy?=
 =?us-ascii?Q?tQsge+LH7+l/5T6WuQ1PZHqByH508q0W2CSO6B/bY83KNmNx5McoaEjv8Lmu?=
 =?us-ascii?Q?6PZ0y/VTu19kq4x8iGuUfHSQ2sykKBzmYUdPBUCZAXV+5Y+RCjjj/3uknAHP?=
 =?us-ascii?Q?/VG8/Qm25NZXYqgey8PC5HuVbgB1ek3/PJh9FEG0tW9F4Vzb1E9uQQOTy9tt?=
 =?us-ascii?Q?FDvbwOej0Bm4Vh+sA7wh+I4BbjfJfKG7M/wE5hKPbwc0XpS3pBNwoX3bBnGP?=
 =?us-ascii?Q?IlXos318zoOz1AY3DTsxgMtfoBdyS3XnFxZaiDItMv15j9OmlofEbSfVPr3n?=
 =?us-ascii?Q?QarcJRp5bXmlfzWZnh2U9RzqfhUpasMDpcI6JvGXZC1FQ6KQiBEfkM2ClUMN?=
 =?us-ascii?Q?Npcd5uwcDiP5YZRX9+JhuNIOTXj6JCIMzuspanP06kdyllUghvBu/+ywa2xf?=
 =?us-ascii?Q?v9T+SN9dJ6ZD0Q9c0RQyTiyRgegYTI0EOyxssUjWoDOCSVeHGEfqzikrk2+E?=
 =?us-ascii?Q?fESemlDWK+JOhb3cAaC7ZJcxslhloLqZ/xnj3KWT/AXadYZz1xarXt2cnouu?=
 =?us-ascii?Q?ydnMq35TRcmr4zmbKTeJg7TT6NxFvbUEzFJOCP1IfOogglLuK8PrJVaPJAtg?=
 =?us-ascii?Q?fz+9lq2PfLDuXdV3U/zwywSn06AI1r+dwaNfoiMC6co/61tY7tn1qjqUn0kA?=
 =?us-ascii?Q?e3rz3VD8xE05mkeTCbsbUkwjSdwIEJBouX952HbtozXsnK8eHsCN3zVdR/K0?=
 =?us-ascii?Q?wcr5xymda+lFPUCRQ7Z9/Wa2njK7iaG93W5FFaMJ2J5zeLDMterqYhtkUzOc?=
 =?us-ascii?Q?w/9QZjqFXa812ytpnGWrE1TfI8MFcxqGVELJX2gzRltpZ2Kc9lK5xN5+1y9M?=
 =?us-ascii?Q?P+QtZU9vJLVbaOs6SbhnaFO4W6GB3FjExDnB/r9wBUsnHW2SD40JnBgEh2uS?=
 =?us-ascii?Q?38o9SHeRvA2JmRh3G7XuE0YxSYcJE4oUNtB2+obMkX0eeNSL7K8OnMmxPDPT?=
 =?us-ascii?Q?deHFOcJ5fR+nacWiUnXkedCZhjDwHs1CKDQM4Pud?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c4e988-ddc0-4379-25e2-08db6c044a46
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:49:48.6575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jnqd8sZspJcKAGldIzmMMe+YqHMEpTQIQ40Ig7d8xDC/9vWpxnoMr0wHepJCBVP5qaCJY67oBV8JBrdD+2nj7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5315
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
 drivers/thermal/tegra/tegra30-tsensor.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index cb584a5735ed..c243e9d76d3c 100644
--- a/drivers/thermal/tegra/tegra30-tsensor.c
+++ b/drivers/thermal/tegra/tegra30-tsensor.c
@@ -523,8 +523,7 @@ static int tegra_tsensor_register_channel(struct tegra_tsensor *ts,
 		return 0;
 	}
 
-	if (devm_thermal_add_hwmon_sysfs(ts->dev, tsc->tzd))
-		dev_warn(ts->dev, "failed to add hwmon sysfs attributes\n");
+	devm_thermal_add_hwmon_sysfs(ts->dev, tsc->tzd);
 
 	return 0;
 }
-- 
2.39.0

