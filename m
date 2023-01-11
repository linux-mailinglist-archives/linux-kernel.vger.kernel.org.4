Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB59D66552A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 08:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjAKHbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 02:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbjAKHbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:31:15 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF78E9;
        Tue, 10 Jan 2023 23:31:13 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id v30so21067456edb.9;
        Tue, 10 Jan 2023 23:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8DBHbw8SRKxIaaEznlgvFtV6o4AQh3C5twMwXmVKndw=;
        b=LKZl3Yl1yaH9pHPcrGazQYIO/+lPuf0TVx5YL6feozCkqA0Y3rsXDrPv7+ShBohCGE
         mav3xeeCzvYfgs7cVqj2k8cDb4fur4tYELCuJfHlTGMbAFF0LCN14a9bLzyiMCsef1WH
         wl7/sxpMWWGKhzMEV2FjqMmAMatKIqDjV8E0Vu9Mx6XHPOglF4ZP83Jt828aQfXaGeDe
         5742PSda/syaQ0PJFDoHuNopxeADoOKLpitq3OAuD84Q8VnMeVrVYn5mUaJsQi0r8vH3
         VNnsVGX3qIbYEuYlTKe3T3xALuE8WUuSFOe6BbP58ExuaMQAAxTpzLNJ+gQwRZLu7qMT
         UQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8DBHbw8SRKxIaaEznlgvFtV6o4AQh3C5twMwXmVKndw=;
        b=JlcBM0AdvVelZFbC2n8sXB3zk4FSzh/JYZaA70zdn8NYJshW91r9qaFvnOofyeg7bD
         KcIjt78k2mPxzYHHz+7Gt5czetlH06LEOweqe3KeqpeHyGFvQU+e2HynbKCgUjuvGYZV
         0plWidupNXE6t2O0DMp1LH/p9uZGuoL1osO4XmV8T/Z5RwwvqWeW8gJ6Y6ZjFm7IKXla
         YaLSA2Kk0s/ylFFlbxflVOxUFX2UC+0mPjghGzk8iQxOoUSs+/nuqtmi0geNEKrI9/lJ
         Vrb4sWb6miu4RxLnbT9sXsvXqvSXKQcSb0T0+G4YRywx2nUF0plbUpDssoLdwa996cut
         XlKA==
X-Gm-Message-State: AFqh2kojWUl+vGKjGRCDb/8zwac3uoFmCrMT47Co0dCwwykFm2DOkMYl
        aeZldikn5N5VlOoz1iHYYhrzIE95QvI=
X-Google-Smtp-Source: AMrXdXsw6vb7Yhx0xIv6eleitRwomvZGl2Ys/JovDBbL5+Orm3lT8EcRZCM5TMZQiwbRXUkftpCrNg==
X-Received: by 2002:a05:6402:456:b0:484:8b49:e117 with SMTP id p22-20020a056402045600b004848b49e117mr50242343edw.3.1673422271823;
        Tue, 10 Jan 2023 23:31:11 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id ed6-20020a056402294600b00499e5659988sm593193edb.68.2023.01.10.23.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 23:31:11 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u-boot@lists.denx.de,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 1/6] nvmem: core: add nvmem_dev_size() helper
Date:   Wed, 11 Jan 2023 08:30:57 +0100
Message-Id: <20230111073102.8147-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This is required by layouts that need to read whole NVMEM space. It
applies to NVMEM devices without hardcoded layout (like U-Boot
environment data block).

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Drop "const" from "const size_t"
---
 drivers/nvmem/core.c           | 13 +++++++++++++
 include/linux/nvmem-consumer.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index d3be50ed2d0b..32f7fb81375a 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -2062,6 +2062,19 @@ void nvmem_del_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries)
 }
 EXPORT_SYMBOL_GPL(nvmem_del_cell_lookups);
 
+/**
+ * nvmem_dev_size() - Get the size of a given nvmem device.
+ *
+ * @nvmem: nvmem device.
+ *
+ * Return: size of the nvmem device.
+ */
+size_t nvmem_dev_size(struct nvmem_device *nvmem)
+{
+	return nvmem->size;
+}
+EXPORT_SYMBOL_GPL(nvmem_dev_size);
+
 /**
  * nvmem_dev_name() - Get the name of a given nvmem device.
  *
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index fa030d93b768..c3005ab6cc4f 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -78,6 +78,7 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
 int nvmem_device_cell_write(struct nvmem_device *nvmem,
 			    struct nvmem_cell_info *info, void *buf);
 
+size_t nvmem_dev_size(struct nvmem_device *nvmem);
 const char *nvmem_dev_name(struct nvmem_device *nvmem);
 
 void nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries,
-- 
2.34.1

