Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F84C6020E8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiJRCJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiJRCIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:08:42 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC238422C3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:08:39 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id h13so12772067pfr.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CzAnMvFQDLPHvwatG/USFLXonFnc4UppdnrxHWRO70=;
        b=KwORkaYqVW4DcwQBe8fKyiUBV3lL2VI45MbBjyL5evrubabQAAlJRmEOYoDNPnKOoo
         IOosyef4qN2cVWORGlutYO9mKfNcT+WQs7HdI9dtzAE52Yfec3xVxA3WT2S73LIqj7EE
         T59NJkFkzwgnTSUFSnQR8PYEwUGY0Ul3q8MYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CzAnMvFQDLPHvwatG/USFLXonFnc4UppdnrxHWRO70=;
        b=wYStaSzOLLl7cULo8Lxx/k+5l+lYa3/iazu638Ql2q5TQE6JJ3FagKi1uQGtQhNNrf
         8tmrEXQUgeAUqD05i98zJbQPx/I5eW8rHyakJLQOb9J2eZ0XE9+beHnnPUJIJeM09WGF
         USviWoJN0oPYwwxGKLC2DuW9xBbKOwXpdYKYq1bEDJLDwp5HwBWK8ope07fZ8rCjh9We
         4PECXriNqpnJvIpT9FJa1Ux7LQqsJ0L1AMgylGdswXsu/gLzGtg0MLT9O/TmDnXhTsU/
         xxvteRTULL+CHAhh04Xmq0jv/eoxn66jiCd8wko0K59L/Vnr3oKhTzP550WodTod+Yrk
         f6kg==
X-Gm-Message-State: ACrzQf0hzbLDtik2bzfRDVsE9utwsvUp0MR7IRxwuih7WexAd1W9c9aM
        MAoTcv9gCtfCLRLj/NWYFuO5vQ==
X-Google-Smtp-Source: AMsMyM42u1mNW0p5VK4cM4i2NzHA/27NsVEfd9Qw1q5ppuQOHIT1iM9sM9cmyu5y2JRmKhPxecsw6Q==
X-Received: by 2002:a05:6a00:150c:b0:563:9f05:bd68 with SMTP id q12-20020a056a00150c00b005639f05bd68mr806021pfu.44.1666058901438;
        Mon, 17 Oct 2022 19:08:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id iw7-20020a170903044700b001782580ce9csm7279968plb.249.2022.10.17.19.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:08:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-hardening@vger.kernel.org, Nick Terrell <terrelln@fb.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] pstore: Refactor compression initialization
Date:   Mon, 17 Oct 2022 19:08:12 -0700
Message-Id: <20221018020815.2872331-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018020519.never.337-kees@kernel.org>
References: <20221018020519.never.337-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3635; h=from:subject; bh=GnPW7cHJLHzp4Ur4fA7Uqr/d5LRg10HGm2sjpwP9wQ4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTgqMbJcThe30sb8XabMHTpGedN4xQTi7dpmCn6Ia 6xJIvlKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY04KjAAKCRCJcvTf3G3AJj2ID/ 0cbUhMbp27GjX1utSX7bmwpWuk4vCfS965dpQWibESAGOrzxATO7v024sS07ZvcZhimNPxdBuP0l1R 3Nb/Wf+jhy+2st1CZcmkQtQJlBcQnfoCF0nYFPOFXScITibR7jFNp1tYOffw3ToSnRFenpS1yFGzdI FAlrcfhYIH4+ecaHqUzTTncAwgv0rftKiAS8UQwJYD9b0MhFt0ZhQe+WqzycDyS8Wh1dGwxGVXF9ni d6FFY93IHvoN6YVGpHwYOiiTWq4OPIbrz7K4qXhGhp3c4/EwIcwdF7wAAQWDoZCD1RdicyChazHNuO LYDmdF3SBcWKX4D40Z+F4ny4Yj1dkr0eYGd5CwOH/StDEcPLFZnxmENrCefQ+YB5BuYbroWeUCClN7 /huBIV8E30nxGUp7wlbDQdy3068Uern1UJcYOCa62BN2aEIWFnrz7GodxvaUPiLiS57GsABPVfDzX5 IoXCLhaAYGhG+6tlC9zY9nMRWDNDEB0drPm6ldJx7BsfmBvCz/hlHBlXWCLebKEp7e2JqdBHrFjxMp KlQVqhaDJcp5WOGPXeC+H772pVOWRqRRB63TFlVuglsrakUvEbjSasz/GJCqe2z779Cn9O6G3wONHH PGi5WMfJM0cApmg282NFC9bLeQ4x8EYVHxb4HiG7FB/pXc2402UlGkIL5oLg==
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

