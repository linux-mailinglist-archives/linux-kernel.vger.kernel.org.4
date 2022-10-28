Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211DA611897
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiJ1RAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiJ1Q76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:59:58 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02B217E0E;
        Fri, 28 Oct 2022 09:59:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso6976434wma.1;
        Fri, 28 Oct 2022 09:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/f+mcZCr/CbyA6aN8Vpia+kx8w0RlnQ3lGVCG0LnGcQ=;
        b=AYbAXYgXFNzRhCB2OIZbIOvjNlVL8Oab5vaT77FIHUDdpokqYundq5fez00SBLysS4
         HINgemKrgVy4fyU7ZIuiKdywRW8MHTd7UPXz98uzb3pbYN17qtJpKwXF/+joBsCNDhgj
         Jq+OVjeZvm3/E3TWxD8D6Oasn9T6YKu/HyoMmhnfYBRVkGn/OZ2qSfHVNXPfks8DbPJQ
         M5U736BD+OF9DCksohUfzlBG6cbbeMi1QdAFSGNtTjs1Y3d1Hd6G29dG/VxzxrMsHi4Q
         C+1uWYheneC7+3WweLuZzrjq9za6nyQu/LXoShX7m1Dtu2ElNHOboPCC4LMAOA4UTq8A
         OUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/f+mcZCr/CbyA6aN8Vpia+kx8w0RlnQ3lGVCG0LnGcQ=;
        b=wqJt/GDOMdrBR42ch7KgyRRShrvNjW3HiIJR0wAgC0DegSXUiAiqtrZRUX5ISYI8zC
         tV6t13VgdWAKwtdCmq0oDi3oTTNnFmsz19xRlGZHcQBJctaWNeHLRIvyp+aLJYz3hpx8
         cDYpjLhV+8NhU3QbnZ4tjabafwVJAZ7zFlEP6xphNcP6ntwSlr9dPJGQLZ4bHxDIcnnj
         IRr/jSLZnNXDrx3qQIai+mypOZ9bFueDcwPeGwCEVXf+1nUkhPdqONcd2AE2fwxPZWjI
         xlqRoiuh2djh/hnZUIB1y8lnTTta8ZBOGDfWRZPSBHejAl6TvjPO3Y6W4rC5Mp7+8sxO
         laXQ==
X-Gm-Message-State: ACrzQf3euRuPaEekBr7spweAGQgu7Lbb6j+2eMt9jSvdTCubyFQQa8ns
        PkNKZ4jfmRvOnu53UAigP40=
X-Google-Smtp-Source: AMsMyM52a0DnQ+hKf8g3nm3FMmaqMhba1fBR5bCgeOIbr3zcKBqCXjJBeDc/XRn+1r6KrxE4JFA4EA==
X-Received: by 2002:a7b:c30a:0:b0:3c1:bf95:e17b with SMTP id k10-20020a7bc30a000000b003c1bf95e17bmr125243wmj.31.1666976378165;
        Fri, 28 Oct 2022 09:59:38 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:d53b:eaf9:15f:6a8a])
        by smtp.gmail.com with ESMTPSA id h2-20020adfe982000000b002322bff5b3bsm4939689wrm.54.2022.10.28.09.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 09:59:37 -0700 (PDT)
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
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 6/7] MAINTAINERS: Add entry for Renesas RISC-V
Date:   Fri, 28 Oct 2022 17:59:20 +0100
Message-Id: <20221028165921.94487-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Add RISC-V architecture as part of ARM/Renesas architecture, as they have
the same maintainers, use the same development collaboration
infrastructure, and share many files.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
v4 -> v5
* Rebased on -next
* Included RB tag from Conor 

v3 -> v4
* Included RB tag from Geert 

v2 -> v3
* Merged as part of ARM

v1 -> v2
* New patch
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6cdc2a74c7a2..0204f106d8c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2691,7 +2691,7 @@ F:	arch/arm/boot/dts/rtd*
 F:	arch/arm/mach-realtek/
 F:	arch/arm64/boot/dts/realtek/
 
-ARM/RENESAS ARCHITECTURE
+ARM/RISC-V/RENESAS ARCHITECTURE
 M:	Geert Uytterhoeven <geert+renesas@glider.be>
 M:	Magnus Damm <magnus.damm@gmail.com>
 L:	linux-renesas-soc@vger.kernel.org
@@ -2713,6 +2713,7 @@ F:	arch/arm/include/debug/renesas-scif.S
 F:	arch/arm/mach-shmobile/
 F:	arch/arm64/boot/dts/renesas/
 F:	arch/arm64/configs/renesas_defconfig
+F:	arch/riscv/boot/dts/renesas/
 F:	drivers/soc/renesas/
 F:	include/linux/soc/renesas/
 
-- 
2.25.1

