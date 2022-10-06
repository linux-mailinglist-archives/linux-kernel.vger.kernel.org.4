Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E9F5F71F5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiJFXlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbiJFXlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:41:45 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630C3B7EE8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 16:41:44 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d24so3097302pls.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 16:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=qCdxcv6M0CuI1NF0o9w+SopI59ed1qMBjC0oFZix1to=;
        b=cuOzGu8QPuJKu+27nAW0yvJkZyh+Y0IUvM+g/jA0NnjQ0A9OMNFZsq6HsUHYOBYeCL
         KjewOTyaimxfA0qnPv7Bw8bk5adAv9A3Pfj/RNVmfZYcsHGsTCFqjDtWH011OG3cB0C/
         Nw/2XLNUzKMXeY5OGkIMKMBctyuza1vVQZKAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=qCdxcv6M0CuI1NF0o9w+SopI59ed1qMBjC0oFZix1to=;
        b=yIBfuD/dSx1EXTe6uDB4phKYnyIEgchevySUVbicpf39NgXHqn5bI4fr4wpy4d9nj4
         /2LLk43hheaO9/zJk0C5eC+qFy8ZsaamFWZf5zFtPFcCIprpKpJh2QKkscK6vQaB4tJb
         MN7GHFu3Ja+hd1FHVnYQvK4jjXh7pv/kMmlTtMTUsA9WNSpDNnFF/js/1SlURVjxbHx3
         aL6cbsVPH5ClCE0/X8XNkhVJ6sMQwYLHirNxWqxKZ9DIXbIOe68PS3TZcJlSEGy6+VLr
         4reirC809IYCkyRwxO7YkczJt49BtY+K0Hgcfrhpq8Es28JyBBmKRF1wRF/LoLgdy9tS
         wBdA==
X-Gm-Message-State: ACrzQf1D1dbGoAg0UhtrHaV1CTRVn2BTxIEJCKR9YoqXNfZVdlIGH4gA
        TndmkuUSVKL6wReY9ukKYxgaSw==
X-Google-Smtp-Source: AMsMyM7Et+YU922Se/+kC0Ktf2RCcFl1kp7JkwscCc/OdZuVm4GhFCkFxpMf9aZo8N3RWKgpB+v4CQ==
X-Received: by 2002:a17:903:22d0:b0:177:f919:9259 with SMTP id y16-20020a17090322d000b00177f9199259mr1837761plg.71.1665099703864;
        Thu, 06 Oct 2022 16:41:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q27-20020aa7983b000000b005625d5ae760sm206462pfl.11.2022.10.06.16.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 16:41:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] pstore: migrate to crypto acomp interface (take 2)
Date:   Thu,  6 Oct 2022 16:41:38 -0700
Message-Id: <20221006234138.1835739-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5644; i=keescook@chromium.org; h=from:subject; bh=nyFzDaejhKcnUUweiZXZHIGXRCrEOLw9LJkJmbn+1Rg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjP2eymu+LeD9AhiAcJ+NO1EOfHWhzgzP6YRktQ7QS n89k2eOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYz9nsgAKCRCJcvTf3G3AJtpSD/ 9n/oFir28xaN+WDAhY0Hc8TenRkOOsHJupmb4YANzKCTMe+ACHdWH9hj+8RX0lnGCdnCFbCTsyQ8X1 ZD0frlnwQlDCTdyvs1qMi2wfNE+o8bKaI/3eC+rhQORcQ6thpYr2q1175SBwkCA5oJvEuVWvdnrAy7 bap5+0WzqcRFysNcdLmuq/hOHCEfHdhMYqveeDg6Z//avkN3ZtNydq2zHbLuzA2kKcuZpszYEjiOPT 55sNMgeyATb3V5kPgJxPaY64On8Lrl1aHzluyfhrOpEBk6xxOTppJqIb7m98tqDzteZzlttmumaKLn RSzB9uIr0n/MTTvy1XCTW9ciX57uhsPCB6oyKu8RaOA4jd8kZl1iDhGgSq9XcSU+n9wVcJgryXzGkP i8oQV74oT5eZpM9F3BBHPB4Zydsle420fcaJDzPw83PA62+jked1QgCP7bj8hAAxgM40/zrOHrcapc rISubO76QW+xGbDYotbMoQ8OPomIuM5BfcCjItymAARqg11jHa7IxKHAZZ2caKduKiDj7hLDpjbshM DrAzzP9uQ6W550VXVUPtcB1mD97/2O8cDZC7pAvzvooLOZnnib102UB8guckM/P1BhdBQqst9rk7dW N0qt7VZmGRE9Csq1q0s9yEZblGUg+3loa8REg+Y5/YaIjEBV8Z0TJFQo2gpQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

The crypto 'compress' interface is deprecated, so before adding new
features, migrate to the acomp interface. Note that we are only using
synchronous implementations of acomp, so we don't have to deal with
asynchronous completion.

[ Tweaked error paths to avoid memory leak, as pointed out byGuilherme
  G. Piccoli <gpiccoli@igalia.com>, and fixed pstore_compress()
  return value -kees ]

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/lkml/CAMj1kXFnoqj+cn-0dT8fg0kgLvVx+Q2Ex-4CUjSnA9yRprmC-w@mail.gmail.com/
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c | 74 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 17 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 0c034ea39954..f82256612c19 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -28,11 +28,14 @@
 #include <linux/crypto.h>
 #include <linux/string.h>
 #include <linux/timer.h>
+#include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/jiffies.h>
 #include <linux/workqueue.h>
 
