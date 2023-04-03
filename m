Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38FC6D4504
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjDCM6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDCM6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:58:00 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543A71702;
        Mon,  3 Apr 2023 05:57:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7tOcs06LvCcIDiCUzFgm8tK4VOShTSPNObhlz+PQB18fyruObksoFSqK+IS7N1CTy3apG4qJ9vShFQzVIz0cM1C5satOkvEt6lWyDHFqUNu1C0Y/YzLQGpKxy71xqgeHhjm/3on9u9O5qSPa19tWmf23C+iul55d3XMdqTQj+3Du1pX5O9WcV9FruhGf1g5zqQvKPn6kz5X7su4ONXhGSy39jHG/GzCfiPyrSIm/6tzzmj0WrWSdZZy3VXgAAd6r+owYQkk3jqVAiPLkhaUcPZpPWLe4GgqYK9RstfNML4qMmjsTROOt7kai2Oww2WOc0dAjt+exEEL03+BaxuC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsReSqbomdhlSTsl75jCknV5AXC8jBXZHUE6qng3+QE=;
 b=nIU76KtW7q8kVWmDYBdYlJKND44B3gj9czX6ToCYyEwn/REbEmWdMC79kv0KFel0b+MhS74reBnWqmuHPddBeF+8lBoTlV8Ji3vbRYABoB/aAk5gMjYQ/wwJ3Aqx9rg6WlIb+tw/ZENdGRj8+C/4K+U2kChnbzz5th08PQ68OnsDumMYIEtiYCaCxC9O25CQY1YFBfw1KXZp+VrVrpyq57LWAi9lHnD2so1BPfii6K3lNRD0eqx1OHznXiBmHBeYPa62vLDHtoFwCeYeVT3syxI7Pxlo8GEaJrnQNz06TQ/y486U8y5A0JAyvu3HB/D6P/fREcHngEwfZYDLj9Rffw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsReSqbomdhlSTsl75jCknV5AXC8jBXZHUE6qng3+QE=;
 b=NkUjMo04yzICc5juIkPseCXBhEzU0d+WDiMA3fRh+1y1wcyErY4ApGPdhBGUW6xJvg5N4A6vE3GOOvBuWvy8LxX6vHdPQJQExjes6kw+l62MUZ+y4vx52eMFN/kNIU6UxGy6xKrUQoC91k0cRkM6pR7IR3zhYkuUmrRaDTy9f/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU0PR08MB8787.eurprd08.prod.outlook.com (2603:10a6:10:476::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 12:57:55 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c445:c8e:be5d:d40e]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c445:c8e:be5d:d40e%7]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 12:57:55 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Uwe Kleine-g <u.kleine-koenig@pengutronix.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH 1/2] Input: st1232 - remove enable/disable irq in resume/suspend callbacks
