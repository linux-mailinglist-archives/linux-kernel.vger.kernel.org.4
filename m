Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E8A72E1A9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242242AbjFML15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjFML1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:27:37 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E511BE1;
        Tue, 13 Jun 2023 04:27:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLgjO+VTBrN0W2AXumIqd084+n8vD3VrjMOXbhEZBra8yRBsqB0iER+OErr7e3Vac+TjxpGQv2lqcJ7ik7A43S0beBn5294dLJV7MbfXvyNeSbVR/gtB7wyrOkl3hSZdz1GX4jDG5Et8PrtGejbI3JfK9IzJuiW2DN0EqNYgpzcRd+GKrRpeH4cuiIFRQDc+1w4bkEfZ/z1PvHH9goY7Ltr3zHeY0Xp0Ufyk/1TUCvLGnMUh/sjePHuB8po3nuyr5ewUaRfQSfaCQJnTAAVQi0T5E0MCyseP4y7RxCirpPJHc1P1mGItGKWS7C5AskCqUxSwxVAv7Sz9a4fA4TPpdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUmClZP5e1qqbGNqHSfIQl660rJG41dR34DXna4zcMg=;
 b=ACNbmZjAaqNQscnVo9gm03VJn1EObM2+7VVd0T1fcw7Xchq8EeUjaARHZ/m3Dz2oUvTEhdcqIqEooCgPGiajC4C5zX5LCgYDf7hghklC1/MVG66A5GDYcE2+Et4hWKmW6Z/AacMWiRK8kQ9akXEPpZ8rLnXOn7vLswJsepEimZH0jwdZFsiFY4PR/I9JqWFRgrN+04w4RWuNQEXw2nfemg8QkfUzWWqWLOn5DKiA5AJSIR6seD1ceUa8Nf7jztr5YZE4leIIE2pOBESYhhFneTQzvdpjaZlVaYC+mKcuYnxnoXLDed7fo/lH2XvOX/G3dV4jCQodtqj/1kXy1MmHQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUmClZP5e1qqbGNqHSfIQl660rJG41dR34DXna4zcMg=;
 b=Z4kHZIHxSD/D6ywks9/+VY7SQEMgRgwG9bl/qSqcNlj3U5pkvX78+eYrNEWWSV4u2yDM13p1Gu7H4vCcozTT8rumaWStX26BznyChl+b18DB4aZqAMFzBMViqzVj1d9bzHL+Cmz0w7l4Z29TELFYLgEUetoR6nKgsmTp5yFNN1aVn97mTlhQB10svrGJNW51RTtbFl2bnPlTpGc6kVEZM442BY7G2/xZvXpsVC+WPTJMDXLoMEvWEkzWaYMHpK2AYdRkwlhTQ291+AKGBnlRnKbPThHT7YpTbUU4srmNpHzRg3wanXDsTh/MD1d2oFMjsWbecLtOz20NWf+xAQFCqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYSPR06MB6793.apcprd06.prod.outlook.com (2603:1096:400:473::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 11:26:30 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 11:26:30 +0000
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
Subject: [PATCH v2 11/11] thermal/drivers/generic-adc: remove redundant msg in gadc_thermal_probe()
Date:   Tue, 13 Jun 2023 19:24:44 +0800
Message-Id: <20230613112444.48042-11-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ea49e068-fe0a-4201-08b9-08db6c0108f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PfJSAC54UV8bTb/93PivJhvhN59B4gkda+yayisgyaL09zp58ArQkNyoNWwhl6LtKN4OxLkdcshooAMDZh7SJ+0M6xEpXbfIeW5GKa0UgT6wnYt0bNJ9bBd8A4pyGmoOjrpJlFf6iHm0Jo25kEioN+WhJ93KtFv8h8DeX3IdJXFJZvOoWRFuchb2vYW0vIcwVMjxmBZIRjMU6LuleVvZxYhV9FeAboUJAmQSn0wPLbGTxrivUJrLJ/4DN9j9DMaVBH/TYMBm40FRR28KI3WRcz2UaAacX93Rzz7X9GqoJKTl5Fnu3kV4uYdx2kC9Jy6zcWZDmHvRoOkubfWBAt0mIKqiySFaiJoVQADI9sNtfc6jdw6SPsz+Sk8qJmg9hj8A0d6XDxUkGQArd+isOYZURcRrjK9jqqnZnLvd1VcQ207iCX4N/qeLCqTDqvNMEKY95AT59e/lfWaVrOCAIn5TEHriifhjHMuL1NTHHGFqzBh7vX9vJS8mpD8m8f3RxhXcG2f1XfCa2DqAMU++OcPcVjNiJXKL9reWBHjKJaIR+Cx26MbYZ908jJlT2v2vUQ/qCus7ajWKLtD9dlNFR+f/p25+sFMb2VWegLzixeS2aEZqqU1H4qce0+ww4Sag+N1JtNCW2paVu6N/edW7yK+HE9sfDdcOAqoex+YaPwzmVMg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199021)(921005)(6666004)(6486002)(38350700002)(38100700002)(52116002)(107886003)(83380400001)(2616005)(6506007)(26005)(186003)(6512007)(1076003)(36756003)(478600001)(316002)(41300700001)(66556008)(66946007)(66476007)(4326008)(7406005)(7416002)(86362001)(4744005)(2906002)(8676002)(5660300002)(8936002)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rsxLRMVb0PJrLn1pGI7uS4iNvUhyFGiEL8YeoRQ9Ed9EddRTHGHTJFK4z5RS?=
 =?us-ascii?Q?hseD0LXSrEbUCMNv+MSKetIUTPzaCZXf9Mp45bmURpWS72aeKX7VTTIq0VBb?=
 =?us-ascii?Q?jQySc/zuC0fPndw38JNb2RHKzOSZy4hhfoJfXQmEOADEfFTGmHddnjZckmnQ?=
 =?us-ascii?Q?hQeSXkyUSMkxz3D4EjpWaRKfD5pOMB+DQ70IxDq7zNyj64js3h8XwQRiBjoG?=
 =?us-ascii?Q?ZrVXtSwGRFgoxqxcQa55LBpkdGIeWZIyl3sP40b9L93oYccVcY44YEUjO7aX?=
 =?us-ascii?Q?3EHDhHAFaFdQxKvYA0KroPoF7Wln3FYune0CPfvOLeACj1mtXt2VCdL9IYsp?=
 =?us-ascii?Q?9m3kURGrHbhCbuTIWodoOhAPFVVU6SODVh2XDh2neSRSY/i1tKqKE+O7JdDc?=
 =?us-ascii?Q?m8s0BiivyTn3TtruooQpJ4Dc18IhCuSPTAIaRvoG6YSZ7jLQHJjW5KEYD+Yu?=
 =?us-ascii?Q?Fe2KMt6EZ5X7B3UCFGehvlc+JtWklTitxECnv8oezR66aEe7sjZQKryqNFEv?=
 =?us-ascii?Q?0pVpcUTOq84OMlwT6Jdn1wrmgC2GQf3CQyUi19WIuBICdMPxvigQRVUOYqYP?=
 =?us-ascii?Q?1oJwFpP+bNctS1BAVSJ7N09WiqchqA8/DfDEjGn54IwbKmQv0AB6CSa8nwA9?=
 =?us-ascii?Q?3A+BWz1lHrZI72vpNrYSpKOZbhyf3Cxvwd+lkVdtQ45o3jlXi8TRwG+fCyCS?=
 =?us-ascii?Q?S1Wcu/bbZEZBnTGhMVtCSgjg3PtzJEJxUM9xqkU8aSJUEgkU2abfxOTSSbmo?=
 =?us-ascii?Q?4enMzMkf6ITQBOkzfHy3WOKm+VhEYxwOrcWhOQlfCpoC8PafuMX2YJY6dkvR?=
 =?us-ascii?Q?z7meMLkyB+yao9cLngHusf3I/8f+SNMtD80bhS7sou5k3zhKFgx6hUPzh6Hq?=
 =?us-ascii?Q?caZqXnG4qLGs0Gt4mKIDbKICBTgUrxxb0o3XTdab/AZHM7wpdUKXLd85krRY?=
 =?us-ascii?Q?Gwf/+F4MMDdkJjjWBoG+HxYpLAeGOGASdwNdyTDOfMoqw7jc9raJwzYNbb3Q?=
 =?us-ascii?Q?LJwW97Jg1YGP4ITF3L12+8RuEiA1JR+HGonhTLS5yG8tRwPr+qmpc1i6JAEZ?=
 =?us-ascii?Q?0TqSkSygNZqlcjJZXOg2d6Yapvn8gni/DMa61M9P98pUk7c/WgPMSxT0Uvdp?=
 =?us-ascii?Q?5qpCIOy+ukbHQxaDU6XT0sbEZ4WnuKKq+B6AV91ut7MVrjl2rVzZxuvvxEIi?=
 =?us-ascii?Q?0wB2BcCAVxXokOX28z+ZtLHB4krb6X3WRC4lgBQVbQmyvgHaI+qGfxCB9d/2?=
 =?us-ascii?Q?L/y61ixF/g7PBzCHIZzLix3ly9El5HyiE/4hV1C2b+mdmGBI8mIbZ26YltxO?=
 =?us-ascii?Q?mqBGoKRkbCT89Z+XZGaDxfUvY60PdLlujCIyQWuVaNo4zZd+2PywrALAT5FX?=
 =?us-ascii?Q?7qwUtViLIlgJFZTvZp539HH8EiUhAcmh6wf60/rOgnKCDNdYKlwP4VRkJZuS?=
 =?us-ascii?Q?TJ6+wQiqC5swbrT1r22M1H+tj4wqUpBwAoUrXyQqNaJELVhx4mLZRQ6piGce?=
 =?us-ascii?Q?JYeGTealkKXEy2N3O0TYRJt1D/b/IW2NdHnyOD2nD6WVSl3BJeAvtCL6y3zl?=
 =?us-ascii?Q?r2Ga6kgHZwyqZV0fxRJ1qrDU/RDdp0yz39zIZKbD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea49e068-fe0a-4201-08b9-08db6c0108f9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:26:30.6626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOZ3O1N2+KJa9nWZmCe6JjWKu+HERMHQsvB1M62jRoyR2sDb1yNpSWXUqTqxIwMCz9GLYpr79xJrHId7FALXSg==
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
 drivers/thermal/thermal-generic-adc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index e7a82d5cabdb..f4f1a04f8c0f 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -155,11 +155,7 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_thermal_add_hwmon_sysfs(&pdev->dev, gti->tz_dev);
-	if (ret) {
-		dev_warn(&pdev->dev, "Failed to add hwmon sysfs attributes\n");
-		return ret;
-	}
+	devm_thermal_add_hwmon_sysfs(&pdev->dev, gti->tz_dev);
 
 	return 0;
 }
-- 
2.39.0

