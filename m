Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A0972E177
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239989AbjFMLZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbjFMLZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:25:27 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2116.outbound.protection.outlook.com [40.107.117.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179C2F1;
        Tue, 13 Jun 2023 04:25:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7HWitxp+UrRnqZx4XIZcAqBWvX+L3zRcFf0Dvs3M5Jzzd7awOSODLNgNmbuZa/DoT9zwhaThT1Jqk6Y/VW6OjkSdjdwMSeMGPHfS2opWNRBkf+InXk7BFLeH5IsbkZc9SwhDcb4aMPvuFAou6V3QNZg1M1HkdOsZXSdGSECdzcXz7boWaviey3J6DeKtzRs9GOS9mg0ZtwTxt7InN0CRqkBTz+88AbJN8ykPOICJkXEqKJ6GMn0ugiidL1RZLE2eAFV1DQBSoDx+X/eNK81mRr02Zr8ghLgmUqCd7LPkEvWwiFSy3Hx9+SWtx3jlIptNFReaI+4Fj7DjoRj7aORjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24Ha1tRsob+jqsqACWErpPA/fxmNzTh+5HmmKy1c0Js=;
 b=EfpiBN64CoGcPwr6JeAkzTdGn9IyYhvODdLq9Z2Qp+OZW4qgqBEQgS8X3dzY8aEWPmpb6UQ4Wu+zyoploLVnhXgU8oqnzi6rJ/cdnsq8yLV0jcLdj7wEplz2gKk1yPayLWhoPQzcuYiJrbqr8acTbmMj7QjYJSONpPGNqxiXVdzHjG38UMlpQE/kmLxHyW9NPeuq/Zus71lLwiifZXYvzT3z5dF0Y0Wff0ou8eiE2oY31+LHUuBydg6mTdjrQcqywg6EGL1+Q9qyiqr6rzJaAvLVhU0POOpSPg7L4g0myJlTI9n8QjVsqytT77LncHpRxOCusK4jqOLWVOETlR0MLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24Ha1tRsob+jqsqACWErpPA/fxmNzTh+5HmmKy1c0Js=;
 b=m/2eYvLY7KhTPF0Q5ZszFyyI0+nsebfV+YfYHZvo3/L3E6NE23+m4b6xvszNQZHAh6OG0Pr+uuhlN7k+XLdusS0iNboKdp3Qh2aPPE7JjpmyeyaJCpGcgmvjEGFxV1jxqp/7bdidiCbt0kMKdaooiT63lJ03exN6zDGVPOfNXzFy4bMiUmcN+gggA43zJzaoGSzZds4c7FLxokh0cxGEJ8B51nO+r9gzt4OidMC/W/T43NQNvkQ5KfSMveelD3XlnE+s9CFd9rpMkLPmb779g5n5PByqXlpNnFVcB4984uYuaxTT9RPdju6uV/64ZeyONfNotPmsIl2P9I0YsFz7uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5920.apcprd06.prod.outlook.com (2603:1096:101:f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 11:25:23 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 11:25:23 +0000
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
Subject: [PATCH v2 02/11] thermal/drivers/sun8i: remove redundant msg in sun8i_ths_register()
Date:   Tue, 13 Jun 2023 19:24:35 +0800
Message-Id: <20230613112444.48042-2-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1ab40e93-64b8-4baa-889b-08db6c00e0ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0mNh/g/t40FlqGp4rGuPlQQ5N1iTB5vM4H8cmCp4dSM96KcGY7qXMTPxgD0uhOZu6HvYofzEw72ivDg7XrbBbjGzNis5ZiXyIRyqBQhvlJ02E9WRrP9ScvzMYxT4ZHsdx+G4EnH/z9tzsIycYQaPWsTwe8Vm1O+JNQA7Qk9gPonx6lNLSS+VRtXmKVkWx7XR7EolQuFwoD0uzvKRj4q9E35E5V69ziTLZ9MBKqA0u8LiTFJZDkZ3GqzBiW64huBY6WDm2WDDwghhix357F/AWeEuyz9fcCoKhhrO0jTcZb+j1+A+VBxlx7/gEyWevdmIfuvZule6ULlufMNOZvfJfsgPmLXrth9jjacQZ428YwvmgZ5sA7X64KHq28/XotiRUcHkYyr1Ow6Dtf/QM+xJ637Q8fypFYHVoBhiAbL408w5wdW1xUfmsSLDPK+Yo7vqhlrOc37VXUTgeMYlGvVR0HPP/dJ7WaaP4hOPXUz5M7wfrdmgzaPrhZdLgGjN/4Ye82Qhlc+CVTrepWi6cAl9/rF5G16fZDTadjGY5lQMnKKh71A2gCFhyaCqRApx5ygC+bW8mIpcoQWx4iSPeRu9SlV0p6BqJp4phrhGkCvT1A8Hrzy6ACd09neSJ6Iga1sl/wy8bnKVhnZLnhbHYVyflA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(66476007)(38100700002)(66556008)(66946007)(921005)(2616005)(6512007)(26005)(6486002)(6506007)(478600001)(52116002)(6666004)(36756003)(107886003)(86362001)(316002)(1076003)(4326008)(38350700002)(186003)(5660300002)(8936002)(2906002)(7416002)(7406005)(4744005)(83380400001)(8676002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?piwdHwhi4kSkjHrRXn2aqvzQCL4e8Xfm0tT3EaDeuL3SKQkL+3qQ9vT4ivmG?=
 =?us-ascii?Q?7bKL199mF9kS6XiOOVYYJfHCVJKCJvsS3zpu4e9SFKbe9F4Q0+mET7y3K1tH?=
 =?us-ascii?Q?RnCxPazDV5G/MYWsD4zCu8tr4WYsJogdPealDodJmKC1owWz/OIzbsbjIoPF?=
 =?us-ascii?Q?xb4/JqAy/5sQtXjVCET1U2l0qnNRN0K5qy4RIOq9D/5qQ8Rxsgyoeo9MUQyz?=
 =?us-ascii?Q?9+PlxUnTKcd+VCradkYjlSyS5gPJvGlpqxF34jHRLdrz/JlxLigLRhY+S9Uj?=
 =?us-ascii?Q?UVtwaGiM7CtCYYxNdepSInqbR5Hih8ayhd5ClWZOTUF9aINTUea8qq4oHTbK?=
 =?us-ascii?Q?gwNgb75UpJ4xaajdlThXf8egtcEU/Ni7bX535ke64GELsQGINZ1xn46GXDWu?=
 =?us-ascii?Q?1vUfaw35gG8Ze4Ab6qmK6x9DWk0jf73udMLjnrXLZZ45LEV8EN6De9gSYOdp?=
 =?us-ascii?Q?7gTbPfi8r6jwNqfriCChUanumbYBdHyx+4Vv8MHwbmfMGnBS6ddo3k3PEWS7?=
 =?us-ascii?Q?YpZDrAEnI0mQEFJI06vmXfa/TC0/j9tBTBE8ysh95lO1hK3nQi8TZ9sialPs?=
 =?us-ascii?Q?RDUBcJGjsIQcidiWuircIImjCS1waqoRo4xfftH3wtaVpsTRO97JI/eXgYn/?=
 =?us-ascii?Q?bW/gkOvP1wMxV6f41LhaRMvFV/VtvOhppBuXq6chpuM2LlBH+D2d91YDFjYD?=
 =?us-ascii?Q?SwCk9R5StIJyw8reKq3F7D3g9UP6PWHImsfjStOL0eky9Ft32W+FA2Vic88m?=
 =?us-ascii?Q?HDc9RY9qjb9xoI7LfUXg01GH4t5IFpv5a6bSEJbxQcXtqgUSW6OKIi1G3ZUY?=
 =?us-ascii?Q?ed7A5dEnuCMY3YefauHbDSuY6JZqZfexI+qqVasvcms4QchouqjbErR64BwO?=
 =?us-ascii?Q?lAZWdTNGxPVzwU73Ywi4jktp4r6XwOp1KY1dHf9Kt0WcTSpfW4WPxORmFLit?=
 =?us-ascii?Q?WRpm8h7wFHub/zyPMzfir11ZyaWx8tKkoNfvCyGjUYiQjroYiPzrgRC74+Li?=
 =?us-ascii?Q?2WQ92s5Lb0LQoiIIZ75/Oh6wd34fLa2UqzLtb8VD9ZPRFw6aZw/luhw74wNA?=
 =?us-ascii?Q?FGn9quTgacNWcsDxSCTWzn4rM+kULP3zhjfKBIwqoANrKHxr2m3rrvcdUJNn?=
 =?us-ascii?Q?/nyHsxx/MnIkN+bhC1fHpkuh3OedY7i0zy74MrCv8qgB2V0PyqHEFTn9LnBT?=
 =?us-ascii?Q?VxoIo86GUrZuf17m/26gRS+05L5IDAnRGf9D8bP1FrKy7NtkbV5kjeK7/li8?=
 =?us-ascii?Q?2iXAnHHGnttda/r8g9YCwOu5JGvGxafPKHzeSygGAZA1ubEcYDJykhyYUMao?=
 =?us-ascii?Q?vos7uFArcTOSFXc47Eul7h22xvsF7GrWRvPvlRi2oygfDSFAcO4BQq7P8kL4?=
 =?us-ascii?Q?XrsKPzC57t/ut+uDxvuFQOGmobvSkhNBTsgItRuVUqq++kbn6kWAsoUgqcVx?=
 =?us-ascii?Q?s6k8hcI1ZWpuLqOqozD+bUGYhDre/whQWZY4gROQ9t2z9sDZjUhj6/rRwpsk?=
 =?us-ascii?Q?9GbqmKMIyhrU823sqwOKReyU/eHhZ2hpYqrp42msDEj25h57X0p/bPX8VBGN?=
 =?us-ascii?Q?SeWdXcGFnIaJWBQs6OYLdTuwsdTPp30XuoTtJrLR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab40e93-64b8-4baa-889b-08db6c00e0ba
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:25:23.1373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X49UvyTiqnu1jm4X7ku0db880B1xJPorQZ0YF9GUb1wyC/szpa6+vjZt/yy6uSExFYlz8E7aOsaSPlXUs4YUzA==
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
 drivers/thermal/sun8i_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 793ddce72132..066f9fed9b86 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -475,9 +475,7 @@ static int sun8i_ths_register(struct ths_device *tmdev)
 		if (IS_ERR(tmdev->sensor[i].tzd))
 			return PTR_ERR(tmdev->sensor[i].tzd);
 
-		if (devm_thermal_add_hwmon_sysfs(tmdev->dev, tmdev->sensor[i].tzd))
-			dev_warn(tmdev->dev,
-				 "Failed to add hwmon sysfs attributes\n");
+		devm_thermal_add_hwmon_sysfs(tmdev->dev, tmdev->sensor[i].tzd);
 	}
 
 	return 0;
-- 
2.39.0

