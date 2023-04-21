Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59AC6EA627
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjDUIoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjDUIn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:43:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE8DAD25;
        Fri, 21 Apr 2023 01:43:31 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4ec8399e963so1426128e87.1;
        Fri, 21 Apr 2023 01:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682066602; x=1684658602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfYMOG8gPlyg4Z3cWn2F4o0SjxhHFN6Ihcum8cR5Xlk=;
        b=a+41VRsBYTq/V/MhxS4NncMUAaeaB+X7nipm5u7gcYrjjGhOf20sOA3+NqCjD7GWjS
         COQujy7krMnzNLKyYCGK8t5TfWwsCHzsucl05eZxHbpgLBCeg7b4+5K3bc8rfjgcI+Ne
         bs6ICN/bPGr1VRm8xsNBy/4/uUy40ITOsRLY97wBb1SO3V/zs5Sf9ZuTiN4H6fWTyt2o
         8C0GoLdN8d3s0EDjpjU9/L0v54kLzSptqJJB51KWJX+grW2HyUgWIojifEerJsNRHsp1
         kgD8iky9NeMRrq5E/HmvrILuhoZB5hmyXQ9A6nlB/6ZbNa0f400kcc3mr4TcVVa7i1Cj
         BOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682066602; x=1684658602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfYMOG8gPlyg4Z3cWn2F4o0SjxhHFN6Ihcum8cR5Xlk=;
        b=ekKzxjBrDHXYJvKpbUedF0Bxs1CZSeTAWmmodjhr7dHY3+y/vZgzrj8zITH8acu/sl
         wRklj5aCD3MinqO8jnZdKaOlJdrotMAyrLWhdJBh5sfUSshoS0CECvUdvT6FJ5qwShm2
         1lp2P0ZxQFkc1avQ5mQtvYvzfFsfAMqWB/Z+aqHphIVHud58qQiWbl7uj9FhnuZC6xhK
         zWshgBTxSuxQ804dXgIVx5PQkcqHgZiSO4m+Ua02ZCEZ4g3xUeFNJ3WkSxVVNFWu+Ux/
         UbZIud8BNEWKzjHQ8HU/fptNnGl99AZG+dW+4u9amj18e36LGp8ISPGddkMh6Gv09hCz
         ZwOQ==
X-Gm-Message-State: AAQBX9d0neD4hCvMMVdrPbVXfi5ccUgf93qcH7z/rEoHMH92p9wArtd/
        JUBkUsZiZZ4EvEJh9xtR2XY=
X-Google-Smtp-Source: AKy350ah6s/GHGWSiKmHFzEyCAr9Dac0vpwQM2CEfN9P6MLOH0UyDwlWNTmr7FY3MEzznuGyXjpKXQ==
X-Received: by 2002:ac2:4e52:0:b0:4ea:fac4:8ef2 with SMTP id f18-20020ac24e52000000b004eafac48ef2mr910330lfr.64.1682066601602;
        Fri, 21 Apr 2023 01:43:21 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id l16-20020ac25550000000b004edc16dbdfasm480721lfk.119.2023.04.21.01.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 01:43:21 -0700 (PDT)
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
Subject: [PATCH V2 2/3] nvmem: brcm_nvram: add .read_post_process() for MACs
Date:   Fri, 21 Apr 2023 10:43:11 +0200
Message-Id: <20230421084312.27932-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230421084312.27932-1-zajec5@gmail.com>
References: <20230421084312.27932-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

