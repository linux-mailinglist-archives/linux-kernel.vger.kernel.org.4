Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C0467E5D9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjA0M5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjA0M5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:57:20 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0380720068;
        Fri, 27 Jan 2023 04:57:19 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x10so4631865edd.10;
        Fri, 27 Jan 2023 04:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WSGMh7tRNAaLj5yI1m4PdJqLgl2acNMOyBtFtlK7OZk=;
        b=QwChc0PKt4BnWFjr/KdVghPRZqy3T2yTdWM7BYwvCzsYOHWWkhWqkuBK/CKWB+hiuR
         74a55Kfc/aa1z76rQBd6a9a0PK2/7SXelwmC88ai1mm/2KEqZNxjUIftDMrUj15rWPo+
         J5EohSEHtCCOJfLHHgQszp62I/bCTWMR5llQP9DpchNEnIClDFjE1uJWxxVRi7MgBJCm
         Q01Subftos9N9h14/ntJjV9G97HO/g0kS3Mx3jWzMRjtIacVz4V43rfM96IPR+d/KrNO
         Gnc7HsmPRFgujE0Tt/hUyGW/XQepQHsoQZEs1sooSM59OtGkpcXc46d42bUi7YzLvfnk
         NbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSGMh7tRNAaLj5yI1m4PdJqLgl2acNMOyBtFtlK7OZk=;
        b=6gWJPI8bczBC91uGsX6+7ilJu9qzC9FlifdTsCFUihAUt5qbqDxSVnO8UjjXt4d+Z7
         BRe5qQpLSP3IxioMVUse4CBbUl/u+hGqBmG17pu13d2CZlS5+IqW7Qr1N/Q1IEl5tQhm
         O20Apxbz+kXsL6yH+uC9pmepUK3C8X6UldAdE2u4BhBGD4+BWRUO8lvtEPuD7SDiXROG
         OZt447eQ7mehw9H9zaFriJlDxn7GJTDORxKdICqs97CUDgtgDr82+i5RGLbm5T8HUJEQ
         8XMsBtUhGTxchuERLa86jgGQ7jmTghcjJzReqMk8SEXSIgh1rLISoQxa78EYb+/JUkbn
         p2sg==
X-Gm-Message-State: AO0yUKXCbIYundQAxL8po3sxdxwtkkwoI+JyC5aOs6fQj8VwGvH8PjXn
        sriVME0A3xyK5LrbetORi1X/BwsVcQc=
X-Google-Smtp-Source: AK7set9fiieDJvoI0cIIXqfh2KwwgHZ/FqCug9cxZlmhbl+skSmKi2RvQL5akuVkh2MI4nIWsO2p5w==
X-Received: by 2002:a05:6402:298c:b0:49f:a3d7:b84d with SMTP id eq12-20020a056402298c00b0049fa3d7b84dmr16189411edb.34.1674824237029;
        Fri, 27 Jan 2023 04:57:17 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id y5-20020a056402358500b00482e0c55e2bsm2248136edc.93.2023.01.27.04.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 04:57:16 -0800 (PST)
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
Subject: [PATCH V3 1/6] nvmem: core: add nvmem_dev_size() helper
Date:   Fri, 27 Jan 2023 13:57:04 +0100
Message-Id: <20230127125709.32191-1-zajec5@gmail.com>
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
index 38a5728bc65c..9e77af0164aa 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -2063,6 +2063,19 @@ void nvmem_del_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries)
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

