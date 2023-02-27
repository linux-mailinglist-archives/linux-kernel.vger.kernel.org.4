Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B67A6A3E38
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjB0JVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjB0JVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:21:33 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37F91026E;
        Mon, 27 Feb 2023 01:20:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROG2uXFLgXQljAsFib77VvJiNWbv1Z1sNmjZ4y8oq66gN/5snQP0/eJSz5s6U9suIwhCIss6B164zGiwolFAxUsdw7HT7nM1mp5WClKJqe141xMCbOHcNVmltCppQEHDChMwEz9bXgiS5BFRBNYtbW0tJGMS0v053WVfFqgdR7qnHZAhIMCGALaqvocq3f11/OyglRZHeimYrLxxF+9YGQeZFdXc7ir35DUKnJAhYMbtCYc7VEzuOdJh1BVelvNRJL+eIYQLtdBFw/PmWKp/c7FmcgIFQABDaewp5UF17lGLTp3bFmjIKQKzXlNncFLsY3e23bOJaBGULZrzAd8U+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8B2Ks62e7FIWpo1ioxvaK5qmzWqJzcSAZC0XDtZm++k=;
 b=HkPQrDuYDgT8jHAp+6iGSmzAckl6KWTP3IsMHVATbsbkBSBfvkRf37KBPcfmQ058v+w01OECElE7HMZ3PPIl/6sm/8fYA5caJdwuPag2oz2kf84BfE9PgNKD29m1VyDndoiJTkaupZyzy/6onUvqp69+/bFrH00xF7fbyYEGSg7+lDviAVT9qlLkM7Edczg7fwKicZmeCF4AXO0iyKwAHucdgm4fiNkJNMLMss1Yb0Yiwcxcv62fVMY2pKMDSr+qNJvhPWckah0L/4HMT/NQB+wSgVxYpauywA3THu5ktxSYtZtf9DzPHkg24MwoogjSrmYe73q0JE+7pCtuW6GKXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8B2Ks62e7FIWpo1ioxvaK5qmzWqJzcSAZC0XDtZm++k=;
 b=PzVLI4SxoBHf9xhprA8xRVIPZ/ao3KSGKEyy7uJ8F8kGgOdrp/3wbHSGBK4zmB7ZYqJVZiwD+RZouMgSbbMVfdnQwcoPsMt/dhweGwadH1N9s98oiYaQm3a3ETLO/57iRmjLOtMYof4nMimaAKzpn5QBq/UDLDmHxd6CkSv2UJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (2603:10a6:803:46::19)
 by AM9PR04MB8922.eurprd04.prod.outlook.com (2603:10a6:20b:409::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Mon, 27 Feb
 2023 09:20:09 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::8562:affc:e0c:c610]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::8562:affc:e0c:c610%7]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 09:20:09 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH v2 2/2] ASoC: wm8524: Correct the MUTE setting while power up/down
