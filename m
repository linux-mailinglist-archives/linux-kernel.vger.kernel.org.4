Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD8267E31C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjA0LUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjA0LTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:19:06 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5B37B420
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:30 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bk16so4642063wrb.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nophxsV7RTMMr7jT/+RerGv5oOL4oTpwyjcwQZkZTDc=;
        b=Ey/fOJ1cRFNO9y5NIrn+b1FYncc4yFk2walPwaG5KX/r956XOp+lQSIX5FJBAmRc9m
         m/dHHPCnzM8t+R3teXgt11h+1EOiiEXWeajFDafLOMeKy04taSYCAQaxH8FmwuPQ11Uq
         9uwXhyJKzJGDOCtlzRgc/yIPJv8k53whjMnS2aMNnJsMpmc0yskJjfgJ2YMZ8pgcNfpR
         C6QExyalaFoy7jyesyRW7pWNJw0YeAEPDf2+os3gVVMY0Iox9W+x4vB0FRP2KvCs0V8z
         xdTSfYKLsWrV7CaXYgUiUOjjkkAzxx3zAyFBj+b7bJuAsWmwLAO5NTqaMRUl1DGghUy/
         F4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nophxsV7RTMMr7jT/+RerGv5oOL4oTpwyjcwQZkZTDc=;
        b=TXCm3a2t0CJU7ltKTMIk5KuQZkPqryz/fmTKHGAq4pPiGdiCvcYOHJ6KraxiXOFJPy
         tT/beFKprN5/smJGy7uTBj9n8cYUArtTSTcRfF6uDGmuKoGLCYzrZ8rXhBmRegQTAyjH
         CW8WKJxEFfnUHlTqAkrH9RD745unXzNdAcQtlJEXzlZovECwXgEYKoMem4FPcxpn3W66
         OQVOm0ZAWE4T9NhO30ChgFoLY5V4dFJB0Zg4WEEfyVSjIxO2WQtMce3ceqJ5OGeBB6Hh
         4sg6XG4mSFD2z82Kqe9gWtFcf2Vhg+0Xj9mN2OwVn7R0dmLvXszYa+7aGUBuJXdan1Ro
         jRCQ==
X-Gm-Message-State: AO0yUKVDC/lLr1/f2wVrDE70lP/2ISS9fLf+553Z0iKiq98RN7Ziz1iG
        atuSi8J76s9LYzVuNa57wY0Dvw==
X-Google-Smtp-Source: AK7set8Ka6HkpcfRSgOGhN+j6sb9fUlSAryF2sEaZDPa3lDdstzH0YuSpoTqGa3zABw3d7VP6GC2mA==
X-Received: by 2002:a5d:5a87:0:b0:2bf:b7ca:8ae2 with SMTP id bp7-20020a5d5a87000000b002bfb7ca8ae2mr9590774wrb.15.1674818309851;
        Fri, 27 Jan 2023 03:18:29 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:18:29 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 37/37] nvmem: stm32: fix OPTEE dependency
Date:   Fri, 27 Jan 2023 11:16:05 +0000
Message-Id: <20230127111605.25958-38-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

Fixes: ae46fd89cc0cc ("nvmem: stm32: add OP-TEE support for STM32MP13x")
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
2.25.1

