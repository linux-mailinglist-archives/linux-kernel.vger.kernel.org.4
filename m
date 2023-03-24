Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D6C6C7E32
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjCXMkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjCXMkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:40:51 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C318A206AD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 05:40:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQHEP3AG9UftdEXQeZFhAXTUlWsZD3VUdC801Gw21BpuhCW2LECUf2QeGXC2FXURqzPEiWuCkjcvccNokM+92/yT2VLj4zljjejPsEcMXRcWZ7R+halLKy1YJI4yvMbgNBEnns/LQ/YFfNEZ9Tb0+CsXos9TbsZF5gjbkKHEc1m1Zaos9Xl8gEbB2cyhtHBoNMgw1QqvLDz3wclwrwbVCJralytbRUdjj1rkE4K4NDqwmAg0ZmKKUmeGcm5MImXEQd0j9v8lck+26QFltpGlCEfst9uTwtoNjSq+RuZL/Gvz5mFA1tAirw23/tSnCZ/5qORNFjtGwGWt+zUSvVnhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oiEE/Se8r5+8USjZJ3+s8fYimwB6HJy4aLNW7gkBhU=;
 b=oSuBqrE2/B5w87ufYxWa5JUAf5mAVXVXWiX+V7XuKWLgupDQQ1M7FZph1hn79JyLzr17B6jWQNHrMJKgtg5oqRPxb7Jv542FXZCZlUPcVf8toGxMipXEWMueicA8G1iBpOLONL6tg7s312SeDND0+qVnj4SmeYTpRAp8x7rTUqLi94Fs81D30w3ZBbE/gSvPCCuORFXwd/LST8HIcPFJLFscC2tlqJJWelqeT4ONXfUAGB0IUB2g/QIuVMs4prrF4W22ogFrP4XlFJofF/Oh8igAIi+s05NuM7GXpYnfBEvoglm6y2a3FxiKZXRwYR8cvCuMbQn72RFmq75JFGl3Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oiEE/Se8r5+8USjZJ3+s8fYimwB6HJy4aLNW7gkBhU=;
 b=J8fi+5b7ooxZJRi+LEi1AYIO80h8eUeY1vNMwHypLgTwHJjuWK8iVKJYbeUi3TZ49UJOH61uy+O1fhDaB34QcCrdDgnEpku3bVal0gg4Fo7yqgZ0NKOnJK2sVZtOSD3D3JRmV8yQ0Sw4hGg0AzveouH1I8G+b6emd1erObOtJi0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by AS8PR04MB9191.eurprd04.prod.outlook.com (2603:10a6:20b:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 12:40:32 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::f922:7fbe:d027:5597]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::f922:7fbe:d027:5597%7]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 12:40:32 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, lgirdwood@gmail.com,
        vkoul@kernel.org, daniel.baluta@gmail.com
