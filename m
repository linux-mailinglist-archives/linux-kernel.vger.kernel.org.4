Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2414172DE8C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241957AbjFMJ6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241438AbjFMJ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:58:16 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2093.outbound.protection.outlook.com [40.107.255.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E951BC0;
        Tue, 13 Jun 2023 02:57:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsr0DxNNeyHpZOpmzcNJri3bcdaeV8GnFsjT+FNssXcL+kgshdWkXm3VZGSnCtL9+3G7vHZIkMy/t4boHp5wl+YhYYfXSw9RQbUnjg1cMQ+i3RUGGyXNnG2iFVvTqtmun5FuXb62qnkcBilaBlPU/EqZ/GUbnLY9/qqwqT8sFP0ZAc7T51P0GjINt53toM6LTxYAyd54pjhJSNXVnN15WH8vpa3u1qvellda/3p+iiwoROqFu9pfF/RartlVnsUXD2ueO+LBQv9pC47SIjhh9w6VuFLbBOK8yu9x6bvodP53eVLcszojSnFZVuJFTmFtn2G0muqqcXOojo8GxB6dtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFRIpDy9mxKf73VaQXtUPoyL7qnzSdTF1HT8l2XaQcE=;
 b=ZVYMd5TlkUOgqD95T8OPOBhgcWDCiewzYAecTzQYjWGzZQJoAiEJGB3pqaOAt8KnYmUPf4te752jCTDTdAdD6BoeT+mUQ22W8Q0XSZKi5EbX2CWM7iJ8Ecskb6yR/rZWO0LVVJozODcQO0RIv29H36rc1hNWJo60K1BBCqRSvny+AbV4fZRLepXEklKhAJN63pdLIc2D44y4H/1mMHXTeTfW6I1YYOaIk8UepjMwuBOGRHvG4056ilXKXF6jRFD128n6Aj3pLG7JMuLJaUHpGj/KJxRc4XmoQi4goKcQRuBQsDgUxU4oVo//H0pmmBDCrvnZcsIaplcmxSJSpncxCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFRIpDy9mxKf73VaQXtUPoyL7qnzSdTF1HT8l2XaQcE=;
 b=kP469xEBH3FdjUQ1WKcAzPHYgd1L9KRqG5pmY0m6zfyC5nviykbfC4V7aJbah3zyU/96vppbQoNm4ORUcaqi7wJMZZ5EdHyv6VsXOq1/Hvs1csd1VBQWDyF7qg98O3AVon1Cf1tB6SiS++O4++WjDisuh0PrpIpoI0HmGadc7TKs/jHvotAj9DvLdqIAonS1vvHA6P37wKRwY2eGMXRt14CSllX3ZtOxCANpIq/oquUsBJNJd5OkaPmKV9J03hPXmMZb0ypOy+N1dpJI2I2C0/g4Nik0wS47HcVXBUwjqOWt/dS/KeXz6LPPj4Yma9jdp7dlg/ZE5j20nWJ7In46WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5784.apcprd06.prod.outlook.com (2603:1096:400:268::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 09:57:20 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 09:57:20 +0000
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
Subject: [RESEND 7/9] thermal/drivers/qoriq: remove redundant msg in qoriq_tmu_register_tmu_zone()
Date:   Tue, 13 Jun 2023 17:56:22 +0800
Message-Id: <20230613095624.78789-7-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5ed2beca-81b4-4c9b-72ff-08db6bf493d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b7MSZC5L1SHrEbhgs/xvu9wdsFYP3eCVUnXtYIlpjaDiC21LAxXY6kQSxyDaV5XpiUV4QbsAkJADQHWYAJFFNAhrQoVhAWIkZP5vRdRQgy4VYuWfFqdlDLuOL7DSiESUBp9A86hNuS0lvMuJiK3zqeDbca1KGtIniHVSairk8jxe0Emmlqk1O1dxuNOy+5HJ4JJe0WM98mmRpsbfwuJT1v/nVTxognS4LbYQUaHWdGZQ1pH2K07/l+xtd+Hl+T2k0QyCJY3f5aZqlEohj3CGzyB6Oo497s0/BfzhvnfAG/VjJsjyuD53a4qX8pcu5BI+0ndYwBUbw2rEtoXnBBZXoNsgdcsn7TihK65nK7NUaaMRbsJfOKQdw7inNTJvyex+tc6i2eJ1KFkjRc/QKb302eJok79n103xbgtTT585bHZh9mAIo5LiENlYv5I5tqmwRlvQt+0XuC7v++fI02m76y3yUJbbdwCMVKqdSlVoWwYY/a+fQ167dnfkueSeafL+1tXAHj6nSJ9LpMJNHVCEKFBtpdxdH2AQW1q5urbyVrkGX2FG3Cl9+c+HlTZqUzS9yHyzYjwoLQm7VGrh/Jk2t/mPfH6RhJKmveqRWGlgVQ0e8X/0xQ1duD4P7aLyuAvAkHuENQxd25bgUofkzOxzRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(376002)(396003)(346002)(366004)(451199021)(478600001)(52116002)(6486002)(6506007)(107886003)(6512007)(26005)(1076003)(36756003)(83380400001)(186003)(38100700002)(38350700002)(86362001)(2616005)(921005)(4326008)(66946007)(66476007)(66556008)(316002)(8936002)(8676002)(7416002)(7406005)(5660300002)(4744005)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oKXZzLxqwhV1eRE+l8Z8eHlE2yio6SlCc6Ka5euJfjF95XeRx+DYeSXjgJV6?=
 =?us-ascii?Q?BGNAzjuD0oBmGkL/lq21r+7qfJT/6hQi7i9l6mEWg0tcX+Zk1xZQocGRWG3S?=
 =?us-ascii?Q?kwT1WqjWTrMTMTPVfUOaIDKqexqCAPqn7GwM9IGVzFprZPJ9aqA96XPcdGLU?=
 =?us-ascii?Q?l79rCyBBl8UIyAejzpxVfpJyDcCDvgA2/YzWN3v4K1EczOt2pvAI7d5Je5lY?=
 =?us-ascii?Q?8EPCR9APSheRbB5kPoVlrmKu+HDWkwh1Y0HueuofNPjCzNob1LeAWo3eskJy?=
 =?us-ascii?Q?jX7BBuzdryT/nkbGhLZ0XrB26tk5jAqNcIlWzwELqaJK0MwEW4wirqxee1WD?=
 =?us-ascii?Q?/gtm6NYBOirkn55oM3Knu7GNo7Qftq0nuRGOQ2x4CYAlW3RHpXUhHnY72P5M?=
 =?us-ascii?Q?h/EVYfOqTaTlW00YLVzOhQ1RC4dFDL9b3sdOocNfsAi917zwwzH0SwJDkYoI?=
 =?us-ascii?Q?GARk0dv8C3/RMmY4AVAktt3RbNKro1ZPHk4cyke09rdjkArDYE0FGCBKNiY4?=
 =?us-ascii?Q?C64xSQXQ4DXjNWqBl2fnajx3MKer/++8tDR9OJZkar65nUjH+nJ3i0mkwn18?=
 =?us-ascii?Q?M/gddh6iQ9NNXL2CL4ScuDWumOSAZeKG8PJvUR7yvr/8zRvCkbLTTHTxstV5?=
 =?us-ascii?Q?mLrlmpMkTNTzXr757bkRSo1kHVEo6CbbM3BE7uoQARzNMoQm1V+y0YTm46M1?=
 =?us-ascii?Q?owKeHDJ4u42H/Dhaexf3Gl+TT4zR66HUmpNbbHkaVRx9aQzhqVzTFXnxCkS6?=
 =?us-ascii?Q?Wf4/hX2ZrzC9g8JvROmW0IFplPe2gFJOFDGg/MqgCvN1iaKOz/kcdtvrW802?=
 =?us-ascii?Q?qR6OfWfKQ2LU8U3vRbn00rADQMrBeYuE/AX+ICcYtPCyMUQxCzXRnqp8k2LA?=
 =?us-ascii?Q?4ycOLxRLBMqKpgWaPr3OZRJKv0yTYkN3dBb9ZWtv15cW4N2JUPxHAqaBiik3?=
 =?us-ascii?Q?d82Dq5GVqaPOA89qamaeVQEhOq2s5VKPk6x8GozCuNBlhtx3oFct4ckcK993?=
 =?us-ascii?Q?m1O+bY8vQuKgHuWMD6BZ6HBLZgaC+M+GyjtSMSwgfmEkrxV+omT9JXmVLmir?=
 =?us-ascii?Q?kcvvjw0dE4qEhQA9tE7O5/KK0c9WumnjjOZ6WU1Lzp0OV9u0Kc3g4XHBe05M?=
 =?us-ascii?Q?Mg8rsEFho4FYZ93kmqJrWts3E0B0nmfVhQAd13oI3BisCAcR9QDTGzdGRdEx?=
 =?us-ascii?Q?kC6TLu8Bj5uas7YZxfqr66HPYlAxlTyDzXmPS21bOFPJHTl6UKPx2r7bGNgA?=
 =?us-ascii?Q?DiqocMA25Py4bpZ9OIjV87oWgsZfSMvXzhQRJIYGESW7nD4tktn/CPanGo2P?=
 =?us-ascii?Q?m4/5Q4ZJygmaEcMeI+A3CocuJfZVxiZGwj++gLZp87AEe5kQpOX2XkD8V45c?=
 =?us-ascii?Q?DF2sGuuz/RB7fSpWgnR9Z/KNcJ8yPtYmUC1LscvDnehg98crB6CuDFW0EzVl?=
 =?us-ascii?Q?7KxstXTtBP9LD6BnknaFss+1ilIonLnS4cYkV+KOhKyXuvKq5Kp6p1XG+HRi?=
 =?us-ascii?Q?f2YTkpyQR3hSMbz4jVEOx/ltEXuZHPbHrqY6DsVyVZEYmLLK3zshbnjji7Hh?=
 =?us-ascii?Q?cz87EphHeTBx32a8gYy8njP2QsD2W4olWgKp1JXi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed2beca-81b4-4c9b-72ff-08db6bf493d7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 09:57:20.1767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdRQfjCjLUMjh+yRBMmdmD1TNdn/+Zd04XxnQ99UZIGExwnKLKFr/HfQ8suvXK6U1NkhgttKPqf6pDyk676SNg==
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
 drivers/thermal/qoriq_thermal.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index e58756323457..61b68034a82e 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -157,10 +157,7 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 			return ret;
 		}
 
-		if (devm_thermal_add_hwmon_sysfs(dev, tzd))
-			dev_warn(dev,
-				 "Failed to add hwmon sysfs attributes\n");
-
+		devm_thermal_add_hwmon_sysfs(dev, tzd);
 	}
 
 	return 0;
-- 
2.39.0

