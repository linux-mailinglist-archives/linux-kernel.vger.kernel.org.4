Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8F76D1032
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjC3UnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjC3Um6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:42:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFDA113DB;
        Thu, 30 Mar 2023 13:42:47 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r29so20327296wra.13;
        Thu, 30 Mar 2023 13:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680208967; x=1682800967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVLJ+jvYtKAHw9uWehWmKzg7iwxnJbw0QCzpAvbBm74=;
        b=W7fVzssA8QDCapvKTkoy/XagVfFnxYrLEzjjz8EEr9aqhofp2hVnw8T+E3Jr+nEdNa
         97dIWkEbf3FORLwLZE/5HArDgiFztVrOgFjz5hxh1jmA6tjNbhheZt3RWJcyaDjN9d5C
         LGWKU1Ceue5VI2if/h8CyKWHHUO2bN6I3O50fpCnM+VtfM8ZFsQPPztuALBtlfENa6ft
         YtwUfM/3ASZcD5pylRfLVPvV/BOl1WCNFBmTdMwJqPu5XQp12OIeZD8Oce9m1qZDFFDa
         RC5c3OwCzvRrbwjIshLD20LU0IonkECsfK766VhHOvAG9yQIskRzqu0j8ZWStESC3bUl
         hRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680208967; x=1682800967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVLJ+jvYtKAHw9uWehWmKzg7iwxnJbw0QCzpAvbBm74=;
        b=z4CGPZB2HaWm0/8ajzm40PwBjFLHQt1HCpE1hTUCKR+MfzHMgpJz5mbhBEfsRzb0Y+
         Zx+QgNBaTN7msY2suMGtWEiZ6Gt8WYq9dMyBSWU0RSeyg89+PLpq6ihOXY9qrFQC+WRE
         5y1/DpvBFWW04P5TpMbTLNIqKf5lfShKnK9AxjUEc2fp0qSvzEB3+H5n5i2bkqSeJqPs
         y0PHKm/4+Q3q3dcVykoz9qoygfIXWG9fhHSnxjDaHlcgKSCW+/xGlfHnPoOuFFVz5W8j
         oz8x8g3fXt4HYLNMMf97JFgNnEEdRoxV/wP25JqzEHh/Je+Ynq93re0PKtSuKTF6+bhA
         a2jw==
X-Gm-Message-State: AAQBX9cvIeGrCcWFREBCeo3HXzcnMD4UDN40QqbtnjmlRT6DihjnoVZ1
        nRTBEQpUSv6wr72whIhU1uE=
X-Google-Smtp-Source: AKy350aAvzzQW67L9QzCg0QWZlDe/xWID6JRpmXb9cTLENUc1XfQLzXnwUJG9YMad8I19gvPKRQjlQ==
X-Received: by 2002:adf:fac5:0:b0:2cf:f2f9:df7a with SMTP id a5-20020adffac5000000b002cff2f9df7amr18208641wrs.38.1680208967130;
        Thu, 30 Mar 2023 13:42:47 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:30f2:5b7:ab32:c3f])
        by smtp.gmail.com with ESMTPSA id v12-20020a5d4b0c000000b002cfed482e9asm297981wrq.61.2023.03.30.13.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 13:42:46 -0700 (PDT)
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
Subject: [PATCH v7 6/6] soc: renesas: Kconfig: Select the required configs for RZ/Five SoC
Date:   Thu, 30 Mar 2023 21:42:17 +0100
Message-Id: <20230330204217.47666-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
---
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

