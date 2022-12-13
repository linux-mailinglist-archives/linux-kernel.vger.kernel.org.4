Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8830C64BF05
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbiLMWEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236882AbiLMWEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:04:21 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B245E98;
        Tue, 13 Dec 2022 14:04:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6nO+7xvhgPS8AuMxNpC6g8l5pjStAb9FCVrjiJCV6Qolw5367fs5OZRSaXvPU8AGmF3w/Nm9/cBOi4PY7dCZWF2MmoGD8/RHKi7aF0vWW06fxnWKL9yVlM5OqBWmka/skzubUaBxoQ0pVmZIHIdRWAXJjzNB/WBMqNC1AvgbzcAfLQHCZMlK2jtLwR2lDX+WEnNz+FglOiUcZLocodR95ConVOrml6ijKLdIVNWT1VsLms/9BiKvvEnicWW/q0XoY5x9VW4veOV0seLz/Ln8wR+D/S+mXGnv5SjHt1l9N3HFxcz2PrPUVhnNWEAOrU5hJjUJuXzkQmoFrKPkaeOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6g5s/9eB0zMdHNRaRE0Nwl5TXFcNOlmIsalRklVRFE=;
 b=gXbySAHhYx3AWtP963qzKeWAp6fM0MPU7Gkf9fdJeIvSm+T7mQkqq5OZGqzi8shPSo2vu7Lq4MznYxgV5NnGnBQu6qDhxv9fc+VrlXsCZbAeQYruwvyrWvaYHP4EDcSGExf0raN6eqf4lqrvbgHTPiGjlxAXsrayC/LsvvcIpK/S8AsXwflaLE4+3MbJflmjV+yxBHLzZXtv1Klf6XJDm7vJP5EJNARWDDieiW5sYG99xjO4KKyE62v0Gp3LUEj49hwXL9nlrMQMQXp0rWtRiB0iwjOiWKb9dd9UBRvEUo6ghS/WQTHS2VF6dRLR+0ZLsjBCtxDh5lGR3UjUe3iwog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6g5s/9eB0zMdHNRaRE0Nwl5TXFcNOlmIsalRklVRFE=;
 b=ZxsQqx854cQesQYRXRqI07BpQHy9LY8M7GMe0ZZMug45mhWQERb9oXNQo5uhYH4LGo5PEIouQl4AlLXf9HvtojXltCYYNb+evV/+jh6Yej5OiWR7nu/kyCMiHQ4PLG8QDpYQaBLN/Zw9qyshd57O/kzhZnqNNDcFzKsuQhqSG4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DB8PR04MB7196.eurprd04.prod.outlook.com (2603:10a6:10:123::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Tue, 13 Dec
 2022 22:04:17 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663%12]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 22:04:16 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, imx@lists.linux.dev,
        linhaoguo86@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu
