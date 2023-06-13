Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2703A72DE7B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241913AbjFMJ54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240890AbjFMJ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:57:44 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2093.outbound.protection.outlook.com [40.107.255.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661CE1BE4;
        Tue, 13 Jun 2023 02:57:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVkNEQF3IBA8izwr6tIsHJjS3TuEVgi0S2O72wInZ8B3PAV2ieq2aS7pPzuWKvBTW75DvJ4sRaJePpSb9k3Ktm/ik6+iI/vL9wFYHV1DtsDfpIPC9C4hPSeGcFkbvEtbpaBfeUPRtuSuOB+ygYf9Z71o5RBPxs7Iw/DZSzXFnpHliBqCKMuYU4gkYZQbYvypDJj/tR1pzlU4uFl1ALNFN0tPH+0az1bUwf2F4av7XLdO6a2UVxtVSBiF/bIT+/yvNCwbj0egx5Bd9k3aTlao7fzKEs2DIhalhKaiS+Ey8F5LitapZVzycauBOcSnlkEPoysnTQn9VMWCm3Uana1dNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++scUHKfsZEh9T42bK/jWLT1eewDohfz3H5KcioCgI0=;
 b=fYixvFU6C5kuuWfhTJYZKSa8XxwwF5pAut0yHBwmMucIa55Z3BCyot8vKjC/xj25/bwtnkvsD5ATbYKbJ3Fev8T8Gbd8ZqGW37s3GrTalApIMt2aVauDcT0aNrarCxbyQjkYPn8EbzVKU258anK2yGDNmhSbKQ7xyDkhLb1LPb9Y289hapeLnZwiQ5r5D71Hgn2TdDzVqY7GNl0bKpwOuJHfKev7WQqgGB5j1hiANMcWPlmg5tEAcEhwwAgbkgu24pVfFFj69SDjyoJie0NuZV23wJVPeRHPRTy8lCr5sO7QNtgKpG+DVxt0f/b7LP+Hyjh+IvbLwcqYtEOshmqSQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++scUHKfsZEh9T42bK/jWLT1eewDohfz3H5KcioCgI0=;
 b=cj2mSmijIvQooRQb18taHzrZHbXf1idn9nJXhQvbz1f71pA6DKZiGBUNsrNmZN4C4ZIrV6f7UVq8fzNUCa5/qSE3y8DOCZNgSfuDmVLiJGAPvIY52O/fUQWK+Lu/UjBgBYmGeW//xqjuWGFdqyemcGGma+oJAASQoNBoeRjEkrNnwxoJ6EwcTy3z2NBgDs+cf0yv5fIjAxyjNIm+f0oK3WaOSXjeXHw5ILeFLcZjDZrXEwn/81exjTt+4b1oTVNPI7KNcy25uNoUt9sSaS7Kjzot680TtlFRrk1FiPHRI6My4em8xRuMzNkmhNnf7jbyipHssgBxdD8YaOB670RToQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5784.apcprd06.prod.outlook.com (2603:1096:400:268::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 09:57:14 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 09:57:13 +0000
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
Subject: [RESEND 6/9] thermal/drivers/tegra: remove redundant msg in tegra_tsensor_register_channel()
Date:   Tue, 13 Jun 2023 17:56:21 +0800
Message-Id: <20230613095624.78789-6-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 75fbeba0-416c-45cd-8336-08db6bf48fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sdDlaFPf0gEDzqj7jKce8eoV4eFQF9RTwM/wHYxaDSWfDVCpTJDnQ19tr6sxC377GA0yUBG0tsC60kC71BhniUrHnPkrZa8Fs3Y3HNVxZ22og7JPaima/mNpKNOeAwZnUKNf7SY8vD+jB/Edbpfx7jTvGp7LuJ6XHx5hIcWHs+svmmyzYbXKX+HB0xxXSWYPfs7OXow7f8bv19MVGkRBPhHnK+HdN7xUr7bLzSXRRK2Q+i5YZO46AELA5TZWcEEIJcYLodaMLvpTttA3hg63FglW4UHR1GpiEovw2SqHjwjJXT3cXwQOr9HF9wom6QD4HJD/9LJ5/dhjUwrSoKhw+V6+j6907rPqapQfGm3d7AzdzN4uz+eU4McLeNfwkH1OJCfBA38hy/ipPFpqtbWjYa+JcSGrzVNqUNCE/o+JrMOwY0rYKsTw4Bem+5ZSEjyUdT/KBXPrrFHtttSRYqq2yNpKSxXEV+E4bgVl9G91GwDzXzFZUuh6nzOJiFCvMiJ2IbWWgG+wXkvbqAXIpUU5jHatfy8F6oPY5Os33LpowR29NzNrhUsx4E1CLWv6hYwF9t7CmJXlsIHTofAMV7Cd/hMlaTrATCF31ekstHJF/qGeq4lteaKBZdDHH++ccfS6YtfTLudHCBzuSSH0mw7tjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(376002)(396003)(346002)(366004)(451199021)(6666004)(478600001)(52116002)(6486002)(6506007)(107886003)(6512007)(26005)(1076003)(36756003)(83380400001)(186003)(38100700002)(38350700002)(86362001)(2616005)(921005)(4326008)(66946007)(66476007)(66556008)(316002)(8936002)(8676002)(7416002)(7406005)(5660300002)(4744005)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IS9rsKk75EM29robJP6eFyoSAmIQjgYdarxobHPsySm2U+t6bvObPQ9Ti/PU?=
 =?us-ascii?Q?Xq1DGVXZ2FRiJzF/gQNMPnajIk5PE7fUNP/6X+bbrMQf35vOinE2Td6cEVla?=
 =?us-ascii?Q?sqcn/YtB/zYXTapSHtX1eXLIggCpyEn6mLQZKRljW+3kIdCy2dkY8inYuQy9?=
 =?us-ascii?Q?2VXVTlJixVZO4PGFVuW4nttNJ+RPH6mcctWr9WwUxPFXwKNyI1gE6HLobXxn?=
 =?us-ascii?Q?iVryZCtO6KDMrsBFTWEgg/5pTMPi3WmOXi4X06n5pYF6mu0LmNpUXooIQKEE?=
 =?us-ascii?Q?/p8qKmcAOWSWbyE3TYdEU53+Iaw+FZKvI9fk0TcpsTy6Oe4pF2401E15Pq/S?=
 =?us-ascii?Q?LAY+yz8xQSH2CIAT3zDgOQcSLX9iNfODk44AubOFtJyy3WslweHUoVqwhd60?=
 =?us-ascii?Q?8LHeKzVKX9uxxXRhXIliWe1Q/LK06y3mWifb93VdHq40zWcsesDEKmG8OIYt?=
 =?us-ascii?Q?XnJDBbqSH+jaBnrAzx1ccLXDPwqfFyyPDAs98EmdLlP/cE0faQvResS8jpFB?=
 =?us-ascii?Q?M2EGq/qpL6wtywjB9SGc8CuexWJ+/uks3hqRNu9/Zg8hJZI+soMivsfYK2j0?=
 =?us-ascii?Q?ZkFMdLSPfWCCuYzLJdDx2SzjDFG9fzABGcak/mF/Mi1JWxc6H9mDVX31NIUa?=
 =?us-ascii?Q?cNI9Cfz7sHgHs238YKBkxgFi2Lzq5nDLTw1bTjPWkO/Jtu5nRnwi3A1msPfq?=
 =?us-ascii?Q?ABOc4yCmDqwp92lJzykqD4v1PtU9v5d8PP7ko3kUsTO2DESE4nqR6u4heq0s?=
 =?us-ascii?Q?wSc4k6OQU2T3KKUAid62vwk+VzIe2lr91jVrs3OFq1T+Vcui/ZlyylA8F1e9?=
 =?us-ascii?Q?8p0nqF8e/o+L/B1JKMLveanLya2zRL26BzyNYmoId6txKnDyQP96a4uevh1X?=
 =?us-ascii?Q?/0Rqx5xduIKhvPCwfLg4aVgBKf3HQbUNwOmGijK58k5hnv6kefQw1rtj+hq5?=
 =?us-ascii?Q?+ys2gYKNQtGNuYjZWnMqIY4y3kJciV3j3XQxNUp4aeHJ5OsYivgDoWdHFfOi?=
 =?us-ascii?Q?WeSQiSbuQeJLQp3boYfkf/RTwpTy2wIdqdh1LTgjQTH+bWKiZ1LyhoIck2/T?=
 =?us-ascii?Q?GelpH1Bc8vznFcCeDQ2SY3bc8icPrtyRHJl/9mppkEo1JSw891R2oaBPrwlB?=
 =?us-ascii?Q?I9gIGF6F7MEMH79vvOrokmog/UjWiGj+3Z/AG0CgNDO5tANIX3xxEwgtrW4o?=
 =?us-ascii?Q?PGSqy8esJFG5E3iA4CkaaGNPjdd0s+N0cyUjBjR3hwHYd6Kt2LNspg/L6sI2?=
 =?us-ascii?Q?sP/p/s+4tN1BSmcu1VMVqnf5LuZ0EePCPHLHerT67aLUFSeKEzmgH7X9J82r?=
 =?us-ascii?Q?567TlrxtJJBvC1Wp1vwVbiTl9h/4T0gMURzhSxg081jsRfgcN2Qw37NQwIsm?=
 =?us-ascii?Q?0OgwbjzGpFubHfg5DmTQMVloXXioZHrIm3Ov6FkdsXX4K91Kq6M0+idRsMDg?=
 =?us-ascii?Q?iCcOGwm0ZobPkbckhpdvitGrvhjqDQr4AgQtQS+qDpTTPudpxrFVwcauIK0a?=
 =?us-ascii?Q?6hVW7j3A8IksGfqnAXx8zQ2d3gtnfaYq9VHDn6R/RHIJva0kSWEeDzM8e6m1?=
 =?us-ascii?Q?qhUbkqFuaaju/k+deUVtp2Uhqwz4D/av/2ZXSYXL?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75fbeba0-416c-45cd-8336-08db6bf48fe9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 09:57:13.5933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTN9tOth6tEWoUe30hvVaVRWA69bIOTGhQxCYMs70xkupKmQEEBWZaucFk8KmT22wtAvpODqC/O2CujEYhKkdQ==
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

