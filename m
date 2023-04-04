Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FC86D6A74
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbjDDRX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbjDDRXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:12 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D820B55BB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:22:51 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id eh3so133538032edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Azd3oktKmYViYGpvLrpeQLO4dth6eZb1RhKC0MZJZlM=;
        b=zjjMh1PtfFWem7fQxHmfgW3oW0PO/EA7FXqwhT2TnxO8hKdQ1SJGh9GYu11d8HBhb9
         zasTPYwmvWDR7oj3Lg6n3mhk0fgEu/r9WNRCeMIDy5Vt9E+nH+5PCsh1r9xcGO/tiZrI
         CnaTSUAgN9gqnQqE5A+mUlANq94mkYcwFsGb6ValUN9xU3iFgVqoLhfuhVXsDPJQ0kv8
         s7VqR/iMHW4X9GMTB8cf1KaAtfVYBrPNzq51L66HEgvcpuwZOQIqmIH6YH23NezCkUdg
         xQUV3sRT9AKUOIflx16Q3vueP/JW6BBoV40TiWV4qY/9OoLidZyBHAac5cHGE40AMWky
         SfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Azd3oktKmYViYGpvLrpeQLO4dth6eZb1RhKC0MZJZlM=;
        b=XcRS6gHu+A68VdEG2vNDJWHvYfGnlnjfdPKJ2+nQzyIIwwqXKGCTOZf/loLPTaMPoO
         85tkS8lTry5LOPvUUbuUN5HnahjzrqaQzjpEGiBBj5m5B5dYLH3jzETYQxdZtRi7uqQm
         ZtTKbnvBzzw1voNnakm3lNgWmjPOXO9BOKVLcNN4iKNK3O403tN3mQi4lweF1Huj0RJD
         rGyLEipsfbA1xOf4jpvmUjLBS/l8cQUq1i8nTt2Z/NYSaAB3w//Ba4BWtHRjKZHPw4bk
         ofz5RzNno72pnxxh/r418cO/UeJ1yQCkNzHu0josF1AGnALY+6LsxLM/sQoGNe7Sz7ZX
         w8AQ==
X-Gm-Message-State: AAQBX9eupOUyUIXOvSWJ8UZXRqhlN94QIYCGSFOMsZFql3i/d40wAeD0
        19tBD5Tm8YZJOjdQ0FF9BEhhvg==
X-Google-Smtp-Source: AKy350bacXr/iZ2Stg7TnkVRd4x9JLwF+M4EqntQGjy0oHcaJJ8vOSjRa3/kiR2uCECGMeFJqelwzA==
X-Received: by 2002:a17:906:110d:b0:889:1eb1:7517 with SMTP id h13-20020a170906110d00b008891eb17517mr283893eja.30.1680628969566;
        Tue, 04 Apr 2023 10:22:49 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:48 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 19/40] nvmem: cell: drop global cell_post_process
Date:   Tue,  4 Apr 2023 18:21:27 +0100
Message-Id: <20230404172148.82422-20-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

There are no users anymore for the global cell_post_process callback
anymore. New users should use proper nvmem layouts.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 9 ---------
 include/linux/nvmem-provider.h | 2 --
 2 files changed, 11 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f43025ad315b..fccb2728193a 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -39,7 +39,6 @@ struct nvmem_device {
 	unsigned int		nkeepout;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
-	nvmem_cell_post_process_t cell_post_process;
 	struct gpio_desc	*wp_gpio;
 	struct nvmem_layout	*layout;
 	void *priv;
@@ -903,7 +902,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->type = config->type;
 	nvmem->reg_read = config->reg_read;
 	nvmem->reg_write = config->reg_write;
-	nvmem->cell_post_process = config->cell_post_process;
 	nvmem->keepout = config->keepout;
 	nvmem->nkeepout = config->nkeepout;
 	if (config->of_node)
@@ -1576,13 +1574,6 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
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