Date:   Mon, 27 Feb 2023 17:19:38 +0800
Message-Id: <20230227091938.1671416-2-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230227091938.1671416-1-chancel.liu@nxp.com>
References: <20230227091938.1671416-1-chancel.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0206.apcprd04.prod.outlook.com
 (2603:1096:4:187::21) To VI1PR04MB4222.eurprd04.prod.outlook.com
 (2603:10a6:803:46::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4222:EE_|AM9PR04MB8922:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2f33a0-98c6-4a48-c794-08db18a3d228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j4Pzc9GB390ozY+diSiVEh5rYFBHoTb23eeD4Kd/jxfdeD8NPxk5Kd5SigiL7Zfyto6mn5v58PFG8tkVPN4QoiOI4sBtaTyhJ6Dbj3ATQjhKKoRfRR3MfaC0lroPrf3aeKjyjuKoCKvXbbwP289P+w2Sm4RYCOwE0oCy1lN7WhvVW+/bLt3griN5OWGUTxp2g7BbtRWh/FnZwNYE3uFTEU7Cjf1vhbzWpuL+eF/MQqG4RQ4e5JrbLHDLIhyfi3Dm+ak8Uf3QnyO6yH8KaLRIQsbZ9aitcWS20gOuFsq1OxEp8I4UyspEWVuBQhbdCrnOM7SLvExrF2FSbXPqloLsAzyFwyDWIzaMoKEziY7vJCeBuqI/N0yjBOCKnGHlQQDI+kRk3DacImy9LQ90lb9vNSD28hvaqNTwXDJ2hryMAUmMrdW7c1Yv5hZ+58pyi1ii1/jsm7hH86EhkSMgFVfOQwuP7DPcf+9yvkyGrFoZ2qhdft+e5y6dH+sWtaCEly8kFCnJg8JFMt5eYfP33VKzVI6BgHStzdIfPAw/loG4Pz8pmXC3IulAcd3Wfihn1cZC4fqnCuy5z02GPbVTcvlSCo5aDPRshEcD0aHu6W2aHGI6jr68FbvxofhG0Hfj0yzPLtUEq+k8US1gL4Z4itx8DJqLDtaZFcpDE3OjtDz+8Ue24yfc8j7Avc1AdSFICd1YV8uKpkoIrYQOMI8x0U0ZCk5MmSQVUSZYLJy79IAcGGw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199018)(66946007)(5660300002)(186003)(26005)(66556008)(8936002)(41300700001)(66476007)(4326008)(52116002)(6666004)(83380400001)(38100700002)(6506007)(6512007)(316002)(1076003)(921005)(36756003)(6486002)(86362001)(478600001)(2906002)(2616005)(44832011)(7416002)(8676002)(38350700002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8DAsVdVOgXwtZ+4Sbwk0Efs0v7SdN4HDmYjyHp3DxcJolzWcAJQaqhStWBkp?=
 =?us-ascii?Q?EKOkiFB5131aEBCrbksmeUxXmQXAMx0Y3TEwbux9ZJvG2Zf0MD9malN3miCD?=
 =?us-ascii?Q?7a2tbTTnufO4NwE8Sd09gcKsMiwzyLFnQ8iMM7wwJwj10o5X70nKcV6ecQjQ?=
 =?us-ascii?Q?jEZNZ06GknVaT17Z71a8W+Y1ls4hossGXlyDOIZUjGI/FyQo3j6TUUbwp7BX?=
 =?us-ascii?Q?uX62AB1SbDou8VT3qL8gJz0PrjLvb915a2kk9lqDBXaJ1W2FEi5eO/SYCYFA?=
 =?us-ascii?Q?RPGlL905+oG2yeeyftwVousXYGITxQ2p5b9L3XvIAWhY8wAjCDEPvFuESgSV?=
 =?us-ascii?Q?fwecXce4q3YmSy/YRfzJExv53D9Q2uhz7Bk6aW5w0nf/5XaotepLitevHK5v?=
 =?us-ascii?Q?lVgwGeaBRTQURUOt4Jv1/QMykbBJb60Jjbv3QCzIC8/6LaDeaw3BOGJGucD4?=
 =?us-ascii?Q?4EtQkxZW54rJuqjvEAYgKipd8/62jg5PvQJKBTfuw0/LVbpYJT5K7JG6/EW/?=
 =?us-ascii?Q?s0x8gW2VWnwDL/k5U2aXIirkjVqWu1hMH0KIB/5bMDw97TABuanZr+9oIrjw?=
 =?us-ascii?Q?9fmXLNfjzhRYW9oex7wQ33n8MrB83KBEJ2IjjamzfE30XvMFO36G2zkH3iE8?=
 =?us-ascii?Q?k0RBJI/s0R0hJ/BX7i1BANFDAZEJTlWEBdHU6fNZDQOecgta/TjqkrlhQySy?=
 =?us-ascii?Q?p4KaQA2oh7MCRBAygGkBj8R82Uh1UxMAHiwHylRuxOiymwKq5fXj59wRei8k?=
 =?us-ascii?Q?AMITW6c58C9a/NxE4uH1jeeLf69rAI0IGY5t6KS3rUrd5ZVPPUDzEYztA1Z0?=
 =?us-ascii?Q?wpVC5Ba47cYGhlXieguWDkocOaCy0tjiWFwXtepVa8RszUrIsVpdOB6YPvcD?=
 =?us-ascii?Q?qZuZfC3k3ugiUtD2GAPWpqV0RGiGtLxv3HWS9Jv1Vtr7qPWTNKu4g6ezPsxv?=
 =?us-ascii?Q?1eFiyV9KGWhxlS9+NP3dslJaVeAC6BQUdCFLvqwMC2iKB/YfAMChpnIWQT7d?=
 =?us-ascii?Q?PJ2x9Pm4VDu+OSz7mfKsIhqvlJlzo29+47FSHnM5fp1n/1FS5vpsXqZAK+wp?=
 =?us-ascii?Q?MD56jXFsPq5dSyNJifDRh5l4r9sDDP8bxqv+W6s6wU5wW/qx8+VrQtbCSqZ3?=
 =?us-ascii?Q?y/c8jY4D3fvT7Sk58OGArtQbZ/mQOD5/s/HYD2rutJLUiwNXUGHBTGkD8Zh8?=
 =?us-ascii?Q?LRQ3I8Y9pr6v4E+9KyQx7aWhlLvgxbjWQHGWBM6dDFy6oZMKBsr1wvwQ2wyT?=
 =?us-ascii?Q?PAhgoO4yBG1q0QGqBmS6SnpEeS3LnhNeO/7T8jnWhFGMj2CjWqEjE1uoBEQU?=
 =?us-ascii?Q?BYDCG2hriN/JekNkBFF91jhBYVnt73TK0FgogLZq/TRgbI9+yH/MWNj1JwsF?=
 =?us-ascii?Q?Nf4roYbY4IThvA3I6Bs+WsouXWcS7dUs8xq6+4zChttE9jwTzBvlyIcibkmL?=
 =?us-ascii?Q?nomtj+psZYvJnVur7jpBIZ231CqgblNFrY3XrajlXVxNObPVDnWwxUl/2Kq6?=
 =?us-ascii?Q?On/ow/sUX4q57ouY3byrfwk97I/QyN6ukj7c3DQDFK+YXvCxC5FJVfjy1HMa?=
 =?us-ascii?Q?YOWlU9zwX/Bmib4bv1wMh8gcl4a2Qzp+IMjcjhYD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2f33a0-98c6-4a48-c794-08db18a3d228
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 09:20:09.0805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSrqo4btNMfdbGig6x2dv5A5q3aMp9KAUkeHZbFbRjVtt1NGMDN8zszMJQt9hWGbiRHjoIt0xZH6vHQUau0QaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8922
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wm8524 should be unmuted while power up and muted while power down.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/codecs/wm8524.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8524.c b/sound/soc/codecs/wm8524.c
index b56dcac60244..8f2130e05b32 100644
--- a/sound/soc/codecs/wm8524.c
+++ b/sound/soc/codecs/wm8524.c
@@ -75,7 +75,7 @@ static int wm8524_startup(struct snd_pcm_substream *substream,
 				   SNDRV_PCM_HW_PARAM_RATE,
 				   &wm8524->rate_constraint);
 
-	gpiod_set_value_cansleep(wm8524->mute, 1);
+	gpiod_set_value_cansleep(wm8524->mute, 0);
 
 	return 0;
 }
@@ -86,7 +86,7 @@ static void wm8524_shutdown(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct wm8524_priv *wm8524 = snd_soc_component_get_drvdata(component);
 
-	gpiod_set_value_cansleep(wm8524->mute, 0);
+	gpiod_set_value_cansleep(wm8524->mute, 1);
 }
 
 static int wm8524_set_dai_sysclk(struct snd_soc_dai *codec_dai,
-- 
2.25.1

