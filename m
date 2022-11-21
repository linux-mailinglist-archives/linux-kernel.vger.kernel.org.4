Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389BF631952
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 06:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKUFIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 00:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKUFID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 00:08:03 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9FD100F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 21:08:03 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id w4so793931plp.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 21:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMIqu6elzQ/fhPBiCrbaxSsjSlZL9VcX8QAuybxVFXU=;
        b=KRZhw+660KNtlWnEcDCJ9UN3q3BXiWu4jvt+zgrdkPEJv8Efcm2jvYdbSopbbPdKLm
         sfztUJ7uo8JOHMmpkZ47c33mRsFyyIQKBKhhk8duY6xWU93kmXD+loss4yL4ss3EfQeg
         mrCnqHflEotvmJ7PVh6+SV3tpv29ss3Hl3o6sAoc6XBhWfkkWGxlcyx5BFDGcpwiWuKt
         LeUy2wC0TW0b3780DzI8SZYNHJ++eJh86b266gtmfiFTCl5lXnSchG0qzEvS4RbQh+eh
         ScA4BSiRu1GST+Eux1wGBUgwNYNjeLWJpXtUgcEQlpNLRS4k/8skvMe4MNuqP5JFiqUx
         y2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMIqu6elzQ/fhPBiCrbaxSsjSlZL9VcX8QAuybxVFXU=;
        b=DVMx9dHPQE6v89AQ842d7+bUgpSNdSagTSP5YEq1GA1abV4/4gccoz9j1Z8onPNKa6
         V9mBGrOyGrIngOEfmZvCuEb5HzDfO7NcGeCt92D9LsWD0YKLn90YejeSYy6kD5z6BIGe
         /h90yn7xX/X6LvDkNU9VGDHHIg5+lCaB+hpjzz2+nCuboJvYbek2+F+AbIdNybx1r6bQ
         v31sBDOrX/cXxXdxXRqH5WmqvLBnwjWxO8BrgkjKzcgWoLYBaU4111pXoDQKCnLPAWsh
         W34zLBjQr60LAej8d6h1zWIOuTc/DWHKkETVYTaBqx74EbTstIUc4OaHOcTB3TzYq4jJ
         9KvQ==
X-Gm-Message-State: ANoB5pnoX/wftztpmKjqF22uOQwUo6HvGZro2+RQQHhAkXroSxPye722
        WhgKZDC/T7J6GUAY47JBAnI=
X-Google-Smtp-Source: AA0mqf6113UG4iffqWXkhPyaQ4BF0B7DCtUVw4L6oDk3vt/EuoUBuuVeWX7tcg1K5ySg8SrKi0VV1A==
X-Received: by 2002:a17:90a:aa93:b0:218:94ff:ce1f with SMTP id l19-20020a17090aaa9300b0021894ffce1fmr10482453pjq.217.1669007282385;
        Sun, 20 Nov 2022 21:08:02 -0800 (PST)
Received: from ubuntu-vm.mshome.net (111-71-212-184.emome-ip.hinet.net. [111.71.212.184])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902e74300b00188a7bce192sm8552884plf.264.2022.11.20.21.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 21:08:01 -0800 (PST)
From:   David Rau <we730128@gmail.com>
X-Google-Original-From: David Rau <david.rau.zg@renesas.com>
To:     perex@perex.cz
Cc:     lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com,
        support.opensource@diasemi.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, David Rau <david.rau.zg@renesas.com>
Subject: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP headsets when playing music
Date:   Mon, 21 Nov 2022 05:07:44 +0000
Message-Id: <20221121050744.2278-1-david.rau.zg@renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OMTP pin define headsets can be mis-detected as line out
instead of OMTP, causing obvious issues with audio quality.
This patch is to put increased resistances within
the device at a suitable point.

To solve this issue better, the new mechanism setup
ground switches with conditional delay control
and these allow for more stabile detection process
to operate as intended. This conditional delay control
will not impact the hardware process
but use extra system resource.

This commit improves control of ground switches in the AAD logic.

