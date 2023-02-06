Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFF368BE96
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjBFNpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjBFNou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:44:50 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09CC25968
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:44:24 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id o18so10415756wrj.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nylkfILgKvlTwcBcSR4ZJEvoZ9v4elWH8Nq2L7mAsOo=;
        b=H9jm3OlRYRGTzZCk5lmT7eN8Dp4V/B3kpKpx/RPRsXcSBQgmYNib53ZjvCpH7zbBI0
         xru8bSXstX1DMK+FGJ/gVo4VN3gY7AByQdpzdDUBg/X8PUUa3mWYV1vVad0lSVyeSYiP
         IRA2JRuCFJgagBpaPorgdl7HA1gfp//Zd0Mxsj39fFQm2kenSqSXnK8dDvqajpUDts1p
         Be6yg1EtZtyotzx/0sLSdFhz/hGy2GwY/ylHVaUZkooY4xMLjGypBrraGa5QIya9/Jx0
         rak50zCHrRDUOVpI4dsAGxtpQ31X5ibG9kYmz+hhmypKv1y0vxoOOzqYhMYQ+l/WcH1H
         YOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nylkfILgKvlTwcBcSR4ZJEvoZ9v4elWH8Nq2L7mAsOo=;
        b=J8QbkLqiRbs2g8FrAtVtr2i/hCgB3OwWFN1CIgC9DeslJeqjqsHucilgBP0EvoPThp
         9+85oaOK2w5NtGQEhSgwMOGZFcpTOxaeMc80vaLjLTJJLeY04eJkav9vuorz8d9HAWDJ
         MWzTXxLumRI0tt/geaJEcYQkJCkFAtyATkXuLXi+Fn2Aqc85OP1ClfJps8ueiKKweCDs
         BR9BzA8DyLI3uSxUaHnpMHdufWIxyhFI64SrZX4aBUxKB93rvJBWC+AwYofXuhrqkEwE
         JwISE/zLRfAsruYXxmUFjpwz2Nk1jEratBsEuWrxHRVQ4ezEMnguYsT3+iFLv0YC9esN
         mUyg==
X-Gm-Message-State: AO0yUKVZuV8b+wNDfxKWnaaY91YVKCtyC8ibugW0GYiEBs499XTHweQ9
        vPVui3OrMK3uasn0+DPQ1FZ/vw==
X-Google-Smtp-Source: AK7set/eLRoPVamcMK9GHV0XwfA2TzVYpn7HeUW2QmFhOFNzizAv6sQQcLjlxCkzfe0inbNZJDQ0KA==
X-Received: by 2002:adf:c70b:0:b0:2bf:b5c0:f157 with SMTP id k11-20020adfc70b000000b002bfb5c0f157mr18499613wrg.39.1675691062482;
        Mon, 06 Feb 2023 05:44:22 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o15-20020adfa10f000000b002bddaea7a0bsm9008037wro.57.2023.02.06.05.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 05:44:21 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 13/22] nvmem: core: move struct nvmem_cell_info to nvmem-provider.h
Date:   Mon,  6 Feb 2023 13:43:47 +0000
Message-Id: <20230206134356.839737-14-srinivas.kandagatla@linaro.org>
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

