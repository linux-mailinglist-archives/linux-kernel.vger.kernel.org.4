Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1AF6EFFFE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 05:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242808AbjD0D51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 23:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239857AbjD0D5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 23:57:23 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC0E2686
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 20:57:22 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-524b02cc166so4591105a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 20:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682567842; x=1685159842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhCOIWu5TyYboPWbdE5sGErQUzQeTZ3Ep4X13Ctc3Mc=;
        b=THVAPf/sJ9XbPlx4VFMwYf/sH8XzYmCLlTS+GixH/Hf/4I8JFrwhvFayxf7EQzZNqJ
         Y4ZHKZFprJVzEW9aqzYmfPgJtv4ess0b1n1GXiLiG3x+0+zgeIS/DN8e5O2Tbo93PANk
         5WJ6HE3PEoe4UJPHAWj1PnLofqErfs7zGrcc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682567842; x=1685159842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhCOIWu5TyYboPWbdE5sGErQUzQeTZ3Ep4X13Ctc3Mc=;
        b=HDaf6SBCSwXxLzUhf7/jkHCZJ6xu/5FwiJaTzD+lwUG9YqqvTPsMLEq0OXw2Ay+fYi
         k11dpOlkPEfVEf1u1vxAi1MlUdSPGiR5OnFtlva95tJ/WStDCUpnQgeyTiDClC6ZdkAk
         eKS081Ixx0h6Q4g/iW9OEnpnGNr05+dV8u8W1d07gBbn85BeQeviBgaqX5+uPpoDYPWj
         LxsrLojwkL6Egr55OBU/6DgWxUGI1X1DMInobwZnHGdxpyjOVw+mLCakANRbSKs7W9oB
         ZDSgPBxrqW4vGymMsLFI5iLFAZwKoj41XpJ9ik6AvU34WlGsyz3bENrqxnvkscRAe9/l
         6aoA==
X-Gm-Message-State: AC+VfDz+lv0D/Gc3LZJhZUUQfnzsT0F6pbFzugJnmJUpVeLO/ZZEJ20I
        HaYkqhPtYYNGppUMIzDigj0Grg==
X-Google-Smtp-Source: ACHHUZ6+ODO9AiLzuUo+FLt7d2YQ0MHqALu5dymdPnnaR9OUwMHNGLKwHS6bsK+sP6eF7yD0+jXoAw==
X-Received: by 2002:a17:90b:204d:b0:247:a272:71be with SMTP id ji13-20020a17090b204d00b00247a27271bemr369502pjb.46.1682567842239;
        Wed, 26 Apr 2023 20:57:22 -0700 (PDT)
Received: from fshao-glinux.tpe.corp.google.com ([2401:fa00:1:10:dcf6:797f:140d:6d])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090ae00100b002471f9a010dsm12214092pjy.21.2023.04.26.20.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 20:57:21 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     Jeff LaBundy <jeff@labundy.com>,
        Douglas Anderson <dianders@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mediatek <linux-mediatek@lists.infradead.org>,
        Fei Shao <fshao@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: input: goodix: Add "goodix,no-reset-during-suspend" property
Date:   Thu, 27 Apr 2023 11:56:55 +0800
Message-ID: <20230427035656.1962698-2-fshao@chromium.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
In-Reply-To: <20230427035656.1962698-1-fshao@chromium.org>
References: <20230427035656.1962698-1-fshao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We observed that on Chromebook device Steelix, if Goodix GT7375P
touchscreen is powered in suspend (because, for example, it connects to
an always-on regulator) and with the reset GPIO asserted, it will
introduce about 14mW power leakage.

To address that, we add this property to skip reset during suspend.
If it's set, the driver will stop asserting the reset GPIO during
power-down. Refer to the comments in the driver for details.

Signed-off-by: Fei Shao <fshao@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: Jeff LaBundy <jeff@labundy.com>
---

(no changes since v2)

Changes in v2:
- Use a more accurate property name and with "goodix," prefix.

 .../devicetree/bindings/input/goodix,gt7375p.yaml        | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
index ce18d7dadae2..1edad1da1196 100644
--- a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
+++ b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
@@ -43,6 +43,15 @@ properties:
       itself as long as it allows the main board to make signals compatible
       with what the touchscreen is expecting for its IO rails.
 
+  goodix,no-reset-during-suspend:
+    description:
+      Set this to true to enforce the driver to not assert the reset GPIO
+      during suspend.
+      Due to potential touchscreen hardware flaw, back-powering could happen in
+      suspend if the power supply is on and with active-low reset GPIO asserted.
+      This property is used to avoid the back-powering issue.
+    type: boolean
+
 required:
   - compatible
   - reg
-- 
2.40.1.495.gc816e09b53d-goog

