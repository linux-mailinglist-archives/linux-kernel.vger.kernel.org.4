Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E4A61188C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiJ1RAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiJ1Q75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:59:57 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DC6DF2B;
        Fri, 28 Oct 2022 09:59:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bk15so7375664wrb.13;
        Fri, 28 Oct 2022 09:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2faLQwm60FIW0toXle/b/I/Kg1QLaRnJK5/efYQgUQ=;
        b=mUHskhk/+kptO7vf7dtbknF4GguKne5ReUOG951HWBB8Nsxp2aqV8MDQNgsmGiR52E
         gcXnNF+2EZehSF9RLcEMz+8whS3F8lyRFeGxHcK1Fsi66C5hYFb6fvs+On0glS9FpuB6
         MxH/13MnbmUT1NfzYKE4H5FlAS/oqaFxy+GCfRCrsm0/LZkz52v7Q5C4Z5cbJi29VPx+
         0dhPe6341MzHwtAiAZjUvUdLMi3kJZYlv6qNBQTiXi2+YKHyQC75ZNHkFuePSehvxGGH
         Anrz3xn9A8NltaVPLX+QpHtfWrrgiMMR7hgHVTIbU+Rtic9Ad87EFkFN1r9o2/l0YCI5
         jJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2faLQwm60FIW0toXle/b/I/Kg1QLaRnJK5/efYQgUQ=;
        b=lX6+VHi/5jTQrGhmJVJd7HJxQzbeY/FJgFKyHWM8BRXwcinGfFXHlo6J7/0GFwRujM
         irNIazHTq9aQtnGT2rmoodH4jShdiFJgFLdmtympWYKpy/nZS9+XDY4Y3PSMfxRtMFmK
         EBg75sGzlrvsVO8Gd0Mt/HzR653ekDvt1POpayyP1LfE7inrgrRVlm9Jw8wOQR0t9jZG
         QVx65kmsCQLAYYZLqOuQBqt2+/R65gsdCZS5ifvCUFtxJcRjnLpI4YRhTiEYhkuLrLMo
         ymo0ysSYeRIgzvrcCWCcngLYfdTSGQwk8CzphcTRWlkIg/Tue/m7axHwuSDxY/hJgpNA
         40pw==
X-Gm-Message-State: ACrzQf1zvedXSsN9SCWaa7i/g7OdlFIS9Arg7Os011n9z9cc56LHSkVY
        l0cTz6gcXR0gu5w+F96jtdY=
X-Google-Smtp-Source: AMsMyM7CC1AUvx0qZrPxkaEOBsaPe9FrMvFnvaaCKY9Uma8oYLgdhitk09PvFAVPyJtPLYrNV3tu7g==
X-Received: by 2002:a5d:6da9:0:b0:22e:53bd:31c1 with SMTP id u9-20020a5d6da9000000b0022e53bd31c1mr211356wrs.358.1666976372812;
        Fri, 28 Oct 2022 09:59:32 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:d53b:eaf9:15f:6a8a])
        by smtp.gmail.com with ESMTPSA id h2-20020adfe982000000b002322bff5b3bsm4939689wrm.54.2022.10.28.09.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 09:59:32 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 2/7] dt-bindings: riscv: Add Andes AX45MP core to the list
Date:   Fri, 28 Oct 2022 17:59:16 +0100
Message-Id: <20221028165921.94487-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
v4 -> v5
* Included RB tag from Conor

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
index ae7963e99225..2bf91829c8de 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -28,6 +28,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - andestech,ax45mp
               - canaan,k210
               - sifive,bullet0
               - sifive,e5
-- 
2.25.1

