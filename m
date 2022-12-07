Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EC36452E3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 05:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiLGEJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 23:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLGEJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 23:09:23 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DB44E6B6;
        Tue,  6 Dec 2022 20:09:22 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id q71so15180640pgq.8;
        Tue, 06 Dec 2022 20:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i76cNidMb9uGC4CAwhKLtXNE3wI2QcxYpZEpD1u1Q1s=;
        b=mFBaYqQbMTnqRYbRJV6ur40dCwgEs6PxrLe4ITOZ5srtXWXyYxdkv0ZUfXZAPpu8xE
         ZC+bZspLpDnkVYg4qW5+VCVltbF8BfTi349NHnGXWJHJFNYYNLKbplEpSG9LX9en5JD5
         5RtkZRFwBLiH4EW2Il287r0H7r+F4YV/5+SPmWRMYTinlqu8VJkSeVCnIg6q9ZNk6EMe
         AOWVryJwj70sJ9sFFm2MKwb7ppLsOGAoaG5Hm0yeCZA34D9YEiVJ5Dt9445c3AHsMy97
         PPV8KfzguT0YyN3u8GE6psAQNOmZxwWVaW97kZYWjdp5baC4lZ/R7K/ceDVESTnMdj4O
         mayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i76cNidMb9uGC4CAwhKLtXNE3wI2QcxYpZEpD1u1Q1s=;
        b=wdiP3kpYmjq4OZ7LIqRvJNY/S1M4aobS5YiMybRYvPMnyEZpQB48r0pZ69bjqq7ZRI
         TX8BpenlfOqTaN5oehmqUMbRbX8ICDo8BYb71emu7Zp84fP1JC4qz3ZvB4CJ7yf8+B3i
         XnZDXsOzqKACSW8FzRXFFpc7hbokm9FhFLdORSqoY/Z5CeE9CksDUuqQLCNB/ZVnbH+4
         yh3h+jrUHTilEcGE0OEr/i1SD4MH/vKH0zcbB21fYTLOCO6Q4RBif2UhgBkfmqbYH0aC
         ff98cybKo7SuqNcs+Nk2kVz1thtrYrJx/5YIH1ojLGRd8MVgd1PgI6/771E1AZg91Ns1
         gZIA==
X-Gm-Message-State: ANoB5pn0tjG4d0/rfoljidoc2xcbFbZg1iFKtLZHiMNlzryEDPL7HhN5
        6XGvCZxGXViZRlQBRgryNZXOBtSfWVU=
X-Google-Smtp-Source: AA0mqf4EWXNZ4h6bTO9WwDVyprVxVYV4wOii6qrSYFqPt9zgrLtOBqgi2Gx1Ts4J1DCGsRtqpcwePQ==
X-Received: by 2002:a65:64d1:0:b0:478:980a:53fb with SMTP id t17-20020a6564d1000000b00478980a53fbmr16881766pgv.484.1670386161965;
        Tue, 06 Dec 2022 20:09:21 -0800 (PST)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:5400:3ff:feb4:7578])
        by smtp.gmail.com with ESMTPSA id i15-20020a63130f000000b00478eb777d18sm587822pgl.72.2022.12.06.20.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 20:09:21 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: add an entry for WorldSemi
Date:   Wed,  7 Dec 2022 12:09:02 +0800
Message-Id: <20221207040904.582585-2-gch981213@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207040904.582585-1-gch981213@gmail.com>
References: <20221207040904.582585-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for WorldSemi that makes WS2812B
individually-addressable RGB LEDs.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Change since v1:
reword commit message
Change since v2: none

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 10c178d97b02..32274d894664 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1462,6 +1462,8 @@ patternProperties:
     description: Wondermedia Technologies, Inc.
   "^wobo,.*":
     description: Wobo
+  "^worldsemi,.*":
+    description: WorldSemi Co., Limited
   "^wanchanglong,.*":
     description: Wanchanglong Electronics Technology（SHENZHEN）Co.，Ltd.
   "^x-powers,.*":
-- 
2.38.1

