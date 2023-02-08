Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4900F68F232
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjBHPjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjBHPjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:39:41 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A5B48A37;
        Wed,  8 Feb 2023 07:39:38 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ba1so13114149wrb.5;
        Wed, 08 Feb 2023 07:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ai4b+jYyw5cqGgwQurdqHixIHibtkEl/YStppo1UAEw=;
        b=FQLtuY3Sl7LpxQh76NTsIOLrH8Jq1NNvlE42F4PxFgAKoKKyROk2dBtRd6tKdLq0BQ
         BYMSYywjJj2IlUrVSD0XT+G/GssyUPR8MNtLNaAg40eoyamc2PVkC8WU0yf6pUTnj8pb
         oruR8ENHG0Ekl4eLqlkgnVApSAYIfpevNYhNEeFOwL0QEsyxiroNzVBwYP1igR2H0JUZ
         uIXpBQYKhPJ8BsYPi9b7/OqmAyewEfbfLYg+pZdKQF7nxZQRJhy9bDSYiWnEFBhrkaQB
         JcazBuRam3ZEZinxwpECR3HA7DuRWQiTByWkbKP8WVsymWG2lpPXnur44brRi+IPbLdQ
         yh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ai4b+jYyw5cqGgwQurdqHixIHibtkEl/YStppo1UAEw=;
        b=xJ4mOPX0fJoI5Q34Y2qWzawf2cQRgfWVnAid6ajtHu33OYMCwufuw35upmydZgGPWi
         je4PDoIQlkiJWyPJsc9us6H5Vg/XjOmm6FIN8oCPehIFc3Pi5etJm+rkTCNT5oWgUqRm
         R0jhTmMDUrvP6R1zEt/jXKRy+EpPKU+TCyOpGSS3mHcw8nxkwraJ5Sj8YGUCcBXVRRIF
         LcBIMQyGBkZU6oJIfV7wlKHDHujDdU2pUGxyv6PQiOS0vI3YF5f2NC4vdosew6xptrTa
         FfKWrkDjQY7RDXZ89XVgRhabRImzZsNE+fdhM95hxduAZFYARTnc+q18IOt0Y3LUq4AY
         xBpQ==
X-Gm-Message-State: AO0yUKVMI2yTNT8pJAUK/SBqW2wcO4iT0Oql68iwoU42PLsox/94nGUl
        y0Wb1Yb6JnHqQLDi7Oj9kck=
X-Google-Smtp-Source: AK7set8iBupnOqMns+N8Z1VtP4hCRBwJa7b6c/HuULlhEG/d0GgtpTQfDR6PLen9OhuZm/odPIaZnQ==
X-Received: by 2002:a05:6000:1141:b0:2bf:e46c:8b9a with SMTP id d1-20020a056000114100b002bfe46c8b9amr7479592wrx.34.1675870777147;
        Wed, 08 Feb 2023 07:39:37 -0800 (PST)
Received: from localhost.localdomain (93-34-91-73.ip49.fastwebnet.it. [93.34.91.73])
        by smtp.googlemail.com with ESMTPSA id n2-20020a05600c3b8200b003dfe659f9b1sm6755596wms.3.2023.02.08.07.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 07:39:36 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 3/3] dt-bindings: opp: opp-v2-kryo-cpu: enlarge opp-supported-hw maximum
Date:   Wed,  8 Feb 2023 16:39:13 +0100
Message-Id: <20230208153913.24436-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230208153913.24436-1-ansuelsmth@gmail.com>
References: <20230208153913.24436-1-ansuelsmth@gmail.com>
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

Enlarge opp-supported-hw maximum value. In recent SoC we started
matching more bit and we currently match mask of 112. The old maximum of
7 was good for old SoC that didn't had complex id, but now this is
limiting and we need to enlarge it to support more variants.

Document all the various mask that can be used and limit them to only
reasonable values instead of using a generic maximum limit.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
changes v6:
- No change
Changes v5:
- No change
Changes v4:
- Add review tag from Krzysztof
Changes v3:
- Fix dt_binding_check for missing 0x5 and 0x6 value
Changes v2:
- Document additional bit format

 .../devicetree/bindings/opp/opp-v2-kryo-cpu.yaml | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
index b4947b326773..bbbad31ae4ca 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
@@ -50,12 +50,22 @@ patternProperties:
       opp-supported-hw:
         description: |
           A single 32 bit bitmap value, representing compatible HW.
-          Bitmap:
+          Bitmap for MSM8996 format:
           0:  MSM8996, speedbin 0
           1:  MSM8996, speedbin 1
           2:  MSM8996, speedbin 2
-          3-31:  unused
-        maximum: 0x7
+          3:  MSM8996, speedbin 3
+          4-31:  unused
+
+          Bitmap for MSM8996SG format (speedbin shifted of 4 left):
+          0-3:  unused
+          4:  MSM8996SG, speedbin 0
+          5:  MSM8996SG, speedbin 1
+          6:  MSM8996SG, speedbin 2
+          7-31:  unused
+        enum: [0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
+               0x9, 0xd, 0xe, 0xf,
+               0x10, 0x20, 0x30, 0x70]
 
       clock-latency-ns: true
 
-- 
2.38.1

