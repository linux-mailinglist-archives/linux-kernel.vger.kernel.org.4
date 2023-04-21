Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785F16EAA98
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjDUMmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjDUMmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:42:39 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17F8902A;
        Fri, 21 Apr 2023 05:42:12 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id AFC324000A;
        Fri, 21 Apr 2023 12:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682080921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ReUlzkjE4Wu5oxkDFDACc0QGLsw/liPYYYIVObV0csA=;
        b=EBy4SLN3K1xBNjJvOdgJT6PUfEQL9bFvtJnkKZY46KL21NgKdoRGRLuXY2Ng5RVJCaQUsK
        GUAjgQdTVTG41iA642TMsVC4zRI8weITdr7eKSHZvuCV1Q5xCkm8Jbl77IjpdbpUulDUiX
        AsR9HA/raMQtAMUCJOFuJPfaI0RECjhMyOz7Albr5ZYlsRCx1iz32soaxO3gFjAiprgSuv
        cIxyMyYohgaG33z6C43NJ8liKsqhp27aY2E8che4fAx5gExva8v9hS1l3cwoZzOoA0YZ43
        4sasYv521gJLU5JtIUz/jn78fj2GCk6QXZiocudJcA47ux7IaLWyQXpxTA88AQ==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 3/4] ASoC: soc-dapm.h: Add a helper to build a DAPM widget dynamically
Date:   Fri, 21 Apr 2023 14:41:21 +0200
Message-Id: <20230421124122.324820-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230421124122.324820-1-herve.codina@bootlin.com>
References: <20230421124122.324820-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SND_SOC_DAPM_* helpers family are used to build widgets array in a
static way.

Introduce SND_SOC_DAPM_WIDGET() in order to use the SND_SOC_DAPM_*
helpers family in a dynamic way. The different SND_SOC_DAPM_* parameters
can be computed by the code and the widget can be built based on this
parameter computation.
For instance:
  static int create_widget(char *input_name)
  {
	struct snd_soc_dapm_widget widget;
	char name*;
	...
	name = input_name;
	if (!name)
		name = "default";

	widget = SND_SOC_DAPM_WIDGET(SND_SOC_DAPM_INPUT(name));
	...
  }

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/sound/soc-dapm.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 64915ebd641e..d6bb97fba8c9 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -276,7 +276,17 @@ struct soc_enum;
 	.reg = SND_SOC_NOPM, .event = dapm_pinctrl_event, \
 	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD }
 
-
+/*
+ * Helper to create a widget 'dynamically'
+ * This can be used with any of the SND_SOC_DAPM_* widget helper.
+ * For instance:
+ *  struct snd_soc_dapm_widget widget;
+ *  ...
+ *  widget = SND_SOC_DAPM_WIDGET(SND_SOC_DAPM_INPUT(input_name));
+ */
+#define SND_SOC_DAPM_WIDGET(_widget)({ \
+		struct snd_soc_dapm_widget _w[1] = { _widget }; \
+	_w[0]; })
 
 /* dapm kcontrol types */
 #define SOC_DAPM_DOUBLE(xname, reg, lshift, rshift, max, invert) \
-- 
2.39.2

