Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470ED705450
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjEPQrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjEPQra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:47:30 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD9F3A9C
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:47:26 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-32c83c66b1cso100472045ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684255646; x=1686847646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4kqAFNzMiB3ZwK/e/ItswkNJsgBlTz31zqehRMdz+Ac=;
        b=XgquwqvLNbDkiRPVfnqU1n76gnw4qQo6lUMlezqCtFltOedMPmcnAvkXvPdCFuhylm
         mclF0gih61PAmtXrLslY7axZG74QEeWuxP6yd+uBQ9qpJ3TcBrCgQEUGRtruX3Z6NyYF
         QeubN5hMQlbLVmVTqFEZ3V9Vn3hUIwcTtEkLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684255646; x=1686847646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kqAFNzMiB3ZwK/e/ItswkNJsgBlTz31zqehRMdz+Ac=;
        b=hxiBAkFIwxaoeW9PVqBi7CzEPUf9CCNRvlcswe2lSV/tDx2jL5WXWXTjrSRJon1mYA
         uXTZ+p4s23lqY/m1EyS5vi5jdNcwvZh3M8apzJGlxsdOiN44WxZxkF5gdgggV8F5Wfcs
         0vkiHxQDNcn96/gM1+p1Imzh74Ato/nqTnxCwaXggOn607SuNcHQfDz/bBsYy+rZ1/XI
         kHPwP/gvIgQJN6Q1njP3cUQISUgGGt9c6diys210vM/bRYSLX19zy58v5EluiYAMPh/1
         CjQYJtk8GnTbXGZ5t+C1WDonuzvv6tgkq5WH2lQnz/kZpYlDdQh7tXWhLqmWt1k2z/yg
         r03w==
X-Gm-Message-State: AC+VfDxEzYM/eFHE+AjTiKN0vaml67I1DQgWH9BlAg2/UC7pXsBZVvp1
        Qc7QgBpsHiWkTdaAECmcW3z/bg==
X-Google-Smtp-Source: ACHHUZ5PMmHS1ZQAfxj/ZSE8EJBw2wv392wyIBpq74SBz2GLLGdQUWCTJBVp7LJdjI9cHzN8lRkBbQ==
X-Received: by 2002:a92:ca91:0:b0:335:ebb8:1138 with SMTP id t17-20020a92ca91000000b00335ebb81138mr12869924ilo.22.1684255646089;
        Tue, 16 May 2023 09:47:26 -0700 (PDT)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id c41-20020a023f69000000b004141e72be1asm7771265jaf.175.2023.05.16.09.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 09:47:25 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, stable@kernel.org
Subject: [PATCH] SoC: rt5682: Disable jack detection interrupt during suspend
Date:   Tue, 16 May 2023 16:46:30 +0000
Message-ID: <20230516164629.1.Ibf79e94b3442eecc0054d2b478779cc512d967fc@changeid>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rt5682 driver switches its regmap to cache-only when the
device suspends and back to regular mode on resume. When the
jack detect interrupt fires rt5682_irq() schedules the jack
detect work. This can result in invalid reads from the regmap
in cache-only mode if the work runs before the device has
resumed:

[   56.245502] rt5682 9-001a: ASoC: error at soc_component_read_no_lock on rt5682.9-001a for register: [0x000000f0] -16

Disable the jack detection interrupt during suspend and
re-enable it on resume. The driver already schedules the
jack detection work on resume, so any state change during
suspend is still handled.

This is essentially the same as commit f7d00a9be147 ("SoC:
rt5682s: Disable jack detection interrupt during suspend")
for the rt5682s.

Cc: stable@kernel.org
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 sound/soc/codecs/rt5682-i2c.c | 4 +++-
 sound/soc/codecs/rt5682.c     | 6 ++++++
 sound/soc/codecs/rt5682.h     | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
index 2935c1bb81f3..5bc46b041786 100644
--- a/sound/soc/codecs/rt5682-i2c.c
+++ b/sound/soc/codecs/rt5682-i2c.c
@@ -267,7 +267,9 @@ static int rt5682_i2c_probe(struct i2c_client *i2c)
 		ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
 			rt5682_irq, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
 			| IRQF_ONESHOT, "rt5682", rt5682);
-		if (ret)
+		if (!ret)
+			rt5682->irq = i2c->irq;
+		else
 			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
 	}
 
diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index f6c798b65c08..5d992543b791 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2959,6 +2959,9 @@ static int rt5682_suspend(struct snd_soc_component *component)
 	if (rt5682->is_sdw)
 		return 0;
 
+	if (rt5682->irq)
+		disable_irq(rt5682->irq);
+
 	cancel_delayed_work_sync(&rt5682->jack_detect_work);
 	cancel_delayed_work_sync(&rt5682->jd_check_work);
 	if (rt5682->hs_jack && (rt5682->jack_type & SND_JACK_HEADSET) == SND_JACK_HEADSET) {
@@ -3027,6 +3030,9 @@ static int rt5682_resume(struct snd_soc_component *component)
 	mod_delayed_work(system_power_efficient_wq,
 		&rt5682->jack_detect_work, msecs_to_jiffies(0));
 
+	if (rt5682->irq)
+		enable_irq(rt5682->irq);
+
 	return 0;
 }
 #else
diff --git a/sound/soc/codecs/rt5682.h b/sound/soc/codecs/rt5682.h
index d568c6993c33..e8efd8a84a6c 100644
--- a/sound/soc/codecs/rt5682.h
+++ b/sound/soc/codecs/rt5682.h
@@ -1462,6 +1462,7 @@ struct rt5682_priv {
 	int pll_out[RT5682_PLLS];
 
 	int jack_type;
+	int irq;
 	int irq_work_delay_time;
 };
 
-- 
2.40.1.606.ga4b1b128d6-goog

