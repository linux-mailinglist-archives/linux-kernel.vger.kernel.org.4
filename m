Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4250F6DC516
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjDJJ1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 05:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjDJJ1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:27:12 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2117.outbound.protection.outlook.com [40.107.114.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876702D73
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:27:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iv0RzviMy4+hqtMGc5rEgZATAfm5IzRwYxCFmFLxR6zDn9wE0kSmPw2rO2xBzaFEZEaS4Jyf1F6ccpOFVt7B3nlplARKnQR8wJUvE4lhSIX8PGxlm+izkpJu5RXq3UiTkJeda9objAQ7tOR4v2gB6XGvybpDEDbVVNVq3PFfjZcpWh67FQ0uhOaHML9qiwXoyKQUqNFKKQKafrLvIMOK/98J+DhAKOvVg8tKfjqH9ZRz4r4zDkQFjM7vSXL+i5qGdATGTTSPQs5dOMYgpkw7IopP9fhVGb+6JFDOPV4mmUtTz0qVUMa7W2cpvQhAt+9eDocmAhclVvm7sql5tND30w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQYtdFRe08i2S22y4qMfLrN82hUCgsZlx1jppiJT7Hc=;
 b=Wp1myHu0z5L5bl94e/wXqtsLq5s3ubsYO6lvuHLAEa0VbmXaVY47CDBIenlSKl+e01de9lkGLwRkhOHfFouAYI6ooqE0Za3kLDJDjqx4eQFVXMaVnId4pQxsIz2+wmhqwtmMDmYkySFojRFcnM9J2NarwvLStc052o/MYodeI/Aod1CzoDCcX9iIq5atHLKkXDPQDXOb84aLyoIgFAu0+XlNxNc1qtgpumubHXVXg23LQzbLvSvj9dGl9rODphrxHN4xwFbCfupXKWNJH5XOkIQBkuVnZR24WQh/vpb+/dhQwPycwgqMIs2ePv7a7+SjKPjw5397OvTqboHjhUOw1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQYtdFRe08i2S22y4qMfLrN82hUCgsZlx1jppiJT7Hc=;
 b=P+OLII6eht05e1oQZ2F7zF24H/sYpz0OmgthqgGrDrQRi0YMUzM73O63L9Ucjtzl/CmV/QomqURgq2C3aP4aMCdjdFMMQz0nJAzqCvuBjmPtIQtHM1AOPptglpa7gcjrchSwpP+wSsEaBFuv9iPfs7QSPCKTeG0thU0kqCr4af4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com (2603:1096:604:10b::11)
 by TYCPR01MB8659.jpnprd01.prod.outlook.com (2603:1096:400:15b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Mon, 10 Apr
 2023 09:27:07 +0000
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::75a2:f32e:d86:4246]) by OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::75a2:f32e:d86:4246%3]) with mapi id 15.20.6277.038; Mon, 10 Apr 2023
 09:27:07 +0000
From:   David Rau <David.Rau.opensource@dm.renesas.com>
To:     broonie@kernel.org
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, bailideng@google.com,
        groeck@google.com, David Rau <David.Rau.opensource@dm.renesas.com>
