Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE7D65481A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 22:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiLVV7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 16:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLVV7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 16:59:16 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2058.outbound.protection.outlook.com [40.107.15.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2964DED0;
        Thu, 22 Dec 2022 13:59:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJzd/IAA+FLlYb/TjgZ1VenCWiA3Ou7BKxfffzhUgB92oAe86E8okxDHNBMlSMI8AbL610A0Tw5RYA9idCoO16K3/mEI+kJmfTIEA0Wt6PQbsfzCCCswzyiLNVwV8vJXFQ/B3cft4r4qYJ/ssfiygJFcKGfHQzbE2ZliUIC/qhw241cCDxXCnudRGxURSJZi31LrZjZLQLs8J2apz/kb/pVI21RpEj6i5ea0B+oWmbHZZ4cgQUoV0b88jWDW9H+QgrLkJKKGut2SBY2ZbtkEU17G6U1PzpjZXE0QwS1rJiUKl5WptAmUYRCeLuOEs8ZTaYcb2YgKXxk/7sAcD4vbOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPLyeyQBsWiu6HT02RqrbFjct+C6eALLBxl08spFg2k=;
 b=jABD5jn9L5cBhy+vbAjroLE4lFGKMdRcnyX73sQ3qGnXSwLiupUvxzIgDXVTWuXTg2MstQiZGU22AVhHIPpvRKRNLjybcUWprc9oGdQ6G9E2m/qGjkCu4Pz+4uuL9Yt+6txWrZ5GZARQVFAqrGg4tBKNiEudxTUkwzKpd9TIPMuBRjpEPRga602CA+wnztxghDilLOl1TiaPKCqJ3FuV2DiD9K6iCa8bvB42LvAAh/8+WJtNpHoGDit2o6EmB+QNn+pb4GVLWjsnjQN0hXMhwTAtTcugN25wA9+xi9s90k1MGnC1La4a8AphkmA1B14rjb6+j3tNcNsLF2PFJe6qoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPLyeyQBsWiu6HT02RqrbFjct+C6eALLBxl08spFg2k=;
 b=16e8Wm1wXK9wyEiV9NwNV0b0+x///XFS30dvXHiqP39m0quc7cB2YSHJj6r2xO5O1qdM0AkbmXKbzpof7ZV0xl+lPX5m1X1WYbJ2XA3sGRoo2zndi6kXsjlSkTJIxBZhIZdM9TM0GGgnLTUkCaAbgg99SAysCDQIef9QBfggR4nXJMJfMa5W1ES3TYSUq7wRwfmGpk9MQ9m9KM34EBd/xHeJ3j5XS0kmmNUiU8K4XH6avjXQUrTbaOLKyue52op/D2lb2ZHUxgXdV7cK7fgs4fBvHM6XhTTwgTB+epP6qv06qOt6E9mgp+0h0gx5tLpzeVzeZiqpfhqfJ5jSieLVAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from AS8PR03MB8832.eurprd03.prod.outlook.com (2603:10a6:20b:56e::11)
 by PAWPR03MB9009.eurprd03.prod.outlook.com (2603:10a6:102:337::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 21:59:09 +0000
Received: from AS8PR03MB8832.eurprd03.prod.outlook.com
 ([fe80::264c:4825:bcb5:e4ac]) by AS8PR03MB8832.eurprd03.prod.outlook.com
 ([fe80::264c:4825:bcb5:e4ac%9]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 21:59:08 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2] rtc: abx80x: Don't warn about oscillator failure after PoR
Date:   Thu, 22 Dec 2022 16:58:58 -0500
Message-Id: <20221222215858.1886378-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0146.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::31) To AS8PR03MB8832.eurprd03.prod.outlook.com
 (2603:10a6:20b:56e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB8832:EE_|PAWPR03MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 38833d66-ae1f-4f6a-e24f-08dae467c060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LfE27wWTZjYJU+CBg1149LyvPD+Cc0yj209AdVxmVh+izd+4pcNYNpEULw6jt16CujsoniAlNSqfFNrnK8UbU0kftny0BzHLIA52Znc26qF4bP/ULOpW777kwFxLChgcVLynLpP4cad7zQAAWVi+Ska3PLS65x03zqs5jMTh/m6EPQSh/bhzk2sUFYtws7BrewKqfD7+mMiiHdJOk71rSk9hXZclKZVVv6IPsxLuG9Vg15K7idz7AR3qhAGY6+fEiWrJvShzhltiOK80Kqwe7TC50+cgvz9E2VEaDTXyY6hTpRL/hLpOcoYqrBAXrqbzr5xMezfLD8C4PbtTGivoI/EsLcNDbESfbgQo2x8/as/1SKqSn0rNiqQ/QgNTTChL1XQo08FA9v4C8XmtcMK/vdgtXDzQ2VfWTKw+kU9HEk29so8f3R+EvXimjGKysae2pM894kWrvaZh9f4ZyZlWp49gDuLWCUQ9vQwbVy0TgtVQFuCeuXRVZShqv3enEFnPfcGUgHo/G6fQygpiC3aV2q8e8U/IgpKFXcuCfPagiT+UywXvYhlAmLY1GmvlfjgyVPFTiTG2CIIs/MdRRtGlem3akug1gNLu4g124a6ef6g6/q39usiXQXeulKC9z2LvwiJuoGUg5vT8n95jzdW1vCAJlU6MrEDbBsGd17zvPi4pnASgLIDgG/NfqK65iy1s8tOin5VTMtlGmMGkK/XaOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8832.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(346002)(376002)(136003)(366004)(396003)(451199015)(110136005)(1076003)(2616005)(2906002)(26005)(316002)(478600001)(186003)(86362001)(36756003)(38100700002)(38350700002)(6506007)(83380400001)(6512007)(6666004)(66476007)(52116002)(6486002)(8676002)(44832011)(4326008)(8936002)(41300700001)(66556008)(5660300002)(66946007)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tAx0rEVYnWrQPCVWT2Gb+rQeCcESAlmR2PTBbIIxMD39DDMzZ8ctOhKJeNSo?=
 =?us-ascii?Q?QjA8U7eEQR+Ev4smWscP4ogKBZ12MsNM+8bEZA7qJbiTCGrv+L7R0fpJCTYo?=
 =?us-ascii?Q?Tof16Ipfj/JRoG1jwwtzWjz6MoVQjVMIzj08EtgDq7EfmkbRHb/ycAwIAyQY?=
 =?us-ascii?Q?/3pu8QxYUKzimh6vXqjdrGgxAKImQtZTuuFsd7+WFLm+Szf2BIWTwzLua+WR?=
 =?us-ascii?Q?U2FX5l1CPcXxfokO97tDxH5oPmAo62tKFqCqGErjakUFDRLCLplwaaRhdUlz?=
 =?us-ascii?Q?56aLI1xK+RDEViXLEjmsSGBtiEDSTRGMsIsdrXaJUvP0UO3drMySW4sOzV0o?=
 =?us-ascii?Q?aZl3V0VWwMYAJlf1ODf3k9Aiz8ZLCsrWsi6XuLzul4UgJTa7aBupTcQtn/8i?=
 =?us-ascii?Q?IypGsnFDvzJuhwC7QID+gVG2sSQtNE8n7KtqIOSYJjjMKbrJC+oriFQckknL?=
 =?us-ascii?Q?im19QL8+dgZ7zTGB8wE9OZaNr970s5aTgQzZ3vupvkStYw2owtqFs221qEKo?=
 =?us-ascii?Q?1d4DF/NYgDpwR/Rq0s67rFEFVNmkm4vdYfyDWRr96hhvPXwyEegJu67xpNIC?=
 =?us-ascii?Q?kesg0ETCKsIvzPsUTkofMWG57n4NkA5c0NkrwEbKpM7xC2H4I7U1185pfTcq?=
 =?us-ascii?Q?Jj+mcZM3ADXe5/1UIbuYP0QVdWIZ0e4+uj4dnzg9NSrr4wBshAIheBzNrdy/?=
 =?us-ascii?Q?XzmdwkromxQszBBx+OlYIFP8sDhVMVJDdyb6qjWJFTGcVHkJQJdwUMHfP+ya?=
 =?us-ascii?Q?Mc9C9btBt58uBF5/t7u/c4bSkId7xwkVt9WgUyYBWxrdkzWhXg1mZ0SrDKN1?=
 =?us-ascii?Q?HjxUh26xp3/ZHVgMUKQ4bLuEY6ysIo363iFF8HmBKlnYzqru6VdFiiq/YYyh?=
 =?us-ascii?Q?N5/XALge3zJDZX0ZccSIf3tdSFNdS0y1Lrhh4T2+Z/9Ht6iavFo6j1eSzXuo?=
 =?us-ascii?Q?fc5Sq5tgi3Ox7hXMxJ6d10qf3pfFeNYjrkaFIENnlvG1+Wb+KOtTjbC0WPzH?=
 =?us-ascii?Q?h/IKyDb63Sywg1ZTBjmPq+cHzHDUML+ZGpR67xq6v82zKW/nscfuKobZDmKm?=
 =?us-ascii?Q?lCew/IJQlpkZ5wtFfJ2TV1qAS7x8mdSAslBK/YlYHAummb7Jx7F5+dt3tgIO?=
 =?us-ascii?Q?71FQP7i7CZ7/8Z8vf5np0YpwMUsv20mWLM5IBaQMkHA8GHRjtrBOWgzeawH/?=
 =?us-ascii?Q?EUbEWCD/XzlkTq4SXwHXDL//2nLz0kg0sGyBilNqGnJCFhJaWtEFmz/7up4D?=
 =?us-ascii?Q?gJt+ualqHCDG/eWWHSYm/8UqzjYh2wyvd8z2OoET/ojUgH4Y5a/KW6teM/zh?=
 =?us-ascii?Q?nTt0KfJ1mniLE1I2azpW7OlGVVUoU829A4zVTXV5sdo0wVuQDRhApn8gUgL6?=
 =?us-ascii?Q?ALPhuN2uBHunFKyLnu0YZph/BjYnafjg/LSaDbF/WHxPWUPGR/Oho+2MJSFy?=
 =?us-ascii?Q?ptU2ksdw4mNam2JO4oSeuKo9+BVMNgmYIUma0/5iTC3VsT9H8SOROlpZMaqn?=
 =?us-ascii?Q?AOJQW4rUnse3BwWdm+mqTARGWxW7Ncts0Cd3nIkv9drO3TST3AXMAC6ym0Ed?=
 =?us-ascii?Q?egTwC6bAmvGrG7gAJuGvRFTrlSFPpr2tvZQAEALpdh1DA2dM6Fa7Jv1l9+hQ?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38833d66-ae1f-4f6a-e24f-08dae467c060
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB8832.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 21:59:08.8092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9iTM66VFsJlMSRwyC5BN0c0LhU8u9n+ebYZY0xXb6oUA33/6oj1hrR2W4u1iGD+di2uWRxuG4DdPnkynlicpjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet, the "oscillator failure" bit is set

> ...on a power on reset, when both the system and battery voltages have
> dropped below acceptable levels. It is also set if an Oscillator Failure
> occurs....

From testing, this bit is also set if a software reset is initiated.

This bit has a confusing name; it really tells us whether the time data
is valid. We clear it when writing the time. If it is still set, that
means there is a persistent issue (such as an oscillator failure),
instead of a transient one (such as power loss).

Because there are several other reasons which might cause this bit
to be set (including booting for the first time or a battery failure),
do not warn about oscillator failures willy-nilly. This may cause system
integrators to waste time looking into the wrong line of investigation.

We continue to warn the user if the oscillator actually fails so they
can e.g. replace the crystal. Additionally, this can help debug failed
batteries, since you will see "Time data invalid" when enabling
debugging.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---
Note that the following drivers all warn when they detect a problem with
the oscillator:

drivers/rtc/rtc-ds1672.c
drivers/rtc/rtc-pcf*.c
drivers/rtc/rtc-rs5c*.c
drivers/rtc/rtc-sc27xx.c

So warning about such an error has good precedent.

Changes in v2:
- Use debug instead of info in the typical case (no battery)

 drivers/rtc/rtc-abx80x.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 9b0138d07232..a8b0fa5565c7 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -115,6 +115,7 @@ struct abx80x_priv {
 	struct rtc_device *rtc;
 	struct i2c_client *client;
 	struct watchdog_device wdog;
+	bool wrote_time;
 };
 
 static int abx80x_write_config_key(struct i2c_client *client, u8 key)
@@ -167,6 +168,7 @@ static int abx80x_enable_trickle_charger(struct i2c_client *client,
 static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = i2c_get_clientdata(client);
 	unsigned char buf[8];
 	int err, flags, rc_mode = 0;
 
@@ -181,7 +183,18 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 			return flags;
 
 		if (flags & ABX8XX_OSS_OF) {
-			dev_err(dev, "Oscillator failure, data is invalid.\n");
+			/*
+			 * The OF bit can be set either because of a reset
+			 * (PoR/Software reset) or because of an oscillator
+			 * failure. Effectively, it indicates that the stored
+			 * time is invalid. When we write the time, we clear
+			 * this bit. If it stays set, then this indicates an
+			 * oscillator failure.
+			 */
+			if (priv->wrote_time)
+				dev_err(dev, "Oscillator failure\n");
+			else
+				dev_dbg(dev, "Time data invalid\n");
 			return -EINVAL;
 		}
 	}
@@ -207,6 +220,7 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = i2c_get_clientdata(client);
 	unsigned char buf[8];
 	int err, flags;
 
@@ -240,6 +254,7 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		dev_err(&client->dev, "Unable to write oscillator status register\n");
 		return err;
 	}
+	priv->wrote_time = true;
 
 	return 0;
 }
-- 
2.35.1.1320.gc452695387.dirty

