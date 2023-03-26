Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5D46C9651
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 17:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjCZPyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 11:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjCZPyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 11:54:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476A04497
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 08:54:35 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t10so26098409edd.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 08:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679846074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CYAkeBkiK+UhGthwoQ1EwlNXrFR2ygK1R+o0KFshok=;
        b=iniB2T59+riVzewdPmkYZTlzSoMEMibvs1gKTUrFj/FlPUgrgbP4ZJDQNewJS/NVhn
         1CFxpd3JcXrRLeifWK2d/aO8I8l3m6pe3ON92TN+gvOaDEJEJR1GyVkWtAoSoH495O/g
         AWUXli4NoPQNE6/xAGw9W8gPX/OnisQIit2jCrYeRyb2+qDOYralNkm9GjOQpOqKicnu
         6hTQQeTGxWwNEXOFRh1mGoTC2KMIfKu77IBW8XupaiP78TLYTZOu0tEsf+xr7cvLqyo2
         kOzHJEpTrOSlNYZ88ch50BuhzvasTM99iYPMFRuWtxQ7R/xGmLlsIgxNdRQxZPLKNPhr
         ILpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679846074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CYAkeBkiK+UhGthwoQ1EwlNXrFR2ygK1R+o0KFshok=;
        b=QMBWmeohoSKEPEM3tgVvKPmYWXVVpIbGMWZE2F8Oxc5iN5Z0pWWccXOtyt9EUwh1WK
         TMmODRIJReuHSXszALb3PXsN2BEOrmvlhKTmv4gmK5dwDJ1M3sCe9qwWM/Li1dWagO70
         JSr6fl/rndZcnvsFKngUpSEhPZhZst4uPV3eIlhNUu1Ip6pxQqDbhZwOnqdgbh3LIHN8
         tGzazxwjrEO5K3QxrnELYvZfBvs+7/PEXMt43xq1q+IJjzW4NEI4DgdHg8CQ91e2epzi
         eb6mKgYC+YKKsM4MGlyzK/ANKaiGomGKzhvqRWp9F21ViYXZNDozhfz2DjgOhHfZl+XU
         lNjA==
X-Gm-Message-State: AAQBX9dS5MDskK2xq7oL87oWZ3RQe+7IVVDMpkcpSQZ1lRKtoO9Zd5C+
        cLZXbzkTzw+JDT+6RZcxO+XH1A==
X-Google-Smtp-Source: AKy350YpYs/8Vdmi3STGf5AquUGui7sbir34hOCWu9zkXPhfNRRkOuFcZ9t6H3NCocxlP0Gvgw4JwQ==
X-Received: by 2002:aa7:c846:0:b0:4fb:8d3c:3b86 with SMTP id g6-20020aa7c846000000b004fb8d3c3b86mr9105609edt.1.1679846074821;
        Sun, 26 Mar 2023 08:54:34 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:eca3:3b8f:823b:2669])
        by smtp.gmail.com with ESMTPSA id l6-20020a50d6c6000000b004af62273b66sm13506742edj.18.2023.03.26.08.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 08:54:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Srba <Michael.Srba@seznam.cz>,
        Harigovindan P <harigovi@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 6/6] dt-bindings: display: boe,tv101wum-nl6: document rotation
Date:   Sun, 26 Mar 2023 17:54:25 +0200
Message-Id: <20230326155425.91181-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230326155425.91181-1-krzysztof.kozlowski@linaro.org>
References: <20230326155425.91181-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow 'rotation' property (coming from panel-common.yaml) already used
in DTS:

  sc7180-trogdor-quackingstick-r0.dtb: panel@0: 'rotation' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
index f98ed588c750..aed55608ebf6 100644
--- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
+++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
@@ -55,6 +55,7 @@ properties:
     description: phandle of the backlight device attached to the panel
 
   port: true
+  rotation: true
 
 required:
   - compatible
-- 
2.34.1

