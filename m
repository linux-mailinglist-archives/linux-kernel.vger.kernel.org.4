Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD82667CF1E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjAZPAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjAZPAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:00:38 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150BD62249;
        Thu, 26 Jan 2023 07:00:38 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso4273693wmb.0;
        Thu, 26 Jan 2023 07:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lu+Or8PKYbtWV7OORtae6hV8R5JH5zBcgVLlCGfEJ6Y=;
        b=Ad0P9ilJcflpOjq+J1Bs4K5nTZpauWznYDwTxBMdJ/H3DadeK+Oagt5Uvago52MtkI
         bg7E4ZnmpP8KQHzCITHQtuYrqtgQZtj8LDidMsB8Hm77wp+oV7H4DEs+gfP1+qALOujA
         0D/XMnipRjqloV6ylVpl9SEgAREiunj5tfsLsRH4QAYZvI9a/3Sa4xy9i0DhczIH0NL7
         GUP9z99wyV5cT7g/FCShv2Kews1XIH43c8y+Z/c7egZwePWBFvBhUqt6iQQbGaVeS02J
         bffwqT+kufont17OoVuuTEONJZKE64cSGXFqd5Ubz1D8OCWbpoqfncCovqL6Ja0684a6
         TgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lu+Or8PKYbtWV7OORtae6hV8R5JH5zBcgVLlCGfEJ6Y=;
        b=d/6oT9aPzo1h5q5jQW9TB3hneKBsDvYWGR5Oe8aA7x0GhkxrXjhBjalGeXDZLq0swb
         Jay5wkMPLjiFj/s3xjWZbFWS2ixBQCkTXRe6w5KxfhHGPhwxmmxEQ5XIY9RkL82qSozw
         pCg5ARqOhCqFtBXV4cyzSF+FtnmxRG4cyu25F8xdFoVFa6DV928DgYj29D0T73fvqOWV
         mzON57KFI0EYvTRZV8JEDNz1br/oNJRazriXwVqxJ1Sp6vZKhKvFt4TGS4u20gJ/SGwM
         SVD2k3WrOtav1V4j74jJJOfImWR1W6tLDVXwfnHeBrSPzHNHG51Gp0iM3TnHJgL+MRdb
         bNgA==
X-Gm-Message-State: AFqh2kqxG3OYSOuceOehcgJPB7gYTRCoGtidd/uS35C3VFIaC93J9d/E
        ukFZzZ/XHW+DghpbkxbwmZY=
X-Google-Smtp-Source: AMrXdXvPwQy0kCKun6Wgxcc78WxueZ1cqFp3ufrgAEiqyqQnr/aP/z1oQhWpwjzkCxLRTvndOgic9A==
X-Received: by 2002:a05:600c:35cf:b0:3d3:49db:d95 with SMTP id r15-20020a05600c35cf00b003d349db0d95mr35521142wmq.37.1674745236485;
        Thu, 26 Jan 2023 07:00:36 -0800 (PST)
Received: from localhost.localdomain (93-34-89-61.ip49.fastwebnet.it. [93.34.89.61])
        by smtp.googlemail.com with ESMTPSA id g12-20020a05600c310c00b003db012d49b7sm11353115wmo.2.2023.01.26.07.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 07:00:36 -0800 (PST)
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
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 3/3] dt-bindings: opp: opp-v2-kryo-cpu: enlarge opp-supported-hw maximum
Date:   Thu, 26 Jan 2023 16:00:26 +0100
Message-Id: <20230126150026.14590-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230126150026.14590-1-ansuelsmth@gmail.com>
References: <20230126150026.14590-1-ansuelsmth@gmail.com>
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