Date:   Mon,  3 Apr 2023 14:47:06 +0200
Message-Id: <20230403124707.102986-2-javier.carrasco@wolfvision.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230403124707.102986-1-javier.carrasco@wolfvision.net>
References: <20230403124707.102986-1-javier.carrasco@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0055.eurprd09.prod.outlook.com
 (2603:10a6:802:28::23) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU0PR08MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: adc6e349-9607-4bd7-5eac-08db34430a3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YlzYqrU0rcv0EJmq47bVVVRJAufhGde1ytCcMriKaCq5uAKk1gHzLOF+oJxnPIIw6irhXx6ZymlHUMdzktfFbYwf7FFafEn6Iqazx0Ydw1mbJJzxilLudeiqJDE7OVvNJdOsVpjEoI/mhT9WyFhTK4kUTF6zPl52mlI1BI2JcwRyE71BJJRHAL9px9thlMk0ODTBC6xMGlMNgx9a4bk8s3JXb3iLe4udERz9dYhKHj4tUp2ZPmz7dTB8mZQpzbryHygefgtiiLSIFC9f3IoBGnXmC0OuqlWZk8nMU/05ugmPQ/y2gy4N70E8prtW74XWQBiBQihpno/K+loqz3NJspJzfgx9VGjEFhg+5zNZGBJO6rDvym4o/n1o81S5Sj9jTYEWpJPWwWrbEwMOEgNlBkPCtc/Euij1ekltW+i9HC5rXN6zPITol2fzEEigaeHv9q0iu6nl8M1hulcdEBpOMKz58KhH2I/iXjm0FYuiro1KJ4jZqgAR4CCqWDw4q8XFD4iP7lWHhweHMq2FDi+l4piaqwLxc/RE0d3xicIXzo32CcS0I74AN7UYlSSOiIQj5BNNHNTvSzVcSYPpoKV1QwJiASCktDePvYlsgCXs0QDFwaaWec3DHOgIl4dDXOLJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(366004)(39850400004)(451199021)(2616005)(83380400001)(186003)(52116002)(6486002)(6666004)(478600001)(316002)(107886003)(6512007)(6506007)(2906002)(1076003)(26005)(54906003)(5660300002)(44832011)(15650500001)(36756003)(38100700002)(38350700002)(66556008)(66946007)(66476007)(41300700001)(4326008)(86362001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?07GTsrnvQqYA06irfaAfRg/zoKQjoSUbEm1/xFOVveY7z37FSZc9gu+sY0Gs?=
 =?us-ascii?Q?CgYIVcPSB3g8fk6T2s0S8w0hBYI/h2Eqaskns4lT8aWU/2ITgmOsevvbRUM/?=
 =?us-ascii?Q?+a+eUBmDXvEvvVbem+bANtNu20G/jpBR49q+8uR+VE7/Azxj+Ao1XYIyeQLd?=
 =?us-ascii?Q?DJBW27yoEi5SowjE/3JXml8jKXO1jD/qPaO4tLIbMHCI0cZjmN1cjN0AI6v+?=
 =?us-ascii?Q?KowMVBGxJFkKiZ8TIsq6JH1mz9lhmhN5gKIhS+fgvTm7+lYojwZqApAsSTJ7?=
 =?us-ascii?Q?xUUejhMNYhnSP/rQ+6bYG0z1/uFirPUIsTDAfPFsyRL2karfsc6BWaFeC4E4?=
 =?us-ascii?Q?OuXM8Hg967KC3L97mdoEN8N86IoaL1ixSG106ip7xKgGpWeBLI0g3lhXCLhp?=
 =?us-ascii?Q?Cv32z+YycXZE33ZbTacPlWzGLy2cI8yYQ4T6N983LNGq/ZEpDPINQyhHoSEW?=
 =?us-ascii?Q?Rr+y9vpIKNxl4bBTcZ5p26tp5aZgEM1BaiO3PviIckBHDL9rzhDdCD3+dWC2?=
 =?us-ascii?Q?6EO5uwqYLmzg8l3xNYlkeO0lI6x0RfujVpIJGiHH8lpgG4WpMcf0glv5o/j6?=
 =?us-ascii?Q?P1K5FLKTJXIZyuGXO0vsdyncoQNPVj/81SEHfHx/fdaJWhE3nQn5IPCKowRk?=
 =?us-ascii?Q?uClBZ7hUkgsiwxzIrZP6ZDK8Idtss1hZ6QUK21BeP9OcmSTUbuc+EyHvYdiR?=
 =?us-ascii?Q?QGRFiIG5SqdU7cO5tUcUKxYjw15flPytdeY2svQNN/mLJGQZjETPVf4pT8PM?=
 =?us-ascii?Q?KAtKLQF+zhEOu/PxMtTqWk1EDBOuYOAzT+UXhTFfSp7wtetqIoFYIRA5LYXX?=
 =?us-ascii?Q?ZT+tLRI45MveSgKGwjvAEB1V/SAGzq82zyHyHv3k7jDYWVuIGnSFGfJ/pcw4?=
 =?us-ascii?Q?lSbI98AzmLGLrKqPnW/GJmYICZdxH1MrgPgqiHhQ+JlQJi708mRWMKtp0xyr?=
 =?us-ascii?Q?ZqV86lMlvZDX6cF/9qdnXsaG3PvaEwKDXRNtd9GiZHSTtZy5uravpsnzDoTi?=
 =?us-ascii?Q?eJNudAFvHlSazxD637HjRC59jsJVOOA4A4ehjyby4ntT5QVPh9CIJGmIzNE/?=
 =?us-ascii?Q?zJJPjxttAUhecjpYyyanB5rSms+AUhHoQ8FsbbD8av2olI3qF93kVGXaBTBQ?=
 =?us-ascii?Q?1/lRe34SNUpxgJXPopRt0ITnTrWeyJF5CA1Foua+YhZCMdo9+48gEbUw9fkN?=
 =?us-ascii?Q?iCS3zX9Xw9zNw3si0Cj4H5rIYDAQzyvM1rXCX6elBd3rjfhKt+NcCmFaCfMQ?=
 =?us-ascii?Q?YFJSAlvU1kSnEgTGVLXVouWE+OP8r4lQin8oN3ijYZvcHn5tGtQoQDdW7Tal?=
 =?us-ascii?Q?of8+FAQ9wdZFfi5hDue3t4TunYqaPssuTXX7wT2AbmbwQOX93WIKdnOJ97Wt?=
 =?us-ascii?Q?oju+l/ishdMfLVjWgqHpAQUeFjuJj7FhYjmuapgbWjODyOom/qVLIlBx/YO9?=
 =?us-ascii?Q?OoZmfJnQ8dunSPbBJ9nptEQvMidZ/Dh7vwMI2FEU35oD6/Y7hrhemHAamrcB?=
 =?us-ascii?Q?q4youMj9ROL+inII6qsZoJ4K2lzY54X94eeqP81jCulrHUKQZzqDJMmao4rp?=
 =?us-ascii?Q?FsUK231VHtq17KP7/VkQqrmtMDyncdCsNTAVkzkMJq9gkGzHZutd02j0jVKz?=
 =?us-ascii?Q?RpmAJZb1KgVjKBp6dH8oZto=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: adc6e349-9607-4bd7-5eac-08db34430a3a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 12:57:54.3303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVt1ITvfSgiRBdWy2FjPzC4TXW0KOIrpyRgmzlpuNcTZsEtECj7ZrnwmHGUtw4VWxTo7PQBWw4367gEBicbzw/Sd3SNewcUISgY4r8pzbhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8787
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disabling the interrupts in the suspend callback leads to a loss of the
wakeup capability in suspend to idle (freeze) mode.

In commit 95dc58a9a02f ("Input: st1232 - rely on I2C core to configure
wakeup interrupt") redundancy was removed by letting the I2C core manage
the wake interrupt handling. On the other hand, the irq enabling/disabling
was generalized to all devices, regardless of their wakeup capabilities.

The interrupt enabling/disabling is carried out by the power subsystem in
the resume/suspend states and therefore there is no need to manage it
in the device driver. Remove the irq handling in the driver-specific
resume/suspend callbacks and rely on the power subsystem.

Fixes: 95dc58a9a02f ("Input: st1232 - rely on I2C core to configure wakeup interrupt")
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/input/touchscreen/st1232.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index f49566dc96f8..faa0be3993f4 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -345,8 +345,6 @@ static int st1232_ts_suspend(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct st1232_ts_data *ts = i2c_get_clientdata(client);
 
-	disable_irq(client->irq);
-
 	if (!device_may_wakeup(&client->dev))
 		st1232_ts_power(ts, false);
 
@@ -361,8 +359,6 @@ static int st1232_ts_resume(struct device *dev)
 	if (!device_may_wakeup(&client->dev))
 		st1232_ts_power(ts, true);
 
-	enable_irq(client->irq);
-
 	return 0;
 }
 
-- 
2.37.2

