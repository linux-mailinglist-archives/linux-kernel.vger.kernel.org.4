Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0B772E181
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241403AbjFML0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239316AbjFML0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:26:08 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6EF101;
        Tue, 13 Jun 2023 04:25:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rwjy4/PekutIJewhX+olu8Q2zivsvoYnhI/9jD3j66Bcke6nyQ0HaWOHhMKx9LWsL736+D41cZXaqec8rCyeFM3J0RWYTRfUYnkEWg37W3QUXi73CIzysDDUGXEMRSdjnm3ahhAhcjAXSebdiAb2y5cBYvC8XmPN+M6aifbZysE70fqi4W5mKJUEJZ7R+aKY2c2i2fCg+9s6je/i5wdMTxmbf79zebCwmaR+Ida/NlMg9VoJQoqXe+Kg81UQz/WpqIKH/ZdX65k2rGajwD5RLLf8e/rTuW46Qcb8FlrB3HR3YnkoPP5WO68Ean3BnMj6GXRzMYWWted9dHbozzUNPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jy+wdJ4SRgf2qsL63HDh5KAoa148kEROpkTGcT1sxb0=;
 b=WXBgtK5ZNwsmT52OFSWqtgSkgkH0TWHgQKuKbGrKygLUZCf9lhAH8Yh7OyxNeettPtngWWeOrQZwYmGJTsGavUKZW13byfX44kwZzW8j9D6TkflSF62/9eJA7bjp1OhYC0ncRLF7NXmU69Wx9eYNWQ5yawA6BPPSdeOYmsgm6JfTjUjJ3Dup9u4a/tl+ZTNUNfcuDt7pNXGdkXhNqljZ0h7bDpDDyvsJn2LEuIizHqIoG1PePEIlosiHdG6XOIVaLM1+lbBJxLwtY9anqEpHbLTihAfFU98GAdeLHv45WAB5jv+r2zQKPcPrQ3xLiM5U0cZ/a2NUYYqCqQ9j6rfaJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jy+wdJ4SRgf2qsL63HDh5KAoa148kEROpkTGcT1sxb0=;
 b=nB74PJ/7Uu3qUdl9FNw0ifdW7er8yFtCIPPgFxxGSLczCc4kLQmF5f3o8mfTKSKSQ/WPgEiGnLqTcIz0cdOdFMBhzQImRmAQ7dOCl3nmceKB1LfAhyHPDAEe3j/DvPYN/n3kGsyaggfFi3ohaTQtDe10gZv9e64kr6hzs+F5Bd/DauiZi/wOiy9eotbXF4batuQJKTqfF+b52JDBQFoFIPlqLRhYO2BA4XbfOda9rvyQz2Agi1hvmEZlpGNDsblyXpvqsvGlpOIYQa+gPXmTvgvuIT8tnXhR45hq2vNrIlefD15vlrMFsq0uh717bJtHa4s3KeYwHu/sD++m/TzOlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5920.apcprd06.prod.outlook.com (2603:1096:101:f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 11:25:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 11:25:50 +0000
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
Subject: [PATCH v2 04/11] thermal/drivers/imx: remove redundant msg in imx8mm_tmu_probe() and imx_sc_thermal_probe()
Date:   Tue, 13 Jun 2023 19:24:37 +0800
Message-Id: <20230613112444.48042-4-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 25210c54-3603-4c8c-dbf2-08db6c00f0cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K+JbraL4NNMJD3ju+zDMh69G22S0/o9G4SZGZT9Q8Ia1D+l5PXBTrsMuiFb/4HST5ttMAvp/Ob3tEVNvXGdG2y7UP0zmuH7BnK2PhIu71xEIRIHQeAKgYg//fGFrcUEqsrDNgi6ba5P1fHdYKvZK69zX62vzl+9s9T4sgc94gpqt1woLXDuhKGxlLdzIDE0HKxHIFu0bi3bdELi42/ilVi9HfTqE+0wHHh+RUxQqpSfCOAkG98JRg1myyAU64bWkotwvWqbW5be7xICKD1k+wp/YSIOMifsDWWXB/ljbWz7zn6tRioV2p07rfjDJeaqQSRoxgYS4mYwYHTJO8vKXStYlS7MyQqL59WzbbbjVopfRUMNHA93QlmfQvybTxNYh37hLkEpBhQtu7coU4FAxPQi29+MA/5+6wiDOEjwEP/CdJTPYL02YHMjFmceBG1V58AMGyAb7eoZSOdTWluuw8ls/+SKb3ig5Hu71KiGTnE2+inGO1mcT5yuGZ1tW/EjBN93NnpeNQSehZNUz5vluZFTpSd4joiA7C1nbU76ltpk09nxq61B52doxn2xjTXc/32+hvRu2ninymaKqXVfWSbJzNfYyJup3LJS8sl6bXOqcTJZIg2yh4xsFx8z4r+JoRyiZwvS2fuXcGxfevJ9CHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(66476007)(38100700002)(66556008)(66946007)(921005)(2616005)(6512007)(26005)(6486002)(6506007)(478600001)(52116002)(6666004)(36756003)(107886003)(86362001)(316002)(1076003)(4326008)(38350700002)(186003)(5660300002)(8936002)(2906002)(7416002)(7406005)(83380400001)(8676002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?weUWzYCZC/hcqklQVU/lUuLwsYuvIlmlRhqZO/Zy8YJcpEttgWpp8SuNCYBD?=
 =?us-ascii?Q?vJ7KJP9rIHUNUcLyS5V3p3KogkTMpIPT4+g5uYFYKpbJDWcNbm3EvvLRGvcc?=
 =?us-ascii?Q?pg6S+gdPwFuMv9rRa6lZUeFGIYd7XEfX14WKT4z2+8LOFqT3EC8N78nV1Oow?=
 =?us-ascii?Q?ekUQapUCr0t4zRep4y4kPewDhHXFm4fNZmQht2Xluy94WTTMRls1mZxR3u4W?=
 =?us-ascii?Q?bzce1Lj9NMQS1PPDWChiq/IfwtXDUlS/cqo21iXOMgrK4DufUGFAwyJyvqoW?=
 =?us-ascii?Q?Q8Z/kBRFp3lqYxn7fIBF9ynUyzygysyGPJ7ufDN/9iPWsTKteNSOUqc6yBJl?=
 =?us-ascii?Q?bxiWvRhpNnywgfgNYe8gE352D7TgRB+dTt9RsRwitpOxrU2NBurYQ0Dj4acD?=
 =?us-ascii?Q?TTE4oUfWRRR1ZhCQNlOH/SdM13YuejVom3azBAn/Fcr5Mm9ItwNVzrJ1Auj6?=
 =?us-ascii?Q?CA1z/RqFjtTm90nDYCgfqcFoKvJwmC77xfOYX1D41yakUw7ERXtyKUEctQIF?=
 =?us-ascii?Q?R17CtuFgU9oeo4OJ5FwCcmGVHf31DQtZX4R4yNroNSaTeXYVPv+Ks/bTSmo1?=
 =?us-ascii?Q?3XecsiP2O5Kmr49Zfu3DzIkmknL//y5w3en8i9s72BQpKTBvFo/zuPCoRL1T?=
 =?us-ascii?Q?z393XetV5mMBJ5/v7HPoPu+UZos2TDVgfX7vWEWugtmUAOAxEtkE1/ncZhoI?=
 =?us-ascii?Q?QJQnR+GBEa+PE0lWRGmp4Jg6buCec8ezHWHR7KVjoHY6JFlPfnp76IgsqleP?=
 =?us-ascii?Q?4bcguoGwPG+7kXGWeHpo+mdrBog4o9eMw7UTbrKtbQRAXBFLzSvP5pcURdrJ?=
 =?us-ascii?Q?9tudmr/5JLOfw6FkaC//pD1EHjWQARTOZmdmxwX05NhceHTbCY/o1IT6nrC1?=
 =?us-ascii?Q?bVvEVk1pBA4pM6AwD+duPn65klCaKDaU0lvgEt3RP7DWBrLOVsny7fyWyrdA?=
 =?us-ascii?Q?IXFve+tmZ5S3MLeHhYEdaysK/iDnw9CNacBUhHZ8OUh6245GiKbBx2fSf4yN?=
 =?us-ascii?Q?01j2M1TKrA/07bgCT4fcn4D/uZ1QBgB4qungw4V46/yxRzBluccZoIG16XhJ?=
 =?us-ascii?Q?6Sf4am7WuX+zOKwmGj/OYG33lF3uUGDxgMiF1Ac+yOSkIsbS19SwlvppZAOA?=
 =?us-ascii?Q?QGhjUa2LtO90lclat7kOyhJH3T05fW42dSyJiu3WESJ6veQn/bQ3R3T25LAB?=
 =?us-ascii?Q?Z2B6fj+xfXR9KN/vi0AeMvLnaqMZh4nL7O6iDF02YwcsCLz4kJk52Y4twuNH?=
 =?us-ascii?Q?k/mxc3YmOXLExTKTsJKl/fo/HOCsiArPP6X2pusWAEPLVIMx7dhKkeg7dAfF?=
 =?us-ascii?Q?PRdQ0mqfxvstdhmkTQ1LvFvtPwQ39Kfwz7gL71vID0CxJVFktmtgSYhnLvO9?=
 =?us-ascii?Q?WvoXrs41lX9/ozXSNP3JNpzqOZNnTFcacB3R/EB+Fe3CeRxHzQmiZZdSRrK1?=
 =?us-ascii?Q?OuVE4GbpUDNbz7vwks/iRCL55mP1UrHw3wVn+x54PmuSKywDEF1tHJK7TB7S?=
 =?us-ascii?Q?WwT0jfZUP39lZgK6+bAtWP5ooOmDjQo0Pfiz2J5+ELgaZ40LLub71Ln5wtLn?=
 =?us-ascii?Q?ao9Kq7gZ5TDyD3ZKSN+YWoqH2w/Q7iBAOA14y5Fl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25210c54-3603-4c8c-dbf2-08db6c00f0cc
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:25:50.1193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AqtHktJVgQGHZdV56QaHgpXnNTW+fBDMRX2KJGErzzHWXlgncyMMg8jYViwkvaItO6yUd7/yesiNw9LDS1IAA==
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
 drivers/thermal/imx8mm_thermal.c | 3 +--
 drivers/thermal/imx_sc_thermal.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index d8005e9ec992..d4b40869c7d7 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -343,8 +343,7 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 		}
 		tmu->sensors[i].hw_id = i;
 
-		if (devm_thermal_add_hwmon_sysfs(&pdev->dev, tmu->sensors[i].tzd))
-			dev_warn(&pdev->dev, "failed to add hwmon sysfs attributes\n");
+		devm_thermal_add_hwmon_sysfs(&pdev->dev, tmu->sensors[i].tzd);
 	}
 
 	platform_set_drvdata(pdev, tmu);
diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index 839bb9958f60..8d6b4ef23746 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -116,8 +116,7 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		if (devm_thermal_add_hwmon_sysfs(&pdev->dev, sensor->tzd))
-			dev_warn(&pdev->dev, "failed to add hwmon sysfs attributes\n");
+		devm_thermal_add_hwmon_sysfs(&pdev->dev, sensor->tzd);
 	}
 
 	return 0;
-- 
2.39.0

