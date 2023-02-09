Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4683B68FC94
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 02:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjBIBUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 20:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjBIBUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 20:20:32 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE144AD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 17:20:31 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id f10so270215ilc.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 17:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c4B/fP2D/WU+gvJrKKscgdRErT41eDBoC5g7skBzasQ=;
        b=NkUqlJEjSov6W2wIEnq48XFTKiW5FzL+wHt0lB8O7+5qepak1bLdF+ealyW5nlTKoZ
         R8WVT9oDjgCa5PTbHJDSjUqTaQ3Emw95eyyahcVuOWAS1J+vEKh/V3iNGOe5WPoPS+7F
         i0ewRT6s/2PRIPWclUIcBjYqUZZx3afRiZx8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4B/fP2D/WU+gvJrKKscgdRErT41eDBoC5g7skBzasQ=;
        b=rBZ5ZXbvomDrDLe1Dfilob4nugARLoNGJQzHX0VXyDXjPKHH7SZBtWUemO2BPJetod
         SgJ9OSiRgPAnFPuqYH5gwgA6cg6Ty+3zuKc7bWtJ9VKP52B/mkPNyxdLAlG0rdPfQJ1z
         mWX5u17ImvfQMANinkWZkqt4FTU4dx/6g3fXI2BpKKVbUj5Ne/FBcOhKpGGottEX6Qdc
         cG4kgslxIQgmyUitJysIs0CaIUsnoKG8ntCyO9e1Nx0kv5rCwJ6v4zrgNbjhruWZf/iN
         kX6vb88sgJEbzhzDeyv0kmlmL/Qt6L4+FPatf4XwLK1GYcdmBS97PwY4edCuy2tpceWY
         0rAA==
X-Gm-Message-State: AO0yUKXd48mvvLpcv6xEgUQiCJe8lqiAtw3HRyaWJ85JKNZaMzfBPOpD
        PkDHicoX05nXUkdlzZ5uc6JBQA==
X-Google-Smtp-Source: AK7set/BMy8+uzdHTjc28D58ZB+OLGxa38IJBo8tQeuPQ/aQ4jNRmPt1RTq9/JLVWjl906HZlLggUg==
X-Received: by 2002:a05:6e02:12ed:b0:310:e9f4:1e32 with SMTP id l13-20020a056e0212ed00b00310e9f41e32mr10892050iln.19.1675905631149;
        Wed, 08 Feb 2023 17:20:31 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id j18-20020a02cc72000000b003a60e059970sm2253jaq.84.2023.02.08.17.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 17:20:30 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org,
        Douglas Anderson <dianders@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] SoC: rt5682s: Disable jack detection interrupt during suspend
Date:   Thu,  9 Feb 2023 01:20:23 +0000
Message-Id: <20230209012002.1.Ib4d6481f1d38a6e7b8c9e04913c02ca88c216cf6@changeid>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rt5682s driver switches its regmap to cache-only when the
device suspends and back to regular mode on resume. When the
jack detect interrupt fires rt5682s_irq() schedules the jack
detect work. This can result in invalid reads from the regmap
in cache-only mode if the work runs before the device has
resumed:

[   19.672162] rt5682s 2-001a: ASoC: error at soc_component_read_no_lock on rt5682s.2-001a for register: [0x000000f0] -16

Disable the jack detection interrupt during suspend and
re-enable it on resume. The driver already schedules the
jack detection work on resume, so any state change during
suspend is still handled.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 sound/soc/codecs/rt5682s.c | 10 +++++++++-
 sound/soc/codecs/rt5682s.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index f5e5dbc3b0f0..59117ebc5ecd 100644
--- a/sound/soc/codecs/rt5682s.c
+++ b/sound/soc/codecs/rt5682s.c
@@ -2895,6 +2895,9 @@ static int rt5682s_suspend(struct snd_soc_component *component)
 {
 	struct rt5682s_priv *rt5682s = snd_soc_component_get_drvdata(component);
 
+	if (rt5682s->irq)
+		disable_irq(rt5682s->irq);
+
 	cancel_delayed_work_sync(&rt5682s->jack_detect_work);
 	cancel_delayed_work_sync(&rt5682s->jd_check_work);
 
@@ -2919,6 +2922,9 @@ static int rt5682s_resume(struct snd_soc_component *component)
 			&rt5682s->jack_detect_work, msecs_to_jiffies(0));
 	}
 
+	if (rt5682s->irq)
+		enable_irq(rt5682s->irq);
+
 	return 0;
 }
 #else
@@ -3259,7 +3265,9 @@ static int rt5682s_i2c_probe(struct i2c_client *i2c)
 		ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL, rt5682s_irq,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 			"rt5682s", rt5682s);
-		if (ret)
+		if (!ret)
+			rt5682s->irq = i2c->irq;
+		else
 			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
 	}
 
diff --git a/sound/soc/codecs/rt5682s.h b/sound/soc/codecs/rt5682s.h
index 67f86a38a1cc..caa7733b430f 100644
--- a/sound/soc/codecs/rt5682s.h
+++ b/sound/soc/codecs/rt5682s.h
@@ -1472,6 +1472,7 @@ struct rt5682s_priv {
 	int pll_comb;
 
 	int jack_type;
+	unsigned int irq;
 	int irq_work_delay_time;
 	int wclk_enabled;
 };
-- 
2.39.1.519.gcb327c4b5f-goog

