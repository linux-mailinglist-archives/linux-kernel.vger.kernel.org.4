Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC1B6C6E07
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjCWQpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjCWQpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:45:08 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234E2C165
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:44:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h8so89472203ede.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679589859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/ixaKYCINrc8PZNvIv/BmX3oT7UL3hRYGh8CvIW67w=;
        b=gR+HrEbSGNaBPXyDWCKFxXDo8N8eJof0wkZfcPSoIFUybYbdbDk7TQ50jIYpTPg1Mu
         7iUSc/JXUV5V2uo6O3W5pCXzqXrByLxMX5Stnh03QSQfvHQQv0Y4y7V0MIBYQscWcpjp
         mSLEFwG0h7sUfUq76wecIuaYUoC3IoMoK0a5F8Y9CXY88+Bjn07Jee7XkQ1reJ/TFS1l
         vquOdwHsm8w3ytV1TkaeX/IycPc8k4Q6nbDFFZ/Ll20wE2tL/k68mTeom7TaPPoMLAnf
         18n656Li66Q7oHf+7SAmOEqoZS1R8eXyPolMfaltUhxm2dX0WJRSryEFQYkh7PS4fOZz
         iMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679589859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/ixaKYCINrc8PZNvIv/BmX3oT7UL3hRYGh8CvIW67w=;
        b=gAF+lgB3txfpMAfWONWLicJcE5kbJ4TW7xzGRkgNf+rybO0RIkJS9GRQhoC6yPSUpe
         GonxlIvDWn1J7rZcZ6SJ+6+4wRNakJ/PnhT10P4oMeeN+6t/kDk02P5c8s7dCZ2Ryf12
         2DW93tpOd7urquB50uuWoBeIDBKgSkTKZHxLsaRCLObroxHNSCPq4JQH8DgtwGZAIaxq
         tolQ29TIMR2AOkq/IB5LP9ncGe/NtFVvop1UvvwpKMmL6Mn+V57TFCnonxEQ0gQ7enO1
         bKtEFCCcaflJDCYMKKzDVxFowmy3YV1lioqe0nnPTkbHbUmwxNCyyl6Pa2ZwJlbfuTXP
         zu8w==
X-Gm-Message-State: AO0yUKUFeWyKR3dYMoKqTvii5JOXMT8dAxcsdNvYHcw2ygN4JVJJioBs
        VLNnCMuD+QkmOmG29YxHcRk3yQ==
X-Google-Smtp-Source: AK7set/vy+gzeXZ1o5gE0FO2a65HuiXtu0JMZsOOtsd+Qb317JBUb4yMNlyBnCpcSiQd8mGZ+rWzSA==
X-Received: by 2002:a17:906:1b15:b0:8b1:7ae9:647 with SMTP id o21-20020a1709061b1500b008b17ae90647mr10473349ejg.76.1679589859734;
        Thu, 23 Mar 2023 09:44:19 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id m10-20020a50998a000000b004e48f8df7e2sm9542187edb.72.2023.03.23.09.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 09:44:19 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        johan+linaro@kernel.org, steev@kali.org,
        dmitry.baryshkov@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/4] ASoC: codecs: wsa881x: mute/unmute PA in correct sequence
Date:   Thu, 23 Mar 2023 16:44:03 +0000
Message-Id: <20230323164403.6654-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230323164403.6654-1-srinivas.kandagatla@linaro.org>
References: <20230323164403.6654-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current setup the PA is left unmuted even when the
Soundwire ports are not started streaming. This can lead to click
and pop sounds during start.
There is a same issue in the reverse order where in the PA is
left unmute even after the data stream is stopped, the time
between data stream stopping and port closing is long enough
to accumulate DC on the line resulting in Click/Pop noise
during end of stream.

Moving the mute/unmute to trigger stop/start respectively seems to
help a lot with this Click/Pop issues reported on this Codec.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wsa881x.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index f709231b1277..4ce72a7f01b6 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -1033,11 +1033,39 @@ static int wsa881x_digital_mute(struct snd_soc_dai *dai, int mute, int stream)
 	return 0;
 }
 
+static int wsa881x_trigger(struct snd_pcm_substream *s, int cmd,
+			   struct snd_soc_dai *dai)
+{
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		wsa881x_digital_mute(dai, false, 0);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		wsa881x_digital_mute(dai, true, 0);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int wsa881x_startup(struct snd_pcm_substream *stream,
+			   struct snd_soc_dai *dai)
+{
+	return wsa881x_digital_mute(dai, true, 0);
+}
+
 static const struct snd_soc_dai_ops wsa881x_dai_ops = {
+	.startup = wsa881x_startup,
 	.hw_params = wsa881x_hw_params,
 	.hw_free = wsa881x_hw_free,
-	.mute_stream = wsa881x_digital_mute,
 	.set_stream = wsa881x_set_sdw_stream,
+	.trigger = wsa881x_trigger,
 };
 
 static struct snd_soc_dai_driver wsa881x_dais[] = {
-- 
2.21.0

