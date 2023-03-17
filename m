Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3D76BE599
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCQJ3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCQJ3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:29:06 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595DF10A9C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:29:04 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id cy23so17785013edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679045342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VFUP5BW3Hbh1sE4rPRVXZjxwGcnBYX4/z1UolsFEGZg=;
        b=dHheWwzbQmX3zunqQ5lAYxMiyTxPJKcQeQsBjBQAkgPCqI2LYFPNEkZ6Eri0b7sRmD
         6c8/OTC5spAy6GfOSZhyoo74Q9qA60TGY3wKIgIadeBmoIsOdLzV0E2LWyxMpK3xMuAM
         RlOuLqJCmGoTmpzzKZDyxL/6UgBaogCbp8SSRdzBiF5H1nvvT8NWCWRfy9Gg61Nfdqea
         TVxvMZBrjZkzuNLMdmDG2QJy4+rEyz5pPvLnMTsP/YtqMxGgzoLn5kz5Vxbu8nSZEBqa
         gQkg9OJMH71rH7bgDM0+o0msHp7MLEKp9clbm4gYxJ59NUS/u4XLEgWQMk/Yu2qdorsr
         duXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679045342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFUP5BW3Hbh1sE4rPRVXZjxwGcnBYX4/z1UolsFEGZg=;
        b=AMvrFjaLqLp84nHqmlqo8Srwe+0FCpktTMZh/aPROPp6mawW+mHFjKcFV+F6N8siVh
         bVlGEwDgrmrJXn2WBa/k2ooqJ70pe8XbrSXQe0xSEhQol5h/mW5jii6J0rLDRi/xClyU
         uO+PnF5fp9FAA98S+599MW5mbw5yquIucTdyiqQ3O9HzOPjOhX6lKwsXh9XHiE5A6m7G
         JWoIUtTbTuXKNUCpLf+NrNWP4RKcIK7yPLWQa6aoq2xnMtPHdbma3yomk9hb/0MgUQ7D
         pDcyFFztuQgcsK4TPtwSVlGUU/JbTy8J53LCAnDlHP9IrP62Nc4Bi/TsoMKpW/Vfo12p
         wOZw==
X-Gm-Message-State: AO0yUKWlnzehrgsOIPErLbkzOi7Q6Jjd2LXAJwbQ8SABmBXfciMMjMbp
        GhKW34ToTkL1e0iEhSAsVTGP+Q==
X-Google-Smtp-Source: AK7set97O71P2trKPqgfWFwmNAyhaCD6puLvQFOFMU4zjAyg3XBjs8CH/e2ya6Z53yC5PK+oJJaY3w==
X-Received: by 2002:a17:907:3186:b0:932:3536:2369 with SMTP id xe6-20020a170907318600b0093235362369mr673097ejb.26.1679045342610;
        Fri, 17 Mar 2023 02:29:02 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:848a:1971:93e0:b465])
        by smtp.gmail.com with ESMTPSA id c25-20020a50f619000000b004bd6e3ed196sm792176edn.86.2023.03.17.02.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 02:29:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vijaya Anand <sunrockers8@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] ASoC: dt-bindings: adi,adau17x1: fix indentation and example
Date:   Fri, 17 Mar 2023 10:29:00 +0100
Message-Id: <20230317092900.16770-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix errors in binding indentation and example:

  adi,adau17x1.yaml:8:2: [warning] wrong indentation: expected 2 but found 1 (indentation)
  adi,adau17x1.example.dts:29.3-30.1 syntax error

Fixes: 87771c940258 ("ASoC: dt-bindings: adi,adau17x1: Convert to DT schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Fix typo in subject
2. Add fixes tag - commit SHA from ASoC next branch
---
 Documentation/devicetree/bindings/sound/adi,adau17x1.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/adi,adau17x1.yaml b/Documentation/devicetree/bindings/sound/adi,adau17x1.yaml
index 45955f38b6fd..8ef1e7f6ec91 100644
--- a/Documentation/devicetree/bindings/sound/adi,adau17x1.yaml
+++ b/Documentation/devicetree/bindings/sound/adi,adau17x1.yaml
@@ -4,8 +4,7 @@
 $id: http://devicetree.org/schemas/sound/adi,adau17x1.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title:
- Analog Devices ADAU1361/ADAU1461/ADAU1761/ADAU1961/ADAU1381/ADAU1781 Codec
+title: Analog Devices ADAU1361/ADAU1461/ADAU1761/ADAU1961/ADAU1381/ADAU1781 Codec
 
 maintainers:
   - Lars-Peter Clausen <lars@metafoo.de>
@@ -50,3 +49,4 @@ examples:
         clock-names = "mclk";
         clocks = <&audio_clock>;
       };
+    };
-- 
2.34.1

