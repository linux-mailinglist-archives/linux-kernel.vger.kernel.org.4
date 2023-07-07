Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E5974B292
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjGGOFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjGGOFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:05:07 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CD52117
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:04:55 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6afc1ceffso31020971fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688738693; x=1691330693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ah7YGD1xyf3kSBx1jvLazId0APuOLF3pVJjrHEEu/ig=;
        b=WzV8wBgJnPy4qeBnOZRqGp2YKUS3RX/TdS3SRNG+atvqyPjAyGGvE9KH+3ujUeRKQz
         PwCa+l9PVlqNJlibhqHyhaNrb654HaZ3IwpdzdjTt1DX2owekQVypyH/NgoI59UdN3wZ
         ib20TKnH8DOYjEeRegiVzy1lYvG4oOxcq1442g/d3RLuHb3SO+jQEVPlTOH7w51ZpihO
         55bxuuBvsxlPDZMK4bsW5jVYhKYJvLPjnYQxdHsdaeE7t2k+2gjg179zFaZOUqvm5TBH
         wei/1fMD0c4HJj5N+ww2Gu6z5j1tpPWMv102AmJwaxJpaCWj+yeZQXpu6SUoEMboGkW0
         zs2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738693; x=1691330693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ah7YGD1xyf3kSBx1jvLazId0APuOLF3pVJjrHEEu/ig=;
        b=ilEzYSMpSaGhiO2LlMAppPPFBhdU/TA6hEDc2rUZSsv+oP2A2DjyVRLo4xAsonIQEy
         AmX8UGJwkrTHbEk6VV+pEjzd8kRxmY1hpdB6VFeCAn3wsCGVOhVwmDYAsr1iSDvwufn4
         4lDcCAaMpkyltcoboDQK012sILQsRsCtY2cxM8HeL7tIXz07GESU9F0PypnW2T5RyUko
         E/tOUmCXKNDzWfJVmQaDhHoBVFn7vbn5sZCNsN0/DFNmo2wEvJfKHBKQcV3kPy6YpHbR
         RevD21rUZuGVYlF5kfxAPtYDnS1n6A0jvuzUCFIjzS38IlXMUVteckq/Jfqho38FoTGx
         bsZw==
X-Gm-Message-State: ABy/qLbsqCy8eJTj1tTcK4PILVjUBbEUq0xfhBKPz69muCTH/7CxY8Vt
        SUco/sR8avD4nJjUOaYqhLIW1A==
X-Google-Smtp-Source: APBJJlFlxElROl8lCVcuW04EJ7Kx+bi8Prfy3SdyYewfyxMMh9NzLlD7C69u2RhV4Y5QdP1gKzLhKw==
X-Received: by 2002:a2e:9c95:0:b0:2b6:c16a:db06 with SMTP id x21-20020a2e9c95000000b002b6c16adb06mr4104254lji.39.1688738693486;
        Fri, 07 Jul 2023 07:04:53 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e8555000000b002b6cb25e3f1sm760341ljj.108.2023.07.07.07.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 07:04:53 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 09/18] soc: renesas: Move power-domain drivers to the genpd dir