+#include <crypto/acompress.h>
+
 #include "internal.h"
 
 /*
@@ -90,7 +93,8 @@ module_param(compress, charp, 0444);
 MODULE_PARM_DESC(compress, "compression to use");
 
 /* Compression parameters */
-static struct crypto_comp *tfm;
+static struct crypto_acomp *tfm;
+static struct acomp_req *creq;
 
 struct pstore_zbackend {
 	int (*zbufsize)(size_t size);
@@ -268,23 +272,32 @@ static const struct pstore_zbackend zbackends[] = {
 static int pstore_compress(const void *in, void *out,
 			   unsigned int inlen, unsigned int outlen)
 {
+	struct scatterlist src, dst;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS))
 		return -EINVAL;
 
-	ret = crypto_comp_compress(tfm, in, inlen, out, &outlen);
+	sg_init_table(&src, 1);
+	sg_set_buf(&src, in, inlen);
+
+	sg_init_table(&dst, 1);
+	sg_set_buf(&dst, out, outlen);
+
+	acomp_request_set_params(creq, &src, &dst, inlen, outlen);
+
+	ret = crypto_acomp_compress(creq);
 	if (ret) {
 		pr_err("crypto_comp_compress failed, ret = %d!\n", ret);
 		return ret;
 	}
 
-	return outlen;
+	return creq->dlen;
 }
 
 static void allocate_buf_for_compression(void)
 {
-	struct crypto_comp *ctx;
+	struct crypto_acomp *acomp;
 	int size;
 	char *buf;
 
@@ -296,7 +309,7 @@ static void allocate_buf_for_compression(void)
 	if (!psinfo || tfm)
 		return;
 
-	if (!crypto_has_comp(zbackend->name, 0, 0)) {
+	if (!crypto_has_acomp(zbackend->name, 0, CRYPTO_ALG_ASYNC)) {
 		pr_err("Unknown compression: %s\n", zbackend->name);
 		return;
 	}
@@ -315,16 +328,24 @@ static void allocate_buf_for_compression(void)
 		return;
 	}
 
-	ctx = crypto_alloc_comp(zbackend->name, 0, 0);
-	if (IS_ERR_OR_NULL(ctx)) {
+	acomp = crypto_alloc_acomp(zbackend->name, 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR_OR_NULL(acomp)) {
 		kfree(buf);
 		pr_err("crypto_alloc_comp('%s') failed: %ld\n", zbackend->name,
-		       PTR_ERR(ctx));
+		       PTR_ERR(acomp));
+		return;
+	}
+
+	creq = acomp_request_alloc(acomp);
+	if (!creq) {
+		crypto_free_acomp(acomp);
+		kfree(buf);
+		pr_err("acomp_request_alloc('%s') failed\n", zbackend->name);
 		return;
 	}
 
 	/* A non-NULL big_oops_buf indicates compression is available. */
-	tfm = ctx;
+	tfm = acomp;
 	big_oops_buf_sz = size;
 	big_oops_buf = buf;
 
@@ -334,7 +355,8 @@ static void allocate_buf_for_compression(void)
 static void free_buf_for_compression(void)
 {
 	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && tfm) {
-		crypto_free_comp(tfm);
+		acomp_request_free(creq);
+		crypto_free_acomp(tfm);
 		tfm = NULL;
 	}
 	kfree(big_oops_buf);
@@ -671,6 +693,8 @@ static void decompress_record(struct pstore_record *record)
 	int ret;
 	int unzipped_len;
 	char *unzipped, *workspace;
+	struct acomp_req *dreq;
+	struct scatterlist src, dst;
 
 	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !record->compressed)
 		return;
@@ -694,31 +718,47 @@ static void decompress_record(struct pstore_record *record)
 	if (!workspace)
 		return;
 
+	dreq = acomp_request_alloc(tfm);
+	if (!dreq)
+		goto out_free_workspace;
+
+	sg_init_table(&src, 1);
+	sg_set_buf(&src, record->buf, record->size);
+
+	sg_init_table(&dst, 1);
+	sg_set_buf(&dst, workspace, unzipped_len);
+
+	acomp_request_set_params(dreq, &src, &dst, record->size, unzipped_len);
+
 	/* After decompression "unzipped_len" is almost certainly smaller. */
-	ret = crypto_comp_decompress(tfm, record->buf, record->size,
-					  workspace, &unzipped_len);
+	ret = crypto_acomp_decompress(dreq);
 	if (ret) {
-		pr_err("crypto_comp_decompress failed, ret = %d!\n", ret);
-		kfree(workspace);
-		return;
+		pr_err("crypto_acomp_decompress failed, ret = %d!\n", ret);
+		goto out;
 	}
 
 	/* Append ECC notice to decompressed buffer. */
+	unzipped_len = dreq->dlen;
 	memcpy(workspace + unzipped_len, record->buf + record->size,
 	       record->ecc_notice_size);
 
 	/* Copy decompressed contents into an minimum-sized allocation. */
 	unzipped = kmemdup(workspace, unzipped_len + record->ecc_notice_size,
 			   GFP_KERNEL);
-	kfree(workspace);
 	if (!unzipped)
-		return;
+		goto out;
 
 	/* Swap out compressed contents with decompressed contents. */
 	kfree(record->buf);
 	record->buf = unzipped;
 	record->size = unzipped_len;
 	record->compressed = false;
+
+out:
+	acomp_request_free(dreq);
+out_free_workspace:
+	kfree(workspace);
+	return;
 }
 
 /*
-- 
2.34.1

