Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D18C73F54E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjF0HT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjF0HTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:19:10 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2097.outbound.protection.outlook.com [40.107.117.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C351FF3;
        Tue, 27 Jun 2023 00:18:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSywtcA0SeZed3oChKoYnS7Ni97KCR5EDxnkqAAlf9jtKHhB4jaM5A7CdEYqFjbODBXz9BTZQpUSTqV4vjcK1mUV+uF7fBzDsQfCieX65eXIcItGACBVa+drlF9twId0pPcZ9wpyyFpUiaQgfk2LkecTxAtBYenA5kb8sZW0qoIa9w6USaeda/TDgXwtNvcqhGjedWL8RutB+cnFHWGhMkUsqyIzusyA7mqvJvPG8LMeuyqLl1ifTvLpXlE5QWQVe3fLg0ZXYsQtybHaNy4gZzobGlTj2cUTDxJj4bnjxedaKPEaovXsGwxh+WFMEQEob7qqSoAjYDiL7lHjCGoIOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCMta2R3xB9w9VP4jznqu9YtYOEgHW1qdHG3TEuTpe8=;
 b=OdTuYv6biUq9mOnkhSNDLYd7dzxxnj16H4DDc1Z3JUuTu9aJeyAYsMCUVfx5MlD134dzAZiW1II0/89XCzDNuX8JY4YQgJaoYnxWqE8gYj+pPySju3/yVghBN312LwPeBZmonwZSAXMpMH129/+H/6c6H+RIHoxys1wRq3tW10iAdE9dNO4obvETlNkR8zK2EOCYnnxTF62QXXeG5sfmoL1wqax2sMyiueYP5LrTVd5h905CliRMhHWf5IH87QsbThn2Mv1bGDIKmwnaGfpHi7d8MIsMeCEqHv7oCNvERtIZM0CXiQkWjgisPSN1Bye3rHchR0GsH361gT/1FkY9EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCMta2R3xB9w9VP4jznqu9YtYOEgHW1qdHG3TEuTpe8=;
 b=cXfcYDyyHeQPKkBJI/ad84YHNJ7iKfelW95Cu3OfosiZid1vhpXiuUCDtzZpgU1RqtQzivs0DIBcpOEfEklbboQ7kmDf+srKtaxt5BcERIx6TRZ9GOPu6IQUdauOVUmhJpzchmBVziPrDpJt9j2onNmRY5HCpGFHanXbJ4XpvyAWm0ZZtOcyI5yA4u/OuHuyUR7GtZGX6d47MjMMO8xSHXtrL4iXfnoyFKr7hxP58bLuav0qZyX5gfExLvgJ0f5bi3eI+kfICdpMQLezVNZphYzm0e7gX/EABI5RfvIRWzHuOafn0YdE4s9Jx9YtwwbCsG0bALmAZR1Lqdy2W72WBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4205.apcprd06.prod.outlook.com (2603:1096:400:2e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 07:18:56 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 07:18:56 +0000
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
Subject: [PATCH 06/15] thermal/drivers/imx: remove redundant msg
Date:   Tue, 27 Jun 2023 15:16:57 +0800
Message-Id: <20230627071707.77659-6-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f0acac-b30c-4d77-574e-08db76dec509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bh6sBU0+TsZVMSI5tetniLfCNbAUnFEBzAhnJNl/Qv2djq73lUxjR2gwqBwa/Ks5QPIjPKoWo24dCW1x4atkDEKkGyugGQHOBSAL9oEjKJV8FNtlmfuFzUKhiRaoLeosZ4bd39mK2Ts5JQvN+Sxxx/0pR01/YfyK5RWkvimNHfhFvCfbWlv8m7bHV1DqVyakBte/cbhf/8VLWsji0cOjjnOrR0FdQljH/1TUlyk4QVXLQ5KBvl6UmmphE6+ke3+qnuXn9fNe8QHJlGLyv7a28is+/A1GQ2Pro7FBxa7kvibeucawqDmF3isDB6EJnHI9QFNl7E94QPR8cugEmZD5Z/lfk+teidn+euSAFpvO7rLQEO9BQCHj5nB3VT+js/hjX8yIxt7IFkQXr9lF813hZ8Rf+IZTHYqD+AeJzQ8PmB3N7YaTrGuYSGI51hTDO6VQjTXSUmKbbIMT4x3+hhgf8QPKz5//ZVDW9+vmjgALmKt5MaR6iS9OnTDb0x0EwQBz9qfIWga6XFmD+xXFO/5SRUT5e+C2Jv40vfdP3c+jzw1OqJyC3tKFTzaWnduJws1TGdZS46iOVvyMMRKuyPu9w8c7QvWgg6EJwR4LMRfwkup9Em4h+KEyqfSeGGJoEr/O5D4zvbdyWjf2XHe3kyWJ+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(39850400004)(376002)(451199021)(2906002)(2616005)(38350700002)(38100700002)(921005)(4744005)(83380400001)(86362001)(66476007)(6506007)(4326008)(316002)(1076003)(6512007)(66556008)(5660300002)(26005)(478600001)(66946007)(41300700001)(186003)(36756003)(52116002)(6486002)(8936002)(8676002)(7406005)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QnBfnhV3lo+AZ6q83ZUvDNI/dOR90Qyt5wKWCerJG43hTWhvLZXch0KEyxM0?=
 =?us-ascii?Q?UQGkwLQtMAth5QJqLGpVpIzCnXqDBhxncf0T+ueEDXp3yEuudE1tDpTR78RR?=
 =?us-ascii?Q?J3mUeJzBba1z02PflfgbyqXLOBDpNw+IF3VkJpBPwCE6+EplUELGXlR815b8?=
 =?us-ascii?Q?S195kbt3t4Du9wyMq+pIKtAn4YOyEl0hWr3+ABVuacWWZRHUv3JYBq6RfXmI?=
 =?us-ascii?Q?cE4HHbaHFqjny89Ug+ojelDCvap2yAYsxm46oNcomBFaSJFzwArQjJs6BXzv?=
 =?us-ascii?Q?ushuvUwe95aCRXWJk3YyY8t7z9ztFXHvskLszCOhlzSDVCORyKw1pYEs4313?=
 =?us-ascii?Q?5OZSvTkVWxN05x0r1wVrDeSNJIj3q6rM7BOktWPWw7kZq9vQthck462vIxNY?=
 =?us-ascii?Q?8T3Z1rDO0I99ZZj44UeMGQkttnnl0Xs5+w9TCOY62wwBE0a1iqDmgvqCkl/B?=
 =?us-ascii?Q?dTOfuie0qCQP7krGJBvUpiFMq3pdPpz1cesPpT+VbaeScIAiqEo7M0/UXTKJ?=
 =?us-ascii?Q?WYC99pWxvyDgQsWvCLgi4wwAYekXVGxYRlYNzobiB4dFhHHseInTIiXOG64S?=
 =?us-ascii?Q?MTLSrfETiM8vjIoSvcAdSFq8ub3oYn2fuuve8HU2HLOOHEinCQHlWVLVTc8F?=
 =?us-ascii?Q?F39PAvXbzc4qHKGl0b0sysyodkRtHurVCvE2roxMm0wEnsohwu0Qq0n30PaY?=
 =?us-ascii?Q?3U2rF2RjN1cjXJRSKSYzZeNtQaAwUB9M013Zv21l7vc1bGBShDBxUoQilP+H?=
 =?us-ascii?Q?orx3mLinGORAS6Q7VhQpN4405g1ytbRiM2yk1yv2CCD5s19HwKLw8rM5fhiW?=
 =?us-ascii?Q?vS1fPsVKx5LWZQDyfIzwQE5MIxawyJ5fKV4DJbEseG0/44q80JEnXrv3S/jk?=
 =?us-ascii?Q?sLDzyVqsQyf3Nwe0+EIBlma6dQRm2N3iT/Ok2qMC20jrDV5x3VKdFtS1kLUE?=
 =?us-ascii?Q?SrngEMFhaQLe0cUEuTQM4H6u+c8HViXaHZTW/e15tLWTs7jyCPRy8X7RioCA?=
 =?us-ascii?Q?4u+FR6iHq4zp56XsKbUelzOtylOc0bhFvPnc5EgSQh0ZPiLF7QxeofWtjviy?=
 =?us-ascii?Q?aHOPxPtNeOcja5OwLZIFAeu2y82uVqvP06mCx1bFxbpFNBn1UDBRTbwchCuO?=
 =?us-ascii?Q?6z5VJ8RYpcKSxN8JiLMfUkfJ3oePIQbH+JgSzd4ze8cqzT5quLp/yoHlDtur?=
 =?us-ascii?Q?iZzhK+7dAPrzAlrM0VOYKtf9irSyxgYxtWR4nGhDgWB8v8r3Wmx5QCOg+IcZ?=
 =?us-ascii?Q?qOw5DXLtZDYEHXMhcXVd1jooCd0CTq6O+YTCfizjDcUmjoA5dy5nt4ogScPN?=
 =?us-ascii?Q?yaGf7dUhYZtT8ZZBRJ4BktG8hGK8o9rQhfz3LxtoJMHTaNjiWsPqHqigf2xL?=
 =?us-ascii?Q?ASjrSHP+PYzIB2NqKJMqbNKMhBIzb3hw08F4C5xBWHkX5BEaNSFZ9PKIh/9E?=
 =?us-ascii?Q?C3tDtiXukZdIQKT8DxGJZBJxIE24brJYx9IdVSxcEtoLHj/q58zMfHBmAVTt?=
 =?us-ascii?Q?vgN9uLzukz1isY+0zNYp7gYI4AbnTmWwaCuDY2jnlwoV6Eg/PDI3qOemdfDS?=
 =?us-ascii?Q?tASh3ljeEKjDDvXMtknf8NTr9kIK5BxNyZpnQnky?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f0acac-b30c-4d77-574e-08db76dec509
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:18:56.5361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJUAX0qsj7zpoDA+zFnKXX0cHUpwf6Hlz+o9kx/ZTXGxNA/2KVvil0N1Z5UWMO4C6x9jYFHKx/Sw5/z9Jybelw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4205
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
 drivers/thermal/imx_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index a94ec0a0c9dd..9be252bea1f0 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -749,10 +749,8 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
 			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
 			0, "imx_thermal", data);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
+	if (ret < 0)
 		goto thermal_zone_unregister;
-	}
 
 	pm_runtime_put(data->dev);
 
-- 
2.39.0

