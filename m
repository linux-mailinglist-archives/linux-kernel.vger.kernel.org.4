Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D67268BA2A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjBFK3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjBFK3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:29:23 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4537D21A14
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:42 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so6874627wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DR9w7wcr4DxJXxKbzQwRT2qyu3/q2O3thBJlj1O/L4c=;
        b=u79opte5IWGA7gNit3Yr2fY+hAux2hPa7qMGAEhQIT9usb2DpPvV7tCvr/QPfllRAc
         VYMLI1cPqFyKkA5mfrA+s0AGji8UkGYdeCDxuHJFA61p8wOh611RGJ6F0ZOtU8+zVpVi
         VOXYlJTLLdnGoMERVY0iJmyGkydyn1+/dKe3XgInaZuhW+MrVcZmu64t9lZ5MZWFgCOC
         EAulcRMWXayGDLrfcWSrZPSU3gMQ/1q5cC/CmxGeLWlL4DLQ17k4T+NQ6fpn1TC6KLkQ
         NQxdnoDmctqj8AwGezvl8egjtAWW2xLEFffILzK12Prlr+EslfgSPCVBvAFAVOynaqJ0
         nX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DR9w7wcr4DxJXxKbzQwRT2qyu3/q2O3thBJlj1O/L4c=;
        b=XQg+ukwSUrBnxNEFHJRmJuRSDjQZeAWZ+kXcZ5wreDtKJB6L5oP53bPtZSNeUz4ZTl
         5W2E/RpTe8XX8Fd6E0q7YVO6tv5bBHnkG4eHkxf6RW4kHYEPIJSTQs98hAgaKAkPE0f6
         l1As/wgvCGp6mfjNnLEYW3JwOf+sNalEFsiOFN7NlhGraKSOAwFvF6KiYnYOkFrZEvEe
         mjRxetivgMHQ7tOk7VPDuijBoH75ezHNDd8xZWE8+I5HafwY4IjRpYkw3BIQrVikh6XH
         FyA0IaSAIOKFpc18Lmk3Gx3a/y6nqa8jBCnMsEM2F7W9fjgevrBqvOH5az/cW81Y4iyG
         76tg==
X-Gm-Message-State: AO0yUKXqPSVUokansAa6fUjllngy5VPscunipAAz48NdgaT5zyXQblZw
        OIfY/aL6k+T8roU48PoU5A/uIy7f2mufchZo
X-Google-Smtp-Source: AK7set+UdntrbbekbCxkuEhueB/mIdg02VNDk7SChoV3/LCU6GeKOogsTvCMtAz33cFJdoUEp7PKDQ==
X-Received: by 2002:a7b:cd17:0:b0:3dc:5342:4132 with SMTP id f23-20020a7bcd17000000b003dc53424132mr18548794wmj.4.1675679320310;
        Mon, 06 Feb 2023 02:28:40 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:39 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 21/37] nvmem: cell: drop global cell_post_process
Date:   Mon,  6 Feb 2023 10:27:43 +0000
Message-Id: <20230206102759.669838-22-srinivas.kandagatla@linaro.org>
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

