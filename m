Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6AA642D5E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiLEQpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiLEQoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:44:54 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D418B20BD7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:43:02 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id n1so14195528ljg.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 08:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dG7yGVyYRsmBVSh74cgqDY3U7gtNUa3Uc2Su87aJNdM=;
        b=PfPAJmwxzI3vsBPIQ4EArHnL8s9XLh3ES8XQsb/9CSv7PNlIvHBRa8UtGxDnI+2WJB
         DTos2u39yRdAXBLCRfIJTXPLNWiG0uNzfABKsPADwpBmN5pxviUlt+9avQK9FWy07T+q
         xiWdcxrvmimZiN0wo6wrzqYbgFxzQahhs1auJpC6jFqlFu8GNvG2SsqboC8lbHIg5KC9
         Hzn7p67YLffS6TlUh9zjF5hXK7WuotoWqAmPbGL9rfPIWlNEvjkMz+P+nxfnpIpn+C71
         sJGtJxTZTQDb+OBS3GIQ1bFs5QbzghPtv/kQStxylRbvfDztYqJHDoWkH99+F6pmMQuo
         ND4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dG7yGVyYRsmBVSh74cgqDY3U7gtNUa3Uc2Su87aJNdM=;
        b=nK2l5igYHdAP8vATzUNHMwNGyoFS8X96ppjWkyVDzvl4/lGukp4QSWt7mRF108kGJh
         SS5eB2asBZ+eQfoeUSQ5LSk+4DurP8P3jZwhf4hqKgNlEgnkqwrvnfJbZD8UJhjw+Gux
         7RGUWiRztw6N/oRZKU/xEiDbqJJoqa1DC0QEpspTIoT77xk9Gbd7EeIpotkktkf2zJKU
         tKQUK6W/5vF85F81sYCX4aAR44dbKHTFpKm9CdvVLcFtUQh9oXVzYqxmNW/o44FyapPc
         B6MtB0LgbmKWkCjuseXvBdZXvn8LEqjjAKAk37//s0Z/S/a4a6jAHlEOY8gXtHuifqzr
         ehLQ==
X-Gm-Message-State: ANoB5pk0aGsb8HOIGYP7h2f1x2wqop1BPSp6lzoqCxJmgdXaFc1iA4xa
        nluPsiRHf2um1S67w5jcq9O0pQ==
X-Google-Smtp-Source: AA0mqf7hc58DyjVflxiSb1V/1fJSNkwZ19NDZJw8GfHZSbOljH7OaSRr15ONo4QvN6myXLlSPxLR1g==
X-Received: by 2002:a2e:321a:0:b0:279:7974:4471 with SMTP id y26-20020a2e321a000000b0027979744471mr17612614ljy.495.1670258581262;
        Mon, 05 Dec 2022 08:43:01 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b11-20020a056512070b00b00494935ddb88sm2165575lfs.240.2022.12.05.08.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 08:43:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: Drop Jee Heng Sia
Date:   Mon,  5 Dec 2022 17:42:54 +0100
Message-Id: <20221205164254.36418-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emails to Jee Heng Sia bounce ("550 #5.1.0 Address rejected.").  Add
Keembay platform maintainers as Keembay I2S maintainers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Mark Brown <broonie@kernel.org>

---

Changes since v1:
1. Correct email format in keembay-i2s.
2. Add Ack tag.
---
 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml    | 1 -
 Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 67aa7bb6d36a..ad107a4d3b33 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -8,7 +8,6 @@ title: Synopsys DesignWare AXI DMA Controller
 
 maintainers:
   - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
-  - Jee Heng Sia <jee.heng.sia@intel.com>
 
 description:
   Synopsys DesignWare AXI DMA Controller DT Binding
diff --git a/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml b/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
index 2ac0a4b3cd18..76b6f2cf25df 100644
--- a/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
@@ -8,7 +8,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Intel KeemBay I2S
 
 maintainers:
-  - Sia, Jee Heng <jee.heng.sia@intel.com>
+  - Daniele Alessandrelli <daniele.alessandrelli@intel.com>
+  - Paul J. Murphy <paul.j.murphy@intel.com>
 
 description: |
  Intel KeemBay I2S
-- 
2.34.1