In preparation for calling zstd library compression routines, split the
crypto-specific initialization into a separate init routine.

Cc: Tony Luck <tony.luck@intel.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c | 71 +++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 28 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 210a4224edb4..4d883dc2e8a7 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -178,48 +178,29 @@ static int pstore_compress(const void *in, void *out,
 	return -EINVAL;
 }
 
-static void allocate_buf_for_compression(void)
+static int allocate_crypto_buf(void)
 {
 	struct crypto_comp *ctx;
-	int size;
-	char *buf;
 
-	/* Skip if not built-in or compression backend not selected yet. */
-	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS_NONE) || !compress)
-		return;
-
-	/* Skip if no pstore backend yet or compression init already done. */
-	if (!psinfo || tfm)
-		return;
+	/* Skip if compression init already done. */
+	if (tfm)
+		return 0;
 
 	if (!crypto_has_comp(compress, 0, 0)) {
 		pr_err("Unknown compression: %s\n", compress);
-		return;
-	}
-
-	/* Worst-case compression should never be more than uncompressed. */
-	size = psinfo->bufsize;
-	buf = kmalloc(size, GFP_KERNEL);
-	if (!buf) {
-		pr_err("Failed %d byte compression buffer allocation for: %s\n",
-		       size, compress);
-		return;
+		return -EINVAL;
 	}
 
 	ctx = crypto_alloc_comp(compress, 0, 0);
 	if (IS_ERR_OR_NULL(ctx)) {
-		kfree(buf);
 		pr_err("crypto_alloc_comp('%s') failed: %ld\n", compress,
 		       PTR_ERR(ctx));
-		return;
+		return -ENOMEM;
 	}
-
-	/* A non-NULL big_oops_buf indicates compression is available. */
 	tfm = ctx;
-	big_oops_buf_sz = size;
-	big_oops_buf = buf;
 
-	pr_info("Using crash dump compression: %s\n", compress);
+	pr_info("Using crash dump compression: crypto API %s\n", compress);
+	return 0;
 }
 
 static void free_buf_for_compression(void)
@@ -233,6 +214,38 @@ static void free_buf_for_compression(void)
 	big_oops_buf_sz = 0;
 }
 
+static void allocate_buf_for_compression(void)
+{
+	char *buf;
+	int rc;
+
+	/* Skip if not built-in or compression backend not selected yet. */
+	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS_NONE) || !compress)
+		return;
+
+	/* Skip if no pstore backend yet. */
+	if (!psinfo)
+		return;
+
+	/* Initialize compression routines. */
+	rc = allocate_crypto_buf();
+	if (rc)
+		goto fail;
+
+	/* Create common buffer for compression work. */
+	buf = kmalloc(psinfo->bufsize, GFP_KERNEL);
+	if (!buf)
+		goto fail;
+
+	/* A non-NULL big_oops_buf indicates compression is available. */
+	big_oops_buf_sz = psinfo->bufsize;
+	big_oops_buf = buf;
+	return;
+
+fail:
+	free_buf_for_compression();
+}
+
 /*
  * Called when compression fails, since the printk buffer
  * would be fetched for compression calling it again when
@@ -589,6 +602,7 @@ static void decompress_record(struct pstore_record *record)
 {
 	size_t unzipped_len;
 	char *unzipped, *workspace;
+	int rc;
 
 	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS_NONE) || !record->compressed)
 		return;
@@ -612,7 +626,8 @@ static void decompress_record(struct pstore_record *record)
 	if (!workspace)
 		return;
 
-	if (pstore_decompress_crypto(record, workspace, &unzipped_len) != 0) {
+	rc = pstore_decompress_crypto(record, workspace, &unzipped_len);
+	if (rc) {
 		kfree(workspace);
 		return;
 	}
-- 
2.34.1