Date:   Fri,  7 Jul 2023 16:04:25 +0200
Message-Id: <20230707140434.723349-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707140434.723349-1-ulf.hansson@linaro.org>
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: <linux-renesas-soc@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                                   |  1 +
 drivers/genpd/Makefile                        |  1 +
 drivers/genpd/renesas/Makefile                | 30 +++++++++++++++++++
 drivers/{soc => genpd}/renesas/r8a7742-sysc.c |  0
 drivers/{soc => genpd}/renesas/r8a7743-sysc.c |  0
 drivers/{soc => genpd}/renesas/r8a7745-sysc.c |  0
 .../{soc => genpd}/renesas/r8a77470-sysc.c    |  0
 .../{soc => genpd}/renesas/r8a774a1-sysc.c    |  0
 .../{soc => genpd}/renesas/r8a774b1-sysc.c    |  0
 .../{soc => genpd}/renesas/r8a774c0-sysc.c    |  0
 .../{soc => genpd}/renesas/r8a774e1-sysc.c    |  0
 drivers/{soc => genpd}/renesas/r8a7779-sysc.c |  0
 drivers/{soc => genpd}/renesas/r8a7790-sysc.c |  0
 drivers/{soc => genpd}/renesas/r8a7791-sysc.c |  0
 drivers/{soc => genpd}/renesas/r8a7792-sysc.c |  0
 drivers/{soc => genpd}/renesas/r8a7794-sysc.c |  0
 drivers/{soc => genpd}/renesas/r8a7795-sysc.c |  0
 drivers/{soc => genpd}/renesas/r8a7796-sysc.c |  0
 .../{soc => genpd}/renesas/r8a77965-sysc.c    |  0
 .../{soc => genpd}/renesas/r8a77970-sysc.c    |  0
 .../{soc => genpd}/renesas/r8a77980-sysc.c    |  0
 .../{soc => genpd}/renesas/r8a77990-sysc.c    |  0
 .../{soc => genpd}/renesas/r8a77995-sysc.c    |  0
 .../{soc => genpd}/renesas/r8a779a0-sysc.c    |  0
 .../{soc => genpd}/renesas/r8a779f0-sysc.c    |  0
 .../{soc => genpd}/renesas/r8a779g0-sysc.c    |  0
 .../{soc => genpd}/renesas/rcar-gen4-sysc.c   |  0
 .../{soc => genpd}/renesas/rcar-gen4-sysc.h   |  0
 drivers/{soc => genpd}/renesas/rcar-sysc.c    |  0
 drivers/{soc => genpd}/renesas/rcar-sysc.h    |  0
 drivers/{soc => genpd}/renesas/rmobile-sysc.c |  0
 drivers/soc/renesas/Makefile                  | 27 -----------------
 32 files changed, 32 insertions(+), 27 deletions(-)
 create mode 100644 drivers/genpd/renesas/Makefile
 rename drivers/{soc => genpd}/renesas/r8a7742-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7743-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7745-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a77470-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a774a1-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a774b1-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a774c0-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a774e1-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7779-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7790-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7791-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7792-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7794-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7795-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7796-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a77965-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a77970-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a77980-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a77990-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a77995-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a779a0-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a779f0-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a779g0-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/rcar-gen4-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/rcar-gen4-sysc.h (100%)
 rename drivers/{soc => genpd}/renesas/rcar-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/rcar-sysc.h (100%)
 rename drivers/{soc => genpd}/renesas/rmobile-sysc.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 753eea641129..cb57f5fb2cd7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2591,6 +2591,7 @@ F:	arch/arm/include/debug/renesas-scif.S
 F:	arch/arm/mach-shmobile/
 F:	arch/arm64/boot/dts/renesas/
 F:	arch/riscv/boot/dts/renesas/
+F:	drivers/genpd/renesas/
 F:	drivers/soc/renesas/
 F:	include/linux/soc/renesas/
 K:	\brenesas,
diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index dfdea14e2a8a..286598ce7620 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -5,3 +5,4 @@ obj-y					+= apple/
 obj-y					+= bcm/
 obj-y					+= mediatek/
 obj-y					+= qcom/
