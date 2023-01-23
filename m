Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93682678675
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjAWTej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjAWTeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:34:37 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B8930E93;
        Mon, 23 Jan 2023 11:34:35 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id e3so11822284wru.13;
        Mon, 23 Jan 2023 11:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soIeeALkS41bJ2ncvnZDLOOPGxMriqJTL5s1g1AyJyc=;
        b=ZXMPZfkOFIL6dxeDLSpIRvNj9o6WVBrQyyyuuxO4aH8UdL8p8gg/FiQQ97cQLhMeXU
         VEUo0xjJYLnWhQFzLFdnn47I6nq785nL8oPWyp0K9rgsniZcJOaqghz+AG068L0MU+xW
         Bqx6nuAZ2hLA22ySlcqUEXE//qir9d0THhXT4/P/494Ysckf00Ml+8ekbKarNVNOwK8e
         Q6ffxoTB4psAMWeZfixOUtBJenIIR6WRg0vcrHrq4bUAcbVO4xQbn69Crr5a/T/zFVFU
         e1OeXt6qREJEbh29PFd8URiT8VWsIMf6dtMmvJ/y65E7C1h3mIIL7Oz4DXrFHWPpItDN
         CmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soIeeALkS41bJ2ncvnZDLOOPGxMriqJTL5s1g1AyJyc=;
        b=AchauiRQW/2UDYC9cXXqhno0AdbaJ7/RgSghKN0/Ri6wxjud2HDphEjSNGTT5FfBO+
         tJJTZpK0dNo1zREIKG2Ywfhveu7OdFzoSrCkWI4DaGHWLd8q4nbT9OI8UHUx+i5YucLM
         UZKLVbNIdhfyqq/nTPkhV01hMOMU0zm3p7WclH/SMPrZIDerBHVe6p0ZI/f0Z59yj50d
         6XTNSyc1JvUpRwO5Yx52WSvEmWXhiyttBMnSkgqDgt7mR6a8FtI2P5XF6IaFnT9QvYSa
         I9ARHlWtemy+GE9+0XoWhUZFTr7x/Xt5+be2v4Wwl/AAe7x77nmHGq8Xm4Md3TRoUmCr
         7R4Q==
X-Gm-Message-State: AFqh2kopzs75q0NWAj1s7qhflwZ0JVC8psdQVNxLTICD5qgXfW4XCI5r
        tbhK77cElWJho4/Tekjb/uGk2OfcMEQ=
X-Google-Smtp-Source: AMrXdXswKfzpNtGZwSh6N9h23hhfo2/ZJ4yh+Eljese29HLOMBEU93s0Z968TxRIVGWoSQt5mMNBrg==
X-Received: by 2002:a5d:4350:0:b0:2be:5366:8cdf with SMTP id u16-20020a5d4350000000b002be53668cdfmr11652548wrr.20.1674502474339;
        Mon, 23 Jan 2023 11:34:34 -0800 (PST)
Received: from localhost.localdomain (93-34-89-61.ip49.fastwebnet.it. [93.34.89.61])
        by smtp.googlemail.com with ESMTPSA id z8-20020a5d4408000000b002b8fe58d6desm151428wrq.62.2023.01.23.11.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 11:34:34 -0800 (PST)
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
Subject: [PATCH v3 2/2] dt-bindings: opp: opp-v2-kryo-cpu: enlarge opp-supported-hw maximum
Date:   Mon, 23 Jan 2023 20:34:22 +0100
Message-Id: <20230123193422.15972-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230123193422.15972-1-ansuelsmth@gmail.com>
References: <20230123193422.15972-1-ansuelsmth@gmail.com>
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

