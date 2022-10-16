Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60DC600051
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJPPD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJPPDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:03:16 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128F0419A9;
        Sun, 16 Oct 2022 08:03:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r17so19857541eja.7;
        Sun, 16 Oct 2022 08:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uB/YFZqZEaKiFGlCwO3LrxhNU5OpxJ4tB5tamj6ARsY=;
        b=XlKCTvyx4mNCaRV0wCHPRlfvy0I+BXCYT7azBCeF1sjnw72XKi6j32c/FaKi5J5q0D
         5tPuneU5aI7Yhh1safVmV8+1rJnpK1bp9LMeOJUUJqmFQ7PkAm85ZiJu/Onr1+KrFaqu
         XJX0OBVFjcaZKkLDZSNHJOgvCgxTIz0iY7DMYxL1Pkp7QsnDqAoQNcDN8bSg996ji69K
         8UvQFVeTsJ737UybdDWWdEIdssl9QONCYD7IHboHds4msZsRl6xI5L9eBuo9EBadHzWR
         uXuRDS+v5FpUXhnMwkd6jtHSPUZlL/i88kceSeVkKfF+Znl1gPBhlqKtPx2HKWhZPgt1
         uc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uB/YFZqZEaKiFGlCwO3LrxhNU5OpxJ4tB5tamj6ARsY=;
        b=l0XfskRyr7xBpyV+Q0xQ6KzWULvyj118xumXsr+Lv9dpqMymTLZGxdamUz2GOkzc/G
         QQfaD5Ge88ccN/dHnES/ITCVW1bJpSYplekuU9npKbfuNgAcpm9Z3rICylSmn9J+dmFv
         w7JWXr6M2IJHfJkP3cNf/iINZ8JvYzExrewtIO+KL5iv/cUuKcWqoN8h/yu65+m/e0im
         BKPiOPm6anumtYu6MHiqAhYUv3Gl3vPhEF7Yt62+chApPQtfjgamBPTNoVivHYU3DNzZ
         25u52O0RN09GscGh8LFJNOK0Bom4Ha0GVBeGkP32iBO8l3xSHRp8wTASaF1x923yNdYu
         ajjg==
X-Gm-Message-State: ACrzQf31rzJCvuh6N2AZl+YHmzH7C6Dt/kOU4mvj7hFWPdaTxgJ5y6Cn
        HqjETaQTae15FHSbi1IfmAY=
X-Google-Smtp-Source: AMsMyM4R+IqmSByLB30ywIJPoa+9dZ2Txso0yYn1CA19X9qnOcMICH79ap/yXmbggu36r9q6XvwDNA==
X-Received: by 2002:a17:907:3da5:b0:78e:793:4084 with SMTP id he37-20020a1709073da500b0078e07934084mr5563503ejc.285.1665932591555;
        Sun, 16 Oct 2022 08:03:11 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-39-7-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.7.39])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090657c800b0078c1e174e11sm4645699ejr.136.2022.10.16.08.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 08:03:11 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: ingenic: Add support for the JZ4755 CGU
Date:   Sun, 16 Oct 2022 18:01:07 +0300
Message-Id: <20221016150110.3020451-3-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221016150110.3020451-1-lis8215@gmail.com>
References: <20221016150110.3020451-1-lis8215@gmail.com>
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

