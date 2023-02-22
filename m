Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5162E69F38F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjBVLkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjBVLke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:40:34 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D47839BB6;
        Wed, 22 Feb 2023 03:40:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5LdaaEr4tKFLLvgfDNi2bHGslgUfZum87olRM6wOfGw05GjPCbriIsm722ZCMJUCU7TG6BrRa0TLO8dLhK72BQwWIihC8ea7C9O57FTpI+oDPzcufUJeTBCIsL0wkDChX6H/21n3rbHzzUwrE2h0JmIwAsdKg2BH417jPAZsv/z28oeHUqHVweUKH9bt41pR/Pdemhvbq9JfvIZsbabbzUUnjF+V4r1iC5BW/vyP0gyXfPZFQtmqDXbApX6iYUODzQ3+CC6uLdyPpr0WA9+Zo6zEMyWZqN7rGkyXd5kfTHIrLEbeOC3+BRFWtzM4b+MTnNg7Vm1NzzbNWMxi+pYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H492h3zy+zQgFK4gbKLUlUZchyTJd7Y7VmAgomkPmho=;
 b=cTCwY72yTXWPrJLi+E2j/aAsSXa3+mZ7f9HNSBUvSIoDpXN4H5JysgkSf51FerAd8nOGlb1IcLBaP8X97Zc8jIo8P/V+g6UlFFtOiNhGddhoY5ZT1zSJLt6WCWEic3ILXzarvL7GzLXFe1LKLNWrsGRhyXGJjqbiWUp1timwrsjDx0Q3+LcfeBZGXn4QGCUXqQXfdXkyENLNT55wsAT/P64eCObOCH4d8mhvT1DlUQW1LR6QA7o7iZ9JpQsFLQzZDJxu1TKuJB4yypA9UBOARkoyDB+oPIOQRAr+pKDzBMqdIa5gQBvNivfwJRZipt0mmpBaTsvcrjrDeqs9BNMNxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H492h3zy+zQgFK4gbKLUlUZchyTJd7Y7VmAgomkPmho=;
 b=jMzIg9259ks2Gl5wDTU89K4UhrUYXmMqHghs3JWk2aWXc6COK9t5Pfykl67o0RO8xPA1xwXFFzDa81lUddVkDg2lrLgijotBbDKn3pY1ax+T4QV/RotVVrZtsNYwxUDGHujLINyQ1R8q1nc/uSq6NGlzMGQ35nQN8vCnD9eoEgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (2603:10a6:803:46::19)
 by PAXPR04MB8653.eurprd04.prod.outlook.com (2603:10a6:102:21c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.18; Wed, 22 Feb
 2023 11:40:17 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::8562:affc:e0c:c610]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::8562:affc:e0c:c610%7]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 11:40:17 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH 4/4] ASoC: wm8524: Delay some time to follow power up sequency
