Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C61A67E301
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjA0LTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjA0LSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:18:34 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2A13C2A1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:10 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id b7so4677927wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DR9w7wcr4DxJXxKbzQwRT2qyu3/q2O3thBJlj1O/L4c=;
        b=sF8aqy+tRNV9j/qZ2iQCf4dYQSyI8A00EeoANp5zCeaMAEHK/jehE1rsQKSe9UyQXK
         PNE48qlU5OOB3QIFN9khvGoaPAL6KEy+dvzsbX3I5Rc0GumTrVh2uEN1yT4tGq4SPGUE
         6hpqZSQ3dzIODaLuwisXipuPDDpvwYryPUFtcYv+56nDrqby4MycjPRNsfkVJdQr4FeR
         qSXoE/tKK40FsKJwFlO05GZpPgmfXubXdcJBLEzjQlLVTTilMshCWddiWYHB8rFjGYfp
         /MmUiG27yb0+WxGEfALrpduHW/Luw+6YvEIRL78W7w1LZi1snPLxNTVU7rlasb/e0f5p
         mKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DR9w7wcr4DxJXxKbzQwRT2qyu3/q2O3thBJlj1O/L4c=;
        b=Om7NFbLDS+xixDxU59BtSEaLsMrQ7uj/bXRKbVOcqj1fRdFuoL+mXDgkYgSKuAcO3b
         3aZF4gGiVEWyxoOwssU+WN7SjrdW1rcy8RsFL6yi9P7XFwXq1XwJIHyF7QF/4w1MUcD7
         gwBYglaDWALEvP5xpA9fQBa/qD/nCaM9+SMfw1hqcwkG3HAlwmOyWmrUgusqycDdB5yO
         dA8ILVzo5n+xLXp8Wk9uDR7c0HF52dyL43JZJ34G9mbdxt+GEpRxIRD417tJ64UALhN8
         hpaUBDLJwvSBy30ccpvpUGS7pn98i65G8/UcuFeGYoDba8iR0w1FELy6dnMXjqgJrx2J
         JMqQ==
X-Gm-Message-State: AO0yUKVgL/zC1vriomrwzxxiWiN6PCqFixyRje5OfNEv69TKmj7SG0zI
        Z1FWT9nFExyi0XuFKielt2OGpA==
X-Google-Smtp-Source: AK7set9PbRgOIlOhvRLpQVV+268XAlgy0lnLfdMO90rJeLQxzu6KuA0U+nSAAZ6TvinKO98kLVdltQ==
X-Received: by 2002:a5d:62d1:0:b0:2bf:d680:e37a with SMTP id o17-20020a5d62d1000000b002bfd680e37amr850728wrv.67.1674818288648;
        Fri, 27 Jan 2023 03:18:08 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:18:07 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 21/37] nvmem: cell: drop global cell_post_process
Date:   Fri, 27 Jan 2023 11:15:49 +0000
Message-Id: <20230127111605.25958-22-srinivas.kandagatla@linaro.org>
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

There are no users anymore for the global cell_post_process callback
anymore. New users should use proper nvmem layouts.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 9 ---------
 include/linux/nvmem-provider.h | 2 --
 2 files changed, 11 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 216a8eb01d00..ae59d9cb901c 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -38,7 +38,6 @@ struct nvmem_device {
 	unsigned int		nkeepout;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
-	nvmem_cell_post_process_t cell_post_process;
 	struct gpio_desc	*wp_gpio;
 	struct nvmem_layout	*layout;
 	void *priv;
@@ -893,7 +892,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->type = config->type;
 	nvmem->reg_read = config->reg_read;
 	nvmem->reg_write = config->reg_write;
-	nvmem->cell_post_process = config->cell_post_process;
 	nvmem->keepout = config->keepout;
 	nvmem->nkeepout = config->nkeepout;
 	if (config->of_node)
@@ -1558,13 +1556,6 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 			return rc;
 	}
 
-	if (nvmem->cell_post_process) {
-		rc = nvmem->cell_post_process(nvmem->priv, id, index,
-					      cell->offset, buf, cell->bytes);
-		if (rc)
-			return rc;
-	}
-
 	if (len)
 		*len = cell->bytes;
 
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index be81cc88eabc..d3d7af86a283 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -85,7 +85,6 @@ struct nvmem_cell_info {
  * @no_of_node:	Device should not use the parent's of_node even if it's !NULL.
  * @reg_read:	Callback to read data.
  * @reg_write:	Callback to write data.
- * @cell_post_process:	Callback for vendor specific post processing of cell data
  * @size:	Device size.
  * @word_size:	Minimum read/write access granularity.
  * @stride:	Minimum read/write access stride.
@@ -118,7 +117,6 @@ struct nvmem_config {
 	bool			no_of_node;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
-	nvmem_cell_post_process_t cell_post_process;
 	int	size;
 	int	word_size;
 	int	stride;
-- 
2.25.1

