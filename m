Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D6873F9DA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjF0KOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjF0KNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:13:40 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2095.outbound.protection.outlook.com [40.107.117.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21EC2D42;
        Tue, 27 Jun 2023 03:13:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kiw6BynbzZ1XUDf9BkSQzUt6j7u1Gem5G8OcJ3xEsvWRuhKVW/bTrBuPDP9eUBNSkoGms1WxVikgxJ28fzIA6dXSQ2DB0+tLvm98O2kcntFExbrU4rnN6Wi5x55DO2hZlGMSoPcqSmJt4E9skoAurBO3KcdV5xb39rPep97vjBb/C6O9IkCbE6pcfOYAZmIj/45YIRB1RasCyJEGkVEtPoic1JjSP1+FklTXblnO2JknNcGqmiRcZ/QBq1kkYiZ2ry8cGloy1UQIuowUY/468fYbaap7ED+ssoI21tyyJjRfm1HmJK2h7oJqx/8OXuQmGnKuSLZ+spL5UhKWRurNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8Axm/BuHsL9VLgY4AKkzo4979rWeQfa1Dr9NSzhxws=;
 b=oJ+/fuaH6gpK2Smme6/WQAnZtXfOkbJ1yj+lsMR3QCQzj2F8Qbxa8NnxmAz0X+vnOFZBLNRM1uxBD1JipBMe+SiqzoJf+A5NVEHmkBiht2FPbEF5ewNt7bbWJKc+woDoZWwzyq9y8CWQ1XwFOfVUXugc70T6esPgfRVHeID7S5OFAFME3/aGF3iH0987GQo74uMc8L/unU8lNf8fimeegYKQk+He3W/5cVjhs79JwY2HhSASSAevZTYqxlMzVViD0mu4PYUkaPxCE/+c+ja8rEMKerwWxGk0br+dfeFfLU3PAJMQdGK+W2f6qQSKihB3HXV2HzwjTJCzUTcY+wzNRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8Axm/BuHsL9VLgY4AKkzo4979rWeQfa1Dr9NSzhxws=;
 b=WQktMvxvOQA1QjcDDGXW6icrvuowYvgKDq6hfbb64jCqhv9ecD/Y2MYvC4/w1UxHg4Vll5xlHMozZ1674WbxwRcOak6KnMC/zkXZ6LxJvokUQr+fEivruLaJBDgoSJay6VsQVBXmlhJOBh8qrw0CssX7UC3BxTPEHGDPvqU057Xjc5/vRFZIyFoxkcBhP5PkVwwerqol8ldbBwbMsDt0f5a/p2WWfngcpwB5RmPJlrkWCM9hDAfRqMpf1RisPAdBoIjNmsTv9JcdyHVVgg6h0XAJszJWHeTGxgcaATy/O5lASI9U3Tt0UaaYzBp7jteHTF8PhCKby3ZVpyrJlYuong==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6661.apcprd06.prod.outlook.com (2603:1096:101:168::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Tue, 27 Jun
 2023 10:13:11 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 10:13:11 +0000
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
Subject: [PATCH v2 07/15] thermal/drivers/qcom: remove redundant msg
Date:   Tue, 27 Jun 2023 18:12:07 +0800
Message-Id: <20230627101215.58798-7-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 148265fa-4ffd-43b2-f63b-08db76f71c40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eor8qGPwK05CzpM7iWwIfUlopexYW7aOWjMw/z1S4KSslc5SEYTjLQqKgCul3X4UWVQuszTDtsuSEQM1XCAlTT1uUB0sqTVFrhE13A9jpaUbub3iJtGuoeWJOu24+DGsp3U+rj6JnnEISwxcwgZBrBUCY4Q3F+vFqdXC46famkRYyG+e5ZLCHyoo8NiwP0F/yLKOlJOXJqSwJ2xH1xZ7npHhu543X/Rf4gUIgoObLhwDrBFd8ebVovVZx6qxzpaMfovN2O2TeGO1yhv1HovVu11J+RR2UnC9KuGCKDWSlvL9EZI5jy4fKe0mdgNGXGz+myDZxT3MRO15Oz5eYJhxFYTKO4EgpCo6O5F+bdlPmMG0JQhwrbb16NMwodwcx91zRgyc7qa/4k1CLNbBauZIaN5ZggTw7TqK18bm1Vy+JeMksCkn2GZSPIiFL+tIkNIOD6pWHQ3UJcp2Xy0rJFnhfsAndhWQjSO2aVbDLg/WrG7ecfFB6+zy6SjnpKglfLGJ8EELAYrcT9dWIXaE7Xa0L7/sIDKfvaCMz+rQPmh3hLHB4SvmD9jyC7yN7UwvkRfXXz0XkT7/nMkwfJnjDO4YO5uzkOoz/+Don92T1cLFt7MirlgFu9j3DXvHUlxUskCqFdjwX7njO7S+J4P1yph7Hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(7416002)(7406005)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(4744005)(2906002)(86362001)(41300700001)(6486002)(52116002)(186003)(38350700002)(6506007)(6512007)(1076003)(26005)(6666004)(921005)(38100700002)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fQTMr7uxST8PlTaK0R0ZATo7dFeZUYQJ9uLrhi0q+b/l4XOiEiVgAWXEokao?=
 =?us-ascii?Q?RHti8N/34F50FVei4SC5mesPwnbIuT9URHDmn9/nUBSQN1DEn/jVPtrqqHtK?=
 =?us-ascii?Q?+vH8jwGFbLdaVhKklc5YQeX2Jajv4fJIbc/jKoSZ/AdDTHVrG8BF5mpdZVmd?=
 =?us-ascii?Q?81HerLbHB/QPNzFjZtwlkySyq441v5GRJ4ZIKT5mEXjIE/XpoBHmyGJCqzhy?=
 =?us-ascii?Q?+i1kVunzqN+Ek3KZcngXnZLuy5ypmmmvYQEDOm07s7tNOERg8ZDKf1WYlkns?=
 =?us-ascii?Q?51ZvCzcJicTjmcNz7sVtJvr0EJxKUVtKNFBfHOU5AfBtGMxxiEm+Sfjyt/8J?=
 =?us-ascii?Q?oWcCkei5Tuu/P6uKuBer7om5foCOSk/V1dKeHw/1ySBOOcknqPK9A854hpYJ?=
 =?us-ascii?Q?3QHRenrdn1WzROoUIz4SqoiVyFhZJF2j1iAVVA4sO1NrE2OaUC3Y7y+wJKHu?=
 =?us-ascii?Q?15/Qi3HmGClGT1zu9aKp8wyJXAq83WHuZmKx7pynss1WDsgy+8ezA5HUp6JB?=
 =?us-ascii?Q?j/nIAgAS2WDTVHtoXDcGZ6qas/JZqDsNuzFVATn8iqd3tZMY9A7WXurB0WMI?=
 =?us-ascii?Q?GuUxqVVdf4QzDbiGXpQaN2Xk/YZMStg0ph/Ex1pi8PzkIdrXNes3+F9eyQ+V?=
 =?us-ascii?Q?xZB2PY+FSl37sJTyxjlrEGtYzy5mFkkBaUVnIDQH4yBT6dPP1y5HTguyldQ3?=
 =?us-ascii?Q?QO5vPqRExnXZmD/m9KUHvO0dx9fjs6k6LsoXxxxiX2Cc/Rh5K2CEvsZEXOjd?=
 =?us-ascii?Q?NMV+DemB6+Be78+26tx3tR7aXj6i6tKyku9Xo9KhXmqmK0x/pb2+cnuU9NF0?=
 =?us-ascii?Q?1wHjg+gGcP2KhHfHEEXlRZVT/JM4e903SgwwUjdXzmKIb46zxuGgKoCGVSga?=
 =?us-ascii?Q?6SszTdZxzpebiaz6b1hhRWQxnclPyJ0eYEW0QRORKg9g8J401st+NW1cvpSS?=
 =?us-ascii?Q?l0uUa81iQAO+vPzCniT5KdhhqhGSqhNklvHNgUvW2ZV8vYAw09ZR704SMtxB?=
 =?us-ascii?Q?NHSGypKrDDerORhinxSU6bLK+4eyVZ4Rb14qyNrX+kNXXbgzx9Vozvs1GyWS?=
 =?us-ascii?Q?0F8zeVyawrRgRzvKSfAEL/6To036hOXIh7WevLJtELVqfDUOQBvg9xlExM7T?=
 =?us-ascii?Q?T1C6GP9JeJzF2RghXnlfYvqHThshwrv2eEPKFu6Yfnec3TBlfCX+L0ShhfrC?=
 =?us-ascii?Q?B1/ofbG+52ACm3hO8yNMDDXNIW6ym93ai7574yGPPISMClkwpNEqgli4xqol?=
 =?us-ascii?Q?NrMcCWWQ7g5O7lNUJnsAYjlMECZssJS6oydM8Fo/5GTZry+1R7YwQzdvUnOG?=
 =?us-ascii?Q?A6cuwHNJD7UBhb32+JvkPooxLW9uLKcsg7C2JyNJc+PNTVwkB6c1BEbHnONV?=
 =?us-ascii?Q?EujhmQAxF/njIh9v5eTlw9nh+jWyJkfUTOoFpEOPDS/ni/2ItAtwAoIQqFX4?=
 =?us-ascii?Q?xglYuQxtYCRIOpbKmkRAliQuSg2E7w9OO8AajpWTHOEa+fYhAB0OzYl0uZjV?=
 =?us-ascii?Q?YaoSt5eSQOromor4ThmXW+oHlRbS1t4sKw397inyXUfcy+c2PeZPrA6sRgnN?=
 =?us-ascii?Q?sjXvsl0hxGvsUIqE3O0BokFTbF82Yi/r47lha6TV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148265fa-4ffd-43b2-f63b-08db76f71c40
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 10:13:10.7839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVNuQbifJahXTOWVct1tRThnMNdv0ju7mretjlBVbfalg5oMpob/exAlD5IU34+b4MTi4Wx81qsgxQoQ1iuEWA==
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
 drivers/thermal/qcom/tsens.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 98c356acfe98..63a16d942b84 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1182,10 +1182,7 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 							dev_name(&pdev->dev),
 							priv);
 
-		if (ret)
-			dev_err(&pdev->dev, "%s: failed to get irq\n",
-				__func__);
-		else
+		if (!ret)
 			enable_irq_wake(irq);
 	}
 
-- 
2.39.0