Subject: [PATCH v2 1/1] usb: gadget: Assign an unique name for each configfs driver
Date:   Tue, 13 Dec 2022 17:03:54 -0500
Message-Id: <20221213220354.628013-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::45) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DB8PR04MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d2ec48-80f8-4898-5ea5-08dadd55f93e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QGjmxQ8edHxucuaYnuZJhagmvKb9OjyUw7HQtHAnMwz10beCujn8QsxpyhAY++XUGxgaScHiuOqsEat87kQFXLfRnYaMt0vpoyqgs1zVlXdXx72NTg8NEQNh4Bu3kvHIooXVGMdQlroDUnSN4EtDqIN317ALKR/14X0gM6SYQElO9e+FxrXmGAD1m7iHiqGQSWL2rZScZN8SAHhIEyMYn80/wasMtMbEUmUgtZphCUBy9/IXdtDoAZfCbg/MhKeXcRUskYxHjMmKjvhW0GR5VwZI9nhiEXLk+vaqr7tCZP1l3ij0YwJNFJmA0vLHuxWdbtBHANRMOY3mKPZcxmNxXbOiCExmhUYXYJVHwMyrqp8wicq9f0TRWK8m7FVOyAKXgdnP70rttCeAvy8dLCnhEVC717RPqrtAZKkZllBK7IZdf7ajN5KSfFw/gbxFuMEqbwDWdWDMg2MZrc6Vj8+wwDPZm8aRI2AG/XZnf4UdfdJsXz3MfWZmSEmSAlljRSRokNjvctom7S+SKmVQtnqIHnklPWbcUKJl8kDgMpz8G75beFAZHbU947N6T0JOonNUkceEBjuzeMMYcAazbVeyPj7RXsJPGme19dT/jLEXYFjc+DdNXO9AY7cD0f0osfsH6hCJmruB+EsSHh2bz74ePeTIq8w8911HrBeGF1ligN4lWCcnF+gFYQUyAtY8TAsr15RfQ0FvXJSd8V6Y5ellv4HhQ4RC4+cy2fjNFw8NJJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199015)(8936002)(5660300002)(37006003)(316002)(66556008)(8676002)(36756003)(66946007)(1076003)(41300700001)(66476007)(2616005)(4326008)(38100700002)(38350700002)(86362001)(83380400001)(2906002)(186003)(34206002)(6512007)(26005)(6486002)(966005)(52116002)(6506007)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zwy026jCp6NS4iTTULB5c592+syYTCpSJMuzrqfzP1Sb2XHIwvWkRSqUtYh6?=
 =?us-ascii?Q?18oWEFNOXhbJ6CbTbaPkGxFxBcn/s8PVbx/ZF6knzy3sPgSrHqTvUJIFouxn?=
 =?us-ascii?Q?txvraBj4T/hoUaUxjA5ICCekzQJqxbw+eucZHIIGbOcpetMqkWvNHSvmDNYU?=
 =?us-ascii?Q?YdNqVe39q0EuSDDnf0KJtBSWJfGUqznyVUUDF6IiwUbC3ySbrAzpfbI2EX29?=
 =?us-ascii?Q?8rNkE/lHynl4pI+tCgaw2u6slRgLkkg7rj+/EMW/STDwqTsRKz5fCTL9wVbY?=
 =?us-ascii?Q?loSvdNvoKSAOZx4N0UYaX4CHWgd+aQOm6HtslTo4UX+awZGTkFd12M4SkA0M?=
 =?us-ascii?Q?gjKQaipAtyDYcaal+KJaU5cVBhtalHaMipsb2RBVWfTp5Y+ut4ojd51gjFNk?=
 =?us-ascii?Q?4NW7BWyrIDyPOI/JTIesvp0PmtunXsFu5rFO+KPQK7SR/M2S+DD9IMMr8utV?=
 =?us-ascii?Q?Snc2gb/Ow1crDcRadJ7qu4pLL+7a+Jk8GF/FR6iUcHZq2OWjRDubNePvVEVq?=
 =?us-ascii?Q?eg8S2IC/Wc4yFM8PLVHqy3p8vi1BN0EoUd2epwRPNmXebb6XLU+ozrhfG46C?=
 =?us-ascii?Q?dKwThsO0D/XZyVqivKXrdy1RVwpmBC0B8aA4V1if7667jsOJJ1UaBIpSoWwC?=
 =?us-ascii?Q?RTdvMfnD4CWzUIYRDB5NEPx3wNJUlaletRYxG/ByvywjRQQrZMaDulKE7PpT?=
 =?us-ascii?Q?A+u60gpnZezid9IdUrtrCE6U7Y01M7DDUuh7qm25HZdTNPj0+VWff40kW3Ht?=
 =?us-ascii?Q?FxIaWZ0Ioc13+8MzbiJXfByrAdBZNN8VkdMs8UiZGOsJslH72/AkRk3GFGj2?=
 =?us-ascii?Q?8MZwXPMDyJ1Z5gmn+WFNstMBw2kRzeUBv7leb8TfsUf3qgjh0/BLixy/vMgg?=
 =?us-ascii?Q?IAh8HSe9UDMWPMNKCKmvzMRIBkN50whe+J/4Hty/32oGmbzy26DEtwUo62P7?=
 =?us-ascii?Q?x7UdnkgHmChUOQ43UQK2NIPNKPNZYFYk4GD1jJUSMhY2fF0iWubDnML79wae?=
 =?us-ascii?Q?b4tKN6xCDSZ2brLSWnsiKl4kFOCWJOgXpMS3JKkYr3ygPkiJYc34kp61JYh9?=
 =?us-ascii?Q?Ya9fxAKB0UcMA/ejuoW9XY7DU7b6XnsvDOVEbcU44dO/1qphe40BVlw7Wd1y?=
 =?us-ascii?Q?thfLBxY1teKddSm7yhTmWMOMeeNb7ZSVwg+P13Orvb9XQQSfSrmn26EHy/kW?=
 =?us-ascii?Q?lNTd+rK4YFUfkjdRdhHpbTTAhnusbrLoDm3xSj2jaxQbTT+r3BV1NNdTOJ2h?=
 =?us-ascii?Q?Tai0kL9eqovcp2TaPZiO0uqifvProAfQNPIZO7mkbgErFHLiknc49oMkg0AY?=
 =?us-ascii?Q?zRexVtXWckFOpqb71RR+CiXj1mlPXayHrZLn8L+sdKsMvuWE0/ZDzPtfo0oh?=
 =?us-ascii?Q?i7ArhSwyHaVVpoKkBYheBshcHa48Ug2MaVdDj5JbQgDW3ij822kj/XAqCA3J?=
 =?us-ascii?Q?1Sv5GuWsJ46DL0uKIPaP6g0KHJLNg5l0oHTmVLwFuPtiDBtGVWVjg1rfkEA7?=
 =?us-ascii?Q?NXNWCoW5OXjMEAaadSuVBEDW5h8SbPcEwPO4HnZYMJixseFh9l7w9YvcqE1e?=
 =?us-ascii?Q?epZZuD4l8GgcNqgu5Y8bLluLRHeVNOpn+ke9j2E4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d2ec48-80f8-4898-5ea5-08dadd55f93e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 22:04:16.8511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41672o7JSVFCbsL3ZztdvDdSGSfIFxbDO7ANJEzQlYMUO21KR7GOT1aKhSVav8x3l5rpA4PZ0MK1M4TWIDr2XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7196
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rondreis <linhaoguo86@gmail.com>

