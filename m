Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9110F673923
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjASNBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjASNAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:00:44 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770CC689C6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:00:35 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id q8so1448379wmo.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AOd0ZEvKWMBuKPkPo/Zqo5m7MHUWNQaguVRXb3+VEo=;
        b=om7J09nbshDZbj2XaKZYzaxIokzE1OsS8949cUasFL+lXb7uYWM3TEtpN9q9JT7Hu5
         TfC0UO5YhYL37zgF6qUYY6ekRtKQQRLIibraBmtfBEnQoVe5J4EhwOuz9cuX6P9LfJyO
         Ag4qV86TX2woox4IcNrNM76cI5FeqYo53sFX5nTZEIxqtTO5dL7HrAWYaceYdsdVLQZ8
         qv7bzpC71Jo6vByGb63uMbo2o4ZM6yZjVw4Gcjog+eb5eywYcJu62q6h8DQCjKoyUNoW
         HonoeQsVG+jHEHqnWp5O8ANqWd4UA+J2TF9PiUYkZva5Xy/kJ756Cl+WfiR21bBtB02g
         BEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AOd0ZEvKWMBuKPkPo/Zqo5m7MHUWNQaguVRXb3+VEo=;
        b=J194lhgHjws7dTaqX7K6pAZeCIN9py+yAxnV5xBxNpDPaTGkgpxgf+GBiJezcxTEYT
         uYThGuX9qtYMiq0nalOw6Qr2T+1fQg8eg+tOzmxBLGRjd5lp1//rkoSnzMWEEQ4ExfDh
         mbU655eacsjyUxj6nhbrO1eayqiL/El1vX2DKOEptVREpXfCt5l4F3hf0x5fAZhO0tav
         CsNaGm/mRHYOx9O/ROO8YsZknwMLI5/nyZqoRJlez7gN4zCvPZaFIuywnucPucgFPCk9
         pj5K06bwMg226HhO2HSnK4GvabknPNLWLRxNW+2uWW3YkFqwtX6/qdqPV1Y0OXMGAPdf
         AILQ==
X-Gm-Message-State: AFqh2kpaJ6QmF3w9U5LgAMODEHrhjGUgL0pf59NacFfaXWLxxkaDnTBc
        ir+KaUIDiRLprrS7uVs8H8BpAg==
X-Google-Smtp-Source: AMrXdXuoBqS2MH52Ow6nOKuruhqXm5kecfENqnEwAFj/KPuJ+4p2xMa+YfA+o3bZIFzy0n90wBe9WQ==
X-Received: by 2002:a05:600c:21c4:b0:3da:fcf1:d4cc with SMTP id x4-20020a05600c21c400b003dafcf1d4ccmr10273418wmj.30.1674133233983;
        Thu, 19 Jan 2023 05:00:33 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w1-20020a1cf601000000b003daf681d05dsm4823808wmc.26.2023.01.19.05.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 05:00:33 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: opp: constrain required-opps
Date:   Thu, 19 Jan 2023 14:00:28 +0100
Message-Id: <20230119130028.106817-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230119130028.106817-1-krzysztof.kozlowski@linaro.org>
References: <20230119130028.106817-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Be specific how many required-opps are allowed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

This change is independent, although logically is connected with my
dtschema pull:
https://github.com/devicetree-org/dt-schema/pull/95
---
 Documentation/devicetree/bindings/opp/opp-v2-base.yaml     | 1 +
 Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
index 47e6f36b7637..9b141a409191 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
@@ -202,6 +202,7 @@ patternProperties:
           for the functioning of the current device at the current OPP (where
           this property is present).
         $ref: /schemas/types.yaml#/definitions/phandle-array
+        maxItems: 1
         items:
           maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
index b4947b326773..438880db1872 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
@@ -59,7 +59,8 @@ patternProperties:
 
       clock-latency-ns: true
 
-      required-opps: true
+      required-opps:
+        maxItems: 1
 
     required:
       - opp-hz
-- 
2.34.1

