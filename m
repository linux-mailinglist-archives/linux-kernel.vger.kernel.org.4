Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04633731C95
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345268AbjFOP1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345192AbjFOP05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:26:57 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E921BC9;
        Thu, 15 Jun 2023 08:26:54 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686842813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kVNcNG6lGwmhGkvgIcyEWY+MHma3vPNVL1G9SDQv0N4=;
        b=C+o78+8R1+tm2CcwSEoPCvVdBFZ3nyIz/qgoRiM1/45Wzh7KyFXEsbWNXI42bbr9qUJGJR
        30iSDDSSzwjP+d1uboQ6pF5aOq9YCeBgvffj6G9qnf7XCpWk2BaGwVx9cTthnihWCuysPL
        xoJ3sed8EOGWfirfICg/+zjIki2llikT5wQWQoOYO8baeTsSDuO8y+ueG+y32fg9HR0O3L
        CcT4bPFtJzVsEUbo+1IhJBqTTWUrSj0joGBErl34WFuW5fDIK2aDcIUy65BaIPq2i1X11p
        CmAaJb2xp6NXsxrVqDvh25owfxxGfRbw+fKn9bcCTPmb+D+2nn2RlTeqVkzuPQ==
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 6646FFF810;
        Thu, 15 Jun 2023 15:26:52 +0000 (UTC)
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v5 11/13] ASoC: soc-dapm.h: Convert macros to return a compound literal
Date:   Thu, 15 Jun 2023 17:26:29 +0200
Message-Id: <20230615152631.224529-12-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230615152631.224529-1-herve.codina@bootlin.com>
References: <20230615152631.224529-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SND_SOC_DAPM_* helpers family are used to build widgets array in a
static way.

Convert them to return a compound literal in order to use them in both
static and dynamic way.
With this conversion, the different SND_SOC_DAPM_* parameters can be
computed by the code and the widget can be built based on this parameter
computation.
  static int create_widget(char *input_name)
  {
          struct snd_soc_dapm_widget widget;
          char name*;
          ...
          name = input_name;
          if (!name)
                  name = "default";

          widget = SND_SOC_DAPM_INPUT(name);
          ...
  }

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 include/sound/soc-dapm.h | 138 ++++++++++++++++++++++++++-------------
 1 file changed, 92 insertions(+), 46 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 87f8e1793af1..2e38dff16779 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -42,36 +42,45 @@ struct soc_enum;
 
 /* codec domain */
 #define SND_SOC_DAPM_VMID(wname) \
-{	.id = snd_soc_dapm_vmid, .name = wname, .kcontrol_news = NULL, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_vmid, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0}
 
 /* platform domain */
 #define SND_SOC_DAPM_SIGGEN(wname) \
-{	.id = snd_soc_dapm_siggen, .name = wname, .kcontrol_news = NULL, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_siggen, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM }
 #define SND_SOC_DAPM_SINK(wname) \
-{	.id = snd_soc_dapm_sink, .name = wname, .kcontrol_news = NULL, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_sink, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM }
 #define SND_SOC_DAPM_INPUT(wname) \
-{	.id = snd_soc_dapm_input, .name = wname, .kcontrol_news = NULL, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_input, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM }
 #define SND_SOC_DAPM_OUTPUT(wname) \
-{	.id = snd_soc_dapm_output, .name = wname, .kcontrol_news = NULL, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_output, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM }
 #define SND_SOC_DAPM_MIC(wname, wevent) \
-{	.id = snd_soc_dapm_mic, .name = wname, .kcontrol_news = NULL, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_mic, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM, .event = wevent, \
 	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD}
 #define SND_SOC_DAPM_HP(wname, wevent) \
-{	.id = snd_soc_dapm_hp, .name = wname, .kcontrol_news = NULL, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_hp, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM, .event = wevent, \
 	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD}
 #define SND_SOC_DAPM_SPK(wname, wevent) \
-{	.id = snd_soc_dapm_spk, .name = wname, .kcontrol_news = NULL, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_spk, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM, .event = wevent, \
 	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD}
 #define SND_SOC_DAPM_LINE(wname, wevent) \
-{	.id = snd_soc_dapm_line, .name = wname, .kcontrol_news = NULL, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_line, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM, .event = wevent, \
 	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD}
 
@@ -82,93 +91,110 @@ struct soc_enum;
 /* path domain */
 #define SND_SOC_DAPM_PGA(wname, wreg, wshift, winvert,\
 	 wcontrols, wncontrols) \
-{	.id = snd_soc_dapm_pga, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_pga, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = wncontrols}
 #define SND_SOC_DAPM_OUT_DRV(wname, wreg, wshift, winvert,\
 	 wcontrols, wncontrols) \
-{	.id = snd_soc_dapm_out_drv, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_out_drv, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = wncontrols}
 #define SND_SOC_DAPM_MIXER(wname, wreg, wshift, winvert, \
 	 wcontrols, wncontrols)\
