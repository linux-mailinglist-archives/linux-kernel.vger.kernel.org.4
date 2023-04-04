Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC60D6D6A84
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbjDDRZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbjDDRX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:57 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058845FDC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:23:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w9so133614911edc.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzeb5V/SOEGPt1++ztmrQsHaT6myWHiPy1gZ7kZBJII=;
        b=JHsg3sox3P/oVO7yc/tm0IKSC3s5sE8Dmoho40tXAtg5RoLy9xAX0UZjXDIfV6gzg1
         CRFpKY2O6Y28IiH0HsZHlfDPdLvrGG7GKS1PvMN0r19O/3mzXkjwTfUKjn+86Kdvc8n1
         rQ2zDWMjyJ5aJdrHFYBSehkwokcngYcBaCP83Hth4ddzD+c7lZSI7TMQiuVg76FQA6ZO
         DFec6soEes8FLGltiU3mh51Zsk41+58M2VFJvaAkolaLUGJ6lsvdlajky+XxulWneTX5
         Nz8QB820k2aYkVgpGk+V/OpP1irTnSwDZXRX8XX+YqGxiVCuSSa8iWiGz8FK9vLhrpK8
         wpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzeb5V/SOEGPt1++ztmrQsHaT6myWHiPy1gZ7kZBJII=;
        b=OSX1XJlApXseafHJnRVXdD9/91afE3SOZZk7VQGBiWuO3aRlVtV7XlUFLAsuQGWjC2
         hR5DLLLtyW03Z85uhnNmI+LluB1NIik3YjC9RtQ7AeONtCjIXn/HiDlf+nuLfCcx3Vcp
         oMAh9Y81okQHZLxrbbvtFA85Obqu+o6EfW3rMH1DY5wb2MP3xeuQjqrceuTOqLewdecB
         KZ6gOCHQF2ROHH3quTttYnmv2cLb/VWdJnynxEokYpB6+Fiwak4bMFOArQ+ujxjk6ryz
         4jDKE8UoIQu1yguslWWVDQSh1xRicLqHk9ceHEvmqVp9FHWAxHK6SEJGWvjazwa1GJbW
         fs/Q==
X-Gm-Message-State: AAQBX9cWDqqnXrqk6bGycSC++ZJtNGgadllSGSNiX6Kbjz3aNrxGMA9r
        eNhzmArKOV2FL2pFp28YAlrbIA==
X-Google-Smtp-Source: AKy350YOQeYLWZxddlltWQg0FzMK7YV6rINPyt5V0FjVmjK/Y8PjtX1T5RRT8xpmpm2u0nu1nesSfQ==
X-Received: by 2002:a17:907:2bd2:b0:931:a0cb:1ef1 with SMTP id gv18-20020a1709072bd200b00931a0cb1ef1mr296415ejc.7.1680628990081;
        Tue, 04 Apr 2023 10:23:10 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:23:09 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 34/40] nvmem: core: support specifying both: cell raw data & post read lengths
Date:   Tue,  4 Apr 2023 18:21:42 +0100
Message-Id: <20230404172148.82422-35-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Callback .read_post_process() is designed to modify raw cell content
before providing it to the consumer. So far we were dealing with
modifications that didn't affect cell size (length). In some cases
however cell content needs to be reformatted and resized.

It's required e.g. to provide properly formatted MAC address in case
it's stored in a non-binary format (e.g. using ASCII).

There were few discussions how to optimally handle that. Following
possible solutions were considered:
1. Allow .read_post_process() to realloc (resize) content buffer
2. Allow .read_post_process() to adjust (decrease) just buffer length
3. Register NVMEM cells using post-read sizes

The preferred solution was the last one. The problem is that simply
adjusting "bytes" in NVMEM providers would result in core code NOT
passing whole raw data to .read_post_process() callbacks. It means
callback functions couldn't do their job without somehow manually
reading original cell content on their own.

This patch deals with that by registering NVMEM cells with both lengths:
raw content one and post read one. It allows:
1. Core code to read whole raw cell content
2. Callbacks to return content they want

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 11 +++++++----
 include/linux/nvmem-provider.h |  2 ++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 212c5ba5789f..a62973d010ff 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -50,6 +50,7 @@ struct nvmem_device {
 struct nvmem_cell_entry {
 	const char		*name;
 	int			offset;
+	size_t			raw_len;
 	int			bytes;
 	int			bit_offset;
 	int			nbits;
@@ -469,6 +470,7 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
 {
 	cell->nvmem = nvmem;
 	cell->offset = info->offset;
+	cell->raw_len = info->raw_len ?: info->bytes;
 	cell->bytes = info->bytes;
 	cell->name = info->name;
 	cell->read_post_process = info->read_post_process;
@@ -1560,7 +1562,7 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 {
 	int rc;
 
-	rc = nvmem_reg_read(nvmem, cell->offset, buf, cell->bytes);
+	rc = nvmem_reg_read(nvmem, cell->offset, buf, cell->raw_len);
 
 	if (rc)
 		return rc;
@@ -1571,7 +1573,7 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 
 	if (cell->read_post_process) {
 		rc = cell->read_post_process(cell->priv, id, index,
-					     cell->offset, buf, cell->bytes);
+					     cell->offset, buf, cell->raw_len);
 		if (rc)
 			return rc;
 	}
@@ -1594,14 +1596,15 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
  */
 void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len)
 {
-	struct nvmem_device *nvmem = cell->entry->nvmem;
+	struct nvmem_cell_entry *entry = cell->entry;
+	struct nvmem_device *nvmem = entry->nvmem;
 	u8 *buf;
 	int rc;
 
 	if (!nvmem)
 		return ERR_PTR(-EINVAL);
 
-	buf = kzalloc(cell->entry->bytes, GFP_KERNEL);
+	buf = kzalloc(max_t(size_t, entry->raw_len, entry->bytes), GFP_KERNEL);
 	if (!buf)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 0cf9f9490514..8ffb42ba0f62 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -51,6 +51,7 @@ struct nvmem_keepout {
  * struct nvmem_cell_info - NVMEM cell description
  * @name:	Name.
  * @offset:	Offset within the NVMEM device.
+ * @raw_len:	Length of raw data (without post processing).
  * @bytes:	Length of the cell.
  * @bit_offset:	Bit offset if cell is smaller than a byte.
  * @nbits:	Number of bits.
@@ -62,6 +63,7 @@ struct nvmem_keepout {
 struct nvmem_cell_info {
 	const char		*name;
 	unsigned int		offset;
+	size_t			raw_len;
 	unsigned int		bytes;
 	unsigned int		bit_offset;
 	unsigned int		nbits;
-- 
2.25.1

