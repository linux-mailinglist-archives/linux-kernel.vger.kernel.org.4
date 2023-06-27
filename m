Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7149573F9E0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjF0KOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjF0KOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:14:08 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2095.outbound.protection.outlook.com [40.107.117.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD97E30DD;
        Tue, 27 Jun 2023 03:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmBcx+cB3ZVxPE6HWb5S8cvsO9jfBQoo5/MSKMlHNqHqbbohrNSvU7W86UDWcaUMyZX7EH/DzDylCoVFZ+26/I0vxKkzeYs2davC+0vDz6c0vNeVmeD7DcVU/I7pg1ZVKZnqvwTkVCML2kIfjiNPyOkCJ9EKv9irflTATc8VjBA4XOO7j/AAZ2vOE397Ojqt9EtCZqEZUwa9bU8qjDIJPgbsahvy9rRAft/8kScO3iH8NzIFTTWwVr1uVqcf+K9NV5PzQwWaaVLdlPenBobTlvaXlyuxDZCawe/BV5jMnDCUzT8G7PfhwuGYBeo5siEp91JJmBSYXPo0yZWO+WeYnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXyKZW0aj2PpLbeRv4C3L5PDEJAjRqqUh1nnbB3UbQw=;
 b=F8E5dbl6bxRyr63q0Sr0qQKGWcO4j2mMwjA5kwqVQQdK3lZhcGym5I/QdRTykGWuKTw+n7V3CXZl4Bjhfuay1ehxo3j9wHm1ZckYwCjKJBy2/lMRHl95IvezE/cSdRqi6trXK87WJMjRHORr2oHgfecD7P0H0quNibIiFpo9PVhXT7TblawxxUfJwOKutICJLIIyCSBcUPX/q5gH+8VctcSQuyD1jV29I239mRqRyu00m5oBoqsLCwdFAYymmfYReYBfpWc+yifc6XojBbZhyIhkPXRt2ErUPMFUoJdjF5544n7Ln7wSW9NjlE4N7ENbxX5G2Zw22HChGPq1TuTA2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXyKZW0aj2PpLbeRv4C3L5PDEJAjRqqUh1nnbB3UbQw=;
 b=of9AJJLnms2UHdrCdF1h8G5gT/uXiYq7+YfhLF8XNDWzjjTFnHK4uqAIpoxehxY7uCRB1+xOcdvdHT45gD3UwsdT/TfDcVke2/YP6KljneGvqx9k3KHzhZffemv6zwUCn+Z/WSKKTOx3Mh1JGOshpKCAh5YTPwVDmB5yJx07VzaELWxozmn/8dIPfkuyEUpYiaTIzZ5bdYySr6M28qVAu3fqK8ymnsNBXcAlzUYORU04b7x3qL5osVOdvHH01uUzRFmJh5chOFVdjBNCuhXdsyp3m0UGUCpbTjuFYaUBUqeuR/r5VXB3ryr/+kj4qKVC7+TmJtgTgTZ73KPxAhKCjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6661.apcprd06.prod.outlook.com (2603:1096:101:168::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Tue, 27 Jun
 2023 10:13:17 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 10:13:16 +0000
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
Subject: [PATCH v2 08/15] thermal/drivers/tegra-soctherm: remove redundant msg
Date:   Tue, 27 Jun 2023 18:12:08 +0800
Message-Id: <20230627101215.58798-8-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c9b0deea-18f5-437c-780f-08db76f71fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UlTtzgRn5FXJyhAip4jwhh0Vl5cJVmJBmXhdzMjpKAILOSXLVYy9j2QeN04DfjHAHmvaPcbY/GHW0jsI0QGrZk5l/ESD6qkJyDsUuBCJPEABr+xPcaCMrkdT3ju9gf109itCZm+fnHmLlpVkpDf0yoGe7lIS8VC7Ab65KqwsLvB2KrlffNH7m1zLk9iSv5AEVVFbzoLMTqbJdh8peoIwTadBogm7SHgdJR1FQ/79vsSUrbseWI/cM9vMhfs28IOhAbDJaYsOkGZyormBmwXAu4JoVk8RGtWXLR/EmnaEtRRTQo3lZGmnFJgg2gjmveUSwpExjgNC85uk8twKGY7kfYWDUcMw5TgTI8IcKQYHY94o4MyWbLbRabIep3ecG/wtcgnzEEOFwAR6UGQFJcxy4B5E9HEDRcz6kUI8DZ7oW1YyOQjmhfFH8I6CLkKdxcuUpBkhw54g/pr7vcVJbS3oEdSSwIIGvZktwOApbmDqlj82hY4Td8vJwGfxaA4LjD/xTltfd88i/Uk6vANuOWXqPNZ3eCD4XH+hsVfU3anTfV/OUxfmHpDpypkI/Z0Kl/BYeyxL1ijDR34BDdjFE0z6BeD1Aa3+BJpSd4ak396TZYtTAoOO+AQsMilBNc4QFB1V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(7416002)(7406005)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(4744005)(2906002)(86362001)(41300700001)(6486002)(52116002)(186003)(38350700002)(6506007)(6512007)(1076003)(26005)(6666004)(921005)(38100700002)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+yiZLuutQmloOKNeOsCG/BUmeMiq43sB8/rrT9ujBxJ3ev5/THOQFNN+qG6+?=
 =?us-ascii?Q?aMlsqwjG6+WX0EdSeZZzt45osQgw1mqvM3EXwlaQUWzOcNIJ+mLGAOk5fU2Y?=
 =?us-ascii?Q?1XXvefpVOmzfBetNUsS5jRlVFQALrejDBS/NdRdF03U2phSEPRVZvlvMcTwB?=
 =?us-ascii?Q?tmAiZKWznKSFQtErbohuMHmP35OhXxyySTbwBoPaQbE/BL7XqLTcCdW65P/I?=
 =?us-ascii?Q?Xby57Ql/FQDRRCaE8X786KPBPbUslkWSis0GvfIIWRKrMtQQhTJ/Z4/V1PbN?=
 =?us-ascii?Q?bk2tiwQbFH4pkNhl3xPqKTo0v7otVgw0r2tTLfRzGFI9hCg6lrGfKcEAPcPf?=
 =?us-ascii?Q?lsYZtSz/6T2ph6a7ERCVxdus24bC6i98d59u2/8mTUTGyjqDSLTz5YdOW+0m?=
 =?us-ascii?Q?XbcWVAUPbdj7blL5w2RY2CUxKvGXQHN+MaumbbMfn3K1vVapKEZKRgFalTuI?=
 =?us-ascii?Q?2OSLPbBxoTgOoIzkrYUSgLybmeYNLKglxseojvhe1U8iBJ3PdlWmuGoUG1lM?=
 =?us-ascii?Q?+Y30C5h0ta+EAWgdywWEqHa+pyexXEpkRPnaMQfhwVTPBIeG2I4wqzA1C+F5?=
 =?us-ascii?Q?UaM+VNMdWED4JUFZKvtRM+wmONHx5LhyOHxH1bvpBlyG2DOa/mUQnPGZzCkD?=
 =?us-ascii?Q?DaUxdw4Ssb1Lvm+Pn2hLlQwprPBGJK6pbMrJaNBzk5+D20FnSn5wMyawzinH?=
 =?us-ascii?Q?LktDWDGtgwVTO6gTyjJsAqIAP5nTn/+MTdezl/MvNhT/9iJsyjZl8hkf7IJS?=
 =?us-ascii?Q?/Io/waiMrAMAqtBFSGHv32xUl6eC7Jwd2KqelxIV01GhcSU/AYn5J2pAfv5r?=
 =?us-ascii?Q?IuA2No10huOX4RIWYx9S5QEW0fzego7K1aHMmZ/xeWWtcLbn2tx+twMSE+xk?=
 =?us-ascii?Q?BzXwcb5tgMJzcavUkOlr/foFO65Zwwr/+XJaDfRQrrOOeCY8dltqv9uV2S1r?=
 =?us-ascii?Q?trD7hPSWwmcQuCgbecvOzRq/jfDg3n7S0dRDg0RmQWWZ7250CofVd2FJ88ih?=
 =?us-ascii?Q?2+eT2Sd7hmGnqbUs9ktKGzpnG914mvRzEehsHLzjknSUhB8NLpI3zaTOGZ4q?=
 =?us-ascii?Q?TG3LpTQwlAoUfwf4KV+q9+roTldO4JP6FTtPH98aeQVdL6eRn9dQt0MeIGEa?=
 =?us-ascii?Q?Px5nGlXxdtjdN9n3t4renyJRSkwRUA0bXFeDNK/7onchBGnVmrOarBq1WDs6?=
 =?us-ascii?Q?JC0+OKkRrY06k9XI54hErbzMATnbkKqHllTNQCxkcrI+VXk6D8MSl8webwAh?=
 =?us-ascii?Q?uxlgqaBPc2lTKA+z1HWl9F+opl3pOmOdnfciJtUASQsu9CYr8h5YK17dE2Nf?=
 =?us-ascii?Q?PSkB57exIRpePcgzVxXfjyg+46ls7GdMXOWNyCOg1VSCWVpU0eKJ9NCnSYkw?=
 =?us-ascii?Q?DPfL+Cy9mHFTLIWWtx0XBpI2gcFC0Z6vOLleWIo0zfKppaNDWu7dySwc09Ys?=
 =?us-ascii?Q?zACemEuAx4peTeSQu7gkn7elgp2UaGsh6L3f1Bw94s8pmXzSArq3/dA0c0Ic?=
 =?us-ascii?Q?n2pHfqRuBXLNovEBwSww3+NaCikplePJJ5V+II1AgWRbiYipvfNFB+5ylVg4?=
 =?us-ascii?Q?VK0wSk7yi8xe0/x6ZvnXafxhy2yxTOZtfdit6Xt/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b0deea-18f5-437c-780f-08db76f71fdb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 10:13:16.8311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFeWX8FAyBFS0mELnqJPYLHzhLh2wJM9ug908heNIqS8dv+JG2ulRq6bxYt13+aCtmzHvxGyNQ2ZnDOEy+22hg==
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
 drivers/thermal/tegra/soctherm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index ea66cba09e56..55966c0a2610 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -2000,10 +2000,8 @@ static int soctherm_interrupts_init(struct platform_device *pdev,
 					IRQF_ONESHOT,
 					dev_name(&pdev->dev),
 					tegra);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "request_irq 'thermal_irq' failed.\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = devm_request_threaded_irq(&pdev->dev,
 					tegra->edp_irq,
@@ -2012,10 +2010,8 @@ static int soctherm_interrupts_init(struct platform_device *pdev,
 					IRQF_ONESHOT,
 					"soctherm_edp",
 					tegra);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "request_irq 'edp_irq' failed.\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	return 0;
 }
-- 
2.39.0