When use configfs to attach more than one gadget.

Error: Driver 'configfs-gadget' is already registered, aborting...

	UDC core: g1: driver registration failed: -16

The problem is that when creating multiple gadgets with configfs and
binding them to different UDCs, the UDC drivers have the same name
"configfs-gadget". Because of the addition of the "gadget" bus, naming
conflicts will occur when more than one UDC drivers registered to the
bus.

It's not an isolated case, this patch refers to the commit f2d8c2606825
("usb: gadget: Fix non-unique driver names in raw-gadget driver").
Each configfs-gadget driver will be assigned a unique name
"configfs-gadget.N", with a different value of N for each driver
instance.

Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")

Signed-off-by: Rondreis <linhaoguo86@gmail.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

This patch is based on https://lore.kernel.org/lkml/20220907112210.11949-1-linhaoguo86@gmail.com/
fixed the all greg's comments.

I met the same issue.  Look likes Rodrieis have not continue to work this
patch since Sep, 2022.

I don't know full name of Rondreis.

 drivers/usb/gadget/configfs.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 3a6b4926193e..785be6aea720 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -4,12 +4,17 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/nls.h>
+#include <linux/idr.h>
 #include <linux/usb/composite.h>
 #include <linux/usb/gadget_configfs.h>
 #include "configfs.h"
 #include "u_f.h"
 #include "u_os_desc.h"
 
+#define DRIVER_NAME "configfs-gadget"
+
+static DEFINE_IDA(driver_id_numbers);
+
 int check_user_usb_string(const char *name,
 		struct usb_gadget_strings *stringtab_dev)
 {
@@ -46,6 +51,7 @@ struct gadget_info {
 
 	struct usb_composite_driver composite;
 	struct usb_composite_dev cdev;
+	int driver_id_number;
 	bool use_os_desc;
 	char b_vendor_code;
 	char qw_sign[OS_STRING_QW_SIGN_LEN];
@@ -392,6 +398,8 @@ static void gadget_info_attr_release(struct config_item *item)
 	WARN_ON(!list_empty(&gi->string_list));
 	WARN_ON(!list_empty(&gi->available_func));
 	kfree(gi->composite.gadget_driver.function);
+	kfree(gi->composite.gadget_driver.driver.name);
+	ida_free(&driver_id_numbers, gi->driver_id_number);
 	kfree(gi);
 }
 
@@ -1571,7 +1579,6 @@ static const struct usb_gadget_driver configfs_driver_template = {
 	.max_speed	= USB_SPEED_SUPER_PLUS,
 	.driver = {
 		.owner          = THIS_MODULE,
-		.name		= "configfs-gadget",
 	},
 	.match_existing_only = 1,
 };
@@ -1581,6 +1588,7 @@ static struct config_group *gadgets_make(
 		const char *name)
 {
 	struct gadget_info *gi;
+	int ret = 0;
 
 	gi = kzalloc(sizeof(*gi), GFP_KERNEL);
 	if (!gi)
@@ -1622,16 +1630,30 @@ static struct config_group *gadgets_make(
 
 	gi->composite.gadget_driver = configfs_driver_template;
 
+	ret = ida_alloc(&driver_id_numbers, GFP_KERNEL);
+	if (ret < 0)
+		goto err;
+	gi->driver_id_number = ret;
+
+	gi->composite.gadget_driver.driver.name =
+		kasprintf(GFP_KERNEL, DRIVER_NAME ".%d", gi->driver_id_number);
+
 	gi->composite.gadget_driver.function = kstrdup(name, GFP_KERNEL);
 	gi->composite.name = gi->composite.gadget_driver.function;
 
-	if (!gi->composite.gadget_driver.function)
-		goto err;
+	if (!gi->composite.gadget_driver.function) {
+		ret = -ENOMEM;
+		goto err_func;
+	}
 
 	return &gi->group;
+
+err_func:
+	kfree(gi->composite.gadget_driver.driver.name);
+	ida_free(&driver_id_numbers, gi->driver_id_number);
 err:
 	kfree(gi);
-	return ERR_PTR(-ENOMEM);
+	return ERR_PTR(ret);
 }
 
 static void gadgets_drop(struct config_group *group, struct config_item *item)
-- 
2.34.1

