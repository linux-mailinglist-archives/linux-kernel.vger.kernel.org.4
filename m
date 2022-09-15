Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2314E5BA0B1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiIOSRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiIOSRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:17:48 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13638051F;
        Thu, 15 Sep 2022 11:17:30 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z12so13795038wrp.9;
        Thu, 15 Sep 2022 11:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=VByNharHGLanOsbOdnpEOJCaC2XQblJhvKILKud7IVA=;
        b=CNodDYGGDRF3F57AByDk6llGUtw61Azz9Xq6nwQaUhcHiZ2tazzJDQ7qUf/62wrxMQ
         cjMEKadtZLluRnMFQ2beQJ0rw7DLn30gjdXrZaZlsrLS2439dcwXpu8yOFb1czRz3ZbQ
         Ea+kbhjzm+Lo4TO3W2VoaJ4VdISG3aO/b2n/MZSjDxnh7Ng+Ox/lPvFpoQAZKyt9In8z
         VAZRZhuPsHDxcThdULcmiMNVpBeukbHO7hPaVJckfAsWDklyGKwKmnrU4isWfvHRv0VO
         VQtnc/X1KlZ2RL2Z6ecXc6qKLL+aMiui+kh1rvNUgKSnwe6k9jYfM+Ovao0ve9LoMVeD
         xbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VByNharHGLanOsbOdnpEOJCaC2XQblJhvKILKud7IVA=;
        b=69CR8BUjt1Hh8Un4p6YrAaqUu3DzJkJ98DwS08mIAp6Q05cjFOGZ6RzKmOHTZtLShq
         ALBKA5AP9eGruDvLG2EYsdZ8mDkaN6Lz5aWgYIOvkFztWw+q1GuBLtYHwiiHXYM454LH
         62bQG8GKY0uitnnsMSTHAHxjakZZAVeY7eHX7QPeyqDLsaBQ5aDyFeQtctNm3FTjUaAN
         tdXrrJupjEIAzckNtNkjU3C8cCOmwQ2ammbPvdQB8XxzpQtkyXhV7IJA19LTetfPw2UH
         mT4DI0ck37g5ROEC/1AIo+dHrrcP5bTtbB79fLnVur6pyObQ/xlAtO28xIRggWyVNTg3
         4U1g==
X-Gm-Message-State: ACrzQf0T6iJtgV3y0Hugg6Mbok31qQdSEGVmAIOleVlhxc6wRHt9sw2J
        B4qLxovnmbHXctYvvaOHb1Q=
X-Google-Smtp-Source: AMsMyM43hky2saxYh9NecZIEnEeUAsq5+QGjHuAYvAfC9WBt5PlYgNayB8FrH5f1QV3njyHRioEy2w==
X-Received: by 2002:a5d:5150:0:b0:22a:43a8:145b with SMTP id u16-20020a5d5150000000b0022a43a8145bmr636108wrt.170.1663265849318;
        Thu, 15 Sep 2022 11:17:29 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:d411:a48b:4035:3d98])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b003b47e8a5d22sm4243151wmq.23.2022.09.15.11.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 11:17:28 -0700 (PDT)
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
Subject: [PATCH v3 03/10] dt-bindings: riscv: Add Andes AX45MP core to the list
Date:   Thu, 15 Sep 2022 19:15:51 +0100
Message-Id: <20220915181558.354737-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

The Renesas RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
Single) from Andes. In preparation to add support for RZ/Five SoC add
the Andes AX45MP core to the list.

More details about Andes AX45MP core can be found here:
[0] http://www.andestech.com/en/products-solutions/andescore-processors/riscv-ax45mp/

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2->v3
* Included RB tag from Geert

v1->v2
* Included ack from Krzysztof
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 2a1c5ae5b0aa..1681767790c5 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -27,6 +27,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - andestech,ax45mp
               - canaan,k210
               - sifive,bullet0
               - sifive,e5
-- 
2.25.1

