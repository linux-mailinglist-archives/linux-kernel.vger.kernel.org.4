Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA52267E096
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjA0JqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjA0JqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:46:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8B67643D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:46:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 083E861A7E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 09:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3F1C433D2;
        Fri, 27 Jan 2023 09:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674812765;
        bh=Dwcoj9AI+37+jvMJo/iQdubzeCr/in3liy/NPqI0rWo=;
        h=From:To:Cc:Subject:Date:From;
        b=g+xgl3oiFAeN8yu2QTebkyKbrVCnzTuUOjptqhJBaFBH3shVauUMfHqr/QHC1dhi6
         /TMMU5fb0cV/gE3qELqKSaRo+4CMTavZsUSuE0q2PcocqNKjx5v4vzWwWU50pedEDC
         tcJpuaDFspmuZz7WYLa7a6RaAoCyEY3zeMbSOwOPZkE9wQcfLKCptcvWPElO2ThLn7
         LrLmMECz+1qASVPqWgt2F0x7if74xxnOXos8MMTcnQ9oetqDXKIaNjMcRvDQFwGXzm
         HTq+weDy4w9D6wIf8GueQuHkhbeRveumaGRlthcM4vx7O3P36tp4krkU9anyk1F/e3
         u7KKAADzgu6Ag==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: stm32: fix OPTEE dependency
Date:   Fri, 27 Jan 2023 10:41:26 +0100
Message-Id: <20230127094200.2451839-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
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

The stm32 nvmem driver fails to link as built-in when OPTEE
is a loadable module:

aarch64-linux-ld: drivers/nvmem/stm32-bsec-optee-ta.o: in function `stm32_bsec:
stm32-bsec-optee-ta.c:(.text+0xc8): undefined reference to `tee_client_open_session'
aarch64-linux-ld: drivers/nvmem/stm32-bsec-optee-ta.o: in function `stm32_bsec:
stm32-bsec-optee-ta.c:(.text+0x1fc): undefined reference to `tee_client_open_context'

Change the CONFIG_NVMEM_STM32_ROMEM definition so it can only
be built-in if OPTEE is either built-in or disabled, and
make NVMEM_STM32_BSEC_OPTEE_TA a hidden symbol instead.

Fixes: acdf68bdf2d4 ("nvmem: stm32: add OP-TEE support for STM32MP13x")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/nvmem/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index ed8ef7460be2..ae2c5257ed97 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -295,8 +295,7 @@ config NVMEM_SPRD_EFUSE
 	  will be called nvmem-sprd-efuse.
 
 config NVMEM_STM32_BSEC_OPTEE_TA
-	bool "STM32MP BSEC OP-TEE TA support for nvmem-stm32-romem driver"
-	depends on OPTEE
+	def_bool NVMEM_STM32_ROMEM && OPTEE
 	help
 	  Say y here to enable the accesses to STM32MP SoC OTPs by the OP-TEE
 	  trusted application STM32MP BSEC.
@@ -307,7 +306,7 @@ config NVMEM_STM32_BSEC_OPTEE_TA
 config NVMEM_STM32_ROMEM
 	tristate "STMicroelectronics STM32 factory-programmed memory support"
 	depends on ARCH_STM32 || COMPILE_TEST
-	imply NVMEM_STM32_BSEC_OPTEE_TA
+	depends on OPTEE || !OPTEE
 	help
 	  Say y here to enable read-only access for STMicroelectronics STM32
 	  factory-programmed memory area.
-- 
2.39.0

