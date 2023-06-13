Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5855C72E18D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbjFML0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241923AbjFML0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:26:31 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088B91727;
        Tue, 13 Jun 2023 04:26:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPBTE/z0Ei8mtPNFOET90vVFw2KNp0zy8eE9wvuBFjmUZSvxQiAft59e+y49s/X50QmAmZ4FqStHAJCzdxz6MbKCrDDilgaK+ONsvh17FjgY/2CDPoZF+PbYJ6lT43+KyGvULPIxwHULB2JrTpORWDVnYpItbijvKpbhZ8I672eclFUWvqN2mmiocra5i3u/0DKdEbH1NJIS6dngQgz8kCG1NT/GdcwcL3QC1l+oolsDljBB4Ib1TEaRsxVorj3YSKjn26AZ44CAL8OhsprkYw8cRkNfJ3Eb5mzUsWkrlOQiCWwErsUDar36GDb/giV7+SF+BPfm4nW2ou+NFVQ8HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rD8kg+92/T4iqfi8bXxqd9k54ysUymkpnPOGQgUuiY=;
 b=aCcvaD43uVam5mKsMknlvI8x5XkbdkaxQzedA3gMK32A7OrY+7hkVlx176eV9PuWw7F01v42NBgfrOkIcTcdS0Ur3J/FrTrKgqCpWsz/dKWccA7ikLpDbBHU87ET26Iqv1/5s2q1DIMGp7orILg130K8ry4dm31mDetY1iFFnpWpQCQAJrpD1qMVy8kA3rOCW9MPOYrm61k1AEq85yD+ikwBzWoR5+AWL6hSxF/+lTm2Uw5DfymXX4tv1LNjGA7ea5OraUdMIcK0nVFWhS3kHNn+6OBAoMS2FI6iDHfM8xubpEPegGRa6v6ERZFu03SX76eN8/7SiKVBYXUMU4t7hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rD8kg+92/T4iqfi8bXxqd9k54ysUymkpnPOGQgUuiY=;
 b=WrhocbSU/1ndkovYFaQZthpZcUB36Ouue+feths5Tilpc6h4Ga+vB1DvTqhfVQujaq/ZYpaTnD2WJTvmNVbZI90Wds6t09ZJ0nJM/Z0eJ69x4yJiaiOlk7EInX1wKTjNsRwPv5EyOUjz1b4dUjoZKY3qvd0tJ5uH8CfNAw7YxPu1FUYehQB6xN4Sq7d9Gjkw4TFziUu+7pWCGqrvY6u1u3fG7vVCqOvzRD4qjD3Sb3NpbP43chW0qR7BtHUnX107fqqUcN6DAztfwFJfJ6GPysAS4FPPCXw7QUU1/8/LvWnhfmh4ylf48AlLkqdUw8c1fdWCYIW8XtYTdVC3WpF0Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYSPR06MB6793.apcprd06.prod.outlook.com (2603:1096:400:473::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 11:26:12 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 11:26:12 +0000
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
Subject: [PATCH v2 08/11] thermal/drivers/ti-soc: remove redundant msg in ti_thermal_expose_sensor()
Date:   Tue, 13 Jun 2023 19:24:41 +0800
Message-Id: <20230613112444.48042-8-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b0240abd-6b6f-49d2-033c-08db6c00fde2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWWVSqCDSgLQDQl5gtDiz4GBtjlJ74GvtFoMHO6PjdCX0ce2xbChwwtAmLWojBbO/zOSpOGcIvSFUc2NeUI4VLCsXkbjJ3u0X8Q3o7RhfmxQnDtp55olTL7u2GkfXTcHDIUa+DGDLOdsriH8nsEf9wZzgU1jn2MdNCAnsR74Wkpa9p2dRpwt7Ko7MSEcOWa1Dt+AOEJ2oXmPf0MZug1JVNY6YRE0pjo2hyLa57UVj7svAgkHFuQhqRh8IWcxGTUbYoh9+SVyqZ2G9F4sakBwhuWq1L5eRperFdlFdTsFmmNkN7LX2fEsc4UO5MNVVFrvDkuTzLzwQQ4MAYzvEfVHeiKtTrvPQ930t+AZaVVduAJJxAaLTxoQLD5bujpsbKTSwZegq9ASF5wUxgUSuSHgzDPvHKpekM7Nr53Ijv6IEUi23czG77Si6zcL4wmU8MqMy3284SRDGjnqnry7G7U7oXRvTNXDNG0WQoNjoVFXzLcdfccIn8JO2hnVkPSRyRc2t8W1DSyfXyVHmOrmh2zG52acKOxTsftbHgIOWVCV2KkKEx4wBP68w6vj2JRnv8S/Xy3zl0GlzUFo66qEKkrSWDAN83R96/gmHTSTuSjIQpcmnDOQEmSTvoCFZOXOk+EytiVwauo3uuE5bDkQmgFTzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199021)(921005)(6666004)(6486002)(38350700002)(38100700002)(52116002)(107886003)(83380400001)(2616005)(6506007)(26005)(186003)(6512007)(1076003)(36756003)(478600001)(316002)(41300700001)(66556008)(66946007)(66476007)(4326008)(7406005)(7416002)(86362001)(4744005)(2906002)(8676002)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6sI/yRoDmTufwXEANHRRg9ZJ8mt7ynhjL26eaZNuKOwtWy/+xWKYlhncaVjQ?=
 =?us-ascii?Q?Nny7xio8hPkBNh4OVEq9hUSpCnwLZx6BkPM3PMCmKzYGl3lllNtyNwqVYp7D?=
 =?us-ascii?Q?ymArV09ZWI/4je4jJpc8D/7Jot3oFf5lAQsMHRGZnV57Vkd6y4zGyGXC6IEC?=
 =?us-ascii?Q?8m0Rnubc5wU1WyqmkrMGReH7wPbMmkun9nSJ0Y71OIV9s/MmZUIxJU4ZbBkw?=
 =?us-ascii?Q?VzO1MAuzLdIgadkZfnV4BaNXjO1OJ5fnJEFsJcjJlCvFO0mlEkcUg1zw/peH?=
 =?us-ascii?Q?8BfcO/Kt6bxmPQCBwowUTABhH8gR49XZFHz34U+g15ftyg1lN7Jwl6mB8E3q?=
 =?us-ascii?Q?7H0Z03hc0qrQf2Zm5QGsWkYSHwPApUdKpcCKg39v6qKI6DYOmiV+bvVAn9r0?=
 =?us-ascii?Q?O+BDzMmcuKBL77V9fVKeyZU5kEIZFOYoxu0JGT03vKrB0KtztTkA+yZFb9KP?=
 =?us-ascii?Q?UnGHjpXC9er2ZUfTdJjIclshnrekz/1xw2vZoqssZp2FmoZM1tQojBQypKij?=
 =?us-ascii?Q?NybDDRA63l5pU0b4bP/EbVjgLo62fwMOMvTrxaIBbgdQRCTp4MyCPAA11mgv?=
 =?us-ascii?Q?h0UzhlxDyTWuWd21cR9aTXcuACcCx1gDlouDnEwN1Znw43Qc4JdWy04jT7O5?=
 =?us-ascii?Q?20g2vV7ZyjxVk5IZYT0epzWS4HTLeWXZSK5I0bDHjaZwYeqFDYnPWW5HGDe1?=
 =?us-ascii?Q?cK5Txr8i2frZTu54isrytnKZvGKFXq4GtDxar2kGBfDjUyQ4A6LrR5fPmjQI?=
 =?us-ascii?Q?2i1F4mxM0yg2aah38xyPRNUeM+furkwT3sgeGMwXwA3b5qMsImRqyKmjaCTM?=
 =?us-ascii?Q?Y8KySxC4hK/X4WeLsN7nTo0mup8eslkVC3dbrUBYqOPoHvZJzgjNrbbefdTO?=
 =?us-ascii?Q?ifACwNwQUVtj25VM/rQrtAxFsjZ2/kImoWRKyPJ4aznJJmqvd/Whnu/y3Q++?=
 =?us-ascii?Q?r125nLEwikgqSM7HB+QRy8ccD7t1Cj3Cps0LZZOmyfnJvZsRiEeVrFL36G62?=
 =?us-ascii?Q?GlhtqOV9lxDJPkSCyKORgzM/3iAcUKKtwRMB0X53K+sasAn0BEypJKOuAmlF?=
 =?us-ascii?Q?WWFjAzaZYiUdzFiy+E6CZu0jNY43sSjq6XdtD9escgHQZ4gpkHTidz31q/wW?=
 =?us-ascii?Q?2zDOX56CHjhk4yle9/INJcv39rRh3vOxzKyxuokXTxJpI9f/vNPanA3VAAKR?=
 =?us-ascii?Q?hb28lrv5ksL52sMcZGvV+QviF/uY8pb5sDJCcr+RzlDa0DuQqdaMY+fRBPVR?=
 =?us-ascii?Q?i2NI5WOi7lU6vcjHpDoOm4/tRVkuz1NORuitQ+E7WfQHy93c+7gw1AP1pnYf?=
 =?us-ascii?Q?S6bqoZ9gCaY1SLLUXprkwZQBAed7Ts9vq6hMuMPGLaWuqQYDt5DftwJKKapF?=
 =?us-ascii?Q?FfMKzU4Bckzd06u006zVdVc4eFItuR2jLneu8IJiojxtsaWdATAL48xYd1lu?=
 =?us-ascii?Q?XrOKS2qCvIsUp3waV2YRmjQ8wtwEWXN74u52RT4pApdcsGICo+SP9zb+G8c3?=
 =?us-ascii?Q?mUsFz+pY0yNGZSSXLkUJJ17nssWmngWAPn5OV/x50iLdhWGSzw4ksWUAV1h6?=
 =?us-ascii?Q?NbHnYnzxFGNfd5O5ZswriU67N+DCpRLsW5bs6awD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0240abd-6b6f-49d2-033c-08db6c00fde2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:26:12.0523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pc2989hyTWuNoLyaGfdGNFBB2qWWJ2PmukTEYMKDcYqRkFQ749eS1IzmCwCWluRQgHu7alHZBfpGQ+/a0KioZQ==
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

The upper-layer devm_thermal_add_hwmon_sysfs() function can directly
print error information.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 6a5335931f4d..d414a4b7a94a 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -182,8 +182,7 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 	ti_bandgap_write_update_interval(bgp, data->sensor_id,
 					 TI_BANDGAP_UPDATE_INTERVAL_MS);
 
-	if (devm_thermal_add_hwmon_sysfs(bgp->dev, data->ti_thermal))
-		dev_warn(bgp->dev, "failed to add hwmon sysfs attributes\n");
+	devm_thermal_add_hwmon_sysfs(bgp->dev, data->ti_thermal);
 
 	return 0;
 }
-- 
2.39.0

