Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D186E1DBC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDNIDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDNIDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:03:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAA410DB;
        Fri, 14 Apr 2023 01:03:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8150061509;
        Fri, 14 Apr 2023 08:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEA1C433EF;
        Fri, 14 Apr 2023 08:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681459415;
        bh=A/hvv45Iuk0V5ALA824dIubPvLgUljKnosLa3dg0EbI=;
        h=From:To:Cc:Subject:Date:From;
        b=V/uwUPy98/cFW554EfKlf6cexw08ln3C2B5ofLE9nOvQezv/KhEjJbYIQrjQMccQO
         v3x7hoEOJPfEQipk5f+ghSpMXXToj/wKRGF3+m5rRVLcDbZMHGsqpOPo16l34CCPKZ
         NkxueHB8RY0GL7qEcegiYKsDPK9q+jGy/gVezoh/AeQqgSJWJsI3JXn6WSl8Y4xqop
         Qp5B8SSowKiZOHth0iAxZWcPHVCjv8gZ/IvKwSZnr1+E3dem3zY2ZnqWKGIaZ6VGId
         XFYWMCscrvH9wGgiMTtdlte0jJBlajO/5v15A1EQnV5rDK1AOjk/9M9OgMlG0gSvMI
         Je2lDSIUh6crQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>
Cc:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware_loader: rework crypto dependencies
Date:   Fri, 14 Apr 2023 10:03:07 +0200
Message-Id: <20230414080329.76176-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

The crypto dependencies for the firmwware loader are incomplete,
in particular a built-in FW_LOADER fails to link against a modular
crypto hash driver:

ld.lld: error: undefined symbol: crypto_alloc_shash
ld.lld: error: undefined symbol: crypto_shash_digest
ld.lld: error: undefined symbol: crypto_destroy_tfm
>>> referenced by main.c
>>>               drivers/base/firmware_loader/main.o:(fw_log_firmware_info) in archive vmlinux.a

Rework this to use the usual 'select' from the driver module,
to respect the built-in vs module dependencies, and add a
more verbose crypto dependency to the debug option to prevent
configurations that lead to a link failure.

Fixes: 02fe26f25325 ("firmware_loader: Add debug message with checksum for FW file")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Tested on a few hundred randconfig builds
---
 drivers/base/firmware_loader/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
index 0cabc783d67a..5ca00e02fe82 100644
--- a/drivers/base/firmware_loader/Kconfig
+++ b/drivers/base/firmware_loader/Kconfig
@@ -3,6 +3,8 @@ menu "Firmware loader"
 
 config FW_LOADER
 	tristate "Firmware loading facility" if EXPERT
+	select CRYPTO_HASH if FW_LOADER_DEBUG
+	select CRYPTO_SHA256 if FW_LOADER_DEBUG
 	default y
 	help
 	  This enables the firmware loading facility in the kernel. The kernel
@@ -26,10 +28,9 @@ config FW_LOADER
 
 config FW_LOADER_DEBUG
 	bool "Log filenames and checksums for loaded firmware"
+	depends on CRYPTO = FW_LOADER || CRYPTO=y
 	depends on DYNAMIC_DEBUG
 	depends on FW_LOADER
-	depends on CRYPTO
-	depends on CRYPTO_SHA256
 	default FW_LOADER
 	help
 	  Select this option to use dynamic debug to log firmware filenames and
-- 
2.39.2

