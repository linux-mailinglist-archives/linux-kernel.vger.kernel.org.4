Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23C36020EA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiJRCJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiJRCIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:08:49 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7978F43AF0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:08:36 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g8-20020a17090a128800b0020c79f987ceso15948937pja.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbYz18T6bZpWW8vOJjiPrzs7fsULyDP/1+meWjyG7ZE=;
        b=KIJuGjNT3LS85ZDwhI1QK3bDVaC4AE+6gjeWhM49s+JH+xpYFFcPNFFUvO5z97nWc8
         3qHYOvMSCMWKhgCUK8jfsgwo94QfZqPwZA0oEE9N75VRfhpgSur4kI1JiPgUTYXCuRtD
         WfbWOlFE7BmzofG7f2xA8rqRZNKp1xI7XjZ8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbYz18T6bZpWW8vOJjiPrzs7fsULyDP/1+meWjyG7ZE=;
        b=i3Eo8zeidRdxDb3qtigctA6e8y3ZNqx6LWDtc/mxVBE3FBQ13QsIaI4SP2HLGrw5k8
         tugQrzF5NpWGOMeNEOF+mE2TqOwS9uPQyKZTpKXCmzHWMKVeT4vG2UAHcuam4XKGRwaT
         4ugjMBREKVbag37FVherBYsVN5PBKfXy3u1I66Cu+UD0raeQhKuUPPgM3Mdpv80XpUzQ
         JICnNsWy4H1cGMIc2+7px151MJThBBBWO5qey8LRrPyKTrE6hjBGgxRiUu1zJSM9JQSf
         ZgSCPtoJZfhWgf2p7ZaSBXqCKLon/hFWFPqBUpLqT8/CtMI9/WlO7omn91tfjY+88hwG
         mBIw==
X-Gm-Message-State: ACrzQf2AIE/A+n3SSbQXUQD3Bi2gUKdYwhnyDlS6KY8oCsJmI6gooWir
        eWEiMLfhEj3gaEzVSwhfyy6Bew==
X-Google-Smtp-Source: AMsMyM5bR1UuDGWR0RD1MGC8amr4BEf8QetflWgXyBl3g52ZWS8Y8D0p6XKIXe5AgoTtNKQKFdQARg==
X-Received: by 2002:a17:903:11c3:b0:17a:e62:16e8 with SMTP id q3-20020a17090311c300b0017a0e6216e8mr612463plh.137.1666058899859;
        Mon, 17 Oct 2022 19:08:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c8-20020a170903234800b0017d061a6119sm7312776plh.116.2022.10.17.19.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:08:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Nick Terrell <terrelln@fb.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] pstore: Remove worse-case compression size logic
Date:   Mon, 17 Oct 2022 19:08:09 -0700
Message-Id: <20221018020815.2872331-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018020519.never.337-kees@kernel.org>
References: <20221018020519.never.337-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5455; h=from:subject; bh=+tMHCZOTPIvRa0mUTcXlg2VCSU1nRw7kMkBTASHQke4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTgqMQlVArORJD6vwQmAGDxw2yPxs+T03ESP4BWrt w84R/kSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY04KjAAKCRCJcvTf3G3AJgQSD/ wNUsf8repH9xHlLCpz/CMMet6C6UcVL2z7D/aT4lcyu0GVdX/RrntIC8lEj7SJN7EQdzrZEHkqjPOe bklsLC/TaHdCVVYaJQnX921X+jU7Abf6S+prdr067yp1N1/I744jauGm99Sj38EMNad1xrEvn1PJcn SDcoAjNiYgS/FZtEjfewNPmZ0bXFioCpc0SCgfbeO12BThhkCI33MWC010Ihjupoytpbs8Ks8bB8xT cU+YxWO/rh4RhIkKO/Bl7vXnRtDFnz2XqwaoDrQjGYVo7YB9e2K1SIefAvQMRyjrWi0V0PsuTNn/zc j5t3pDG2o+Y/jTywGSZqdAsMvQOl6jjHwG+jUswIrjtH6XwAZQXbk6nsQwSuSuqZq69Qs+5rQJEBes OpxlD5SOpU03hzZnFdId1wn/YWs7G58Q6hDr3Bv4dh9xKWJ5LcvrR+4gdI4oV9/istb5krrPYzDFtB pErJjTAD5Sz9g16VL6U8pNSZpZVw3hXsP6ShpA7Dazjv5DExoJ4qsgco7mprLEnEoK/Ge72MQjHq51 JSzVidOSLPIq+FMcAALcrw8TMCFWAaZuClsddg6CJmkAw4KtdYqIym5otPCNS1iN/lhqCRx/fkCqXn /ahzhUBhLVdmH5t+vkcWyNiDr8Cd7Tdt994hwFqcjd8njG+BHaRDiFNSZfvw==
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

The worst case compression size is always the size of the uncompressed
data itself so avoid perfectly optimizing the oops buffer size. Hugely
simplifies the code.

Cc: Tony Luck <tony.luck@intel.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Nick Terrell <terrelln@fb.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c | 144 +++----------------------------------------
 1 file changed, 9 insertions(+), 135 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index cbc0b468c1ab..ef0bc3ae161b 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -97,11 +97,6 @@ MODULE_PARM_DESC(kmsg_bytes, "amount of kernel log to snapshot (in bytes)");
 /* Compression parameters */
 static struct crypto_comp *tfm;
 
-struct pstore_zbackend {
-	int (*zbufsize)(size_t size);
-	const char *name;
-};
-
 static char *big_oops_buf;
 static size_t big_oops_buf_sz;
 
@@ -168,105 +163,6 @@ static bool pstore_cannot_block_path(enum kmsg_dump_reason reason)
 	}
 }
 
