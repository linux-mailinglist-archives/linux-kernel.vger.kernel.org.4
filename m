Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B226D94B6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbjDFLJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236833AbjDFLI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:08:58 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7065972A0;
        Thu,  6 Apr 2023 04:08:57 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id q16so50299830lfe.10;
        Thu, 06 Apr 2023 04:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680779336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfYMOG8gPlyg4Z3cWn2F4o0SjxhHFN6Ihcum8cR5Xlk=;
        b=p6OqGU8gW0fCJlDL00V8f51dUiscXEsiSaD5vmQO1isPXkmvIh9KT8CDihdJexXbVQ
         q3tgHgG4DpF06psRjl2A0IwVsn7JX5nomaufOSyqRqwv5ek93yeBNotwx9a7jv2Hx3jX
         huraJ/iQLlQk0axSQbJnfik5t4ssW1sNuwAp2CLylhKbUT1vphXZg7hswQOtf6gru7og
         GYKjDGlUc94LMNNxr2vHX0t+Yyy/c0JvLlFUDELjqewTug0YBn0HwusAej3sAMJBsd0/
         dSR0LlkVSh/BpSwUfX0PVU1Q562PEQvh67dmT7x5Sp4gYIPmyP5w/qIVOiReOYL5Wmcq
         sa8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680779336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfYMOG8gPlyg4Z3cWn2F4o0SjxhHFN6Ihcum8cR5Xlk=;
        b=THv+dHDKSfSCDa7U0gg4XWKkMSG9ZRwx4UvabVKHgStwonZ3Ztf/OqSkD8yJsr/wnL
         GLdeVu3txYMuu5hKUD50tDAcv36mF6JMCcZ8r6CQAuUhLAnlrYaeJPeuDHTxUnIrAVzk
         k0ITwsksPt/OfNG+rw1efED+7IAOQiErKR7IqsaJPvp8OxDOL7Uqkl0fKD8DDyHpVvtJ
         UNhMxgxPKtO5l1cHkY7EMAWD0PgzkOCL9dk4MXJ0aQrsiPM5yBZBPeCzYDf4dT+E87MN
         xdkHh1zZkvxXgA9HSYg2IZDgmXDQ9Qnxt6Fu+jx8k66paPZg1K5dQA1+p3/Ok1PVpLOY
         CCtA==
X-Gm-Message-State: AAQBX9c85SoSruYp+UX1DNjHPywCUwTNMsfG1SwJCx6uFuLnUE78AzNV
        snee8pYm59HBuMiF9UMbfYw=
X-Google-Smtp-Source: AKy350bEbAhBNNx9rxCddQ6y4IbOjg+2Hy5K6Gk/hqrMHBDrixOMNKnmkaniICT90Ogxfil+NedGuA==
X-Received: by 2002:ac2:4a63:0:b0:4ea:e262:e551 with SMTP id q3-20020ac24a63000000b004eae262e551mr2417608lfp.31.1680779335666;
        Thu, 06 Apr 2023 04:08:55 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id r26-20020ac252ba000000b004e048852377sm218667lfm.263.2023.04.06.04.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 04:08:55 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/3] nvmem: brcm_nvram: add .read_post_process() for MACs
Date:   Thu,  6 Apr 2023 13:08:03 +0200
Message-Id: <20230406110804.12024-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406110804.12024-1-zajec5@gmail.com>
References: <20230406110804.12024-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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
2.34.1

