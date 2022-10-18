Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFB26020EF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiJRCJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiJRCJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:09:08 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0643A748F2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:08:46 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-131dda37dddso15424037fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBRd9cw1Rkfek0J7YHlv9ebkE6z5a48tsgrcsxT5PuA=;
        b=NwNNyZ5Wb03KNiJhkFaOysaWhHo6lNizPNjKIi4CbPvS6pVTgMh50mv7INFYyuW8a6
         kR3Kzootcf5Q7/OePmjcvl0M1ECOirL7jq0lnseGrS+XkVMmc3wstnkJEQy0KCkbml/j
         EHPaSGukxSVTz0OFFdebK0v/c10ovejMsD3qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBRd9cw1Rkfek0J7YHlv9ebkE6z5a48tsgrcsxT5PuA=;
        b=mNpTUYVcljgmEkt9zhN1XY8DEKT6NqK18G2l18frQeXEhq55XlpAq9k89nwM3xUhf0
         AX72wFWpFGO+Vm8TiGpOiO9DGg7NCpHsL3GmK8lt+/VsYv5Z+KLQx2P8L9XXyfhzDDnp
         NrbDrBkn+INxsm2eYGtnug9AUsSe24hag1elxBZcFwvdF/DnZskb/WluqciZ8hwryJwu
         3t3mzGCJdr/fiYmDbOBCRKVE0+15RyJqL0SKQoOA5V4kIEzGeqs8fvF8xGLfuB+uL+6U
         Jn5XtrD2/109WjNaQBZEtu+PaJx7HDxUgSl77wUK758oN+Ow+XuYNUrYZQ+enAWPug+w
         YvKA==
X-Gm-Message-State: ACrzQf1bDpby9PVi6fgKh1EMqLJMDWHLtbcS70ymkJQO+YbICVliulYL
        B0sY9efLYOSXpOG3LCNtWUwGyfxZyBnf0g==
X-Google-Smtp-Source: AMsMyM6V5SLuc+cJSz5kpkL2t47DjSmr/J/X0Am3hm0EyaT5eZJmd16vVHaB/3yRCDgTErjFU4UfoA==
X-Received: by 2002:a17:90b:692:b0:203:6c21:b4aa with SMTP id m18-20020a17090b069200b002036c21b4aamr35534172pjz.227.1666058900664;
        Mon, 17 Oct 2022 19:08:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i10-20020a170902c94a00b00179f370dbe7sm7290666pla.287.2022.10.17.19.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:08:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Nick Terrell <terrelln@fb.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] pstore: Allow for arbitrary compression algorithm
Date:   Mon, 17 Oct 2022 19:08:10 -0700
Message-Id: <20221018020815.2872331-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018020519.never.337-kees@kernel.org>
References: <20221018020519.never.337-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7760; h=from:subject; bh=uc0kl+a6TRA5+6XFgJLw6TULSMAzOvGGUCrsT4ONIEQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTgqMbyBNAMou3xirdeIaCwW74Lc8wdvstFfBCHL4 YvkAb9eJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY04KjAAKCRCJcvTf3G3AJg2mD/ 4w2fvpDNRN1D3IMtBm5CqUw6M66DMdJv5Rq9IeVdTvcGKOCQXOloxOx2Kb87Ut54OsTz/sQVeWov9K j+HR6jVxFiq2kKFSP/kJH6RTIyTK/3QwN0Ocw43Aqtg8qZGMx/gShBINNtVDhJ0buKILEduEhleF5F /lzkv49eXy9dXWiMedinSBfu6ImScEtd25ym/aekGxbs66tcHySFjb0GN+TW7GTjw1vTTZThi0pejJ /mO7YyshqePq3cmiMQk43j0NItwXL+Vavk92Mp1ZeAb4PB636UntywH4uNtj8I0Ho2s/wWPHeTFhAA tkZhDwkv4MovVNZ0UdfdIH7iC5zeVxTnFPidM0wgOi3lGAEBtkYHTKjyImKs/VtBeuIYw8vpAzt7dv lW1n9bVVeYYk3xPVimBaY/vsjy6eKH51PwqwWduQHba6H5vv0X1m9huhQao842Pde8jTxZiA5i7e3G 8g8/h5pPHoxqZ1P1HWdDtRWdJVH65DsseUcXVBnaK+MGCSd89ciXaqNSaiJ0WG82swVia9YZEvBm2n E5kBZxNvdeySPLgMoRdRfHI9X8JCQiZhbQwBmq+u4aZ/Ev2tNTd5cbmwtAnQvrX5I7ivkqrC1irznU raF+bf9m0wrDMA/10vca2++0FDSwjv+kSHfH5cmAQJ+gxdNBeHY134R6+ghw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there is no longer a need for figuring out worst-case compression
size, there is no reason to limit the compression algorithm choice.
Greatly simplifies Kconfig.

