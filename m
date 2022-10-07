Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C818F5F7A98
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiJGPdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJGPdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:33:51 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10058.outbound.protection.outlook.com [40.107.1.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302551162FA;
        Fri,  7 Oct 2022 08:33:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjNw9t55hksRB21NoAmcc1gKoBX/VCEwTNbR0IAE51i0stlYoSRkS8Kt/m0LMeiQP6ykakRvCQKQ18tnjQtobYC15w+a9OrKfnAJL2i1dyh1oRVykgDc1ix8hvkUt7xYq0nCyP7Eze2bEKH2Zpq+9uSwJl5k5HrpXIpPDXI7xLU1n+quNh7pZGfFW+vMN/GDXJ2IHhtxEMiUvfA3lz7xGeZt1gJjE80oW4Nc9c4dW/aJck67839uYUvjWHMudWSlj2sYrV4nttKaWRBbbuV2bv175m3+M7V7/mh0HSxadVJJd8vWC/CCnpyXzQQRmUCCQ74SfvdUdxRN+wxBF0CvNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHBnH1aXXi8ESzr1ktuxirQ4ZSdGMQVR/TqFihDs0Ew=;
 b=mbVF7ogK/e1BS2pm4eX17rOH3jom00BtZbNp+UAsBZH7osFUJ5X5JRDiMKkjvuGtzBTjzeV5MbiIKQedm54DO8bHf45dDOTJ2gAsoup7oHkKJceiwtJEMTVMHu/IQk8VbJzc4Jj5IYlHFU/GEdpmhhKMY/RnuxQjwi3WuezRWC78ex4k/c2iCkWFguLaWLVtbTEXqH0jHSoM3BtdM7pfchuQ5gB9IdEPguED5l3Y66vmWEyzmgien9vcafevmn3VgEQ2d9SK+L805sIBUB4mGIkkwZYuGFDH08M+4QpUo9UAwefakO8vs9AuHcJQONUXauTTXzB2k14S6sXBq4Ps9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHBnH1aXXi8ESzr1ktuxirQ4ZSdGMQVR/TqFihDs0Ew=;
 b=BRAHr+7n5K4mv3pSMUkKrCf5GKXNy2kfTHSqUF8L3nld2e00WmHnCW3GphKZxZ5m33o4TYg7eYCUAgvSu6x4IJgiMzQNmLmVTpdIUtWDNESVV4bo758VVYzqrxl/7VUbXgwo4eDTW/sKgEKSQZs9u0N/24r8ExirnUiYK4Ozf+NZBSNrFFsHoIxQ3/Kw0KcLwxPC2shCtkuDAGCIrqemuaJajlmXpuds2snVvWkjXpKhQNfD0q5eY+daBuSae+6+Q4ytlG6JUWwP/IlX+QIKqai7n2fKgjNvbLZ75BOsEDJer5Tdh4USETZCBKgFJ7Ll/m+5ggFi/o2BC50k+GgFHw==
Received: from DUZPR01CA0077.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::15) by VI1PR10MB3584.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:137::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Fri, 7 Oct
 2022 15:33:47 +0000
Received: from DB5EUR01FT050.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:46a:cafe::44) by DUZPR01CA0077.outlook.office365.com
 (2603:10a6:10:46a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Fri, 7 Oct 2022 15:33:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT050.mail.protection.outlook.com (10.152.5.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 15:33:47 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Fri, 7 Oct 2022 17:33:46 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.68.172) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Fri, 7 Oct 2022 17:33:46 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the GPIO providing driver
Date:   Fri, 7 Oct 2022 17:33:23 +0200
Message-ID: <20221007153323.1326-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.68.172]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT050:EE_|VI1PR10MB3584:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ec46d4-6fb8-4a5c-0343-08daa8795379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rMHM547MsHacTqSZYg0CZmhzc1DGZsgqrLOx/i7IQfb2GkZrCS2M9bib4lCzAD1BUb+52TEIUwRlwBHg/5Kku/AHu+eYkoOf8FTspGLSCtO2+b3TKRo0lbK48XbL6weRn0sEINBjHNWoCZ3VoHNWwSwJsvYPhhVx0nvxBIDtX9rBq2j2Yk4NKlOsSEidBdxYAgiUtQk72qiLhDtmyK0nZABchEApuWOwAMhksJlrHRM9FOTfht5C7N9/LfKjg+/VuhL+TalNYjK0xxKUa9V3u0/x22H11ZPTfsytVR4CiHlZnCcF89BHHNW+jFV2mCEvR+oHYr4JKscCsYP+oUc+HOlZcXNErbdm/JdDQaGJZ0qK5VTOBEVuh023AhW2Gfr+Wz9fSdkCVH9dvAwuGNIQ/JAFrrkCaE3y+bIhkrVU+RvC4vXH/2v1Id1tLWxqgZmOR72xTgr2jrxx+yJ92hzBJ4FjHCDKD6VGYz4N2H/wm0h9U72yTGBpGPwrQh1WLCFE0KgKJU9+sorSX1L9iHb6nlmy1UroJI8MZE7h1btPXbqW2HBXLEXG5uDjngujnlQWACNXBpFFHv+n3+yg5Wj1KUONefL8iUQhbRHk5j1NsjlycwDInfiBiYGKKRElFTmYrYDFHn6GCPYBrFMUB3nZIMmO52MrMOUwr71OHWaDbrMejsI+rh9y9rd3xiBR74mfoCQGwhROgqrzugpRMAZlZeN2JjpTxhVY0DBvOWecaiusjKoTez0qOP8UFvaeOXeU5ctYX6ZvRFVx0T0vC7M/8l/5rZ8Hw6nlrWDY42ILG5kW2+FfWrLJ4sSlzbq32x5NtflZaukStBYynfqUNShHrQ==
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(40470700004)(36840700001)(46966006)(41300700001)(110136005)(54906003)(316002)(2906002)(8936002)(70206006)(70586007)(4326008)(5660300002)(44832011)(478600001)(8676002)(83380400001)(82740400003)(81166007)(82310400005)(36756003)(40480700001)(82960400001)(356005)(186003)(6666004)(1076003)(26005)(36860700001)(956004)(40460700003)(47076005)(2616005)(16526019)(86362001)(336012)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 15:33:47.0670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ec46d4-6fb8-4a5c-0343-08daa8795379
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT050.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3584
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we register a "leds-gpio" platform device for GPIO pins that do not
exist we get a -EPROBE_DEFER and the probe will be tried again later.
If there is no driver to provide that pin we will poll forever and also
create a lot of log messages.

So check if that GPIO driver is configured, if so it will come up
eventually. If not, we exit our probe function early and do not even
bother registering the "leds-gpio". This method was chosen over "Kconfig
depends" since this way we can add support for more devices and GPIO
backends more easily without "depends":ing on all GPIO backends.

Fixes: a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO version of Siemens driver")
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c b/drivers/leds/simple/simatic-ipc-leds-gpio.c
index b9eeb8702df0..fb8d427837db 100644
--- a/drivers/leds/simple/simatic-ipc-leds-gpio.c
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio.c
@@ -77,6 +77,8 @@ static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
 
 	switch (plat->devmode) {
 	case SIMATIC_IPC_DEVICE_127E:
+		if (!IS_ENABLED(CONFIG_PINCTRL_BROXTON))
+			return -ENODEV;
 		simatic_ipc_led_gpio_table = &simatic_ipc_led_gpio_table_127e;
 		break;
 	case SIMATIC_IPC_DEVICE_227G:
-- 
2.35.1

