Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A965BE4B7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiITLlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiITLl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:41:29 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AE573938
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:41:18 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o70-20020a17090a0a4c00b00202f898fa86so2199567pjo.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=g6AC6jEf76DqrwOwWwOtLtUk31f5tzTAXDubM2/ZX08=;
        b=ARe77Wi6S4c70JwGGEeGv+7LI1vlm8Iao63LhaaZHXbimsEa+2gKXKIj45z3WezXK8
         9NYPi+kjzosHx4EpLu4dXx7ZqZ4LDGoZy8FTEym+8iVCkRSq9FE1w3aKbtH3k33G0U/9
         OMowAo+E47vhSo3QmIZYnzcxdvxPibw/EO8hBjPaxGYOlh1We22+Ax1EA81tAI+nR1QN
         7S8VI5BuEajQ0w+LShkZeO9VD5m8WNxwnm6YPkAsivGsP8SfhNUQdzRqJgLjWngm8U7c
         wOgBquSA33uMDBYT+Nm2XKAKlqna45n+bBgo4qdhO2ockESRK3rna8I/hxoKPxYJ+lQk
         fPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=g6AC6jEf76DqrwOwWwOtLtUk31f5tzTAXDubM2/ZX08=;
        b=5Tmer+/2SqocS8vR4se6J2CUHIr5Ei50O56rWnl/iR6M2iKVBDhNAYoYa7BXAcUS/M
         5EAV6xrFHo3fIoSbykd1ZVqRTPn5BjvshNtt2/dd2ZFH0vvxY2hcjU3opKZnEMT/d2Fx
         GzGy4yMEm+jLu9DQNjTalBHC19/XBKBba8TLWbJJJoa48KhUkXXfFELZ8wHQkPskWcft
         vfbCXk4iuIbykDkp4Oj+nIy7HWyqpUH3ooCbv/eOqY14eQZUKpcSxsYgmh8/BSQiYuXG
         MMC58hFxPqN2Ue2LtEkcTs9XvjUAuaa87uFQG+k6mEvAQBa91Er+zd+yMA6oS+JWneih
         nbdg==
X-Gm-Message-State: ACrzQf3kxqD9RjXTz1kDBYjMgWTi9SvbmHDLZj0flQuYUQrmClAuaj0x
        M+SU5wVxCx7Xl6SQYH/bvdNv6w==
X-Google-Smtp-Source: AMsMyM5G7F0wTVQPxep+p0SCdwjOJ5D5ZVd8XO7y6z3cQPkLD0IruGY9NAplEmO3T0icT/eFqApszg==
X-Received: by 2002:a17:903:496:b0:176:ba09:1cc0 with SMTP id jj22-20020a170903049600b00176ba091cc0mr4344800plb.41.1663674078004;
        Tue, 20 Sep 2022 04:41:18 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:6535:ca5f:67d1:670d:e188])
        by smtp.gmail.com with ESMTPSA id p30-20020a63741e000000b00434e57bfc6csm1348793pgc.56.2022.09.20.04.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 04:41:17 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, thara.gopinath@gmail.com,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, davem@davemloft.net,
        Jordan Crouse <jorcrous@amazon.com>
Subject: [PATCH v7 3/9] dt-bindings: qcom-qce: Add 'iommus' to optional properties
Date:   Tue, 20 Sep 2022 17:10:45 +0530
Message-Id: <20220920114051.1116441-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220920114051.1116441-1-bhupesh.sharma@linaro.org>
References: <20220920114051.1116441-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing optional property - 'iommus' to the
device-tree binding documentation for qcom-qce crypto IP.

This property describes the phandle(s) to apps_smmu node with sid mask.

Cc: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Jordan Crouse <jorcrous@amazon.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
index 94f96ebc5dac..4e00e7925fed 100644
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
@@ -32,6 +32,12 @@ properties:
       - const: bus
       - const: core
 
+  iommus:
+    minItems: 1
+    maxItems: 8
+    description:
+      phandle to apps_smmu node with sid mask.
+
   interconnects:
     maxItems: 1
     description:
@@ -72,4 +78,8 @@ examples:
         clock-names = "iface", "bus", "core";
         dmas = <&cryptobam 2>, <&cryptobam 3>;
         dma-names = "rx", "tx";
+        iommus = <&apps_smmu 0x584 0x0011>,
+                 <&apps_smmu 0x586 0x0011>,
+                 <&apps_smmu 0x594 0x0011>,
+                 <&apps_smmu 0x596 0x0011>;
     };
-- 
2.37.1

