Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93346BFAF6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 15:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCROpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 10:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCROpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 10:45:17 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2092.outbound.protection.outlook.com [40.107.117.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C529320D12;
        Sat, 18 Mar 2023 07:45:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3u5cpxvOO01RkHqEwuPl6+cXb1J1rOIaPUsLDeohEHPSzCSwHNtsqGUn9QEHghJPo1GZwEbNGQFg8OrRRDCtgewTQKou+9ZCGy77v49vfAHgc4f6xdfj8BJqaKQC3m/kPUfRTYyOsjcyJPNpTay74zbiHLYNeC3Kf7THns3psW2LEJheCGyBKLMGacLTJAZfmN0qF06UAkE2YokP/UnBsndLhxmxWndDikWyZn14cgDQIlgnmdB6aYJY90m0lSaXDP3nlTR3lqD4Xknh6VxL/sy1IjouE52kuLss21k12ZvV2Qui0baZL/sPrlrUVxpX987ELKVKtoaUO12SY5XHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGkoe2OMWlCGJ7PD5WcRuYFUzk2FY6bsdIkAZqphzhg=;
 b=KCFm/4vR8q325qnQM8oNXqdjkCEHkKUDqY3H7NFnrqMXsVJgwJBhxR4Lg2j/9tD9ITAomP/ElCyfWNWCQJM7Uj1kINkeYPFsUh7PaeHyPmysSubEMxK/zSE6hjQvB8cYYk04SBY+UOfIXOnyEpB/uh1xP77+BEDRBXeMEiSPIenvwzNeBVOk4+Tc/Upkme0Yksx31my96DDbUB/0hES+C41PzlR8RW5AjS5b2HYEafs8BIUkdce5+5k8RbNcuzDge4Anv0NApPrUfqxS6h2tDozdxU16Q6hoJZXvCqawYooReXQQvVhaG5A35o96cxNmyqzmw5AXvePXacopGtp+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGkoe2OMWlCGJ7PD5WcRuYFUzk2FY6bsdIkAZqphzhg=;
 b=XcIeZC7YwrwVsQ0IL6ga79LBbtOUJ4maBxoLmgeDX42+loHzdFyEsL4uHysg7iqFsydVOInPc/LZZDX8SS6TBMTWXOOt395RiEt3ymANKjn/PY6pPE5Z/tR/yU8RcvoqDdYHGA7NNcbjr+aZvG3BC3/Zr/CjUzLPskCm1qG4N4jAuVDFeW+hBkOVpG2f7Dzd5zleDOeqYHtcKLuEnzZpivuGPoYc276+N7tWB7hdoGoSq7lGQeJTYKNsGiaVkbrkkgFKom5nnNr0vY8JOHpRfD/NdhdRhKxtG9pJsGDYlvD94EHO/4t1iSg/ucFNPKTc1AcdqN/DxybTD9zxTWNZ8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5283.apcprd06.prod.outlook.com (2603:1096:400:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 14:44:58 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.036; Sat, 18 Mar 2023
 14:44:58 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] thermal/drivers/imx: remove redundant msg in imx8mm_tmu_probe() and imx_sc_thermal_probe()
Date:   Sat, 18 Mar 2023 22:44:07 +0800
Message-Id: <20230318144412.75046-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230318144412.75046-1-frank.li@vivo.com>
References: <20230318144412.75046-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5283:EE_
X-MS-Office365-Filtering-Correlation-Id: 524a2dd3-1af0-4aea-be11-08db27bf5893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ulouShp6C9MAmttC/fLUm73ouV12ytCtXc45JNOGf4+Kyvxr5U1aPWsqrAs4W/iTB7VsdvAIlzI4NIj/s73HFOB4ZAOkWwRdUQ1l4/FKqzHpV7QSvmp74mV2E/vWiLr603Q+CkrfO4Ko0vqiReUDtUOj/Cyty/Ol4B82fkJIgupZmHruxbRAjDKBFDzhEqcBit44M3PULdnRG+b0yrskIH45pcrlUcaXeBSij7WJui7jdr+OAh/KzFBdTMWqapeFIx28vE3yIVeOfox922mBHJ6CgDWGnjpJqG+wKM2EITxgqccYzfrFJ417SMX2YpV79HRL3XbW2YL+xyw3nnkyJydvpSxOwliGe0PIrEU76Ei728ZFzTsm3R6Nat6dOufBokJG5pUjNC/vSwJizUbh8CeSPlDaaSjf8fmEXlgr7oOnbyIPfMbf/0++WmQbUoSuhumOQhbbdhjf0DfbWAdLr9G5j07UfTxUqLp/cnSHyUGflnLfnjkyZyDeXGwGdKNAKApayVJ0QPo+LDlkc3DE+pqbZ6YKx+FO1/8DxYfdBCUl3J7ganibcEio9hL21at1R4W3e3QFcEMCIlPvcfcTEb0G+zxkPXQ7e7QE/oYH7ENfNv92958Wts+fNwckPLRnt2poKeUN8BeMEUoiFFDM9L9WDaBGsn0pCo8H9qEsnRHJGyEte0HPDY+rZz2L3EZ99KGjasDmd5FpR1TnjUMMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199018)(86362001)(36756003)(52116002)(316002)(66946007)(66556008)(66476007)(8676002)(4326008)(83380400001)(478600001)(110136005)(186003)(6512007)(6506007)(1076003)(26005)(2616005)(6486002)(6666004)(38100700002)(38350700002)(8936002)(41300700001)(2906002)(5660300002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cm2Z5MFsbNQrliM68Ke9j+ozrhqfGQrUUmHwlFkw9oTxXKQYmQJ4pENXE5Rr?=
 =?us-ascii?Q?KHWkuv3+25BDmnBnrtjgfwoe85Aa3Vsn1v8tBRLSVeUQNartR4DWE4/1NtDu?=
 =?us-ascii?Q?TYThGcTxPST9C7DPTFiDmZYo7QKEqOkQ87Ycjvqf70bFXk8EFwnz+3Mf4T3p?=
 =?us-ascii?Q?TA4ZYy1yyRIlU4Qcln/meM0cVffEJfRHi9yaZKulzIyLetS/swtIgVuuLSyc?=
 =?us-ascii?Q?yJT1SY2b8V+Ba1oiq/8AK1GTX4ONr7r6WpPaqS6KWDyejwJtbzxOX/eC2o6O?=
 =?us-ascii?Q?VAcR3RzyACoeoXSIuMdOrkJd1CNnTO5g8vTJ/BI+Vuc1RT7q505BTrZL+quI?=
 =?us-ascii?Q?ow8qJsO3NuogwdBEFTHE0eeecE6ISCgmA7MW402FaVwJuJAtggbs3kuTnaGM?=
 =?us-ascii?Q?16oDQIjx5tA3T4rZrnV96RSmnab23d+mU/OaSWGfDOWdn+KT+3Y+59apF/xR?=
 =?us-ascii?Q?XMxYy/WmkEjSddauPZlAimsep7GOqZmZ3kbhZ5bltefzpVmRgr08cvCx1XAr?=
 =?us-ascii?Q?rYMq2XEA1gJbZjPcsQEq0C15XIdp/F+QdVd8m/sG7jDmxUNtYQEn4fqiiWik?=
 =?us-ascii?Q?OZXy8/VmYiYC5v0owV7czaztn3+4XxIEOEjyJIlOBNGSmznAZXdJenA21bx+?=
 =?us-ascii?Q?4RMthvV6kswnZ3RTKbSZHA8iolaHHIsLuEAYmqu/IvSp9JXHFeomXp5neoI7?=
 =?us-ascii?Q?DCWPfXq8ldwcQlYpkT/2XRHE5Qspa8V70DPXPUZGjogIsA+ryIH1B56/jM0j?=
 =?us-ascii?Q?rr24wHHrDfjeAgb7hJ4p13yUkxYJJPriaLK2MLiD7mIHes208m4IzJRhlQ9P?=
 =?us-ascii?Q?vm4pEeE2DRYXILoKHw8NJYHmYrxcawE+650eFXkGUijXG9ZQXeTa9ekhJy5/?=
 =?us-ascii?Q?vRaxG01vtzw4YIUEkJCrPMP6eJwmSHT0vv96SPw1LgmVpI7voV2gs7IvFFw3?=
 =?us-ascii?Q?SOH/cZOnu1Exq7EMWTHYN/KTd5UsdXqiYrXBsRUTn3urPTffX391bvEmt29F?=
 =?us-ascii?Q?asZB5dZFRYm+1ZJDkbrSM835cy6TzY90HkL98iL7m7fqlyEqldV+LXGhdhKu?=
 =?us-ascii?Q?IL/PmNCmmCQvNlsVEvoaGU+jAro3JopP1i8e/vm9Vk8oBEyPPLrzPMOZXxMs?=
 =?us-ascii?Q?GYELGyap0v+jU2pEKtOaYj8lYNQxht+PaAKw0McNEZvDvgNzSUV/wRUHcl/6?=
 =?us-ascii?Q?vOXgNIBIL7BOaPbTNTwN0GGwCEGCWQTigSkcgee2hMafptV+g9AG025KCI8Q?=
 =?us-ascii?Q?oPU2f0kLNYEiSvukLsjaHkgctAY7SiDbY8lfjTOgIoktIlS5ps9tD4iLYHdO?=
 =?us-ascii?Q?xpdVW6JFXsBW8g5gu4nmub/1zn30l80iejWooxjwn6eNlW7/PFs/ZDepky6t?=
 =?us-ascii?Q?OpP2F/VTcym9J+NqF0ofuQuOX3chEAeWbnUSRU1xkXqyGZ79Cgc/MIFBfnv/?=
 =?us-ascii?Q?qfkolYSxNv9lhCQ2n256HF4cE01+Uu2zYMEGY1cmiZApDTIzSCRyBJigg3xt?=
 =?us-ascii?Q?trw2tII0ze9+YBdbG8isedgl8vliwj6IJzUyyUm1h3gvTNGzLMHgtQ/8AboO?=
 =?us-ascii?Q?xdih9Lvs1qnzVCt09BTT7V/wYyCxgo7jAVDEb5Ca?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524a2dd3-1af0-4aea-be11-08db27bf5893
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 14:44:58.3558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkcmH+lOKvOfvVlAn2yjRXrwMGjzTUA2WhVqHdbfOSGfZXqqWjPLC7jszy8YTLxgPI0lC2+Ghjeo/0pnANFpsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5283
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
index e0de6ac49469..d837e2f96397 100644
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
2.35.1