Subject: [PATCH] ASoC: da7219: Improve the relability of AAD IRQ process
Date:   Mon, 10 Apr 2023 09:26:34 +0000
Message-Id: <20230410092634.4870-1-David.Rau.opensource@dm.renesas.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0170.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::11) To OS3PR01MB6641.jpnprd01.prod.outlook.com
 (2603:1096:604:10b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB6641:EE_|TYCPR01MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: 967f3224-5fbb-4779-107e-08db39a5c0ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zxz+ovBL6dnbG8ekZqHnkqxMRc2w21WFA2zG7YbFLIfj9NRDACkENLKfVJjkchStJA/0uaKcU/g1X7L1aaYrVoP42jHS/t0H4/owBjSR/HY7qeBePDU74Wq49rvneb1j4cVW3BYW8Mj4/ayxZUL+SGcijtXWR6t0Q24iFdUpUyV3Nipe+joFawozj9oeavegCCM6+UpIiCCo8ScJPxFMqLJ1QBNkxT7gi/4E8OjB8rjzslL8TVDbpptk5PtJnRpDQbkto5+o1t3UrxUokWkGfJ/ZlMT1LgFms87SRoxmg77NmPXd+TplHUS2ccQ2mH+JOznNmZ2E/z+Y1/piz/ZVP4cGQhHajm+jh6w1Lz+B7CNfQ0pRg7eNtWiYvE7TEi8hogWmom5n3PNDQHC5ZCi8agPDGFHhMO2u5xn8cnZ/tSlZaS65CyHPWtoazSCHxzbJ6MlUa5R++JtfHrE4AC8+7HdOklh4+swTyGX6Bn6qDDAqrJD/zVKfM0+gZclc5ue3KezHtICGWDkonAI9dCrC9kW+/RZRiPQgiXRuyNzxLAXW7c1Gml3FHnKAMNKatABjP1/15jB7T5defWq+Skt5BDCp2YJFGx1kCyYu8bV6GoQKH/ZjQVdLRnH5sNCDppCz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6641.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199021)(52116002)(478600001)(86362001)(103116003)(83380400001)(38350700002)(38100700002)(2616005)(6486002)(6666004)(2906002)(316002)(186003)(6512007)(6506007)(1076003)(26005)(66476007)(8676002)(107886003)(66556008)(8936002)(6916009)(5660300002)(41300700001)(66946007)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?458IVzlZZpNgDmJc6CtheKRc+E5KXnmexjgbBnZoZJ6DS7R6MUg7uDUPnDfN?=
 =?us-ascii?Q?4oKlAfN9I9V9IhLYXi8ZfxO4LgRkvCnaXuqnA3F/gAK64kH+d5qC3llvDJEe?=
 =?us-ascii?Q?osg25At3DJMw6z/DPfVJdNSCT7cfEZFZ8PKpHXKrCAbswcPIEzm+3UnFKnYY?=
 =?us-ascii?Q?7UzhgfZm4xgmrDI8CZSvwOpY1oc29vPso1CWK3uKaJ4cgzVYlIkEiHZRaORe?=
 =?us-ascii?Q?WuaWLLmjLqXKXVRtvbptipW08oxzJtmfmXcSq4HEfoaTJs92NBTeyeRZTOEX?=
 =?us-ascii?Q?YWQc8lFtY7vXsm1h92EYElHB9BecOWg7Q20hBA/qW7pvIU4+/Jtge0nv/voU?=
 =?us-ascii?Q?qgwmr54OWjAFEnSZXMZAnau7h2lbm60T84yVjkuza7wO2CjVrZMJOeOeNmFH?=
 =?us-ascii?Q?Z0RXtniYQ+1dxIQhsObS+FvcvCU2O4Qle8ge3WZJ8nIzb4pq6dVwSSU0pToX?=
 =?us-ascii?Q?7FCJWKOysRj65Tcn+S6duz97AxHnF14OTkPwRLI7UwgBpu5sNgvRrfupRXue?=
 =?us-ascii?Q?IxzxsOEO0aFYbgDd2qvXwXjmFa+dyWk2MNIp666/ja4hybdWuRJfMROqn9Vj?=
 =?us-ascii?Q?LeV4Mx9HpHUmUc1dG/hfwcjq+Y9v6v7AdYecJsct0Cj5/8kcYupWvT9D4gDw?=
 =?us-ascii?Q?ik+ympmO50B4JRN8Yc4Zkk6axaqxKcReyTQPr758syw9vE+DZkpras+yOnSv?=
 =?us-ascii?Q?8Ndx8tZZsdZp/7gynxdQ6n4Y+dMbq8KvS7X7dsTSA6VACDZHuK+8k2Lz7YY4?=
 =?us-ascii?Q?0K+3Qsc8+Uue9hxbYkogTmYlOR6cQKiTs3fwI10/DySDlmzSv9hfCnUDQQaQ?=
 =?us-ascii?Q?XtoxkbujRdEpZgyIGJ9S3OasZi6dxrhIrVEwuPGF25gDmcfwk6XV5P4iX3om?=
 =?us-ascii?Q?cyDL4SIjH+PvT/w65hTj7gQ04vGz3Lf2t5iHbjA/NwzxnGwGn8SgdztkkzO7?=
 =?us-ascii?Q?ltXCbKr5ra1eK0Koesb9JWLTIW30HXUvvvb8zyOIX3B5/0QB0UIlzZuCCrwN?=
 =?us-ascii?Q?Bd4ovHmuVlQdL1EblUoBFe2FkQ3bnRKcWQh78EUe+nGWjjjKLWAyTZRX4VT3?=
 =?us-ascii?Q?GtHFY8D0NOr9mR5Stp3QCTVcpK51AYlEOB2O3VlcbiUdNOyOYI6MDiZAYrQ3?=
 =?us-ascii?Q?T6hZokkDqBwOCZt0Yh8DeOlQ2P+OI27YAwSlgXHA8PbyI9tMLYquaGFK1CKd?=
 =?us-ascii?Q?eLbbZLMSwulfNGHS6JqtNTkwTNLf/hZP1gLgW6hMDAK8FgQQMlsTRHih8Wqk?=
 =?us-ascii?Q?fkc8cClPnlmsYbLk1mPZx6wAa7AnSB9+U9qbyDT6ICY8qzZC++5D4OdTvgWd?=
 =?us-ascii?Q?xTDFTCVVij7y2xUu1wyEmw4YGEVoAdFiPI96S9W2AZj+uL4swwxTP8j3dvFX?=
 =?us-ascii?Q?ZchrYxNS1qHj1u41ZCO9FeXjNoEiJ1hhIGAil1wuBHgZX2dhBMTFAEvbcnuP?=
 =?us-ascii?Q?1Cure5qcYJb+2MsO/QVnZjqQfIfkTzKfrMXfUUiZJ+xBJyHkQLhrq+aif27b?=
 =?us-ascii?Q?LKJPGCRdQvfP1woz01A8/kA/QYV9jcU5BXP7Gi7PJUTXG+n6G1ebg3CqIRwF?=
 =?us-ascii?Q?G5Tfa7oKNgMvJfvWevIsfzh3ouqFnS46165Tr6itQs1GmX9ZwRFHuvsUyZwf?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967f3224-5fbb-4779-107e-08db39a5c0ce
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6641.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 09:27:07.7827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvqK+XGHhJhO+RJrKWNE+hYwpAYLl8/hP85ry0xCKrm0bStaDovTxUqD2L1syJZ50lYCku4+vzfzLbU/n/1ksmcwL7A+p/BcycmOk5KgtzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8659
X-Spam-Status: No, score=2.9 required=5.0 tests=AC_FROM_MANY_DOTS,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit improves the control of ground switches in AAD IRQ

Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>
---
 sound/soc/codecs/da7219-aad.c | 60 +++++++++++++++++------------------
 sound/soc/codecs/da7219-aad.h |  5 ++-
 2 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index e3d398b8f54e..993a0d00bc48 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -342,36 +342,17 @@ static void da7219_aad_hptest_work(struct work_struct *work)
 static void da7219_aad_jack_det_work(struct work_struct *work)
 {
 	struct da7219_aad_priv *da7219_aad =
-		container_of(work, struct da7219_aad_priv, jack_det_work);
+		container_of(work, struct da7219_aad_priv, jack_det_work.work);
 	struct snd_soc_component *component = da7219_aad->component;
-	u8 srm_st;
 
-	mutex_lock(&da7219_aad->jack_det_mutex);
-
-	srm_st = snd_soc_component_read(component, DA7219_PLL_SRM_STS) & DA7219_PLL_SRM_STS_MCLK;
-	msleep(da7219_aad->gnd_switch_delay * ((srm_st == 0x0) ? 2 : 1) - 4);
 	/* Enable ground switch */
 	snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
-
-	mutex_unlock(&da7219_aad->jack_det_mutex);
 }
 
