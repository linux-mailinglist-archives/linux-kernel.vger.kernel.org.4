Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEF1677D4A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjAWN7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjAWN7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:59:42 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC1324114
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674482373;
  x=1706018373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/WXW21EG+pqy+W42CXni76Bfh0YGb++llEepThhlRRc=;
  b=Vvvpde2+d0eTl1hPh4Jpy8cfbBUg2HVP0Mmt+6Ek4W/VdFk43GUEUIWX
   rqMfgB6GHNnXe50/f4lUg6oQrkavbhLopNyO6FVBt4BD026W/vpDp35ZF
   bD3jgLOvpbpsUO2lYBi1X3/kwFtjpwQylv6pIamNkt0XfRXyA39KGUiAD
   4eO+wCvOEoFkdjRChnjOilUZOvDbNCHqeGYAkFnN9btfDukZgk6eWMTy5
   gksXuxOa/OzWaFvXOHQRNsfKBJdlArcZY/jwCzfg7Uii5T+TXJobtrjVx
   yqKe0HwXcl5tqqG2EOqNXM0c7MWedwjNsVFh1frU2cv1EZ4Z98gt8zuiW
   w==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <kernel@axis.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v3 1/3] ASoC: soc-component: add get_jack_type
Date:   Mon, 23 Jan 2023 14:59:11 +0100
Message-ID: <20230123135913.2720991-2-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230123135913.2720991-1-astrid.rost@axis.com>
References: <20230123135913.2720991-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add function to return the jack type of snd_jack_types.
This allows a generic card driver to add a jack with the specified
type.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 include/sound/soc-component.h |  2 ++
 sound/soc/soc-component.c     | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index c26ffb033777..3203d35bc8c1 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -98,6 +98,7 @@ struct snd_soc_component_driver {
 		       int source, unsigned int freq_in, unsigned int freq_out);
 	int (*set_jack)(struct snd_soc_component *component,
 			struct snd_soc_jack *jack,  void *data);
+	int (*get_jack_type)(struct snd_soc_component *component);
 
 	/* DT */
 	int (*of_xlate_dai_name)(struct snd_soc_component *component,
@@ -384,6 +385,7 @@ int snd_soc_component_set_pll(struct snd_soc_component *component, int pll_id,
 			      unsigned int freq_out);
 int snd_soc_component_set_jack(struct snd_soc_component *component,
 			       struct snd_soc_jack *jack, void *data);
+int snd_soc_component_get_jack_type(struct snd_soc_component *component);
 
 void snd_soc_component_seq_notifier(struct snd_soc_component *component,
 				    enum snd_soc_dapm_type type, int subseq);
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index e12f8244242b..3cd6952212e1 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -256,6 +256,26 @@ int snd_soc_component_set_jack(struct snd_soc_component *component,
 }
 EXPORT_SYMBOL_GPL(snd_soc_component_set_jack);
 
+/**
+ * snd_soc_component_get_jack_type
+ * @component: COMPONENTs
+ *
+ * Returns the jack type of the component
+ * This can either be the supported type or one read from
+ * devicetree with the property: jack-type.
+ */
+int snd_soc_component_get_jack_type(
+	struct snd_soc_component *component)
+{
+	int ret = -ENOTSUPP;
+
+	if (component->driver->get_jack_type)
+		ret = component->driver->get_jack_type(component);
+
+	return soc_component_ret(component, ret);
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_get_jack_type);
+
 int snd_soc_component_module_get(struct snd_soc_component *component,
 				 void *mark, int upon_open)
 {
-- 
2.30.2

