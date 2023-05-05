Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660A06F871C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 18:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjEEQzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 12:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjEEQzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 12:55:31 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451F019427
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 09:55:30 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f19afc4f60so14028145e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683305729; x=1685897729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5FjLfR0dXo5At1Nv29Yy33iCFfTFuwOYzh/k0tPY30=;
        b=h2kiVF0IAYWJVzk/aTOE5lG4mTWGCGqOzz7oqa1cEibfLFqfpXftD8+mXnGJ3ooHWS
         IwiU2xbAuSOG3BBfRsosNxzd4xmRAxRlZnnj7z66A4FlImtmpVtzl+qhgP/a0TD+xOuc
         gzHQOwfxqt7hnrRj/4968rJ4XQInsT/bGviRbiJxa6lp6iaAdaZ8mJ+Xc10i/71jTNxw
         iyisfDrfM94Dy5OW+1LNsZcF/d25rSUTrEdMMQgbqG88q+wtQywmWXOHlqspJuzDXXuw
         qqVm0we6aasVZV9JEcU00Wy5O5IMDJyTVGI8+ENgD0q5Nlwi3MfJBiUkBan3NJwXnfxO
         quww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683305729; x=1685897729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5FjLfR0dXo5At1Nv29Yy33iCFfTFuwOYzh/k0tPY30=;
        b=TlAQQqgizT3josF6SPhQ/LFjkmRSqDQ+IwPXD9SXzL39MS6b9yPrdghgEVWvCKQdlm
         nY3E/cVG/LIn1ACMWImnM5I+ontgVGMFD84g42IcBuIohndzmrgVmUpiZMYCCHs3JyeT
         9Dm4WNfOocI0dKv88b7qhIZE9DerKWK138yoSq0oprnVnileozW8Zn61hmyea2o/1fgu
         SFzJ+ENFGMem2GU2pPeX57xF/TIHIByOkicy1ZXxcJYbOvvrgcvK2pu+qshyN2MSHDCw
         vE6x4cBe2Evlg2yIICI3BrbHfZHvM8bjIW2C/rW3X3lGT6o8WaEZ7mBDbGsfve+V3C6G
         +nfw==
X-Gm-Message-State: AC+VfDykzGH50v/1Vyz6d3/TYGeeEAHIEHlr/3h+i/nv+IfPp/WDqZeL
        RlnTjP/A5Zbmi91yQt9wtvXftA==
X-Google-Smtp-Source: ACHHUZ60mo9CYfuAJyu07wBUOWWLk7kW4NKYDEp4m79W50XgNcx+2nLVG5HKWdgdYDrfhhambBQ6rg==
X-Received: by 2002:a7b:c7d3:0:b0:3f0:683d:224d with SMTP id z19-20020a7bc7d3000000b003f0683d224dmr1768579wmk.9.1683305728751;
        Fri, 05 May 2023 09:55:28 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id x7-20020adfffc7000000b002c7066a6f77sm2923551wrs.31.2023.05.05.09.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 09:55:28 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, tiwai@suse.com
Cc:     perex@perex.cz, lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/3] ASoC: hdmi-codec: use snd_soc_cnew to add controls
Date:   Fri,  5 May 2023 17:55:14 +0100
Message-Id: <20230505165514.4666-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230505165514.4666-1-srinivas.kandagatla@linaro.org>
References: <20230505165514.4666-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there are multiple instances of this codec in a sound card using snd_ctl_new1
will fail with below error because of duplicate control names.

snd-sc8280xp sound: control 3:16:0:IEC958 Playback Mask:0 is already present
hdmi-audio-codec hdmi-audio-codec.4.auto: ASoC: error at snd_soc_pcm_dai_new on i2s-hifi: -16

Fix this by using snd_soc_cnew along with component name prefix to avoid
this duplication.

This issue is noticed on x13s laptop which has multiple instances of Displayport.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/hdmi-codec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 8c54cddf86b6..48d1eef9c806 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -801,7 +801,8 @@ static int hdmi_codec_pcm_new(struct snd_soc_pcm_runtime *rtd,
 		struct snd_kcontrol *kctl;
 
 		/* add ELD ctl with the device number corresponding to the PCM stream */
-		kctl = snd_ctl_new1(&hdmi_codec_controls[i], dai->component);
+		kctl = snd_soc_cnew(&hdmi_codec_controls[i], dai->component, NULL,
+				    dai->component->name_prefix);
 		if (!kctl)
 			return -ENOMEM;
 
-- 
2.21.0

