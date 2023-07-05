Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915D574847C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjGEM5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjGEM52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:57:28 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17D610F5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 05:57:27 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso67805565e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 05:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688561846; x=1691153846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xhg4Btd/0KybnmhVesqfMosrv9Aez9Q8GYSJ7Z38kYc=;
        b=Npwz7cfcZgmC0s2V6ezJBOFdy4P05NRAP4wOB0hnf08Cx3+flkWy/1N5uEYlx3AXT1
         3paPunOjWfJO30Lvj/A4owjC32Jk4fMUQ5FKxtW/43Y9yPSva/2jwLRFy/uKgDNvvCre
         D6Oebsi5p9u9DATB8WMm+4OCKjoSvZLkASmtEgaVykWt6yPublzxBxL9g/72jY8nPq4/
         uO+IqlKDtL8VO4AWCiGie2dpM/JHRH2HHcpEgrySVWCs6JylK/crCzIcJIxP7/WKbpXM
         +v/BFUHKADoIbw5JNt+9pU2HR/yhDScol9ZBRHFfuk/KaF8/VjG7UBdtr2KJsw3lq4Ya
         HlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688561846; x=1691153846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhg4Btd/0KybnmhVesqfMosrv9Aez9Q8GYSJ7Z38kYc=;
        b=HKL7/8XlI4ivOjzYS80LHUUiY5KRVgLVwOX949k76vPPWmB5o7tFadt1/NaKC63hbD
         Ftc0rRTgnwCMr74zywDtt2BXKC3zLwmxlbfoD51oEkxc7iFKAtEnmeTZz3QAYaWj1uA3
         VdpoXoLbHQXrJxnn7h4ZjFXPl2vqDPykTCZWRHj7grkV8N7NtQpjhPX+lPFFHDI89dKn
         so0RpiaAgvHmrvmJXjU4IdbszfikwoKIIy0wfl8xkmOZMfAQil8BIBD+JnFEsq4aD0c6
         YZGsen4KD9Dkc9OWfngEwEO5gJJ0JkmgNJu8SM3BGX47bYNoU+EeSi/WkobZRawv+xT5
         vNJw==
X-Gm-Message-State: AC+VfDzcxiCKDNSvkm/LFVPlw5Q5W5mWq26vZcn/W2Eix/Knd/KuQbkh
        t9j0nTTY7xBhDSm0EtslHehkLg==
X-Google-Smtp-Source: ACHHUZ5h1fIf4kmzcOsJi/+UT0HCUmr1gk3pOMIu5hkWvxLrSVetBvxtazlzvE/ayYYEUXK+sA76CA==
X-Received: by 2002:a1c:7903:0:b0:3fa:c3e8:901a with SMTP id l3-20020a1c7903000000b003fac3e8901amr13883895wme.25.1688561846413;
        Wed, 05 Jul 2023 05:57:26 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id y6-20020a7bcd86000000b003fbb346279dsm2100555wmj.38.2023.07.05.05.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 05:57:25 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: codecs: wcd938x: fix dB range for HPHL and HPHR
Date:   Wed,  5 Jul 2023 13:57:23 +0100
Message-Id: <20230705125723.40464-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dB range for HPHL and HPHR gains are from +6dB to -30dB in steps of
1.5dB with register values range from 0 to 24.

Current code maps these dB ranges incorrectly, fix them to allow proper
volume setting.

Fixes: e8ba1e05bdc0("ASoC: codecs: wcd938x: add basic controls")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index faa15a5ed2c8..3a3360711f8f 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -210,7 +210,7 @@ struct wcd938x_priv {
 };
 
 static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(ear_pa_gain, 600, -1800);
-static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(line_gain, 600, -3000);
+static const DECLARE_TLV_DB_SCALE(line_gain, -3000, 150, -3000);
 static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(analog_gain, 0, 3000);
 
 struct wcd938x_mbhc_zdet_param {
@@ -2655,8 +2655,8 @@ static const struct snd_kcontrol_new wcd938x_snd_controls[] = {
 		       wcd938x_get_swr_port, wcd938x_set_swr_port),
 	SOC_SINGLE_EXT("DSD_R Switch", WCD938X_DSD_R, 0, 1, 0,
 		       wcd938x_get_swr_port, wcd938x_set_swr_port),
-	SOC_SINGLE_TLV("HPHL Volume", WCD938X_HPH_L_EN, 0, 0x18, 0, line_gain),
-	SOC_SINGLE_TLV("HPHR Volume", WCD938X_HPH_R_EN, 0, 0x18, 0, line_gain),
+	SOC_SINGLE_TLV("HPHL Volume", WCD938X_HPH_L_EN, 0, 0x18, 1, line_gain),
+	SOC_SINGLE_TLV("HPHR Volume", WCD938X_HPH_R_EN, 0, 0x18, 1, line_gain),
 	WCD938X_EAR_PA_GAIN_TLV("EAR_PA Volume", WCD938X_ANA_EAR_COMPANDER_CTL,
 				2, 0x10, 0, ear_pa_gain),
 	SOC_SINGLE_EXT("ADC1 Switch", WCD938X_ADC1, 1, 1, 0,
-- 
2.25.1

