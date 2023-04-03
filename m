Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E766D4506
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjDCM6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjDCM6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:58:02 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B472D5B;
        Mon,  3 Apr 2023 05:58:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3gUdnz5M7JvEcqeVupFfe/TeM3sYZOwy9xRSyvNGpX2enOm6P/tDK5Bbq9iPPuNpmTOWRYkLFK7uC2MJ/5zidndKNyBkgRsAZ+Yi/DEMtYsPy0geAUgAfwR7DLj8iVi1hRjk90sjUEAWwmc9HjxvWTOffFiyUMfIboq2l9su9cyFEVik4wwIfmTLPGxgaUNnGFuw2kLgDyutuJeYWNTlnROUe6PtZdGUpXZ8UEtF2m3DdgBcYYmgk4IdtLq9J6EQn31GtC8LUQgqZAo7kNfeNgwtrUXCyNVOUdf8GpPXa/ZSuuNQIz8vQ6OelggnIeVHWQ5SjQo0i+f982BPngjHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDh9wCBQDptbMEgYwpXyRzx1UM6n36KRCOxfPDjgK9M=;
 b=d7SMXvlw3vg+niaGgUEhOobJLqkk40moM9sp5mcIxxag2SYGzI2ifnzhN9fNSnXnAV84X8An/oIn3cpBIqRIGgY4/MUsX3OcY5TTJ2ChnJjuhKlzIaHP3iUkbyNkhzXmmAwWt3vTEtSoqWCcJf0siEXvxjDYwZJEra+ynmiL3eKXhK1WuOoE1TEpFxULmQPs3GV1/2UpQljt44jYx0x10lUPpWQ0hSF7WUHu0rbqebySklWlWfhPNWzDhXrVcXFMNkQQ1FSJ7jZ5wKOLvNaNtoeoeVSnELS7AFFFmpDkRIe9BVbmz2Y8YbIeHZUO/18YJa7aYDqSGxL9WdLeaazBtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDh9wCBQDptbMEgYwpXyRzx1UM6n36KRCOxfPDjgK9M=;
 b=zIF2OWGVNiT8xyQ4b38ZLircqshlZ9BC/uCqkxJ9gLYp8MkIUlUtNp22gAPLyLCYwK8v1JBT2cV7rSqoAY7ey6xajiMpaMlmmVgdyONp3/zeT0SW3CWvA7G98CitEgSZmjMA5csYrGhN9QCGKUULCqTIyDf3SSOGXkT6kaV2b4s=
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
Subject: [PATCH 2/2] Input: st1232 - add wake up event counting
Date:   Mon,  3 Apr 2023 14:47:07 +0200
Message-Id: <20230403124707.102986-3-javier.carrasco@wolfvision.net>
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
X-MS-Office365-Filtering-Correlation-Id: 83c3e5e8-7220-4501-0ca2-08db34430a6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OTE1PftioMSab64ep45+MV/3001mvJPZd6bfTO/ZCBUwLMCl4i1o+4WqX9eC9JYyss92ab3P+ICClzi/dp8oTmHUHIL9q1+lzSR6/XwrPY8k3677PxjQuE2ipcj9cBjuQ7eOIlWiddaV55NDLqblpDfjsYDnhobr0vI2Qr+nh1yjQ8wJWyKL/gDcJvDmagmJbK4obfJ1y02U7hCihQIQyCsdzWhQdbFsyjyfbOlcUwEfy965sFT7UIIShNg1Sb44S3/dcLVQjrnAxKUyS6UCjt04fGOrjGPfQlQGpB/xpegCMQMqHqicyHtU74Q3FSNdPSsiIpUxkXy5WJyzEX18l6lH9Qm0JEn0dKZ+uo0JffOboZgiaHoqE0AL/GHxF98StGSJ/qKeJdTTtc/XhbkDYr8bRvvoZu2gOdN7+tz672K4TypU3ML5JVMeAdh7Qizj6qR9qTVF5IPzFqaWI/qPLU82V3kmgjrdggbHsWhi3V3/w9rLplBsUJFL6irXCU7KJPj6DDhHZN23Pi6/zLtURe1jUWXSX7kvvdmeOSy6Uf7+/vNCl/FcwQ9lPYNZszWawsuDx/N3LINk+N3RC3WB50WwDekqwmBb5BKOR3T7hQjPf8q35tMTL1x1YorUOKFd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(366004)(39850400004)(451199021)(2616005)(83380400001)(186003)(52116002)(6486002)(6666004)(478600001)(316002)(107886003)(6512007)(6506007)(2906002)(1076003)(26005)(54906003)(5660300002)(44832011)(36756003)(38100700002)(38350700002)(66556008)(66946007)(66476007)(41300700001)(4326008)(86362001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NYgfO9Rdl4hSux67zqkcOlJNPMj+Iq7EhkyPHa81Aa42oCQ2/F5+CLQvi8LJ?=
 =?us-ascii?Q?qCe9qLYiBcM7clIDSxAo0oGuOvvtfcD5L4EHFnpNSUq3kVSG7cOw3E5XK0zS?=
 =?us-ascii?Q?GShbs+WSCkhCsP5Z3ZsyUq9HBFEerrfFc5FgvzgIQSPIhUx+ueVDWIMRkqwF?=
 =?us-ascii?Q?33V+giHo35R5Cmtt3bsQfmPflKCSVaqjx8VfwiiWHhdN89M9V96yZDtXcIu9?=
 =?us-ascii?Q?U2meqlEAIUGWM4RNRep4It2UBfKR13C/vc19xwu8oXKTvWUFzfQWh+WSmI7f?=
 =?us-ascii?Q?WWVTovJgMr0MgIIJnjlwOKsxBUUOypkzljtxHecC8sR0tR2IpVZUJh8r3BPt?=
 =?us-ascii?Q?6bRhCzKRyXBs+OJlN4t5PuKbtb2MFk30rZKyb9wrG5c474cKC4mdtKruAGrg?=
 =?us-ascii?Q?4p03e5Kp5Lu5mB5//AZaQC6OMfGodxEw/2hXp+qLFbCSh/buzzLvNhpbEpTw?=
 =?us-ascii?Q?F2zorifym234PUr+B8BTm0pUp7IO/0lmPu9xcbt/9eAUzg9I9aKTlhs9oney?=
 =?us-ascii?Q?4TYizo9FGl8EHW65jPO5XHnnOXN6JJgm4+cmja7Hv1TKAksxspDqem5gTnJK?=
 =?us-ascii?Q?U93KzM71FhRyslS/qECL7twoVD9SFs3OdscTfUjcWXKUs+9tdfn9RUFB16Qm?=
 =?us-ascii?Q?N1LHQIBt0Te4W0DZab05kZzcVQ/fsT9+pbGXhmGPw/esJ5VUoNUXgzt3q6uA?=
 =?us-ascii?Q?RXzbOp4hEDVELdhrk8uQuudhXHYPDY4MOJIbIt16gP+QxMhjsmi/6ewcrIPM?=
 =?us-ascii?Q?RmcrYH1XpFRLO+Hrb2nkjZIVcP9S+aT1YMXdteoD1BQNSDTIxaph+SWMqYS+?=
 =?us-ascii?Q?NKVqmHI0JBCi9gIgVwQU432evAPv/stxNtt7SMkR0H4MERQ8fLZ7/YrlL9y5?=
 =?us-ascii?Q?s+D8/WWWeORxs0ycrN/b/dHJVTEE8kHaRMx0GYI5REXYE3Qyii6EPugRcs/J?=
 =?us-ascii?Q?s4mkMKS9gR92G1BvnwWtrTg4WBzBKSpLfqxC+TQU3IiGM1/sujyqwR9zujtg?=
 =?us-ascii?Q?a75RHNyc1ApLR3zkwurANRxMc46LrxB8K6p+E+SdFR5xbBwTRFvpnHyhvxZO?=
 =?us-ascii?Q?lW7crdrxcAohoTzKT5V71p185+PgjZjzXvd7SxZ7E4jInU2m+EKKhevB7QFI?=
 =?us-ascii?Q?NWE/1W50JUl8noEYKcTlKLH0Ae1L5SAA+u3Jn7HWpRWBQ9Zcjf4zB19FxLJG?=
 =?us-ascii?Q?5KHCjuQfy9FU4XzaUGipycPT3LEw0mgi5O95ItpRBkND82Mv0siY2dt81B20?=
 =?us-ascii?Q?/RA/BT3iP/o5rldtXCYE4+xPMOp1GljCGGr8OMuBXZWi0YeTs55iHeDX729v?=
 =?us-ascii?Q?OHJsBuJ4AphYmxHMcoOZ3c3jwOByNVTDY6Z/5OIcGmxX0FTigEZlPgejLnzE?=
 =?us-ascii?Q?huu3qMIesVYFJ1XCKCbHjeX1FUtSLihj4PAyCjZdoQC0DAicohthIC3nxwEL?=
 =?us-ascii?Q?3gG+rSKV0C71QqyYg7EgZcH/u5iPip9FhGAWeXFmHcWtq+8XaPcBcHsmJoxI?=
 =?us-ascii?Q?Rs4++aLr5kDKg9dWfC8ygnyeCGt4pZcXOoCSj5FaTyDEkFxqvwhSRccf1m8o?=
 =?us-ascii?Q?x0XobUEliOifks8ZjZ/FrLsUtgFkPj7n6x65m6snYDafsUUpfIE5gtO0ZNnH?=
 =?us-ascii?Q?jkmmaD5iP9RoWati9ByhBoQ=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c3e5e8-7220-4501-0ca2-08db34430a6a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 12:57:54.6478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFhPTwArbspZhFs3Fu+GYt9JD4mqGs5TNIRL+cc/g0CO8dLrh7A7W8gX4rgdVJtHANmBJoUXivbiZokYN2oNWXepFDoy9/qijCBkg4SxyTk=
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

This device driver provides wakeup capabilities but the wakeup events
are not reflected in sysfs. Add pm_wakeup_event to the interrupt handler
in order to do so.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/input/touchscreen/st1232.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index faa0be3993f4..f175bea464e1 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -59,6 +59,7 @@ struct st1232_ts_data {
 	const struct st_chip_info *chip_info;
 	int read_buf_len;
 	u8 *read_buf;
+	bool suspended;
 };
 
 static int st1232_ts_read_data(struct st1232_ts_data *ts, u8 reg,
@@ -173,9 +174,13 @@ static int st1232_ts_parse_and_report(struct st1232_ts_data *ts)
 static irqreturn_t st1232_ts_irq_handler(int irq, void *dev_id)
 {
 	struct st1232_ts_data *ts = dev_id;
+	struct i2c_client *client = ts->client;
 	int count;
 	int error;
 
+	if (ts->suspended && device_may_wakeup(&client->dev))
+		pm_wakeup_event(&client->dev, 0);
+
 	error = st1232_ts_read_data(ts, REG_XY_COORDINATES, ts->read_buf_len);
 	if (error)
 		goto out;
@@ -344,10 +349,16 @@ static int st1232_ts_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct st1232_ts_data *ts = i2c_get_clientdata(client);
+	struct input_dev *input = ts->input_dev;
+
+	mutex_lock(&input->mutex);
+	ts->suspended = true;
 
 	if (!device_may_wakeup(&client->dev))
 		st1232_ts_power(ts, false);
 
+	mutex_unlock(&input->mutex);
+
 	return 0;
 }
 
@@ -355,10 +366,16 @@ static int st1232_ts_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct st1232_ts_data *ts = i2c_get_clientdata(client);
+	struct input_dev *input = ts->input_dev;
+
+	mutex_lock(&input->mutex);
+	ts->suspended = false;
 
 	if (!device_may_wakeup(&client->dev))
 		st1232_ts_power(ts, true);
 
+	mutex_unlock(&input->mutex);
+
 	return 0;
 }
 
-- 
2.37.2

