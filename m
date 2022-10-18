Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1486020E5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiJRCJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiJRCIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:08:43 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90937284C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:08:40 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so12631028pjf.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VM6TrkNfqqqa9ARyQZypqrAo/ewzetmaTqLOSrYaeE=;
        b=ezyLTjrM3Dn0zRtu72SFNG0CnEpp1bT63bETOd2sgVAX4wyvBiuKeStfHGQqcLyT0c
         gVDYu1L+NV1sUT55XXuC2KnIGY6mInWaLnQuPwZ0OWKrVkQgzv5C9d3BHfr/ahLIDZI+
         DPOFNE01+2a7o4KLbVjTxkkKlLFYEWzfuT0vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VM6TrkNfqqqa9ARyQZypqrAo/ewzetmaTqLOSrYaeE=;
        b=GHnHNrhymUZyVQoWwWBbUqrAGmbbsekwJ9zw/xGkYTdJ2tvX+gjDTT65tpsty3kWPS
         JuSZIq97pFSVKKW8QwhsqBKTieWUxye6D0uhnXBcMwPOB/VyVguuRRmgMdhsmiImuRjy
         sTr2RsUqhpZSzLPY6jMu2JPFPwF5TpfGN30SOy6IpL74pN4SeWFEqJw9FazvGRMRDi/J
         lxxwDTvLqJYKsc6GVGiSe/KustRfFmglLwHELBB+yv9D+fokhF4oX/ZOrVy/Po817WzA
         lBvM/a0yrEdnTl5VRljtwW9bmIfq8zn9Jjzm59f5vms8lCdXXMYk+G9yhS2WtCjXHyTI
         6lFA==
X-Gm-Message-State: ACrzQf30h4Qdvfd88r5wkQMR76H+0S5eFHIvufn7Ad/lqd0M1VBo9eTo
        QaTHNRkwy/x4KHV/f1rlhmbvXg==
X-Google-Smtp-Source: AMsMyM74kPZI3NEJlQ4I13yJg8iIYbMLJs0Ow74byPpU+7gCvF39Ifo4s0jk3IrU+VUUikYEbh0plQ==
X-Received: by 2002:a17:902:e542:b0:185:53ee:60cd with SMTP id n2-20020a170902e54200b0018553ee60cdmr690796plf.59.1666058904055;
        Mon, 17 Oct 2022 19:08:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i3-20020aa796e3000000b005625ef68eecsm7801373pfq.31.2022.10.17.19.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:08:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Nick Terrell <terrelln@fb.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] pstore: Use zstd directly by default for compression
Date:   Mon, 17 Oct 2022 19:08:13 -0700
Message-Id: <20221018020815.2872331-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018020519.never.337-kees@kernel.org>
References: <20221018020519.never.337-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5821; h=from:subject; bh=sLRnNe7TSr1mUP3rC2Jvs34rMQHwsZo2peo8sm7nqHc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTgqNgz5mFVDTEKh2ZTTBl7zsnZsWbaMExcRb5vXR gEu/gkyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY04KjQAKCRCJcvTf3G3AJkloEA Cx0DdUC7uHvpq0otB5MaffHQuDX/WFSqZOjbyZ3s4Ko7jTPVRaQ+0I5mgBLkr7XNi5anMUfD6E0dwW Jmj0GLm7TQQTNlNPjlWEh+sBwrakWkY0ogeMNlT2BEghzGrAehJtXAm1OVNpuGZG9zbkTl+YDmSoM0 R00snjAslMqT96UbreZhrfb3+PoH/Mp5KytWO7IR/wIbsZq2x1gbUssIdJ3PMUDV8YIrXyoXep26YD o+lEndpJ0LG+2doq/BH4MbiMXGGAuFjbhjfwlY3jVtGvBpJVjdF3/vD9ornpfamj5gK7MXGyGrWFZ+ s4H9gtlsoD2FGpj+wHerMCmOVqXyg7r4RQ9075mZ3Z8FqcfRwbj+Ywvm8ZExjTFbQnxaou3du24z8y oZ8/OLj58d/xW2gp9OTE4wFeQM736WRXGnmQQOCsfMms1EO8BbpnAZX6/Pc1adzCbOcSIHlqKiC6al lpEUsadqvEctXeAtBUc8w7/S/upt6CE8UOYLxyieiZC5rwWYTakzZjDvDi3nk4//DMjRjjL10ED3Ih b1VGqx9YEEvMtMiNg63YZzTzXFbXAG2UXtmiovUfzVMIXBT2NXjEl4nngk8zmuYqBgPGGpoxiNT60M 9iO/p2mSCGm6jRKhoFq+jeSqnGms3IfOyYPiGf2BV/Kd1JtkkkcGW8HSKHYQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If compression is desired, use zstd directly to avoid Crypto API
overhead.

