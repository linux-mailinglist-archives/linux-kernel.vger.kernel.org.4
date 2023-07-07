Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A5574B2A0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjGGOFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjGGOFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:05:31 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DA919BD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:05:08 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b6f9edac8dso29140771fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688738706; x=1691330706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VApuNv7K0akCAqJYRY7aWjKx21v5ANKMyMqi/O1A0MY=;
        b=bMtfuXHQAOZjenwNznuGxZ1Ud/AreXxB8SuCW8AVQEiSEQBdTQ7NPapmusVTdtPXvZ
         V6QPEua25XqtQYjmtpkLMOt73d1/7FQVlFhZjL6wkBkrha5fBIfxWIga2h550Lo/SlkK
         SVOY8GKTIytJAWijHSstTiEE55AQ3BvbheXQioapE06YLb/cGydYXuEjWOBppcVK1CMS
         UqilY6jq3uzFjA0aINhfjPR4A0lS/hlD8PaFu93Z2po2ISZxBEwmZPIza4FlruOp8GFn
         AnOwHW0FUQtR3rCGr0sRxJAJ70ejgUkT6R0cc6ZG0AoiL4+40FMu7MB0COlOTU/i741M
         OREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738706; x=1691330706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VApuNv7K0akCAqJYRY7aWjKx21v5ANKMyMqi/O1A0MY=;
        b=CTnKXNrstydk2JYJTnb4Cr+YM4hukoCF2WV+crwTUAKkNBfG7l1kk6xJWhUpdURLbM
         rTAu7kT7bOwDTprEwbPk8EQ6O5phkdUIAaQb99qDn5z6K22lpMyGKk2g1GQudyA5zVS+
         /NHt5gIhIHQxKLr3eiE4oVAj9pWX3t1bPJfDTECAKl87hZ4ujztPp5fMtSxcw5qXTwdC
         jy19ei8ePLllRQXDBCiwwaNZBYWUjgyP/THuFK/JGKDg5I3voll2b+AznvGYrrFlTw12
         iLe9vWMLrssVzqfVFrV9H7G/enO1tBafdaG2+/sFNW8e1rM+oDdgPc6IpDMK+TRqGtzL
         PdRQ==
X-Gm-Message-State: ABy/qLaIDqOzQgVjGR+GrikxbgnZ1SX4vgRKP/0YqEU7fBFzjFn4Y5qC
        W9uXh2WJm/9tzHcaDk2T+DPiiSOJJsDj3M/U1Mk=
X-Google-Smtp-Source: APBJJlFVYwF1JmN9UgPPIHu7IqhkYo85p/SkhH0GI8LAixeD+mcBM5zYy2/oHzF5Oduq7ge5pzX8eg==
X-Received: by 2002:a2e:854d:0:b0:2b6:ef2b:da5e with SMTP id u13-20020a2e854d000000b002b6ef2bda5emr3821401ljj.49.1688738706796;
        Fri, 07 Jul 2023 07:05:06 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e8555000000b002b6cb25e3f1sm760341ljj.108.2023.07.07.07.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 07:05:05 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>
Subject: [PATCH 15/18] soc: ti: Mover power-domain drivers to the genpd dir
Date:   Fri,  7 Jul 2023 16:04:31 +0200
Message-Id: <20230707140434.723349-16-ulf.hansson@linaro.org>
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

Cc: Nishanth Menon <nm@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Tero Kristo <kristo@kernel.org>
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
index 9e580df3e5db..3cf16ffac892 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21101,7 +21101,7 @@ F:	drivers/irqchip/irq-ti-sci-inta.c
 F:	drivers/irqchip/irq-ti-sci-intr.c
 F:	drivers/reset/reset-ti-sci.c
 F:	drivers/soc/ti/ti_sci_inta_msi.c
-F:	drivers/soc/ti/ti_sci_pm_domains.c
+F:	drivers/genpd/ti/ti_sci_pm_domains.c
 F:	include/dt-bindings/soc/ti,sci_pm_domain.h
 F:	include/linux/soc/ti/ti_sci_inta_msi.h
 F:	include/linux/soc/ti/ti_sci_protocol.h
@@ -21335,6 +21335,7 @@ L:	linux-kernel@vger.kernel.org
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