-{	.id = snd_soc_dapm_mixer, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_mixer, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = wncontrols}
 #define SND_SOC_DAPM_MIXER_NAMED_CTL(wname, wreg, wshift, winvert, \
 	 wcontrols, wncontrols)\
-{       .id = snd_soc_dapm_mixer_named_ctl, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_mixer_named_ctl, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = wncontrols}
 /* DEPRECATED: use SND_SOC_DAPM_SUPPLY */
 #define SND_SOC_DAPM_MICBIAS(wname, wreg, wshift, winvert) \
-{	.id = snd_soc_dapm_micbias, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_micbias, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = NULL, .num_kcontrols = 0}
 #define SND_SOC_DAPM_SWITCH(wname, wreg, wshift, winvert, wcontrols) \
-{	.id = snd_soc_dapm_switch, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_switch, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = 1}
 #define SND_SOC_DAPM_MUX(wname, wreg, wshift, winvert, wcontrols) \
-{	.id = snd_soc_dapm_mux, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_mux, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = 1}
 #define SND_SOC_DAPM_DEMUX(wname, wreg, wshift, winvert, wcontrols) \
-{	.id = snd_soc_dapm_demux, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_demux, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = 1}
 
 /* Simplified versions of above macros, assuming wncontrols = ARRAY_SIZE(wcontrols) */
 #define SOC_PGA_ARRAY(wname, wreg, wshift, winvert,\
 	 wcontrols) \
-{	.id = snd_soc_dapm_pga, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_pga, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols)}
 #define SOC_MIXER_ARRAY(wname, wreg, wshift, winvert, \
 	 wcontrols)\
-{	.id = snd_soc_dapm_mixer, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_mixer, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols)}
 #define SOC_MIXER_NAMED_CTL_ARRAY(wname, wreg, wshift, winvert, \
 	 wcontrols)\
-{       .id = snd_soc_dapm_mixer_named_ctl, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_mixer_named_ctl, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols)}
 
 /* path domain with event - event handler must return 0 for success */
 #define SND_SOC_DAPM_PGA_E(wname, wreg, wshift, winvert, wcontrols, \
 	wncontrols, wevent, wflags) \
-{	.id = snd_soc_dapm_pga, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_pga, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = wncontrols, \
 	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_OUT_DRV_E(wname, wreg, wshift, winvert, wcontrols, \
 	wncontrols, wevent, wflags) \
-{	.id = snd_soc_dapm_out_drv, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_out_drv, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = wncontrols, \
 	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_MIXER_E(wname, wreg, wshift, winvert, wcontrols, \
 	wncontrols, wevent, wflags) \
-{	.id = snd_soc_dapm_mixer, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_mixer, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = wncontrols, \
 	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_MIXER_NAMED_CTL_E(wname, wreg, wshift, winvert, \
 	wcontrols, wncontrols, wevent, wflags) \
-{       .id = snd_soc_dapm_mixer, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_mixer, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, \
 	.num_kcontrols = wncontrols, .event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_SWITCH_E(wname, wreg, wshift, winvert, wcontrols, \
 	wevent, wflags) \
-{	.id = snd_soc_dapm_switch, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_switch, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = 1, \
 	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_MUX_E(wname, wreg, wshift, winvert, wcontrols, \
 	wevent, wflags) \
-{	.id = snd_soc_dapm_mux, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_mux, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = 1, \
 	.event = wevent, .event_flags = wflags}
@@ -176,101 +202,121 @@ struct soc_enum;
 /* additional sequencing control within an event type */
 #define SND_SOC_DAPM_PGA_S(wname, wsubseq, wreg, wshift, winvert, \
 	wevent, wflags) \
-{	.id = snd_soc_dapm_pga, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_pga, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.event = wevent, .event_flags = wflags, \
 	.subseq = wsubseq}
 #define SND_SOC_DAPM_SUPPLY_S(wname, wsubseq, wreg, wshift, winvert, wevent, \
 	wflags)	\
-{	.id = snd_soc_dapm_supply, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_supply, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.event = wevent, .event_flags = wflags, .subseq = wsubseq}
 
 /* Simplified versions of above macros, assuming wncontrols = ARRAY_SIZE(wcontrols) */
 #define SOC_PGA_E_ARRAY(wname, wreg, wshift, winvert, wcontrols, \
 	wevent, wflags) \
-{	.id = snd_soc_dapm_pga, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_pga, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols), \
 	.event = wevent, .event_flags = wflags}
 #define SOC_MIXER_E_ARRAY(wname, wreg, wshift, winvert, wcontrols, \
 	wevent, wflags) \
-{	.id = snd_soc_dapm_mixer, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_mixer, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols), \
 	.event = wevent, .event_flags = wflags}
 #define SOC_MIXER_NAMED_CTL_E_ARRAY(wname, wreg, wshift, winvert, \
 	wcontrols, wevent, wflags) \
