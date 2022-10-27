Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2A3610181
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbiJ0TUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbiJ0TUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:20:35 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3FA61752;
        Thu, 27 Oct 2022 12:20:34 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id fy4so7490398ejc.5;
        Thu, 27 Oct 2022 12:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjDda3Lusp/oeaEDqD4vTznnGneLFmIyRWb+1tSU3S0=;
        b=TM+ybklDQvKacnw4jxjk+JrGqUjq68rPK56yGOE/x7mpjeO8OgUiNm1ShuZc1CFayq
         XUqb44iDsCqMmRs9yTPaefezGiyhTkxFiTMWERhqIiTH6B8WGplndMa+SCQvq1pbzSt0
         kScXPe1tfiuA+enAKNrHz2Yc6pzVpliyTrPS/xpr9/UxREgM1Hn9O91CE0v0WYzZJvB2
         vWcloMDGT/9PRuz+0SytwfWHVIRLFCXBEKJw9rKijD2ypoplkaZbsgE1OkAAdmQOm6EP
         tYlYpAOLA0HK4a+SdvJl4Q3dRdV+64Sgir0S8Bs9y1CqTfuCrmIrA24eBJlX7l/p7u61
         Yv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjDda3Lusp/oeaEDqD4vTznnGneLFmIyRWb+1tSU3S0=;
        b=adxJ6z1QSq45Ml+pnT6Zvd2GUZpsfYd7tfXmITeBmk9KfPFebcWsUs+ABwOmc7kZ/X
         VZ25mjVMp4V+1f4Yh5dgGx66KTIM/fggGivLP+qPahQoQfRAvbtTPZRuf+VuujXC1n5w
         zDKhHkZ1P419CM+RJn+2op1PyhlFmxZTvXiXCpYfzPiovJCUO3a+GCyf9v0sBXZD8h6B
         hLj57fJE6CrXPXeq3Ww45a+zyEbmb+OBweUGDoGnXbKqX3rR9YxbGAcU7WAASqgnE+YO
         LPQw0IjonnAd71ZCK16QORUPg+VxQ+vT4cA0NJiqXxi2lsQ1IHien3BHxiGjr2YOvXwt
         XWog==
X-Gm-Message-State: ACrzQf3AsrR//AYedG1PgPZ177CgDzwZoRNqSF4i38od8CkWarbZzGa6
        83tNfy391J4wafKXc+HS5SQ=
X-Google-Smtp-Source: AMsMyM58IPDGR1FEjDiX+/eXGN8nqgADvMkqUZZGXNjNnAr5x5wxmxfWiKNf6+H6BXZpBj7Y9V82aA==
X-Received: by 2002:a17:907:2723:b0:7ad:4a55:512a with SMTP id d3-20020a170907272300b007ad4a55512amr10373701ejl.608.1666898433081;
        Thu, 27 Oct 2022 12:20:33 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-238-32-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.32.238])
        by smtp.gmail.com with ESMTPSA id w18-20020a1709067c9200b007acc5a42e77sm1187006ejo.88.2022.10.27.12.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 12:20:32 -0700 (PDT)
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
Subject: [PATCH v6 1/3] dt-bindings: ingenic: Add support for the JZ4755 CGU
Date:   Thu, 27 Oct 2022 22:20:21 +0300
Message-Id: <20221027192024.484320-2-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221027192024.484320-1-lis8215@gmail.com>
References: <20221027192024.484320-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the clock generation unit (CGU)
of the JZ4755 SoC.

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

