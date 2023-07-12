Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93B374FF31
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjGLG3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjGLG3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:29:20 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2092.outbound.protection.outlook.com [40.107.255.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7720010E3;
        Tue, 11 Jul 2023 23:29:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dn0qNUfXE/SYITNq2utKB7eqGpNpnXwjprNPHX0m9r1814EbCSMuzi4XdSbZqtUfqU5mU6GdghOrBf/FNbjxVLX7/czkVX5SzbAHuCeaw4ACXFufRGBVAa1s7Zg3oaUmSWTXXHgJvyhQrJJRK/VByH4HX99Vw5CuZlZEBbHlHJNHSZTVmkbHr44Fmxe/8P+Qm32YaFPlP3OqY6lFRyibT6FTNtguFklHvyG75qaHISQDuS1+QzrQaSCZq949NW+Jglhns5FWIVgNr5uVTEubf3psAHTcB/GCQkowkKSOHTj2TlMjoajllmVWOmCAW6CBdBOgd2btdctw6SXEgU4+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZozWrzBbgRSJsVIQmRLHJ99OtcdKbjF1rw6LaMWhE1g=;
 b=P7tl1m1j1cZkRbYRYJpKB1udMx5TPbHDat78Dn8yasQD1RVr2b6Ap9qx3xfYv7QtYqH6L3G60xWEIl0x22YBa5Ivcq1BfulZJnQws0SZyOPKehD2Mn4IQt9Zxbo4AlISK+9cq6Awhp814YPB7EUKmT3keTERvo7v0zj2Q0xR+zv01ZOhYXN0FTO+c1qYeBIwmGLmzSwVbN6X3ixBrH6LIMXoP/9TqDcMEVv07To+sLWq7Yzo+LLnDJzHVP8FVQjg9n5ZcuYFw4v0nhcDvIqPKEiIxjMM/3jozQ9bzNhu8mMK8lcl62V7UN4paxxQqNMktBd5H8+P47lMLvark5mSdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZozWrzBbgRSJsVIQmRLHJ99OtcdKbjF1rw6LaMWhE1g=;
 b=aASmB2guNguYzAr1G25S6KMvJ0R4LWqHOSaNDppTweUInP+9Qvb9ThkGww2UE/bkosLWE6cHRL+hm2WDBBuesVxIjjoxl8q0fuphgNERf5M1Eedh73GX5JZ0i9a+gkcHxCrlg0Lwmb7gB6F9p1KzOBn9VTzRMQ9ObXgT5Z3YSz3UIs91fLckzVXOkzYY6bYx1EWI4Pe19CPuKDBzwEjJVfjRfHOefDf5pvOqo4xj3wfjlyNqLNzD0C6MxgFvmkOJLZK6eDU8D4PlQEUcXDDlqtMedn/yazuakgpDi0nYMPiqPUFF44oRSD53c5pv7N/WbabIKhbIgeLkDmsEgXHMMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6672.apcprd06.prod.outlook.com (2603:1096:820:101::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 06:29:12 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 06:29:12 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] serial: clps711x: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 12 Jul 2023 14:28:41 +0800
Message-Id: <20230712062853.11007-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230712062853.11007-1-frank.li@vivo.com>
References: <20230712062853.11007-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: a6f9464e-ce2a-4912-5c69-08db82a14e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PvyPcWboGi2OO+L0yiSN69RK41BWbey+Z5wYrviL5d88QCvMSeqvBf0Q06aZ5vIHScdDLrp/nzZl5hpXYh5cGwRJXLp8TQZ/U2u2/GTCslvMQPe943A8FSyT1FrGaxXSc5jzEuBdfTCH03ES5Du3cWH87aNNXSKs99sSg/YDme7f0PyZhA/+SHLe8mUQvTHAog4Alqh/unR2f4jti0IQ9oaTXKTl94dfTAcYB00u9Nr9Rtxx3AmHhc1TBZ4PU88tLGPgvgqZZS/HmCtOh4yP7nZHo8Yyli0tvPG+SiB06f7lVNAKnpEZB3+pj5mmJH+UAW6D1hZU3LCRJyz0buILDJYJ4v69QQXLycQ+EIsItdn2JkoBQdh9VSMizGX+8sxfLA3Lvb+g/9y64XSCeVW8TA1uCj9nji/3BlocqQx6+To+21qAIfRku1loZjovwzw0sHkrmdjRCcPzKU9ppu73jzw0tqEq9Le9NfITx0WUGSYDE01Op3bJccVcwHxkzNPWpDO69+iAPZViItfqMA4wpEwgIJTCqKtF7Pn27AVRswI0vMBwN8VAELGHkxD5AIPm0WImGwzPv9LcAP1+NXDJcXHgkCflh15U29YHdHvrZ0h1M53LI1hCMlIqR1pIkmDW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199021)(86362001)(38350700002)(38100700002)(4326008)(316002)(110136005)(478600001)(41300700001)(66556008)(66476007)(66946007)(5660300002)(6506007)(8936002)(8676002)(4744005)(2906002)(6486002)(6512007)(6666004)(52116002)(26005)(186003)(1076003)(83380400001)(36756003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?urd+XoaSM/9lJtZVvlXB89nKsK8eEDrOt6fckXn8Mvi9l1oN+ShEspWRXGr3?=
 =?us-ascii?Q?hL7yHMeKUFpsus/o3QnpMMbWeihBG8ekBRss7G36MAgZKbXDfshJJwOrBaLA?=
 =?us-ascii?Q?1cGAP+NJg9JvMF9aQzGUIGdJbe8ypokhAkLl+FUbJQb1qNgvWkaawMKWVJvI?=
 =?us-ascii?Q?Pv7awSXMGv2s85oUud38k6COjJBmifwNnAJsRXVpbtQYOvWHgrdVRrCkSigt?=
 =?us-ascii?Q?0eqZH2EHfO2e0v0AHgYHAz+MW+G5rVziw6UwQoIxl6aarHdyim30OMxJ6JSw?=
 =?us-ascii?Q?ugBeYFsKZq+g8zNzEGlPWhNsqw28mvTMWI5U8OEML50rrXpJ7QVUrIYIQ/9b?=
 =?us-ascii?Q?T6gxxcp9/mNHO40kG/dVczq25Wr3d5BKG8BXf+UGxWEt9ETkLigBpV+G/STQ?=
 =?us-ascii?Q?prXSjGDqitiM33Toz7Mfn1nUp9qYPOrXcMdTUY7utzbxilYvbSmISW1iLe2H?=
 =?us-ascii?Q?P5fr+AVEXjMMtLuYmySojDiWQ1B3Kx5xoEoHACfFldJzQvGqeU0nVBAcqi/K?=
 =?us-ascii?Q?L5Zr2h36ugbBjUA0Q5EMcHHykeelAbtUuJsDseQO1WFlrzooUDyBoyWh+GbW?=
 =?us-ascii?Q?c+w2R7IVKN5/xkjaHBr2go+gJAhpodv1PFUzPjuEsIA3QATUsFW+iaUyUMz0?=
 =?us-ascii?Q?VVFYMXzu4K4CmA4evpvI9EYfKgCALVhPeNmxCGJVM9+zfjoNzhTunEjVhk/l?=
 =?us-ascii?Q?+lhFS1eYRZYBIn3vwq5LVHto7zMGrLAEoWe5QdVGpHTBnsGTu8ruCqJv2fXt?=
 =?us-ascii?Q?QAP5mHFEJj2VxUCHoInP3rBgzH/aMy8bbE6t4Rxo82lMFxZmDBDVgBLaUdIc?=
 =?us-ascii?Q?b0NNjT3e7751fYTt9jCTJ/RBdNFVhs2U0fDT+dEqH6r68G6yW9AtftcM8mS+?=
 =?us-ascii?Q?ntSukJYmndK8tI0GevEpibW8OPFTOxQjtSVLGTQJ6/2NaLppZBPWa3o1lX1u?=
 =?us-ascii?Q?HxDITWUCo3Q+15Inw3KxDzzAUXGYDbfmm6mk1F2Gs3MWFOYiyI3luWLsXkmX?=
 =?us-ascii?Q?nVnysDCLOt+g2cLZSA+wCdM+PhbUKyNKHJYkXp0dVTP4iz0NRL2dHEGif7cc?=
 =?us-ascii?Q?YDDpToJ9+j+ol68XQwttkmpJ1mVrubmtiSb02AkhhTvHbrOEwH77EuMzBbjC?=
 =?us-ascii?Q?BZrYJ46bC9KLwSoTxvBxtM5c6P5mnw2+HJTWz4+HkTel88xpGo9pKbKlsK28?=
 =?us-ascii?Q?2o+gNoaZ/pf5/wDaPziOOtFKcAA5oGEScJelmrSO0y3Esrndlv05auaWpLSy?=
 =?us-ascii?Q?gz80MGFK6e7Nopw0sKKVI2FvIPZ7SLfu370fjLBQFySrmP4MRKb/C3PX5SUd?=
 =?us-ascii?Q?+9pjtIazP4Pjh4WM9+IdaOjC3YAXy4r79gDqZo7RAv/77uS+FyThgHmG3mrk?=
 =?us-ascii?Q?4AhZI/Q7z/+UfyOLK+hL2dCj7cAFTtv12S/FQDW/ZomD4xJl1z7NCfCDXJuW?=
 =?us-ascii?Q?OEppxrSABonZ4lhMikt3unTOVA2V5ppdLchXob8CZpLLVvHMZ7CYaNAzktLK?=
 =?us-ascii?Q?Rlm9LglgXGeLxwmRpAHJWLWTWHsA/OVgrsficlywjfgWN4mAj+jBvIA8odeq?=
 =?us-ascii?Q?VaEoB/r1PD60Bu0dPMf9pUkaSPJkY0HudgTQNrsp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f9464e-ce2a-4912-5c69-08db82a14e79
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 06:29:12.2215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3svgnqUbTzQTTaMgPelnipOPsuK+iJvOe2sTvviFjrDfWAhdi3nDlGVbxuE+lfOgA1wjnHXxSqW2+ocGBjAKjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6672
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/tty/serial/clps711x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index e49bc4019b50..0deb1d7b53e3 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -450,8 +450,7 @@ static int uart_clps711x_probe(struct platform_device *pdev)
 	if (IS_ERR(uart_clk))
 		return PTR_ERR(uart_clk);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	s->port.membase = devm_ioremap_resource(&pdev->dev, res);
+	s->port.membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(s->port.membase))
 		return PTR_ERR(s->port.membase);
 
-- 
2.39.0

