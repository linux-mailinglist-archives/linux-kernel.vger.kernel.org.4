Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC8A677130
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 18:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjAVRqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 12:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjAVRp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 12:45:58 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6556F741;
        Sun, 22 Jan 2023 09:45:55 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j17so7478156wms.0;
        Sun, 22 Jan 2023 09:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrGjhQpE634D6lomaeukDiYcPVKw6kiO4+o7Lkr2XV8=;
        b=Oiw9wjdmxkg+Z4X1DjeV2SoLl1sFCwYQDUjijKclKyrSxMeXiJqZgNr0BPZf6JIpgs
         gkH6Z8LGhwgAVPKDxR+v3AH/97TCjhu1hfdEB3V8hL26bcwc+kyzyEvOrRBONp3peds2
         cceLM70khghwzSDhlLDzU6D66PqvIEIwA/SpkXJj9V5RRcZsPJXNRuqu8Yf64JpXzbnO
         dwmquxz03jwcBmB9Pd3LHY6UEFCBiTjNJ1JksQWlvhRSgAULq96D776hZg4KlOEjXkks
         Hvh/gddGpnTnXp/2rX3GZvmc34PhXT3rW28szanLjP/5J3f8b6wGCVJ8BIWybwwA6Nby
         VsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrGjhQpE634D6lomaeukDiYcPVKw6kiO4+o7Lkr2XV8=;
        b=t8ehyuvzU/p18lgz4gR4E7KHFVwESx2TJvsjuM2QU2m+yKu0JilRD3X4r+1NrkauYS
         KCM1YLKoN19pavSQfMQ/8+y6yjTocPh16gq9k6cj2oqE1P+wqw0Y3wGC8vPDy7zEUfDt
         OB9hvY7ddaXyj7nD0ISUUXylX9qCnQl5j2GQ6IRS4Rdhm17PXkGR7EdjwQseuB1+Pas0
         YapuZN8hQkpR1MGS3VZihiXSuUJSVA8OV327Olnbo12ix8Xgl1mJBwkfvQYOiAXD0jmN
         rZih0AtohZtmnGAjjXJX496Q2qSvz2gXEogYrM4OeiiPvmD6gTxTMor1ym/n5PFj3tx3
         aLsA==
X-Gm-Message-State: AFqh2koeerSOSn5yfKdqzjMvVpr/7icAJJ718ZNp96potO3Lqt0lSIdB
        RSIkybY/SIJ0uVqg1DaqLCU=
X-Google-Smtp-Source: AMrXdXu2iwlFsFsuAc7BfKVvsmRM3ldpfmz19j3YaSnxzG3vzgP73jSuNizCOqWKail6FpyGVa4r4A==
X-Received: by 2002:a05:600c:1d85:b0:3db:1bc5:bbe7 with SMTP id p5-20020a05600c1d8500b003db1bc5bbe7mr14800225wms.0.1674409554113;
        Sun, 22 Jan 2023 09:45:54 -0800 (PST)
Received: from localhost.localdomain (93-34-89-61.ip49.fastwebnet.it. [93.34.89.61])
        by smtp.googlemail.com with ESMTPSA id m2-20020a05600c4f4200b003db0ad636d1sm9202257wmq.28.2023.01.22.09.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 09:45:53 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 2/2] dt-bindings: opp: opp-v2-kryo-cpu: enlarge opp-supported-hw maximum
Date:   Sun, 22 Jan 2023 18:45:48 +0100
Message-Id: <20230122174548.13758-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230122174548.13758-1-ansuelsmth@gmail.com>
References: <20230122174548.13758-1-ansuelsmth@gmail.com>
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
---
 .../bindings/opp/opp-v2-kryo-cpu.yaml         | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
index b4947b326773..908cb0d7695a 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
@@ -50,12 +50,28 @@ patternProperties:
       opp-supported-hw:
         description: |
           A single 32 bit bitmap value, representing compatible HW.
-          Bitmap:
+          Bitmap for MSM8996 format:
           0:  MSM8996, speedbin 0
           1:  MSM8996, speedbin 1
           2:  MSM8996, speedbin 2
           3-31:  unused
-        maximum: 0x7
+
+          Bitmap for MSM8996 later revision format:
+          0:  MSM8996, speedbin 0
+          1:  MSM8996, speedbin 1
+          2:  MSM8996, speedbin 2
+          3:  always set
+          4-31:  unused
+
+          Bitmap for MSM8996SG format (speedbin shifted of 4 left):
+          0-3:  unused
+          4:  MSM8996SG, speedbin 0
+          5:  MSM8996SG, speedbin 1
+          6:  MSM8996SG, speedbin 2
+          7-31:  unused
+        enum: [0x1, 0x2, 0x3, 0x4, 0x7,
+               0x9, 0xd, 0xe, 0xf,
+               0x10, 0x20, 0x30, 0x70]
 
       clock-latency-ns: true
 
-- 
2.38.1