Date:   Wed, 22 Feb 2023 19:39:45 +0800
Message-Id: <20230222113945.3390672-4-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230222113945.3390672-1-chancel.liu@nxp.com>
References: <20230222113945.3390672-1-chancel.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::23) To VI1PR04MB4222.eurprd04.prod.outlook.com
 (2603:10a6:803:46::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4222:EE_|PAXPR04MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: f3413fb6-69d0-416d-95a1-08db14c9921f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JYGOqS/TqkefrFnIgjIQq35lgPYF8yP3QtnP/6tV5jraXljyqCyVh/TYm+rVpC1/79kg2DB41NDObYR9UCyZDr9lKvw6iht0ED5WTi5UmA2Rm8p6jpknVjfgqQSA2amFuC0tUh+8f5Sd4hj4UaAmjP4wOApCrQP3Cvk2SqbqXUy9MhJSQK+KddQROsuoQ7xKlagHqAbldx6VnaldECw3cj2HZsUWgWpEQ2dU0eCWKcdCs1RhCFfQv3LM9MBU3GOdlyRWkkZPo9PIIug9dBUCpl8daDGszLtREOwt0ZvwpCxXmPq2uj6DIddgzfy0wL1CCeETTkNwGiGpe9yyj0Ao+0qSE1VHAYaLFt4IRuYh+ITcNnYwzuJd7vSZ2Gk8VNmhfpnnvDVPmIsVLKS/S/ve8OKMEeOtMgS6iEyBMsF+x1OhmPOJn4znScRtOXcUEyFK9Lmum8W//eyQgzCXhJnFs8HDJZt4BKBLMajPuqEfhfIw457EH3uvR2giMR2WDF8fcn9+9xGz1qarymm/O2HUxfvP8dGz51FpdE/0krISAjIJMiKAKxQ+qkf4zNy2hQ86rDV/wBiLWKrrUpmkMo6gC4R4Sst9PlQPcModPSRQ0S1zLVLSDZ97BWCsPysKqJLbkG0VhHJwQjmZhem8VwKJvnMMmNNHx7cE6qbGToSJYQG+P8tEcyVE3MYDoI3+eLn0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199018)(478600001)(86362001)(38100700002)(38350700002)(2906002)(44832011)(921005)(316002)(41300700001)(36756003)(7416002)(5660300002)(8936002)(83380400001)(4326008)(66476007)(66946007)(8676002)(66556008)(966005)(186003)(26005)(6486002)(1076003)(6506007)(6512007)(2616005)(6666004)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Ia/wQRpp6kWkccXPVI4IWDRGP+WGzaEqWmP7GcRvQ1Iz6UFMC0bATYZfXsj?=
 =?us-ascii?Q?1QXJs14WFpGwklHtlPZ6AtRV3cDuJ4WqjFR6dEufUY8rghRm4sYZ3nBskGBq?=
 =?us-ascii?Q?7wDZFuq2M0zrslEWNzcnCCpwAMbgND26oJ+aHopIx85PIUJiQrKHtfAa8Q/c?=
 =?us-ascii?Q?ORDllR7m68e2jYOv8+Vh7Gx/ywgWlvKkW5v7XX/ctextwhrF8ssL8MWVPJqA?=
 =?us-ascii?Q?jhaJoYmzhPLFWnnVQi4sU3h4gwu69Xewht5CkpccZcb7P3RSZ9e1sT8oCqQN?=
 =?us-ascii?Q?kre7wt4uJYWYg4zX7Zu5Wg1wXxGbH47Y56U+76trq5TgWh+QGFwKwAz9qeW9?=
 =?us-ascii?Q?JYZStGVlBKmnJhi2v1/e/Nf2LJUHGGdtVfWSScJp6j8olVnR778zQrYu5GtF?=
 =?us-ascii?Q?d+E7Ybhq2nE84daWW5EdpWMVBE9Bbveg+skb/7wkZdEkSdPRC5MjZcYMgaCl?=
 =?us-ascii?Q?c4HL7qflx4OiQjMWQVgpIyjixqb1KX5PM6ZlzQfm4N57phLFIRIG/QBnG6to?=
 =?us-ascii?Q?xHKB8vGANYfUXP4iOMER9MLxP1+PHBicp4iXvkpiHXgwFrvUfDTj4Agx4aPw?=
 =?us-ascii?Q?AZVYD2iVlnOHzWZ+j885N0QVTzStNsvNhKZ3LeDTDb9OPgPiRHzBJZ8tm/mP?=
 =?us-ascii?Q?vdsqrpLbAdRSHWCYdwwBNBGbSIZguKufiHdZYPbc3zN3YQpI2al/YDLZUuvE?=
 =?us-ascii?Q?SOZudEkuMJTjMp+jm+iZN3g6nlprbBnF6GsxKI/1qViVdcIAG5nuUNF8Zoq6?=
 =?us-ascii?Q?4rGkQ55AA06iAS34g1dNEu/Vubk0wQJUvk2imOwOZ5Y/Pa7pdmW283268Raj?=
 =?us-ascii?Q?jE1OrfvxTWr5LJQtVZtnSrJuS8WP9holnERcVJh6ABP569cbqnYUTX1No2uE?=
 =?us-ascii?Q?Swp9/cJOuAaqSMEBb9iKgX5KukCEuyyUNYZtyLa8F5s7Aka2dO2xAMMpwMiY?=
 =?us-ascii?Q?RH48hr6GB92Iggg/YgLQHBLrsBYQyeKYkONIS000AXZxkX9a7LwIoxx0wliK?=
 =?us-ascii?Q?u9zqVrwrmyWpQg69rRllC7EDN2ZPn53zNMfcGS4gpY1KxPDa9Qr3D4WxwMMH?=
 =?us-ascii?Q?l2COlH19Ye3CeYGzLlECwV952WbJPjqaBhK/glAfjCoeHv7jqlEM8CvPZnrv?=
 =?us-ascii?Q?pEPA7BpNI1E5v9Hk8FV8fsghdigawP7SiyDKWHL45tS64GFkcPGqATLVnyAK?=
 =?us-ascii?Q?25ZSHSlX6RwA/61PXzHbmKgKUl4Gz2RbX1pRHOkcATrILbwtMHFiZ28xbmre?=
 =?us-ascii?Q?K3wfy3ybnoUOpjd+DayfhfftNPnnHWOuTM0kZ8rmfoOvMAWiplyhcUs2yBdS?=
 =?us-ascii?Q?VbUYaBgHpkCOOjVThaf0UPXm6y/xyk2/050ZjkRz7Y7/eXPOI8ftsIJyHN7H?=
 =?us-ascii?Q?AlbFhY36YccURA7za3vHY/d5L+Au5w62AJyiOyhNxZ6QNhYr689mWp/uwx/V?=
 =?us-ascii?Q?zZLtlnaUHcxHmUVMt9sbjJRZnjDYqhHWJblIREx7uSXkK9PchtmWDZM4rKGS?=
 =?us-ascii?Q?2XKBjJVq88L1pdvOFHg9ZDQBVinZk0Yn3KurRTG3on2Fi65YzawAAblAzCrA?=
 =?us-ascii?Q?nbXQl2byvgHPmGr2uX/nwnGNXJFI29fZTpNQxXHp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3413fb6-69d0-416d-95a1-08db14c9921f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 11:40:17.7613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NuMNIp2xjQKVdZZjxMHBB9bvggRyh8cO0/S9oyQ197VQ23wpz/5hArDdJG0sAmjNtysW6HpI+m32r9ycmDSWYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8653
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recommended power sequence needs to be followed to ensure the best
performance. After MCLK, BCLK and MUTE=1 are ready, this device has to
wait some time before ready to output audio. Otherwise the beginning
data may be lost. For more details about the timing constraints, please
refer to WTN0302 on https://www.cirrus.com/products/wm8524/

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/codecs/wm8524.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/soc/codecs/wm8524.c b/sound/soc/codecs/wm8524.c
index 8f2130e05b32..f61967b66c3b 100644
--- a/sound/soc/codecs/wm8524.c
+++ b/sound/soc/codecs/wm8524.c
@@ -21,6 +21,7 @@
 #include <sound/soc.h>
 #include <sound/initval.h>
 
+#define WM8524_POWER_UP_DELAY_MS 100
 #define WM8524_NUM_RATES 7
 
 /* codec private data */
@@ -29,6 +30,7 @@ struct wm8524_priv {
 	unsigned int sysclk;
 	unsigned int rate_constraint_list[WM8524_NUM_RATES];
 	struct snd_pcm_hw_constraint_list rate_constraint;
+	unsigned int power_up_delay;
 };
 
 
@@ -157,6 +159,28 @@ static int wm8524_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 	return 0;
 }
 
