Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751A56020E4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiJRCIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiJRCIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:08:36 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954E32DC4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:08:30 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id fw14so12641778pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8o/3L/7nu8yqSqN2t7ynhTHNqc6zN3rpINeuVtJh23c=;
        b=Ejf9T48sPy2SQkDkKO3qeRvLhxySNSJCnDu6Xwwm0S7fucUsPGGdILc95lmBN0JR7m
         gYaf/SfNGV6HQ6L9OtG6dvMIzzfhmlStyUx496rhLALi/gn3WEbiVIF9qqOQOYX3a6PM
         SssrKHd8ghM4DgybtJLu0nA1WEx8YJwQquFFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8o/3L/7nu8yqSqN2t7ynhTHNqc6zN3rpINeuVtJh23c=;
        b=IOgjHiPM2udKCIpnLl2u7diTeuIwKVWg0TLqU1Ye8jjiyLJDuBzBrGHw7imAq4i+Iu
         3S9FIc2s5yhVy5FoqZgXi5KYCuGuUahi8r27X9ERswF+iLTPARbuqB3Ir1+vp++k5hIj
         SFVr6hZHfSKzxTmYOD4UubAxXbmORsUSNj7OewlP4/I6BeuVrnuOrW2DnqqX6JJrGKYX
         pBOQbRsYZsWf/oWhbEqotAU/0Z8tm9oXUjmJYQOcdHcU/4zRZakMv4OIv+QtxhVQ62zZ
         3SpL0ycz5KSIxW6G8KvxD4MjwNiHV3IS0RwgiT4m20UEAfUcoa+9X2sPQ+LY/+Jww7Fy
         F01g==
X-Gm-Message-State: ACrzQf1ANeHApCmDbxIAb8bO15zdJXT+OYTKMsN2AMN7OQ/sECIdTva9
        O17QkEDzsGy0XUY3mUIZ777z2g==
X-Google-Smtp-Source: AMsMyM6J95gTGuLusRFaCvMsJ0bdX7wowAFXXKCq11iWsbGo/OW/s7BeFJ9B9qNpiVJe61pC54CP5w==
X-Received: by 2002:a17:902:d484:b0:17f:7437:565d with SMTP id c4-20020a170902d48400b0017f7437565dmr630248plg.154.1666058898335;
        Mon, 17 Oct 2022 19:08:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d4-20020a631d04000000b00460d89df1f1sm6797003pgd.57.2022.10.17.19.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:08:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-hardening@vger.kernel.org, Nick Terrell <terrelln@fb.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] pstore: Use size_t for compress/decompression type widths
Date:   Mon, 17 Oct 2022 19:08:11 -0700
Message-Id: <20221018020815.2872331-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018020519.never.337-kees@kernel.org>
References: <20221018020519.never.337-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3370; h=from:subject; bh=d80Gw6VCQNtp9Ez6pYN9gROZhqnl6PYG6krL4B0B4o4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTgqMos88G1DeCsiRQXnCR4zXLwb9UDI3ISAB1F4o GocmFImJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY04KjAAKCRCJcvTf3G3AJn12D/ 0aQ1ZAKOJEY9arwChs4OA2uRV6oYgtpEV0Vqbf1CrNEqoszswyKm83dWZjIsQfDaPkTVXUrt6AaAZh KhXqXry8mtOn2Q/8OvPkeiux7ChBtIMTyYzbb82dVlxgiTZF/MbOh/O0HHOHy40gXWM4qC8UzEnbMP uhk/JxGuOJNsItMrrG+h+z4sr7eN16+mpbjEGqnMbyTm0CaT1zh3oLULl0eYluGQOlfKBIwygVuWf2 Zuca9gRFaF+R5kukMrkDAaS9RTJT8z3znNqCwGKh1Wi6/1JZxmNNmq0YraSEJOEEejK0oEX8GLE0JV EgMkXBbQSG0X5cLREwp7RRC7Ej5T6OuKJMVqAP8eONNDoYls82NtGDB0mQkPDTVj+0cRHNt/6CXt+H UKM6TqbO9HBC8iBW4iYp/pr78AHpecShCoGdvgewKjJUxkF32lHh92QjTaNhcWp5Y4a4PNIu4eM+0R KX+HxTicQMjInWMcHgBfKfROug3RZeANjLebFqVC2rvESIcgiUmevJTLRQ4tNu5MfD9uhLfMps8jfO HVPHeOiGO3p29tj9QsMNRBSnZ+k5O/qeR1Lk7NWTHbqJ94e7sTubSLZblRTgM7U3AGOUbEgSrNu7DB +e7GlQxFJ4q/mulBqu19pB7ZbgBQtp4qKvHdgqnzU5feIHA2nmD+MH+HY4MQ==
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

