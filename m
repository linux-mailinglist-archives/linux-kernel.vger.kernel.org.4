Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5047E73F56A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjF0HVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjF0HVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:21:03 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20729.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02886269E;
        Tue, 27 Jun 2023 00:20:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRsdY0iuVvC2IfjjiAE3MKNJ7yQt6uhJqyA89NQz06nczGvi+nc5p1CoUDDYAc29N4PUp0d71iy6i1sRQgrXxgDS/9g/2ux4HvaVryXLVJmeV8AQDxDjE+nSGkhbBvriefTpLV+l8V3WHIg3RQw4rTjMM+VjwXZ8KwbNSH37YtVByvckpd0vCKtZiDqWQ4+Y2z+mzdZZp00bBvwDUSLqDPkQncp3vmN9N4l8hO9P6s+nz7r0ce7NlD2AKjwGfa5ZZbn71lljDTWUpqKhyBVp6pKZndmBxUkOBJcOHiQUvq2r8t3S/E24ODnXSLYJvetetE5nX6vCg1YOU+q6hUWMpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1gQQy2LsLzxKVpupOl7l07DODTlYKrF46Uz2jsXo6Y=;
 b=eS/tZdcq/04ZLcdu1LZj4N3T/lW+cJQeiMuPBNEpApleOoA/51gwCegJOeWvkpUYhgNxsY359KrdrAEZg5s/j8uIVhmO616CFOAQmnIfOYRgfozuql1dnQF0+gXIHBl/XpWWLIX5Nv2ez2qHcW5zSECirPHVwuHpi06i6eSjsEMI2uYY8gHTGBSrABYlttLMFFoa8Lxs2JPdi1GqQhpj00JQC8glaQhSfUTog2KeDTzpLFZoOOxfbZqOWPfoMjD+hIZLIW33QDFX+Q3fx369HrHbUSSuM2a852kcWXdDbduNa6IqMBNH1/sVRCmBgNEkM51hT3+iarOfLFcOGP+Vsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1gQQy2LsLzxKVpupOl7l07DODTlYKrF46Uz2jsXo6Y=;
 b=bMqOk90DQWKU2ip4prgSaIcTJ/tl0MpVeQmeBZjKCRgWBWV5WElIMiZQeCENgZQ4NmhWVcpa2NHxNuTQQtH9pWVBjogAg13FZUl2UN0ktPP3MmP/ZYIc7f/JNFrLHG4z7ipgiCkZc33/z6Uh3Z78SW02MGZfBBzhNU9jcMfK+pPNnx7jfVUtW8W3T4aPwkpu5AwJyY/ZurA4KIXV4xOUG51zfIbf811skKb/Krwoz3tPncxuCwZAm3/uUTE1Rg4nxYL+JCJcGcqXswTRrYuDPCWSblyJ3qqw4+tv5xNBNWhhQJNbcou087h1WhUxlDRF71dkv0zAVJpvqYORfLnRZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4289.apcprd06.prod.outlook.com (2603:1096:820:78::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 07:19:32 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 07:19:31 +0000
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
Subject: [PATCH 11/15] thermal/drivers/intel: remove redundant msg
Date:   Tue, 27 Jun 2023 15:17:02 +0800
Message-Id: <20230627071707.77659-11-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4289:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f51b0d1-8011-49f6-95ec-08db76deda14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /q6op132s8e2iGNDI4sNScDlHEvdzhKJd9QZJ4xKJvd82NEWXs60rJqb/wmenW54fxAOdP40mhuV/G2Gmz0WC/3dW1LJy3DZ7PUnefwM9XQuu4hI5NA6w2p6uD2D6haSo0RLTCd8JdLlo7C1xx+PxujMW++Smmm3pZxJq08miflQPBUaXJhrQj66dEVHdgvdOObIH0K+17TBa+9QBNN3ppzrsItoSj3T3V5BsSUmLFs84q2kiQtJ66MONq1sAqD901Pt1LGhKfYOzrzpJ1+fEEFXkZ/irTFbf1z83HH9w9pzzZBtxvOEfBerUmmB05KQYEL9Mx3hJn9PzL0eHUHgrrnGhQehT/JU9UEzOVbbgbnxPHsqytsQIOyKOqPxtHxl4f2mLInYkZg9OHpSzsDnsN1yKxF+Jg+UwaBWlsCeuYwZ/2zFHTJYx8MtSAo96hFlCD031zzYaMmgTmXOqLXuLwiZ67XUTCEjc79zZThywk4BtLqMM7Goqooum/DwzvIK7SIljEiLgp3mp0eQ+FCNUPYSZRK6bDTKmWlWBHobneCR1SlY7vb7IbQwwpy3vur081py0ZjtjgWA35987jKmVCpCfNfGQ+mqaun2kXD2TLUKfwZRav6ZJIKmxjoX3ofibLLQ4omq3J/3k9s2WmP/7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199021)(6506007)(36756003)(6486002)(478600001)(52116002)(2616005)(6666004)(83380400001)(2906002)(1076003)(26005)(6512007)(186003)(4744005)(5660300002)(316002)(86362001)(7416002)(7406005)(921005)(66476007)(38100700002)(38350700002)(66946007)(41300700001)(8936002)(4326008)(8676002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BtfY/6mZ6WXpGYwHHhTJ/gy0ikfGNI8eRg6R55YNtAht9PU5/F8fLCHjdfFk?=
 =?us-ascii?Q?fBGdYVIOqDJJuPivfJtwK/iBisnDmBxavxOzBxCBmPMD0W+oKUvDgzv5MTG0?=
 =?us-ascii?Q?/MxLdLv0Qpm6jigp/2jP4VWFUFp3MDjbBuzkE2PTYn5KWEeAvfqL6wV0v4Ab?=
 =?us-ascii?Q?87FAcvEXLnrA3gDR7JF5nbIWZIFPy8a9vwERGpdHqav/1qAr1n2tZmeGSAzn?=
 =?us-ascii?Q?y0knRRun5cyJNnqpaCOJXk8YUxqycoUmP6SAyaomxRpc7K8LdiSAPqwlWtN+?=
 =?us-ascii?Q?qRAJTMKYHFzf3QNOsFr/tXKXzZOut2usRdyTJksiVZ1X9qvNPdwr7YgQHDM1?=
 =?us-ascii?Q?eG3lrdi/x0c4Qxd39SxIxVxxikeNSQzrLDfi/OojHFhQTQ0UwvAbVbW5Q4As?=
 =?us-ascii?Q?xNlZeSwEyPXh8PzB5s7roQygOXY7CWXY2idumNz150j0/jq7uQxXSCe/AXBa?=
 =?us-ascii?Q?NXc1UVY2XGFzsFCbejlooFifNjCNZZAh2o7fxWrewgpixvB2kPPzpyNwEVtY?=
 =?us-ascii?Q?FwgefKZeLUbfZNa1Pn25Zdb9gRXCWCi4hKncBBEVTvnEJW7Xq1yhKJGKdoXp?=
 =?us-ascii?Q?G9ukNe+JuUI6tFdoEXkf7UC6u6khXARPePQiL6rXgmmngI2bs47g01wWAHhM?=
 =?us-ascii?Q?o60v0sg1nXthYyQh2D7o18lEb5Z1kbtkH8Q0Fmuffd8o9pm955VHNZf5kwez?=
 =?us-ascii?Q?HGgFs0GztEdklp/ENoGjK3WAw1eHYMiNOZfU/WnYMAAHxVmL/xX53ZOadQMc?=
 =?us-ascii?Q?Uvu3e1gWbMQP//M8jrEDN7pA99xTjndB4mE/j/PMNpVS/JTPft4TyvxAyGWK?=
 =?us-ascii?Q?8WocJYoivY5ExEsbv2C557WvE7KX8PdHbqS9ol4DUhda3QRYlD2gfwffLE7g?=
 =?us-ascii?Q?/mA/yYull4G7Gs4vT8J4DRajqCmk/Lys6FnUXBBw01PlbaV6fCg1dIcng2zj?=
 =?us-ascii?Q?EtvKabWpLVYBhBy2P67OkZJZgBTHfZv9uMgLd7WJg4vanpYa9AYVZB2KKp5b?=
 =?us-ascii?Q?vKdmyoCb9sNstXZ9RprHlb1gfLGjyYfL+yHyhbxPojQmL3zO5BdtFfRKZVSx?=
 =?us-ascii?Q?evJCAczCKnph43uAVBIJix0L3HBMi1fhAywAcsehgEEhkzrkX2tkQdNtW0Ez?=
 =?us-ascii?Q?0ipqw3+/iI3hwgn5rhI8EWWQ11ajJdV4j1fomj4WZTULH9UATZpMbRuiPcew?=
 =?us-ascii?Q?JILFHIcTO7bWKGUIhnaoQ5yzFjtpxeCk84n5R1yCLnvV6uO2O5HMHyFBrck9?=
 =?us-ascii?Q?9UDOJSeDXvYkTF0EIrSp+4toBGooSmr7eHQiRw4AzTh6Zw3EyB9O7upIp31r?=
 =?us-ascii?Q?7ospW1Blx5cHMKbIaEqdO8oPHKo3hqszDk884/nORiBabKOCOVIU5lYCxplF?=
 =?us-ascii?Q?HRKpdMJ11q112e/uRgJdYC12ddwVIeZT9Aat7MfZhmGE2/FxghtS5gCRXO8w?=
 =?us-ascii?Q?dAJB4udOvZTpYsWCdBrmI0Yo7hKzyA3qvcmKsaBU8QZBqVHKr7CASgjQ+u8Y?=
 =?us-ascii?Q?eo4hSryHdxGJoWWybZX4o/Vkt7TivsR7hbYcHH79tkzkFtjNogV0+H0xtQlw?=
 =?us-ascii?Q?gzxT841zeaKQGTK055wJ8wijP3Gj9rU9jTL5ivzv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f51b0d1-8011-49f6-95ec-08db76deda14
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:19:31.8321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0kQjbacXc8vjEWmQf+hpKggq5nZqIXd3NJG+3P3DBAHGZawG4wBKrYwd2jEAQJLp+g/8Xl+O8v0lqvv7cVWqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4289
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper-layer devm_request_threaded_irq() function can directly
print error information.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/intel/intel_bxt_pmic_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/intel_bxt_pmic_thermal.c b/drivers/thermal/intel/intel_bxt_pmic_thermal.c
index 6312c6ba081f..aeaefbbd5d8f 100644
--- a/drivers/thermal/intel/intel_bxt_pmic_thermal.c
+++ b/drivers/thermal/intel/intel_bxt_pmic_thermal.c
@@ -245,10 +245,8 @@ static int pmic_thermal_probe(struct platform_device *pdev)
 				NULL, pmic_thermal_irq_handler,
 				IRQF_ONESHOT, "pmic_thermal", pdev);
 
-		if (ret) {
-			dev_err(dev, "request irq(%d) failed: %d\n", virq, ret);
+		if (ret)
 			return ret;
-		}
 		pmic_irq_count++;
 	}
 
-- 
2.39.0

