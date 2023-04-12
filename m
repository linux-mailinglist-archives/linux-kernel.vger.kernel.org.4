Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CC36DF2A4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjDLLJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjDLLJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:09:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946D81BD;
        Wed, 12 Apr 2023 04:09:34 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v27so1261560wra.13;
        Wed, 12 Apr 2023 04:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681297773; x=1683889773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOfHS7Qab7COf5GtysXp/s/EeUshZZGs99cMnoHWLN8=;
        b=KXkT36kIhH4+z8eGdY1Vra7SGQyCjqqO7jEbK/xNa8WLTRmZxCxMGGiGyMQ6gpA97u
         efp5NuCBLFuiXo+jIebfDuwK63r3dAAC4uMXqh+SWA0HAbJHnNw4aq153+CJQ4kKYlmM
         kBDD/zPnQOrNJIwgtYq8QXM6UhJmYDfyeFlF9HUjyhGzfik5nIrg+qDYXt5y3CRljPzV
         8OwCk2AahtWm6gDqqoujS0q9WJ3SuyzZW7noF+gPzsi3GYaz6WANuq/6aBM4CoITESkD
         GXy7Wmf+QkYZWxe5xEqv+ipQKVRSDMd7IR7QPzK6HLX8s9Jr9dT0Bt52El8DNtVLtOow
         DWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681297773; x=1683889773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOfHS7Qab7COf5GtysXp/s/EeUshZZGs99cMnoHWLN8=;
        b=Nyj8+m/AD8UN50cu/cveEXKpQCnQzx1j7jK4S23EeXsBuhPf299lgYXyrM/hfJ/OA7
         3lzHlfNBmpFLlY++2UKku8NF9jxqjMxETYdMq4Banbq6LLCGTLR0RylvqzxaPaZc6PtZ
         D2xl7SUXXsqYOhHpcSaiG0K3zjXPVdoCFgmdXNk/U6zSTVdBhzPm+87HA8yIbQnwUSgT
         sAkMK4wHsAtf7gssO5m00iLTctSOTAc2JS4/aFYo9QdaSuUaNL18828AGEV/RwglEzSf
         PE4vrcN/q7cDjs3X6kKBpXmtP++q07tlw8bhZjKdi3/m0kP9hfG9H17s0RWjXTsewS1C
         os3Q==
X-Gm-Message-State: AAQBX9dRzet/FmSJ4R5eULvOIsyfolCttfg8sBzaohf77XOp5GNvN5u3
        k++aNaK4dUMnJi6JMwRtyxU=
X-Google-Smtp-Source: AKy350YtiZRV0yRO7dsna9ACipGa4QgFSL7APwLjXNb9K94TAKrkV3vUnAuEzMQUiL3+mG1FFgSc/Q==
X-Received: by 2002:a5d:62d2:0:b0:2e2:730a:c7e0 with SMTP id o18-20020a5d62d2000000b002e2730ac7e0mr1857235wrv.3.1681297772582;
        Wed, 12 Apr 2023 04:09:32 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:783d:9280:20c4:db22])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d668d000000b002e61e002943sm16863582wru.116.2023.04.12.04.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 04:09:32 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v8 7/7] soc: renesas: Kconfig: Select the required configs for RZ/Five SoC
Date:   Wed, 12 Apr 2023 12:09:00 +0100
Message-Id: <20230412110900.69738-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230412110900.69738-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230412110900.69738-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Explicitly select the required Cache management and Errata configs
required for the RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v7->v8
* Included RB tag from Geert

v6->v7
* Included RB tag from Conor

v5->v6
* New patch
---
 drivers/soc/renesas/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index de31589ed054..67604f24973e 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -334,6 +334,10 @@ if RISCV
 config ARCH_R9A07G043
 	bool "RISC-V Platform support for RZ/Five"
 	select ARCH_RZG2L
+	select AX45MP_L2_CACHE
+	select DMA_GLOBAL_POOL
+	select ERRATA_ANDES
+	select ERRATA_ANDES_CMO
 	help
 	  This enables support for the Renesas RZ/Five SoC.
 
-- 
2.25.1

