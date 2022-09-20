Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80145BED17
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiITSub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiITSuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:50:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93862606A6;
        Tue, 20 Sep 2022 11:50:13 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e16so5945808wrx.7;
        Tue, 20 Sep 2022 11:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=PvYfwd2nPuMUYkxu6YqzbYYwaZvTVZWZRcfAOAojG1g=;
        b=XvqfCxUWw7Ob93m1pCW+Yo3ZDVF8JTbPLKM+69O0aP8qjXz8rQoXy9zm9mAboPkuDs
         wFptWyweOJhrxbhrsloM2xwYI2b8pGPhzbIxJKL9X0rvGNf3z/VJ5eD7WQyzGxSran5c
         fQlS67sZZUYeAtrT5VYuopmyaAASMcZ7EPQPoNv0ugP8hxMAE7OCuM3Dlkq1ocROp3VL
         d2Dn8OGyXQTMi2gbGPBg5lgtDlwyDqdO05ohE9Hv1gdkt7khCjd+3Xwiv2Enr6C8lf9r
         mR3vfwHlK6h837Oe8tchU7jJLWdFYrhsK2G8MW+yQbzVuS20p/1LltM5U+1vwCo/VQI/
         rRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PvYfwd2nPuMUYkxu6YqzbYYwaZvTVZWZRcfAOAojG1g=;
        b=uN95kl+qSXbSgVwsEWj5ziBLxejndbGWCqOeXYC+WEZ/WbvuG9ph4cJMoHkVdKn3oc
         5/WTkkI72i5MBeTQ6ozSMxXaoTtgcYtPGykVAeAr1Przl0d6s25XuF8oE1dPXOVxXXol
         FIdwdWl1+QWuMEFWUCL/6spNGaJe/6DC/EcWge6yePk7wLvgQ4anKWOsneK8Y9HAd4gd
         QKF3aAjEHnGxrnirE/UG+9XwRwAn4mC62QklOJYUEGjaT4grxIdXIWe6G6j1ylDEnVYO
         QghUnPDiIL4dZXCzzXQCkWGbM8S9pz8XE19RgOFKhppoT0HidbOVD9Q0zY3eiLyrBMiP
         AtpA==
X-Gm-Message-State: ACrzQf0ypy2nChYlVHGagVu05aLZYxAD1ctGtqABbtxy0HCIOi7wPPjh
        Zpg/AkLYoixCfgl0G+4jRLw=
X-Google-Smtp-Source: AMsMyM76OQSXwK5sY+9A35aBFOAgfcDsYqF2PChfuGlLLSZuTZZv7QbLJ2jvApEs1oRsa52efQYETQ==
X-Received: by 2002:a5d:598f:0:b0:22a:f77e:869a with SMTP id n15-20020a5d598f000000b0022af77e869amr9719128wri.357.1663699811661;
        Tue, 20 Sep 2022 11:50:11 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:e9a4:d6c9:505d:20d0])
        by smtp.gmail.com with ESMTPSA id cc4-20020a5d5c04000000b00228de351fc0sm582722wrb.38.2022.09.20.11.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 11:50:11 -0700 (PDT)
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
Subject: [PATCH v4 03/10] dt-bindings: riscv: Add Andes AX45MP core to the list
Date:   Tue, 20 Sep 2022 19:48:57 +0100
Message-Id: <20220920184904.90495-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

The Renesas RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
Single) from Andes. In preparation to add support for RZ/Five SoC add
the Andes AX45MP core to the list.

More details about Andes AX45MP core can be found here:
[0] http://www.andestech.com/en/products-solutions/andescore-processors/riscv-ax45mp/

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3 -> v4
* No change

v2 -> v3
* Included RB tag from Geert

v1 -> v2
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

