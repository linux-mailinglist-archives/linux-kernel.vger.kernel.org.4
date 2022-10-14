Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5BD5FED91
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJNLtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiJNLsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:48:36 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A916EAC8E;
        Fri, 14 Oct 2022 04:48:21 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d24so4506030pls.4;
        Fri, 14 Oct 2022 04:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlMejhYMrsXeQZKhuEF1RsJsIGglk9iDSAvDuHs7gfk=;
        b=G8Hw4b2L2H0lG9SfcHxalBmc2wtHIOFBxmsUbWYkxjDFlW/aEWp6sQDCG8kruTGgBR
         6s42BULDi2LwMaDd4Efod//lUTLO5tU1gDhMRo5pgDkZRPbP1vKFKTg3ra4+ykqgfFY6
         mQTk96hwXLFj9ZcJuqOZCxcIDR9JF/SuSQWXsHpHhPieK2561O4SIVzeugVhU1m7/ee8
         +uK1TX3VY60R9OKoUAoUr7biI3GFIbsHd5kzYTN3M1qYdSiQHGKYbIJupEBC8EDtG3Kc
         ppb7406iGC6CwF+lAyQmrzSYSu32C1E9pgsu3n65du9C6AqoEXK76Q+lAbhcmprIY0hu
         ADeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlMejhYMrsXeQZKhuEF1RsJsIGglk9iDSAvDuHs7gfk=;
        b=y296INPI1noRt8CjomI94CfYGIpRw6QsJcBiZ1y0kWigGHdM0c01zxOYLrhXEuOYW+
         bfu6d+BKj0Hf7jA7e+pVurJCTvP1RMQ4ZWI1tuiCh7IfC2/sCADGB9rA8jIkaQnSO2jq
         X5t10LSg7clkSh2w0vV896aQZsFf7tJM2sJ0FAGmJu/wCk0i1UN/OQtEmg35S6bY9LE2
         lh3PzY6E4KQ7QUIqEhoymNtVEc3Wu92aNSuyYaA0LZAVTVwUqDbR7q/L3W6j3Fh1W50F
         byj4rqTfdye9BIbFpsE/AowmlyvlRRTHAe3aOwYv5z0hlHRWIkZqQj+HXwnZiqTj0NnV
         grzw==
X-Gm-Message-State: ACrzQf0Dz3tL3zj0gEETZAis57a7BVBKOjzsHne0DLwnUdF5Fps3Xcz8
        DyYs9iidOS+LCxFRhdFJfjg=
X-Google-Smtp-Source: AMsMyM7V3n0ex7bitAex/i/J5JM0HK0pT9CRujkcyqWPO9lxBpcgwOj3+1Y7aTnn+WggOZI0GcrFiQ==
X-Received: by 2002:a17:90b:1d88:b0:20d:7449:c0ef with SMTP id pf8-20020a17090b1d8800b0020d7449c0efmr16746550pjb.103.1665748094976;
        Fri, 14 Oct 2022 04:48:14 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e282-2aaa-c1aa-06c8-0e68-c5ee.emome-ip6.hinet.net. [2001:b400:e282:2aaa:c1aa:6c8:e68:c5ee])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902ec8800b001746f66244asm1606678plg.18.2022.10.14.04.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 04:48:14 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 22/26] mmc: sdhci-uhs2: add pre-detect_init hook
Date:   Fri, 14 Oct 2022 19:45:57 +0800
Message-Id: <20221014114601.15594-23-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
References: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
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

This "pre" hook for detect_init(), uhs2_pre_detect_init, will be required
to enable UHS-II support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/Kconfig           | 22 ----------------------
 drivers/mmc/Makefile          |  7 -------
 drivers/mmc/host/sdhci-uhs2.c |  3 +++
 drivers/mmc/host/sdhci.h      |  1 +
 4 files changed, 4 insertions(+), 29 deletions(-)
 delete mode 100644 drivers/mmc/Kconfig
 delete mode 100644 drivers/mmc/Makefile

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
deleted file mode 100644
index 2436eb4996a4..000000000000
--- a/drivers/mmc/Kconfig
+++ /dev/null
@@ -1,22 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# MMC subsystem configuration
-#
-
-menuconfig MMC
-	tristate "MMC/SD/SDIO card support"
-	depends on HAS_IOMEM
-	help
-	  This selects MultiMediaCard, Secure Digital and Secure
-	  Digital I/O support.
-
-	  If you want MMC/SD/SDIO support, you should say Y here and
-	  also to your specific host controller driver.
-
-if MMC
-
-source "drivers/mmc/core/Kconfig"
-
-source "drivers/mmc/host/Kconfig"
-
-endif # MMC
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
deleted file mode 100644
index 3ea0126a9a72..000000000000
--- a/drivers/mmc/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Makefile for the kernel mmc device drivers.
-#
-
-obj-$(CONFIG_MMC)		+= core/
-obj-$(subst m,y,$(CONFIG_MMC))	+= host/
diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 8e547b672574..88decfba1880 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -1570,6 +1570,9 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
 
 	DBG("%s: begin UHS2 init.\n", __func__);
 
+	if (host->ops && host->ops->uhs2_pre_detect_init)
+		host->ops->uhs2_pre_detect_init(host);
+
 	if (sdhci_uhs2_interface_detect(host)) {
 		pr_warn("%s: cannot detect UHS2 interface.\n",
 			mmc_hostname(host->mmc));
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index bc4be80bf0af..943701aef22a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -745,6 +745,7 @@ struct sdhci_ops {
 				struct mmc_request *mrq);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
+	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.25.1

