Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAE1747C5C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 07:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjGEFYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 01:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjGEFYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 01:24:06 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2110.outbound.protection.outlook.com [40.107.117.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC8810E3;
        Tue,  4 Jul 2023 22:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVI3A56bdEOspNeGzZp6qGRRyuu+RBko+KZOAXypINtRyQY3OFx/a51X8HOg0hwE1uph1ctiGkyKPqppbxrYx2ajto1p1/LBC+R6RH9qi2IV46pZCYazDF+DmR3cPe8AF0w877X5NTFfIVhV6fCM2xlUnlTe0rclVW0TH7mpPiPR7ozEcQ7xqebvrr9haaKCNMoJw2dF4vm4xYm1pu1A1H6c93SS8twGHMhEHYFUL4JFdhSztAdt5zgd7gyzndMvVo8mugy52Pk/lq8WXjmqCz7svlZfHZbYfSJOAka+VXFe2jimpGqJdjtmXujfWwxev5zYpaPF+qhMd8nshMoZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqIvxRCY7UWU70MClQClduwmQVt92UZpYY6fX1yYh7w=;
 b=nO18jm001wGTlhnrA+juN6SHa/Ouu4zL3JIx9/E33j+DJk3i7tSZJy6aKRTy/uErOEOVRRgylRdK2Mr7rZNg/A/byJp9T/jKMpla1w8+W7XxE2KetamhmINLvP6owusjmq4+qPhaoyv7Lwwm9BflMb7ZAArbBj8mV+/bfyv/vkDIrJ6/xoERq2VUW1c5eWy4Oqy5KqYj7x5Y1e4uL+Wuo4UIRx6UJeDEQZ29Z0z4NVsVRQlsm1sytlvzvENN6kK+nRu70e2Drnq8fJVmAF4X5CFMtUgQr6tavIhMdGNuU+HoKL2kM0WpYfJPLY5p82SA4dHtVHDvPXKW2IvwVXi/Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqIvxRCY7UWU70MClQClduwmQVt92UZpYY6fX1yYh7w=;
 b=C0RVi1KQM6x47Fu3hTJoIPlfDDakNOO/E4PojGhKsF77vMe3vxao3QSMVKWuYIEWrFSCVoS3YWwQ3fHAXVX1BVFvNIjkcPGSSsukpMKTDQbzb3VLnyfLG5jyB/+/FfcN0ncdeI5a2bPbRt8GnF3EsIdv0nVpTLw+EmX+e/OvB9vfntdIn/oI3vd9dTybeanXjGUQNXgHar52ZqxSI//uxrbYaXd+z1lj0mleiBXDnjPYNJbrsxMrdfo58ckPp1k2NaWpEQB3Bqn/T/znxnBgmRKzWqnt0wsD6UdHk4oyJPO+94w0xPh+1YWOao3DCdcVqirc5EXQwud0/dI0UvIO2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5123.apcprd06.prod.outlook.com (2603:1096:400:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 05:24:03 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 05:24:03 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] Input: omap4-keyad - Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 13:23:40 +0800
Message-Id: <20230705052346.39337-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705052346.39337-1-frank.li@vivo.com>
References: <20230705052346.39337-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a302b17-c60d-4147-c926-08db7d180bc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wgNrhXh5gq5yw4BmENOEdsB2DER9my0YjC4gZE/yNFkrhhKgDGLt0IsIsdYIjn6QbNCJ4tf7l8IkhQFn5SSpPnqrwC3tLxluBj459xyfShZ1a+3tizhg7RuvlFwWt2MEOboZczQNZOGdEdfP6Og60T7hrM+2UjnAFXEPOdP+5j05Qp/en9BG/HnYrBzogjxn2zf/MzAuf0MBKpmJP6AtB1E7kypbhs583dNInuspwORAwxA+yy0bjApa93b+i+t1qm051uNMEhvJ/lLvAxbx/0bvVTueWRY9Gw9loVf1cLC+dChMDufgBpLsPIB57DarjxYqrJl5BcIhfM6T6V8TpPFKWE4WL7KaQ6yKkjNs8pfODu/VsdhmgnJLnCtYngTnyiuUzOut/XnyUzxfK59cDUWxKsfWsSXma48pk7UM3ZC/0IPDj6iyCSU7MJBmldD+f+7ksIjBbRD6iJyW/fpjf1LGEMkMx1rAxfcq+1q8Vu1H130xtuXxqfQ/hP5fJUm5kl28yc/G9l7my97uEjCjIF3AWIe06/EVEVTLvl8yDvUEpX9KyazJpVl5Z9UOgYyIdsy8beb4aZQjLcxRXCXskj0XL55gdn3WqUyrAg69UvPth0aNwTYRabZ/9ixqgCcb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39850400004)(396003)(366004)(136003)(376002)(451199021)(41300700001)(38100700002)(6486002)(38350700002)(6666004)(83380400001)(1076003)(6506007)(2616005)(52116002)(186003)(26005)(6512007)(86362001)(478600001)(66476007)(316002)(2906002)(66556008)(4326008)(6916009)(66946007)(8936002)(8676002)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r7ubGH41LHe+Q8dsDJslC4vhTjvDGtYu7mWGx1B71HyDUdUyqi8N9pZDuvh8?=
 =?us-ascii?Q?5KsgWEnWniYTZ55Paz4kcEsxdtxVzL6B/tjhzABPDXhwNqbQPyvSBw6H7skI?=
 =?us-ascii?Q?V4E61PwwrBlOiv8kQiNvJviO6ppDodjfJdELLdAkK5UauCzhnXcknL9duy0v?=
 =?us-ascii?Q?1RaUIK2w8FHQxhFAP+EZ6jFp/KT7xqNqSP7zbYjB3Blgk/tekkhR5Wi7aLVq?=
 =?us-ascii?Q?qIpb/weUTuo3OqCnw2elDMhWn8nNnblM5IPlxxZDw2PemJIDFTLLfLU/VRO1?=
 =?us-ascii?Q?HyZS4beqpdmtcSvmhtzk4pYnXQ+lQ4/uXFO1GEIPioz+iTaOa/3xonFBxUgF?=
 =?us-ascii?Q?7I3D+P8cfRpRPFAXA6/xqsqvXgKzvSAC4aOFgdKpN/fhUrUhLHtCDpvr9Vi/?=
 =?us-ascii?Q?daKIQdhKizUUnGU5zTDSqq4wnRQzaQzkSpSC4YCSZgvR/3tAz9nBGRNcMCox?=
 =?us-ascii?Q?0pt4P8KrffTzyqEwpOOvblEiNEH2YWBtmVPj87LuLlfhTMa3P/zwWXCrSbVc?=
 =?us-ascii?Q?08KBOLa5IEZSEJFE0UbAlDi6OFAzt7cYH+V5JaFpoPvpHztPN5F2pPxky5Yw?=
 =?us-ascii?Q?jKK1yumstobFyxzrMIA3uqVvT68BTD62lOD7GO7QXqsonjKzbqvY8ERSPcT2?=
 =?us-ascii?Q?OkziQVFSyXBDNatE2H/9RYuAUMxFBd2FupLdkXO5Mn8CeQLoDuqYnUupYZuo?=
 =?us-ascii?Q?HnkLaFBiPR5Y1FpoANus3M/6+Doq08X4vk+8ZbHmRGX86oiFgCusb+3/ZgrC?=
 =?us-ascii?Q?3k8sj7p2LEDJhfVNDpu+vt9YSyPVNT8qC3ow/wYpPbM4nbX1gewKBHbUdnQ3?=
 =?us-ascii?Q?pZgke5clEwZZ1qbUk445XgOQAQeGF1DudzXDuoA8YhVvVqCowu+vxRCGdXiA?=
 =?us-ascii?Q?0EgFdxZ6BQOb2dAcLvpSmMG5qGksHPdqTBemynbURMGrt/ShuJofFFlMqCJU?=
 =?us-ascii?Q?erVIp/qvc0nLIFPpEap1tcO3Y9lDki3JhzxvpcSoI63NqogPju1ppkHV0mQq?=
 =?us-ascii?Q?l0lmNg5voykG9zEK23m16VxFqmBwYFkENW8eNluCc16TksokypvllH5Fsn8e?=
 =?us-ascii?Q?qqm1178qNPmwlWNsfQifrGkBJjUYBRd5aJ4TpooV0zWk16jqkEKIzCF+tOZ0?=
 =?us-ascii?Q?8aYQ9oEVq0p+mSt9RVk1tRJTBuWhsK8ZfDoSePLFkVJrzEIrmR1nrx/gOAKf?=
 =?us-ascii?Q?9umugmi5DZkr/7ilG35IN5vygnmMcijVoa/i7BpBWB2UceXFYjOVkYl3Yi7K?=
 =?us-ascii?Q?sqIgSetQW/albXWyuoZcRPV+9Sh29qy2H1kRVNlWc5CrUhbyOucbsvZEAYfy?=
 =?us-ascii?Q?kd9AWgwbEAl+A2Ti6oZgb/9prOqG16Izh4bhHR4BxmvrxUzh8rvveNBRVatv?=
 =?us-ascii?Q?GjnunIPPCVa88gAapDhJfeaK0Qt2XEGnp5rNFn3eb/FrdYo2WwHEIGMYs9dz?=
 =?us-ascii?Q?+oeayy2FfOu+6UavmSBba1ki9XGE+/CqeQ2Qhf9dlUG56pij1HPmdRefp4Gp?=
 =?us-ascii?Q?Isv9IpAPTbhMIAMQf9qyrog0tSMao/OU9xDyxvPpNAZHogn8b8Q8g7szzFBR?=
 =?us-ascii?Q?6q4Cl+xKtYjBsejQa4XRh8sfTU6rx9VdOZRzS/kQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a302b17-c60d-4147-c926-08db7d180bc4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 05:24:03.5431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHrkNbAsIx8iDeEwmzxgoJA5FyGM1mkm8H0yAgg6jKZfW0R6vCn2LgkzQduUTyf12yvDy9K8p8McfiyAhZ5ujQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5123
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/input/keyboard/omap4-keypad.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index 9f085d5679db..773e55eed88b 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -341,17 +341,10 @@ static int omap4_keypad_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct omap4_keypad *keypad_data;
 	struct input_dev *input_dev;
-	struct resource *res;
 	unsigned int max_keys;
 	int irq;
 	int error;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "no base address specified\n");
-		return -EINVAL;
-	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
@@ -370,7 +363,7 @@ static int omap4_keypad_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	keypad_data->base = devm_ioremap_resource(dev, res);
+	keypad_data->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(keypad_data->base))
 		return PTR_ERR(keypad_data->base);
 
-- 
2.39.0

