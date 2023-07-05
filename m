Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7FE748461
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjGEMtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjGEMs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:48:57 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1730010F5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 05:48:55 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-313e742a787so615793f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 05:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688561333; x=1691153333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=796mPETlBqbeNQ5vV/FcWX3FA/XcOt8VlMkifegXBJw=;
        b=votp08ad7DjF8+34RaFA/Zj5QD6sm6iRVV4rH3+q1RS92sWxEZ6fSnVef2YVtLxJCA
         7sjTG310S7I/gaKEs6jL5sODe5C8w8Vopwf76GMsd5hh1lN0NCdcu4kHDFkRWJLsPhN2
         KNDFznH+2YAYgItpod/1CRQnEDBziRBjsWh7nCBg2ZfcpDx5hmXEDSWS6zXwazoPRSLE
         AS8DL31mS4zBnxdLo2d37lKtTGZuKj8NTMlKc2E6d0RSmWvAlO1RdvlyQ0cN6aX9kEIw
         IEk2lK+2FKDvNS0JhaLzHCmBsymeQ8GzU+dpp0kUfk9l+8YQcn8vBrCHUWoMMT+2MfN+
         OUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688561333; x=1691153333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=796mPETlBqbeNQ5vV/FcWX3FA/XcOt8VlMkifegXBJw=;
        b=XPFJ53IqClqNz8nfdDzDJqaOvTUfV603kTma9tlki8ckkb6PKvdUH6K5FZiLUlL00e
         YlgPL1ZKqkEOrqqrtLbju+htWRkYw4GqgqrGp5lYsh2OBsyMiVoQc9lc72MUj3Va9Nps
         hxCtBeqMUMvCVekI8dPOr6aGMfZ+FiWUQ3d7iBXo1e2/6UJmzHO5yFWsRZKMEDS5KhtJ
         +UgrtxOmG5Vy1DVUlZT3bO4iNkWkLArg74GYGvThC/6EebFe6sVmsQl5RcOG58TuOCf8
         EbacWQQyWwNeFIZNWKXKN+w2D61lKjP3RWYzmI+owySaSJHDJlR9yL392eoMAL9OfUQh
         CVeQ==
X-Gm-Message-State: ABy/qLbk4XcVyswG6tugPI6Uubzd0/t4aHhH+MS+bX0PW8sev71TNcQi
        byw9fOsxCfX5AkzgeLz623A4xQ==
X-Google-Smtp-Source: APBJJlE7GGHPV5ilUTNwqFWMGOathf6ghUXbeCZOEhnHAO94EQBL8ZMk5xLOXPIg/ka5t02RLI4U3Q==
X-Received: by 2002:adf:e805:0:b0:314:314e:fdda with SMTP id o5-20020adfe805000000b00314314efddamr2551891wrm.23.1688561333301;
        Wed, 05 Jul 2023 05:48:53 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id cw13-20020a056000090d00b003112f836d4esm30770606wrb.85.2023.07.05.05.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 05:48:52 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH] ASoC: qcom: q6afe-dai: fix Display Port Playback stream name
Date:   Wed,  5 Jul 2023 13:48:50 +0100
Message-Id: <20230705124850.40069-1-srinivas.kandagatla@linaro.org>
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

With recent changes to add more display ports did not change the Stream
name in q6afe-dai. This results in below error
"ASoC: Failed to add route DISPLAY_PORT_RX -> Display Port Playback(*)"
and sound card fails to probe.

Fix this by adding correct stream name.

Fixes: 90848a2557fe ("ASoC: qcom: q6dsp: add support to more display ports")
Reported-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 31e0bad71e95..dbff55a97162 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -476,7 +476,7 @@ static int q6afe_mi2s_set_sysclk(struct snd_soc_dai *dai,
 
 static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
 	{"HDMI Playback", NULL, "HDMI_RX"},
-	{"Display Port Playback", NULL, "DISPLAY_PORT_RX"},
+	{"DISPLAY_PORT_RX_0 Playback", NULL, "DISPLAY_PORT_RX"},
 	{"Slimbus Playback", NULL, "SLIMBUS_0_RX"},
 	{"Slimbus1 Playback", NULL, "SLIMBUS_1_RX"},
 	{"Slimbus2 Playback", NULL, "SLIMBUS_2_RX"},
-- 
2.25.1

