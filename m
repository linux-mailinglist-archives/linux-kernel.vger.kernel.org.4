Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB326F8717
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 18:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjEEQza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 12:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjEEQz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 12:55:28 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB19619427
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 09:55:26 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f415a9015bso508715e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 09:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683305725; x=1685897725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L3GpvKdXnUbv3/06jF20p2wjzRq6DzJPnthy2LMuYWA=;
        b=X4cFhQpexPgpiVzeKDoIVe1f5KH9FnPWl+bvlAJbfLZrhyLSpwgP/sU1IJ1i25x/YD
         C1vySuirB2jOIt0kNuzjHYK20WAhit8JcVgzBt4ZIjjjMDM++PnXb+5BClRWY608yImG
         hgCiP2UgDHpaN89G0zTTmnymOMZOuA9jap6sfndvqXHI5t7wwy0Fo9wXX3mpK7pvYeVk
         s5JwSSsK8R4APt/fcKnlnee51w5MRyQ4P6P7e5s9KD95q2VmV5GTvuUtlYAjK2jmc0Y1
         jWaYn0HfhjOsxKFfE35gP9i2OZfGjW8stUxYp03FJc7EyS7Qfbz9/KU7LIAaeuBomF+/
         QtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683305725; x=1685897725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3GpvKdXnUbv3/06jF20p2wjzRq6DzJPnthy2LMuYWA=;
        b=RFQpN5OrqWjJtZa9R5tqvBdg2jhmLwnIHuphHH7C34Pa/yTTmvq4vMzrkHEMHvPI6v
         Mgs9VZNYuPfz64u7NxbQ3KUI5lU40aUjVw7AyVnj91OeQ5Q0rQcBD/5VgeTvPYDF+ERG
         4X0Pklf6Lsi1BSjFSK5YmVuzUbzW2tHCmCcdwHLTWFAWhl0oNVR6vpRMxnydwv5b1Ls0
         5dR8EOcKuFCcQOPm0i6coIgcFTF+uUTyqPOEBcuTGr4LpjiOy8b+/sNVdqCea/90Xb64
         dQj/IZrzrRg0lN4F/xbZZrwvuQzNAVMu+z/HxzJc10pwa/jYc6v63nSCxK1YzQbgjGyv
         BZIg==
X-Gm-Message-State: AC+VfDxzrOoIIoXK/KnE4VuMu5illlqi+OA4rkCeM7BF4lJzVt+doc6N
        AvClmXNn9+dRwE6FcjNE+zLZ5A==
X-Google-Smtp-Source: ACHHUZ7N80D7cGL6BaynTO6FiJRBZXlGZ68zRgHBLAxYl02IPxyDf8TRFR88tz+iZNTUnCjuMiziyQ==
X-Received: by 2002:adf:e9cc:0:b0:306:45c0:f070 with SMTP id l12-20020adfe9cc000000b0030645c0f070mr1675588wrn.39.1683305725414;
        Fri, 05 May 2023 09:55:25 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id x7-20020adfffc7000000b002c7066a6f77sm2923551wrs.31.2023.05.05.09.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 09:55:24 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, tiwai@suse.com
Cc:     perex@perex.cz, lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/3] ASoC: hdmi-codec: add component name prefix to controls
Date:   Fri,  5 May 2023 17:55:11 +0100
Message-Id: <20230505165514.4666-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
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

While adding audio support to two instances of Display port on x13s,
hdmi-codec failed to add controls as two codec instances were trying
to add controls with same name.
    
snd-sc8280xp sound: control 3:16:0:IEC958 Playback Mask:0 is already present
snd-sc8280xp sound: control 3:16:0:Playback Channel Map:0 is already present
hdmi-audio-codec hdmi-audio-codec.4.auto: ASoC: error at snd_soc_pcm_dai_new on i2s-hifi: -16

To fix this issue, I have added a new api snd_pcm_add_chmap_ctls_with_prefix()
to allow to pass asoc component name prefix, which should provide a unique control
names. We can also make snd_pcm_add_chmap_ctls() take prefix argument to do the same
this.

Srinivas Kandagatla (3):
  ALSA: pcm: add snd_pcm_add_chmap_ctls_with_prefix
  ASoC: hdmi-codec: use snd_pcm_add_chmap_ctls_with_prefix to add
    controls
  ASoC: hdmi-codec: use snd_soc_cnew to add controls

 include/sound/pcm.h           |  7 +++++++
 sound/core/pcm_lib.c          | 30 ++++++++++++++++++++++++++++--
 sound/soc/codecs/hdmi-codec.c | 10 ++++++----
 3 files changed, 41 insertions(+), 6 deletions(-)

-- 
2.21.0