-
 /*
  * IRQ
  */
 
-static irqreturn_t da7219_aad_pre_irq_thread(int irq, void *data)
-{
-
-	struct da7219_aad_priv *da7219_aad = data;
-
-	if (!da7219_aad->jack_inserted)
-		schedule_work(&da7219_aad->jack_det_work);
-
-	return IRQ_WAKE_THREAD;
-}
-
 static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
 {
 	struct da7219_aad_priv *da7219_aad = data;
@@ -392,6 +373,18 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
 	/* Read status register for jack insertion & type status */
 	statusa = snd_soc_component_read(component, DA7219_ACCDET_STATUS_A);
 
+	if (events[DA7219_AAD_IRQ_REG_A] & DA7219_E_JACK_INSERTED_MASK) {
+		u8 srm_st;
+		int delay = 0;
+
+		srm_st = snd_soc_component_read(component,
+					DA7219_PLL_SRM_STS) & DA7219_PLL_SRM_STS_MCLK;
+		delay = (da7219_aad->gnd_switch_delay * ((srm_st == 0x0) ? 2 : 1) - 2);
+		queue_delayed_work(da7219_aad->aad_wq,
+							&da7219_aad->jack_det_work,
+							msecs_to_jiffies(delay));
+	}
+
 	/* Clear events */
 	regmap_bulk_write(da7219->regmap, DA7219_ACCDET_IRQ_EVENT_A,
 			  events, DA7219_AAD_IRQ_REG_MAX);
@@ -400,9 +393,6 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
 		events[DA7219_AAD_IRQ_REG_A], events[DA7219_AAD_IRQ_REG_B],
 		statusa);
 
