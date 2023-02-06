Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C2268BA2C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjBFK3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjBFK3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:29:24 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED67222FD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:43 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id f23-20020a05600c491700b003dff4480a17so2165497wmp.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlgQhz1wWZHgj4L9ZFSLZgiqIbO7/bsHrgNAPDxm69g=;
        b=uEOtCxamU2FEeYztMe6sLSIfwGm16K9OJnqFJY3ILzBo3xoTlgSPuaDm6a/a4YegsF
         a527CSzq54KGgEP3SaIwchbMOIcuEh/+6qXCNDg7/Xvg2RMaHI5rYqOtOj6Vt2h4zDOl
         z2+wReloMKAGeFv2VuI8Tr2XVfThDxzQGAVPmqtp2axu8J+48DsOHsRqJjt5rRfDnVp1
         CFXIz1SUAzmTAwUIc5vYtSjcjIoBUsnjTY3OqWw3Oxs5ovssTDtdjz2bfyVxGKjd66VB
         U2BUEBW36qjWx9aK9+4K569LDq/tQvx82Q2ikb9rrac5hA2cjopo57ThHPygmB92wFt1
         Znew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlgQhz1wWZHgj4L9ZFSLZgiqIbO7/bsHrgNAPDxm69g=;
        b=il9LdpIZT+Lq6+mOIvSnsw48UK1Jbhg5FT0E8eKw5EV46IjUlV+Padolln/5TMpeck
         32Q/gGbYqLguZKP/dEUntylW2/xjWG11uvvbTc+ngNMDahINda2uxbjqlzxsg3aUEKCa
         J5lYJFssWsl3xA6qvopU3E1P4UXOtbVAidqwEk8/Wn5m3O7Wf2cXOL1SsATSTppWA/A6
         alramSQq8ncYZxMoJhlVAQpsLaxfP1e+dP43MOVtkeZd1/azgZ+Sk4cDA0+3HKOzxENG
         rh2MI9a+PM1oCFtI9y3akI1DeZW7mQgHzduqIiyQb2+4oy6KZGR8VaYAgijrYHVE8ahr
         Rq9w==
X-Gm-Message-State: AO0yUKUwmjPsgT9dYF5uOb7Uh16nnv92ImrujbQl3G2MdIi6OAIXJK76
        R7IzfkdiVc4i89VpNOLKLT2lbg==
X-Google-Smtp-Source: AK7set+jNvQiQc0puaD/LiLJjFfzeezvD62gGBk5wwoChQTLa0cne0s8eA08wN5TXSJA6At1kiwJnQ==
X-Received: by 2002:a05:600c:b88:b0:3df:9858:c033 with SMTP id fl8-20020a05600c0b8800b003df9858c033mr10674011wmb.8.1675679321432;
        Mon, 06 Feb 2023 02:28:41 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:40 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 22/37] nvmem: core: provide own priv pointer in post process callback
Date:   Mon,  6 Feb 2023 10:27:44 +0000
Message-Id: <20230206102759.669838-23-srinivas.kandagatla@linaro.org>
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