+obj-y					+= renesas/
diff --git a/drivers/genpd/renesas/Makefile b/drivers/genpd/renesas/Makefile
new file mode 100644
index 000000000000..e306e396fc8c
--- /dev/null
+++ b/drivers/genpd/renesas/Makefile
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0
+# SoC
+obj-$(CONFIG_SYSC_R8A7742)	+= r8a7742-sysc.o
+obj-$(CONFIG_SYSC_R8A7743)	+= r8a7743-sysc.o
+obj-$(CONFIG_SYSC_R8A7745)	+= r8a7745-sysc.o
+obj-$(CONFIG_SYSC_R8A77470)	+= r8a77470-sysc.o
+obj-$(CONFIG_SYSC_R8A774A1)	+= r8a774a1-sysc.o
+obj-$(CONFIG_SYSC_R8A774B1)	+= r8a774b1-sysc.o
+obj-$(CONFIG_SYSC_R8A774C0)	+= r8a774c0-sysc.o
+obj-$(CONFIG_SYSC_R8A774E1)	+= r8a774e1-sysc.o
+obj-$(CONFIG_SYSC_R8A7779)	+= r8a7779-sysc.o
+obj-$(CONFIG_SYSC_R8A7790)	+= r8a7790-sysc.o
+obj-$(CONFIG_SYSC_R8A7791)	+= r8a7791-sysc.o
+obj-$(CONFIG_SYSC_R8A7792)	+= r8a7792-sysc.o
+obj-$(CONFIG_SYSC_R8A7794)	+= r8a7794-sysc.o
+obj-$(CONFIG_SYSC_R8A7795)	+= r8a7795-sysc.o
+obj-$(CONFIG_SYSC_R8A77960)	+= r8a7796-sysc.o
+obj-$(CONFIG_SYSC_R8A77961)	+= r8a7796-sysc.o
+obj-$(CONFIG_SYSC_R8A77965)	+= r8a77965-sysc.o
+obj-$(CONFIG_SYSC_R8A77970)	+= r8a77970-sysc.o
+obj-$(CONFIG_SYSC_R8A77980)	+= r8a77980-sysc.o
+obj-$(CONFIG_SYSC_R8A77990)	+= r8a77990-sysc.o
+obj-$(CONFIG_SYSC_R8A77995)	+= r8a77995-sysc.o
+obj-$(CONFIG_SYSC_R8A779A0)	+= r8a779a0-sysc.o
+obj-$(CONFIG_SYSC_R8A779F0)	+= r8a779f0-sysc.o
+obj-$(CONFIG_SYSC_R8A779G0)	+= r8a779g0-sysc.o
+# Family
+obj-$(CONFIG_SYSC_RCAR)		+= rcar-sysc.o
+obj-$(CONFIG_SYSC_RCAR_GEN4)	+= rcar-gen4-sysc.o
+obj-$(CONFIG_SYSC_RMOBILE)	+= rmobile-sysc.o
diff --git a/drivers/soc/renesas/r8a7742-sysc.c b/drivers/genpd/renesas/r8a7742-sysc.c
similarity index 100%
rename from drivers/soc/renesas/r8a7742-sysc.c
rename to drivers/genpd/renesas/r8a7742-sysc.c
diff --git a/drivers/soc/renesas/r8a7743-sysc.c b/drivers/genpd/renesas/r8a7743-sysc.c
similarity index 100%
rename from drivers/soc/renesas/r8a7743-sysc.c
rename to drivers/genpd/renesas/r8a7743-sysc.c
diff --git a/drivers/soc/renesas/r8a7745-sysc.c b/drivers/genpd/renesas/r8a7745-sysc.c
similarity index 100%
rename from drivers/soc/renesas/r8a7745-sysc.c
rename to drivers/genpd/renesas/r8a7745-sysc.c
diff --git a/drivers/soc/renesas/r8a77470-sysc.c b/drivers/genpd/renesas/r8a77470-sysc.c
similarity index 100%
rename from drivers/soc/renesas/r8a77470-sysc.c
rename to drivers/genpd/renesas/r8a77470-sysc.c
diff --git a/drivers/soc/renesas/r8a774a1-sysc.c b/drivers/genpd/renesas/r8a774a1-sysc.c
similarity index 100%
rename from drivers/soc/renesas/r8a774a1-sysc.c
rename to drivers/genpd/renesas/r8a774a1-sysc.c
diff --git a/drivers/soc/renesas/r8a774b1-sysc.c b/drivers/genpd/renesas/r8a774b1-sysc.c
similarity index 100%
rename from drivers/soc/renesas/r8a774b1-sysc.c
rename to drivers/genpd/renesas/r8a774b1-sysc.c
diff --git a/drivers/soc/renesas/r8a774c0-sysc.c b/drivers/genpd/renesas/r8a774c0-sysc.c
similarity index 100%
rename from drivers/soc/renesas/r8a774c0-sysc.c
rename to drivers/genpd/renesas/r8a774c0-sysc.c
diff --git a/drivers/soc/renesas/r8a774e1-sysc.c b/drivers/genpd/renesas/r8a774e1-sysc.c
similarity index 100%
rename from drivers/soc/renesas/r8a774e1-sysc.c
rename to drivers/genpd/renesas/r8a774e1-sysc.c
diff --git a/drivers/soc/renesas/r8a7779-sysc.c b/drivers/genpd/renesas/r8a7779-sysc.c
similarity index 100%
rename from drivers/soc/renesas/r8a7779-sysc.c
rename to drivers/genpd/renesas/r8a7779-sysc.c
diff --git a/drivers/soc/renesas/r8a7790-sysc.c b/drivers/genpd/renesas/r8a7790-sysc.c
similarity index 100%
rename from drivers/soc/renesas/r8a7790-sysc.c
rename to drivers/genpd/renesas/r8a7790-sysc.c
diff --git a/drivers/soc/renesas/r8a7791-sysc.c b/drivers/genpd/renesas/r8a7791-sysc.c
similarity index 100%
rename from drivers/soc/renesas/r8a7791-sysc.c
rename to drivers/genpd/renesas/r8a7791-sysc.c
diff --git a/drivers/soc/renesas/r8a7792-sysc.c b/drivers/genpd/renesas/r8a7792-sysc.c
similarity index 100%
rename from drivers/soc/renesas/r8a7792-sysc.c
rename to drivers/genpd/renesas/r8a7792-sysc.c
diff --git a/drivers/soc/renesas/r8a7794-sysc.c b/drivers/genpd/renesas/r8a7794-sysc.c
similarity index 100%
rename from drivers/soc/renesas/r8a7794-sysc.c
rename to drivers/genpd/renesas/r8a7794-sysc.c
diff --git a/drivers/soc/renesas/r8a7795-sysc.c b/drivers/genpd/renesas/r8a7795-sysc.c
similarity index 100%
rename from drivers/soc/renesas/r8a7795-sysc.c
rename to drivers/genpd/renesas/r8a7795-sysc.c
diff --git a/drivers/soc/renesas/r8a7796-sysc.c b/drivers/genpd/renesas/r8a7796-sysc.c
similarity index 100%
rename from drivers/soc/renesas/r8a7796-sysc.c
rename to drivers/genpd/renesas/r8a7796-sysc.c
diff --git a/drivers/soc/renesas/r8a77965-sysc.c b/drivers/genpd/renesas/r8a77965-sysc.c
similarity index 100%
rename from drivers/soc/renesas/r8a77965-sysc.c
rename to drivers/genpd/renesas/r8a77965-sysc.c
diff --git a/drivers/soc/renesas/r8a77970-sysc.c b/drivers/genpd/renesas/r8a77970-sysc.c
similarity index 100%
rename from drivers/soc/renesas/r8a77970-sysc.c
rename to drivers/genpd/renesas/r8a77970-sysc.c
diff --git a/drivers/soc/renesas/r8a77980-sysc.c b/drivers/genpd/renesas/r8a77980-sysc.c
similarity index 100%
rename from drivers/soc/renesas/r8a77980-sysc.c
rename to drivers/genpd/renesas/r8a77980-sysc.c
diff --git a/drivers/soc/renesas/r8a77990-sysc.c b/drivers/genpd/renesas/r8a77990-sysc.c
similarity index 100%
rename from drivers/soc/renesas/r8a77990-sysc.c
rename to drivers/genpd/renesas/r8a77990-sysc.c
diff --git a/drivers/soc/renesas/r8a77995-sysc.c b/drivers/genpd/renesas/r8a77995-sysc.c
similarity index 100%
rename from drivers/soc/renesas/r8a77995-sysc.c
rename to drivers/genpd/renesas/r8a77995-sysc.c
diff --git a/drivers/soc/renesas/r8a779a0-sysc.c b/drivers/genpd/renesas/r8a779a0-sysc.c
similarity index 100%
rename from drivers/soc/renesas/r8a779a0-sysc.c
rename to drivers/genpd/renesas/r8a779a0-sysc.c
diff --git a/drivers/soc/renesas/r8a779f0-sysc.c b/drivers/genpd/renesas/r8a779f0-sysc.c
similarity index 100%
rename from drivers/soc/renesas/r8a779f0-sysc.c
rename to drivers/genpd/renesas/r8a779f0-sysc.c
diff --git a/drivers/soc/renesas/r8a779g0-sysc.c b/drivers/genpd/renesas/r8a779g0-sysc.c
similarity index 100%
rename from drivers/soc/renesas/r8a779g0-sysc.c
rename to drivers/genpd/renesas/r8a779g0-sysc.c
diff --git a/drivers/soc/renesas/rcar-gen4-sysc.c b/drivers/genpd/renesas/rcar-gen4-sysc.c
similarity index 100%
rename from drivers/soc/renesas/rcar-gen4-sysc.c
rename to drivers/genpd/renesas/rcar-gen4-sysc.c
diff --git a/drivers/soc/renesas/rcar-gen4-sysc.h b/drivers/genpd/renesas/rcar-gen4-sysc.h
similarity index 100%
rename from drivers/soc/renesas/rcar-gen4-sysc.h
rename to drivers/genpd/renesas/rcar-gen4-sysc.h
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/genpd/renesas/rcar-sysc.c
similarity index 100%
rename from drivers/soc/renesas/rcar-sysc.c
rename to drivers/genpd/renesas/rcar-sysc.c
diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/genpd/renesas/rcar-sysc.h
similarity index 100%
rename from drivers/soc/renesas/rcar-sysc.h
rename to drivers/genpd/renesas/rcar-sysc.h
diff --git a/drivers/soc/renesas/rmobile-sysc.c b/drivers/genpd/renesas/rmobile-sysc.c
similarity index 100%
rename from drivers/soc/renesas/rmobile-sysc.c
rename to drivers/genpd/renesas/rmobile-sysc.c
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 6e4e77b0afff..734f8f8cefa4 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -3,30 +3,6 @@
 obj-$(CONFIG_SOC_RENESAS)	+= renesas-soc.o
 
 # SoC
