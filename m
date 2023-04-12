Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6056DE9B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 04:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjDLC6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 22:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDLC6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 22:58:16 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F5E4C12;
        Tue, 11 Apr 2023 19:58:13 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id ec6so106889oib.8;
        Tue, 11 Apr 2023 19:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681268292; x=1683860292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXm4p7yaMiNVUhho/kMZq4dDKz/JyVJh9U5+nL1pDFc=;
        b=f53rxXOXi1HJKKrIwKKRru/2JLbrbpxthT6U0UOPxC8Tp3t0t8d0wLxSZ7SFE2BeFM
         9d3MajQ8TXkWI5UCcBk2spAjAoOg739ufPUM66g7rLjgWr6P/emJ4bP9ajK+JKlzMff1
         DVTP73N63L00oMgGtc1aMzpmvWPWJBOXxG1BzkNaj1xFXAkzmcdtQRx7NSBanV4CbJta
         lv7qM+OvVPWTrm8mYL6j7m3SZGOcKJZSiYawFvwjGb3jITuppb8x5h9sLPjWr1oGZ+aF
         r1bOaByTWI0ZzAHVcrMGFTe+U1x5ZI5dyRC2sMCXyzqM0mkHHkUgTaeUv3df4r5ibK3r
         lweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681268292; x=1683860292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXm4p7yaMiNVUhho/kMZq4dDKz/JyVJh9U5+nL1pDFc=;
        b=DsROpvjHMT88WCISgkF2wnVGmaxdd9V024Lt9osm/qjBiAL4WFUXVJjmh/JmILoyMv
         RaiQ6JRufLmTmIf2xRjcUeZt0qDD6FrAqEAJ9/XSw0zDtv5vt0aj3llJPsCIeSwQngln
         p6vilqU03fqkdJfubk5j3LyLmtd7NVAA8/H6QnEiIf9anI1t3uN63ApghNRVruPNajKm
         7BX69FMoL260O1nGXITruZxIhpDz0yVIXkKUm6SxplJOu6Pg4oGGpXu0guuFOX0aBIaX
         7ScoPR59keIaZO2fEF+wUILMNhoHE9P7P6AD2lLP/bUiAUd04BhW3FF/Hl3JXaI4n/4x
         CWsQ==
X-Gm-Message-State: AAQBX9eSN5BT7TUc8gc3qUe//ZDUqROpPyLeB3jRbrRaWs6AfIOmtHTO
        HEVMTxbVkFl8kWSm2Fxf/Gc=
X-Google-Smtp-Source: AKy350aoVCsAwa+QgdiP3fZ5X6vuACk5DBXFp8Ir8jv2VyLGzIw3Y9i12MARjc4j1IpTC8oukuvJMQ==
X-Received: by 2002:a05:6808:11cc:b0:378:2df5:49f5 with SMTP id p12-20020a05680811cc00b003782df549f5mr5013826oiv.2.1681268292482;
        Tue, 11 Apr 2023 19:58:12 -0700 (PDT)
Received: from localhost.localdomain (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
        by smtp.gmail.com with ESMTPSA id b124-20020aca3482000000b0038bc0cb5d52sm3013293oia.9.2023.04.11.19.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 19:58:12 -0700 (PDT)
From:   Tony Dinh <mibodhi@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Tony Dinh <mibodhi@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ARM: dts: mvebu: Add device tree binding for Marvell Armada 38x
Date:   Tue, 11 Apr 2023 19:57:35 -0700
Message-Id: <20230412025737.20280-2-mibodhi@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230412025737.20280-1-mibodhi@gmail.com>
References: <20230412025737.20280-1-mibodhi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding for Marvell Armada 38x.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

Changes in v2:
- Add marvell,38x.yaml. For now, add this binding to the Marvell
directory to keep it consistent with other Marvell yaml files.
At a later date and a separate patch, consolidate the Marvell
yaml files into  marvell.yaml.

 .../bindings/arm/marvell/armada-38x.yaml      | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
new file mode 100644
index 000000000000..096bd46d932a
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/marvell/marvell,38x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Armada 38x Platforms
+
+maintainers:
+  - Gregory CLEMENT <gregory.clement@bootlin.com>
+  - Andrew Lunn <andrew@lunn.ch>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+
+      - description: Armada 380 SoC
+        items:
+          - const: marvell,armada380
+
+      - description: Armada 385 SoC
+        items:
+          - const: marvell,armada385
+
+additionalProperties: true
-- 
2.30.2

