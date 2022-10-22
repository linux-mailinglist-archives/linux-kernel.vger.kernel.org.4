Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588BA608DED
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 17:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJVPNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 11:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJVPNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 11:13:04 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1A313642C;
        Sat, 22 Oct 2022 08:13:02 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so7098863wme.5;
        Sat, 22 Oct 2022 08:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pf0wqcQ2vn6wyNNf67PgKqcbfJEkj1r+s1XXcU5BuM8=;
        b=UG0ADy3qylqYF/CuZdFG9p/YHVjwUnpYwDe36KNKPP51jVACteTE8AjTvAOLRUBG3T
         UsPTz8tk0g3YldMIARqcWnFNqv9uQ32n78yLXAdxIvqLuyAlXeW69w3Z/tVhY/XezC+V
         ipNly49oTGbnfGJtz4BRGZhehUucjxySy/oUeNKSuyekpOrvc3O/82yPJNyR/ATYPvm4
         oDo4BqPRiuxQBzW3FRH5t1AQwbDOZkq93I/uIi4kzqSi+IUeTo510X8QHLAgfxH3o5CY
         1Ckhl2Qe4SB8dekQ79QiulXJqcs70Y1vgj6kWUg0o2sZIXtb6adT28jbgNzn5ZJMAwlX
         olNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pf0wqcQ2vn6wyNNf67PgKqcbfJEkj1r+s1XXcU5BuM8=;
        b=ArCqCaPE5qG9ADFNLCoXIUb8HnaMkBLam9sM1Lt2qOTeNdNseYSJ38iaweFbsy96Q5
         tLLdu41jq12COFH8aDS3rWy+MTLNddGm6W8lz1vbavO2KQjpMJdYsEEyUJ+XOmNWkC4M
         JJhqUCRqDqXLLql75gQYl2Giy/1eM/mmLQoKBwARtqzV/aFDTUAbRg4KIg0gfVBeyEUd
         l6M1kx1pdHgCTbAAhClEF+bLaITylKtaIhh6RoXbAjaqf9z1t1Be0O+gk/SI95+1LQtM
         WwBcWw2vIH/ImbzDA2qAZsmK4whYLVIhxmUmScK3IT0ifYUO2x6uq/XKvKG3KekVJyBt
         xscA==
X-Gm-Message-State: ACrzQf15aXhayYqgwXbcFOV4aJzr0ynpoZgZK6qeJkQdhvrH+ow8YGAQ
        KgxOkqYF1PVXSg23Ewi7lWo=
X-Google-Smtp-Source: AMsMyM5Lqow6tzJwhfOT8o5ANbc3i6cY5SNuqCSYfStNp0fIO+Y631oY7IJ9kToRhNfpYpis8r7mFQ==
X-Received: by 2002:a05:600c:4f46:b0:3c6:fb4f:3e1b with SMTP id m6-20020a05600c4f4600b003c6fb4f3e1bmr16909605wmq.159.1666451581054;
        Sat, 22 Oct 2022 08:13:01 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-133-18-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.18.133])
        by smtp.gmail.com with ESMTPSA id u11-20020adff88b000000b0022e2eaa2bdcsm21310581wrp.98.2022.10.22.08.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 08:13:00 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: serial: ingenic: Add support for the JZ4750/55 SoCs
Date:   Sat, 22 Oct 2022 18:12:23 +0300
Message-Id: <20221022151224.4000238-2-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221022151224.4000238-1-lis8215@gmail.com>
References: <20221022151224.4000238-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These SoCs UART block are the same as JZ4725b' one, the difference is
outside of the block - it is in the clock generation unit (CGU).
The difference requires to make a quirk for early console init.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 Documentation/devicetree/bindings/serial/ingenic,uart.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/ingenic,uart.yaml b/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
index 9ca7a18ec..315ceb722 100644
--- a/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
@@ -20,6 +20,7 @@ properties:
     oneOf:
       - enum:
           - ingenic,jz4740-uart
+          - ingenic,jz4750-uart
           - ingenic,jz4760-uart
           - ingenic,jz4780-uart
           - ingenic,x1000-uart
@@ -31,6 +32,9 @@ properties:
       - items:
           - const: ingenic,jz4725b-uart
           - const: ingenic,jz4740-uart
+      - items:
+          - const: ingenic,jz4755-uart
+          - const: ingenic,jz4750-uart
 
   reg:
     maxItems: 1
-- 
2.36.1

