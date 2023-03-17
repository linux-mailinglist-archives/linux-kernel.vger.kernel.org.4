Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0246BEA13
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 14:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjCQN1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 09:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjCQN0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 09:26:35 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707BC212A9;
        Fri, 17 Mar 2023 06:26:33 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a32so5086148ljq.1;
        Fri, 17 Mar 2023 06:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679059591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWn5xXqBj6yi7+enhvrMvqUOn19onL6aIZYPMgopTDA=;
        b=Oj6V2PCimtWlltVB2+AyFA1DqnZAojZU3hVO2883M9Gp4gxHeUoLkTJIcSNHxDLpnS
         +V2rJzbGJIXMypWrzFzx11lP5YcG3JXQkl65RP/xA5SpyyWkBNUBg8XvYTq2ZQB3PgrP
         Ub2UPWw5+Rh0fEBXxHgYIXaaKvW+lhF9Hjrm1SvygV+S142+xLo32OcjNbd0eLaijbrl
         gww3P9tPf31sti0nHRjO4cS73bpT80qIP4Yhg6ewks6JiqUg+PMzNJDdFtDogoFZwqV6
         olTf0h+K9vLYDVCJvLZiWBLsC5wVdNm0NwizJSbn90QCcMQ7S+lK8wHcKJjBvvm3YHSp
         Je+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679059591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWn5xXqBj6yi7+enhvrMvqUOn19onL6aIZYPMgopTDA=;
        b=D1qkZKxS7/Tmn+xoJ+5nr47S7YUTu4hpyE2AHpPUg6p0Ew5F29UnIbWlsU03O284Cc
         yQdswzBRP8xHaU84e/qkmHzONdpqrfmz60Q97f9NMmfS9Ai4PBiIoge4RfgKXgIxa885
         WpmEoh/RinMWMtK17O6I3GQdrvwtzDkK/d/h77ij/90P/pRXj09Iv+LsV53dUxl5nOmm
         lWVKLPjnZbY1YustyeKbvm+qaMWipVJkC/kGAyLIB3rxcAu1DRCc+SFLe23mnHkvspM1
         RVvoReunxjEgwn7HXAfcBAqahUcPD932VE3jPxJqo3Xo7MoZqNMS1oN4m5qJkveL5KWb
         NAwg==
X-Gm-Message-State: AO0yUKWFq8x5wO1oaIS2xIgVrxJ3LwDeO1JVsW4OkOfT6McYWoOcmyv2
        gHtGC6458KcNgumlzy0WnBA=
X-Google-Smtp-Source: AK7set/00kAGhBMpoTNzaud5U11pLUBia2K1nAvT4IMnIwPHtiX8OmDHOOjTpanu7a9MGrLSIXN/NQ==
X-Received: by 2002:a2e:97da:0:b0:298:3a2d:4363 with SMTP id m26-20020a2e97da000000b002983a2d4363mr3725806ljj.5.1679059591810;
        Fri, 17 Mar 2023 06:26:31 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id p15-20020a2e740f000000b00295b588d21dsm411083ljc.49.2023.03.17.06.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 06:26:31 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V4 4/4] nvmem: layouts: add fixed cells layout
Date:   Fri, 17 Mar 2023 14:26:20 +0100
Message-Id: <20230317132620.31142-5-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230317132620.31142-1-zajec5@gmail.com>
References: <20230317132620.31142-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This adds a driver for the "fixed-layout" NVMEM layout binding. It
allows defining NVMEM cells in a layout DT node named "nvmem-layout".

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/layouts/Kconfig  |  8 +++++++
 drivers/nvmem/layouts/Makefile |  1 +
 drivers/nvmem/layouts/fixed.c  | 41 ++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)
 create mode 100644 drivers/nvmem/layouts/fixed.c

diff --git a/drivers/nvmem/layouts/Kconfig b/drivers/nvmem/layouts/Kconfig
index 7ff1ee1c1f05..2ebbde7b15b2 100644
--- a/drivers/nvmem/layouts/Kconfig
+++ b/drivers/nvmem/layouts/Kconfig
@@ -2,6 +2,14 @@
 
 menu "Layout Types"
 
+config NVMEM_LAYOUT_FIXED
+	tristate "Fixed cells layout support"
+	help
+	  Say Y here if you want to support layout with fixed cells (hardcoded
+	  offsets and sizes).
+
+	  If unsure, say N.
+
 config NVMEM_LAYOUT_SL28_VPD
 	tristate "Kontron sl28 VPD layout support"
 	select CRC8
diff --git a/drivers/nvmem/layouts/Makefile b/drivers/nvmem/layouts/Makefile
index 2974bd7d33ed..449dd893f968 100644
--- a/drivers/nvmem/layouts/Makefile
+++ b/drivers/nvmem/layouts/Makefile
@@ -3,5 +3,6 @@
 # Makefile for nvmem layouts.
 #
 
+obj-$(CONFIG_NVMEM_LAYOUT_FIXED) += fixed.o
 obj-$(CONFIG_NVMEM_LAYOUT_SL28_VPD) += sl28vpd.o
 obj-$(CONFIG_NVMEM_LAYOUT_ONIE_TLV) += onie-tlv.o
diff --git a/drivers/nvmem/layouts/fixed.c b/drivers/nvmem/layouts/fixed.c
new file mode 100644
index 000000000000..b8d2f141d272
--- /dev/null
+++ b/drivers/nvmem/layouts/fixed.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+
+static int fixed_add_cells(struct device *dev, struct nvmem_device *nvmem,
+			   struct nvmem_layout *layout)
+{
+	struct device_node *layout_np;
+	int err;
+
+	layout_np = of_nvmem_layout_get_container(nvmem);
+	if (!layout_np)
+		return -ENOENT;
+
+	err = nvmem_add_cells_from_of(nvmem, layout_np);
+
+	of_node_put(layout_np);
+
+	return err;
+}
+
+static const struct of_device_id fixed_of_match_table[] = {
+	{ .compatible = "fixed-layout" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, fixed_of_match_table);
+
+struct nvmem_layout fixed_nvmem_layout = {
+	.name = "fixed-layout",
+	.of_match_table = fixed_of_match_table,
+	.add_cells = fixed_add_cells,
+};
+
+module_nvmem_layout_driver(fixed_nvmem_layout);
+
+MODULE_AUTHOR("Rafał Miłecki");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, fixed_of_match_table);
-- 
2.34.1

