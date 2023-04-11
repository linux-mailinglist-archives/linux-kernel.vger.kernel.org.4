Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CBD6DE4E4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 21:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjDKTWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 15:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjDKTWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 15:22:22 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1678F618D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:22:00 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id i20so13050536ybg.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681240919; x=1683832919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UKK5UX1sxA/fn51ycSNCkY1kfW7huepZ1JtlF3gmCU=;
        b=MODAKOLAe1mrFHbVLmSTy4tXpGrI6txQIJfm5HU7lN1WAtmS7oqJ7klQsvQAaLo3Mv
         k8OMqRaomz/vkCR9BzzUkJJv28dzjJvu2nY8yN03/fbdeRP2ul5C3BOPODjVzN1fjkmK
         /WmeqkGRYSOVzBsjuQZyqTqHPf3MZiaBOuQN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681240919; x=1683832919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UKK5UX1sxA/fn51ycSNCkY1kfW7huepZ1JtlF3gmCU=;
        b=MX0II+n85zwQOc6AVYpZ9X/DZCLvw2Re1UsDnjcifeU83YvYz4EPKYNTkqKgGC2ozd
         BfTABcyH2QxyglnknpHY1PXX79PNFv9khUWqXEyNniSnBRN5HEFP37sOjUHfBn7kVRGd
         5WuknKiwbMjOF8IVo3EeF5C5hLmpqnJcYJgV2oOZcPDcyF4ca+pzTrH5I5Iy/fjwr6+Z
         IaVhwEoKzwd/iiOTU8TnTEUSlUFPskdRFTPgWzuRegqsnB8ZbL2JVL9BjpxHLjG6FZfv
         27jxA/+WvaWVngyS9a5P6HKmsnlyakLoxObCuy5AbKBFOU+LV3N4gCTCWZoUXoOm/exH
         nwCw==
X-Gm-Message-State: AAQBX9c/m+onPyeqVHk+Of6GleGq9u4acwBHFBsJ/tSpM3e0ht17z8Uz
        7/P+0d8lxgHRNnjm5Gq9s4lDmA==
X-Google-Smtp-Source: AKy350Y0AFVRCh26uZEEXl/caeeSKSUSmctYd6tMGvN9clthojK4HZRfhP/DRCF/UTqrV0O1hw6atA==
X-Received: by 2002:a25:6d87:0:b0:b8e:e918:33ac with SMTP id i129-20020a256d87000000b00b8ee91833acmr5372721ybc.1.1681240919489;
        Tue, 11 Apr 2023 12:21:59 -0700 (PDT)
Received: from localhost ([2620:0:1035:15:2991:9b76:4e62:65bf])
        by smtp.gmail.com with UTF8SMTPSA id u74-20020a25ab50000000b00b7767ca7485sm3834942ybi.34.2023.04.11.12.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 12:21:59 -0700 (PDT)
From:   Mark Yacoub <markyacoub@chromium.org>
X-Google-Original-From: Mark Yacoub <markyacoub@google.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     seanpaul@chromium.org, suraj.kandpal@intel.com,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Mark Yacoub <markyacoub@chromium.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 09/10] arm64: dts: qcom: sc7180: Add support for HDCP in dp-controller
Date:   Tue, 11 Apr 2023 15:21:33 -0400
Message-Id: <20230411192134.508113-10-markyacoub@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230411192134.508113-1-markyacoub@google.com>
References: <20230411192134.508113-1-markyacoub@google.com>
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

From: Sean Paul <seanpaul@chromium.org>

Add the register ranges required for HDCP key injection and
HDCP TrustZone interaction as described in the dt-bindings for the
sc7180 dp controller.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Mark Yacoub <markyacoub@chromium.org>

---
Changes in v3:
-Split off into a new patch containing just the dts change (Stephen)
-Add hdcp compatible string (Stephen)
Changes in v4:
-Rebase on Bjorn's multi-dp patchset
Changes in v5:
-Put the tz register offsets in trogdor dtsi (Rob C)
Changes in v6:
-Rebased: Removed modifications in sc7180.dtsi as it's already upstream
Changes in v7:
-Change registers offset

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 423630c4d02c7..89d913fa6e3eb 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -822,6 +822,14 @@ &mdss_dp {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&dp_hot_plug_det>;
+
+	reg = <0 0x0ae90000 0 0x200>,
+	      <0 0x0ae90200 0 0x200>,
+	      <0 0x0ae90400 0 0xc00>,
+	      <0 0x0ae91000 0 0x400>,
+	      <0 0x0ae91400 0 0x400>,
+	      <0 0x0aed1000 0 0x174>,
+	      <0 0x0aee1000 0 0x2c>;
 };
 
 &mdss_dp_out {
-- 
2.40.0.577.gac1e443424-goog

