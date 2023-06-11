Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C3B72B229
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjFKOED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjFKODv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:03:51 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F229CE77
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:03:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f70fc4682aso24017935e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492228; x=1689084228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGrbdlHRBEYsKz5RMYlb0xpi4rIRjCjmXS8VS4uzx8Y=;
        b=o8z+wNs0iEr7/TgZmIYH5V32Lr0bdhn4ARwqDtLO3ALnazR8Vyz5Q0yKaTn8x2WbRe
         t4jEvZNDnAewAjYidSAmmJ368aCHf56OjLnr3XxMqsfoPfjtsMqoNKHDvo1fBCtAX9Lf
         icrfgoM+hCzf/JGCe9weaugRzVREeauXbdS28fOm2kj0KXb/dGoluleBlgWf6TyjNW6S
         mSdNXK1pyAqDI4yjWLhkrPJ6rh6L7skh/xJLg4dbn5MKDyxEhNLWCQ3LooYx93Nvtia9
         +TQG+jCXJPH7FC9cW8R6mIY8h9N/vQ35HGjN69Ol2Jx2Un50Tus1hs+Bo7hXZ6a5eeZ8
         JE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492228; x=1689084228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGrbdlHRBEYsKz5RMYlb0xpi4rIRjCjmXS8VS4uzx8Y=;
        b=FR+SQYCoNanVtSRc9UNkeE6ZupR/sg6J6tGBHk696CbDovhmdtBNz9m1UybgkI5HCp
         EXsgq+kXqRqT6HD1YJq94ooyDUjaWizm1RKKmh9132goZKgCXpYNuhtFTK12P8wcJky2
         /LNhzOVUcA4X4ZqTdjwtnG3zN8ZkglaqHIjsrZ1qwmCrUMz8Prv/UcAj0VErnOiTr48k
         xj2mu5jUEMMkD1jEvtr4pl0r4tLcYmTHovF8kTLA4zttt9MrwqtRfIRTIdZ9k4siH3wq
         izOS6kahIoAdwqfLtPkWCWmaoZmnYukP9WiyNYbIDjbt/u8I2PjM53N2bpLiEuVaeVeH
         lFag==
X-Gm-Message-State: AC+VfDwISxaX6i2++cqx0fCXba9tfOGnE6UuIGMwjlmFyCF3QFim09MY
        xQRwGpsEiGQ6iZX2kKoTP6/QVg==
X-Google-Smtp-Source: ACHHUZ5SJfLPwyBdHhNRhwksbTe6w/wcRP+7xON5bXsdDcqHaOWa5pkuWmqN28YYYDOX6o3Fjc0dcw==
X-Received: by 2002:a7b:cc83:0:b0:3f6:13f5:d1ea with SMTP id p3-20020a7bcc83000000b003f613f5d1eamr4124351wma.11.1686492228301;
        Sun, 11 Jun 2023 07:03:48 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:03:47 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/26] nvmem: brcm_nvram: add .read_post_process() for MACs
Date:   Sun, 11 Jun 2023 15:03:08 +0100
Message-Id: <20230611140330.154222-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
References: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

1. Parse ASCII MAC format into byte based
2. Calculate relative addresses based on index argument

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig      |  1 +
 drivers/nvmem/brcm_nvram.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index b291b27048c7..688b70ba4826 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -55,6 +55,7 @@ config NVMEM_BRCM_NVRAM
 	tristate "Broadcom's NVRAM support"
 	depends on ARCH_BCM_5301X || COMPILE_TEST
 	depends on HAS_IOMEM
+	select GENERIC_NET_UTILS
 	help
 	  This driver provides support for Broadcom's NVRAM that can be accessed
 	  using I/O mapping.
diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index 39aa27942f28..4567c597c87f 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -4,6 +4,8 @@
  */
 
 #include <linux/bcm47xx_nvram.h>
+#include <linux/etherdevice.h>
+#include <linux/if_ether.h>
 #include <linux/io.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -42,6 +44,25 @@ static int brcm_nvram_read(void *context, unsigned int offset, void *val,
 	return 0;
 }
 
+static int brcm_nvram_read_post_process_macaddr(void *context, const char *id, int index,
+						unsigned int offset, void *buf, size_t bytes)
+{
+	u8 mac[ETH_ALEN];
+
+	if (bytes != 3 * ETH_ALEN - 1)
+		return -EINVAL;
+
+	if (!mac_pton(buf, mac))
+		return -EINVAL;
+
+	if (index)
+		eth_addr_add(mac, index);
+
+	ether_addr_copy(buf, mac);
+
+	return 0;
+}
+
 static int brcm_nvram_add_cells(struct brcm_nvram *priv, uint8_t *data,
 				size_t len)
 {
@@ -75,6 +96,13 @@ static int brcm_nvram_add_cells(struct brcm_nvram *priv, uint8_t *data,
 		priv->cells[idx].offset = value - (char *)data;
 		priv->cells[idx].bytes = strlen(value);
 		priv->cells[idx].np = of_get_child_by_name(dev->of_node, priv->cells[idx].name);
+		if (!strcmp(var, "et0macaddr") ||
+		    !strcmp(var, "et1macaddr") ||
+		    !strcmp(var, "et2macaddr")) {
+			priv->cells[idx].raw_len = strlen(value);
+			priv->cells[idx].bytes = ETH_ALEN;
+			priv->cells[idx].read_post_process = brcm_nvram_read_post_process_macaddr;
+		}
 	}
 
 	return 0;
-- 
2.25.1