Cc: Tony Luck <tony.luck@intel.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Nick Terrell <terrelln@fb.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/Kconfig    | 122 ++++++++++++-------------------------------
 fs/pstore/platform.c |  39 ++++++--------
 2 files changed, 47 insertions(+), 114 deletions(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 8adabde685f1..a95b3981cb0e 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -22,99 +22,41 @@ config PSTORE_DEFAULT_KMSG_BYTES
 	  Defines default size of pstore kernel log storage.
 	  Can be enlarged if needed, not recommended to shrink it.
 
-config PSTORE_DEFLATE_COMPRESS
-	tristate "DEFLATE (ZLIB) compression"
-	default y
-	depends on PSTORE
-	select CRYPTO_DEFLATE
-	help
-	  This option enables DEFLATE (also known as ZLIB) compression
-	  algorithm support.
-
-config PSTORE_LZO_COMPRESS
-	tristate "LZO compression"
-	depends on PSTORE
-	select CRYPTO_LZO
-	help
-	  This option enables LZO compression algorithm support.
-
-config PSTORE_LZ4_COMPRESS
-	tristate "LZ4 compression"
-	depends on PSTORE
-	select CRYPTO_LZ4
-	help
-	  This option enables LZ4 compression algorithm support.
-
-config PSTORE_LZ4HC_COMPRESS
-	tristate "LZ4HC compression"
-	depends on PSTORE
-	select CRYPTO_LZ4HC
-	help
-	  This option enables LZ4HC (high compression) mode algorithm.
-
-config PSTORE_842_COMPRESS
-	bool "842 compression"
-	depends on PSTORE
-	select CRYPTO_842
-	help
-	  This option enables 842 compression algorithm support.
-
-config PSTORE_ZSTD_COMPRESS
-	bool "zstd compression"
-	depends on PSTORE
-	select CRYPTO_ZSTD
-	help
-	  This option enables zstd compression algorithm support.
-
-config PSTORE_COMPRESS
-	def_bool y
-	depends on PSTORE
-	depends on PSTORE_DEFLATE_COMPRESS || PSTORE_LZO_COMPRESS ||	\
-		   PSTORE_LZ4_COMPRESS || PSTORE_LZ4HC_COMPRESS ||	\
-		   PSTORE_842_COMPRESS || PSTORE_ZSTD_COMPRESS
-
 choice
-	prompt "Default pstore compression algorithm"
-	depends on PSTORE_COMPRESS
-	help
-	  This option chooses the default active compression algorithm.
-	  This change be changed at boot with "pstore.compress=..." on
-	  the kernel command line.
-
-	  Currently, pstore has support for 6 compression algorithms:
-	  deflate, lzo, lz4, lz4hc, 842 and zstd.
-
-	  The default compression algorithm is deflate.
-
-	config PSTORE_DEFLATE_COMPRESS_DEFAULT
-		bool "deflate" if PSTORE_DEFLATE_COMPRESS
-
-	config PSTORE_LZO_COMPRESS_DEFAULT
-		bool "lzo" if PSTORE_LZO_COMPRESS
-
-	config PSTORE_LZ4_COMPRESS_DEFAULT
-		bool "lz4" if PSTORE_LZ4_COMPRESS
-
-	config PSTORE_LZ4HC_COMPRESS_DEFAULT
-		bool "lz4hc" if PSTORE_LZ4HC_COMPRESS
-
-	config PSTORE_842_COMPRESS_DEFAULT
-		bool "842" if PSTORE_842_COMPRESS
-
-	config PSTORE_ZSTD_COMPRESS_DEFAULT
-		bool "zstd" if PSTORE_ZSTD_COMPRESS
-
+	prompt "Panic dump compression"
+	depends on PSTORE
+	default PSTORE_COMPRESS_CRYPTO
+	help
+	  Choose whether and how to compress the panic dump output. This
+	  is usually only needed for very storage-constrained backends.
+
+	config PSTORE_COMPRESS_CRYPTO
+		bool "Use an arbitrary compression algorithm via the Crypto API"
+		help
+		  If the default compression algorithm from PSTORE_COMPRESS
+		  is not desired, an arbitrary one can be chosen if it is
+		  available to from the Crypto API. Note that this may reserve
+		  non-trivial amounts of per-CPU memory.
+
+	config PSTORE_COMPRESS_NONE
+		bool "Do not compress panic dumps"
+		help
+		  Do not compress the panic dump output. This leave the
+		  output easily readable in memory, if non-pstore forensics
+		  tools want to examine the contents easily.
 endchoice
 
-config PSTORE_COMPRESS_DEFAULT
-	string
-	depends on PSTORE_COMPRESS
-	default "deflate" if PSTORE_DEFLATE_COMPRESS_DEFAULT
-	default "lzo" if PSTORE_LZO_COMPRESS_DEFAULT
-	default "lz4" if PSTORE_LZ4_COMPRESS_DEFAULT
-	default "lz4hc" if PSTORE_LZ4HC_COMPRESS_DEFAULT
-	default "842" if PSTORE_842_COMPRESS_DEFAULT
-	default "zstd" if PSTORE_ZSTD_COMPRESS_DEFAULT
+config PSTORE_COMPRESS_CRYPTO_DEFAULT
+	string "Crypto API compression algorithm"
+	depends on PSTORE_COMPRESS_CRYPTO
+	default "zstd"
+	help
+	  This option chooses the default active compression algorithm,
+	  and can be changed at boot with "pstore.compress=..." on the
+	  kernel command line. The chosen compression algorithm needs to
+	  be available to the crypto subsystem for it to be usable by
+	  pstore. For example, "zstd" needs CONFIG_CRYPTO_ZSTD, "deflate"
+	  needs CONFIG_CRYPTO_DEFLATE, etc.
 
 config PSTORE_CONSOLE
 	bool "Log kernel console messages"
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index ef0bc3ae161b..1f01c4b904fc 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -16,15 +16,6 @@
 #include <linux/console.h>
 #include <linux/module.h>
 #include <linux/pstore.h>
-#if IS_ENABLED(CONFIG_PSTORE_LZO_COMPRESS)
-#include <linux/lzo.h>
-#endif
-#if IS_ENABLED(CONFIG_PSTORE_LZ4_COMPRESS) || IS_ENABLED(CONFIG_PSTORE_LZ4HC_COMPRESS)
-#include <linux/lz4.h>
-#endif
-#if IS_ENABLED(CONFIG_PSTORE_ZSTD_COMPRESS)
-#include <linux/zstd.h>
-#endif
 #include <linux/crypto.h>
 #include <linux/string.h>
 #include <linux/timer.h>
@@ -80,9 +71,9 @@ static char *backend;
 module_param(backend, charp, 0444);
 MODULE_PARM_DESC(backend, "specific backend to use");
 
-static char *compress =
-#ifdef CONFIG_PSTORE_COMPRESS_DEFAULT
-		CONFIG_PSTORE_COMPRESS_DEFAULT;
+static char *compress __ro_after_init =
+#ifdef CONFIG_PSTORE_COMPRESS_CRYPTO_DEFAULT
+		CONFIG_PSTORE_COMPRESS_CRYPTO_DEFAULT;
 #else
 		NULL;
 #endif
@@ -166,18 +157,18 @@ static bool pstore_cannot_block_path(enum kmsg_dump_reason reason)
 static int pstore_compress(const void *in, void *out,
 			   unsigned int inlen, unsigned int outlen)
 {
-	int ret;
+	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS_CRYPTO)) {
+		int ret;
 
-	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS))
-		return -EINVAL;
-
-	ret = crypto_comp_compress(tfm, in, inlen, out, &outlen);
-	if (ret) {
-		pr_err("crypto_comp_compress failed, ret = %d!\n", ret);
-		return ret;
+		ret = crypto_comp_compress(tfm, in, inlen, out, &outlen);
+		if (ret) {
+			pr_err("crypto_comp_compress failed, ret = %d!\n", ret);
+			return ret;
+		}
+		return outlen;
 	}
 
-	return outlen;
+	return -EINVAL;
 }
 
 static void allocate_buf_for_compression(void)
@@ -187,7 +178,7 @@ static void allocate_buf_for_compression(void)
 	char *buf;
 
 	/* Skip if not built-in or compression backend not selected yet. */
-	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !compress)
+	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS_NONE) || !compress)
 		return;
 
 	/* Skip if no pstore backend yet or compression init already done. */
@@ -226,7 +217,7 @@ static void allocate_buf_for_compression(void)
 
 static void free_buf_for_compression(void)
 {
-	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && tfm) {
+	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS_CRYPTO) && tfm) {
 		crypto_free_comp(tfm);
 		tfm = NULL;
 	}
@@ -578,7 +569,7 @@ static void decompress_record(struct pstore_record *record)
 	int unzipped_len;
 	char *unzipped, *workspace;
 
-	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !record->compressed)
+	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS_NONE) || !record->compressed)
 		return;
 
 	/* Only PSTORE_TYPE_DMESG support compression. */
-- 
2.34.1

