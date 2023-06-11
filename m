Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3725272B238
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjFKOFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjFKOFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:05:02 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D547359D
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:19 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f6da07ff00so35466985e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492259; x=1689084259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgKld3plYHBwOAMsuA+zbtCm3Ym56oMGsuAqYXo/IA0=;
        b=OPhWwjENjE7DqRi6Ke06tHDxGhGPmQhJ+VUveFyTMj9FtFfrS0idkhXdIi227FKPTC
         A/v8ZJEuWlXOWhasKqe4B/0C6a6Nt1yy53V+bcwRDBsYTYXMCKgbj1YDt3aW57DLE0qq
         zPwm1Dxvz+Gnp0oeq7VP0mlzxJDuVto2nhau6iaqOx+k3S1mwRilv0FSilh1SAfb9LBT
         VB7t565EZqff3IykHnJ+8lAOPR8+QxljJIBXUo1ttY1w4jRI5OCQZ50qgvVKD8CZAp8u
         1IiddqjH3yYsvh02MyKRyWN1jshsSdo5ltAfQGoqqsEeJWx616qOyP2AmG9kxIQQBW99
         4O6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492259; x=1689084259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgKld3plYHBwOAMsuA+zbtCm3Ym56oMGsuAqYXo/IA0=;
        b=Gr1kM2J0WGVA3PWcbn7LIfrdt5DQaKRhjIeD9NxELM0BKbjAMqlDd1YaRDJtEyFM2B
         3mRMf9hUixyRt/PrUadLE87HCNivz835WPajBiFe0t9nAFWLSSd/+um1XS99mA1e8RPf
         lBaUOZ48MNvbaBALascGGUEbXAtIb5Uydc4sVMsdrmYvvR5h/h2Gj9PHZ/ugPsqgSHQC
         k6EzlHRs4ZwLC/j0HOZR0Sj0Wl9XyypwxvPDxMqYnetQLyP/ZFiCxcVBNEp6biyD9thC
         +xFDlhly7f6dgk2GHpxDO9du7AGIuZ4PWSKRliATi3qwF+N7XLxTdnoZdQmQsy/xTkWY
         c/7w==
X-Gm-Message-State: AC+VfDw+1ect2vuxnljxv57/Y9eQQ5rc8ehzo6VPBGTli2erMqRPcGEF
        BJAA+R4qn+SHNmUt4noijr4YQg==
X-Google-Smtp-Source: ACHHUZ7BweNm1niR/ItvaXK3HTZDid0TjdjjA6nYGWUj1/ia4pl68ioSIeAJWyL8N+OcQoa5bAYqHw==
X-Received: by 2002:a05:600c:225a:b0:3f7:3401:17ac with SMTP id a26-20020a05600c225a00b003f7340117acmr5235824wmm.5.1686492259051;
        Sun, 11 Jun 2023 07:04:19 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:04:18 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 26/26] dt-bindings: nvmem: imx-ocotp: drop unneeded address/size-cells and children
Date:   Sun, 11 Jun 2023 15:03:30 +0100
Message-Id: <20230611140330.154222-27-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
References: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Referenced nvmem.yaml schema already defines address/size-cells and its
children, so remove redundant entries.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/imx-ocotp.yaml  | 21 -------------------
 1 file changed, 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
index 7112d13c9bff..99e60d713dac 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
@@ -47,12 +47,6 @@ properties:
   reg:
     maxItems: 1
 
-  "#address-cells":
-    const: 1
-
-  "#size-cells":
-    const: 1
-
   clocks:
     maxItems: 1
 
@@ -62,21 +56,6 @@ required:
   - compatible
   - reg
 
-patternProperties:
-  "^.*@[0-9a-f]+$":
-    type: object
-
-    properties:
-      reg:
-        maxItems: 1
-        description:
-          Offset and size in bytes within the storage device.
-
-    required:
-      - reg
-
-    additionalProperties: false
-
 unevaluatedProperties: false
 
 examples:
-- 
2.25.1

