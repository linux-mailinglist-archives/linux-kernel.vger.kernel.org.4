Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960756767D9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 18:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjAUR5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 12:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjAUR5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 12:57:46 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9799425E35;
        Sat, 21 Jan 2023 09:57:27 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso7773739pjf.1;
        Sat, 21 Jan 2023 09:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8xerOhLO8JTLqzPKced78KygnBvXGTTylBpFDCkDJg=;
        b=cUDItZmBvVh5WDYr7E2FPoJX+xvQ3P5UMmOmgnyJ6TFVn2TXMGtNx7M1LcUKwM0fXD
         AFrAcl4Xaund8P53K9cNUAqhScIAmJAQD+tGBomQO7cHHnOT6OP6eXfvvcz7uHSIII/r
         qaPGgs/bXgrv/zbL+KelfVhdkCL1Mmqf0ZL2Jaai7TXOJBmnxXJjdb6BV14zQwMRtBWs
         FCeaXi9WYA8z/K31PrxsaMJwdiRjD50jBm3XCn9Cb4O8A7OXQ0WuOsVCmAxQYRQj6W36
         0eHAX21cZTvFSoJJR1io0t69icFdxTzyUUakQXGmftBqq+L/0vZOvlDF1k1LjPRHvfSI
         RvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8xerOhLO8JTLqzPKced78KygnBvXGTTylBpFDCkDJg=;
        b=nOxw1YOFtL0J6K5vhmARvwD/oJo7QZ9KDKTlcn/YZkm6wtxj7AhEprClH7FvAU1l3w
         Rup+v6zk5JY1N99QBrNWU+uPKa04lm0NEL4zzoHF21m9W2AE7jf1cnHTWV5+ciRSJ83y
         5bzPinGhctPFFi+5Hw99DJ2teZbfTxX3D87POnjRW10diNnkxIt0JGtWaAARiyy0+Elo
         Fi5z88khOTcJbAX70xtpDoGZIscnwn0gFIuLBZFzLoC59kRfb29qDA8yhQSNQ4DWS83R
         Cd4hG6ZYVCeR/baD+FrrkXYGRD9c8vv4o4sIGVD3c1zGRCcVODyoObiGU+bioLnCFCwR
         pogA==
X-Gm-Message-State: AFqh2kqmqgMe8vKwmQzTEC4ufuQ9M1cKkf0Tdu6piRK6ZoecfckPafih
        yFrpk4lwucPv+zdszasvuBqMmEZWNA0=
X-Google-Smtp-Source: AMrXdXsIU8tIRkm+vufigl+w38qOxbT1W4mxmURgtnWiSMXQvnsZPPB9L3Pw8OZa8rDBd+2S8LEzHA==
X-Received: by 2002:a05:6a20:6a91:b0:b9:92c2:7ed5 with SMTP id bi17-20020a056a206a9100b000b992c27ed5mr4487904pzb.22.1674323847084;
        Sat, 21 Jan 2023 09:57:27 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id r3-20020a632b03000000b00478e14e6e76sm24857374pgr.32.2023.01.21.09.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 09:57:26 -0800 (PST)
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
Subject: [PATCH v3 5/9] vendor-prefixes: Add VIA Labs, Inc.
Date:   Sat, 21 Jan 2023 17:56:33 +0000
Message-Id: <20230121175639.12818-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230121175639.12818-1-linux.amoon@gmail.com>
References: <20230121175639.12818-1-linux.amoon@gmail.com>
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

Add the vendor prefix for VIA Labs, Inc. (VLI) is a supplier
of USB and USB Power Delivery controllers for multi-functional devices
and platforms.

Website: https://www.via-labs.com/

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: - None
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

