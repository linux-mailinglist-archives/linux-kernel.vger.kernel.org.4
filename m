Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601D768BA29
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjBFK3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjBFK2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:28:42 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F2D22038
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:37 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n13so8281652wmr.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1rofkASwOxqgmxowzyZ3fLwYQAi8p7kZIwCpQKFbL8=;
        b=ZDsI0S6LSv35qlLWy0gxYEEUwY/hD8wVbzkM8O36zG72K9N+E2qILqBhgyL3w/QbJz
         IpDMJyB3zo3j4l+dzJlZAJH83tjWMCtgCE41nFW4y4HVTlwXz079rI4DRCrXXpGpWjAq
         ucT3Rv1FKpvvpej/IMLCUe8yW3XGZ58UqYWrzDTUxFaqB5uNWg840d9qTdKMa73YkZhS
         Q1PRnZza7SfJOVFZhUzGEbWefJdtJbN8Vk64rLLI5MmwzkoksbPdAKoS4RACkL7kEtwt
         RfQG4sFk3jfMh1g2KXUe0MVNpTH8G3udFRpScepd/CbiTg6jq6vhGZ+49upNe18BMn2y
         NaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1rofkASwOxqgmxowzyZ3fLwYQAi8p7kZIwCpQKFbL8=;
        b=x9HZ9uIoI8khJxvzpFzGWOBNWQb1S8iXwr2xpaZFOUt7+4+kq0KpD56C4G+8JkQIjD
         6Q2wcgI6aDrr4YMkU+LHVljeBDYpvQTpQDmAKOS5qPiHYJJM6vK9O+Eswg2MjqradsjF
         gpD1wB/cx7RtGcOTBbGjXT4u0+lLd48fqXrLuB7CcgRLHOiYYVcbfWzSI1uJaa0MaC2L
         0dIGQYdFaiSXwrm25sEB5Cmuv9pMqG6m+ajYwgyjSlxm9HWE8nwoLJ/uE9x33wSnLAQ7
         KkYWF1GYe8T+ESc/+5a6qPmbsVFAOnGu14A4fObtE5EHFrsYdnaN20dIb0FPsHbdnWtS
         Sk/g==
X-Gm-Message-State: AO0yUKUzPlTBVHyVMHacs0t+zt1BVh/KC6CJXToRPzju60sm65oUgp6B
        YH/t/vGI2CgYVXh7cvONU2j88w==
X-Google-Smtp-Source: AK7set8Vf2s3nMMbOf48JFVjmUNh94vRr+7sEXvJcrhbNzMfsgWX94JE7nmJYtVw59iUwZxrwNNYdg==
X-Received: by 2002:a05:600c:358a:b0:3db:5f1:53a5 with SMTP id p10-20020a05600c358a00b003db05f153a5mr20756860wmq.20.1675679317487;
        Mon, 06 Feb 2023 02:28:37 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:36 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 19/37] nvmem: core: allow to modify a cell before adding it
Date:   Mon,  6 Feb 2023 10:27:41 +0000
Message-Id: <20230206102759.669838-20-srinivas.kandagatla@linaro.org>
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

Provide a way to modify a cell before it will get added. This is useful
to attach a custom post processing hook via a layout.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 4 ++++
 include/linux/nvmem-provider.h | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 80051726b064..216a8eb01d00 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -694,6 +694,7 @@ static int nvmem_validate_keepouts(struct nvmem_device *nvmem)
 
 static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 {
+	struct nvmem_layout *layout = nvmem->layout;
 	struct device *dev = &nvmem->dev;
 	struct device_node *child;
 	const __be32 *addr;
@@ -723,6 +724,9 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 
 		info.np = of_node_get(child);
 
+		if (layout && layout->fixup_cell_info)
+			layout->fixup_cell_info(nvmem, layout, &info);
+
 		ret = nvmem_add_one_cell(nvmem, &info);
 		kfree(info.name);
 		if (ret) {
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 3bfc23553a9e..be81cc88eabc 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -155,6 +155,8 @@ struct nvmem_cell_table {
  * @add_cells:		Will be called if a nvmem device is found which
  *			has this layout. The function will add layout
  *			specific cells with nvmem_add_one_cell().
+ * @fixup_cell_info:	Will be called before a cell is added. Can be
+ *			used to modify the nvmem_cell_info.
  * @owner:		Pointer to struct module.
  * @node:		List node.
  *
@@ -168,6 +170,9 @@ struct nvmem_layout {
 	const struct of_device_id *of_match_table;
 	int (*add_cells)(struct device *dev, struct nvmem_device *nvmem,
 			 struct nvmem_layout *layout);
+	void (*fixup_cell_info)(struct nvmem_device *nvmem,
+				struct nvmem_layout *layout,
+				struct nvmem_cell_info *cell);
 
 	/* private */
 	struct module *owner;
-- 
2.25.1

