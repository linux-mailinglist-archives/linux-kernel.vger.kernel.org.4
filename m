Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C519611894
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiJ1RAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiJ1Q75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:59:57 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71092E0A6;
        Fri, 28 Oct 2022 09:59:32 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g12so7394590wrs.10;
        Fri, 28 Oct 2022 09:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ku5lF3CTU+uK+oU1JYQf2lS5QXHn/wjM4We6ht5jRA=;
        b=HWshL2JJrihm1Gcnitlj9oBwqZbG7dBrNPu2swm/BttlGesn2PbwoludpIRmUqu/c2
         u+0/lEsEtreics+jk1lNEkNPjhSw5mGVmG2QSDOHoxlSEz0ifhRdpu4uWhF+MEkjtmq/
         04vDzTVzawaOTdfjoJuDrVR2oY9jHtBU3HBPCDwVkjFC3f8Dxqhpj0AVZSQU5GfS4j5R
         FPi6r3ZTA9vXDzWqsawkQMZ7ubdJBKiAP11uCgLSxDvzd4O99NaZaFOPers0C0iGlf8U
         m0ETAFo43FIj0Cp/iqz/bCurJahrqxEnLcpf7SlMoVldil5UWxZPIp1Cv89lOrUMzzPF
         HBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ku5lF3CTU+uK+oU1JYQf2lS5QXHn/wjM4We6ht5jRA=;
        b=pOtnPTlLkvFr7jhG5pChVdJtW4PmxOyJY7L4vQL8loI6SKo03hbtJJjSZq2LzDtGpL
         0R4odJnB2/i55yvmpujwnqxsLt8jaHg+CiSjFshE/aU6X8ad5Igt2V3m/9AfpSDos0rM
         MwIORcNmbun6xSbEgPJPwH4w6sGSfzEG0BxIUyaiitY3fjNrhG7FQhrFikpIFKnfRlby
         6zz6H9kX9tQGjWMlqQWuhH3KGCjV+ZNITNckFg7egRPC87q4cptiJt01YIT/wjoW1m+o
         aatHpXf/MqbqjJyOFRa8DpPudjawnMoawh1fzuxhbCBKUZG0ce/THpa0ncVyElY2HuA5
         BnSw==
X-Gm-Message-State: ACrzQf1qfzPJ9E0ishFcUoZDPeFMYSNcP61fROXMAtPAIvOJ3+Jv65Ks
        ugrBF49Fi+upqcNQDfYuDGk=
X-Google-Smtp-Source: AMsMyM7YfKk37OhTqU4Uwb40+Crqw2aD9y6NIgO4b4+pbNGOImXNB90OVt2tI03m3Zvh2mLQC+OLRw==
X-Received: by 2002:adf:aa8d:0:b0:236:588f:71f with SMTP id h13-20020adfaa8d000000b00236588f071fmr170388wrc.205.1666976371539;
        Fri, 28 Oct 2022 09:59:31 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:d53b:eaf9:15f:6a8a])
        by smtp.gmail.com with ESMTPSA id h2-20020adfe982000000b002322bff5b3bsm4939689wrm.54.2022.10.28.09.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 09:59:30 -0700 (PDT)
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
Subject: [PATCH v5 1/7] dt-bindings: riscv: Sort the CPU core list alphabetically
Date:   Fri, 28 Oct 2022 17:59:15 +0100
Message-Id: <20221028165921.94487-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Sort the CPU cores list alphabetically for maintenance.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
v4 -> v5
* Included RB tag from Conor

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
index 90a7cabf58fe..ae7963e99225 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -28,17 +28,17 @@ properties:
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

