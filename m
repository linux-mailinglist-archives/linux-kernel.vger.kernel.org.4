Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E1473F57A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjF0HWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjF0HVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:21:40 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20729.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490202D63;
        Tue, 27 Jun 2023 00:20:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrXBcy/Iy7nHI18BgL2/2UlObyhVYzK7BmcI5Q1zyPvig1A89fTNeSiIqD9TV//6BUFq1QPhZJaPK9Li/7rwyjsu5aM0DB4dI0cqjd7EapfiJ1IEGAILuCrucd/YZebchxktPBsgvSgyts25LCmCUsrDcd78fDEgkBLUod06N5XH4Sm1g0XlrHVcKOA/crkWpfFGU/ui/qhu38P3qfhnjErDJnunEWLUinxSv3AaMUUSMi7vXfmJqVbVOS2yqCEsNsa07WeA8ZbIZ1AaX5GWgJoInwbh3BX6pA3WANR0sFSYq9TFxhXYRHu7r3OTx7J7G3Bek/PdC7Z1bOxl/eXUhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNadqL0WqyqUBdkAuQcsi37js7GRgeqx9jrx5etaUws=;
 b=b3e7WurqVXp9b48LIl5NMzsPPBL+QEbUR+JJDAewjlHZCyMKT+zbMYvwC5YKxoZMnLbvn0lPxqeK8+spNbLYlSCEnTJCYNbxw+PLFKmt9ZK6lmWw9ECJFrtfELRUyuaQH4EAAWUnFWQ6fw4wMgpJjCPjRK0a2euMv6Zhlki/ewD+/D0fqK3XNNtAWPv4lnaoWEUGbuCEahOPdHo0tpetF8QNES628xdQu67n1T5iaNcTAUABjIhUqzgeeIa2sWZF9/rSMns24xRbGq5vEes3S1JPPTZtoD7fQAWfehbeMZV66W0EnzebSFe+6UqTcs9DDQZd5yiHtNmDx9AOHDa7Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNadqL0WqyqUBdkAuQcsi37js7GRgeqx9jrx5etaUws=;
 b=WOlkkjcRoqiMG7FaktUt5pvvFGqfxMuRjFyFf4dcrOweX43hLDW1AIeWRwj1lH7pOij+F5na3BNNNNvXAQPfiGATy87PZoF5qS1YcSeCUDjas89UBZdkGR1dCCmEfOV0ivp1XmsDmOD08HnMHTu2uQxH0e89PlIVjbGbQLpRtRERgb0zV3cTIBSiea0Z+TgAojvetgtzP71DKu978qD3RCxMmkSfGy6jISTWTAlfP5LOqnx/LvUft0EMmcpZSnk2hh2mXIV4qfdZnkG97HT17k2X7PBsRneuNa779XuupEzyOEb3ZSVRsNhGEIMeCYWV4/2eCsm/kQimPmfPi5AjRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4289.apcprd06.prod.outlook.com (2603:1096:820:78::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 07:20:00 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 07:19:59 +0000
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
Subject: [PATCH 15/15] thermal/drivers/mediatek/lvts_thermal: remove redundant msg
Date:   Tue, 27 Jun 2023 15:17:06 +0800
Message-Id: <20230627071707.77659-15-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: e0d8f096-6dd4-45b8-171f-08db76deeabd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nU2p+ASGFvDR5WKCJNn8CyNovmGR5Bz5em6VjWVVpoA1PPsi9y7175fhKJITlNjBryrtTOfvLcEUxvijJNL1XbKICSQGH93vR+Xsno6Q6qACxVDQtmnykJiC53WRSMre2jhVBLA+6CFboGE6rO06yrs73fMivMZrpq6gMM8FxdPxaRCvzz/yJS0N3ZOiYXmHaIV8HX1BUvtT2lKBZSMCfhPxVGGWjUc4e/PBWiogfK+5AiCkFQFkaFuHAfWkxr29QW69MhcEcumaTAxnQMCSviskq7tg63xEgW9Rq1y1jROOeAw581DhnHv1E8lKine8dAEDfug9koF3DjR5G8o7o1I5olMb32pHePGofQle7TwYUugBfm0FT50lUW6uFBqbLtlWvXRwm6y8W4tT/nLp8q/cPwqXN36mcIVU11wWDbvaRo+sElKG1Yosigt1+QIOJT6wVnUNVt6tdDyM04kFIxSdZHurpPXJjkacmqZ/qZjt0n2/04XZisCEqy6CQsOgf8pj99M7Cp6bv/EBJ97Dz+Hgu9xwuWEcaaRdRPLfjG9zHBEqIxBe0hC6PrWh8vTBOWR6CSu7BElG+Mi74ubDs2p9HMghnzKsbRw5u+pnc3Fj0uccse1qbmc9XxOmFgvixrCzlKpGN4/Zkz8xOgZ9NQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199021)(6506007)(36756003)(6486002)(478600001)(52116002)(2616005)(6666004)(83380400001)(2906002)(1076003)(26005)(6512007)(186003)(4744005)(5660300002)(316002)(86362001)(7416002)(7406005)(921005)(66476007)(38100700002)(38350700002)(66946007)(41300700001)(8936002)(4326008)(8676002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?spOZMpR7b314EGbX6EKO4/obELRG249t6lk9KTRg6wDctoISjrXrTCVefnWT?=
 =?us-ascii?Q?sPDfvGW3ACmCscyfHRN0SAQh79EzPqzhKDHvbeLEDcp00YuRasafG/RPctIH?=
 =?us-ascii?Q?6v34zHrQNP7V649S2sw16Uq92OTRM3N/nQjm4MgOXsZzDQgRdxS/aHQUsA+a?=
 =?us-ascii?Q?kpoxGnHGjTI8nNKsJORl+s8jkfwyP58OTCHXScXU9qRENF+ztnq3RkQ6O9E+?=
 =?us-ascii?Q?FsO8ZpSQvmJZa5GwQMag9GikB5e1mCtXmYfjo0GloR0mvp4PF7iO0NXYNbvo?=
 =?us-ascii?Q?BtWMOC7WW9bZoT8PLW58xyPAIfUjAWvCHCarriB7XzOaBPaM0WUjJZ8ppip3?=
 =?us-ascii?Q?rlI23xWGk3sMF3yNRHrLXl2VJw6Ktc91g23t5HJJcxS5s/D2ShxcKfEOUsJ4?=
 =?us-ascii?Q?4uBkQUHkNw/N9V6Pwuv41USeTnMSGnFCsaTb8xW2tVwaaF5Dxe1RtrH9PYuL?=
 =?us-ascii?Q?8AhgGZKFVC9V4zMNhY0TA4OAHi2KwbPfhIC1UjHf9HQCmtl/qgYA9qtci8f7?=
 =?us-ascii?Q?5/QrD7n3NoywUmOWhqe1UCKutXvv/hyfm+kurZYbrijxTrNhq8gh8XAfMArG?=
 =?us-ascii?Q?uHj/5NxFsSuWh9HRv2lwhoFRly4SXfHMcphtapluuhqO8qTwuJdbafPmkDaS?=
 =?us-ascii?Q?b9RN9zyDiDBJ/MEDknU+W2PYh1aqEeXLGRNWKVFza1S31WQ2S0yVXZttf6P2?=
 =?us-ascii?Q?pYGDqHFiWLBjRxIof84qqdbjIJT3Xl1mHOxfVYIkrzOMm/3RS9+/mmerh0oM?=
 =?us-ascii?Q?g6BlGZhFwOxl4/9jE3XAB6r7zcramuycaX01G5dhbEkOaNtA8PJnHlAJPda+?=
 =?us-ascii?Q?HvWzYcczHsLZ6hb2GhVh2T9LM9Xv/Bl4vGcdxhzNHDBnUyeh2AXHiAD19SA5?=
 =?us-ascii?Q?rGhR66bCX7MCEE3b7AvrPij8WuBldxk9Dk5Gnstv8XXPJSij7mvpO9SPkslv?=
 =?us-ascii?Q?U0qcyKN9fnXCatTgvFV+ilUcC8fekv3tznGvHi/mPjNFXGgrgEAxKzbl5XKj?=
 =?us-ascii?Q?CeNvDh+FT7U4keYS76nMyRSBxLJ10L14j7sR7B3bpR1gT+9Qr1dDXBsiheHq?=
 =?us-ascii?Q?cNpRXswzdNQJaTOmFYKfjMKvjLJPCF8eQ5BurV/lg9KY+KO6p5FqRBkjYanK?=
 =?us-ascii?Q?xmbHZDL61915IcTFChw9gqK52BReFGZzTzQZ5h7FYnbFIjPgELECt8oU8JdL?=
 =?us-ascii?Q?vyxqUD/nXm20TuVQWiak0+s3mBpYp4TkzGekh+ISBtvSESX62o5sqdhK8axN?=
 =?us-ascii?Q?iVM97a4OWSRfNCVvG3Tpc+YgCUJ7HVa4nOLy03hK3VKo9KRXKts4YRA43bml?=
 =?us-ascii?Q?smPn4QNSwn4CYBCLiJOjqBXnhciqMofIybxw8V+t5EhD4NgtAYzIdqktJ7O1?=
 =?us-ascii?Q?e05XF16zJCJhohkV+SBhk1g+VwXPlGnZj9If8ipi1MjO8R9MZd6Fexh9yDq4?=
 =?us-ascii?Q?/RPswhnoEa3imyhsWgHOTMQ5j77A/CVIkJwnyPt0O6QFP0+64QeR+ZbAyL9L?=
 =?us-ascii?Q?A6X9NVXcod94lLYwb4ryI1swoZL7whIgMk72AfJLXpG4T1JqerEldhSCb9Fo?=
 =?us-ascii?Q?ahiPtlq21zdJ20SnAndn60WBwI/XggTNKLb4XCME?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d8f096-6dd4-45b8-171f-08db76deeabd
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:19:59.7872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9oS8dlQKhNVcWkc9pJPLNfkXYewt6CrIO6FqRVNTir5rFa75yo9PUrVQvywraBM1Au6a+co+lPAgY7Q+vCL6A==
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
 drivers/thermal/mediatek/lvts_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index b693fac2d677..bd503fbcba51 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1151,7 +1151,7 @@ static int lvts_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(dev, irq, NULL, lvts_irq_handler,
 					IRQF_ONESHOT, dev_name(dev), lvts_td);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to request interrupt\n");
+		return ret;
 
 	platform_set_drvdata(pdev, lvts_td);
 
-- 
2.39.0

