Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB0972DE6A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbjFMJ5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241474AbjFMJ4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:56:55 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2106.outbound.protection.outlook.com [40.107.255.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B570D1BD5;
        Tue, 13 Jun 2023 02:56:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLTSmsbhi7i4nUUWRBTmeJkGUbqqkVCyqKzX2ZKMw5hP4joOvmDePwp4CsUHXqco/pWMe6hftnr6oot6z5/0AVmJJS7LAY7wQUSNS/TccTDVCnGRpWchcxjdmwaQC6YVhesY13f5JD+iHoqAW0MW/q/g8kpUL4BbJNRTaqF39KhOL0IZte7z7kISh4ay3+5Z66e/mREDQ+9I3mxGHtJsoMFGjoy2WzR319eEbDyEUrMEN9KiTjNBNqHrVUFeFM/zxnR8ofkCKHpRDsptV1dAqjPR4kERE37ec7PndQYjjrlibPORqCb7xotWv6Vmj/NJAMK0jRaeGcDu15EWLq/O4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgUHWTc8w9uXoZ9FmOs4xU+yjuY46oZRm/AqUHLmhp0=;
 b=G7aWWL4FylmrzoPEMSaYOS59A1lDPFgi4TTx6xuBvdb2xE9F8voqV2dN7KliSEGexErNvsa5GFbOtm26Vb1bzLGU9K2ACMV9m3BvixTXIp04o0M+yWd1Cj+QMEJ+MPYg/ehtLHM39t6MviNK0NPZZb02N9vFlfAOLzD6hZEbhDcsLHaob+wxPJRxA109zvr+8SiHImifKJY5lf+x4nFq/pInVU/mUb+5Ekst42iEYL+z1pSdbxXtnH0WDl65IfettoCjY8PdrQuGNcJ8QibmdV1ucFR7O+4t6AlrHjcrqdjaYx5fN+053g55dlPoNiwDVBCmEN+07DJkGbnV0crCZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgUHWTc8w9uXoZ9FmOs4xU+yjuY46oZRm/AqUHLmhp0=;
 b=dj3M1cu7b0va+GFHEXe0G4j1uKkhHW2sdRflxUN384l4jMdZpMqyRI0KVVMGjNJihuyCzHuFDunfOACMhJrehAvUSOhbh/c1/TEl38eLHx1eIw7nAjiAQlXnJPuvtHyGOEFNOUEEnWlgkdD+6GOhhBcLtTcEV6afthQND65fKT+dUjzVGu8lya4sgm455sAOB5FXC2NNgnnED7OiS96HZZkRGH7G4nWKLAszklzzDPqe1D+O4MSsrHab3RLLXNsmrdnkLn9jVBTu6aAEpaOasqlmkBdY+a7raYR+suHc9mjzXlUflJazR0hZt+9ocBLcNaja1G2XcJEXqraG4fND8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4012.apcprd06.prod.outlook.com (2603:1096:4:f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 09:56:39 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 09:56:38 +0000
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
Subject: [RESEND 1/9] thermal/hwmon: Add error information printing for devm_thermal_add_hwmon_sysfs()
Date:   Tue, 13 Jun 2023 17:56:16 +0800
Message-Id: <20230613095624.78789-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:3:18::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4012:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f0c09d-eb81-4388-4502-08db6bf47ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iVbodcEwfJ06GuaAFyq2QmgKS2CWgmq5KMceHodqVJPsXi/m8tXdlx1F/kO/CKjNv0LtiGIOcdvWMLuzy23pLZWpUlps0ms/QlRvjO+i+DVzGflD0M3N/a+JMvH6G6iVHij2/NOrL/b6SiBsxczFk4eWGcfbCUkgXCHErFAS2TtOGv7pJD0MIO5y5X/ZYsN3mumISuqCB0PArD+lSTBkrwbxqemTU7OngrHQghGEsf1I+NVSMudxiwJZr/JY2LpQ4/n3MFM1UZZAhU2T9I1N/AOJAW/yn5J1P5CukZGk34ORYqyKLz7y29NP4tDYDW8Alw9IYaHJGlwlqgtEb8ONquBr1ljcpgHaKFw8ZaNBXfuEJ+BA22hhC4Z9o8xWpaZ8hai34JPESBjWw4Fo6zcyUdPae4XPWonCSJnEGN1nQoS2hugYuc0zPDEvBmNGsKB4aC+lh2PpnyxApXeNZ74ZWPyX+1Q5WsyQy+is7ft0SlnKWJ9lxEA60LblkSsXb+fp46XlOV32NfQhWjh3N/j0HrugLCz9sJc7OM6TpToO9CI/tWT0UvYaxG2R+yXUQ8Md4pJcek1Nq/aQJ7W6EsyM2IXM8ic/m1J20qWj/NTrRzK2EYm3aMm39nH6+V+HVK4q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199021)(4326008)(8936002)(66556008)(316002)(7406005)(7416002)(66476007)(41300700001)(186003)(2906002)(66946007)(478600001)(8676002)(5660300002)(6666004)(52116002)(6486002)(107886003)(1076003)(921005)(6506007)(6512007)(26005)(36756003)(83380400001)(86362001)(38100700002)(2616005)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PkovJBVBwalxUd6yVGZZ7Zc9EOhF/vgSPkmecnEeoYNW/PcG4a74d6ytOBKy?=
 =?us-ascii?Q?WcjZToECquF8xM1UlBRXMn6f5FTdleSLoGiONAvO7U1p6w1SdsXY69Tw4TUo?=
 =?us-ascii?Q?uTuVH1Ifsg76ccunyjfSBnEEYqY5BOjYyl0Vey3WMKV4/FvOot/r52G71aEb?=
 =?us-ascii?Q?Lh66TPtUsLWDZAHibPvMKpU5pQlpx8qalGANLM6Uis8NlkRMMfR6AtKE/93O?=
 =?us-ascii?Q?pH2jmDYEWNJA57m2AgYRJg7DhtkigzdaDpIekWrwz7bfm6IK03LS9PmyjF1b?=
 =?us-ascii?Q?h4CnTaeuYd1WTf09hBbD03ffe0NmG8hRQiEfgeF6a4XaoZqe3OerYTbv6C78?=
 =?us-ascii?Q?G2QBSGNkQsm7pEbw5WE5Yogluz5OpzUwCXJBNfT4jOUVXGI7e1jJd72MEGnk?=
 =?us-ascii?Q?7JugLahuOFGCWJi59BmC6uIYcsCzvgalQCLWSA8pAh8tWTFfmmwiFG5ZlIhA?=
 =?us-ascii?Q?RMxEHF7m4Xu2gusvSe+xqj6+tXhVHb8S9qVNe31FyLBlIo7nP4YqJORcO00v?=
 =?us-ascii?Q?jwQ/csZkBygXmORc1m2TII8s5Z5gZaM89j9gfrn9f1osALX2mTPi+vPU47KR?=
 =?us-ascii?Q?ZXGiXrm9baJqsQed6W0m02SAC287+D4megeGa9g6dX+GFM1cOTNoNIX7aN9/?=
 =?us-ascii?Q?5oiIRAA71kiXF2xdZCW3nIdkLDQ38alx5D5zXuyT8fKcVSmlHzZTT5+TqIzj?=
 =?us-ascii?Q?rhDqytfDdKk2Po4O26iM5khGXoxx3t3KnIgyVBag4Bd3JskAMEfw3cBNSfts?=
 =?us-ascii?Q?3Y/qyN0yO+36e65Ffqz4DhLEJWuP12zCQTbqik6V2eFbomNiGwNnLHxL39V6?=
 =?us-ascii?Q?JykKW+7fM4YF2duZXOV36PZ+yo4lITJxAogUY1kvm5vx9iJdZKrYHQvDgJNL?=
 =?us-ascii?Q?cks0FuqxUf2KkRdeYjBkfmyJ5DWf5xAjyeP/ND6QxbY4N6Qo90rN7GJ4NesP?=
 =?us-ascii?Q?K8mKYE6rUWnff3w+bMRIZwXwA0Qq+NT7M30QbdcqZ/GHDuo9LYhVgDhJpetY?=
 =?us-ascii?Q?Rqb0XbOjEEoQJYg/2vugwD25TmEJMFVXORXDWk+EY7eVJDw7TFUu6xuCg2vg?=
 =?us-ascii?Q?nP1rxTc1dNsgtT/ekEn1U5kqXEdLUktMCFY/Uw/YNipEqH8cTSIJaxpex7+P?=
 =?us-ascii?Q?iHXu00+mDJwYUWBv1V3sB1QsmKuHMIMMGCm4mZdxTd0zUcUs31OJK0LRIrPV?=
 =?us-ascii?Q?48PI4FHtj6QMQF6bCMIV0fEpUnFJgNvo3oIDvBfrOY/ozDYQWJoBs0tC45WZ?=
 =?us-ascii?Q?6i/3SfYSze46+o/Hzn68l5ujuW0UsMx6SzRH7oiZ5ZeTH6I2WsREh1iakC7j?=
 =?us-ascii?Q?k3ij7i+paP6M0kpKXd+x7Fl4MwPTZ0yC4tAEMSgJEyBMqvdMeZUW+eaWpxhH?=
 =?us-ascii?Q?CmpilvXN1AaDZMB39Z74jnc+Np4kCqZza1+ECTDNvenF2CLm8qH2aSVgrsjw?=
 =?us-ascii?Q?YakeVvQm2xi3xTdxwnsndFokYYl3kzWAIf6kq1icKA+EaPCijWd296bMTJH0?=
 =?us-ascii?Q?ckphxHoHjH/KL/nqYnNPCt2/9SqgMu7QkAoTcobpz0YfaTFw1wXCQXYnsMpD?=
 =?us-ascii?Q?o2JTRpj/qmkII0QAqbL2VqzRYcad5vKx/WKga3En?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f0c09d-eb81-4388-4502-08db6bf47ade
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 09:56:38.3657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOfQ6gJ3ZWkmW0VC2s3VqfMQAqzhA23tWix5WZuZ0eXwAqa6I6NeLoyDfdzb5XOHAW7ho3veECp8JAcOspzWwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4012
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
Resend patchset so that the changes to thermal/hwmon.c are copied to everyone.
 drivers/thermal/thermal_hwmon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index fbe55509e307..a580add5a2f6 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -271,11 +271,14 @@ int devm_thermal_add_hwmon_sysfs(struct device *dev, struct thermal_zone_device
 
 	ptr = devres_alloc(devm_thermal_hwmon_release, sizeof(*ptr),
 			   GFP_KERNEL);
-	if (!ptr)
+	if (!ptr) {
+		dev_err(dev, "Failed to allocate device resource data\n");
 		return -ENOMEM;
+	}
 
 	ret = thermal_add_hwmon_sysfs(tz);
 	if (ret) {
+		dev_err(dev, "Failed to add hwmon sysfs attributes\n");
 		devres_free(ptr);
 		return ret;
 	}
-- 
2.39.0

