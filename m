Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D476092C3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 14:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiJWMkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 08:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiJWMke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 08:40:34 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931A65E64B;
        Sun, 23 Oct 2022 05:40:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k8so2919061wrh.1;
        Sun, 23 Oct 2022 05:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uB/YFZqZEaKiFGlCwO3LrxhNU5OpxJ4tB5tamj6ARsY=;
        b=qzQMw7ON0+uZJDhMnQkrOx/vildPqKEk5MWsXxxjSgjt1NhkKIQPrd8Paz0GJt+/E+
         BySv59VCApo5zQ43/uzN98ta+zDRaI3lHAyblbOu7Cz2l0B1A8rjN3NzRmlU3S3FplgZ
         EziwBJ3ViH7XqBOsbeuQAmK70imiUGieCcR8UUWQwQs7WsaG8LfTQgS7aFASf0qivopI
         +vWRC/L0kh0Yvl5l17qtaYO2nzjR4pHZiNC42QJuze30GWRBLbIrOnjTJxwO5wOqQb3U
         uvNLQtGtSLrrhFTX/KfJsgKGmNY5lEmjXh50tK2XDkKhDUpqn9eLQXFy/8qttoBQgI6Q
         m08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uB/YFZqZEaKiFGlCwO3LrxhNU5OpxJ4tB5tamj6ARsY=;
        b=BRh5AJ+VZtGt8qS6WSYnEZg/WhChnicp2MquhxyFQZz2IHWWt5Jzn/Clnje6pMUGw/
         D1XpfNdfnwYysFIrid+ikHsjBMInv5yOIRnEGz9qiCyvhLGaJbVvF16TAhsvDmYm8BHj
         xEUc3ZrifCMyQGhQ2JH5eGb8uBj+GzokzGiGhhv8rz/xcf3hF5pioicX0K256kn3YO8x
         RDl76knMa/Mx7JkhNiJaF8tATdVdfS97qein2jz3bpCyiXpDHV2r1rtXOYob0/CMWF2y
         ZaV8JpahZN8xRIZ/169Bj3Li5xAuGLJMSpS2V2ePs/7s7CNcHaN2R6dhRG17dDdJBH3l
         FhLw==
X-Gm-Message-State: ACrzQf3H2C2K+oTPyRIJUexF6avazyPJW1tmvaMXZjDRSB5UyhQDp7Ke
        zlBnTyUBnzk4xyFXjVz+ZVY=
X-Google-Smtp-Source: AMsMyM5J2yNqU6RlSo9TZe86AUUUEwPlm+jJkOW4Q2o614K1u6exZF/bThCO29DJZ7QUDTb15jqCBA==
X-Received: by 2002:adf:b612:0:b0:236:5d1f:143a with SMTP id f18-20020adfb612000000b002365d1f143amr4791485wre.364.1666528823948;
        Sun, 23 Oct 2022 05:40:23 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-133-19-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.19.133])
        by smtp.gmail.com with ESMTPSA id p5-20020a1c5445000000b003c71358a42dsm6286497wmi.18.2022.10.23.05.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 05:40:23 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: ingenic: Add support for the JZ4755 CGU
Date:   Sun, 23 Oct 2022 15:39:42 +0300
Message-Id: <20221023123944.4103876-2-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221023123944.4103876-1-lis8215@gmail.com>
References: <20221023123944.4103876-1-lis8215@gmail.com>
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

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 Documentation/devicetree/bindings/clock/ingenic,cgu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml b/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
index aa1df03ef..df256ebcd 100644
--- a/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
+++ b/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
@@ -22,6 +22,7 @@ select:
         enum:
           - ingenic,jz4740-cgu
           - ingenic,jz4725b-cgu
+          - ingenic,jz4755-cgu
           - ingenic,jz4760-cgu
           - ingenic,jz4760b-cgu
           - ingenic,jz4770-cgu
@@ -51,6 +52,7 @@ properties:
       - enum:
           - ingenic,jz4740-cgu
           - ingenic,jz4725b-cgu
+          - ingenic,jz4755-cgu
           - ingenic,jz4760-cgu
           - ingenic,jz4760b-cgu
           - ingenic,jz4770-cgu
-- 
2.36.1

