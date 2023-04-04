Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C436D6CD0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbjDDTBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbjDDTBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:01:25 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8BE3A9C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:01:24 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r11so134703052edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 12:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680634882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHE/rBbww83tJZiQz3167wNvDjgskvsYq0IYxB/AOR4=;
        b=zPYLj9QkXCUFrb232mzqMKckOcIXMdGh67Jxx52nBaKxag/jlB8aJKsduacGDVmoeM
         MY/WNxq+mj8lGeDWSl5PJHP+YHexcHu5dC+ZtOTJ+oc6mpxEnWuaYgsWsDxrmqlFmjdl
         GtCWw00Or/ECfxUdr4tKiW7gPtcCNOWC3GFHWp97bA4nRBU4U1ahISB2bxz0etsYgPsy
         tatSMpfVcapW5/r7mb8tFdaYgJv06NNrTysilysgn+PgGQWfWU341a+Mrliad0pNXwFw
         IyjCoocRc9MbwtDw99xRdJ6efKZnhP8tHZwHwr6tLbclQFfbpoZrSvlagotRH5rJPi4v
         ZfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680634882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHE/rBbww83tJZiQz3167wNvDjgskvsYq0IYxB/AOR4=;
        b=ic7B4l9XmUDdqc9grYMOA3X2xGindU0nj8EMEaY0ugyLcF+F4+ZloydiilHor56JSP
         goguuQWIfQhUrFZus4I4qvFjSMj31pSA/vxvaFGKsB9lbKJaRff5ykq0IP++0gZNCkFJ
         5Cdx5p1nSoYcEy1PAYDTTMEXdGUBIdJbLWLrTLdIvRPgIKjOfv2I/sLYgj9aeuzKKrsE
         GZuzlH7+uK5nw0NT+q41aa3/25Q8f7vNhiLiSSx4ZMd6fHRuYueb0YO9y1Ofiqe6dMBi
         PDQP74d/UeziX6iq8reIGbutQrwnYyDBsi6rrtkKB2QBZSKt7kWJv4UDShjGiei/slcN
         w4oA==
X-Gm-Message-State: AAQBX9dcfX6TIvT2m0bFqSqEjGauywNuCePBs2hkDjE0sEKf3I21qR/8
        w6lL+g/cTmh8A3yBY+8zceHsfA==
X-Google-Smtp-Source: AKy350b2+sG8vxa+S9kO9UBfoIkxY8Nw5+1joCziMKEUVv4LhML9JMZc9XN4M+q0gTUfxHaykEfTJw==
X-Received: by 2002:a17:906:3e96:b0:93b:2d0b:b60e with SMTP id a22-20020a1709063e9600b0093b2d0bb60emr466105ejj.74.1680634882724;
        Tue, 04 Apr 2023 12:01:22 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:7467:56f4:40b7:cba8])
        by smtp.gmail.com with ESMTPSA id dx21-20020a170906a85500b008d044ede804sm6257079ejb.163.2023.04.04.12.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 12:01:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Yuti Amonkar <yamonkar@cadence.com>, Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/5] dt-bindings: phy: ti,phy-j721e-wiz: drop assigned-clocks
Date:   Tue,  4 Apr 2023 21:01:14 +0200
Message-Id: <20230404190115.546973-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404190115.546973-1-krzysztof.kozlowski@linaro.org>
References: <20230404190115.546973-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The meta schema from DT schema already defines assigned-clocks, so there
is no need for device schema to mention it at all.  There are also no
benefits of having it here and a board could actually need more of clock
assignments than the schema allows.

Keep however the assigned-clocks in children nodes, as apparently their
proper parenting is required.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml    | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
index c54b36c104ab..4f3841e6a307 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
@@ -54,18 +54,6 @@ properties:
 
   ranges: true
 
-  assigned-clocks:
-    minItems: 1
-    maxItems: 2
-
-  assigned-clock-parents:
-    minItems: 1
-    maxItems: 2
-
-  assigned-clock-rates:
-    minItems: 1
-    maxItems: 2
-
   typec-dir-gpios:
     maxItems: 1
     description:
-- 
2.34.1

