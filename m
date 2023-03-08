Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551016AFFD1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjCHHfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCHHfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:35:34 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CC41F921;
        Tue,  7 Mar 2023 23:35:25 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g3so62151220eda.1;
        Tue, 07 Mar 2023 23:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678260924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydV0x0rwcG3ZlgXY+mzQMZLrMJgGqY0Ocp8WqRfbhXI=;
        b=gZlq2Kkuk9VLf2wxgDlvBqUxwWF3QUw0OTvuvL7dyaApcUu6d9KZd+JG8HMT8ap3JW
         Vx0G32zrjk7Qq6UIsYqSLg7fAPNk3ZBBI4Zw+vKtZUNAQELBG8jT55lEvaLIaBFC/4Uw
         9RrR5NmXkShLV4u+rXiFjbujReIG/tUArH2pXfQczAe3ObVR6ijZXXziCIXvfCB8ANS4
         umNWknNKdgS3mcr1PMkYI0jgoVJCpQx+/HfpsLmCv76fHxfuEShXpo6469Y8iCq/VY8T
         AE5lBlFm4Luuy/Wu/Mt/aPjTrFrjUP+10XLRw7GfR3/IDq8xLSWJGWlClXgZaqHrQ8vK
         VofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678260924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydV0x0rwcG3ZlgXY+mzQMZLrMJgGqY0Ocp8WqRfbhXI=;
        b=o/MrYbURsT+8kDRdwfPnaF9KRYNNP+R0IAoafhdbEYdSorD+x/eSl2Urq9f8YcmU9A
         NNAiu3zaHsx7Xg37D5XBLrmascku38V/Pwjfnh0ITEsAp2+h5IiYC/nyFVpTYkFzvCTF
         /KI4LDoFQOA2pD7zezOpcYLIQEP34U9uanF0TS+C5pbWGyGY5CrEU0GHHW2hKHdk7wbk
         rYxE0dKQi9SlD32wPnt3CNvzmib2ycb1MIhcRCYm67OeZna5VxUVx/TkqTAe0YxWaDmO
         JJNBSvq6CSUIA9FIrv0dVLiFFsELxQR8ooQ31INwqeJQ+tZddKxKzLGudd+HpwGU8T6+
         l0ZA==
X-Gm-Message-State: AO0yUKU8Ld/UwrjBDUma2RUTPRjy32OM6tc5A1sfNuG9lChb6Qsb8xbe
        1yU+IwHyBzlh866O1Q95joo=
X-Google-Smtp-Source: AK7set+MqghAbh20u08oxbKMjKhLU7Z9/418ZjJYV3F5ElaxH2EboSHQ2QntlQLxgJ4yVw5eng/I3w==
X-Received: by 2002:a17:907:7e82:b0:8f4:6efd:833f with SMTP id qb2-20020a1709077e8200b008f46efd833fmr21620650ejc.3.1678260924049;
        Tue, 07 Mar 2023 23:35:24 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id h15-20020a1709062dcf00b008dffda52d71sm7051880eji.124.2023.03.07.23.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 23:35:23 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v2 1/8] dt-bindings: sound: nvidia,tegra-audio-common: add coupled-mic-hp-detect property
Date:   Wed,  8 Mar 2023 09:34:55 +0200
Message-Id: <20230308073502.5421-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230308073502.5421-1-clamor95@gmail.com>
References: <20230308073502.5421-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nvidia,coupled-mic-hp-det property to use Mic detect GPIO only
if HP GPIO is in active state.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../devicetree/bindings/sound/nvidia,tegra-audio-common.yaml  | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-common.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-common.yaml
index 82801b4f46dd..7c1e9895ce85 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-common.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-common.yaml
@@ -80,4 +80,8 @@ properties:
     type: boolean
     description: The Mic Jack represents state of the headset microphone pin
 
+  nvidia,coupled-mic-hp-det:
+    type: boolean
+    description: The Mic detect GPIO is viable only if HP detect GPIO is active
+
 additionalProperties: true
-- 
2.37.2