-obj-$(CONFIG_SYSC_R8A7742)	+= r8a7742-sysc.o
-obj-$(CONFIG_SYSC_R8A7743)	+= r8a7743-sysc.o
-obj-$(CONFIG_SYSC_R8A7745)	+= r8a7745-sysc.o
-obj-$(CONFIG_SYSC_R8A77470)	+= r8a77470-sysc.o
-obj-$(CONFIG_SYSC_R8A774A1)	+= r8a774a1-sysc.o
-obj-$(CONFIG_SYSC_R8A774B1)	+= r8a774b1-sysc.o
-obj-$(CONFIG_SYSC_R8A774C0)	+= r8a774c0-sysc.o
-obj-$(CONFIG_SYSC_R8A774E1)	+= r8a774e1-sysc.o
-obj-$(CONFIG_SYSC_R8A7779)	+= r8a7779-sysc.o
-obj-$(CONFIG_SYSC_R8A7790)	+= r8a7790-sysc.o
-obj-$(CONFIG_SYSC_R8A7791)	+= r8a7791-sysc.o
-obj-$(CONFIG_SYSC_R8A7792)	+= r8a7792-sysc.o
-obj-$(CONFIG_SYSC_R8A7794)	+= r8a7794-sysc.o
-obj-$(CONFIG_SYSC_R8A7795)	+= r8a7795-sysc.o
-obj-$(CONFIG_SYSC_R8A77960)	+= r8a7796-sysc.o
-obj-$(CONFIG_SYSC_R8A77961)	+= r8a7796-sysc.o
-obj-$(CONFIG_SYSC_R8A77965)	+= r8a77965-sysc.o
-obj-$(CONFIG_SYSC_R8A77970)	+= r8a77970-sysc.o
-obj-$(CONFIG_SYSC_R8A77980)	+= r8a77980-sysc.o
-obj-$(CONFIG_SYSC_R8A77990)	+= r8a77990-sysc.o
-obj-$(CONFIG_SYSC_R8A77995)	+= r8a77995-sysc.o
-obj-$(CONFIG_SYSC_R8A779A0)	+= r8a779a0-sysc.o
-obj-$(CONFIG_SYSC_R8A779F0)	+= r8a779f0-sysc.o
-obj-$(CONFIG_SYSC_R8A779G0)	+= r8a779g0-sysc.o
 ifdef CONFIG_SMP
 obj-$(CONFIG_ARCH_R9A06G032)	+= r9a06g032-smp.o
 endif
@@ -34,6 +10,3 @@ endif
 # Family
 obj-$(CONFIG_PWC_RZV2M)		+= pwc-rzv2m.o
 obj-$(CONFIG_RST_RCAR)		+= rcar-rst.o
-obj-$(CONFIG_SYSC_RCAR)		+= rcar-sysc.o
-obj-$(CONFIG_SYSC_RCAR_GEN4)	+= rcar-gen4-sysc.o
-obj-$(CONFIG_SYSC_RMOBILE)	+= rmobile-sysc.o
-- 
2.34.1

