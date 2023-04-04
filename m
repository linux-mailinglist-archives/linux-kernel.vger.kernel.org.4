Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D696D6CCE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbjDDTB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236094AbjDDTBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:01:23 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CC31BEA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:01:22 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id er13so93680676edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 12:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680634881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siX//wbRdPcHa0A32GfJh/26lg5gyZzU6mUPQs/OP4g=;
        b=b3D9uKATuq9rmH7AV2GGxzPklV56XhdLO9DS5guHITk7eqy6UQrJRjqwbmJ5af81GV
         fvdto36kqeltwH+0n0PlLXkgDf7mxnt64Ax4gRuHyXIN5T0osvTuV/zEScgUzZf6Qsgd
         GYvXumzNNZJBtXbn9OU1bfrVvzO1j4f9BChH9ppvzK+v3SA3LMN1npc/2VtOIKJgyLAz
         F7sgv5sbptfuQx6IqUOUaRTyip7KmHu18Jpuqk2ivm7H4oDAKWDvg/wk9UGEnQEU61w3
         lIIpC+gh5+7LYOBGlIdOWdI/4671qqczYZIqlRNssK+U3TuIeWWIbLepiV0ddDLEMKPL
         E1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680634881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siX//wbRdPcHa0A32GfJh/26lg5gyZzU6mUPQs/OP4g=;
        b=InCo/rnHEOX88LW7luw/lISf+QxvdGPlH8rvm01vy1ZwZibH9CweArGOp9jCfB7SJb
         jCpScXKj9U4a7rvnuvp6nw5xZ+yDw58Gf98/YpdI2ojq1Gus8kXxX6ZWXVzc+EGN34xp
         6pRH2Lg/EDarJwzMQMQ5yfmPV2ekJ17lFghJ3x9ceEpnMKlDdWzyToUlZNtxZO4m1s4e
         tE6yuDtK0ZFEAkCJ6S+faMulhOevWRC3nqbc9mMVjzzeNyAtB/iK3TgbwQWyjOCiT1EK
         v0TIC8f4YNB8S/WzkSNyUBXlGaoXHiVDkdpq/lAOhQP9J5SuD2vv3+B1UM7I9TBud3aS
         fWSQ==
X-Gm-Message-State: AAQBX9cujaitsqqp2zaa633Rx1P0PDgEYHNLYqgiaVquSLzNtKltshBZ
        H2MMd/dJx+f/ZB5Vxd4oi1gp8A==
X-Google-Smtp-Source: AKy350axTcQuqtRhNBq4mwSO6xgliAFnNzA4wAjIj1P1fJbgBspY8TwtsK7eCEGwYkoPwn0dMmSUPg==
X-Received: by 2002:a17:906:b199:b0:8fa:b2b:9de with SMTP id w25-20020a170906b19900b008fa0b2b09demr548651ejy.25.1680634880861;
        Tue, 04 Apr 2023 12:01:20 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:7467:56f4:40b7:cba8])
        by smtp.gmail.com with ESMTPSA id dx21-20020a170906a85500b008d044ede804sm6257079ejb.163.2023.04.04.12.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 12:01:20 -0700 (PDT)
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
Subject: [PATCH 2/5] dt-bindings: phy: cadence-torrent: drop assigned-clocks
Date:   Tue,  4 Apr 2023 21:01:12 +0200
Message-Id: <20230404190115.546973-2-krzysztof.kozlowski@linaro.org>
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

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/phy/phy-cadence-torrent.yaml        | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index 2ad1faadda2a..033a24172b01 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -44,12 +44,6 @@ properties:
       - const: refclk
       - const: phy_en_refclk
 
-  assigned-clocks:
-    maxItems: 3
-
-  assigned-clock-parents:
-    maxItems: 3
-
   reg:
     minItems: 1
     items:
-- 
2.34.1