In preparation for adding direct library calls for zstd, refactor
routines to use normalized compress/decompression type widths of size_t.

Cc: Tony Luck <tony.luck@intel.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c | 47 ++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 1f01c4b904fc..210a4224edb4 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -155,17 +155,24 @@ static bool pstore_cannot_block_path(enum kmsg_dump_reason reason)
 }
 
 static int pstore_compress(const void *in, void *out,
-			   unsigned int inlen, unsigned int outlen)
+			   size_t inlen, size_t *outlen)
 {
 	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS_CRYPTO)) {
+		unsigned int crypto_outlen;
 		int ret;
 
-		ret = crypto_comp_compress(tfm, in, inlen, out, &outlen);
+		if (inlen > UINT_MAX || *outlen > UINT_MAX)
+			return -EINVAL;
+
+		crypto_outlen = *outlen;
+		ret = crypto_comp_compress(tfm, in, inlen, out, &crypto_outlen);
 		if (ret) {
 			pr_err("crypto_comp_compress failed, ret = %d!\n", ret);
 			return ret;
 		}
-		return outlen;
+
+		*outlen = crypto_outlen;
+		return 0;
 	}
 
 	return -EINVAL;
@@ -297,7 +304,6 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 		char *dst;
 		size_t dst_size;
 		int header_size;
-		int zipped_len = -1;
 		size_t dump_size;
 		struct pstore_record record;
 
@@ -327,11 +333,11 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 			break;
 
 		if (big_oops_buf) {
-			zipped_len = pstore_compress(dst, psinfo->buf,
-						header_size + dump_size,
-						psinfo->bufsize);
+			size_t zipped_len = psinfo->bufsize;
 
-			if (zipped_len > 0) {
+			if (pstore_compress(dst, psinfo->buf,
+					    header_size + dump_size,
+					    &zipped_len) == 0) {
 				record.compressed = true;
 				record.size = zipped_len;
 			} else {
@@ -563,10 +569,25 @@ void pstore_unregister(struct pstore_info *psi)
 }
 EXPORT_SYMBOL_GPL(pstore_unregister);
 
-static void decompress_record(struct pstore_record *record)
+static int pstore_decompress_crypto(struct pstore_record *record, char *workspace, size_t *outlen)
 {
+	unsigned int crypto_outlen = *outlen;
 	int ret;
-	int unzipped_len;
+
+	ret = crypto_comp_decompress(tfm, record->buf, record->size,
+				     workspace, &crypto_outlen);
+	if (ret) {
+		pr_err("crypto_comp_decompress failed, ret = %d!\n", ret);
+		return 0;
+	}
+
+	*outlen = crypto_outlen;
+	return 0;
+}
+
+static void decompress_record(struct pstore_record *record)
+{
+	size_t unzipped_len;
 	char *unzipped, *workspace;
 
 	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS_NONE) || !record->compressed)
@@ -591,11 +612,7 @@ static void decompress_record(struct pstore_record *record)
 	if (!workspace)
 		return;
 
-	/* After decompression "unzipped_len" is almost certainly smaller. */
-	ret = crypto_comp_decompress(tfm, record->buf, record->size,
-					  workspace, &unzipped_len);
-	if (ret) {
-		pr_err("crypto_comp_decompress failed, ret = %d!\n", ret);
+	if (pstore_decompress_crypto(record, workspace, &unzipped_len) != 0) {
 		kfree(workspace);
 		return;
 	}
-- 
2.34.1

