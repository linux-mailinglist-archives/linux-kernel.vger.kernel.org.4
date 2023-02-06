Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCBA68BA24
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjBFK2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjBFK2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:28:33 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E3D1F5F7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:31 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id q8so8282449wmo.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nylkfILgKvlTwcBcSR4ZJEvoZ9v4elWH8Nq2L7mAsOo=;
        b=H+8wDGn6MwsJtorhe1b+KfobkWQ3JGlvl29JCF90CHFiNinpa+46Rj5HEIHW7HtO//
         vNX7iZermzGFKa4es1GinCckVqmrLOAySnJENWd0jkFnGAW3BPTlUqhatkDwekXtRVAQ
         c5DTb3AEy9h5/5xYm3kZBHbs5ZD+7d3Z8Xtts6BtWPAhKNLGaK0onVXlbENQE1dreML9
         uN13ne2aVlE4RngNaBk1PpTAGWDi89jzO7Tc0ybLE2tKHu/OiQFfwd2L2oMfaXaka0el
         S8+4p6GonpQj8gV+V+ri4+0zW+CNg2udzQkChDD1iaFqjZIuXJ8E243m9inKTLNPLjcq
         r5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nylkfILgKvlTwcBcSR4ZJEvoZ9v4elWH8Nq2L7mAsOo=;
        b=ove2klrhUIRjTvGzxOdBIaLE/nnDrj09VZR748H9eDOPs7GDeJ0uf9sGYrWZlPWfQX
         pMqnMALamL5JlcDM42umoir6GIXkLR1Kq8R/skR6JQiOADN8OvyS13p/4ewnKNvDlWtv
         507F3uEg/oSwFOLlJY/7PMNAhJwzL3SpivdWnqJtNkq4Vh1HMlBCn4jdry+uBhrCqltR
         EPooVZnK6Np8CEF7h0V4bqqmuSTr/wjyTedp4+l4lLx2SM0O7rDmmtOmUkkuJrdeWNet
         ThhLzkK8cemHi+/QN9KW3nS9ecv45TTCq9HuB5ROUSUkTrpEHY7euowgo396DBAeFNUv
         q85Q==
X-Gm-Message-State: AO0yUKWs1p9+qsul41is27bFITEtnCs4i+oJVGDg3ZcYrHYZ07TmYdMd
        AZgFz6GEH9cUj+9z37QeOXMDHA==
X-Google-Smtp-Source: AK7set+umTGOJRDhELbFIDMf0pl8JAvB02wJpVkIdr1emtiaE4hiCdHMQi532k0MeAHd4z/GZEtixQ==
X-Received: by 2002:a05:600c:35ca:b0:3df:f7cc:4da2 with SMTP id r10-20020a05600c35ca00b003dff7cc4da2mr6317627wmq.16.1675679309879;
        Mon, 06 Feb 2023 02:28:29 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:29 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 13/37] nvmem: core: move struct nvmem_cell_info to nvmem-provider.h
Date:   Mon,  6 Feb 2023 10:27:35 +0000
Message-Id: <20230206102759.669838-14-srinivas.kandagatla@linaro.org>
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

