Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64726729C70
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240744AbjFIOLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239305AbjFIOLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:11:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ED630FA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:11:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51493ec65d8so3210575a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686319871; x=1688911871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/K6Rw2BBP9t+cXD/TQNNgIcmDtvMs3lPtOP/UrH7G7A=;
        b=h8iBAptxQttk0bbiDQovJX+21DX7qKwXrBnmFU8s/hafPH5IMfV9JPDAnfrO9dj6LG
         xbVO/VZyIdyOy+iWQY2QwUrj+zWEwUCd1q9HZyskeaWGgKuHNO/hBaOhA/9XhXYiwaLA
         ReYu7KIrqSfnbXk77keMmhg2OTqBdxE1V08BwbchEr1OTpsNuUGhsCXgijheYy3u48TX
         QYcbO4W+WWycTcDRWTNPX7x6+spFetTqAcIq7U2UY361cix5dzfM9r+jDvPGSGczvFGS
         Llh1ycz9FWXTU6b5OxEbOZ4ImHtOv+ooW6Qu+JQ7BN8bqyECz0v37mlfsPCtm8TrFpiT
         T61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686319871; x=1688911871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/K6Rw2BBP9t+cXD/TQNNgIcmDtvMs3lPtOP/UrH7G7A=;
        b=KlY8BKrat3UVtI09BoeCgEeoBfUN8Gd/joTEEtPSIAjobOAnqK7dPxhoJY10vk7a7H
         JBEHvR2kFCjK8mGUX+oWG0XQpdpTxw03ciT7OfKsKkdG7cclGdgFr6IDpWHvAXFmJeYU
         WTkv77519fQm+IYneIFtT+NusDmNcq8FIYyXS0rWqRR+ge70TXstG6wW0hkLIrI3bUaZ
         +y29JO/eZjiw/pozLulCmWdJhRjJK0IR6K7Zh6+QuBABj6JPohhMJoGewQJuIswy91Vb
         22dHcyP7BHuyMmbIu/YeZrrYD6FkcamrpHkGWySpFWc8mYsc2ifSK/td98k1YAHbckPZ
         iEWA==
X-Gm-Message-State: AC+VfDxp1PFMeEa6hexx71hJKk7zhR82vGFkhoa4prK1a8sWJ/g2OnIp
        DHetM4PwPghuhRmQqV5OKi5HCHZn8MVKo0rALy8=
X-Google-Smtp-Source: ACHHUZ72lwQsFlXEqj6bo/VjtGXzWFH6QAIcDwwdCZXs2QTBJ0U74KDahv1uUbSVB3/zT/7EcJIc0g==
X-Received: by 2002:a17:907:9686:b0:978:acec:36ab with SMTP id hd6-20020a170907968600b00978acec36abmr2278703ejc.35.1686319871665;
        Fri, 09 Jun 2023 07:11:11 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id r8-20020a170906350800b00965fdb90801sm1327704eja.153.2023.06.09.07.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:11:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Conor Culhane <conor.culhane@silvaco.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: i3c: silvaco,i3c-master: fix missing schema restriction
Date:   Fri,  9 Jun 2023 16:11:07 +0200
Message-Id: <20230609141107.66128-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each device schema must end with unevaluatedProperties: false, if it
references other common schema.  Otherwise it would allow any properties
to be listed.

Fixes: b8b0446f1f1a ("dt-bindings: i3c: Describe Silvaco master binding")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
index 543b177f8610..133855f11b4f 100644
--- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
@@ -44,7 +44,7 @@ required:
   - clock-names
   - clocks
 
-additionalProperties: true
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