-	if (!da7219_aad->jack_inserted)
-		cancel_work_sync(&da7219_aad->jack_det_work);
-
 	if (statusa & DA7219_JACK_INSERTION_STS_MASK) {
 		/* Jack Insertion */
 		if (events[DA7219_AAD_IRQ_REG_A] &
@@ -430,9 +420,9 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
 			if (statusa & DA7219_JACK_TYPE_STS_MASK) {
 				report |= SND_JACK_HEADSET;
 				mask |=	SND_JACK_HEADSET | SND_JACK_LINEOUT;
-				schedule_work(&da7219_aad->btn_det_work);
+				queue_work(da7219_aad->aad_wq, &da7219_aad->btn_det_work);
 			} else {
-				schedule_work(&da7219_aad->hptest_work);
+				queue_work(da7219_aad->aad_wq, &da7219_aad->hptest_work);
 			}
 		}
 
@@ -465,6 +455,7 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
 			da7219_aad->jack_inserted = false;
 
 			/* Cancel any pending work */
+			cancel_delayed_work_sync(&da7219_aad->jack_det_work);
 			cancel_work_sync(&da7219_aad->btn_det_work);
 			cancel_work_sync(&da7219_aad->hptest_work);
 
@@ -964,13 +955,19 @@ int da7219_aad_init(struct snd_soc_component *component)
 	snd_soc_component_update_bits(component, DA7219_ACCDET_CONFIG_1,
 			    DA7219_BUTTON_CONFIG_MASK, 0);
 
+	da7219_aad_handle_gnd_switch_time(component);
+
+	da7219_aad->aad_wq = create_singlethread_workqueue("da7219-aad");
+	if (!da7219_aad->aad_wq) {
+		dev_err(component->dev, "Failed to create aad workqueue\n");
+		return -ENOMEM;
+	}
+
+	INIT_DELAYED_WORK(&da7219_aad->jack_det_work, da7219_aad_jack_det_work);
 	INIT_WORK(&da7219_aad->btn_det_work, da7219_aad_btn_det_work);
 	INIT_WORK(&da7219_aad->hptest_work, da7219_aad_hptest_work);
-	INIT_WORK(&da7219_aad->jack_det_work, da7219_aad_jack_det_work);
-
-	mutex_init(&da7219_aad->jack_det_mutex);
 
-	ret = request_threaded_irq(da7219_aad->irq, da7219_aad_pre_irq_thread,
+	ret = request_threaded_irq(da7219_aad->irq, NULL,
 				   da7219_aad_irq_thread,
 				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 				   "da7219-aad", da7219_aad);
@@ -984,8 +981,6 @@ int da7219_aad_init(struct snd_soc_component *component)
 	regmap_bulk_write(da7219->regmap, DA7219_ACCDET_IRQ_MASK_A,
 			  &mask, DA7219_AAD_IRQ_REG_MAX);
 
-	da7219_aad_handle_gnd_switch_time(component);
-
 	return 0;
 }
 
@@ -1002,8 +997,10 @@ void da7219_aad_exit(struct snd_soc_component *component)
 
 	free_irq(da7219_aad->irq, da7219_aad);
 
+	cancel_delayed_work_sync(&da7219_aad->jack_det_work);
 	cancel_work_sync(&da7219_aad->btn_det_work);
 	cancel_work_sync(&da7219_aad->hptest_work);
+	destroy_workqueue(da7219_aad->aad_wq);
 }
 
 /*
@@ -1031,4 +1028,5 @@ int da7219_aad_probe(struct i2c_client *i2c)
 
 MODULE_DESCRIPTION("ASoC DA7219 AAD Driver");
 MODULE_AUTHOR("Adam Thomson <Adam.Thomson.Opensource@diasemi.com>");
+MODULE_AUTHOR("David Rau <David.Rau.opensource@dm.renesas.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/da7219-aad.h b/sound/soc/codecs/da7219-aad.h
index be87ee47edde..fbfbf3e67918 100644
--- a/sound/soc/codecs/da7219-aad.h
+++ b/sound/soc/codecs/da7219-aad.h
@@ -197,9 +197,8 @@ struct da7219_aad_priv {
 
 	struct work_struct btn_det_work;
 	struct work_struct hptest_work;
-	struct work_struct jack_det_work;
-
-	struct mutex  jack_det_mutex;
+	struct delayed_work jack_det_work;
+	struct workqueue_struct *aad_wq;
 
 	struct snd_soc_jack *jack;
 	bool micbias_resume_enable;
-- 
2.17.1

