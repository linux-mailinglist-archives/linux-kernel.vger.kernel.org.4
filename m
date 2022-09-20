Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399FD5BED12
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiITSu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiITSuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:50:13 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204D65FF48;
        Tue, 20 Sep 2022 11:50:12 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso7537420wma.1;
        Tue, 20 Sep 2022 11:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=i0mZzaQm6+l7tL7CHpRvjbgnVX+wPMwIm1qv0xCs4s8=;
        b=OEBmL0IbJg2zcJRYGPljfxLtxYeL6YJrqrfndtFclS9FAIyhmaJZ3zl8/WfjaHw8+z
         L/Kor5vnC1+IiEtHNY5L5EgQEIw4JLedb9pfqwvbBIXFemYh1qmCl9xE2rIdOw6wWkOr
         qP+ZkR+s/GM4xSSoIVS+WKm055sWd0EKPa/UsajIpCR2ZxzfQvE4Rl+aQDAVBUe4KaR3
         RicMais/DYLBk/nGCQzYIalPt+PjtSSje0B+JlRlQSMcV6L8EwB4cITUTDYrycdm2he/
         d9HdFj++ZOVP2rLb8xukP7Ao1aXtVI+Ys2LhId86b9dFcSjx+WLjWX3bup+OmtNgYltn
         0WAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=i0mZzaQm6+l7tL7CHpRvjbgnVX+wPMwIm1qv0xCs4s8=;
        b=MxWFjp9wyAguoGUIWwbfp7EdEuBuCbtFHhHaTP0bYiUmGKIjnm1iDYWDLdQQJC7kgE
         4E9VQv/4Da+F9LuZFYrOipokZwUydvn653dyTyZWk6ssnWXohZKGTAyFLkgpefZvrTq0
         2rFYQpdpwkfovemYmgwTOADaqMcgYIE+kTubzDijOf5oxLnhRB5FvCxGDN5K8hf4DqYx
         Q3LXCRmu11W6koiD/LppxXEW2QQPrPogKm5a7flhLctC3QPFdWg4uOA7fkgOR/wJA5KE
         rsJsGrjN8FJrojvT4YGMNOKF1Kl9zkieEwG2vFY2VJJM/9ASBl6onjIBDpDEYIV2nwSl
         ABTw==
X-Gm-Message-State: ACrzQf2us2SrW6uf5Tm+BtR0yLWTd8g1dtqldfx3f8cGTqW+ixYik+X+
        EaN+/q36/6+/da+/d/HHmBg=
X-Google-Smtp-Source: AMsMyM52d4NzTqDtmW2Bvy/qewCqt1i/HUIQSyOLLldvhyGClnlQSHpWhiIESwW5LglFU3AM1rPD7A==
X-Received: by 2002:a05:600c:5028:b0:3a8:4349:153c with SMTP id n40-20020a05600c502800b003a84349153cmr3433382wmr.130.1663699810715;
        Tue, 20 Sep 2022 11:50:10 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:e9a4:d6c9:505d:20d0])
        by smtp.gmail.com with ESMTPSA id cc4-20020a5d5c04000000b00228de351fc0sm582722wrb.38.2022.09.20.11.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 11:50:10 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@rivosinc.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 02/10] dt-bindings: riscv: Sort the CPU core list alphabetically
Date:   Tue, 20 Sep 2022 19:48:56 +0100
Message-Id: <20220920184904.90495-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sort the CPU cores list alphabetically for maintenance.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
v3 -> v4
* Included RB tag from Heiko

v2 -> v3
* Included RB tag from Geert

v1 -> v2
* Included RB tag from Krzysztof
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 873dd12f6e89..2a1c5ae5b0aa 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -27,17 +27,17 @@ properties:
     oneOf:
       - items:
           - enum:
-              - sifive,rocket0
+              - canaan,k210
               - sifive,bullet0
               - sifive,e5
               - sifive,e7
               - sifive,e71
-              - sifive,u74-mc
-              - sifive,u54
-              - sifive,u74
+              - sifive,rocket0
               - sifive,u5
+              - sifive,u54
               - sifive,u7
-              - canaan,k210
+              - sifive,u74
+              - sifive,u74-mc
           - const: riscv
       - items:
           - enum:
-- 
2.25.1

