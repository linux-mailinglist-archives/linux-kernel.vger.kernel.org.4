Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF22767286E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjARTbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjARTbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:31:00 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10EE5AB66
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:30:51 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id i188so36865859vsi.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whvNa1bQa9Ec01Ss8iLlJDl35nz+BH7m8TtqnPdDJwY=;
        b=ImLD5hc/tmuvomyXgF6IjzNPnrWJWOCR2+a7OULQkwKKwDj9QdI2G3eQsoQZsK++9R
         4BYRXCIJ8nkHHh5aV7YDmT2k/W2eS/ltVtSskU1+sWSLtpj3x587500gg7CYhCo2jTmt
         0KoCBfTya/mqK1EArI3IzHwezk6DGMx158GAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whvNa1bQa9Ec01Ss8iLlJDl35nz+BH7m8TtqnPdDJwY=;
        b=6PAxLTwrfvwqNkX/E2lO1Fe2qRdH9xhKf2TAhNFwPxEmDjst+EXHBx7KJ/DtQjloC6
         R1pk3rAqO03dEVcnQdi6FHbp0TeJ8nV4qAxT3RbuTNREHFj6ts+DkQinoyQeVUC5vrJY
         AVL9vUykNA8Kyn7ygNdfygrDY/SNDkbESrsfhYsjBdKAYrCCjFLiK+JTk10p8wmva8zZ
         1oWdcQC6CADa1TN6pvTPCWAeaP9vrHVVw+tG2AMitrjYEVI6cVBOl/XvBmZSSGRCH5IS
         gVDHytDTmMFbVonbHnCDevUIRMxeRAImM/2DZt50nl+I90mtPm6h3GTerWHCkmlK+qeN
         mgBw==
X-Gm-Message-State: AFqh2kq7IpEZZ3YyqEX7ZNArMxZFSaeGaXct02QAhYydyMkzyDc4/IFh
        Nh4VFHRKKPqchm6KRfySHqOhIQ==
X-Google-Smtp-Source: AMrXdXuIYSpsuAQVnu/PN9wvfo695OrdT003SUKTNSh8GNPck2iywWTRy+ghKQQifhstv5OOviVDUg==
X-Received: by 2002:a67:f886:0:b0:3cb:aaa:81d8 with SMTP id h6-20020a67f886000000b003cb0aaa81d8mr18345765vso.16.1674070250836;
        Wed, 18 Jan 2023 11:30:50 -0800 (PST)
Received: from localhost (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with UTF8SMTPSA id j7-20020a05620a410700b006cbe3be300esm8750610qko.12.2023.01.18.11.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 11:30:50 -0800 (PST)
From:   Mark Yacoub <markyacoub@chromium.org>
X-Google-Original-From: Mark Yacoub <markyacoub@google.com>
To:     quic_khsieh@quicinc.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        markyacoub@chromium.org, tzimmermann@suse.de,
        ville.syrjala@linux.intel.com, stanislav.lisovskiy@intel.com,
        matthew.d.roper@intel.com, imre.deak@intel.com,
        lucas.demarchi@intel.com, manasi.d.navare@intel.com,
        swati2.sharma@intel.com, bhanuprakash.modem@intel.com,
        javierm@redhat.com, jose.souza@intel.com, lyude@redhat.com,
        hbh25y@gmail.com, arun.r.murthy@intel.com,
        ashutosh.dixit@intel.com, ankit.k.nautiyal@intel.com,
        maxime@cerno.tech, swboyd@chromium.org,
        christophe.jaillet@wanadoo.fr, quic_sbillaka@quicinc.com,
        johan+linaro@kernel.org, dianders@chromium.org, marex@denx.de,
        quic_jesszhan@quicinc.com, bjorn.andersson@linaro.org,
        abhinavk@codeaurora.org, seanpaul@chromium.org
Subject: [PATCH v6 09/10] arm64: dts: qcom: sc7180: Add support for HDCP in dp-controller
Date:   Wed, 18 Jan 2023 19:30:14 +0000
Message-Id: <20230118193015.911074-10-markyacoub@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
In-Reply-To: <20230118193015.911074-1-markyacoub@google.com>
References: <20230118193015.911074-1-markyacoub@google.com>
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

This patch adds the register ranges required for HDCP key injection and
HDCP TrustZone interaction as described in the dt-bindings for the
sc7180 dp controller. Now that these are supported, change the
compatible string to "dp-hdcp".

Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20210913175747.47456-15-sean@poorly.run #v1
Link: https://patchwork.freedesktop.org/patch/msgid/20210915203834.1439-14-sean@poorly.run #v2
Link: https://patchwork.freedesktop.org/patch/msgid/20211001151145.55916-14-sean@poorly.run #v3
Link: https://patchwork.freedesktop.org/patch/msgid/20211105030434.2828845-14-sean@poorly.run #v4
Link: https://patchwork.freedesktop.org/patch/msgid/20220411204741.1074308-10-sean@poorly.run #v5

Changes in v3:
-Split off into a new patch containing just the dts change (Stephen)
-Add hdcp compatible string (Stephen)
Changes in v4:
-Rebase on Bjorn's multi-dp patchset
Changes in v5:
-Put the tz register offsets in trogdor dtsi (Rob C)
Changes in v6:
-Rebased: Removed modifications in sc7180.dtsi as it's already upstream

---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 178efaaa89ec..6f6fe5cb6563 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -817,6 +817,14 @@ &mdss_dp {
 	pinctrl-names = "default";
 	pinctrl-0 = <&dp_hot_plug_det>;
 	data-lanes = <0 1>;
+
+	reg = <0 0x0ae90000 0 0x200>,
+	      <0 0x0ae90200 0 0x200>,
+	      <0 0x0ae90400 0 0xc00>,
+	      <0 0x0ae91000 0 0x400>,
+	      <0 0x0ae91400 0 0x400>,
+	      <0 0x0aed1000 0 0x175>,
+	      <0 0x0aee1000 0 0x2c>;
 };
 
 &pm6150_adc {
-- 
2.39.0.246.g2a6d74b583-goog

