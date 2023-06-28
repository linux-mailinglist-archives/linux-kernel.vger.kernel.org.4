Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA64740EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjF1K2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjF1K0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:26:42 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C082D7D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 03:26:40 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb761efa7aso4839514e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 03:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687947998; x=1690539998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuHCd5iHQZEu3yLxK3H5002Fp9mhCHE1bYCUjxfT00w=;
        b=kIrvu1fp5N6kZkZzTu819ivlwe2RwOsvvRpr95K+WkF7h6uLaoxXcEFvbKFSfmnFWC
         3G2msJZnhQgaP8TEEotmbMaajTUUw85K5DP0npluG7rDEEcyFElDo8YLKLbWJYujvX8L
         0QA9udsFcOepH5hZ7Zp84DQR2rEU0XCk/6dOjNoYmGaCVDh179a2NG/AVmxx62eXjArA
         dSQHjhBHyxsStTn0TEzO80cAnCaowhhLQcjYyCiQLncSezOjxTBPUpy1F+TblUX+cEJ1
         KbJB61BXm5w7yFtxabaKTIX2YtLeSTuXz00Aeu25PnDs2iTZw9KfOdCHqPd2wa5C4oKW
         X3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687947998; x=1690539998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuHCd5iHQZEu3yLxK3H5002Fp9mhCHE1bYCUjxfT00w=;
        b=dQuzYhi+Xfvdo82Mf4/qLQj8tbs5re+hxGAbn4UBC0x/yvor9F/e6tXWKCD1A0cDP3
         IowKXpsxSj31viZS4+cgrppEogInW/aqGfN2FhMWeoYPb3qIuUu0MXl/DW968uxeqC72
         AVHITfxaWjD27tCchPw+fNBdIHvyJYrh1zzjLOj8pozVNq8iyzTPj+K/yOcHqpksOnPr
         PVJulHo/2mxoIp9yz0dPyB4TvDHUa0cOtckxgs2wF/kZqjN6nXsfB2oooV47Dt4P6PqI
         lfPQfAsIPX4D0AT/tffvqkfPCjicdInlEmkPqaSDW1fu/q+g8q6ka58nk23upCYunUtD
         emvQ==
X-Gm-Message-State: AC+VfDwCrmYkg0ja3HiTRj29SJQ9aYjpZnUFy8VHJ7t02ZCL1YprE8sT
        hJUh9O6AOfFbD9aeEhTXmuwPfg==
X-Google-Smtp-Source: ACHHUZ4D7KP/WuAE/uTqzc8uPPDUFt3JfNe6/Y6fhu0gjx1LzcDjG70eVVOvxHFT+42JXA+dBchO4g==
X-Received: by 2002:a05:6512:2348:b0:4fb:76a5:2325 with SMTP id p8-20020a056512234800b004fb76a52325mr6782533lfu.24.1687947998165;
        Wed, 28 Jun 2023 03:26:38 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a10-20020a5d53ca000000b003140555c0ddsm2467780wrw.56.2023.06.28.03.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 03:26:37 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        broonie@kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        johan+linaro@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/3] ASoC: dt-bindings: q6apm: add firmware-name bindings
Date:   Wed, 28 Jun 2023 11:26:19 +0100
Message-Id: <20230628102621.15016-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230628102621.15016-1-srinivas.kandagatla@linaro.org>
References: <20230628102621.15016-1-srinivas.kandagatla@linaro.org>
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

Add bindings to get firmare-name from DT, this will provide more flexibility
to specify platform specific firmware file name and location. Also this brings
tplg firmware name inline with other board specific firmware locations.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/sound/qcom,q6apm.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml b/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
index ef1965aca254..c783451145ef 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
@@ -31,6 +31,10 @@ properties:
     unevaluatedProperties: false
     description: Qualcomm DSP audio ports
 
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Audio Topology Firmware name
+
   '#sound-dai-cells':
     const: 0
 
@@ -38,6 +42,7 @@ required:
   - compatible
   - bedais
   - dais
+  - firmware-name
 
 unevaluatedProperties: false
 
-- 
2.21.0

