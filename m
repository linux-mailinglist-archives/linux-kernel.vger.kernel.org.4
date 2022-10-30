Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71AE612BE2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 18:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJ3R0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 13:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiJ3R01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 13:26:27 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0299FC7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 10:26:26 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y4so8940496plb.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 10:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V80UGbFaefodELDsnmOH1hIVX1sH5nHYnUjMRM/2dyE=;
        b=kI23bVMawUnZtojoj3JoYjTDdj1zCB29PnaZvUCvkDgWTFM0e/8pS8IQ7gf5LOUtAR
         Kz/4KtGCybjZqoi5H47WeXDYuuSoALQvrZSy8vXJDW7zaCtAoV2Il7X9pDLvrEwEmAom
         NYEXK7xOJSpiaE7IWbVgljDRknEejMatudlRlfo6E2ElpqIhIecpDd3+CACp54gc8S22
         Dsa3AeZVTvKqAXAD5Rq+nIK/0Yr9lh0UfzT1anQv1v8I38voK7KO+tC8lChtPsRmu+GV
         r/evczQqJVEVs/yk0olvUpxv0gNAX5oaKUz0+rvImnDTAkefCdqGs8qbWhK04fS4KF6o
         2ISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V80UGbFaefodELDsnmOH1hIVX1sH5nHYnUjMRM/2dyE=;
        b=le+prpTW3ggMCXea1/S+VJv7Bw3Fe7hj9S4/gO35R26BKNpORk8R9WwEcrZ0d4iYJN
         v5e+d1Tkb/qlRnXBHHC99IffFcjti5gO4Cze+N0mDHV+6oCW+Wneze8wUB8MQiQ45Q80
         wWh+fmGSdjIAWqbZEnL/ZMoMKV/Yyg2xh1xjeK+wc1OsoDtbg56O+zS6oyRXgs+aRhXP
         jvB03ycyT6K7SvART8gWF446c2tG2xLxNh+zY42HscQ5ZoE1Kul3N8aA7V+n+n+NEI/0
         xojtA8nivPFZdpAeMP1U76sXCRKABB6U3w/LuWTzRpTEopfZVR1y2Oqp62BQ0/KLpzzm
         mWLA==
X-Gm-Message-State: ACrzQf3PQPqgqTyxMLeGZlNAwMcdnFNgoxUk/H64ZdrxVcEYEaacaO8q
        5eWn6i7ySgNsvVXcoviLLEnKitdbRL+1pg==
X-Google-Smtp-Source: AMsMyM5mLUixD4AFeMv/fO9d/F4MvRCyMhpZRQgxNtDO833SzZnEAml0bZqv/D126e+xIFxmrHAMkQ==
X-Received: by 2002:a17:903:4d4:b0:17f:7ecc:88e3 with SMTP id jm20-20020a17090304d400b0017f7ecc88e3mr9668808plb.169.1667150785495;
        Sun, 30 Oct 2022 10:26:25 -0700 (PDT)
Received: from localhost.localdomain (118-167-185-125.dynamic-ip.hinet.net. [118.167.185.125])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b00186c6d2e7e3sm2933881plb.26.2022.10.30.10.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 10:26:25 -0700 (PDT)
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
Subject: [PATCH v4 1/2] ASoC: mediatek: dt-bindings: modify machine bindings for two MICs case
Date:   Mon, 31 Oct 2022 01:26:08 +0800
Message-Id: <20221030172609.1635096-2-ajye_huang@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221030172609.1635096-1-ajye_huang@compal.corp-partner.google.com>
References: <20221030172609.1635096-1-ajye_huang@compal.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a property "dmic-gpios" for switching between two MICs.

Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Change-Id: I5b59ac23e761fdc078a2227da14fe170c8df6388
---
 .../sound/mt8186-mt6366-rt1019-rt5682s.yaml         | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml b/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml
index 4fc5b045d3cf..8c24cd1f1906 100644
--- a/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml
@@ -21,6 +21,13 @@ properties:
     $ref: "/schemas/types.yaml#/definitions/phandle"
     description: The phandle of MT8186 ASoC platform.
 
+  dmic-gpios:
+    maxItems: 1
+    description:
+      dmic-gpios optional prop for switching between two DMICs.
+      Ex, the GPIO can control a MUX HW component to select
+      dmic clk and data form a Front or Rear dmic.
+
   headset-codec:
     type: object
     additionalProperties: false
@@ -68,9 +75,13 @@ examples:
         compatible = "mediatek,mt8186-mt6366-rt1019-rt5682s-sound";
         mediatek,platform = <&afe>;
         pinctrl-names = "aud_clk_mosi_off",
-                        "aud_clk_mosi_on";
+                        "aud_clk_mosi_on",
+                        "aud_gpio_dmic_sec";
         pinctrl-0 = <&aud_clk_mosi_off>;
         pinctrl-1 = <&aud_clk_mosi_on>;
+        pinctrl-2 = <&aud_gpio_dmic_sec>;
+
+        dmic-gpios = <&pio 23 0>;
 
         headset-codec {
             sound-dai = <&rt5682s>;
-- 
2.25.1

