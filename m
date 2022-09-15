Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8015BA0B5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiIOSSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIOSRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:17:48 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED533883C4;
        Thu, 15 Sep 2022 11:17:31 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e16so32109534wrx.7;
        Thu, 15 Sep 2022 11:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=DlfLNEnJzkppJftCUUhFQByphbHbOmAnWdcgiohRW60=;
        b=hM0I9QdqQtIUxR1qSRvsjFP2FzHyMjgIs+Ic+QKjwiZg/1fs8IwOb3pjMsL/OqwJ8l
         Inqnkukb8OvL2yqEynuvwieYpmgh8DDxvEUcCbqNSyf3Xd10mw2vlq4tMAIp1R3ovKfj
         TunWBD953JGKSahmnTCq2I2QCocacbvER871aKS4Twb44HwhdvDmI6LpCU/+OsrzE/7i
         qG5MUo6qBQj5zl+8/pSDwwnqIdnJkRZ/b+/EG6sOhPn55aD7WNY70g7t6rJ+epxdW7HJ
         LNqv8iOfzmfV6jIJZcJtXrSrnmsrt3t/oE1Sj8cjGHVmcZOlaDX5+ZZ66iK2oyBwDa/H
         RF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DlfLNEnJzkppJftCUUhFQByphbHbOmAnWdcgiohRW60=;
        b=gzEjkBMWsU7+V0a+oPGo4NpZUAA7dG4f8F7PCntrRBDWtCEnqjNsSub1mMagzX0zQO
         JvgaNNm+eoCHlqFxj9eVjOyrw1volQrrL5EGsfjNHUvu9FHrSRYptJUcB2KuFtj4gpb0
         e0vStVhbzIc8/GP736jbb8cOZyQ+5dndGkNZOkH+V+PsOMLUKL/JtRWzPnRTlqsy0MXc
         amj+bFM4WzG4VJChq5QRt0bE58/nMn9gvgqk/yVQEO3RLfHnANixa3Y+saFgn/5kORSp
         gp0DoHh9TWHYcExuGS2WwvbsrsabHtJg3zuIgC1JiAsLligoqWtyBM6VmQluARJIhcyU
         3SIw==
X-Gm-Message-State: ACrzQf1WIeSXxvWEe9ytOiw2Pd9LJSPCQ4DGvbWASLl5T1qrRoy2kAhW
        oSTfWgs8kUp0ls7R9efJrmY=
X-Google-Smtp-Source: AMsMyM72fYaxbw/fQj9d07nNHvdmzMbmevob6z4j1zFc2p/Qm9ONBBcoYLu19erjaE+mJ0Qsua3FWg==
X-Received: by 2002:a05:6000:2ad:b0:228:cf8f:fe85 with SMTP id l13-20020a05600002ad00b00228cf8ffe85mr649664wry.94.1663265851515;
        Thu, 15 Sep 2022 11:17:31 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:d411:a48b:4035:3d98])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b003b47e8a5d22sm4243151wmq.23.2022.09.15.11.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 11:17:30 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 04/10] dt-bindings: soc: renesas: renesas.yaml: Document Renesas RZ/Five SoC
Date:   Thu, 15 Sep 2022 19:15:52 +0100
Message-Id: <20220915181558.354737-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Document Renesas RZ/Five (R9A07G043) SoC.

More info about RZ/Five SoC:
https://www.renesas.com/us/en/products/microcontrollers-microprocessors/rz-mpus/rzfive-risc-v-general-purpose-microprocessors-risc-v-cpu-core-andes-ax45mp-single-10-ghz-2ch-gigabit-ethernet

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2->v3
* Dropped "(RISC-V core)" comment
* Included ACK and RB tags

v1->v2
* New patch
---
 Documentation/devicetree/bindings/soc/renesas/renesas.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
index f51464a08aff..34050e7be637 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -431,11 +431,12 @@ properties:
               - renesas,rzn1d400-db # RZN1D-DB (RZ/N1D Demo Board for the RZ/N1D 400 pins package)
           - const: renesas,r9a06g032
 
-      - description: RZ/G2UL (R9A07G043)
+      - description: RZ/Five and RZ/G2UL (R9A07G043)
         items:
           - enum:
               - renesas,smarc-evk # SMARC EVK
           - enum:
+              - renesas,r9a07g043f01 # RZ/Five
               - renesas,r9a07g043u11 # RZ/G2UL Type-1
               - renesas,r9a07g043u12 # RZ/G2UL Type-2
           - const: renesas,r9a07g043
-- 
2.25.1

