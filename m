Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532755BED22
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiITSuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiITSuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:50:17 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84B1606AA;
        Tue, 20 Sep 2022 11:50:14 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g3so5874926wrq.13;
        Tue, 20 Sep 2022 11:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=PIml5h9yfGZM8hFj0DM2cpSK5N9+Jc9EevGrYn1++vQ=;
        b=LR7YtcMxhe3P0sEoEbJcH+IkBqrOkuc6o8e6zFaIH3s6hCMkvbaoX0KeIil8ejenWE
         jddSYjFaJ1eXffm98pgu4B8UsyZ3805SytCXEvlU6HFY19IQ7wytoXQTYtdMNXR4Y4Uu
         UF5heYpMAZWUxTsPfNc6mi7iecR8SCO5gWsBBj9bx6hDhVa7XaVvwM+PjpYm+xPqH5gS
         pYjljuCUtbgOc9W5YnW7gRo+HwpDSbwKNODmxr3vhnfntwpf4hKvY30l7Wu7TuprisUh
         i4Kd079fwNxBqMniHL9S35KyW5pU6OA999s+81FLD1xOQhNKhq2NDzXlh2ISaDAE5aJL
         9c8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PIml5h9yfGZM8hFj0DM2cpSK5N9+Jc9EevGrYn1++vQ=;
        b=1Al1+3pVbppgplZJxcTLvoN+A87kHkMBDLTN2A4wx3isomLPZqGkWiU+TURItWWui6
         6eQJgRJg3wSNLgJGCM+kdZPvcmUlepgtWHKV/CtZ/qQAj6F3rJybSep4nRxwAIQT68PF
         YjUGvpge+tAjBelZBM1d+eiGnb2pz9uOMNMzxHjZAJpX8TJZmWTnDGoTbQpHPFV56gI9
         5sgnYflghRW9hrzmYGhakCKMlzHcu3J/qTOHHQtaW/qESZjXLimOeHLGsl9x4OQu+8HZ
         g/1rtdw/gtLS4CcOjqi/baGcXSbCrvRoLC8uVUUzYJfmBmkwTJUd4ALAazbp+BlLAt3t
         AKLw==
X-Gm-Message-State: ACrzQf2zb0XsJimLnKaQateW/WhqPn3W2kleXZNiTDo6BBASFxUeeCYo
        BHneEQWYa2cpi7+XTDgHAx4=
X-Google-Smtp-Source: AMsMyM5YuEsIkz/ZbwCy+LfECoAJ6wOTpSpMRW2lh6ErlpsbZS7wKSEoBVSfZwsTS9ij5ivNi33RTg==
X-Received: by 2002:a05:6000:1689:b0:22a:a66d:1f37 with SMTP id y9-20020a056000168900b0022aa66d1f37mr15201522wrd.197.1663699812700;
        Tue, 20 Sep 2022 11:50:12 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:e9a4:d6c9:505d:20d0])
        by smtp.gmail.com with ESMTPSA id cc4-20020a5d5c04000000b00228de351fc0sm582722wrb.38.2022.09.20.11.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 11:50:12 -0700 (PDT)
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
Subject: [PATCH v4 04/10] dt-bindings: soc: renesas: renesas.yaml: Document Renesas RZ/Five SoC
Date:   Tue, 20 Sep 2022 19:48:58 +0100
Message-Id: <20220920184904.90495-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Document Renesas RZ/Five (R9A07G043) SoC.

More info about RZ/Five SoC:
https://www.renesas.com/us/en/products/microcontrollers-microprocessors/rz-mpus/rzfive-risc-v-general-purpose-microprocessors-risc-v-cpu-core-andes-ax45mp-single-10-ghz-2ch-gigabit-ethernet

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3 -> v4
* No change

v2 -> v3
* Dropped "(RISC-V core)" comment
* Included ACK and RB tags

v1 -> v2
* New patch
---
 Documentation/devicetree/bindings/soc/renesas/renesas.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
index 07c5e6ebd5a0..2789022b52eb 100644
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

