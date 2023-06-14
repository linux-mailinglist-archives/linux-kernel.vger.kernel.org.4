Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9357072FB9E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243574AbjFNKs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243437AbjFNKsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:48:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF6C1732;
        Wed, 14 Jun 2023 03:48:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f63ab1ac4aso8235754e87.0;
        Wed, 14 Jun 2023 03:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686739692; x=1689331692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKG1x2TJZ8TijUzKSzDRuHBHShSw/jhXVj5kCAhPbSc=;
        b=EnC83bQMIav9RSbuOTpryxDbTLpqndkyoZ4pJ8p72ijhFLkgPUQg/Re0cm3f1047ex
         ZkrOPFgTe2BuEqKYqNw0r0/+9h4Eif34hp6dianM1mAnpnSHsYZtnkF2dueBK/qH31v3
         FF+MBP++VBA3D4haCge2to04ml7mvdMS6kzQ8RuMRLbeG1VlygbZucY0wDWa3yGqhoXC
         ZcgvOUJxZVmohztxfl6sIgslmne3EGvjPp4uSLycs3IRnsWE5FsAHLODgBqDctqLFH18
         I4uDrKXkKgleWCmLfrku+sy3mQcsr3n1gwUUJ0qcdEctbtqMVTHHOoKsqisrvuTMWddx
         H1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686739692; x=1689331692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKG1x2TJZ8TijUzKSzDRuHBHShSw/jhXVj5kCAhPbSc=;
        b=MtL+mQQ2f0hzS5l5E30xDRYPA9Lire/8/t4g+du6mBJRd75/KqRkaE1umLRRrvvRcO
         uwfHcMEO7mRawCAT7ZvEYx9sxf0uyzohMkOEQywHvBMLZ3EzkanidSvtEZ7Cxy2kakjO
         uutpEA2uKbWYtfuBk/Ij0VCMLNFusSgYBTLqX0XJ8IN1y8xh3LR8hJ77pPEVLyZ9535L
         GQZ+fGbioXkX/ezKKp9axT69nxIEl4KsiFdUFoL0OziddL/2lIcjJZ4CbEU2jujLSqfX
         Wzu3mnJnyJFqRwPF1Uubj2Z/lG0uvcmDb1Bz+J8b18FjaO6k2sceAl4zy4NJWL4P+hzc
         hmWA==
X-Gm-Message-State: AC+VfDxk7GuQzq9O4ypEJO7zzYM9xSn9BIleB1u51S9WKKoARDLsASqw
        F2LWB13EEfEfNuIJxjIH7Dc=
X-Google-Smtp-Source: ACHHUZ50LsHwcrLV5KEYmFgnKen9/kwa7RpV1eepSXfCswQaFW1zBZZ4UWcwr8mV8l0rnra4LYqRwQ==
X-Received: by 2002:a05:6512:3121:b0:4f7:684f:8e98 with SMTP id p1-20020a056512312100b004f7684f8e98mr562465lfd.67.1686739691724;
        Wed, 14 Jun 2023 03:48:11 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:64d6:8737:b80d:a298])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b003f5ffba9ae1sm17154904wma.24.2023.06.14.03.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 03:48:10 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v9 6/6] soc: renesas: Kconfig: Select the required configs for RZ/Five SoC
Date:   Wed, 14 Jun 2023 11:47:59 +0100
Message-Id: <20230614104759.228372-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230614104759.228372-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230614104759.228372-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
v8->v9
* No change

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

