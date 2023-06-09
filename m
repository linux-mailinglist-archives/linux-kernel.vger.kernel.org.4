Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBDD729C5C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241244AbjFIOIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240514AbjFIOIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:08:34 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC403A82
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:08:08 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b1b3836392so20234831fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686319664; x=1688911664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vb3nOB5mmNaSLiLGidKYWAt5bGJLOhDgqIJjapvpICE=;
        b=GWJtdr1fwLxS7pZ3C4Vr14gwlvHOrjOk2E0+WbvNPI+/M28gg8546jWNV+ocxjLl4i
         NZUUWcQGNrq3nSO8DP63olYk5PJyq/zYxF8PlOSbXnKp2Ydu6KsHrbQkrO4Fy0qU/fIo
         vcF5HXDV5bQ9R77E6QtkDyIRLXdnAZXOfL2JspuY8PmSCt6FqMsy/u/nht3JFlj7VG50
         x/d5wGh9ilEJ6QHNhvgWRPsPWf0FCco20IjyLpoOJ4tHaCjosn5eUKxJmgAiwiwdXVx8
         T4wSmEwaQ4TP7OMGVSofcvcRI8hXo4sXV2xD0Cnn2+rtwwjuccDUJYqaPXlIHGSm7mSq
         fbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686319664; x=1688911664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vb3nOB5mmNaSLiLGidKYWAt5bGJLOhDgqIJjapvpICE=;
        b=Fx748zsCNitMWNHn1l9ojDvWyrjfbghH1vBilJVDobmPhqYxEgeoLT1LYNqpzMu3xE
         adWMX1w/eVhLhD/Un5NypLdTir7iW+R/y0ntFuzMXs88c9OVmP6PPQzpugeOTXySChVR
         fDaPS0+HEPQeDY//MAnOzbVUvUBRHSgF5k+ihAw6prdKA9zX30lGMEqiOMKonwkBlTaI
         sq4ED9QzNF2xV8qyyRUJtt8tPN0avVWfIQQLUr72Neu/sgc/HOLgyWDQOmrmVOl5Si77
         2nm4jAtxupU2s/iHSdf2gIojjII3/dFDIOtUcmk8sCK04+4wOuKefHl4lsV9LPPKuDOy
         aNKQ==
X-Gm-Message-State: AC+VfDwcGjA1jjy8zf4M+fkwUWnB/vEiFaIuy8KlLGRWp4UpgUhPQNHw
        JEr+t//9TBhQ8SAWd0w2Fa1M1A==
X-Google-Smtp-Source: ACHHUZ7+WporHM7dwtaJEdMlTqs6kXxNbsAOHTQfd47NY2qmSob4WjVVPmv5It3WTfWYmOyP6ZmzlA==
X-Received: by 2002:a2e:9a86:0:b0:2b1:c783:b905 with SMTP id p6-20020a2e9a86000000b002b1c783b905mr1112603lji.15.1686319664618;
        Fri, 09 Jun 2023 07:07:44 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id jw15-20020a17090776af00b00977e66ff323sm1337706ejc.75.2023.06.09.07.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:07:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: dvfs: drop unneeded quotes
Date:   Fri,  9 Jun 2023 16:07:42 +0200
Message-Id: <20230609140742.65018-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/dvfs/performance-domain.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dvfs/performance-domain.yaml b/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
index 1dcb85a02a76..cc930660b794 100644
--- a/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
+++ b/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
@@ -42,7 +42,7 @@ properties:
     enum: [ 0, 1 ]
 
   performance-domains:
-    $ref: '/schemas/types.yaml#/definitions/phandle-array'
+    $ref: /schemas/types.yaml#/definitions/phandle-array
     description:
       A phandle and performance domain specifier as defined by bindings of the
       performance controller/provider specified by phandle.
-- 
2.34.1

