Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8591F68BE9B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjBFNpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjBFNpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:45:10 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8762E1F491
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:44:40 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id z13so1233712wmp.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30/j6XveIjdBVJ7JIV4Cgab8QMESVd8u6z1D2E6L96o=;
        b=iSf8P89kQBcMSFUniY9s56Q5MEYNe3QygPu4DrRMYdvH08MfRZUBaw4pE3BJHQtyey
         81bGMMdMKuyaGH0TleQUiTUhEVLMVKPq1Wg6pSmPFSXLUbvKBmkVjWlj7JH4TDiy9szO
         L/ej5dyHtiGaKBfFUK6OcWkXAMBa4qT4BrRJMh1l4mb0T/pB68pUyY5yhvV4kexDUeiT
         bUaaUQpz1k+7t67csRxoUDW4bceHHvRik38Qck4Yt52/3RqCi8EbOKKb3ZPSa0wQ1f1N
         b+thr4vZ7cYY1FMSkhKKV1gd6OBg0ej5x0u6i0QAtfEofn7zGtTljji4DsiMeMyx0xlg
         8OWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30/j6XveIjdBVJ7JIV4Cgab8QMESVd8u6z1D2E6L96o=;
        b=a0w5vtahi0t2picf9XyChB9xCRMXaOEwmGn4nayhiDPCEu8U8JwtSN/spvjkgA1kxu
         rovXqFh9blp1ia6wLlCGbvdti74blqchjpAZEYZTTxXxXLaw4n8A76ZjEa8VGY4a2MOf
         mBnC4HAXql1lmKHCapMGobnKyOwwNR0yWqHNoKEZ774ptnpZg0rpk9yOOP1rFBeYcWch
         KnRtqW6OkDIfewk826E48rUrE9GsK7ixzcq83S98v9SuJN+xVwZIG7EtgwKWywXABom5
         OqSRrh3zubozs7SKhOv7G2HaCi++ly0DHAriGa0dv9MfZxvcGIwj4GQ4iGuCWqfe0/Iv
         t1HA==
X-Gm-Message-State: AO0yUKVNKKnC0bv2EN988OhIJfzXBfYbmrE3KMZzAqYwBPmWPRBKYXQP
        Npv+vxj3oWgvtqy4ACBbneEr5A==
X-Google-Smtp-Source: AK7set+WqIlCuc8N6nBf17Z0hNwjnOGB8DKs7LpYoLKbNA+WhsKZVnVBxQBHut82b2x4bX/Zn0VrVQ==
X-Received: by 2002:a05:600c:4b2f:b0:3dc:53a2:2690 with SMTP id i47-20020a05600c4b2f00b003dc53a22690mr18906870wmp.7.1675691075687;
        Mon, 06 Feb 2023 05:44:35 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o15-20020adfa10f000000b002bddaea7a0bsm9008037wro.57.2023.02.06.05.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 05:44:34 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 22/22] nvmem: stm32: fix OPTEE dependency
Date:   Mon,  6 Feb 2023 13:43:56 +0000
Message-Id: <20230206134356.839737-23-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
References: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
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

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 4d262f69a073..6dec38805041 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -291,8 +291,7 @@ config NVMEM_SPRD_EFUSE
 	  will be called nvmem-sprd-efuse.
 
 config NVMEM_STM32_BSEC_OPTEE_TA
-	bool "STM32MP BSEC OP-TEE TA support for nvmem-stm32-romem driver"
-	depends on OPTEE
+	def_bool NVMEM_STM32_ROMEM && OPTEE
 	help
 	  Say y here to enable the accesses to STM32MP SoC OTPs by the OP-TEE
 	  trusted application STM32MP BSEC.
@@ -303,7 +302,7 @@ config NVMEM_STM32_BSEC_OPTEE_TA
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

