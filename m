Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D0474580D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjGCJFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjGCJFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:05:47 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2091.outbound.protection.outlook.com [40.107.215.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEA1E4F;
        Mon,  3 Jul 2023 02:05:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UExPwP9TUJxGUc0lz10IiAqhDWv7OOmOI1EKggvN8xoqqNqNMIzpklJ0fa60hTxfkwpmgNIgYn8E6p22rbBYfP+HPnX/JU507Vo3LXfsLZVoCeqY1tgOYBe0sJvXvZ5WW8fBByTj5NHp0epyPe0AeIgjCij55vT0u0pLSWwtjz8pa8GrT1vUDWPYf1RunM+RhXoz/1j9yw2S2YB3Id5MaD2fp5KnZvX9n+PzwR2Xh/5uhWkcFUbk9+sqaDBrh9cyKjqWaCKX19+NXIpPQcl/n10MifsIjqiUDDvAkSsEQwJnAhWsJCm9vXx3sFOi+0CcbZdhHkoZ2mOnlJY7m1tiyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzTrLLCsS8hWf9pHbl4ls2xtiQpiF4o81Aj2dajeQBo=;
 b=CbawsFPD0JGXTRAPiIqlPUBYFh1fpNVYKiQICperrV2EZ2oTDYcrMFZSCQxfLF9NSeT1GnpasJhbuytOdgBX3OzLzpxyHdMDJluDJwDdVmtjVHD9NVol8n0eBXNXMx0v1VKtFeT/gD38eu6BDx0y/7qFRRaFWcesDaqDg8Cme48PWU0n+EgjqqI/B/UkoEIxXKB20WG3HBVSF0hvNE7lOemR+EI+GIfy8SENVzBLA703UgTvRGpnMEVlp2xKVLV/4L98y8RQ1Yt+YwnZNlQ00nUCPsI/vfbNLkZHOiZJpEaPMKz3+M/efnVBPu+0u0cEOXXKLnri3+2//1iaBdKNxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzTrLLCsS8hWf9pHbl4ls2xtiQpiF4o81Aj2dajeQBo=;
 b=SKkBWrq1jH6+fq+lSJo9Sy9mYp7Pj8HUq5bo/kSrAQnNmsvkjATvCEDgGqpTTvKg2wNMqVjJVJn8QdZBWE9ez5ybXwGR1FnakEO7aXpcRtM41Y44hdver+yvTgAc+fhROwiTsBhna4EzS5LVx1LVz/mkRDSr99an81jgJr/dCMKee4HbYwS9HwUGmQQ6EDzhnVsakeojq6y/jTg7xiscOITBV1zZGDD4kyCGs2j/jnBa4lkO4+BXzcmlzI9LfUyCECjc+k2WctnyxVD9uSsdS5/VMZ9jR0OnUf9JtoOaqOFvTtmHxEmPO93vASBA7M3cPgbZKGg8KOKU3k82PIcm3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4003.apcprd06.prod.outlook.com (2603:1096:820:26::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 09:05:27 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 09:05:26 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     miquel.raynal@bootlin.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, tglx@linutronix.de,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, frank.li@vivo.com, wenst@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 5/5] thermal/drivers/mediatek/lvts_thermal: convert to use devm_request_threaded_irq_emsg()
Date:   Mon,  3 Jul 2023 17:04:54 +0800
Message-Id: <20230703090455.62101-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230703090455.62101-1-frank.li@vivo.com>
References: <20230703090455.62101-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4003:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f740ee-ed59-4742-b9e8-08db7ba4a43d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DvvG71hKtKNhUlpc+OpP2jVcnAoUjJDawXvgWggrrn/c+iO064n+TUtBEb4ZyC3e455+JJFrPdKHneHrQjelEyPPt2BIM35jJ/0BLqhrSuR5WXNNqbdUX6ECN6xb4uYF7u4K9A+m2xdTPiW+n6OIUz3lIUicqaoV6+QNLV41yOYXoTfcFLjU5DqV6edoTfW/Us9RfHEiAoBzez7ezqJzl8aAKPq4equg/fxwkXo3/I8n3ubGBftTkrh5O9+ECn3ONOvLNn5tungCRPbLznT1Xjc+7P+4fyLPZ/1PBkJvaSFWtzGJxZIQHPa35G9ULkh9tp/vlDxxi74NyhNaRxrBLmzRIdgkpKNgf2Obt+m3OBToLpxO4UlLeEeaFlDsgdf4t3gk5VhIkYT0b4HIGtuKk+DLmoYMvT8lcv+XFhipO0LA94ldY18zc8oZkcZjCx2s3yDTlWKYl32UgToH/Zd6Jyqa7KIXptECOx/Zu2brKyyfc44kuwXYAoPFAQS1DbNSPNMXqjbLpSm8wRsu4HuyNxDaPdgZete053Obvt95vEQovmbnPmO4skygCJ7MDtCE7tuSa+qnq7otzYoGwSHRg1ZIJDcTabF4mpON5nmkLYMPaS3sttaHnvA3a7EOD67rdryIhPDn5Z2WC11VYn3UhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(26005)(478600001)(1076003)(6666004)(6506007)(6512007)(86362001)(2616005)(186003)(38350700002)(38100700002)(66946007)(66556008)(4326008)(66476007)(83380400001)(921005)(52116002)(6486002)(316002)(5660300002)(8936002)(8676002)(7416002)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AlP49cWogshT7IMjJwq20YMrET1TehDWe3jp79Xpuelwq0tVXO2Jvf+zRsSi?=
 =?us-ascii?Q?BMJu3nO++nvopN/rwuyx6UAZtvdCxdnGpsm4fu3UHjA6nXkxipCC0800HPAW?=
 =?us-ascii?Q?qlICrkAG0jKDwrSwnPQt//It7wGjozUFGalRTDlE1dqUAxdF17mO9D6qF0Kh?=
 =?us-ascii?Q?R4G1W9Znh7vXlFuzgOuWuGx84EC2saKfdYINOKnJTBpxKVlnZvPyDxy7RXhf?=
 =?us-ascii?Q?+IkkXfkWRTTBPyYYOkl0HYhK4MPi/x4SG72HBAQbKMHpNwPCEtX9szVAT1zx?=
 =?us-ascii?Q?FnUapsSLS90wFWwll5qqh5qt9UkK0nuYAa8sKptIXQkhUy+Z87jjjYUoWFkS?=
 =?us-ascii?Q?raaZXQQT5TgvpnLF3O31eQZrZ3IXdaUIDEinQku1oyJljSp0y/1TgTA+/5OG?=
 =?us-ascii?Q?LgDVO5uVFJZ9VUM7hJdU+tIoc5WEhcENGo+aPL8GLpjt+7q/kBX3jlTMi4No?=
 =?us-ascii?Q?v5uekBV7hhIMLdTHY8FL5nDAF6a8/ZP3JgiZENVes3CzVgFv271nYNVxM1B4?=
 =?us-ascii?Q?O1QuVVr7Nf3SzXw26NE78vQXyjH1CcDWKaoIyVeIwAqi9q+utG4NVJrwOPkv?=
 =?us-ascii?Q?IHl/Yl0ABC0ckn9GqiBZ4nCWahkG1aTGvJzkyS1Ro7rtLFh6/UDrHu9VPFA8?=
 =?us-ascii?Q?JJvq29BbyhV2dbTORqdT6QOeNabrJIx/D6V83ShMGtFvT/PbRs4SLcmhyhWF?=
 =?us-ascii?Q?D4Yf0QfzSAV4U0o3v3bWn05fw+Rc4YAmskJR8nmUM/z1xgC51xTNSJASiHbp?=
 =?us-ascii?Q?8sijI3Cc+B5vvN0cviRh38hIuIELfVzQbV0HsHb9WSOXrA0PyNvV/IxHy0Ce?=
 =?us-ascii?Q?aqcQq7A2Y0Ni+JjMYYASlRI/80S76WTdkoyJOdAVaut6bNTzMKFscfE42ZLn?=
 =?us-ascii?Q?kjMQQ5m483QeMtgNV4ZaBGVc1LtcImkyYpTjzWAWzMYaXlmeiNo+TuQA/yEe?=
 =?us-ascii?Q?6kz7XAXdlfdfRy6cggO1mKeofci6vQVLOtuV/XBBH2KI4VcouLf7BvT2BsK1?=
 =?us-ascii?Q?GLnbcMt3UhxAOz1wkFI+NVR8FoLDx3pyAeLYR1GRKZNdXpq3AddgJM7XdNqD?=
 =?us-ascii?Q?x7gXdNfwV8/tv7+5r1Q2TMp5JPk/3rJ8ipgUvasfMlXMqCgCsRQsu7CDPz1t?=
 =?us-ascii?Q?UD6oxOg9VpeNsHe6xXtlgigvD9DB9g0V1gZC+4jFHdJj4n3FLIIN3GXRsXKM?=
 =?us-ascii?Q?XdxX4W879Q+5Zdenxs29PWBnylMFfpt2uueXYQZYU1CL99883E3MJePpM+jI?=
 =?us-ascii?Q?HQMTjq3PWrASFq39mrN9+s2sNCfCd9v6lotgfVSlIzANARcdNsh6NdlPTLNc?=
 =?us-ascii?Q?Xvrkm6VuAw72RC1mXBfbKFV+E7Py6lmE5T6DYv9z/3hjxWOxBNhE3qjt2ZSK?=
 =?us-ascii?Q?v/CCqNCMGMgA8uRalaYherzPDTzCjZsmlRtfMXwJd3kNGuKncCAPpW/e/xSB?=
 =?us-ascii?Q?eDBJViE6ShNsTJfDDC+i0o9gs4aNef6f47D7+jpTN3but6QIGBJcQQstEh0l?=
 =?us-ascii?Q?vhimJgCWIEMgdw+5dLTZ/jPsLRU5CmSEGGaBT3gGmFOG8g50liDxLY5aXDE+?=
 =?us-ascii?Q?pJVfbH/FmlI6rdhZeUCWKJ9wytRO+PG/mMEqV0Zo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f740ee-ed59-4742-b9e8-08db7ba4a43d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 09:05:26.4851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2rcRdXB5EyvNvlrVkT4GGC42c2jeCicjYzruu3+zMsy0AFDjdSPTPfQL4Ep46p5/iYPGhL6EaqFoXP5N6bA+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4003
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more than 700 calls to the devm_request_threaded_irq method.
Most drivers only request one interrupt resource, and these error
messages are basically the same. If error messages are printed
everywhere, more than 1000 lines of code can be saved by removing the
msg in the driver.

And tglx point out that:

  If we actually look at the call sites of
  devm_request_threaded_irq() then the vast majority of them print more or
  less lousy error messages. A quick grep/sed/awk/sort/uniq revealed

     519 messages total (there are probably more)

     352 unique messages

     323 unique messages after lower casing

         Those 323 are mostly just variants of the same patterns with
         slight modifications in formatting and information provided.

     186 of these messages do not deliver any useful information,
         e.g. "no irq", "

     The most useful one of all is: "could request wakeup irq: %d"

  So there is certainly an argument to be made that this particular
  function should print a well formatted and informative error message.

  It's not a general allocator like kmalloc(). It's specialized and in the
  vast majority of cases failing to request the interrupt causes the
  device probe to fail. So having proper and consistent information why
  the device cannot be used _is_ useful.

Let's use devm_request_threaded_irq_emsg(), which ensure that all error
handling branches print error information. In this way, when this function
fails, the upper-layer functions can directly return an error code without
missing debugging information. Otherwise, the error message will be
printed redundantly or missing.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index b693fac2d677..b6403bf2300f 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1148,10 +1148,10 @@ static int lvts_probe(struct platform_device *pdev)
 	 * At this point the LVTS is initialized and enabled. We can
 	 * safely enable the interrupt.
 	 */
-	ret = devm_request_threaded_irq(dev, irq, NULL, lvts_irq_handler,
-					IRQF_ONESHOT, dev_name(dev), lvts_td);
+	ret = devm_request_threaded_irq_emsg(dev, irq, NULL, lvts_irq_handler,
+					     IRQF_ONESHOT, dev_name(dev), lvts_td, NULL);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to request interrupt\n");
+		return ret;
 
 	platform_set_drvdata(pdev, lvts_td);
 
-- 
2.39.0