-{       .id = snd_soc_dapm_mixer, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_mixer, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols), \
 	.event = wevent, .event_flags = wflags}
 
 /* events that are pre and post DAPM */
 #define SND_SOC_DAPM_PRE(wname, wevent) \
-{	.id = snd_soc_dapm_pre, .name = wname, .kcontrol_news = NULL, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_pre, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM, .event = wevent, \
 	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD}
 #define SND_SOC_DAPM_POST(wname, wevent) \
-{	.id = snd_soc_dapm_post, .name = wname, .kcontrol_news = NULL, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_post, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM, .event = wevent, \
 	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD}
 
 /* stream domain */
 #define SND_SOC_DAPM_AIF_IN(wname, stname, wchan, wreg, wshift, winvert) \
-{	.id = snd_soc_dapm_aif_in, .name = wname, .sname = stname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_aif_in, .name = wname, .sname = stname, \
 	.channel = wchan, SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), }
 #define SND_SOC_DAPM_AIF_IN_E(wname, stname, wchan, wreg, wshift, winvert, \
 			      wevent, wflags)				\
-{	.id = snd_soc_dapm_aif_in, .name = wname, .sname = stname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_aif_in, .name = wname, .sname = stname, \
 	.channel = wchan, SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.event = wevent, .event_flags = wflags }
 #define SND_SOC_DAPM_AIF_OUT(wname, stname, wchan, wreg, wshift, winvert) \
-{	.id = snd_soc_dapm_aif_out, .name = wname, .sname = stname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_aif_out, .name = wname, .sname = stname, \
 	.channel = wchan, SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), }
 #define SND_SOC_DAPM_AIF_OUT_E(wname, stname, wchan, wreg, wshift, winvert, \
 			     wevent, wflags)				\
-{	.id = snd_soc_dapm_aif_out, .name = wname, .sname = stname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_aif_out, .name = wname, .sname = stname, \
 	.channel = wchan, SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.event = wevent, .event_flags = wflags }
 #define SND_SOC_DAPM_DAC(wname, stname, wreg, wshift, winvert) \
-{	.id = snd_soc_dapm_dac, .name = wname, .sname = stname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_dac, .name = wname, .sname = stname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert) }
 #define SND_SOC_DAPM_DAC_E(wname, stname, wreg, wshift, winvert, \
 			   wevent, wflags)				\
-{	.id = snd_soc_dapm_dac, .name = wname, .sname = stname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_dac, .name = wname, .sname = stname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.event = wevent, .event_flags = wflags}
 
 #define SND_SOC_DAPM_ADC(wname, stname, wreg, wshift, winvert) \
-{	.id = snd_soc_dapm_adc, .name = wname, .sname = stname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_adc, .name = wname, .sname = stname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), }
 #define SND_SOC_DAPM_ADC_E(wname, stname, wreg, wshift, winvert, \
 			   wevent, wflags)				\
-{	.id = snd_soc_dapm_adc, .name = wname, .sname = stname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_adc, .name = wname, .sname = stname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_CLOCK_SUPPLY(wname) \
-{	.id = snd_soc_dapm_clock_supply, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_clock_supply, .name = wname, \
 	.reg = SND_SOC_NOPM, .event = dapm_clock_event, \
 	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD }
 
 /* generic widgets */
 #define SND_SOC_DAPM_REG(wid, wname, wreg, wshift, wmask, won_val, woff_val) \
-{	.id = wid, .name = wname, .kcontrol_news = NULL, .num_kcontrols = 0, \
+(struct snd_soc_dapm_widget) { \
+	.id = wid, .name = wname, .kcontrol_news = NULL, .num_kcontrols = 0, \
 	.reg = wreg, .shift = wshift, .mask = wmask, \
 	.on_val = won_val, .off_val = woff_val, }
 #define SND_SOC_DAPM_SUPPLY(wname, wreg, wshift, winvert, wevent, wflags) \
-{	.id = snd_soc_dapm_supply, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_supply, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_REGULATOR_SUPPLY(wname, wdelay, wflags)	    \
-{	.id = snd_soc_dapm_regulator_supply, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_regulator_supply, .name = wname, \
 	.reg = SND_SOC_NOPM, .shift = wdelay, .event = dapm_regulator_event, \
 	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD, \
 	.on_val = wflags}
 #define SND_SOC_DAPM_PINCTRL(wname, active, sleep) \
-{	.id = snd_soc_dapm_pinctrl, .name = wname, \
+(struct snd_soc_dapm_widget) { \
+	.id = snd_soc_dapm_pinctrl, .name = wname, \
 	.priv = (&(struct snd_soc_dapm_pinctrl_priv) \
 		{ .active_state = active, .sleep_state = sleep,}), \
 	.reg = SND_SOC_NOPM, .event = dapm_pinctrl_event, \
-- 
2.40.1

