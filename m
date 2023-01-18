Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1DB67286A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjARTb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjARTa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:30:56 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4676C5CFDE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:30:49 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id n2so8584152qvo.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/52S2yQO347VCYnw3lcgURc+RsitVzGCjZgdtUF6R2c=;
        b=B2/cZWZAuvHw0Rt4dcv6ipWOsx/xa87RiYmMSjt40gPQiuZW28kSOCN18cHj9JEHYD
         JlP5e57TRa7JOqyxL/ZljMb4hA0UTkb08WLbJzclztGei8o3eRLybHFr25EV70aQ/iK8
         vK2izOMFI9OAEj11M/H5SfB8e917SA5SlbFaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/52S2yQO347VCYnw3lcgURc+RsitVzGCjZgdtUF6R2c=;
        b=SfXSRBEwuMQbrjtV/c8y6op9Dpc8Mt7WIwuSVtOg4No2GxNmj6h5uwEHSN0Kbqc4i1
         1bwK/5enVdpC6Hd1H/H23hKkegzC9Gc3GN94KVrSo5P8+5qhgjzRnhqrMAVFJ+twUC7u
         72hBUI3EkumSz+t+va+DYT/01pYe4DAF+zTcCS9lzKWVJCSmnJsPaRTak4ZidShx0+E9
         +uIfsOcOtGpht4mllLjjsg1zDbFwUF+4fha5ccB0xK16KHcDKxvk1xrY7glEay5x9ulL
         WoNUIhvejyYBROFKvbDlkie7xp8ysq7/wuDcykAJpyqAXIaScBEfs7Jk0I6GxPrGu+Oj
         g7/g==
X-Gm-Message-State: AFqh2krJR4PDF+4rw8ldkId2RcuTmNAavZVFs286s+JtiP7e0kCh2wsP
        edaZ4k+jKM8KP5imJ/J/RjpffA==
X-Google-Smtp-Source: AMrXdXswgWPxSK5vtG8KVOUpiv1dsMdMlTWhfTgij9ORwe5l2o9VqGfzDsuK+S7FR81euFwjYj3agA==
X-Received: by 2002:a05:6214:2d41:b0:534:e0c4:226d with SMTP id na1-20020a0562142d4100b00534e0c4226dmr10247851qvb.16.1674070248272;
        Wed, 18 Jan 2023 11:30:48 -0800 (PST)
Received: from localhost (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with UTF8SMTPSA id f8-20020a05620a408800b0070543181468sm23215117qko.57.2023.01.18.11.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 11:30:47 -0800 (PST)
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
        abhinavk@codeaurora.org, seanpaul@chromium.org,
        Rob Herring <robh@kernel.org>,
        Mark Yacoub <markyacoub@chromiu.org>
Subject: [PATCH v6 08/10] dt-bindings: msm/dp: Add bindings for HDCP registers
Date:   Wed, 18 Jan 2023 19:30:13 +0000
Message-Id: <20230118193015.911074-9-markyacoub@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
In-Reply-To: <20230118193015.911074-1-markyacoub@google.com>
References: <20230118193015.911074-1-markyacoub@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

This patch adds the bindings for the MSM DisplayPort HDCP registers
which are required to write the HDCP key into the display controller as
well as the registers to enable HDCP authentication/key
exchange/encryption.

We'll use a new compatible string for this since the fields are optional.

Cc: Rob Herring <robh@kernel.org>
Cc: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Mark Yacoub <markyacoub@chromiu.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20210913175747.47456-13-sean@poorly.run #v1
Link: https://patchwork.freedesktop.org/patch/msgid/20210915203834.1439-13-sean@poorly.run #v2
Link: https://patchwork.freedesktop.org/patch/msgid/20211001151145.55916-13-sean@poorly.run #v3
Link: https://patchwork.freedesktop.org/patch/msgid/20211105030434.2828845-13-sean@poorly.run #v4
Link: https://patchwork.freedesktop.org/patch/msgid/20211115202153.117244-1-sean@poorly.run #v4.5
Link: https://patchwork.freedesktop.org/patch/msgid/20220411204741.1074308-9-sean@poorly.run #v5

Changes in v2:
-Drop register range names (Stephen)
-Fix yaml errors (Rob)
Changes in v3:
-Add new compatible string for dp-hdcp
-Add descriptions to reg
-Add minItems/maxItems to reg
-Make reg depend on the new hdcp compatible string
Changes in v4:
-Rebase on Bjorn's multi-dp patchset
Changes in v4.5:
-Remove maxItems from reg (Rob)
-Remove leading zeros in example (Rob)
Changes in v5:
-None
Changes in v6:
-Rebased: modify minItems instead of adding it as new line.

---
 .../devicetree/bindings/display/msm/dp-controller.yaml    | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index f2515af8256f..17d741f9af86 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -24,13 +24,15 @@ properties:
       - qcom,sm8350-dp
 
   reg:
-    minItems: 4
+    minItems: 5
     items:
       - description: ahb register block
       - description: aux register block
       - description: link register block
       - description: p0 register block
       - description: p1 register block
+      - description: (Optional) Registers for HDCP device key injection
+      - description: (Optional) Registers for HDCP TrustZone interaction
 
   interrupts:
     maxItems: 1
@@ -154,7 +156,9 @@ examples:
               <0xae90200 0x200>,
               <0xae90400 0xc00>,
               <0xae91000 0x400>,
-              <0xae91400 0x400>;
+              <0xae91400 0x400>,
+              <0xaed1000 0x174>,
+              <0xaee1000 0x2c>;
         interrupt-parent = <&mdss>;
         interrupts = <12>;
         clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
-- 
2.39.0.246.g2a6d74b583-goog

