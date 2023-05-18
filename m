Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD367079F4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 07:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjERF41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 01:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjERF4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 01:56:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C95010CE
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 22:56:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DA1C64D35
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 05:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE18C433EF;
        Thu, 18 May 2023 05:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684389384;
        bh=TfZo0gQWtATIJF7wQknAcwMEllVnKQ6QHqI+P0/UAX4=;
        h=From:To:Cc:Subject:Date:From;
        b=k+Jj15DVmVo9NFT33XxY2qLh9yHswy4eFdGA6nXRcc0c5QbsUBfjU/wsu6WZAWosF
         eA/inhzSRI7YGVfCP9YSXAJ4w/wNEggMjEVPuUKTuxLpVjTl78TNbRk31cl6xvCmU/
         mgoHp6HoDJ0jKJo+FfAOMVbfrUo49y+aUlZXIL/na1ce/yk+IvA+JlUtH7PACakPtt
         IQOIwCoqW2rzBtpRSSOtrZdqdm1jtHcVs0cKmfhtuIORl7cTu/SyARRb80OWGi18sC
         FFEdK1ITf/fQa2NgsnFCJ18T+oyPDzQjgt68ulCVIoP47qrjF8v9jxHtAxxKc2OVn8
         5c0FJZtRnW0KQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] Revert "serial: allow COMPILE_TEST for some drivers" partially
Date:   Thu, 18 May 2023 07:56:20 +0200
Message-Id: <20230518055620.29957-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit e3e7b13bffae85e2806c73e3ccacd4447bcb19ed partially.
It turns out, the image does not link for CPM:
  powerpc-linux-ld: drivers/tty/serial/cpm_uart/cpm_uart_core.o: in function `cpm_uart_release_port':
  cpm_uart_core.c:(.text+0x598): undefined reference to `cpm_uart_freebuf'

So do not allow compile testing on this driver.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/tty/serial/Kconfig             | 2 +-
 drivers/tty/serial/cpm_uart/cpm_uart.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 398e5aac2e77..3e3fb377d90d 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -762,7 +762,7 @@ config SERIAL_PMACZILOG_CONSOLE
 
 config SERIAL_CPM
 	tristate "CPM SCC/SMC serial port support"
-	depends on CPM2 || CPM1 || (PPC32 && COMPILE_TEST)
+	depends on CPM2 || CPM1
 	select SERIAL_CORE
 	help
 	  This driver supports the SCC and SMC serial ports on Motorola 
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart.h b/drivers/tty/serial/cpm_uart/cpm_uart.h
index 0577618e78c0..46c03ed71c31 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart.h
+++ b/drivers/tty/serial/cpm_uart/cpm_uart.h
@@ -19,8 +19,6 @@ struct gpio_desc;
 #include "cpm_uart_cpm2.h"
 #elif defined(CONFIG_CPM1)
 #include "cpm_uart_cpm1.h"
-#elif defined(CONFIG_COMPILE_TEST)
-#include "cpm_uart_cpm2.h"
 #endif
 
 #define SERIAL_CPM_MAJOR	204
-- 
2.40.1

