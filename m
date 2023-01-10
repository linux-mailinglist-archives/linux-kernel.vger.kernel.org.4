Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9A1663EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjAJKy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238165AbjAJKyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:54:43 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E8A6AD83;
        Tue, 10 Jan 2023 02:54:35 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m21so16943251edc.3;
        Tue, 10 Jan 2023 02:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kx33osG0iIsA/kyalJIybKATyfWaMXF9jLXNGZKLKMc=;
        b=k5eMydzOQ4SSz/enP/AZgMBTxZ3wxzbr4iy9HH74X9Wo7sH3oUW9IyrLVrLK2cf2wc
         zuSWFUOsT12RRRHg2LOo6wi1bQWeWdvi08ypPH0suPvYe+xYM9RWrc9BzUB71YgF9fOi
         Lq4HPmCy2nRPI+/kCyS8sG1WqgxIDuZeE73JQL4ny4jhpXP8KdtjHNyQJoRZLH10FQK4
         WIgKcEIu5m3iYn1NQzZ2p92sCfpp+3ZnGYc8JsWpiSeWKlNP9jjHsaKIPHrS0XxWtJih
         4BKng+Gsh8KOWVcY5YCvwpbZpxPJRWVEahK0ERsB1omXnGLj0ABvGnNNWA7a6XhI0p8n
         d87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kx33osG0iIsA/kyalJIybKATyfWaMXF9jLXNGZKLKMc=;
        b=ndTdg9m9T56og+/86OnZwo65SC/dsfq6AJ9WAcXcI7g3rmnEroW7fERgMnI0EbuAK3
         jBhUOTYvA6dXSJ/lBzk5CuzivMEPTUdhprkSwXKCVFEP3TKBe6JSDET5GGR8d8krJPWM
         b4OM/bUh64SQka/EugjizCIGyBQaq0q2MBkajxTnOyV4/WxjieSHWMPVsezl6JAmsw+f
         O0zd2xH+KfJDhEpkGVpPoxPQ5+awv5ABWrIDuloA4tbAQsOecOlWENWe85OqZCPsPt6D
         T8b3u9zQfJzuwdV3Z4r77dbQ2DVNc14LdSkHpZz6JValBTznkv0bBh3rtwRFfD57gkJv
         ZYMw==
X-Gm-Message-State: AFqh2kpNd/1qXkzSa+k4hmD1E1iKWp/N5px83ctCG6EArHvL7xiIXr77
        Uf9QcdgMkto9a9qDsruFOq8=
X-Google-Smtp-Source: AMrXdXujTDH9bun7NJvAXIkJISNElTOLLlrnMwl8tuomQ5TWs/s0LVewdaaY9i/gr94QXtYBCFBFJQ==
X-Received: by 2002:a05:6402:2685:b0:493:b55d:d7f2 with SMTP id w5-20020a056402268500b00493b55dd7f2mr24287133edd.14.1673348074366;
        Tue, 10 Jan 2023 02:54:34 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id s1-20020aa7c541000000b00495c3573b36sm4818199edr.32.2023.01.10.02.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 02:54:33 -0800 (PST)
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
Subject: [PATCH 1/6] nvmem: core: add nvmem_dev_size() helper
Date:   Tue, 10 Jan 2023 11:54:20 +0100
Message-Id: <20230110105425.13188-1-zajec5@gmail.com>
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
 drivers/nvmem/core.c           | 13 +++++++++++++
 include/linux/nvmem-consumer.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 1f05f0a50d86..81743ae8793b 100644
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
+const size_t nvmem_dev_size(struct nvmem_device *nvmem)
+{
+	return nvmem->size;
+}
+EXPORT_SYMBOL_GPL(nvmem_dev_size);
+
 /**
  * nvmem_dev_name() - Get the name of a given nvmem device.
  *
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index fa030d93b768..d88294ddf562 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -78,6 +78,7 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
 int nvmem_device_cell_write(struct nvmem_device *nvmem,
 			    struct nvmem_cell_info *info, void *buf);
 
+const size_t nvmem_dev_size(struct nvmem_device *nvmem);
 const char *nvmem_dev_name(struct nvmem_device *nvmem);
 
 void nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries,
-- 
2.34.1

