Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB426761D7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjAUAB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAUAB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:01:56 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD6E8B745;
        Fri, 20 Jan 2023 16:01:55 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l8so5218199wms.3;
        Fri, 20 Jan 2023 16:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zd8X1w31p03LQ0JCvCdaSsk+BBXGwn/BPzQzqQpcm5U=;
        b=M6mW/VOyceIQU6kCUiqbPhsj390voQEygv7Xj7G/EX8aHytisKgnuyyHVCcMAEhl2c
         qvFRTzkHmqwxGaUbuggPsI2qm985n8Mm+y2XeAlof1TyLCDIWTYJFxdvD+QhVV+HfiEz
         Xb2emrjNNYupzLmYVcp4zOU/v6Jipdi20YSqkfu/P6IOQc/eDL6ecGiWabGMRuI6Nx6g
         DZWLwR76BATF8xH5vFmiqgm11Jd/VCRt+HIiJWo/6drEroHVQ8eGoN2P6jIMu4qeQhde
         3zNZ9Vh1ukdMJ8F1tDsXj4A3GK2Lljn5bZ7GAdDZo0J31UvON2W28p+p7eYjOEfOdUek
         c4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zd8X1w31p03LQ0JCvCdaSsk+BBXGwn/BPzQzqQpcm5U=;
        b=Kw0jhchT7cC2GzjBeYRtc06UQvnZqI8ZNtHvMfawXcPr0fpW4zjyhu2YWyXQHB+hZP
         X3ukiFyjB0NHae9eudfPEa589g94I8ooat0KLc7J7nWFCs11GWQL4Hq1BHzJ8I8UHY1V
         x6Ozz11BK6HNaZelmARer1mN9yi5uHPrnJurZCNzKTSF6zNfchuMFdjN+XIjQlfcHmot
         OZRdYgBT9kS1HEvtsB46FSOO2x3SijxSfWtTLgZgA/CDtPj1XhILOERQn1O/M++ZSuCL
         bLLzpTxzLPjhhYTG7/eK72EVK8EclJK2EYh3uX7296/xs2Sgnldgmnkf51m95jnIar1R
         0Gew==
X-Gm-Message-State: AFqh2kpib5I2oXFz6gE+n1s7lelXIG2CPtjELIBTkGt2zuNj8a+m/W9G
        nfNzHe/W+9+0UVavh6r1Yt0D4NkIZ9E=
X-Google-Smtp-Source: AMrXdXuYxoqI6p90pT35ZxeGJDEQ9mmGhNkEEZL6jHIzpZhm55SA6ZRINh+VoLsTszG9hQQAaHc68A==
X-Received: by 2002:a05:600c:4a27:b0:3da:fae5:7e2f with SMTP id c39-20020a05600c4a2700b003dafae57e2fmr16019245wmp.3.1674259314228;
        Fri, 20 Jan 2023 16:01:54 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id h11-20020a05600c314b00b003db2e3f2c7csm5284292wmo.0.2023.01.20.16.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 16:01:53 -0800 (PST)
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
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 2/3] dt-bindings: opp: opp-v2-kryo-cpu: add opp-microvolt nvmem based
Date:   Sat, 21 Jan 2023 01:01:45 +0100
Message-Id: <20230121000146.7809-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230121000146.7809-1-ansuelsmth@gmail.com>
References: <20230121000146.7809-1-ansuelsmth@gmail.com>
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

The operating-points-v2-kryo-cpu driver supports defining multiple
opp-microvolt based on the blown efuses in the soc. It consist of 3
values that are parsed: speedbin, psv and version. They are all
appended to the opp-microvolt name and selected by the nvmem driver and
loaded dynamically at runtime.

Example:

opp-microvolt-speed0-pvs0-v0 = <1050000 997500 1102500>;
opp-microvolt-speed0-pvs1-v0 = <975000 926250 1023750>;
opp-microvolt-speed0-pvs2-v0 = <925000 878750 971250>;
opp-microvolt-speed0-pvs3-v0 = <850000 807500 892500>;

Add support for this and reject these special binding if we don't have a
nvmem-cell to read data from.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/opp/opp-v2-kryo-cpu.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
index b4947b326773..cea932339faf 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
@@ -61,6 +61,17 @@ patternProperties:
 
       required-opps: true
 
+    patternProperties:
+      '^opp-microvolt-speed[0-9]-pvs[0-9]-v[0-9]$':
+        description: |
+          Assign a microvolt value to the opp hz based on the efuses value from
+          speedbin, pvs and version value read from the provided nvmem cell.
+        minItems: 1
+        maxItems: 8   # Should be enough regulators
+        items:
+          minItems: 1
+          maxItems: 3
+
     required:
       - opp-hz
 
@@ -75,6 +86,11 @@ then:
     '^opp-?[0-9]+$':
       required:
         - opp-supported-hw
+else:
+  patternProperties:
+    '^opp-?[0-9]+$':
+      patternProperties:
+        '^opp-microvolt-speed[0-9]-pvs[0-9]-v[0-9]$': false
 
 additionalProperties: false
 
-- 
2.38.1