Signed-off-by: David Rau <david.rau.zg@renesas.com>
---
 sound/soc/codecs/da7219-aad.c | 42 ++++++++++++++++++++++++++++++-----
 sound/soc/codecs/da7219-aad.h |  1 +
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index bba73c44c219..08200ec259f9 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -352,9 +352,14 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
 	u8 events[DA7219_AAD_IRQ_REG_MAX];
-	u8 statusa;
+	u8 statusa, srm_st;
 	int i, report = 0, mask = 0;
 
+	srm_st = snd_soc_component_read(component, DA7219_PLL_SRM_STS) & DA7219_PLL_SRM_STS_MCLK;
+	msleep(da7219_aad->gnd_switch_delay * ((srm_st == 0x0) ? 2 : 1) - 4);
+	/* Enable ground switch */
+	snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
+
 	/* Read current IRQ events */
 	regmap_bulk_read(da7219->regmap, DA7219_ACCDET_IRQ_EVENT_A,
 			 events, DA7219_AAD_IRQ_REG_MAX);
@@ -454,8 +459,8 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
 			snd_soc_dapm_disable_pin(dapm, "Mic Bias");
 			snd_soc_dapm_sync(dapm);
 
-			/* Enable ground switch */
-			snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
+			/* Disable ground switch */
+			snd_soc_component_update_bits(component, 0xFB, 0x01, 0x00);
 		}
 	}
 
@@ -831,6 +836,32 @@ static void da7219_aad_handle_pdata(struct snd_soc_component *component)
 	}
 }
 
+static void da7219_aad_handle_gnd_switch_time(struct snd_soc_component *component)
+{
+	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
+	struct da7219_aad_priv *da7219_aad = da7219->aad;
+	u8 jack_det;
+
+	jack_det = snd_soc_component_read(component, DA7219_ACCDET_CONFIG_2)
+		& DA7219_JACK_DETECT_RATE_MASK;
+	switch (jack_det) {
+	case 0x00:
+		da7219_aad->gnd_switch_delay = 32;
+		break;
+	case 0x10:
+		da7219_aad->gnd_switch_delay = 64;
+		break;
+	case 0x20:
+		da7219_aad->gnd_switch_delay = 128;
+		break;
+	case 0x30:
+		da7219_aad->gnd_switch_delay = 256;
+		break;
+	default:
+		da7219_aad->gnd_switch_delay = 32;
+		break;
+	}
+}
 
 /*
  * Suspend/Resume
@@ -908,9 +939,6 @@ int da7219_aad_init(struct snd_soc_component *component)
 	snd_soc_component_update_bits(component, DA7219_ACCDET_CONFIG_1,
 			    DA7219_BUTTON_CONFIG_MASK, 0);
 
-	/* Enable ground switch */
-	snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
-
 	INIT_WORK(&da7219_aad->btn_det_work, da7219_aad_btn_det_work);
 	INIT_WORK(&da7219_aad->hptest_work, da7219_aad_hptest_work);
 
@@ -928,6 +956,8 @@ int da7219_aad_init(struct snd_soc_component *component)
 	regmap_bulk_write(da7219->regmap, DA7219_ACCDET_IRQ_MASK_A,
 			  &mask, DA7219_AAD_IRQ_REG_MAX);
 
+	da7219_aad_handle_gnd_switch_time(component);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(da7219_aad_init);
diff --git a/sound/soc/codecs/da7219-aad.h b/sound/soc/codecs/da7219-aad.h
index f48a12012ef3..21fdf53095cc 100644
--- a/sound/soc/codecs/da7219-aad.h
+++ b/sound/soc/codecs/da7219-aad.h
@@ -187,6 +187,7 @@ enum da7219_aad_event_regs {
 struct da7219_aad_priv {
 	struct snd_soc_component *component;
 	int irq;
+	int gnd_switch_delay;
 
 	u8 micbias_pulse_lvl;
 	u32 micbias_pulse_time;
-- 
2.17.1

