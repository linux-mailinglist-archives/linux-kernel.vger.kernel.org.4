Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE70673F559
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjF0HUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjF0HTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:19:47 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2112.outbound.protection.outlook.com [40.107.117.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A63A2965;
        Tue, 27 Jun 2023 00:19:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfTjkMtVeHx2ZtR8wHfxWxznE2vlQMKWe+8A7q1pDdZD55py1PChvRXl2M/T99lNUiDM2GhDaVnEzMcWHDW/jyOomKVzTJkjPV+d+4s7/Agn9/R1/AaiDi6E8xDMDS/Nb1e+dCLItvY+z6/gjXY0fvy+jfX8aK3buz23Cz2YN05nSf28tgW5uaEib5jgV2604UfQIaRQkITjioWq50x8cXpGs7IL4MetIOLNbUXFW5OlUBZmqezM22IR6YiGdPa1SfTxp5kXPM0m5KUO62Fdk0fAClYLE3Srf2CeKVQtPfljhdFRyTpPQweAn0a6y4A0kdiDQIorSg/Qt8ADt6StNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbn2r7sMqCMJAkMmElNywTdslyzlUzkXyMWbWMHEQOs=;
 b=VOOc6uFO0MpbqnTBXPkp+JCn730Dh8Re3yie0TBI8SQWNMMSQgS6WWUusPFb3oFe3psGlaMlxxLaSEbgurFFuJXSC47L0CIMjyI7vRWh0Bo7jKazSCfOj+YpwOFJVfoKA5fox0cpDT5NuWbJcXoVBkb/D2Nt0EbO6Eog89EI9XVW0OFbK7KI8hn05t6YEUZZD6oR+Z3FrPZJFDImbsT0jgo85HMvbgSElgk52z2Vkdw2qOrxyz97+wzI8XAJeoKruCtjJT652gXXzjuAsLweEYjH2GBto6cuF2DvrNbdd5lbbTIb6H93rP/p4ZrdtiTcbLd9h/4ioYrx7dELLi7iwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbn2r7sMqCMJAkMmElNywTdslyzlUzkXyMWbWMHEQOs=;
 b=OlP5x+yWVU3dUJ/a/DEeEvXBP6fAm8h8pMWP6R3Xt2wgdOqwKyC1VxzLUePXjXf2msGowF5tDBx/qc+czvf689gBHiZXGjANoyLX+XwxlxkkmlqtrviAAztrmiseJ3t0oq5gBL5lGcQm5LfgPNgExC+gtz3aSg99vXhTiLQ+SMQRcsORnEi7POWft3WMOsMlkJsGoabn6BQ+wpWDrOp2m3voEc22xqWWAFrR4SSLo1O9SG1iYCWztNiyjKWM8bVh2sYUOn+0as0hLgvX5iWfVtLOzXFWaohUHAyczb9Y7zVb3IL4/cLlVbWDWZIAhL8lG7lXrpiY+LTzZXFEdsJUZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4289.apcprd06.prod.outlook.com (2603:1096:820:78::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 07:19:18 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 07:19:18 +0000
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
Subject: [PATCH 09/15] thermal/drivers/maxim: remove redundant msg
Date:   Tue, 27 Jun 2023 15:17:00 +0800
Message-Id: <20230627071707.77659-9-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4146e1a6-c370-418c-5cd7-08db76ded1d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u80hgdvTW6H+yKOUHiI3ySyuuhr0C2yM6jUsUSq/hGlKBIE8XMz47WwH3o8NcVWD8KPRfg5fS65qEXUADDVtoMq9jHvFYzVXmvKnJVhgnW0SEhrLPAT/qz9BL93h5h+xWcsORU5AFG+QpSRFgZdswO2LYVfebGCuxSa+0EKRQfOjS58c21GVy890FHy/lS2LyHdQSL/xA2c7EeXCbZsUD6V/uZ9UWYCUxW9nvwBkJq3qfrqtbNZm96nHyuO7mrPkUgf9tJO0Fwsmy6zaFfuSjlxPoeqKba3S0NXrJ/lRMgJmyWCfnz25GieQpeKNV//edVrvfOjf3922cJlF6TSvmGunhIoDRAx9fNOfpU4Qgg7QlH05MAJcv8nMNegQhBfC0iKT9nHweCx3iw1Cx1CLRA5RfC0xyDJaOhiOghIumgQ5TFie9kfBjX6dPTOcUeua7zWuB5nluizKKBJAAUm65AxYRZzKKGwjGBuAUqRYCKyp/i0dqOtNonjC11+fnaYz6uwuNVwShdxj2XhULvMAWpXJUAwsVvy47uFfpn+Kz9yfq3ZmdtAbyCWJdRwKZU0iUbUVVIXu5Z7onkCU7s2S+Vj9xv+Sdlfb7xZG4ks/xyCGVpjrV5FeNxOwgLyScXeDftwlQmpEKDy9kzA+FFD1LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199021)(6506007)(36756003)(6486002)(478600001)(52116002)(2616005)(6666004)(83380400001)(2906002)(1076003)(26005)(6512007)(186003)(5660300002)(316002)(86362001)(7416002)(7406005)(921005)(66476007)(38100700002)(38350700002)(66946007)(41300700001)(8936002)(4326008)(8676002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TnC1lvOaZLdEGOqMkYtS5TBInP4pv0viWK2OcK7V+C/qopnVGnU8loitY2fj?=
 =?us-ascii?Q?wfI+wSQ+v8orutz60bNEgl9CtIONBc5zZOlkPj3UrffwGWip0b4yFvlTfTg+?=
 =?us-ascii?Q?sxYv4wAVEa+MlZLIsYKszasQGhq4xnepdJRdX4ChgfOrf2T4DmJS++FUXiFS?=
 =?us-ascii?Q?Jkkos72Xcoxm5Rbg1YpcAgyMAdhXfxf3OHURVd4rXB/cyhee/qKhUYvRHavl?=
 =?us-ascii?Q?hc2b5TfDlUAn8sCmEd6Rj1KnZZHwVarrXgW4NNTVxrKnz1Pwyj7GZ20HSFos?=
 =?us-ascii?Q?/mylZywBxH616cNp1700lXQJRiwxdzcbTEPjeNn2+dFJn+BFb2GsQChXZrQb?=
 =?us-ascii?Q?p0jXmF5mwT37LWTjV4SGi8NH0RK9FygET/WuTsVmZ4mkC+0hsF5kNUtSwxMs?=
 =?us-ascii?Q?v834t765r0U3rS8tAhQGP1ly0iP/GJq3rj2CglMwW2VJAR2ryuPIt364G450?=
 =?us-ascii?Q?3uz8HSR+l3OVh495JXaBHLz5rSiUWYPQHI5V9IflqpNOKu7B+OZRElZsrrWy?=
 =?us-ascii?Q?cgnb5GMcBCjlB8giU/rOVvLzLqw6KHxWv+E5TA6380Ay1B9FJIIWc9OdQ39V?=
 =?us-ascii?Q?pkA4CfrbU7hiGZs5Uho3RKju4hTze2QOnEJhd3UDyDuOTxt5O7HCKiOcKH+h?=
 =?us-ascii?Q?q/M5BERU7D23frB2APy78PRchme1kkM3Sur7SjI7WivAW3N2H7xPFYTL6R08?=
 =?us-ascii?Q?L9UejjEHLyW337wpg6POrTB04gsE+xQnnQScz9W3zf8blNIqifGhd421oVZS?=
 =?us-ascii?Q?3HnJLCY9d1c4Sew6NmTCvbxILwhYSkpekYk+IzcONJ4pZubceQeb+Twftdyz?=
 =?us-ascii?Q?LIZ+cNKf8J9GpAdrfmWzZDC1oZQiKgpgpGFnPxj+u2bloQXa40x5DwEgGJ/i?=
 =?us-ascii?Q?2dqnxN7Yh9eCzktONpu/EdTP/TsKjqN0F5C1FsqfjrI8F67RfvbECk8fVGO4?=
 =?us-ascii?Q?mTcUY95S089haMiDc2W/hwdc90Cln0U51T+9b2F5xiT616j/GhaZA+NR7onb?=
 =?us-ascii?Q?oJl1i1pzSxE2xXg7liqdEJYvdHxbRChoX6AhSrhfNcE8DYO8yHxru6MBEjzg?=
 =?us-ascii?Q?twSXDQvnJbR5rezTdUwhhuFW6OIc0eRzgQmr8lgdssBXRJVmjF8CLYLKQwjx?=
 =?us-ascii?Q?0QlfUEb2JSe43ZhAUc/JWgu0D+Frl0gHpnLpiPTRzYR/QJUya3nzdrC0IiY4?=
 =?us-ascii?Q?LoVMQlFWewpoULC5X/y8Z7fYIiUQI3osKW9SkQzVV6zXH5gRbkbn5WW1C701?=
 =?us-ascii?Q?8y3p/RGMsh4qKFp+5zxbwjSe8rNbyYXXyN9l3vYOpXsp1UDfmq4Xw13AOMY9?=
 =?us-ascii?Q?Mn2eFCOCv96I+j6r8zJD63AUGyMvbbY+bEak1EruLHKtPrETAeRjoYk0vWHT?=
 =?us-ascii?Q?8HL6/TUoDVObi36GcXAT6Nm4gmIHa1A9fDqECY0xsGmnM4jyHe1GfzW3lsvp?=
 =?us-ascii?Q?wm8T+lLRM5Wo4a82gtqQ/3MeNPejlUasr7/d11PKB2ifLjhW2JSvVZG8HVKj?=
 =?us-ascii?Q?Y3VCTtofrBqiXmooBhkA1dwW6wkVyscAo/q6xhx8AQcfGZdgHDLf/LWzzFDW?=
 =?us-ascii?Q?x48rwfz7s7Icua4Gm7F0dWjyEJdJk2V5E81YR0G/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4146e1a6-c370-418c-5cd7-08db76ded1d9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:19:18.0219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYbmIvPWtpCZjXd3JYCXudWGHz8JBORcoqPba7UOZ6Hkt+KRxcIHXj2ej0MiQc5QxwfCs+xOgjaO8DPycHerNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4289
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
 drivers/thermal/max77620_thermal.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index 61c7622d9945..73c251caa62d 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -125,19 +125,15 @@ static int max77620_thermal_probe(struct platform_device *pdev)
 					max77620_thermal_irq,
 					IRQF_ONESHOT | IRQF_SHARED,
 					dev_name(&pdev->dev), mtherm);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to request irq1: %d\n", ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, mtherm->irq_tjalarm2, NULL,
 					max77620_thermal_irq,
 					IRQF_ONESHOT | IRQF_SHARED,
 					dev_name(&pdev->dev), mtherm);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to request irq2: %d\n", ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	platform_set_drvdata(pdev, mtherm);
 
-- 
2.39.0