-#if IS_ENABLED(CONFIG_PSTORE_DEFLATE_COMPRESS)
-static int zbufsize_deflate(size_t size)
-{
-	size_t cmpr;
-
-	switch (size) {
-	/* buffer range for efivars */
-	case 1000 ... 2000:
-		cmpr = 56;
-		break;
-	case 2001 ... 3000:
-		cmpr = 54;
-		break;
-	case 3001 ... 3999:
-		cmpr = 52;
-		break;
-	/* buffer range for nvram, erst */
-	case 4000 ... 10000:
-		cmpr = 45;
-		break;
-	default:
-		cmpr = 60;
-		break;
-	}
-
-	return (size * 100) / cmpr;
-}
-#endif
-
-#if IS_ENABLED(CONFIG_PSTORE_LZO_COMPRESS)
-static int zbufsize_lzo(size_t size)
-{
-	return lzo1x_worst_compress(size);
-}
-#endif
-
-#if IS_ENABLED(CONFIG_PSTORE_LZ4_COMPRESS) || IS_ENABLED(CONFIG_PSTORE_LZ4HC_COMPRESS)
-static int zbufsize_lz4(size_t size)
-{
-	return LZ4_compressBound(size);
-}
-#endif
-
-#if IS_ENABLED(CONFIG_PSTORE_842_COMPRESS)
-static int zbufsize_842(size_t size)
-{
-	return size;
-}
-#endif
-
-#if IS_ENABLED(CONFIG_PSTORE_ZSTD_COMPRESS)
-static int zbufsize_zstd(size_t size)
-{
-	return zstd_compress_bound(size);
-}
-#endif
-
-static const struct pstore_zbackend *zbackend __ro_after_init;
-
-static const struct pstore_zbackend zbackends[] = {
-#if IS_ENABLED(CONFIG_PSTORE_DEFLATE_COMPRESS)
-	{
-		.zbufsize	= zbufsize_deflate,
-		.name		= "deflate",
-	},
-#endif
-#if IS_ENABLED(CONFIG_PSTORE_LZO_COMPRESS)
-	{
-		.zbufsize	= zbufsize_lzo,
-		.name		= "lzo",
-	},
-#endif
-#if IS_ENABLED(CONFIG_PSTORE_LZ4_COMPRESS)
-	{
-		.zbufsize	= zbufsize_lz4,
-		.name		= "lz4",
-	},
-#endif
-#if IS_ENABLED(CONFIG_PSTORE_LZ4HC_COMPRESS)
-	{
-		.zbufsize	= zbufsize_lz4,
-		.name		= "lz4hc",
-	},
-#endif
-#if IS_ENABLED(CONFIG_PSTORE_842_COMPRESS)
-	{
-		.zbufsize	= zbufsize_842,
-		.name		= "842",
-	},
-#endif
-#if IS_ENABLED(CONFIG_PSTORE_ZSTD_COMPRESS)
-	{
-		.zbufsize	= zbufsize_zstd,
-		.name		= "zstd",
-	},
-#endif
-	{ }
-};
-
 static int pstore_compress(const void *in, void *out,
 			   unsigned int inlen, unsigned int outlen)
 {
@@ -291,36 +187,31 @@ static void allocate_buf_for_compression(void)
 	char *buf;
 
 	/* Skip if not built-in or compression backend not selected yet. */
-	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !zbackend)
+	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !compress)
 		return;
 
 	/* Skip if no pstore backend yet or compression init already done. */
 	if (!psinfo || tfm)
 		return;
 
-	if (!crypto_has_comp(zbackend->name, 0, 0)) {
-		pr_err("Unknown compression: %s\n", zbackend->name);
-		return;
-	}
-
-	size = zbackend->zbufsize(psinfo->bufsize);
-	if (size <= 0) {
-		pr_err("Invalid compression size for %s: %d\n",
-		       zbackend->name, size);
+	if (!crypto_has_comp(compress, 0, 0)) {
+		pr_err("Unknown compression: %s\n", compress);
 		return;
 	}
 
+	/* Worst-case compression should never be more than uncompressed. */
+	size = psinfo->bufsize;
 	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf) {
 		pr_err("Failed %d byte compression buffer allocation for: %s\n",
-		       size, zbackend->name);
+		       size, compress);
 		return;
 	}
 
-	ctx = crypto_alloc_comp(zbackend->name, 0, 0);
+	ctx = crypto_alloc_comp(compress, 0, 0);
 	if (IS_ERR_OR_NULL(ctx)) {
 		kfree(buf);
-		pr_err("crypto_alloc_comp('%s') failed: %ld\n", zbackend->name,
+		pr_err("crypto_alloc_comp('%s') failed: %ld\n", compress,
 		       PTR_ERR(ctx));
 		return;
 	}
@@ -330,7 +221,7 @@ static void allocate_buf_for_compression(void)
 	big_oops_buf_sz = size;
 	big_oops_buf = buf;
 
-	pr_info("Using crash dump compression: %s\n", zbackend->name);
+	pr_info("Using crash dump compression: %s\n", compress);
 }
 
 static void free_buf_for_compression(void)
@@ -818,27 +709,10 @@ static void pstore_timefunc(struct timer_list *unused)
 	pstore_timer_kick();
 }
 
-static void __init pstore_choose_compression(void)
-{
-	const struct pstore_zbackend *step;
-
-	if (!compress)
-		return;
-
-	for (step = zbackends; step->name; step++) {
-		if (!strcmp(compress, step->name)) {
-			zbackend = step;
-			return;
-		}
-	}
-}
-
 static int __init pstore_init(void)
 {
 	int ret;
 
-	pstore_choose_compression();
-
 	/*
 	 * Check if any pstore backends registered earlier but did not
 	 * initialize compression because crypto was not ready. If so,
-- 
2.34.1

