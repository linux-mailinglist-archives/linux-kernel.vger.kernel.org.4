Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E948767CF1D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjAZPAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjAZPAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:00:37 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FAA6225F;
        Thu, 26 Jan 2023 07:00:36 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso3396967wmn.5;
        Thu, 26 Jan 2023 07:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqSdR9F/4qrsb/DJV5LDlpU6ymTD8vEIbDj/jR3v5UU=;
        b=Pwo8OUMiwZ6XoU7HhKrZAzp9QAXXeqHz68ZvLGWvbLCcTNLhmdrdTBGVL49XdMlB5B
         hilykyGdPc7OP+st9RqwaVY30pcj72pXqg50LNKQpBZdX7BOCh0Na05+8wQxDwP1yzgZ
         1XRV6LUMwL/Vov/12b7LNqWrv4IuJ5aiFuovUfZKhRLTxRkWviU++iqMhXmUBdSapvLY
         STwX0h8zM89gb/CLDXOnDqB1o4/hE64G0qolBFPggbgVixMztR33ddyDgSAbCz5mAmwd
         rrKX9kokoanbhzf5jHpciuQHqTF72RyOgBxWndJWdddabqQurO07x8/aa9QyMBeZH1SJ
         BCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqSdR9F/4qrsb/DJV5LDlpU6ymTD8vEIbDj/jR3v5UU=;
        b=bAxYHNFwkUlNhE7tLFMxogUpRmuWS6m3xp1QjnCYA9SHGoiX3mnAERubwG7xj+cFDh
         XmSo5BRJODd7xgsn8X8+2V0guBHqrrZu/CzLo5f2zGRikx1Kl3tOOyDMrtJYv+VPn+9T
         5YGzJBm0b/TwIwJcbiKTURldHYu/xDF/UC211TVwsjIKbzDExwuS51i4QeZxVP9HbpJn
         Wxz1RB9zVS0Cwl/4g85oWklR1weamlhLBGwT2JW2HrJ03zDjFNgn6813eUNhog61hK6m
         91Q3dYBgjkzpflqtllrkkHwiF4WpY1cbQ0IPLG/wLap3E/rrDuuEFz7Fv4+NRwH+3t/+
         txyg==
X-Gm-Message-State: AFqh2kpSpB7IxddxpE5CXrz3vFbnwf+9l6FDZdTU3SXKGRteAEZQ8EwX
        /jnSqpYdQ5FXWeP0N0AalrM=
X-Google-Smtp-Source: AMrXdXt0USSXq5i5MytDwxB6ZrZBqx437jvNBFLAZJMnw1BBKflR6VswmeEXY/2APXHdfz9hUaYPeQ==
X-Received: by 2002:a05:600c:4928:b0:3da:909f:1f6b with SMTP id f40-20020a05600c492800b003da909f1f6bmr36859843wmp.1.1674745235221;
        Thu, 26 Jan 2023 07:00:35 -0800 (PST)
Received: from localhost.localdomain (93-34-89-61.ip49.fastwebnet.it. [93.34.89.61])
        by smtp.googlemail.com with ESMTPSA id g12-20020a05600c310c00b003db012d49b7sm11353115wmo.2.2023.01.26.07.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 07:00:34 -0800 (PST)
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
Subject: [PATCH v4 2/3] dt-bindings: cpufreq: qcom-cpufreq-nvmem: specify supported opp tables
Date:   Thu, 26 Jan 2023 16:00:25 +0100
Message-Id: <20230126150026.14590-2-ansuelsmth@gmail.com>
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

Add info on what opp tables the defined devices in this schema supports
(operating-points-v2-kryo-cpu and operating-points-v2-qcom-level)
and reference them.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v4:
- Add patch split from patch 1

 .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
index 89e99a198281..6f5e7904181f 100644
--- a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
@@ -36,6 +36,25 @@ select:
   required:
     - compatible
 
+patternProperties:
+  '^opp-table(-[a-z0-9]+)?$':
+    allOf:
+      - if:
+          properties:
+            compatible:
+              const: operating-points-v2-kryo-cpu
+        then:
+          $ref: /schemas/opp/opp-v2-kryo-cpu.yaml#
+
+      - if:
+          properties:
+            compatible:
+              const: operating-points-v2-qcom-level
+        then:
+          $ref: /schemas/opp/opp-v2-qcom-level.yaml#
+
+    unevaluatedProperties: false
+
 allOf:
   - if:
       properties:
-- 
2.38.1

