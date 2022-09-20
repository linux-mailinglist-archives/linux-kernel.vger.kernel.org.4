Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8F05BED27
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiITSvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiITSuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:50:22 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C0B606BF;
        Tue, 20 Sep 2022 11:50:19 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso1854863wmq.4;
        Tue, 20 Sep 2022 11:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=EQLU1p9zTnbfza7bDPcd3NTO8vUBdj6VZqpG9QwD+18=;
        b=KqGa3vSo6XnGef1G1wAkb5SClNL9yfvCVdQtQAsrWjvrjhXEtvlKeS2Wx5Pl/cEo4g
         jyHMcEeIMCzJhn2d7oLJ5dyKw9QP1KriaW3agts4FTcty0sIokH2qQGwzG/8+uwXnXie
         9C2lkObVBs7SFuoqcGQKgafrr8GqKHAcBG9edfIb31IQdyG4bMqnLoE91OclsjrDEf/3
         95R/CXxpmoFxHHfxw796ffA9NTMLN7qLvzVqdkrbB6dnEyzvVOPDAXcqkc7PArungp6+
         WQ/t1WKBGhbC5ShIIt2ilu3Juz/3Ptn3rAniZ3kxS4W2uKYQQOIsr5TPl74iDo65BXHA
         DziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EQLU1p9zTnbfza7bDPcd3NTO8vUBdj6VZqpG9QwD+18=;
        b=VyvIWLmHUgGK6VgCuthVLKqqujLLcC/OHSZy2NOIDFcFc22481eHiEDaLzJ7zrKTvB
         NQ62hfYVPi9+QG9GsBsWYBjT1zXA3c8G28Ya9N/dfkwSzaw5IidA1rVsQQ1SHJK7ITig
         IhIQcE+6QivFcmoAOb/0ZBAftV3UuqpIYqQaH0vLJxb0VnGhtmzCNE04JyGGCBRfpd9e
         yGIwo1uBQ3o7FnUghSsQA7ulwhzoqvtlhoFdkQpsFfCzN2a+C94i9SGOODoAeYQBJhp7
         JcU08WQsOaPZa8aGgEmOnebESm+gcBU+6j8of6+tneLqshOBeYmxhfySIbLZO7ee9rgD
         XPEQ==
X-Gm-Message-State: ACrzQf0xyCB9CB4XNVhJBXUMdQ3Samjh+/fxpYl4qSEO28iojTPX7jyd
        oJs/u1SRGSmUZ3+VW90qHt0=
X-Google-Smtp-Source: AMsMyM6RQFozicQvq9rbieliRqHqd66tgvlgtA/miWJlG7cXqg4FA2VYKxF7IvVo5PdnBSZ+DwcNRg==
X-Received: by 2002:a7b:c34c:0:b0:3b3:4067:d473 with SMTP id l12-20020a7bc34c000000b003b34067d473mr3534185wmj.52.1663699817985;
        Tue, 20 Sep 2022 11:50:17 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:e9a4:d6c9:505d:20d0])
        by smtp.gmail.com with ESMTPSA id cc4-20020a5d5c04000000b00228de351fc0sm582722wrb.38.2022.09.20.11.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 11:50:17 -0700 (PDT)
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
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 09/10] MAINTAINERS: Add entry for Renesas RISC-V architecture
Date:   Tue, 20 Sep 2022 19:49:03 +0100
Message-Id: <20220920184904.90495-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Add RISC-V architecture as part of ARM/Renesas architecture, as they have
the same maintainers, use the same development collaboration
infrastructure, and share many files.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
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
index 48c5a152f743..fbf507cd3f41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2671,7 +2671,7 @@ F:	arch/arm/boot/dts/rtd*
 F:	arch/arm/mach-realtek/
 F:	arch/arm64/boot/dts/realtek/
 
-ARM/RENESAS ARCHITECTURE
+ARM/RISC-V/RENESAS ARCHITECTURE
 M:	Geert Uytterhoeven <geert+renesas@glider.be>
 M:	Magnus Damm <magnus.damm@gmail.com>
 L:	linux-renesas-soc@vger.kernel.org
@@ -2692,6 +2692,7 @@ F:	arch/arm/configs/shmobile_defconfig
 F:	arch/arm/include/debug/renesas-scif.S
 F:	arch/arm/mach-shmobile/
 F:	arch/arm64/boot/dts/renesas/
+F:	arch/riscv/boot/dts/renesas/
 F:	drivers/soc/renesas/
 F:	include/linux/soc/renesas/
 
-- 
2.25.1

