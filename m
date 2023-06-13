Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0989A72E192
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbjFML0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242215AbjFML0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:26:33 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E041F173E;
        Tue, 13 Jun 2023 04:26:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nk+eFAcvpH86+aNdlmJfJxVtmL9S3w5gr03CaFkMgSQCz+BwsTQEUPwLPly2wApSX2nWIgbxzHXO59SiIFhx2z4etBfA9SEMVq6n3Z12+8D6S6b+SO6hcnQGqqeHPTHJ9QWzZtO/6xsJ/ppW6tS/umPEOWavGGELOfIRx7yK3etwbMNkWvIu3iXEyCJcnZQXH93mgWGF04OPcYlQJIHzxYNqPeYHpsCjlOSH8rQsakg1Ik1vrJUzmaOOvukcCzz2z0yrBSGplyr3ShjJa6cDUpngQtgdO3pD9L3Q/G1cYtE9aOo8U49Q+28MH2cOs+ZtJp5gxxLG1EqVHyqaRhuo3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++scUHKfsZEh9T42bK/jWLT1eewDohfz3H5KcioCgI0=;
 b=QlmtU1rDJmQLzR4VPtf0hpyor38wS95a/pPhaIJ4JJ173DbJccARAcBgOb6RdAzJB8VwtnqkTEW9I7ckzJEpiwXR6hvIBcsKr1Mqr208DhWCuudf9G4bM2uMb7VBkNSZB65qmF8F6/9UH3BzSsgWqd9Jo5cPa8VlMfYMHATpdtr72f7oCXqo0MnII8WWDGG8JHRuxc1rsLBYC64fRQ+H+5JUzCfl4KLvXnfhs/zzhe6YR0/drQT9n5wZrSVr/7mMeQPQW6v5VWVi7i6wxw7s63pN8dRnZdNypKakrBBBrC8sJULvejREDPBz9twNJhdZnvZvEDBC4Y8P4xuCjGjWAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++scUHKfsZEh9T42bK/jWLT1eewDohfz3H5KcioCgI0=;
 b=MRdUzgXh5xwZP8ss6ESj3ISsTprtV9WmC7Vs8Hom9V5PFvvmISI04Q6PRFUE9qO2O9YEorhFD9ioIMr6jBlMiBTPGi3sW19ShYHQz2ZXGMpMtLV4rl7I2wZh07bThKTXHnvrmEdTJ9tDrpRNopqTCQjgdLzkm+VS1lK1o9XMbhlJuOaRyXo5Qrj18gL/vm6RRj2W+vyMJ8In/wfWZ8PZy3VtzabrOiGfX6QKjVzyxmxPk73iwVLuzHqF1F9NJcSZc3PfdfHYHUbIll5PnggIH0xixrWVHDHTN1lkn+QjhPhyVG7tqoob3Ygc75BHvUht0P1vyk4c2ZuCh44F6ZgPFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5920.apcprd06.prod.outlook.com (2603:1096:101:f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 11:26:01 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 11:26:01 +0000
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
Subject: [PATCH v2 06/11] thermal/drivers/tegra: remove redundant msg in tegra_tsensor_register_channel()
Date:   Tue, 13 Jun 2023 19:24:39 +0800
Message-Id: <20230613112444.48042-6-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 20a1ed1e-b5ac-47dd-3da7-08db6c00f756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRwMBJVxbHSeg/lHM7pjYBtoC31pAVsA8EyMH2edNscAeLG+pW08//DwWa1EZGbIjiDiiFGwYuHyconvniHMVFatRsWM6sIQTGDeisRokOCS3dVXoWNNfIvPi+hCA/bCMj54M2HYQbCMzfKN1RrRSdLC8Q1fFdlTQq/e6WySbCtkdvc/iXNmOwrGsvaKOrvBx9h1DzIluW+ueuJvNgEAT09k1OJh3X5GGsEHLClPMt7zN4DtpeEZJ5qUL5LXR839qn/IpARdhvJa5WeS5CFn+JIi5u4jkGAhUe/mgLLfBr1pl/p1KPIfvwk68MzER7DhTV52Xb0Ly+lW7Q85PWtnpVSnEyRu7PKrllwyvTyoHJzByCTvpHt369ELX0FBL/T4ONAIIQjJ9J0fFuEblRZZgU1dEMz+XSA2oYB5PUrZcn4yOBxWFqAmnaZF+Yk0x1XwOIcHt7anuPcVzQrOk7rgotbpANzJzfsDJmGSXRfMr3wwqku9YydTFxd6p2I7QcfwH5E/xZ5CHqkihWcWSb3/1+qiXHlsbtPQczs3dFIYsp8IlJYtB7QmQTHn+0dlhMGQeJuqSIPiuOTNNrU6X3UWk3YnorAXOitp4GgHd+qBBRP6ByUgfNrHtP864fo5m7gQSvLU7AD7/KcO1eZJGv84qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(66476007)(38100700002)(66556008)(66946007)(921005)(2616005)(6512007)(26005)(6486002)(6506007)(478600001)(52116002)(6666004)(36756003)(107886003)(86362001)(316002)(1076003)(4326008)(38350700002)(186003)(5660300002)(8936002)(2906002)(7416002)(7406005)(4744005)(83380400001)(8676002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sfflQPJA1G8eO2P0QHaw7tKixVFNk+XWyDvatyLTaV/X805YvPezr41mlGMD?=
 =?us-ascii?Q?ypgd1mJxilynhr3K9MNBQx4EAWOlrUWhnDOAkNxexoCcybsqCx/Ratcp4oGC?=
 =?us-ascii?Q?3O4LsElao+ACnYOkk3Yb/JHeXs/5GPJdOddj2bCqkZIGmwKxQ+A/sbRhhLLm?=
 =?us-ascii?Q?7+6pA5tH3gpTlR5UHK9ZK+4aK6TwfEw2Vk5HQ9LVAJFGFYLGRUN06G36aH/G?=
 =?us-ascii?Q?u/REnvprQg+iXurpM+tLN4pkVgqb18xbgYYb2KftAmZI7E198m8kelVRp9AB?=
 =?us-ascii?Q?4H2WuFBfskN8v5sIjTb88oRHGrcZBel0JSWo2aOMuJn+NSuNQhtpMtvbBy9i?=
 =?us-ascii?Q?8UcZSQiP9ReqboNsD66jOq4a3pz9PD/Rp6YxsZMFdKUFY7e6Fwk0AI9VOjst?=
 =?us-ascii?Q?eTzAWQruMFMzeDyv/0AHhCtQv7F7Uz1UfQV94nAND4EK3qBAkk+F3aOAjKyD?=
 =?us-ascii?Q?GWaXqpvJhT0QPc3XD6rvGN6rePnhrwqzNThjhsq7hSnxFo//5eHHWxgcfeDs?=
 =?us-ascii?Q?DKnbDQiUQ4f+Wh2rFdRBG+SH2VzcnnkYCI7Aa0u0OzLtNQslCHoteBc/9ydM?=
 =?us-ascii?Q?zTrjQYh8EoYklV2eCCbwvsJRdzpxMDJz89LRD3goTrDwh4TTF6efnYL/FkF4?=
 =?us-ascii?Q?zjf053fNr+PPR/antsM1F/Bq87qmDSLZd5vJRpjOQZf06ICUB74nCNHnWvmU?=
 =?us-ascii?Q?bjut/zxIub3w6d9tACf2EKgo+ZwolqMDf6swbWG4gNF/o7QJp9Jh1pDG23vR?=
 =?us-ascii?Q?lmsKxd8DBow6tppFTThVXzo5PKysZmECaHJEMVoMJQPp+kUb1/DuR3NVYX/3?=
 =?us-ascii?Q?lbwhYKv6abpZaNSqTT0XdfUd02WbUHw20p79Z9FZ3SJ+XY56XAsxeVAzx0Kp?=
 =?us-ascii?Q?lMz4G2mcldGkhiOzfvjjKoZFi0rvZOCEwSbO4H4dHuw5ueQPhSTaAwXOXlbK?=
 =?us-ascii?Q?buaLV2jd6BiTOi1SboXc87u0otxGY/2PUbgrRkdHzldHsvGKkBaTQ9RvGtKK?=
 =?us-ascii?Q?3QjpqnsNf4aj645u+81yQPhi6SIcdM3z+hp1dbboTK5PeeITT/dZm0EhVxWA?=
 =?us-ascii?Q?JBrxjodlLJxSQiWN6XYWM56+/yfh7pAh7nnRGr1HU9vYFot49DsMyzUZmbl7?=
 =?us-ascii?Q?GESIi2wXjvGL7TyMXm99kp2F3oA1qFBPzeFEjzcGixhhrsCxaiUaCPlIt3z1?=
 =?us-ascii?Q?beGa+ExoJcmP2geM2jNL9oTzHvIc/naGAGV+ZlPtY8D+JOukhR/EIXH8z+cj?=
 =?us-ascii?Q?euVOPW+wU58cjFbzSdaqJHWR3WbI6x24UuAcsxeljyiI/ceXnYX94MAXL3Nk?=
 =?us-ascii?Q?lnKnd+j4aSfSwYrUHnfE0gwhQQw1z9h9r+Vx7isCBIPmqFSEMJMYIakzeLND?=
 =?us-ascii?Q?HtvzZNEKcyykGJgy9uMrbweMhUPZf4SvaBG1Qs5a54IBWxTwBmAFQFUn8FZ/?=
 =?us-ascii?Q?+2i5VfumJG6ZLpU+98okDC49zqzzgb6dZpDfNRY5bsHih98/LYNV3+SLYm/s?=
 =?us-ascii?Q?LZD1WjIIQtwF4DhSXGaa9ILLwhuZ2W73APKL+i0vmPXQ9dynlNKi+rKDKhxq?=
 =?us-ascii?Q?31i5osrXY+RryBDoqGmX4rq+P4c3n6QkC4qfnS0b?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a1ed1e-b5ac-47dd-3da7-08db6c00f756
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:26:01.0886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovzd8cmPcdYzmzt6W8sIGLhCe2ksUfavTmz2P8CudG4hdVhB1vRbey1XTVpPWKNkcl0pUN94gyZ7MBcfQDkYtg==
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

