Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC36611726
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiJ1QLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiJ1QKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:10:43 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945FB22BC80
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:08:03 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id e129so5201299pgc.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFMOsXdTB5Df8ggzsilthr4+D/qAdNxZr6+urTN5nT0=;
        b=zZC+U/aHqGW7IFAZAT+3MMfxAOCLrwRbrJkGx9aRZlZrEK91b5LV1yRvLpqRDKms3n
         HHh3MTsvqFGJ/6gBEXzoUu4QNQm4x+M5zMZoHQSh1XrxC7dP0sP7PaqvUHScU9mHRVZj
         Pm1N6esyC8jfpG2CkBLI+W0+OkuIIGw2WISEC4Bl8RmLPYpj+fWY7axdG/qxuLgSUpqN
         tk1FQm/M6TntPVogLH8KS2suatkgPh4NfmWHdJUZvlsHMqlNK0wBiWnzB+ays6G84Dyz
         akSHt18VG5GweZWQkvuufNNZ4ndduvth9ndhCjRTuaof2qnOxK5OI5l4exDYBn3s1wbV
         ETyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFMOsXdTB5Df8ggzsilthr4+D/qAdNxZr6+urTN5nT0=;
        b=lpLuBZw2dh4HBepuZSzcl01d3s3Wgm9DMzSmGTdCCwUAbGW4JZiq6ZM9Pe88TGMl3t
         S1JxIjgrkKukISRIhFFkH8tO4CbAujGIfjcksAWs9Tx8Sgz9XR5Ufq69F3M2gQ0EHvgP
         Fs5/tvOEjdDviZXPJyCzVYVILKbq9DSrmfxtHbU8bWN8RWoPlJiGZnvuJcMBCxiB2Ye/
         I2h7sf5J5oJl+jR+qDVa7hxDMa3W6FcXiE36yVkQ9sTj2BCxtwWcXjNIR4mryAIMWNca
         FAG5x79zxPUR4w3xFwOW2pCAX8neMWcCIW4hOPLsky/IoSf+ZT9MswnNwn17cq2M42WA
         zolA==
X-Gm-Message-State: ACrzQf2ZoozGli8rpIdSOI4SvdVQd3PWItPpMVHT8DhJiGZGZNMgqcwV
        RLKluDA0aW2ZfXWzcdWv8oPdyYycbkbv3g==
X-Google-Smtp-Source: AMsMyM7yJoeG8ckb4rHiQkGpwA6IxAzvmzG5yzqEtCKG0mybBC/dVnuYOEDRHXiy3eVt9wfYq8Dirg==
X-Received: by 2002:a65:5b0b:0:b0:462:da7a:1ded with SMTP id y11-20020a655b0b000000b00462da7a1dedmr179239pgq.605.1666973282863;
        Fri, 28 Oct 2022 09:08:02 -0700 (PDT)
Received: from localhost.localdomain (118-167-210-30.dynamic-ip.hinet.net. [118.167.210.30])
        by smtp.gmail.com with ESMTPSA id b70-20020a621b49000000b0056abfa74eddsm3112071pfb.147.2022.10.28.09.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 09:08:02 -0700 (PDT)
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
Subject: [PATCH v1 1/2] ASoC: mediatek: dt-bindings: modify machine bindings for two MICs case
Date:   Sat, 29 Oct 2022 00:07:32 +0800
Message-Id: <20221028160733.1390230-2-ajye_huang@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221028160733.1390230-1-ajye_huang@compal.corp-partner.google.com>
References: <20221028160733.1390230-1-ajye_huang@compal.corp-partner.google.com>
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

