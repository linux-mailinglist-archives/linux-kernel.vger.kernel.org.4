Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C25A725446
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbjFGGca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbjFGGb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:31:56 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AEE1735
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 23:31:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6e1394060so58493535e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 23:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1686119511; x=1688711511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+N6ncdPhuJx70XZ6yjaTOtXW/wJdhXZgpqu86CyLnmg=;
        b=iSFhC91P61leOakC3ZYDB1vfHeGButTdGDM1hW2MzuCfi7TC+dUY0TPp87E5Gwzxxo
         h1o6UEBegakpxBiWmhOhHQNcKItVaIWq4KsvQsneKZ0iK3g19qU++mCSiiVscT1xka+X
         S7IGHfHgN7WvF22pGm+WjoUgdt42UbaeJaUH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686119511; x=1688711511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+N6ncdPhuJx70XZ6yjaTOtXW/wJdhXZgpqu86CyLnmg=;
        b=Jb7xUPRziyl5JzNYA/DvYuc9/KDmtujLlP5nI7dHtqogHd0nqUloxgrZ7B6+BtxpS+
         Euce3U2MTO6wbc7wru0PYEMUBRmv8ouJonDoD1Xc1/CpZRl9lW8h+9w1SYo609avN8lU
         NrMpGm5BqLZLFUgKR0eZ5eEPqslHidG3OcPB2USEw9+yafVePOju27IpbDxv3itFqzyC
         iz4jXMOV8iuBSa0M8BdIksRy0tsT5nMSqiE52sx/urraOe5rb73WmFL/v9e/H8nZVmCo
         6A1u4GnUKNvQVfciD4gr/6ejX94RdyxyxeF09Jfm75WnTV+mfIZ3HrHup+BKqJAm9Dwe
         YD9A==
X-Gm-Message-State: AC+VfDwlZcWMI6/vjv5UripNgIrGkptMjWcSbhACfgNp14lQlElVtYHO
        MMWqjA/GYNe9Siqjdx4fOKg83nmQRZaEV2k5coZEqg==
X-Google-Smtp-Source: ACHHUZ5a8gfVu2axekyl+99oSLUzWfSPuWuaqcQZYuCkNPZ73b9TII++3uuK7xQc96qqlkKElumaFA==
X-Received: by 2002:adf:e80f:0:b0:30e:59e9:5e1f with SMTP id o15-20020adfe80f000000b0030e59e95e1fmr732503wrm.65.1686119511073;
        Tue, 06 Jun 2023 23:31:51 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([37.159.114.163])
        by smtp.gmail.com with ESMTPSA id m6-20020adff386000000b0030630120e56sm14385127wro.57.2023.06.06.23.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 23:31:50 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        michael@amarulasolutions.com,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org
Subject: [RESEND PATCH v2 4/6] dt-bindings: display: simple: add Rocktech RK043FN48H
Date:   Wed,  7 Jun 2023 08:31:37 +0200
Message-Id: <20230607063139.621351-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230607063139.621351-1-dario.binacchi@amarulasolutions.com>
References: <20230607063139.621351-1-dario.binacchi@amarulasolutions.com>
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

Add compatible to panel-simple for Rocktech Displays Limited
RK043FN48H 4.3" 480x272 LCD-TFT panel.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

---

Changes in v2:
- Add 'Acked-by' tag of Conor Dooley.

 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 01560fe226dd..bd6a92d2b41c 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -280,6 +280,8 @@ properties:
       - rocktech,rk101ii01d-ct
         # Rocktech Display Ltd. RK070ER9427 800(RGB)x480 TFT LCD panel
       - rocktech,rk070er9427
+        # Rocktech Display Ltd. RK043FN48H 4.3" 480x272 LCD-TFT panel
+      - rocktech,rk043fn48h
         # Samsung 13.3" FHD (1920x1080 pixels) eDP AMOLED panel
       - samsung,atna33xc20
         # Samsung 12.2" (2560x1600 pixels) TFT LCD panel
-- 
2.32.0

