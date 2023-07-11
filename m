Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD4674F21A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbjGKOYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbjGKOXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:23:04 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248B02127
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:22:31 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so9158069e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085343; x=1691677343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iwIBZ05Ys45I978D50ldwhR/Cf6WfL00p93qangrY3Q=;
        b=Iou84qTwZTWHyUC5ueKdQedZumyQQXVVqADsXy14PIsu47h1UECAkc/MAemCiToZ6n
         rKEGK5lCL5LD5stpmMGK2sCBV2ZuW/aDPw274rORL1tFEVb7MjlEGt4CmZw9A3mkGcGu
         DvcDU8Q43Zo+xE7VAHNHNRzaYsm+MIznNQMPhSV8Z5BKMrtHXEipR/tr+7BaJb73fZHN
         qOZCCqL01iOZCqx97LB1oFQFQ+M+3nL2CW2knHH/eGy6nOTJqmpNJQyF2aZdXi8lj9gG
         xImxCRawYhLeEqe9PgOFYhuLAW9oRNqQEdORDzp6P9ixb9knA3Dy7AsaIt9C0BpYitsx
         7ZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085343; x=1691677343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iwIBZ05Ys45I978D50ldwhR/Cf6WfL00p93qangrY3Q=;
        b=glvRpLB0fjlyi3j5zjtyB/2P15rgmQ91E+qlUtC8RBOkDrpQpVhNzbEy7j0yTAEyCs
         /cVZCvJdQNzTFPAXN3bPZsBiJRC6HdrFHweyp7J3IQ+h1CN6sQajV46wajOZ/+gjPIaw
         3O9eJxdCaKH1tU96C9KU5eLVvFKanF8J1Rj4kpEAiyaIPYvR6h6gmn1hY3gUfJs3jK+U
         pzohmc4Y8B8Xi9IhcUcjsVEPdN9vpMLks85cTdq3+NjxkHjlp7wcJZBUaeNW/b7Jkatm
         QIChpfiqwMRvduq4/e8kyIjiu8906iGwNT1rv16cmrfm8z7tkWPpd6p2bFDd6a1QeBC/
         z/Ag==
X-Gm-Message-State: ABy/qLZx26SnIrSYeOCtijXxvCnIosdM8DEaKKxmTMxYUWsP2OUMGWH1
        g9HGgv2FPP0CE0GKg9QmlS6J5w==
X-Google-Smtp-Source: APBJJlGEMYUOHgBlD4JB4xGY34paEiDQr3XVU9HTTGAP9qFTytewgj5cPGx3DY7erboJDQ9LoHVwog==
X-Received: by 2002:ac2:5f01:0:b0:4fa:6d62:9219 with SMTP id 1-20020ac25f01000000b004fa6d629219mr11328781lfq.62.1689085343456;
        Tue, 11 Jul 2023 07:22:23 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id w12-20020ac2598c000000b004fbbf5db0a5sm339232lfn.100.2023.07.11.07.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:22:23 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH v2 15/18] soc: ti: Mover power-domain drivers to the genpd dir
Date:   Tue, 11 Jul 2023 16:22:20 +0200
Message-Id: <20230711142220.751795-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify with maintenance let's move the ti power-domain drivers to the
new genpd directory. Going forward, patches are intended to be managed
through a separate git tree, according to MAINTAINERS.

Cc: Nishanth Menon <nm@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Tero Kristo <kristo@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>
Reviewed-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                                   | 3 ++-
 drivers/genpd/Makefile                        | 1 +
 drivers/genpd/ti/Makefile                     | 3 +++
 drivers/{soc => genpd}/ti/omap_prm.c          | 0
 drivers/{soc => genpd}/ti/ti_sci_pm_domains.c | 0
 drivers/soc/ti/Makefile                       | 2 --
 6 files changed, 6 insertions(+), 3 deletions(-)
 create mode 100644 drivers/genpd/ti/Makefile
 rename drivers/{soc => genpd}/ti/omap_prm.c (100%)
 rename drivers/{soc => genpd}/ti/ti_sci_pm_domains.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4be5dc3fd6dd..633bc6767cd5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21107,7 +21107,7 @@ F:	drivers/irqchip/irq-ti-sci-inta.c
 F:	drivers/irqchip/irq-ti-sci-intr.c
 F:	drivers/reset/reset-ti-sci.c
 F:	drivers/soc/ti/ti_sci_inta_msi.c
-F:	drivers/soc/ti/ti_sci_pm_domains.c
+F:	drivers/genpd/ti/ti_sci_pm_domains.c
 F:	include/dt-bindings/soc/ti,sci_pm_domain.h
 F:	include/linux/soc/ti/ti_sci_inta_msi.h
 F:	include/linux/soc/ti/ti_sci_protocol.h
@@ -21341,6 +21341,7 @@ L:	linux-kernel@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
+F:	drivers/genpd/ti/omap_prm.c
 F:	drivers/soc/ti/*
 
 TI LM49xxx FAMILY ASoC CODEC DRIVERS
diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index e6f34d82e6a8..193892189f0d 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -11,3 +11,4 @@ obj-y					+= samsung/
 obj-y					+= starfive/
 obj-y					+= sunxi/
 obj-y					+= tegra/
+obj-y					+= ti/
diff --git a/drivers/genpd/ti/Makefile b/drivers/genpd/ti/Makefile
new file mode 100644
index 000000000000..69580afbb436
--- /dev/null
+++ b/drivers/genpd/ti/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_ARCH_OMAP2PLUS)		+= omap_prm.o
+obj-$(CONFIG_TI_SCI_PM_DOMAINS)		+= ti_sci_pm_domains.o
diff --git a/drivers/soc/ti/omap_prm.c b/drivers/genpd/ti/omap_prm.c
similarity index 100%
rename from drivers/soc/ti/omap_prm.c
rename to drivers/genpd/ti/omap_prm.c
diff --git a/drivers/soc/ti/ti_sci_pm_domains.c b/drivers/genpd/ti/ti_sci_pm_domains.c
similarity index 100%
rename from drivers/soc/ti/ti_sci_pm_domains.c
rename to drivers/genpd/ti/ti_sci_pm_domains.c
diff --git a/drivers/soc/ti/Makefile b/drivers/soc/ti/Makefile
index cc3c972fad2e..cb800a745e66 100644
--- a/drivers/soc/ti/Makefile
+++ b/drivers/soc/ti/Makefile
@@ -6,9 +6,7 @@ obj-$(CONFIG_KEYSTONE_NAVIGATOR_QMSS)	+= knav_qmss.o
 knav_qmss-y := knav_qmss_queue.o knav_qmss_acc.o
 obj-$(CONFIG_KEYSTONE_NAVIGATOR_DMA)	+= knav_dma.o
 obj-$(CONFIG_AMX3_PM)			+= pm33xx.o
-obj-$(CONFIG_ARCH_OMAP2PLUS)		+= omap_prm.o
 obj-$(CONFIG_WKUP_M3_IPC)		+= wkup_m3_ipc.o
-obj-$(CONFIG_TI_SCI_PM_DOMAINS)		+= ti_sci_pm_domains.o
 obj-$(CONFIG_TI_SCI_INTA_MSI_DOMAIN)	+= ti_sci_inta_msi.o
 obj-$(CONFIG_TI_K3_RINGACC)		+= k3-ringacc.o
 obj-$(CONFIG_TI_K3_SOCINFO)		+= k3-socinfo.o
-- 
2.34.1