Subject: [RESEND PATCH] ASoC: soc-compress: Inherit atomicity from DAI link for Compress FE
Date:   Fri, 24 Mar 2023 14:40:19 +0200
Message-Id: <20230324124019.30826-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0003.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::16) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5151:EE_|AS8PR04MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: 244cdf18-cb3f-498a-f1d3-08db2c64f50e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i6axiU4exLIRyNWaevPiLxR2iLI6X7Q1kCCblyTfgBxnNcIORZ85I2l6Y3W2Mb1w/1DdACRvdAfkXkLFBPqQP8880Mr4NUh9os8JjWHTAWQwDEGpymwrWjXYh5aJ4nCXNQzrV4lTI85fZfjtBTENnRybuiD7SqQH+zigY1G3P0fa5s5BtxveLHZ8dNk8Q//QKvySOnRJUdB3DSmjYq8Nf2c4+xmyC3nTsGshnnUM4o236h8+T5y9aNHtPLVsrvcVc2OdxIVAmAtb5GdGze2wErUCsUf6L82w13YZKc8s1XhOntqW9ockDCAztRAWGYZqkrwvqaVtoHbw5ltpwXXnJ8smLfu+pKKzhS1m9HHGU0QaeI5QbnQt9qAZ/xSF+7R+B4XsOma7pWMFiEXRE5JHWSqJmJOd0QFii/FX1ySWLMEb75yIZtq5Z3XuvGGpshYibQmaQBTV3ypuNLpMEYsZI+/zKQ2R6XcUh4vVFRwjNRXgyxvPvtJB51by9Xt8XR2g0NfSjjuxFpfw4Cimxj0prusVI49n6IVAwv299mED52/o8Y25HWO2+lWCBe77PjLXRxvGJ68ACcw9EUWla8UDYxzjoGoRDeRl2dOTi201XpF1AIXo0djQG50nQ0qAcVx2ok1intfxyJWGTOMh0R4IqciuZTxkp5soBo2KxMhFbocn+YIc7f9uSaeDgE3LehJDUOjlr1ZtAd9EGYbpkCzlcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199018)(38350700002)(38100700002)(2906002)(66946007)(478600001)(52116002)(2616005)(186003)(83380400001)(6486002)(86362001)(316002)(4326008)(66476007)(8676002)(66556008)(26005)(6512007)(1076003)(6666004)(5660300002)(8936002)(44832011)(6506007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hfl7bTWcNLLQP+vZ8J1Jwd4XCmjdtDc5CbP4eHRzEro2dlRygonODss1TGvR?=
 =?us-ascii?Q?xQaZILzruPk8NuYK+LZQZGq8AThFOJ2e4BNbgdecg0/gxRx+wYz5slbJ2A3C?=
 =?us-ascii?Q?viqex1hURDPhD9HF/wc4QBbBadic5zgJ1e5Wkr9EYw/3JnAxNeIDbnj3/CHA?=
 =?us-ascii?Q?EQ+7E+ft6u5+O7iTXZlBKGB2F1K+TyveX4puD09Pb7sweR3E90OiuBjy21vq?=
 =?us-ascii?Q?1to6bf14zUiZaI0a+ElezSQVu9o9Mk+MqSy9nrmMvB0Fc+AvO8wYZphRCj/s?=
 =?us-ascii?Q?M0wu7SwiOcW3eaHIU5lISSwYqds1fT4f0vNCTOELRAaPNQElzsYDSxgHQunf?=
 =?us-ascii?Q?KZytlV78A/Yi9bSC51WUVYIrVPyTJFdhCfkOjVxQQtl/6oMnnrEIJaZ47s5k?=
 =?us-ascii?Q?f62dTXvBwRuIis+7jGETCTis8yl000RX8u0ylv0FCY82+pe9Pc/G2fVD2hsJ?=
 =?us-ascii?Q?kHSpD0ZR8D8f0PTAJlatY8daeShKi9s0R5WbBXsBC6sG0+Pp/lF6eNl4LuR0?=
 =?us-ascii?Q?g/mNpH/BrtRB4+atpYiVtqV4hoOeEERgTP4IeeGCvXuMR75cEgwMtZUHrxri?=
 =?us-ascii?Q?UpkNwT6wb6YM7p2VCEbBmfMi9kgA6h3eL6xsHUBEYovCwCRgWo4cjN/d8m9n?=
 =?us-ascii?Q?2FmGRRpKGwCF0k+vOzz1xE3FQjIAGHniNC7ttR1bIP4FMBD4qb10oKCnpD7j?=
 =?us-ascii?Q?g+yMAZIeJoWvK59M5UOvGkmZRwEbZm80jpab6m6W76h7nmkJ67nVyjLP+TIx?=
 =?us-ascii?Q?jyJRE4MTCvZokD+AwoHjqaAKJsNy5nxkzokQBBsKN1hli/Ozyl3MByGoq4lR?=
 =?us-ascii?Q?TEADUF4DtifW0tNtHHnWNWGTB7n6EOxb7IZAkz1ju06ktg80Xk+TkRj9c0iJ?=
 =?us-ascii?Q?bIaW4iyfAKARBgJvk/2u7nRZ5JZbb9XWEnwjlm5v9WnxgB6jysyduuDGsUls?=
 =?us-ascii?Q?MdLRZmEfo2TTX5BiKGHuLfaiDkKeLE4O0fQNmNeWEk9aZXmmZDufhn4v8ap0?=
 =?us-ascii?Q?eukMiWa9zg30oyh5GBHQu1xqxnhva5StTD2NSOHcf5xwkc75wpvWHYAlLw9v?=
 =?us-ascii?Q?zQXF/GjcHj0hwrqMbjlg6Sq+zkciZXPssg1ArKtQdWcTu+mY+KEH7vE8gAes?=
 =?us-ascii?Q?2nkDo39FLS/TDT5SINd2+KWIvqIXDvl8S9h1Ml6dKPCsqWMt3t+UBv5E9ZjT?=
 =?us-ascii?Q?DWdiG0E4SXRPZRPBrAanr/3xvDJx59doHaVXKRU4sNpb4u5orCDrvQ+O0ph9?=
 =?us-ascii?Q?nOnNUXlbb4GlNNsBLjuS8yr5WpuzXEQI5xaS/zSCHPCgTJJ+L/2tQ/EDAHuj?=
 =?us-ascii?Q?FzqXCTmbmlkaf32/SYrOZ4XJ85y0GZyPsxsS1Um46HbMhMx/9/gNoPwXBQKc?=
 =?us-ascii?Q?rZYYVAPnlVWqlmNnsu60j4Ebw16hA1Ti9aWt7Mynq1LCJhZ0q6PSNRZ/xfUO?=
 =?us-ascii?Q?lSRSY7yXaKzazEigl7okeFWPeGPpnPL9UgFbLjrwJvEkZmg6Jw/lSARRsaB2?=
 =?us-ascii?Q?ThHEx0QCkuU3be9O7JRtZZ/tLn7jlnXoRYh6QwiVPhhCvIgbOUJYVNL833/u?=
 =?us-ascii?Q?xbZ1hjvdtCDMGr93Qpx302RNC/5q1w4sYTVI0Dbxwxd9R9zwXLrHSh4rtZFr?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244cdf18-cb3f-498a-f1d3-08db2c64f50e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 12:40:32.6555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiPD0if0E5PP2LFd6QF7uHflDqMaNWE1fk6ekX+CnS5RSkAoIFU1jOuXdrVJv9ejdEYNe5wGtl3MTcnd4TRfwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9191
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

After commit bbf7d3b1c4f40 ("ASoC: soc-pcm: align BE 'atomicity' with
that of the FE") BE and FE atomicity must match.

In the case of Compress PCM there is a mismatch in atomicity between FE
and BE and we get errors like this:

[   36.434566]  sai1-wm8960-hifi: dpcm_be_connect: FE is atomic but BE
is nonatomic, invalid configuration
[   36.444278]  PCM Deep Buffer: ASoC: can't connect SAI1.OUT

In order to fix this we must inherit the atomicity from DAI link
associated with current PCM Compress FE.

Fixes: bbf7d3b1c4f4 ("ASoC: soc-pcm: align BE 'atomicity' with that of the FE")
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/soc-compress.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index e7aa6f360cab..d649b0cf4744 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -622,6 +622,9 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 			return ret;
 		}
 
+		/* inherit atomicity from DAI link */
+		be_pcm->nonatomic = rtd->dai_link->nonatomic;
+
 		rtd->pcm = be_pcm;
 		rtd->fe_compr = 1;
 		if (rtd->dai_link->dpcm_playback)
-- 
2.25.1

