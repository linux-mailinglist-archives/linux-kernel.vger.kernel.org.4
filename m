Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817C9726911
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjFGSl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjFGSl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:41:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AC71725
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:41:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5147a478c38so1896058a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 11:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686163313; x=1688755313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XfuroyQJAbz9eJ8IYNpTYqcNYBwtnqvDKwV5tW+1tFE=;
        b=IcfL/GcfP36E83IHgmLLRi5x1twq00fmG6Sfg8gSppBVGwe2eLmviHQPFJ44wcHFAJ
         BZjzoqPyR/Nr8XZQTdbjkEtgGtt5h9R/QencLiOrJZBGy7AlV7sPcECAxKrtr7HM2JqY
         /tQh38luGPEzqOFmx5LXn57Ix1WXy1sw/jzFu3DeThk/4BqOeQx7xEaP8SczU190LF+F
         ot9K9/TfEHCHi/GYMMbzC79T88RLWwZr/L10IayHPC1szSRe9EzXx74tSGl8hENMr48i
         VMhEbpuoRrZpj2U2c7sJL9TG895IB21QKqKiB5pTkt08w04BKsNz4j3qX/tJYP+IwaxL
         H6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686163313; x=1688755313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XfuroyQJAbz9eJ8IYNpTYqcNYBwtnqvDKwV5tW+1tFE=;
        b=KK9ILhrBAS01rkA1FyROXoYit7LlHCGSS9494uybq5I8mLs9ZQy11RJmvbFzRB3QVA
         moXS9QM/gsq6udI+eKDHR+VnBl4Whjq8OW3YpKtmgd7+k+CUD6eR3yf3NW4kAEvHmNEA
         agi8AhTMZDwoZi3JlEOAh6kStFSHfCpCWlVkyls2DuntGLbo/MyLzqZEGcdukdYYeW+z
         rPqoq6eRojWg4bZ2KFkTz24YZ1so2yn8Q6vC/Hv/H/dPHtb55W4bK3sa6HO/CAySqvtb
         nKrCyh09TkowPNAvxi5YLtZrdsgqoLd27GPdqXvPEYmt5QKHisK+S4m8kserc4S6QzYh
         0q8g==
X-Gm-Message-State: AC+VfDzOuZjpGhw0ltR8LoroThPfd1EvrV6pYmwhd+atnxkdjs/v9XBf
        1hAzVm206q+XvhyI1lJ7CIUUUg==
X-Google-Smtp-Source: ACHHUZ6zGHkNvsuGpMnZNEHMZYFlUcKqv1tGCUIBu62p6KkmSMlv2eSJHXspjLAOaPba7v7Y91kGHQ==
X-Received: by 2002:a17:907:2da3:b0:978:337e:c417 with SMTP id gt35-20020a1709072da300b00978337ec417mr7146739ejc.60.1686163313297;
        Wed, 07 Jun 2023 11:41:53 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ci17-20020a170906c35100b009787ad3157bsm1435856ejb.39.2023.06.07.11.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 11:41:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: misc: qcom,fastrpc: drop unneeded quotes
Date:   Wed,  7 Jun 2023 20:41:47 +0200
Message-Id: <20230607184147.420352-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index 1ab9588cdd89..2dc3e245fa5d 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -36,7 +36,7 @@ properties:
     description:
       A list of channels tied to this function, used for matching
       the function to a set of virtual channels.
-    $ref: "/schemas/types.yaml#/definitions/string-array"
+    $ref: /schemas/types.yaml#/definitions/string-array
     items:
       - const: fastrpcglink-apps-dsp
 
@@ -48,14 +48,14 @@ properties:
   qcom,smd-channels:
     description:
       Channel name used for the RPM communication
-    $ref: "/schemas/types.yaml#/definitions/string-array"
+    $ref: /schemas/types.yaml#/definitions/string-array
     items:
       - const: fastrpcsmd-apps-dsp
 
   qcom,vmids:
     description:
       Virtual machine IDs for remote processor.
-    $ref: "/schemas/types.yaml#/definitions/uint32-array"
+    $ref: /schemas/types.yaml#/definitions/uint32-array
 
   "#address-cells":
     const: 1
-- 
2.34.1

