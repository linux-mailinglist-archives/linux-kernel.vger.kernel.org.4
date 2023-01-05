Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7EB65EDDD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjAENvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbjAENu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:50:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ECB6338C
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:48:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C096B81AE4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 13:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7B6C433EF;
        Thu,  5 Jan 2023 13:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926472;
        bh=cHw2D6c9GdFSvgGCy0oGwbsuU5djCFfJJbkfipj2g/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dv/o5jOj65aEMbPI7bEChRRKayfPxBpZtZsPsnUldfc43Y3A0DFULrsx9ZsuDR6L+
         WEpCr+fbkTlHGE+Rne97ManqekzpOs8PvF8HrEzrKBtwGr33qfKE3QlRq/XVs9+Rjn
         +nOdKQREp4M27ws5LgW3ujF/vq9r/reu3Glj+Dz9X5WmJZKl8UCjX/F+8linAVE+A/
         uUc1NPPF9DBXmYNo5Mjg7Bsh2SZniTeOQKoKGg+cUFpzIGucWYom0G0EJ1988Dnz5M
         6nZD//LtPB41l2qOcHQmqEyl6zkwMuUMeHHXlW17S90/mirCtRAiTJjQT2wJQWqBZZ
         1bRu5pUe/w7qw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Szabolcs Gyurko <szabolcs.gyurko@tlt.hu>
Subject: [PATCH 26/27] w1: remove ds1wm driver
Date:   Thu,  5 Jan 2023 14:46:21 +0100
Message-Id: <20230105134622.254560-27-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105134622.254560-1-arnd@kernel.org>
References: <20230105134622.254560-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This driver was used by the mfd/asic3 and mfd/htc-pasic3 drivers, but
both of those are removed as part of the PXA spring cleaning, which
leaves the w1 support orphaned as well.

Cc: Evgeniy Polyakov <zbr@ioremap.net>
Cc: Szabolcs Gyurko <szabolcs.gyurko@tlt.hu>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/w1/masters/Kconfig  |   7 -
 drivers/w1/masters/Makefile |   1 -
 drivers/w1/masters/ds1wm.c  | 675 ------------------------------------
 3 files changed, 683 deletions(-)
 delete mode 100644 drivers/w1/masters/ds1wm.c

diff --git a/drivers/w1/masters/Kconfig b/drivers/w1/masters/Kconfig
index 24b9a8e05f64..692cac3ff0ee 100644
--- a/drivers/w1/masters/Kconfig
+++ b/drivers/w1/masters/Kconfig
@@ -41,13 +41,6 @@ config W1_MASTER_MXC
 	help
 	  Say Y here to enable MXC 1-wire host
 
-config W1_MASTER_DS1WM
-	tristate "Maxim DS1WM 1-wire busmaster"
-	help
-	  Say Y here to enable the DS1WM 1-wire driver, such as that
-	  in HP iPAQ devices like h5xxx, h2200, and ASIC3-based like
-	  hx4700.
-
 config W1_MASTER_GPIO
 	tristate "GPIO 1-wire busmaster"
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/w1/masters/Makefile b/drivers/w1/masters/Makefile
index dae629b7ab49..c5d85a827e52 100644
--- a/drivers/w1/masters/Makefile
+++ b/drivers/w1/masters/Makefile
@@ -8,7 +8,6 @@ obj-$(CONFIG_W1_MASTER_DS2490)		+= ds2490.o
 obj-$(CONFIG_W1_MASTER_DS2482)		+= ds2482.o
 obj-$(CONFIG_W1_MASTER_MXC)		+= mxc_w1.o
 
-obj-$(CONFIG_W1_MASTER_DS1WM)		+= ds1wm.o
 obj-$(CONFIG_W1_MASTER_GPIO)		+= w1-gpio.o
 obj-$(CONFIG_HDQ_MASTER_OMAP)		+= omap_hdq.o
 obj-$(CONFIG_W1_MASTER_SGI)		+= sgi_w1.o
diff --git a/drivers/w1/masters/ds1wm.c b/drivers/w1/masters/ds1wm.c
deleted file mode 100644
index f661695fb589..000000000000
-- 
2.39.0

