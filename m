Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA11E73F549
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjF0HTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjF0HTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:19:09 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2128.outbound.protection.outlook.com [40.107.117.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA951FD6;
        Tue, 27 Jun 2023 00:18:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMCJ+caHpxfWTfm+5/pr9q6IDVhYyeKDGQzct+CPj0ZlJQpacMRaR4HlHX9NCFp9MDn3fErvlspC8RgpFYuaNOY3CBesrvgXywVC74mDgZ1wuOKQ92ERJmOI7a0q+flFBcrMFhDdqlO+GRmrFIqn3qgrG+E4pJe9OrmyNzQW9RKnLCGXAkDai6j3tS2UZ7iMEyOw5zERXNHDI6VCbSX/3E8LrN+09B5T/uK/TQbh4OlCBlQH/UDpVTKwmXmUlpF9loe7ESVVCQOQQwfPiJSvIP3FueWBvZjse+n5H+ZMLwnBNvStIM6lL5UPtnvCdtIp1B3I5hohSZfqspx9D6nyNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgjEmSp+ieGa0pEFqdSlTF5vo5i8gyOKAdnyG+rtLsQ=;
 b=n6wFoAWwUmAdUJSCD3Wmwzb+C5EGIV/WRplDGyUxArL6ICfoBVXB9vWiDe0ZbYWPehXMFxXuq5qlEGCmaRscJrLV+ksZrIGtY5ZH1x+geh+6hZYwqaJOoqhE5jv+bNBppzGOYMgHJ5U5DqGcKS+wd5NlYD4h818aaUF2FvkXxbEhLEtSm5WIMKqbCmG8UfooWkFn/uL8dUyaDtWYadbSn125+1XPwsHJmhs0N9V08xgFiZZ8HaCtPVzfW6mT76GBgjjlBKUiCBSfi+xSdUR1RsMgTQ8vaghj0QujQy1rrQkcRCMfnC3Mvta/Az7ann7VlfqJa4lXUnuVP/A6BKOMgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgjEmSp+ieGa0pEFqdSlTF5vo5i8gyOKAdnyG+rtLsQ=;
 b=QpAiXRY0xievsedZMBpYFHPCZVS0yxKLojfGo+xxsQjpbxp4mmDpYrxEeQqnIdam3HMIujZS/jkwwr14Dn3pFVlkd8X7gjU8vEmuX8oEkV45/3MKi6EdMoZnlSvw6j+F5p1YF/7akzaB/ron8GIn0tlSvjB6oYPTReKTYNRGYWjuIekOhKpJjGLQt5pgsWrYIZnIajJDfOXS0mxuuy8Tr23tFpDu1++psbchWjBhTIg/vh0UAlM4Y7g3DBqs3mRJ5/is5sX5jWoKxiFRxTILkw0UilRm5yymij7jjflK1nvxyNmcQjDOwGXQfMX4SYRqE62beSulQnUQ+GIu7lwBrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4205.apcprd06.prod.outlook.com (2603:1096:400:2e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 07:18:49 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 07:18:49 +0000
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
Subject: [PATCH 05/15] thermal/drivers/hisi: remove redundant msg
Date:   Tue, 27 Jun 2023 15:16:56 +0800
Message-Id: <20230627071707.77659-5-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 75ca1366-4b6e-49c0-7303-08db76dec09f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nppBnbEXR//jVNftlJntJgDik3eh+F+FoDdRJ4XTqONgub5ltMO94N7uNOUE1SHs543IfIBM8rZXv5OVUffM+jA/9+6dxg4DEdRc6IRmipPxJN2mxVdJ4FDpvS7DI0EU1i0YuDrZLVgT6X5tRbOlVojCqpXWkZqIeVqB0l8JjeEILnv+guFwZLFCyq0dDkYZnOsc4N4wLVbKWd60T5HEZ0OEEoHL78UOCNWo+ARut4DFmY2M3NbOnQhGuh6P2+bmm+sngdq/v5HK8+rfFUHW+jQRv1vn4U3eHe1It7TLcbxWpQsSKo6CEVioCV98sxmHogSA780jtgltMLc5+/wWdgIokqNGbwiS3QrVsrMj1UKKtBHZFKQVInCDk/am15+uh1ac6jYuHzDO5R6dmXEhpodxOyqrxgDckGOPsOtFpQcp+8mX1RK/smpgMPr+ZhwLZ21C6+kxvZTsGPVddw+jiV1ZwcjsHGOqmXGdkmjcipnH+0jOPaHMxXOsKd/zHt6EgDAyoIPYTycwgjtdhIUtfrH4/xsls4QZX2R/ENN9FrcvPrlYaHKjrYWsCXSC8actHznXVYNhQc8T/iXhrZvAh00Qv/tSr6m4HQ8MWiZaVYoZDw6fiWyT+AZ7aor17V23Emi0dRZJQHetfSxGFc3dNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(39850400004)(376002)(451199021)(2906002)(2616005)(38350700002)(38100700002)(921005)(4744005)(83380400001)(86362001)(66476007)(6506007)(4326008)(316002)(1076003)(6512007)(66556008)(5660300002)(26005)(478600001)(66946007)(41300700001)(186003)(36756003)(52116002)(6486002)(6666004)(8936002)(8676002)(7406005)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i1A/iIkbJke/RDU1I1EtB6pxtwH287a8moZrZ9u68UEaKkcviRXJGyzowsQ4?=
 =?us-ascii?Q?zvgn4iQXdrB4rXk1aenxMgbNlAmvnhzxxzUdCOwyVntj72atTQX94IZ/+zb9?=
 =?us-ascii?Q?tQ7QGsBb6uk7DVboWe3gc4q9EiI/ATLHyoH/g0kb4vKFJ55X3X32Qt6A5JDt?=
 =?us-ascii?Q?V/P2KWcFXzSUg6gEIMRY17P7vHV5aR3Xcn4xufKsEPqgRBm4G29AClNYJdC1?=
 =?us-ascii?Q?Yu0RMVkrs3kTwWBDgzrlxMYGYkGu6VKcZRphdXuPLztLn2z43kDFsMPYpYN5?=
 =?us-ascii?Q?BPQ1SGmcj3E1sOM3Hj7a8gt/P3Ntjv/PVu3P6mn4VvGEpm456N5R6nLXbKwJ?=
 =?us-ascii?Q?HBSmBZxblOnxrgwVgAlV60Uzcdo0/KkLXSGIdmT8X4dQlkfAQkcN7yHyVfAC?=
 =?us-ascii?Q?WhbIPwT5rhR4P0qwAoVs2uFCsa1hUFxt93VAuLVxbo88wogfynl4iCNGgeJ6?=
 =?us-ascii?Q?UsygSUETKtdq3qlFdlDFX6kJPWp25hxTowcQ0AkOZCJTTbEDz3fF/iDyjZua?=
 =?us-ascii?Q?tabZst1ARxPqjEutRHrk1dWFvTnsnJTMJp9TZHt6uvNwl6Y4+z87AAhYhc4H?=
 =?us-ascii?Q?VWfr5oqtavoxJbfPMAzWtrKqrUDG3lz3ozalMMKUr72RWbHfDPCDW+hWvk0k?=
 =?us-ascii?Q?vxSruwzksAEpW5jlIFw13yZP4QlkKp6hNAYKHdW60EMJbbNzVGYRBmNMiWlE?=
 =?us-ascii?Q?pjzsaj26cyP8Qw5nETmh78GkEajUZ6L5o7Ak7TYw+Ssn/P8rh2Vnj2xCi8r3?=
 =?us-ascii?Q?AH46mueKsic5PQmdW1cAuEymNHq7AwZyP9rquTkH/VwDz9xp+9LNATfRa3sP?=
 =?us-ascii?Q?wlvY0aVvE4wDhG5M+xSl/2i0F0l+cSygww0n4fTGZ7ah6y2c9vXc2rpr2PCF?=
 =?us-ascii?Q?doV6j7bqT4q72oRnLe1qe1mkBg2jMuGfBEA3nRWdeXdOoHb6xI3unB8gSIvY?=
 =?us-ascii?Q?EJ0cRs+91HbmP1MNBoFmkra2AN1MG6hM7qNRqDePFf1ZUGMRWSvrla1GXgNx?=
 =?us-ascii?Q?obr5IcCklesuBs0z4QFDBwWCFrbTZvxuPF5m2kSGIQi6uKU1WnCFbaAshMm6?=
 =?us-ascii?Q?yy8YA48q3SclvZ5GS3pe4lTH57l/ECTNp8/RTo0recCSUkdsrC76cZ8PAcwH?=
 =?us-ascii?Q?saJP+fBSSssymBhl6gNeQSBFGuFIQkIC9lEd4pu2KLR5zzvHpv/UxJINZr7A?=
 =?us-ascii?Q?UQblQ0qRN+NJ0cDUBvnCw2rHGnGytbX4Z/gRx/iGlRsOX+XUHUf0V9qGC8bt?=
 =?us-ascii?Q?2dNl5pi8j9z/Vx3CFoLS0quEcoo13c9c48ufhh/Yc/zHSz4UqKH/GnwPaZlm?=
 =?us-ascii?Q?zpLgGqBeVpb3Xvxu/4QQEZfpAdoXPJOmiZAi2xyqIVlmcLTniQKB4yHWuhLz?=
 =?us-ascii?Q?90S7OH4wpGlF92NgYQKmXvrxBKdeCypT34gPNN5oLhB/mdK/vUS8FLmVZffx?=
 =?us-ascii?Q?WQhnACcT/mLCiauLb5M0ru1Vc22x0t9UKaP6PtayHnC7PtxQbY41ZHFWdhCZ?=
 =?us-ascii?Q?UBV1xyz8TvtsCL1dsf9ozNohHGJsrnOcTSMuzhyuDMjgqxLF9lBOOMM9ZblD?=
 =?us-ascii?Q?59W5v4bFqvj/OzBFoJ556URGkrCfCOGUIGGC8Hed?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ca1366-4b6e-49c0-7303-08db76dec09f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:18:49.1392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45HxQybYtLOetkzEyVGUCOY5R8r2gHo8eVmivkD5GLJKhXgpFzNqi3wfmUJtfafrXd2Nlxemf7Bt8GoL7PJo3Q==
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
 drivers/thermal/hisi_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 3f09ef8be41a..5f20f07a7566 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -580,10 +580,8 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 						hisi_thermal_alarm_irq_thread,
 						IRQF_ONESHOT, sensor->irq_name,
 						sensor);
-		if (ret < 0) {
-			dev_err(dev, "Failed to request alarm irq: %d\n", ret);
+		if (ret < 0)
 			return ret;
-		}
 
 		ret = data->ops->enable_sensor(sensor);
 		if (ret) {
-- 
2.39.0

