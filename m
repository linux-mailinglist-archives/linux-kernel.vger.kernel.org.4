Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3379E7270F6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 23:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjFGVyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 17:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjFGVxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 17:53:45 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF7A269A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 14:53:30 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-652328c18d5so3865982b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 14:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686174810; x=1688766810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXrYtUuCuWvkbV7L1gPu5v5c01AxUbntKP7msewlmBY=;
        b=VPtavFwrSLAnsChx0O9sOQZYBq1ojrqZEAOSN9K2H5D+oyhkPzKm1AqgA4P47Pf5oh
         O8BG7TF+uwHJXH1rO/mOL9Oga2y26MvCYhRwbSAF/7bdKs8d+B6F5pZXdFPrDqgi3EQP
         EzWvrRr+x12vJ7tl4U0Canch7ihXb8a8DBjks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686174810; x=1688766810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXrYtUuCuWvkbV7L1gPu5v5c01AxUbntKP7msewlmBY=;
        b=RL/8/OZlG4ywOQP7a3zNGeriuguoboxAej8kz0kDSPI+oEBCD9zkOaYHnWEYNt76N4
         Wy8b2IAKrdcvwyugBupVcT6I8VI/DCVpJWpc+Jlg1inQOx2hy56rEVkbJC0vCqOLJIYp
         h7R9+xmu8LVpWMBPJh+Z80uCCuYhJZe5H4hBTk0pdEUoNxvuiQ6B2lrv2U2Qon/jNryn
         kjnvYan9Hht5amQXeFjaaoQge5ZTPUSp5GfwrLGdQVzKK/IyaM2rMI/4WmE8xYMycg8X
         +fhOt25ueU86L7yWB3sPB67STXS5spbxltkUJLd5qbgfg4eNGcneRPXNzrjnzO9X2fKN
         wqig==
X-Gm-Message-State: AC+VfDyy9mJt65t4/pFYVnAFODrVTL5VLmnZFZBf4iNrXcsxx6E8fxKR
        QNzgs2MLSyv4Zk3WHvqopvyPpg==
X-Google-Smtp-Source: ACHHUZ5bFX6isITbSdGTCwRLcU7Gw3ebiIVWNaaFurz8NR3mHaewyosZt0XNEE7p9+xHiFDr1q+2Qg==
X-Received: by 2002:a05:6a20:9384:b0:111:92ef:314e with SMTP id x4-20020a056a20938400b0011192ef314emr2361644pzh.35.1686174810186;
        Wed, 07 Jun 2023 14:53:30 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:34b2:b638:6b53:f6c2])
        by smtp.gmail.com with ESMTPSA id j25-20020aa78d19000000b0065dd1e7c2c1sm1376486pfe.63.2023.06.07.14.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 14:53:29 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, hsinyi@google.com,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        yangcong5@huaqin.corp-partner.google.com,
        linux-arm-msm@vger.kernel.org,
        Chris Morgan <macroalpha82@gmail.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 10/10] arm64: dts: qcom: sc7180: Link trogdor touchscreens to the panels
Date:   Wed,  7 Jun 2023 14:49:32 -0700
Message-ID: <20230607144931.v2.10.Ia06c340e3482563e6bfd3106ecd0d3139f173ca4@changeid>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230607215224.2067679-1-dianders@chromium.org>
References: <20230607215224.2067679-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's provide the proper link from the touchscreen to the panel on
trogdor devices where the touchscreen support it. This allows the OS
to power sequence the touchscreen more properly.

For the most part, this is just expected to marginally improve power
consumption while the screen is off. However, in at least one trogdor
model (wormdingler) it's suspected that this will fix some behavorial
corner cases when the panel power cycles (like for a modeset) without
the touchscreen power cycling.

NOTE: some trogdor variants use touchscreens that don't (yet) support
linking the touchscreen and the panel. Those variants are left alone.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi        | 1 +
 arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi      | 1 +
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi         | 1 +
 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi        | 1 +
 arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi | 1 +
 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi   | 1 +
 6 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
index 8b8ea8af165d..b4f328d3e1f6 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
@@ -104,6 +104,7 @@ ap_ts: touchscreen@5d {
 		interrupt-parent = <&tlmm>;
 		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
 
+		panel = <&panel>;
 		reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
 
 		vdd-supply = <&pp3300_ts>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
index b3ba23a88a0b..88aeb415bd5b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -116,6 +116,7 @@ ap_ts: touchscreen@14 {
 		interrupt-parent = <&tlmm>;
 		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
 
+		panel = <&panel>;
 		reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
 
 		vdd-supply = <&pp3300_touch>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
index 269007d73162..c65f18ea3e5c 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
@@ -43,6 +43,7 @@ ap_ts: touchscreen@10 {
 		interrupt-parent = <&tlmm>;
 		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
 
+		panel = <&panel>;
 		post-power-on-delay-ms = <20>;
 		hid-descr-addr = <0x0001>;
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
index 6c5287bd27d6..d2aafd1ea672 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
@@ -102,6 +102,7 @@ ap_ts: touchscreen@10 {
 		interrupt-parent = <&tlmm>;
 		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
 
+		panel = <&panel>;
 		post-power-on-delay-ms = <20>;
 		hid-descr-addr = <0x0001>;
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
index 8e7b42f843d4..0785873d1345 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
@@ -99,6 +99,7 @@ ap_ts: touchscreen@10 {
 		interrupt-parent = <&tlmm>;
 		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
 
+		panel = <&panel>;
 		post-power-on-delay-ms = <20>;
 		hid-descr-addr = <0x0001>;
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
index 262d6691abd9..f70f5b42c845 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
@@ -154,6 +154,7 @@ ap_ts: touchscreen@1 {
 		interrupt-parent = <&tlmm>;
 		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
 
+		panel = <&panel>;
 		post-power-on-delay-ms = <70>;
 		hid-descr-addr = <0x0001>;
 
-- 
2.41.0.162.gfafddb0af9-goog

