Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FAA67E302
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjA0LTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjA0LSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:18:35 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA966C57D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:12 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h16so4628078wrz.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlgQhz1wWZHgj4L9ZFSLZgiqIbO7/bsHrgNAPDxm69g=;
        b=jboH9m4d2F/3Lm40Pzxn6yISbXc8QSet12DjhqQ4Zjavz1umtEfufHhsawbPg6wARS
         tjuNvJ+Jd3Vmir4rUsOPS6phMb23JeHSrPKJ+WvPWJzvg+/qx7a+aHRCAma3XYVy1pdR
         H4p6CD+UxhUG5W2bRJmtBNjpzHJkVmVl/lD2SKVJ8WHBvNgFb85wtUy1EnmBaU2SxQKX
         zkWLKYDkU/0Sb2r9xbCfJEa2imlJAgPC6nISUhNT9NtNAro3AJVBZISkL6v7d9fak0hb
         pqfyWVd7niKnLc2ngIEoDHQpf7ogRrtX8aoE56O/pU8RNtQeBOj3LZE/mCG2ZJLr3yJr
         rDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlgQhz1wWZHgj4L9ZFSLZgiqIbO7/bsHrgNAPDxm69g=;
        b=ncOIduITQv6RT2OdWoVcGXksoZUZuUxGRrIXO5u8N8wcVwtXjyuf/ZvjfSr4SEzKFR
         HzcWvXqsQ7CwVSKzl1L7J1GwyxZ9Eb0AETXeClYJtB1SkpOUizCWy7wQR74h6PjpuQJ5
         /bD5pajlcGcaV6s3jjL46R+YuSFJRM9eX5gz/ir3mv7V0gaq/PcTEkS43tEwp+Dtioin
         03kDToki4QANMlTOrhtpYb9Uc+C0msdlvEwB+maBes+qJHQlVfvqRr7Ijzmo/jS7jFV+
         S6mBO6avIyTJMQzx8BlsM38LQapmZJzf1zndBuVbRo1QRJBjJWY/OZeoUDsZLRV95zQx
         e4nw==
X-Gm-Message-State: AFqh2kqNLTBHTpNYgQMW0Kf5hFkPKLxpvoJn14gWhSsynENIsZYhoeRP
        pcu7yEtt5dPuRi75kra6dfbiBw==
X-Google-Smtp-Source: AMrXdXuXq1j1V78+1Q+GMkF1wY81DUo6H9LnopFNJi5fLBZkbfDbEwdiNJLSGEVmfgpjBNXON0bp6A==
X-Received: by 2002:a5d:65d2:0:b0:2bb:6c04:4598 with SMTP id e18-20020a5d65d2000000b002bb6c044598mr34641539wrw.67.1674818289744;
        Fri, 27 Jan 2023 03:18:09 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:18:09 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 22/37] nvmem: core: provide own priv pointer in post process callback
Date:   Fri, 27 Jan 2023 11:15:50 +0000
Message-Id: <20230127111605.25958-23-srinivas.kandagatla@linaro.org>
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

It doesn't make any more sense to have a opaque pointer set up by the
nvmem device. Usually, the layout isn't associated with a particular
nvmem device. Instead, let the caller who set the post process callback
provide the priv pointer.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 4 +++-
 include/linux/nvmem-provider.h | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ae59d9cb901c..81ad6a4c4f86 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -53,6 +53,7 @@ struct nvmem_cell_entry {
 	int			bit_offset;
 	int			nbits;
 	nvmem_cell_post_process_t read_post_process;
+	void			*priv;
 	struct device_node	*np;
 	struct nvmem_device	*nvmem;
 	struct list_head	node;
@@ -470,6 +471,7 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
 	cell->bytes = info->bytes;
 	cell->name = info->name;
 	cell->read_post_process = info->read_post_process;
+	cell->priv = info->priv;
 
 	cell->bit_offset = info->bit_offset;
 	cell->nbits = info->nbits;
@@ -1550,7 +1552,7 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 		nvmem_shift_read_buffer_in_place(cell, buf);
 
 	if (cell->read_post_process) {
-		rc = cell->read_post_process(nvmem->priv, id, index,
+		rc = cell->read_post_process(cell->priv, id, index,
 					     cell->offset, buf, cell->bytes);
 		if (rc)
 			return rc;
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index d3d7af86a283..0cf9f9490514 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -20,7 +20,8 @@ typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
 				 void *val, size_t bytes);
 /* used for vendor specific post processing of cell data */
 typedef int (*nvmem_cell_post_process_t)(void *priv, const char *id, int index,
-					 unsigned int offset, void *buf, size_t bytes);
+					 unsigned int offset, void *buf,
+					 size_t bytes);
 
 enum nvmem_type {
 	NVMEM_TYPE_UNKNOWN = 0,
@@ -56,6 +57,7 @@ struct nvmem_keepout {
  * @np:		Optional device_node pointer.
  * @read_post_process:	Callback for optional post processing of cell data
  *			on reads.
+ * @priv:	Opaque data passed to the read_post_process hook.
  */
 struct nvmem_cell_info {
 	const char		*name;
@@ -65,6 +67,7 @@ struct nvmem_cell_info {
 	unsigned int		nbits;
 	struct device_node	*np;
 	nvmem_cell_post_process_t read_post_process;
+	void			*priv;
 };
 
 /**
-- 
2.25.1

