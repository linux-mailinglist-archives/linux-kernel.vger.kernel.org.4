Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54526D6CCB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbjDDTBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbjDDTBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:01:22 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C0D1991
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:01:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ek18so134719412edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 12:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680634879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xdmeU1LWxBpvWwDDQiFchlMca3RtpapWdUf3ChV5Tv4=;
        b=Xm+aZzF4PoD6L8vXoGfT6+59/BgtaxEiUSF+MZRATCfE7PHQphjbbBA0pQJH6a+6UZ
         Lql9f8x3xRNBtKLk52YXwj7tIKSKZRqAc3j8XQozv+4a9FvhVRogi46E2HtZZFv/oO02
         NmBv2ifbigXafZCbmZ5IAzRqWzCSE67/VgCoLtsjUIQHb+JgoBfPZG53JMlwB4s2KVHT
         7R76U+ZpF98zpoTzZgSiEYF4KMsGY1vTxa8j7JkyIMVUZ0pbrcGuEUkm/xdhQ/2ATlmT
         cIbBAq7tw+ggBE9iM2fBaGF0sgwUftx1o5Ge35A8KBqxAveKdNtQMG5WjdwR2snCUY3E
         7YUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680634879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xdmeU1LWxBpvWwDDQiFchlMca3RtpapWdUf3ChV5Tv4=;
        b=45Tnb2IdHd0sP5v0F7YYzQDgotG6lRMr3CBQMErnHTfs6b5RVtx7NMZYQiTkjnLnq9
         diylsPhDgx88wxYoSiqEFatP84g+FXy9xwgVwY1IH0n5kH1OudcfHPvZESSp3jxGAvfv
         OdVqsd0g7RHvs+4fBt9KkFw1SgUAPkSY/UdGZAKAjfcG8iD95vdtwYX3frxLCfxLH5bg
         Zm/SsLQtt8td0n/a97CH0yoZpvrIxGzX//SWdjaf512vmWAEuvLTPGw+qsn57JfubxVM
         oE22+/5HkC5EN8z2i7An2spD9fihCC31n4OFus855/teVzrf/rNiziluAHeXYcktrK1H
         IK7w==
X-Gm-Message-State: AAQBX9fEhs9SRShxrLvcW9h8PdsyeetylVGtiY3gsWEtSJXkALnaGzZ0
        sE59MScJoDm5aOxuyx6GIhQI6A==
X-Google-Smtp-Source: AKy350Z9nhHQkGwfXXAmu9CDd/l+fSb9QwcPUqGPeKtnTr9ak7kVjuSZ14j5pV/JdmEBP0Rbu/ulIA==
X-Received: by 2002:a17:906:2319:b0:932:b790:932c with SMTP id l25-20020a170906231900b00932b790932cmr597111eja.44.1680634879631;
        Tue, 04 Apr 2023 12:01:19 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:7467:56f4:40b7:cba8])
        by smtp.gmail.com with ESMTPSA id dx21-20020a170906a85500b008d044ede804sm6257079ejb.163.2023.04.04.12.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 12:01:19 -0700 (PDT)
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
Subject: [PATCH 1/5] dt-bindings: phy: cadence-sierra: drop assigned-clocks
Date:   Tue,  4 Apr 2023 21:01:11 +0200
Message-Id: <20230404190115.546973-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/phy/phy-cadence-sierra.yaml       | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
index 6a09472740ed..1de699fe5306 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
@@ -61,14 +61,6 @@ properties:
       - const: pll0_refclk
       - const: pll1_refclk
 
-  assigned-clocks:
-    minItems: 1
-    maxItems: 2
-
-  assigned-clock-parents:
-    minItems: 1
-    maxItems: 2
-
   cdns,autoconf:
     type: boolean
     description:
-- 
2.34.1