Cc: Tony Luck <tony.luck@intel.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Nick Terrell <terrelln@fb.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/Kconfig    | 11 +++++-
 fs/pstore/platform.c | 93 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 97 insertions(+), 7 deletions(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index a95b3981cb0e..1f05312c7479 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -25,7 +25,7 @@ config PSTORE_DEFAULT_KMSG_BYTES
 choice
 	prompt "Panic dump compression"
 	depends on PSTORE
-	default PSTORE_COMPRESS_CRYPTO
+	default PSTORE_COMPRESS
 	help
 	  Choose whether and how to compress the panic dump output. This
 	  is usually only needed for very storage-constrained backends.
@@ -38,6 +38,15 @@ choice
 		  available to from the Crypto API. Note that this may reserve
 		  non-trivial amounts of per-CPU memory.
 
+	config PSTORE_COMPRESS
+		bool "Use recommended best compression algorithm"
+		select CRYPTO_ZSTD
+		help
+		  Use the compression routines currently deemed best suited
+		  for panic dump compression. Currently, this is "zstd".
+		  As this compression is used directly through its library
+		  interface, no per-CPU memory is allocated by the Crypto API.
+
 	config PSTORE_COMPRESS_NONE
 		bool "Do not compress panic dumps"
 		help
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 4d883dc2e8a7..51d2801fc880 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -23,6 +23,7 @@
 #include <linux/uaccess.h>
 #include <linux/jiffies.h>
 #include <linux/workqueue.h>
+#include <linux/zstd.h>
 
 #include "internal.h"
 
@@ -72,13 +73,17 @@ module_param(backend, charp, 0444);
 MODULE_PARM_DESC(backend, "specific backend to use");
 
 static char *compress __ro_after_init =
-#ifdef CONFIG_PSTORE_COMPRESS_CRYPTO_DEFAULT
-		CONFIG_PSTORE_COMPRESS_CRYPTO_DEFAULT;
+#ifdef CONFIG_PSTORE_COMPRESS
+		"zstd";
 #else
-		NULL;
-#endif
+# ifdef CONFIG_PSTORE_COMPRESS_CRYPTO_DEFAULT
+		CONFIG_PSTORE_COMPRESS_CRYPTO_DEFAULT;
 module_param(compress, charp, 0444);
 MODULE_PARM_DESC(compress, "compression to use");
+# else
+		NULL;
+# endif
+#endif
 
 /* How much of the kernel log to snapshot */
 unsigned long kmsg_bytes = CONFIG_PSTORE_DEFAULT_KMSG_BYTES;
@@ -88,6 +93,12 @@ MODULE_PARM_DESC(kmsg_bytes, "amount of kernel log to snapshot (in bytes)");
 /* Compression parameters */
 static struct crypto_comp *tfm;
 
+static zstd_cctx *cctx;
+static zstd_dctx *dctx;
+static void *cwksp;
+static void *dwksp;
+zstd_parameters zparams;
+
 static char *big_oops_buf;
 static size_t big_oops_buf_sz;
 
@@ -175,6 +186,14 @@ static int pstore_compress(const void *in, void *out,
 		return 0;
 	}
 
+	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS)) {
+		*outlen = zstd_compress_cctx(cctx, out, *outlen, in, inlen,
+					    &zparams);
+		if (zstd_is_error(*outlen))
+			return -EINVAL;
+		return 0;
+	}
+
 	return -EINVAL;
 }
 
@@ -203,12 +222,56 @@ static int allocate_crypto_buf(void)
 	return 0;
 }
 
+static int allocate_zstd_buf(void)
+{
+	size_t csize, dsize;
+
+	/* Skip if compression init already done. */
+	if (cctx)
+		return 0;
+
+	zparams = zstd_get_params(3, 0);
+	csize = zstd_cctx_workspace_bound(&zparams.cParams);
+	dsize = zstd_dctx_workspace_bound();
+
+#define init_ctx(dir, name)	do {					\
+	dir##wksp = kzalloc(dir##size, GFP_KERNEL);			\
+	if (!dir##wksp) {						\
+		pr_err("Failed %zu byte %s " #name " allocation\n",	\
+		       dir##size, compress);				\
+		return -ENOMEM;						\
+	}								\
+	dir##ctx = zstd_init_##dir##ctx(dir##wksp, dir##size);		\
+	if (!dir##ctx) {						\
+		pr_err("Failed %s " #name " context init\n", compress);	\
+		return -EINVAL;						\
+	}								\
+} while (0)
+
+	init_ctx(c, compress);
+	init_ctx(d, decompress);
+
+#undef init_wksp
+
+	pr_info("Using crash dump compression: built-in %s\n", compress);
+	return 0;
+}
+
 static void free_buf_for_compression(void)
 {
 	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS_CRYPTO) && tfm) {
 		crypto_free_comp(tfm);
 		tfm = NULL;
 	}
+	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && cctx) {
+		cctx = NULL;
+		dctx = NULL;
+		kfree(cwksp);
+		cwksp = NULL;
+		kfree(dwksp);
+		dwksp = NULL;
+
+	}
 	kfree(big_oops_buf);
 	big_oops_buf = NULL;
 	big_oops_buf_sz = 0;
@@ -228,7 +291,10 @@ static void allocate_buf_for_compression(void)
 		return;
 
 	/* Initialize compression routines. */
-	rc = allocate_crypto_buf();
+	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS_CRYPTO))
+		rc = allocate_crypto_buf();
+	else
+		rc = allocate_zstd_buf();
 	if (rc)
 		goto fail;
 
@@ -598,6 +664,16 @@ static int pstore_decompress_crypto(struct pstore_record *record, char *workspac
 	return 0;
 }
 
+static int pstore_decompress_zstd(struct pstore_record *record,
+				  char *workspace, size_t *outlen)
+{
+	*outlen = zstd_decompress_dctx(dctx, workspace, *outlen,
+				       record->buf, record->size);
+	if (zstd_is_error(*outlen))
+		return -EINVAL;
+	return 0;
+}
+
 static void decompress_record(struct pstore_record *record)
 {
 	size_t unzipped_len;
@@ -626,7 +702,12 @@ static void decompress_record(struct pstore_record *record)
 	if (!workspace)
 		return;
 
-	rc = pstore_decompress_crypto(record, workspace, &unzipped_len);
+	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS_CRYPTO))
+		rc = pstore_decompress_crypto(record, workspace,
+					      &unzipped_len);
+	else
+		rc = pstore_decompress_zstd(record, workspace,
+					    &unzipped_len);
 	if (rc) {
 		kfree(workspace);
 		return;
-- 
2.34.1