+static int wm8524_trigger(struct snd_pcm_substream *substream, int cmd,
+			  struct snd_soc_dai *dai)
+{
+	struct wm8524_priv *wm8524 = snd_soc_dai_get_drvdata(dai);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		mdelay(wm8524->power_up_delay);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+};
+
 #define WM8524_RATES SNDRV_PCM_RATE_8000_192000
 
 #define WM8524_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
@@ -169,6 +193,7 @@ static const struct snd_soc_dai_ops wm8524_dai_ops = {
 	.set_sysclk	= wm8524_set_dai_sysclk,
 	.set_fmt	= wm8524_set_fmt,
 	.mute_stream	= wm8524_mute_stream,
+	.trigger	= wm8524_trigger,
 };
 
 static struct snd_soc_dai_driver wm8524_dai = {
@@ -213,6 +238,7 @@ MODULE_DEVICE_TABLE(of, wm8524_of_match);
 
 static int wm8524_codec_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct wm8524_priv *wm8524;
 	int ret;
 
@@ -230,6 +256,9 @@ static int wm8524_codec_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	wm8524->power_up_delay = WM8524_POWER_UP_DELAY_MS;
+	of_property_read_u32(np, "wlf,power-up-delay-ms", &wm8524->power_up_delay);
+
 	ret = devm_snd_soc_register_component(&pdev->dev,
 			&soc_component_dev_wm8524, &wm8524_dai, 1);
 	if (ret < 0)
-- 
2.25.1

