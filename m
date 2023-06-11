Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8310472B234
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbjFKOFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbjFKOEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:04:52 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C323226AD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:04 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f6da07ff00so35465615e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492244; x=1689084244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqrslVRpwmGjqb/smGQc76LFau+8yBY+SL3Icfvthho=;
        b=GnGbTZ0Gyi3C5gdfIDhytuSqTXEsxDSf2i7tPpXp/qF6J3Bo0r95CJTDlOnVSZIlsA
         lbO0J5GDuQY8PD07H6KCzN6oyyTm7JgOGi1I0tOFsW122bweajwV6q2TrzDvdgiYX336
         6PtBSVsoa7zuJRvJwsD2MK0dW1ofelq/A3OUoun0IesJaZN5R790Gm4eyialKQ94O+hN
         IXNkkXC/0pceePTx9zHNu4ryCiEuSWUJpt9umER6cm+qlgiruAKEiKMge+OqQTiS08JR
         qn/WkvBL7dGxI0JfZxS2bT/RusgPMTsOctfBVG2qfjySMCHZKs3ZoeDRrKSpUQ9SN3Pt
         /UUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492244; x=1689084244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqrslVRpwmGjqb/smGQc76LFau+8yBY+SL3Icfvthho=;
        b=kj5+s6QDU2BlEMaFCADCtNxCdY/noiOsgAad0sPhb5QNM206Rbn+4sClsX5xGZK4Oy
         5tFkDoa9moCah6r247bdFFjIYZ3LvifOMf5zbNXKFRm0IdTiQmib7DSrRljPn5Qhrrae
         CNadBtrBYhNp+k6lRCexm9+TLvoqBV0D0QFtJpRnUwS8hd9qVhLrXHfKFDKgdBx8dyfr
         bvWLL57SuiJ+2FXCGbI8zslQLICLEXyiUim4ojdDYAqQjwIX2BaXUnFMUI5rS5JRa+5n
         eAhhl0PqBxE6Xs4HUQzCrPP5Azehz7TnwCxEkocZ42nf4BEUgMS5XTrGi68OWW/5+hxF
         FQtQ==
X-Gm-Message-State: AC+VfDxLZ+5CWREHGkEHS3wdJ9IWwWLhN7wHPf/+BfE0J7ffCRB/Vjzd
        fD7/vZutmkfxzVoJ3lp1yMc9lg==
X-Google-Smtp-Source: ACHHUZ4nqr0SFl5XrFkPJ9Yk0gZ3tV1d0e3CcRp5UTc/5DwQ2XepiNMqQb5Ec9nfH35zu12wIxPgjg==
X-Received: by 2002:a05:600c:b56:b0:3f7:3991:61e5 with SMTP id k22-20020a05600c0b5600b003f7399161e5mr6112307wmr.4.1686492244295;
        Sun, 11 Jun 2023 07:04:04 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:04:03 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 15/26] dt-bindings: nvmem: qcom,qfprom: drop unneeded address/size-cells
Date:   Sun, 11 Jun 2023 15:03:19 +0100
Message-Id: <20230611140330.154222-16-srinivas.kandagatla@linaro.org>
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

Referenced nvmem.yaml schema already defines address/size-cells, so
remove redundant entries.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 8d8503dd934b..c898c67c243a 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -64,12 +64,6 @@ properties:
   power-domains:
     maxItems: 1
 
-  # Needed if any child nodes are present.
-  "#address-cells":
-    const: 1
-  "#size-cells":
-    const: 1
-
 required:
   - compatible
   - reg
-- 
2.25.1

