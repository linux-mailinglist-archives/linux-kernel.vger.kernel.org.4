Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024E6611937
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiJ1RWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiJ1RW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:22:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7D8229E71
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:22:28 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so10429355pjc.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFMOsXdTB5Df8ggzsilthr4+D/qAdNxZr6+urTN5nT0=;
        b=8U/f+2hJhjF5TA6s84eiTLKl/O3fHVNMKbmkkAJ5FX/aRcszHn6fJBjnhGYYHQFhG2
         fTBTsLcL84cBOXGg2Q2mgiqcOwDnk0opQiYBNiOu+hlqD6C3F0E27LwvFgrg+Gg2KVws
         IY4kwfWNNnR2taX0KaH5Xdz+RlGQDTjTI2U7QhXlmr6JX79RWzIM7O4kL64obG6g93Ap
         mWD4qOOieD+oZ44d4vdRDuRIkCdVolcJZunUq0em5vrp7EzLh/2OkrNn4jIuIg3M2bYE
         cuTIJeKO+N8Hd8kHyOTSeNXd5vXuSV/aBQl2AyhpHg9klUbUKNp4gciAvT5jrIToqZuN
         lHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFMOsXdTB5Df8ggzsilthr4+D/qAdNxZr6+urTN5nT0=;
        b=jiG5Fy6VhqtRTDfBEk7OKr+MZBCCG7MAiFuR+0N26xoBJyujtPgoGs103OmVsisgBw
         ntl4B7WQMhj5FKapbAGqnxYLnTkFUftRZ4hAOA70TY6EqXLjWbZ7+SR+I88+uJa/w3S6
         v+r/YwhqZWEWxjNjaqu/fYeOcKZX90GeUQBEA8l1YTdR6y8YtUkgVj9jEnRetjt4WVjk
         NludcI9ibYkxGksV1qjSpsy7CZFGLJcy9IPixV8/Y7zrgIQ1JB0r6EkwylirunFuNe/j
         i5npMJ8Yi/9oKqGmKRblAyG8is7AVnD7NcxqXJKW2kncpGOP3KlGkaFclJrKqvD8tQTA
         KT3Q==
X-Gm-Message-State: ACrzQf322KJrGL7bsSKLcgHg16KVQShNkv/1H4H5frzxeG63QNtAfJ4q
        hDpEtVGPlQHv9saaN4ZK2tXJQlxEW7VzRA==
X-Google-Smtp-Source: AMsMyM7tCLeMSIkzuM8wzGQXwgjziB10x1ohi/U73N7eYMIHY7EgkGmX+ArJKDN2eNOxLRCaa23Crw==
X-Received: by 2002:a17:902:968f:b0:180:a7ff:78ba with SMTP id n15-20020a170902968f00b00180a7ff78bamr10947plp.87.1666977747715;
        Fri, 28 Oct 2022 10:22:27 -0700 (PDT)
Received: from localhost.localdomain (118-167-210-30.dynamic-ip.hinet.net. [118.167.210.30])
        by smtp.gmail.com with ESMTPSA id rm10-20020a17090b3eca00b0021282014066sm4604945pjb.9.2022.10.28.10.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 10:22:27 -0700 (PDT)
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        "chunxu . li" <chunxu.li@mediatek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v2 1/2] ASoC: mediatek: dt-bindings: modify machine bindings for two MICs case
Date:   Sat, 29 Oct 2022 01:22:14 +0800
Message-Id: <20221028172215.1471235-2-ajye_huang@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221028172215.1471235-1-ajye_huang@compal.corp-partner.google.com>
References: <20221028172215.1471235-1-ajye_huang@compal.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a property "dmic-gpios" for switching between two MICs.

Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
---
 .../bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml b/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml
index 4fc5b045d3cf..212d2982590a 100644
--- a/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml
@@ -21,6 +21,10 @@ properties:
     $ref: "/schemas/types.yaml#/definitions/phandle"
     description: The phandle of MT8186 ASoC platform.
 
+  dmic-gpios:
+    maxItems: 1
+    description: GPIO for switching between DMICs
+
   headset-codec:
     type: object
     additionalProperties: false
@@ -72,6 +76,8 @@ examples:
         pinctrl-0 = <&aud_clk_mosi_off>;
         pinctrl-1 = <&aud_clk_mosi_on>;
 
+        dmic-gpios = <&pio 23 0>;
+
         headset-codec {
             sound-dai = <&rt5682s>;
         };
-- 
2.25.1

