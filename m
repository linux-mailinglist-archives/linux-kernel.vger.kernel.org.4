Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744D773F53E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjF0HTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjF0HSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:18:38 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2131.outbound.protection.outlook.com [40.107.255.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DC31BEC;
        Tue, 27 Jun 2023 00:18:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9Pd5/fmiJ1XLlHpYw2uLMB5hPZAIQUU6odpIKYcjbpYTk6Tfrx8sKEM+gBXvMiGqhrYigC+PSMnGnKrO6aM6YFm7j+02D7vV54ocTTIZH+ZBpJKtRoyX9NwAO0W94D4U3BOGdf6zI2Z9kUzlnw2RqYh4KClwVLoESqAmkkVLQF/7UF8GTEd016BPl0fjpO6bCfp0USKnNK35jaQcy0z10/HkAuSAn9JsxZrcTXpYzsWsN9UeZk/Y+3D5+KYUCVTs5dqQeAanecO6eLJ77KYtUnxVc9FLsg0GOGRR4r0YnasOsxpkLipnFWF/gQnKgdMxuNq+IKJsLD3LNwuhUxNzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3icIxl0tLCyJTjOBjt4P1sSfvXumBXa37u3dbHG26bk=;
 b=KNvMPa1yi4yF0xzQ7Nd80ZhKXVC0/kKIA+rsth2LY6Us/qpVvUGJCq9nJEfYytZe1JJmlgPw/y/ZdmHPutPDVwKoj2gcA1Mvb3tgrJGfiJYArCnPKc1iB1Y2sQ2O59DhAjZrSlexLkDH9ReujeBdjA8e8JHJ++D55Fn2zNW1VdQxG8ZiPaKaKQlUUHTzmpTLn2H/LdxOv1tNtSwIXiX0XWiNn1DBpxeBaZlE7TGlaGf0V4ELvqkV7h2RkaOOOxrK54tAB11TaWzXlXbpA0570vbopixiwTR1F217iLgdP59VdeS9VHgY/RqCLfGC7Zm14IZeKG7SfZvFtek+4m6TbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3icIxl0tLCyJTjOBjt4P1sSfvXumBXa37u3dbHG26bk=;
 b=BScsMsV9o8wasuqU8tttt94AhGCksc0MrDDrJLqU4soe6wE9bemmmtXtFvYtZQhBy/rbd/Rv5ju/tVo0/2nijhF0f/fQyadM5Tz8gdYTlfOdY5UVGLaqQQcPzNq7HmMm5QLrCJV470a5oG2q3e7+qYeTSMWJ9u8NsE5soCcE1hxSRq8A5wo1RdnGcpo6OoS9BR+BPxSiCWkQ+q9D6R011QdNXd5my/1xa50Z2MOq7xnL775EK6Agv6BrR5Fs10grSQcSFJXbRJyuo2MEIfr5M1VvDf08KODAPvLamrouKhnQdpb5weCrk1Yib7HsKpFksjO7BHx3DuKXIdkvRb9X4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5137.apcprd06.prod.outlook.com (2603:1096:4:1ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Tue, 27 Jun
 2023 07:18:34 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 07:18:33 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     miquel.raynal@bootlin.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, thara.gopinath@gmail.com,
        heiko@sntech.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, tglx@linutronix.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        srinivas.pandruvada@linux.intel.com,
        DLG-Adam.Ward.opensource@dm.renesas.com, frank.li@vivo.com,
        shangxiaojing@huawei.com, bchihi@baylibre.com, wenst@chromium.org,
        u.kleine-koenig@pengutronix.de, hayashi.kunihiko@socionext.com,
        niklas.soderlund+renesas@ragnatech.se, chi.minghao@zte.com.cn,
        johan+linaro@kernel.org, jernej.skrabec@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 03/15] thermal/drivers/brcmstb_thermal: remove redundant msg
Date:   Tue, 27 Jun 2023 15:16:54 +0800
Message-Id: <20230627071707.77659-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230627071707.77659-1-frank.li@vivo.com>
References: <20230627071707.77659-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5137:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d4c458e-a490-45d3-279c-08db76deb784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KaWEyH1G0RffvlWzNDYR8IhqTHhw+kRBO0WOZ6g2yHJXSh0YHipOF0/xfEhilsbQjPrvDcuj+lDTyRXaIiBx2NE65eTsNobdkeUnoy2hCdCO3+3g63dQleip/0heSpmbfM0wJhmRu708hzVrkSyE2Bd8rCxnI0QmCUuX/ubVfPlMquZBOy1ctrvpE0e120LJILoqyXG4mUwUN9BJshsmU8NdjCXS4zzDDQ4F9yNAp8HezjjZtB/khUfCSFw/k2jLq2uDz72n0noC/wYw3Lo/jlaDcxaEf3gC8cUlUtZNgC2BGI9X6I4LZBa55nl2L0ursie59ROitx4dEDP+Ku+UBs+HzLKQNqtRLAFv9v+vCgvMPzu9x0MLzYCwiwwStPCkb6O/l1zuRLL0k7AB54idA+ecWpI80bexksuBeypghW40i3MTdD/CX0AiA+b63Hh1SHKuq0Meynp537+TH1uu1/M6C1ziMd7DG8Of+9/a6LeNRJPi+gNg1jhcsRzLN63O477izGiEJnX6ERm50du+0No+DgUs2VppO/3CsK30P4aBVKg1IJ6lKmaKI0RgL4cly1qfvAFAvnt8424/JyIdfFqh/htTRP5Pyfi2nH9IFIY5n1dz0cNeDRFVIADWp52pVjpMQyNiA8hVFvfssawXzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199021)(52116002)(478600001)(6666004)(6486002)(1076003)(4744005)(6506007)(2906002)(26005)(186003)(66476007)(6512007)(66556008)(5660300002)(66946007)(4326008)(7416002)(38350700002)(41300700001)(316002)(8676002)(8936002)(38100700002)(921005)(36756003)(7406005)(2616005)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HNjGSRpIhy5A+1DntdVlGpZrDWjW+dyDD0JGhdA6fNTp6fNm3pf+jK1SghpZ?=
 =?us-ascii?Q?DBdZlPY4/Dqi8OQZcJxhcMwoAAJn+mO0+6SJsdLrWRhveOi+3Aspa8jOvdqf?=
 =?us-ascii?Q?8V2LxFmWG6jr/eOfd7yIgpvJuSupN3p7/bj40sa5ObG5QP+jyU2leQoL3Kzc?=
 =?us-ascii?Q?mARiqq2hXgL1XlAsWR7+M7lC2YXUhRsrU0hhJjlZ+jtC7ozzrN46JbJI7yly?=
 =?us-ascii?Q?oxaaW5fm0DYe8b9IxM1/r4hWvtl10KwvKCv/8sHTFiL6le31/rxQgBJAbGX4?=
 =?us-ascii?Q?HDFBbAnIANcSPFBfaPKzyR6ZJ+hocUsRy5n1IHdgU7FU6PGdG4Kd+pizme7z?=
 =?us-ascii?Q?RFcYGaU1eXJygJMIKdChRJmr9byGOlDkoHSHEadcgm2H71WUhrwOrZJhFd51?=
 =?us-ascii?Q?QvmyPJbqHRR6MDotszlmgOVW93Y00LanknW9Ey7WViBZi7dQizf0i5JrSe5B?=
 =?us-ascii?Q?dlqt+xpJldhJvFSaWZFeZ6afeD+L2boZEeGAncnpN7nKH8B1yeSjPAkmbKpK?=
 =?us-ascii?Q?ASsi3y/8DKkSYqOyzmh8dS3bH9uym+Utyvl4S1aRYOX0yJ5g5/k8DB13ucTU?=
 =?us-ascii?Q?RzqZAy/KaHrFnLrmWM3pOBmD1ZXuPO8ubCM9Ws7LQw1PuHiy0emd3GVITjPI?=
 =?us-ascii?Q?NaiYWWNez/00Emchxj/YLaFcr8TZJPeiXTS5Sw7SeLZTtqqKdY7Mr9y5D0+j?=
 =?us-ascii?Q?Y7QXLEZ+zdN20m7QSDf+8Vz8y8VkAVsitpAIRY8BqdALERs7URf7red3FATB?=
 =?us-ascii?Q?vJLpsN/sgU6rp2LRRWhpWPyWKS8mPRoxGfZ7JaS7HD4XCOGHLgnp7T06Rlmc?=
 =?us-ascii?Q?96OPqIIKorfJ8vJZ52oNc9EXVIXMKg6UKWAq/d09dgNffMpI2/2OvT9dtZLK?=
 =?us-ascii?Q?0K4K5b9B2VxYnwTjRivOXVfy5twKJAZMBaXHBgfxrMoRDC9z1Pntn6u7+ydc?=
 =?us-ascii?Q?/T66/ZR7B1I57QINrhgnyvLaQ4rNzJRhsSgrYmwW2Htqd/xtXYxXmzrxz7PL?=
 =?us-ascii?Q?L/aYB6xOvpLNG8IbNMwX2sEYfcBILR5o6jLG6IXAfBXsG6+8y+LaLQD9cdqq?=
 =?us-ascii?Q?IvKbUABFieVSoxmur0LT1oOtRaVUxHJZYYj3Xcsbj0WQAkxmGC7K2jYcGWiH?=
 =?us-ascii?Q?kX1MdBEFnXXVbnxNgWjy2+sXngwNn5tIk4MZEmpgcEZj21aL7fbskgM5MaWo?=
 =?us-ascii?Q?pGT7d0Rd2ic50a60Imk1yc3v6Kdly9eMVCVkEfSoJdZe9HK2H3QIhU5IpUQw?=
 =?us-ascii?Q?LJMI2quD10gKZF0s8GkR+7CRYl/7Np7UlWJxSMMP5ubPI4xw1Brq11QHTFFs?=
 =?us-ascii?Q?wkrMx+4mIn2dLGsB9GquDQQKYGsXIvBJCKd3vyFMR9hTKP3of7GihP89E9Q5?=
 =?us-ascii?Q?CZn/taz7sPnk+xwzIc1GS4RfZDEXwDmxuZbTvFqq4fPxBD0fz7Sx70GsmMmx?=
 =?us-ascii?Q?Q58VQ/CWivArHBf3138Y6ccwRztuEDqtcf7gAZqwVoGFoKjplpsZqWjTa5Qs?=
 =?us-ascii?Q?mZlsTlUDAwQp7wV6mk8LHiWZnl8hYLCidRfx7/Z13VE28O5RrfH4CnwFUQm8?=
 =?us-ascii?Q?F7dDJY4MIiN8cVbL80HtT4x8TFKK8wi/RCDJ103L?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4c458e-a490-45d3-279c-08db76deb784
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:18:33.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmzrodgNbSRrUvie+n3YYN2L02zAdL/6mdrvtp27E5dVC0T4fIf3RRxKws2koQq1tqFny4XJ0W4K9SyOh9fKag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5137
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper-layer devm_request_threaded_irq() function can directly
print error information.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/broadcom/brcmstb_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 72d1dbe60b8f..7611094cf367 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -353,10 +353,8 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 						brcmstb_tmon_irq_thread,
 						IRQF_ONESHOT,
 						DRV_NAME, priv);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "could not request IRQ: %d\n", ret);
+		if (ret < 0)
 			return ret;
-		}
 	}
 
 	dev_info(&pdev->dev, "registered AVS TMON of-sensor driver\n");
-- 
2.39.0

