Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E383A648776
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiLIRNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiLIRNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:13:22 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCEB42998
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:13:16 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id jn7so5513980plb.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 09:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30dMEap98zmC9FjobmK4HAr7EsnBPy2I728S8irHPHo=;
        b=SqpXkBzUzzGdcOEoAZiSACFm/WChD89j4Uxx9+5wm9SE08kj3TH0SDV2/fXJRh5+qK
         aV4iJdKWBV8EzVE91QPEG6iCBSwF7jeXbR9Z+mCho7sHhrPP7WGsD4B30zu3aSq682pa
         vt5znMBOCJDHjSVvhlRMW1B44dTeLKeDF6RmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30dMEap98zmC9FjobmK4HAr7EsnBPy2I728S8irHPHo=;
        b=UPGLwhtaegP+jiq81fwSMvGq7NGY1Gq09iprUqEiKE4+kZxS2fGbtmfQjKhd5ofc9b
         wQ0iYgsFIbeV/q5iSoKWbUyZASDRSJ2pQi7td8vXwUHY8SQfGbXC4DYhiSfFpZrH4e8a
         cjwkGsQjfhdml2PQt7QRJwUQ1Phs7YsRiie557pmRVhOirx+xqICvVjfra417fM58TeL
         YL1/+7Fp+OWfYWorNmChPbbxE3bU7R6gIK7ItJnls2X2s8NfJVc4nretYNvvqlRWDyg5
         /P0i+WC5OPMDi2ZYmsBvlrYvoaYZupnMDL3QIkGldwdlL+XnrJPfeGSFKLnz2wze9we0
         47Vw==
X-Gm-Message-State: ANoB5pn1ewBJbtRQkkgzue1E04qi0evcAswgRUgXegXB4sKm1L3fx1si
        yjQF7XaTz4x4Dav/2J2kvYZ+uw==
X-Google-Smtp-Source: AA0mqf7EnY6+VbLUEEY1RBV1EuWIccn+GFpNszeaWwG5gFJuHFttoTTi32iO7IMLJwflvkCf77UVRw==
X-Received: by 2002:a17:902:9881:b0:185:441e:4d0e with SMTP id s1-20020a170902988100b00185441e4d0emr6484880plp.62.1670605996123;
        Fri, 09 Dec 2022 09:13:16 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9a82:7898:7bf4:b4f])
        by smtp.gmail.com with ESMTPSA id j16-20020a170902da9000b00189c62eac37sm1597503plx.32.2022.12.09.09.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 09:13:15 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     swboyd@chromium.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        mka@chromium.org, Yunlong Jia <ecs.beijing2022@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-input@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] arm64: dts: qcom: sc7180: Add trogdor eDP/touchscreen regulator off-on-time
Date:   Fri,  9 Dec 2022 09:12:38 -0800
Message-Id: <20221209091234.v3.2.I65ac577411b017eff50e7a4fda254e5583ccdc48@changeid>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221209171240.1614904-1-dianders@chromium.org>
References: <20221209171240.1614904-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In general, the timing diagrams for components specify a minimum time
for power cycling the component. When we remove power from a device we
need to let the device fully discharge and get to a quiescent state
before applying power again. If we power a device on too soon then it
might not have fully powered off and might be in a weird in-between /
invalid state.

eDP panels typically have a time that's at least 500 ms here. You can
see that in Linux's panel-edp driver nearly every device specifies a
"unprepare" time of at least 500 ms. This is a common minimum and the
500 ms is even in the example in the eDP spec.

In Linux, the "panel-edp" driver enforces this delay for its own
control of the regulator, but the "panel-edp" driver can't do anything
about other control of the regulator (for instance, by the touchpanel
driver).

Let's add 500 ms as a board constraint for the regulator that's used
for eDP/touchpanel on trogdor boards. If a given trogdor board stuffs
only panels that can use a shorter time or stuff some panels that need
a larger time then they can manually adjust this timing.

We'll only do this minimum delay for trogdor devices with eDP (ones
that use either bridge chip), not for devices with MIPI panels. MIPI
panels could have similar constraints but the 500 ms isn't necessarily
as standard and there are no known cases where this delay is needed.

For most trogdor boards, this doesn't actually seem to affect anything
when testing against shipping Linux. However, with pazqel360 it seems
that this does make a difference. It seems that the touchscreen on
this board _also_ needs some time for the regulator to discharge. That
time is much less than 500 ms, so we'll just put the eDP panel 500 ms
in there since the board constraint should be the "max" of the
components.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---

(no changes since v2)

Changes in v2:
- Fix typo in commit message (Matthias)

 .../boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi  | 12 ++++++++++++
 .../boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi   | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi
index ebd6765e2afa..e27a769f8cd4 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi
@@ -26,6 +26,18 @@ pp3300_brij_ps8640: pp3300-brij-ps8640-regulator {
 	};
 };
 
+/*
+ * ADDITIONS TO FIXED REGULATORS DEFINED IN PARENT DEVICE TREE FILES
+ *
+ * Sort order matches the order in the parent files (parents before children).
+ */
+
+&pp3300_dx_edp {
+	off-on-delay-us = <500000>;
+};
+
+/* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
+
 &dsi0_out {
 	remote-endpoint = <&ps8640_in>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi
index 65333709e529..3188788306d0 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi
@@ -7,6 +7,18 @@
 
 #include <dt-bindings/gpio/gpio.h>
 
+/*
+ * ADDITIONS TO FIXED REGULATORS DEFINED IN PARENT DEVICE TREE FILES
+ *
+ * Sort order matches the order in the parent files (parents before children).
+ */
+
+&pp3300_dx_edp {
+	off-on-delay-us = <500000>;
+};
+
+/* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
+
 &dsi0_out {
 	remote-endpoint = <&sn65dsi86_in>;
 };
-- 
2.39.0.rc1.256.g54fd8350bd-goog

