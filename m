Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526BC73F9C7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjF0KM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjF0KMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:12:50 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2094.outbound.protection.outlook.com [40.107.215.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA28C9;
        Tue, 27 Jun 2023 03:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTM8Ut8HEZ917ZJJA1KBVmbTd+DxX6I9a82uTjavo4U2UmNp0tOlCJt8QybDH/V6TwN8rWnu0efU3CWb26CRZe8JBXRoiMUL9x1d7pIh1vUB0VVwnVsqZiY/98Pi1gi7kMSdKjpKCAB+B69pdJEsAnjSawm8YIum8KOjcrVzVzI8uqAIu8oCpBCZo5Vi1yfeuHNUwM4+OaLlOpL7/8OJH0takyNVD1iGJKG2mqm2s/GEOdt5v8yDNG9GbQoKVux14ptWDdW9fwTUN+SmBE2pu30NewPWCJHPyKx/e5djoTPRybbwOO5MXfTc47jEXePhHSA/gluFDG7vPX2rLLiPcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Qb9DNrkU5ARIUU+cr0yOK+SXTENy6LaR2AmgH4Ek9s=;
 b=VagiK9zAx6J3r9729m0bcTbAQGJ8qmqQA9DJJNq+t5bHI5ET06oGc6GOgRoBrl+sWfekhaSrFiBLxnsy/M3OIFggMkzNBL88DK1DQyvkVEubfxWz6gYQouGm2V52MdZaMleY/Wj5LJMcEcu+j7Tkx6GHdPuOjzJS2sQA8TL3LgZQqsEluJzg+pb3xJ4qiQ/qMg4Gb3xOupbZXMVIKd5UH/HJRjhpEOI5ZAgFuTqJ80JengWmC2cbB7RB90zpiZk7Wp4H3gKpA/sUD+m5GMm6Xn11EAxk7SaLaUph0nUsQfopCRFbrrG920A4PeHlcD4cNSfCYq1In08jP71xJXkhqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Qb9DNrkU5ARIUU+cr0yOK+SXTENy6LaR2AmgH4Ek9s=;
 b=SUrbqac3EfGN1S3nopkNA3+9TTbKfwSY/fMd2NozrXJQmjYc9EbJIemV6tb7kUzUS78L/M4k9z3Aoxgf3SgnGZJyZP/z9fDXXUoTJ3rZRWQufq/P6AlesBYfJDRuoYecJzSn8NSepTeRP3lNyp0DoTWshA8kF3yYmDrOMZ4hlJQ1lI6Yh5SBhTAs8pUWYTkFw0xz9rLr6yg4R41xEmAoU/a+++75qz0K4Njc3sgDYZAw4VAq2pKwF9Q0OtkZK3GWWdlmZznrehAbkmxukDQto1QWDBjfr3v2EJZkNxetfkJetTKrYLptg5oW1ERVwJ3/P9cH2yvlN/PuELXxhYowTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6661.apcprd06.prod.outlook.com (2603:1096:101:168::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Tue, 27 Jun
 2023 10:12:45 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 10:12:45 +0000
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
Subject: [PATCH v2 03/15] thermal/drivers/brcmstb_thermal: remove redundant msg
Date:   Tue, 27 Jun 2023 18:12:03 +0800
Message-Id: <20230627101215.58798-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230627101215.58798-1-frank.li@vivo.com>
References: <20230627101215.58798-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: cf15c978-270f-43ef-3f1e-08db76f70cf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RERfor4MyLcbGi9OEmOV4YLKsrSiYlxbP8Edx+oTZcMa41NYiOTT5LKGkhSE3GuLMOulYXxn5wGi80D5+eUwK96TK7GDxkAnX+aCVLCEWXIWL6gcNf5h5VdiLLY4oppK9J3B0S2ZXC2YjEy9hvZowjrps7mVj+XZxoDjBtVcpAWiOwW9g1HP48GcbGKZROqQaFGVD9siDkO5FHc5M6iwqCIAOy5CUlW1tUsXuWngR75wXzJvwNEaoBQ1nbUViI6CCivRk9VK7e8bN7s+uL/yEfaMwFsLCksQPF3US9rIzDVDfQP9hkxCPr8AnJRIxxAxVOo8q+oh6c6He5rtbSFugcSDCLtWUQEWDLMsKxCqlE6HN2YTgpyOFtzGOwubA0/B96vAf/m6JYwWBzWpoitJgBLYzlOHB031vDnMKpAnN3rqODpRr8Bc18KLtBOoKrFe6efPLzrHHbYlPa96rDe8tOiWR9yzaFUgf49v51aynGjVgvlwirAq2GCiA7xcEQt7CUmLUJhjq5slPX+IfUcab5tNb56HSw1zUQh/cgUDFNP/2viejME9CLLILFyFwHrxZO6qWqvkri693bzZ65G0QIKQZ7rRSsIU8ctkK5FY09+Qcx1fczkhEfSOBsOHYghiIQbv8T5Iz5W60ZipMEfeiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(7416002)(7406005)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(4744005)(2906002)(86362001)(41300700001)(6486002)(52116002)(186003)(38350700002)(6506007)(6512007)(1076003)(26005)(6666004)(921005)(38100700002)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gZrIHnwY57CSpwFfHru3Ncg2OyDV9/BcWfmFvajGTcdMGfHsVH2bsWrXD/Iq?=
 =?us-ascii?Q?d+GxtW1qyZAtnapK4JCnPw8oGEZT+F5DhCDK3VtTrifYpWjl1QdU1ChKB83h?=
 =?us-ascii?Q?l4bATETNOk1jOMA9s1ETN/RaUhJuz59QVdfOiAXYepGXulwz9jcYAHYJm2si?=
 =?us-ascii?Q?4vwOfmV3CdFTsgU/EaWFXzvX30PnpdK/1+mKyJzWjneiEecayxXVgbK2hmnr?=
 =?us-ascii?Q?xerAwLstKt4ji3o7jO987a6J6n/JENA/Qd+OW/0zNE16UV7g9/mdlAO9u2sC?=
 =?us-ascii?Q?QgrjhnjszckcsVl0xBs2eSsFJnzqRv8/DGSMTxWz8n2MPYxN74HMtiEYCNqo?=
 =?us-ascii?Q?kOkKsulhz+VURDCPePnfnzfV4IYHFdZYYPaV1tzYX3UGi8XzBpO/CfHreqiK?=
 =?us-ascii?Q?dfigXveL+prhWYbrQQJ0DucaHV3IEQ4STVjPHnDydEO382UC/Aae0EXh7DJ0?=
 =?us-ascii?Q?dF3c7j/G/SRTNihruOMCoOGgcTrkmyVm4QE0vV+fwUj14p39B0zc8lLAJmXu?=
 =?us-ascii?Q?fU34DGkmf0/cvNNVtyEjcm4GUVqpfcWLhGBA9izckRSKlU/ZMLBpVgrJ7sgz?=
 =?us-ascii?Q?9MOuZ+hE1xwRE/VMYx7Gmms89LMltk69oOTZskAMc/gVohC4hMFH488okbVy?=
 =?us-ascii?Q?m8YkJK+j5Ag9QhKqniHkWU5bR/ie3ARBEeubtnvTK8Zj52cveI4exJn0T+2K?=
 =?us-ascii?Q?ME+iyqcPqLEfUzVGFtr0VFiY3NJrBQGUIv9biv7dDtSf+KWdsdjnMvK8SUlZ?=
 =?us-ascii?Q?MyDdjKU63glkRkd9Woadbh4bUhON4LxcfHvAvXWc7Kjb145JQ3YAF20fBeql?=
 =?us-ascii?Q?EjbGOBwY1fN48ZHNwPG6P9dz3NHGsY0uVCvCP5qqIhqZu6GY6Ynlkq7+w+1k?=
 =?us-ascii?Q?yedprIQVHJ+PdsRHZD9V/yqV0ouwpLme/UEQ/H1DnSIlhV6lxhTKfwpgalgC?=
 =?us-ascii?Q?s5uxeIRsvHOXAicEVLwy0TPPwMrwiyu9JSbxu8XxvOU4AtDZwpxA8YemTyix?=
 =?us-ascii?Q?M363erwx6jdtMuoNTwZh+sOcAZOs+mvS5THqGNRERf8ncx8sjTbLHE793Efm?=
 =?us-ascii?Q?KmRsKR5wnlFj/UPXXuX8h/4ypOLsR2qbgBAWQge3JA13y8naCfA5bF2bHwTV?=
 =?us-ascii?Q?gpCOEISBbzv6KYfbLGRCdZqUDS8K8kQfrF3GdidmlJZBoMKWwp2IrNQpnz5b?=
 =?us-ascii?Q?V4CFj5+Q23tlCiqx/sw+7XJ9LTF8Lwiy8SLydy4V3e76C/swZnj1rrLm+VT0?=
 =?us-ascii?Q?PU65oahLXr/zLSK1GYpxD3itHTIdkZePXTQptxqDL2h5efGJNlQr5t7CdxsF?=
 =?us-ascii?Q?v7K/I7Cc3I//bEHP83+JwiOsznwIB6i5BH39CvVrmdkNOmwKgf7E1VaHiJoI?=
 =?us-ascii?Q?mg2uA8m4EP1OYE2FauP9lQUchQu0X2fvUFK2McO/UwmX3B0AkWawGD712lTi?=
 =?us-ascii?Q?3cPUw5KUXP29IBfdyBQAqZZEtsmnT2Zvoe+t3fq3K80Iy1E+0iW7QbWvOCKh?=
 =?us-ascii?Q?lXkahOSjesx3GYNZH9LsAjRzbIu6iszKfPTZhQlzji7rquZ32BCItfQYy9Mt?=
 =?us-ascii?Q?KtUkl03INBjVjMCmoAyUPUywsW2wbnqsbXPHRxzz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf15c978-270f-43ef-3f1e-08db76f70cf9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 10:12:45.1572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ku/+q/nqrQa3cKAhnUAq9ILBPB8xiZemGqJUyhiX2BBQRU3Tx+GzH9UUdlGTuwkdPFU1e5tD2BH9nGsaCQHXRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6661
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper devm_request_threaded_irq() function prints directly
error message.

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

