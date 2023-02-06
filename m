Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E602368BA3D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjBFKbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjBFK3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:29:47 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853AE21A20
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:29:01 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so10399791wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5lWuq1dqBRExLhj0uCTTB3JASg++oX5rRvkth7BBTg=;
        b=lf/p3x9QeSIuKX7tPTFBMZglAmU/qPv30bA36lvIsw8GK/JF+8Hz7YAtLNfYXAjbjc
         2FAypbqBcQyAu7n+CUkcEQc0fF4Cqbm/nZ7N6RUTLHQ1N/gTxZ1HSjAm+GjlScrVBjfU
         X2KlM1UihEQflU607oNDSSBoNtkF6MiDASeHQIgat1AM8kHXruM1jWfEXJbKaGV4917a
         XkFhmpyteDWIBYo7Bg/7wEB+30nzsf9xwiDqAViwZbnZghjGjVk22PbkMPqU9IGFFb7N
         pkEOnMzge9sUKf1bahYsLv8G2H/yoyynkSN1sC0vshVc9HmZYbCJ9hnPd+8VFXaJFRfb
         78jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5lWuq1dqBRExLhj0uCTTB3JASg++oX5rRvkth7BBTg=;
        b=u+5m3M6sHEUevM9ougt5liBDawKCqcsXVBMh7X+unWb7kJioeEgDY5DPAmcALBBxuS
         RjmSpUIoQjcr7CSF7qMafzYUY3WiX0zzLsxt7P7HaQEJF41obI/SLot1gAwvUFjQcFky
         0dLmltZenACwukNpxH25vHlMcdJ4SoaUINVnI7AxuDznx53VcHF8Bd5qfzotHWnX/Jpi
         szQlDdem5UsGK+7yVdp6KwtvOw+w5ABHjwKgW0qWRh1W29uCGTEPcdqKrZ0Z/MYI1Ojb
         FQsQEbn4EFGB3fMtHG+vOavDS8peF3L36zOBloAesbPYSrleh4CJj9xuOMD4OyKA9NfN
         Ek1Q==
X-Gm-Message-State: AO0yUKXXXDX2YBs71OpqJEde3KJyuV2KKV0PupoQeog0oXP7Zb6+Uxw1
        6WQB/7l0Vb/UFxEeKMNPrE80Rw==
X-Google-Smtp-Source: AK7set92im+QaXuByfBvanfDhbizp2kMRGIGHETco0pu3d6z4K48q9GfW9s8YYixKy/cIYzryElE6w==
X-Received: by 2002:a7b:c846:0:b0:3dc:405b:99bf with SMTP id c6-20020a7bc846000000b003dc405b99bfmr18874716wml.15.1675679339913;
        Mon, 06 Feb 2023 02:28:59 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:59 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 37/37] nvmem: stm32: fix OPTEE dependency
Date:   Mon,  6 Feb 2023 10:27:59 +0000
Message-Id: <20230206102759.669838-38-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
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

Fixes: 0a37e22da31a ("nvmem: stm32: add OP-TEE support for STM32MP13x")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

