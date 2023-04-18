Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAFF6E5DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjDRJzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjDRJzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:55:09 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DD26EAB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:54:55 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5069097bac7so2420713a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681811694; x=1684403694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cRfuFeBQF2GhlfpWUoUKdpK75M5MnTFGf0plvdLi68=;
        b=C2Gwbgl2JvkR9/b/grjshd/C+6ox2w0XGOFuJ8S7JpFN4bzNJOp1pHVIwhuGq5bvNk
         r6ww0xJsSxXQ/fBjmaFjwHSYeyAr2Kxe2nsYa+wfmgUO1Dhm/nqVcVAdzN7WAMRFIqnk
         HrApMx7EoUZ5G+Sbj1jWkzhgaOa+WW2EDN4au6jh7qtSdE7wztjWdQaSwHAnQ4fB3qyT
         3UPZ/rJ9vP3Q4tlbNI2otU85R5KO9GcKkglUggsMn4U2m8n20bE+/J4+LtRi3kPXC2y+
         fZSJCKB31kPq0QvEC36AKly99YBANLOD3jFDXWlnRcxZ1AJ70yOCk13vXoGxLa3IOGCm
         Cf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681811694; x=1684403694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cRfuFeBQF2GhlfpWUoUKdpK75M5MnTFGf0plvdLi68=;
        b=KMFKBzZEM3z48rQXE5aXA9WsnzNlDwqPgQec+5U+Pp03weTuptCu1WlSH4716a5hxb
         SFbkteJSy3e5eM1S4Y6Jp4rk9uFag3DJL+hFY0ivjodslYBdHFC6dt94nGciK9tz213Y
         nuAztV/v//rf5fmOABBhvae1nmzjliQMDx7A72rgjVtrqO30e0K2VSgFz0pYNDsNtMSC
         qA/LcHSQXICuLSNDTie+dsa8GDtVB8ZEAkQVRjq3VBWAEYJcten6GTCnKYPEInhL8lXb
         SACujEzb1STB7knkG4ZYV7JhBwTZsrVggpOpT0XeVyN9BPvzA/6LUETaLZewsMstubeG
         S2RA==
X-Gm-Message-State: AAQBX9f2aGpUat+CQacJ+4O2LvATlXIV0EzqGm72gltv37LSDLwwZuTI
        9qeFkFSDnTgcGTm9m+r4k4AxKA==
X-Google-Smtp-Source: AKy350Zv4eAYzjlFPhmgQi9Le6Vg11S1iPenSSp/apV18vS/Di6QxTwegzV01A/ajeWBcJ+evGhJwQ==
X-Received: by 2002:aa7:cb0d:0:b0:506:b120:8df2 with SMTP id s13-20020aa7cb0d000000b00506b1208df2mr1389396edt.12.1681811693399;
        Tue, 18 Apr 2023 02:54:53 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id o4-20020a509b04000000b00504d04c939fsm7076578edi.59.2023.04.18.02.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 02:54:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/7] dt-bindings: soundwire: qcom: add 16-bit sample interval
Date:   Tue, 18 Apr 2023 11:54:42 +0200
Message-Id: <20230418095447.577001-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418095447.577001-1-krzysztof.kozlowski@linaro.org>
References: <20230418095447.577001-1-krzysztof.kozlowski@linaro.org>
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

The port sample interval was always 16-bit, split into low and high
bytes.  This split was unnecessary, although harmless for older devices
because all of them used only lower byte (so values < 0xff).  With
support for Soundwire controller on Qualcomm SM8550 and its devices,
both bytes will be used, thus add a new 'qcom,ports-sinterval' property
to allow 16-bit sample intervals.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2:
1. Use uint16 for qcom,ports-sinterval.
   DTS will be fixed in separate patchset.
2. Add tags.
---
 .../bindings/soundwire/qcom,soundwire.yaml    | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
index 98c7fc7e1189..fb44b89a754e 100644
--- a/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
+++ b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
@@ -86,7 +86,7 @@ properties:
   qcom,ports-sinterval-low:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description:
-      Sample interval low of each data port.
+      Sample interval (only lowest byte) of each data port.
       Out ports followed by In ports. Used for Sample Interval calculation.
       Value of 0xff indicates that this option is not implemented
       or applicable for the respective data port.
@@ -94,6 +94,17 @@ properties:
     minItems: 3
     maxItems: 16
 
+  qcom,ports-sinterval:
+    $ref: /schemas/types.yaml#/definitions/uint16-array
+    description:
+      Sample interval of each data port.
+      Out ports followed by In ports. Used for Sample Interval calculation.
+      Value of 0xffff indicates that this option is not implemented
+      or applicable for the respective data port.
+      More info in MIPI Alliance SoundWire 1.0 Specifications.
+    minItems: 3
+    maxItems: 16
+
   qcom,ports-offset1:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description:
@@ -220,10 +231,15 @@ required:
   - '#size-cells'
   - qcom,dout-ports
   - qcom,din-ports
-  - qcom,ports-sinterval-low
   - qcom,ports-offset1
   - qcom,ports-offset2
 
+oneOf:
+  - required:
+      - qcom,ports-sinterval-low
+  - required:
+      - qcom,ports-sinterval
+
 additionalProperties: false
 
 examples:
-- 
2.34.1

