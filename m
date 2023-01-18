Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE240671DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjARN0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjARNZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:25:36 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F979AAB1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674046362;
  x=1705582362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c9tQ6467axGUUkqK8Hn/WxBs1AovQDwhp7i0J3ZaltU=;
  b=oUTJko1HiCs47ScSwNDFuyBfNE3/2E0xF+mmifvzaRtcShJ/MXnqcHDa
   29gKUadym3+U7+WVCNHoP9uvyS4348E3/lpNlI1nwRC6mNj0QDzvgTEg/
   DPSu18dUf4VREGNeM9BDgNV3hwz73rG/IcU/BVJN+0qflq01JqhAcC/uf
   K1eu20Wa9h8CJN7GJiubj2tcQCAJl/bbNExAZOn1qYV1rU6FND0ikxNfu
   QUg/MHcgYuO2t+PFvzrFFyRHsz/sSrAmGNLWbv+Eoxyk60OelSrx4H6/F
   NOI/Jn5IkJTAf3jTbC/QzcloJxQdtv137/5qNNgBYNzsNSaCGhvt7ppvX
   A==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <kernel@axis.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v1 3/4] ASoC: ts3a227e: add set_jack and get_jack_supported_type
Date:   Wed, 18 Jan 2023 13:52:25 +0100
Message-ID: <20230118125226.333214-4-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230118125226.333214-1-astrid.rost@axis.com>
References: <20230118125226.333214-1-astrid.rost@axis.com>
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

Add set_jack and get_jack_supported_type
to allow simple-card-utils to add a jack for it.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 sound/soc/codecs/ts3a227e.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
index 2305a472d132..212dfd2b60ed 100644
--- a/sound/soc/codecs/ts3a227e.c
+++ b/sound/soc/codecs/ts3a227e.c
@@ -258,7 +258,22 @@ int ts3a227e_enable_jack_detect(struct snd_soc_component *component,
 }
 EXPORT_SYMBOL_GPL(ts3a227e_enable_jack_detect);
 
-static struct snd_soc_component_driver ts3a227e_soc_driver;
+static int ts3a227e_set_jack(struct snd_soc_component *component,
+			     struct snd_soc_jack *jack, void *data)
+{
+	return ts3a227e_enable_jack_detect(component, jack);
+}
+
+static int ts3a227e_get_supported_jack_type(struct snd_soc_component *component)
+{
+	return TS3A227E_JACK_MASK;
+}
+
+static const struct snd_soc_component_driver ts3a227e_soc_driver = {
+	.name = "ti,ts3a227e",
+	.set_jack = ts3a227e_set_jack,
+	.get_jack_supported_type = ts3a227e_get_supported_jack_type,
+};
 
 static const struct regmap_config ts3a227e_regmap_config = {
 	.val_bits = 8,
-- 
2.30.2

