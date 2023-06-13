Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A8172E188
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbjFML0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242010AbjFML0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:26:18 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5ABFC;
        Tue, 13 Jun 2023 04:26:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mk2WU2BhjZ24GN8a7SfUiIFa7qcibKVW0h0D0kuN0XjTHs29rHM14jILZZQRX2EUJLGVgmSzsz7JIOFk05cOl07RV1iUBeDc4/R+x3diipLy9XBVTJ7moBX3eSgkLeKUeMsCeINSN96MbGBqjAaeS8oEUgAiFasIg4uWdF7kyT/F2G6YvqpXLwxFJ5Z7ObeC5ts1g7OYxii+SfR4/2NJf5RESGDy2WHbjAuuI/GbGxc3eY3Rag7R/rD0So5JdH8tJ+m7sgalz7qL+c1YFD8eWIJRctRc/HamVsclNAJ2qX82UXEsMLwa+ne8CmQvHAXPb5I//NW+PoWdqOBSmK03xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgjRIFM7XXXA1ZiuM4luxgQMbyvfhlw0vWc2ywkdzrY=;
 b=JkpT46PjkI7kx2Rt11uTava8HMaudMnV0mWQTm65nRGlsbQEgs2zaJXHxD4E2zXIVSiY8PwkvqYU/KajznkTnP+jXLk5+sNq0goQawTRTGQdkpb5owgHLnCbHhNWsAJ3gmcwQCki/2ERVzUKn8SjUNVEKSEsLeT5BDQm16uaYz0uod656KM9jsp4NzhjHXyhCnY/QFjhoWDukaYwdTCdLqBgNNG6F0zHmckQXjI9VEJAs3eiCZJW7LrUU3yHAPur+giJis4hYouxhKi137TTZSSIoseCXz74e9x8/PsEyCSdZ5OnlVxgohVIztKcGiEu/8SO1ETo0kjMJrgD2H5zog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgjRIFM7XXXA1ZiuM4luxgQMbyvfhlw0vWc2ywkdzrY=;
 b=DOT6y3jQ8IW+8MwtxiVaI9UsSnOmKZTlG0vNGJg2He9fqYwZ5eGaHTsDz2a9TYJ+u64jHJky2jSLU9d529fVpkY86WN+fgxwu8jQphs6oQDUJa3sZU5PBu8T0zFDJJHqJUm4uEWkyZrL5aWsbhMTgrJN0JQK43nvHtqUQaau4i9nsHfscwXhfcAxlWjYXYWUYTTCcJ88Ej12K2I6FEjVCQTZUlzNz5P/nZ6jnHRFDISumqGmKTw/ydHq9TAESU4W3G5pCjo3T/xyp/C3JQtXoMfSWZjww2GyOUDY/QCxvi7Vy8PbaDdmnKLgPOXtrOsej4xS2eByqvK40Hz1apeQbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5920.apcprd06.prod.outlook.com (2603:1096:101:f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 11:25:56 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 11:25:55 +0000
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
Subject: [PATCH v2 05/11] drivers/thermal/k3: remove redundant msg in k3_bandgap_probe()
Date:   Tue, 13 Jun 2023 19:24:38 +0800
Message-Id: <20230613112444.48042-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230613112444.48042-1-frank.li@vivo.com>
References: <20230613112444.48042-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: b31ea6a9-48b7-4609-4e6f-08db6c00f435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6xBjUVaPSHeYSi/1QpuP7Vw6QQq7D/Xz8wfc30tT5dlQJjaUV0kCEnRYNd91rSNV+mcmgkK5GqAGFXWISTyJEYunm91FvU+10kKuXNlEFOJXhUuk1S5iyizAmzvSqzr9E9lof6MJTegE0qVtSG9gzxj1WCyGgni+6GgOiLfNULlrCi4vio+waO39/BjXZzVFbV+TLuVbcS6LFSvarrNWyg2RKzUrx8p6vUxCKMmUPNPLktivRxRgI8m6cM0qMOBN68y2vxg/cCZKwPqZ0x6taanLOX0HSDxQG9K+hspzvf27M3jOhVR3YkBnHc0bYfnAXsgn8jBlKjmfC8TMeaiGU504qWd2+DZu6QubvzFcSVwkxgbe3PGUPhhX7aoppIucLqKFpGcVzFkx2AhxMR094ENotBz/86xhBz76zuToKSqb0zqUn+hrFPOMKpnykcEaHiIXAz1vnjx8zP6KkuN2sKm3q/9hyTOWz7GUz/8Sbmko6uhoztiqQdsGyJYTDAOtiL/zDLbA4E2LpxZ+mgE9pE4jXdUOq1clpF5dA/kbfD6A6+RR3SErK0I9TCUb0nvaFbsfve4B46zzidU2K2T+fuaBUqj6hqazdwr8Wbq7IdeXKh3+FDJ88UG/h52TZdL6rL9RuvkDhMggBcHLPPhEUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(66476007)(38100700002)(66556008)(66946007)(921005)(2616005)(6512007)(26005)(6486002)(6506007)(478600001)(52116002)(6666004)(36756003)(107886003)(86362001)(316002)(1076003)(4326008)(38350700002)(186003)(5660300002)(8936002)(2906002)(7416002)(7406005)(4744005)(83380400001)(8676002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jyGnOweJGUqlrnahImkGutTBR7Z50pTkeSypBnQGm/+av1ADyaUwpH7z/8iM?=
 =?us-ascii?Q?cQnAJrngzYUAjXS74/SwH8jd0fK9UfrcQyClmxN+xK34wEbjqx1Bng9famyi?=
 =?us-ascii?Q?z3aEF6wEfb16CS0LYYWUANgKJ1++FbyIQLqF96G8P8ymY5+Jmx9YPcdd5lYL?=
 =?us-ascii?Q?p83en5YRifRATeMfRqaIF3g7nrcz2G0Uv18GEgu6/LlP9U+FSZ3LY/2+WNVk?=
 =?us-ascii?Q?oRUiLTbmD8ldOp/TDnCieFkHccq5P+Gz6pFa0EgyrKv4y/N2ZiObFFjpyYmE?=
 =?us-ascii?Q?wAUqNtOcJBBMxVQ4/HEwB6S3K3gTv2jTxDPgL6cpE5kIGWF/85qsuMjzn/Ah?=
 =?us-ascii?Q?4NiF8d1BDHiuqQQiXScmymlY1gyp83sb72xo1tgabA3tHiMv6q3+8qnw/EVm?=
 =?us-ascii?Q?cK2z6yVmj7EgcO81LwjypbDcYCy9Ys16wUAt7t+JcLFBlQfsWznDd+M35ddS?=
 =?us-ascii?Q?JfvxUYxkN9daovnLjlgcppW2J6MvBWpLvrodGRzLPicEWDZgQgEEmfmMXP1t?=
 =?us-ascii?Q?aRZxTz4vtqOODzV1u5QqIf69vWZJjxpG1uhqTqm5P/16S49SqmEg6KkcekQC?=
 =?us-ascii?Q?kFh2/ZBtriBEeoZY6jb13q3G4XEE3A0ltQ48qL9xZmUE2KdiJ504nVvproGq?=
 =?us-ascii?Q?3uCdYRB+9h+Y7T6yVXMsO/Et6HcpSg2BEf03dkbwr5hznJFDaq2B9WGeS3VY?=
 =?us-ascii?Q?5DFw/+35a0gFG1+zCvYvOwf0GRJ0jvwunbKVdiCZ5c1m+suzWbxbODpKbBPq?=
 =?us-ascii?Q?OvkTz6Boe6Nkt3y1Vqa3gsPE26O+Gg9Q/cViJPTwv4tb4TJMytFG9ZmS7k1a?=
 =?us-ascii?Q?lruabvz3p0puinVa/CV1nikNBXauBTv/FB01dxo0aOTN0YuYBkyjGrGvmAkx?=
 =?us-ascii?Q?KJMd5MS+BWTz0BD+Ebl6vmy1XZ2xsyBfpGv6WUqx7dyNL8nNnLK0kAGeBANq?=
 =?us-ascii?Q?pfP7h+qNOkhrPLIbEEJ2InFSslyw2+UTUKN08a3aSmX1OOdiVrFCrCkU80j0?=
 =?us-ascii?Q?zXpbvmjIZwC7g+3V7GgiKrfPMdn+hCo5h03d2ChKsDGvdxGClKnQP5S8zVO7?=
 =?us-ascii?Q?1UMX2Zwip/VL7MTSkX3vqUkR2KTPfWTdYjtQ52/Z2+R1Rikg/qB4EMf5zU6p?=
 =?us-ascii?Q?e8oVxMvEI6r3w2Re6IDjEGImNd8Kl4xWG4kxokMQ55NvDNgWGnOFejbuBkCp?=
 =?us-ascii?Q?rVGEbjUaZUmpwRmEGrOvq43wG7yUIF8LAmUq+W2/JJW/7xGVC6e+ANMmgi9l?=
 =?us-ascii?Q?ZW0KkVPQ01bP7hY/JTKwfGcaLKk3DWVSIuoj9VwmChwh+azf3/c3XS1eE1c/?=
 =?us-ascii?Q?91z2+R+uaNNPVNqNJ6WsaBLabG1xn4KFq4Zfsv008qWEhx9YIPvawjeroAIF?=
 =?us-ascii?Q?YZ2ayFSxZ0mZm/ihfSLvPJ/wvWDfkjpvPfjj78zRfbjkuexDYGl5cnj/GMlY?=
 =?us-ascii?Q?85TC/eI+7a95bJFfO1L0QSkkLLbrB8iRUUmRxVYT7Tai6e7svvPziDq/Svvp?=
 =?us-ascii?Q?2JjM9mvHoLBcJxgq7oT9D2N/CI+JlGoama0ji4Nkzf8j4v77/KdvfTq2t0FJ?=
 =?us-ascii?Q?5XLMt/Itlag0vID1CiBNRm89CCGcAQEXxVW/oR1j?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b31ea6a9-48b7-4609-4e6f-08db6c00f435
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:25:55.8525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hPELDnbItbXpzTFLoykmcvRRfL03eL1s6hqwUb7tdZ5TMw7+/8IdIkXoGvrH2TwxJE2PigaabSwv5zYzVEPaQ==
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

The upper-layer devm_thermal_add_hwmon_sysfs() function can directly
print error information.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/k3_bandgap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
index 791210458606..1c3e590157ec 100644
--- a/drivers/thermal/k3_bandgap.c
+++ b/drivers/thermal/k3_bandgap.c
@@ -222,8 +222,7 @@ static int k3_bandgap_probe(struct platform_device *pdev)
 			goto err_alloc;
 		}
 
-		if (devm_thermal_add_hwmon_sysfs(dev, data[id].tzd))
-			dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
+		devm_thermal_add_hwmon_sysfs(dev, data[id].tzd);
 	}
 
 	platform_set_drvdata(pdev, bgp);
-- 
2.39.0

