Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3FA706B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjEQOl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjEQOlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:41:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B81122;
        Wed, 17 May 2023 07:41:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30789a4c537so606757f8f.0;
        Wed, 17 May 2023 07:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684334510; x=1686926510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCJ4yt4evevwqvOYmzH9xOUxgzk8GcorEVg3x278BIQ=;
        b=pRJRYyShxn3ZgMEpSTZbNU09nslhYx5L8qW1byZvEdn7iP2q4FrdhLMgCzGwJOvmrd
         kpS+pVQe2+s4j8/NIdYQM1bFa4roMpYDBO56rnwq+5TnJwLWugmXgyYHwcd5r/aU3fQ5
         jb6AzkhdYNIWaun+T0bBhWXt50WsSFJTyfkp7Vv9GCVS59HQtaeSserwd73eMU7hnPKY
         0UOnbzUjmH3/C6b1J57kD0mdlRKZU4xOPbsmJqhwGLKJcPmMMINSAfy52k4lasayHttu
         GIhcl7YTl3iL8Dz9CZZ9udufKMIlBgLho0CCnwgaSale/Uksk+yYH4vneDTYdX3jkaF+
         S/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684334510; x=1686926510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCJ4yt4evevwqvOYmzH9xOUxgzk8GcorEVg3x278BIQ=;
        b=M9WJhLYQbhUWD/hPRE7DjkppHhnAQ1f9Y1aRu3qt/qMSoz/h/UtZ5QRcB4pcQNjWU5
         Q8leYxOBfe/9dWBIIO3C1BloFeXJqVGwjUqlkdV2lurajn7Xlhv/Z3ByFDXgtkEz2EWs
         Abp0bcIC2VDZ28nahC0K0H/Wb8EyklXl7AEaDJ5ctIpACgbrWl1UgwNjUxR+q7kkZRur
         vwpxQ3pjM8sdp0FGoibKGy4JMAyF8F9KvZa834b/tHNXCMPxyQ9er6xA1xeINtOw6sYX
         78wrWMTos8gO1XU1e674fRs1HFney0IGO2wji2r2kwMgOZ/HsrY2QJCgj+yqRIfeUjx1
         j+6w==
X-Gm-Message-State: AC+VfDyrlOPRnY5HCQ53Qk/AX3fdMbQak05/thV5uGzK36AqFJoStR3d
        X1fjCUhMERTb8htpv1GeIBpw5T90laU=
X-Google-Smtp-Source: ACHHUZ5zH8zKlrHpcEOiGS6G5luIQ+5XbGHeuv2XopijC9xv2XwbHAsqPBL7FN72Dgnkkig0hwLuog==
X-Received: by 2002:adf:e443:0:b0:306:2cf5:79d7 with SMTP id t3-20020adfe443000000b003062cf579d7mr997234wrm.17.1684334509892;
        Wed, 17 May 2023 07:41:49 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id o16-20020a5d6710000000b003079986fd71sm3015380wru.88.2023.05.17.07.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 07:41:49 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] dt-bindings: rtc: Add Mstar SSD20xD RTC devicetree bindings documentation
Date:   Wed, 17 May 2023 16:41:43 +0200
Message-Id: <20230517144144.365631-3-romain.perier@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230517144144.365631-1-romain.perier@gmail.com>
References: <20230517144144.365631-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the documentation for the devicetree bindings of the Mstar
SSD20xD RTC driver.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 .../bindings/rtc/mstar,ssd20xd-rtc.yaml       | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/mstar,ssd20xd-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/mstar,ssd20xd-rtc.yaml b/Documentation/devicetree/bindings/rtc/mstar,ssd20xd-rtc.yaml
new file mode 100644
index 000000000000..2acd86cce69f
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/mstar,ssd20xd-rtc.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/mstar,ssd20xd-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mstar SSD20xD RTC
+
+allOf:
+  - $ref: rtc.yaml#
+
+maintainers:
+  - Daniel Palmer <daniel@0x0f.com>
+  - Romain Perier <romain.perier@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - mstar,ssd20xd-rtc
+  reg:
+    maxItems: 1
+
+  start-year: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    rtc@6800 {
+        compatible = "mstar,ssd20xd-rtc";
+        reg = <0x6800 0x200>;
+    };
+...
-- 
2.39.2

