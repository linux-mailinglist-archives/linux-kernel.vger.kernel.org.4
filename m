Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7766712BC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 05:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjAREpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 23:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjAREpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 23:45:16 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4293658649;
        Tue, 17 Jan 2023 20:45:05 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 141so23667311pgc.0;
        Tue, 17 Jan 2023 20:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfihuVFwjd5d3eUYDaVupZrTOejihs/ApCisILxFErw=;
        b=iIZ7zPl+O+toE3nPuz0aILU48jCG0tEOyL1xKTUO7wLHUYujqTmYAwqEqKKVHgKecJ
         LXU4VOntZP0lF9/kvYUdGa+JgcU6C4P9vvUjg1KcN6YSXHzE6gOUR6DdAGvax8go/t9a
         1gDk60IpS5taasM3iCzOMJNgu7OJpz8VQzIF3gwq04XLUnmgqMbF8P+b+se/HsXRZULS
         qJcElls5l4zMZa5YjwzfAZ+8+sMgI+Uf+1SkTBw3PdiCN6g3texCwlIneHxByniKWdxL
         SODuxoM4s/KYhZiaylSHIKbDkTwwMSFJoWwDrZbB1ddWubwiylfEhp1OR8aTUSFuBCph
         2EDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfihuVFwjd5d3eUYDaVupZrTOejihs/ApCisILxFErw=;
        b=uRdEND3Ayz4YF+PMX+Ix5ZgAmAPJPfWDK6MtOV/SVeH1Ij7JQwtOrT5ChwPgRPQrjX
         A4Pzp1WHcjaBmgrVVB2iRjktLnTIl/51e7yFTIBGZxWH+tEXrVzSXnzBSiVaXNnlBQcY
         P9UuEtqe14zXbN0t8isMnMw62oy06M/8twfd1MNcGyyaBQh/Rc5OsTcNApRU/Y8dk1PM
         Zwe+wsCftqtU8J+WmB/yNqeMvWSpY3FGdpOIQYwXtV78TE35LLZIBISwijRzNU4MhpkT
         9+EnjpQp8jA9f3oo7BUo2mUgmZk396YaHAriceTE3/y0VEHxd8AOENliEzPrn4KL4n7y
         eG0A==
X-Gm-Message-State: AFqh2kpBBMDf+EaP5s41XLvfnGINXxe0+rbZb0rnYUX/kHewwGB9TOqI
        6mtvvA3KLlZWULS03K9v6qLPoWlmphs=
X-Google-Smtp-Source: AMrXdXuPHaZARMk1tFINkL/nlmxzUDML6XCzLORMAthj8F2FYePyX1hUTAWnb30yDp8P3ssUGUGgSQ==
X-Received: by 2002:a62:15d2:0:b0:58d:be61:8bc5 with SMTP id 201-20020a6215d2000000b0058dbe618bc5mr6584900pfv.13.1674017104956;
        Tue, 17 Jan 2023 20:45:04 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id i1-20020a056a00004100b00581a156b920sm8682770pfk.132.2023.01.17.20.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 20:45:04 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] vendor-prefixes: Add VIA Labs, Inc.
Date:   Wed, 18 Jan 2023 04:44:13 +0000
Message-Id: <20230118044418.875-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230118044418.875-1-linux.amoon@gmail.com>
References: <20230118044418.875-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the vendor prefix for VIA Labs, Inc. (VLI) is a supplier
of USB and USB Power Delivery controllers for multi-functional devices
and platforms.

Website: https://www.via-labs.com/

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
V2: - drop Drop marketing, so without "leading".
    - add Ack of Krzysztof
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 70ffb3780621..d19b7f9cef4c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1398,6 +1398,8 @@ patternProperties:
     description: Vertexcom Technologies, Inc.
   "^via,.*":
     description: VIA Technologies, Inc.
+  "^vialab,.*":
+    description: VIA Labs, Inc.
   "^vicor,.*":
     description: Vicor Corporation
   "^videostrong,.*":
-- 
2.38.1

