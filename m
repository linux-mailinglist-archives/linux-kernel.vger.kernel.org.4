Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF816A2E6D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 06:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBZFkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 00:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBZFj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 00:39:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437DC136EF;
        Sat, 25 Feb 2023 21:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=O340cx3Gf4ovH/d02TCwqdI/1zyYU3moQhAG1qL628c=; b=pI5DciSQKlna6bL0mallbe8Ihi
        X3b+wazKWjPIFHBzO2k2MpiVgLW3ygLANi/AF5yJaXfBCvA3CfEzTuju9IgnvXB7OGEkvwwDDdvDJ
        9Z9n5RR9kKliIDiujjn7XESJLRcnkWQcaIix6VUwkcwXA0z21WQAQNTJLldYl6UnbA8jB7EtSnQma
        S0l6nlNAGs9qAsf2HdLGiBLw1MteqhlFjuHr6p75SSEVAZtC3e4ltOijeGrw4ZaZDgO6g21ErtiHx
        DgHGM3k4R25XyPSZ5CllseMdv2tJ07dK6WVyEoA7aYgdX1lKkOV85PAYswLJvCjS6pmSCcuuoGQJy
        Il5zW/rQ==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pW9lM-006qYL-Ql; Sun, 26 Feb 2023 05:39:56 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Shych <michaelsh@nvidia.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 5/8] platform: mellanox: select REGMAP instead of depending on it
Date:   Sat, 25 Feb 2023 21:39:50 -0800
Message-Id: <20230226053953.4681-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230226053953.4681-1-rdunlap@infradead.org>
References: <20230226053953.4681-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

REGMAP is a hidden (not user visible) symbol. Users cannot set it
directly thru "make *config", so drivers should select it instead of
depending on it if they need it.

Consistently using "select" or "depends on" can also help reduce
Kconfig circular dependency issues.

Therefore, change the use of "depends on REGMAP" to "select REGMAP".

For NVSW_SN2201, select REGMAP_I2C instead of depending on it.

Fixes: c6acad68eb2d ("platform/mellanox: mlxreg-hotplug: Modify to use a regmap interface")
Fixes: 5ec4a8ace06c ("platform/mellanox: Introduce support for Mellanox register access driver")
Fixes: 62f9529b8d5c ("platform/mellanox: mlxreg-lc: Add initial support for Nvidia line card devices")
Fixes: 662f24826f95 ("platform/mellanox: Add support for new SN2201 system")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Michael Shych <michaelsh@nvidia.com>
Cc: Mark Gross <markgross@kernel.org>
Cc: Vadim Pasternak <vadimp@nvidia.com>
Cc: platform-driver-x86@vger.kernel.org
---
 drivers/platform/mellanox/Kconfig |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff -- a/drivers/platform/mellanox/Kconfig b/drivers/platform/mellanox/Kconfig
--- a/drivers/platform/mellanox/Kconfig
+++ b/drivers/platform/mellanox/Kconfig
@@ -16,17 +16,17 @@ if MELLANOX_PLATFORM
 
 config MLXREG_HOTPLUG
 	tristate "Mellanox platform hotplug driver support"
-	depends on REGMAP
 	depends on HWMON
 	depends on I2C
+	select REGMAP
 	help
 	  This driver handles hot-plug events for the power suppliers, power
 	  cables and fans on the wide range Mellanox IB and Ethernet systems.
 
 config MLXREG_IO
 	tristate "Mellanox platform register access driver support"
-	depends on REGMAP
 	depends on HWMON
+	select REGMAP
 	help
 	  This driver allows access to Mellanox programmable device register
 	  space through sysfs interface. The sets of registers for sysfs access
@@ -36,9 +36,9 @@ config MLXREG_IO
 
 config MLXREG_LC
 	tristate "Mellanox line card platform driver support"
-	depends on REGMAP
 	depends on HWMON
 	depends on I2C
+	select REGMAP
 	help
 	  This driver provides support for the Mellanox MSN4800-XX line cards,
 	  which are the part of MSN4800 Ethernet modular switch systems
@@ -80,10 +80,9 @@ config MLXBF_PMC
 
 config NVSW_SN2201
 	tristate "Nvidia SN2201 platform driver support"
-	depends on REGMAP
 	depends on HWMON
 	depends on I2C
-	depends on REGMAP_I2C
+	select REGMAP_I2C
 	help
 	  This driver provides support for the Nvidia SN2201 platform.
 	  The SN2201 is a highly integrated for one rack unit system with
