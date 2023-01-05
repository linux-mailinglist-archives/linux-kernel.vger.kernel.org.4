Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA7565EDAE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjAENre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjAENrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:47:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261F83F100;
        Thu,  5 Jan 2023 05:47:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9755061A8E;
        Thu,  5 Jan 2023 13:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6D9C43392;
        Thu,  5 Jan 2023 13:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926429;
        bh=MePNggNn2Sdy9A2QPxyvtHiIGVkS0Kpugps/y3JKzaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CIfFNq+TUc4bgKQDXZX7LJ+AsYv5L19C+b57kSP+WCWPDnV+66EVyavxyDdnjwa2L
         m7JZmu95FeBZ7HP5WaYlNIWHpccm+ST8DcBStZW9hEuK+SjMaCL8c8ml4LeCuYwB8r
         lqTZJzXfqZwq8HyPtBdhfBQIHyHwtyTfDS3z+A95BjcBJfPk0S6gvACvIUZ1+Sq0h/
         1tknNa7twsy7amcBfF/+1PzsKpK78HVLpOwlxu/5TK7M9xsgb6N325k9s/fR212RKz
         oUwHFGcll88yYP3SzeJk0IIBvi1H5s9E4W9Uyu29IiedhRxyBOwjieAyB9zW7yOk/0
         if3kYzrG8RESA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 10/27] input: remove pxa930_trkball driver
Date:   Thu,  5 Jan 2023 14:46:05 +0100
Message-Id: <20230105134622.254560-11-arnd@kernel.org>
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

The pxa930 SoC support is getting removed, and no upstream
board ever provided the trkball device that this driver
relies on.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/mouse/Kconfig                   |   6 -
 drivers/input/mouse/Makefile                  |   1 -
 drivers/input/mouse/pxa930_trkball.c          | 250 ------------------
 .../platform_data/mouse-pxa930_trkball.h      |  11 -
 4 files changed, 268 deletions(-)
 delete mode 100644 drivers/input/mouse/pxa930_trkball.c
 delete mode 100644 include/linux/platform_data/mouse-pxa930_trkball.h

diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index 63c9cda555c3..32cc4c62a716 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -393,12 +393,6 @@ config MOUSE_GPIO
 	  To compile this driver as a module, choose M here: the
 	  module will be called gpio_mouse.
 
-config MOUSE_PXA930_TRKBALL
-	tristate "PXA930 Trackball mouse"
-	depends on CPU_PXA930 || CPU_PXA935
-	help
-	  Say Y here to support PXA930 Trackball mouse.
-
 config MOUSE_MAPLE
 	tristate "Maple mouse (for the Dreamcast)"
 	depends on MAPLE
diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
index e49f08565076..92b3204ce84e 100644
--- a/drivers/input/mouse/Makefile
+++ b/drivers/input/mouse/Makefile
@@ -18,7 +18,6 @@ obj-$(CONFIG_MOUSE_MAPLE)		+= maplemouse.o
 obj-$(CONFIG_MOUSE_NAVPOINT_PXA27x)	+= navpoint.o
 obj-$(CONFIG_MOUSE_PC110PAD)		+= pc110pad.o
 obj-$(CONFIG_MOUSE_PS2)			+= psmouse.o
-obj-$(CONFIG_MOUSE_PXA930_TRKBALL)	+= pxa930_trkball.o
 obj-$(CONFIG_MOUSE_RISCPC)		+= rpcmouse.o
 obj-$(CONFIG_MOUSE_SERIAL)		+= sermouse.o
 obj-$(CONFIG_MOUSE_SYNAPTICS_I2C)	+= synaptics_i2c.o
diff --git a/drivers/input/mouse/pxa930_trkball.c b/drivers/input/mouse/pxa930_trkball.c
deleted file mode 100644
index f04ba12dbfa8..000000000000
diff --git a/include/linux/platform_data/mouse-pxa930_trkball.h b/include/linux/platform_data/mouse-pxa930_trkball.h
deleted file mode 100644
index ba0ac7a30d8c..000000000000
-- 
2.39.0

