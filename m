Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7193567E2F8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjA0LS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjA0LST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:18:19 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA2B13D42
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:59 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id y1so4679617wru.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nylkfILgKvlTwcBcSR4ZJEvoZ9v4elWH8Nq2L7mAsOo=;
        b=qCd7YMgI533JAgYHWeT5mVBdd8oF5HyGTUwyhc1bBUD0HrOvrt1BByiix5iODd9wX0
         g+leoTIGAEoM2LzRwOPfZHXW48iUWUv2bLhO3lo1Tq0jtuftz69ki/xxQmygCQkvQOgv
         nREs0YFPoUHGrKQro6z2UMLP9Qe4lg5Nm4xt8urN3u44zrkAajwcfPFZsAG4u1R8XyCM
         yct3c1nXqh7VG4IS5rYFja8vsflczMEhu8GE2Nfk4bBstcQex4kNaaALvHTbqogjWrPL
         0vDKu31jvcbukd6TdvSm3vOH6vdEFPrXUURyYJ0WJefaYW+S8oglOGsx+ZbPMhMMI15U
         OM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nylkfILgKvlTwcBcSR4ZJEvoZ9v4elWH8Nq2L7mAsOo=;
        b=dsw5P5x0PH5zHWAS/xOPHzpw7+95nsRMYmC56in66F8zpf3ORlXpWkpz2MLMNgMAwx
         yOFmQxXmBnYiafwKA6nyhzZqB4X/S9YXbNh1HFxIWR8am9mbCWWMqAqp+kZ9wvVoXK8D
         c9DRVGbjjs66KTJ1ueYR+VuTdoVl7nSCVh3vfIy7/gL6toaoJdz8SbrR3olNJZnGPTBz
         Zdv1EWsLfWgmMU116+rLMF8fqg1dS/LvzFW1csf8YUhrcnxNuwxaKXT7l1m05s59QF4j
         3jN4+l4x016jU2v1pmeBjDpxu1L8dZVaoUSDfZkW284ih7xxnTq1e2uv0lb5M/rHBQcn
         SwMw==
X-Gm-Message-State: AO0yUKVNB7rHx5RJcqEyxtCtry0PSCWVHepfmBliVyHZjgRcbEzvwC3i
        1XuCThE7AHQ+YPpflkxRViCIIg==
X-Google-Smtp-Source: AK7set8RBihvGwEVgPF5bXdSgujBX9x6M9V1EJhImlWDzppJxxL21xoI76Tjzj/cA865s7vztejO4g==
X-Received: by 2002:a5d:65c5:0:b0:2bf:c338:8673 with SMTP id e5-20020a5d65c5000000b002bfc3388673mr5625307wrw.41.1674818278015;
        Fri, 27 Jan 2023 03:17:58 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:17:57 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 13/37] nvmem: core: move struct nvmem_cell_info to nvmem-provider.h
Date:   Fri, 27 Jan 2023 11:15:41 +0000
Message-Id: <20230127111605.25958-14-srinivas.kandagatla@linaro.org>
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

From: Michael Walle <michael@walle.cc>

struct nvmem_cell_info is used to describe a cell. Thus this should
really be in the nvmem-provider's header. There are two (unused) nvmem
access methods which use the nvmem_cell_info to describe the cell to be
accesses. One can argue, that they will create a cell before accessing,
thus they are both a provider and a consumer.

struct nvmem_cell_info will get used more and more by nvmem-providers,
don't force them to also include the consumer header, although they are
not.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/linux/nvmem-consumer.h | 10 +---------
 include/linux/nvmem-provider.h | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 980f9c9ac0bc..1f62f7ba71ca 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -18,15 +18,7 @@ struct device_node;
 /* consumer cookie */
 struct nvmem_cell;
 struct nvmem_device;
-
-struct nvmem_cell_info {
-	const char		*name;
-	unsigned int		offset;
-	unsigned int		bytes;
-	unsigned int		bit_offset;
-	unsigned int		nbits;
-	struct device_node	*np;
-};
+struct nvmem_cell_info;
 
 /**
  * struct nvmem_cell_lookup - cell lookup entry
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 55181d837969..a953a3a59535 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -14,7 +14,6 @@
 #include <linux/gpio/consumer.h>
 
 struct nvmem_device;
-struct nvmem_cell_info;
 typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
 				void *val, size_t bytes);
 typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
@@ -47,6 +46,24 @@ struct nvmem_keepout {
 	unsigned char value;
 };
 
+/**
+ * struct nvmem_cell_info - NVMEM cell description
+ * @name:	Name.
+ * @offset:	Offset within the NVMEM device.
+ * @bytes:	Length of the cell.
+ * @bit_offset:	Bit offset if cell is smaller than a byte.
+ * @nbits:	Number of bits.
+ * @np:		Optional device_node pointer.
+ */
+struct nvmem_cell_info {
+	const char		*name;
+	unsigned int		offset;
+	unsigned int		bytes;
+	unsigned int		bit_offset;
+	unsigned int		nbits;
+	struct device_node	*np;
+};
+
 /**
  * struct nvmem_config - NVMEM device configuration
  *
-- 
2.25.1

