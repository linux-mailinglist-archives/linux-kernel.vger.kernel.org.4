Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A870729C58
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241059AbjFIOIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240067AbjFIOId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:08:33 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F129C35B0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:08:02 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5147dce372eso2774826a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686319658; x=1688911658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHO7vpOhYQx0clo/eQSsMDoAoRh8NI3AXk3LkWYJrvA=;
        b=UomGHu9e9xSud+fvhCguBVbINIy+Nt32q4XAikJT97lMKTKm3HPgMhhLX6IuwsxG6C
         IlFTtrHbH8A6Gqo5b8j1SOGNZm+CiQKQoje5e/5lrGhO51A7Z/EIVsCFQ8e2aScvc9mS
         ruZcnB2jUMqBwOWGFEwR/6Wrvj/l6N0vZhMRhAA8VrVy1EW+b+EWXVouAGB5bFsps0Da
         ZhH/uJvziOSJjcxvUXXjW5Z2L2CMAaOL4DLxAYFe7zUBHWBBc985NtsZikxTeAJW0aJT
         rb5525L/p6vTpbe0hvIQPxQ7CeZsRyPsdNZCyjzNinVutoS0Bh9kLtNpe/99FDtHjP4L
         Aczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686319658; x=1688911658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHO7vpOhYQx0clo/eQSsMDoAoRh8NI3AXk3LkWYJrvA=;
        b=Ci2P5Zf1gh5wdIyfZ6pU7y9oY18vFqULOMWDA84oEgeSKNABzssPSqNXjeCLJh+VcX
         DnbjJeU6DCx05ag1VJbQCBlIepzY/qm6rTD5g9pXugmNDVewfzktHq61fmLABVa7YVU4
         D5u+FFhfJcdVr2Fj96tv02jBD5lQA5ZiUzhoHqK+q0DPmedM7tdqaxzXJrwJInaN6/NG
         Wyw6UUey0dyYdCQ/KAHpSSoS3ncllpzF033Jeso9H3a4N6ZXpviRlP9ubxNh99pYHegU
         cAyiZ1RDLHsPfnjm4j5TBv+azMH/BIxdBMQ6A5Udxf8mmD1vsb3OlQs8p0tiiicPmIA7
         xeBg==
X-Gm-Message-State: AC+VfDzjaaNsBwym5NkN6kk1oRX3pZ3ubahosACEpQb10R5bEzQ8Ht34
        wAy352GzJw5gVwmIv9RFWzr7Lw==
X-Google-Smtp-Source: ACHHUZ4Ppp4dcuJtxj7Mzp5FZ/ew+7eEGU8lcR9YSExvb8u+Zk2l/gqQKALPR58wRCRl08O97AFDNw==
X-Received: by 2002:aa7:d986:0:b0:50d:9e7c:264d with SMTP id u6-20020aa7d986000000b0050d9e7c264dmr1345447eds.8.1686319657821;
        Fri, 09 Jun 2023 07:07:37 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id g16-20020aa7d1d0000000b0050bc4600d38sm1819861edp.79.2023.06.09.07.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:07:37 -0700 (PDT)
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
Subject: [PATCH] dt-bindings: i3c: silvaco,i3c-master: drop unneeded quotes
Date:   Fri,  9 Jun 2023 16:07:35 +0200
Message-Id: <20230609140735.64855-1-krzysztof.kozlowski@linaro.org>
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
 Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
index 62f3ca66274f..543b177f8610 100644
--- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Conor Culhane <conor.culhane@silvaco.com>
 
 allOf:
-  - $ref: "i3c.yaml#"
+  - $ref: i3c.yaml#
 
 properties:
   compatible:
-- 
2.34.1

