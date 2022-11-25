Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4432763845A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 08:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiKYHPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 02:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKYHO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:14:56 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5B42C65A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:14:51 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id b12so5454086wrn.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joDj7YH7FrMNDdWO2mycsfq4f2JecKmI31ui9o19mv0=;
        b=G4GmtcUSdHjAjOy+qcTZHhITfJ9tnuRoqOTz8z/eKbAF2Go26N60J6f/bFB4S/uZ1p
         XE7nAebxBR4+bXUB5iehIf4+gm2ncaQ4guspB4RuZ5IP4jRmiA4RY2bHRv5r6asN+9s5
         m7iWN+Gu7kmazQs1aJDLzn7gwBCCogb1Ks+1i9xJ9zcexkiagkeWKAlw5ygeYZt8joU+
         UWkgw6qN7vy33DcAYF+yqsFNXqDGvRqptPG7i9ZvIwZgSzxZ9xWuEbTQoiYfvRia30yM
         h12njBAYH1uXKyzgZRTvHxLJ6pX0Xrh3v/uawyY16p9h1MZ17CTNJnnolFCTn8RGZf8p
         ZUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joDj7YH7FrMNDdWO2mycsfq4f2JecKmI31ui9o19mv0=;
        b=tc7TDO+7NlmC3dk72w9rTFLjmS5qJFwby6jPoWSRef1p/4d2imWwWqPjGXGsrEStyX
         xzNazaxx3ppahs6rzA3d2uLf3P83yyeEZ1GogtYMU7F3juLKK5RPP+U8XIy9KpkcHJIz
         8+u7L8ZrA+YBky9sjaZHbHgr0N9Z5vc7BrGAVCxPBeU7B8SJfZvBf9IZr7NDpPmSBerv
         BGpyKyKWr67CgltsDK0wrpYWA0Kligc6pHbQRZGNdSwUEOSOibGbd5Sup7pT19FCIjSA
         vz9DukLfncOBAZHMuph2/ikmStxmkuhJgAUbYrKzqtaXiRqB43v0vcFE2aclvBlfrrwR
         wisg==
X-Gm-Message-State: ANoB5pnsCesZqLe0lSi3ZIQHM7nc1YUBtfMdZodfLKXcsK++HfJyUxAX
        pdPu4zt8jLOdxrNpb2o1V8WJYAQDtlFJPg==
X-Google-Smtp-Source: AA0mqf55gcXXY5azkkF3zQVinEUiq0TPRlrjzsqtQYWZo31+UCvorFUlj2F2j/nIiAQ5V2hQgjg82w==
X-Received: by 2002:a5d:4d09:0:b0:235:e330:71ba with SMTP id z9-20020a5d4d09000000b00235e33071bamr22302137wrt.213.1669360490621;
        Thu, 24 Nov 2022 23:14:50 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003cfd4cf0761sm9108444wmq.1.2022.11.24.23.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 23:14:50 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 06/10] misc: fastrpc: Rework fastrpc_req_munmap
Date:   Fri, 25 Nov 2022 07:14:01 +0000
Message-Id: <20221125071405.148786-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221125071405.148786-1-srinivas.kandagatla@linaro.org>
References: <20221125071405.148786-1-srinivas.kandagatla@linaro.org>
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

From: Abel Vesa <abel.vesa@linaro.org>

Move the lookup of the munmap request to the fastrpc_req_munmap and pass
on only the buf to the lower level fastrpc_req_munmap_impl. That way
we can use the lower level fastrpc_req_munmap_impl on error path in
fastrpc_req_mmap to free the buf without searching for the munmap
request it belongs to.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 47 +++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 0d9f1eb9a0ed..a1e916902deb 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1630,30 +1630,14 @@ static int fastrpc_get_dsp_info(struct fastrpc_user *fl, char __user *argp)
 	return 0;
 }
 
-static int fastrpc_req_munmap_impl(struct fastrpc_user *fl,
-				   struct fastrpc_req_munmap *req)
+static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *buf)
 {
 	struct fastrpc_invoke_args args[1] = { [0] = { 0 } };
-	struct fastrpc_buf *buf = NULL, *iter, *b;
 	struct fastrpc_munmap_req_msg req_msg;
 	struct device *dev = fl->sctx->dev;
 	int err;
 	u32 sc;
 
-	spin_lock(&fl->lock);
-	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
-		if ((iter->raddr == req->vaddrout) && (iter->size == req->size)) {
-			buf = iter;
-			break;
-		}
-	}
-	spin_unlock(&fl->lock);
-
-	if (!buf) {
-		dev_err(dev, "mmap not in list\n");
-		return -EINVAL;
-	}
-
 	req_msg.pgid = fl->tgid;
 	req_msg.size = buf->size;
 	req_msg.vaddr = buf->raddr;
@@ -1679,12 +1663,29 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl,
 
 static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 {
+	struct fastrpc_buf *buf = NULL, *iter, *b;
 	struct fastrpc_req_munmap req;
+	struct device *dev = fl->sctx->dev;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
 
-	return fastrpc_req_munmap_impl(fl, &req);
+	spin_lock(&fl->lock);
+	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
+		if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
+			buf = iter;
+			break;
+		}
+	}
+	spin_unlock(&fl->lock);
+
+	if (!buf) {
+		dev_err(dev, "mmap\t\tpt 0x%09llx [len 0x%08llx] not in list\n",
+			req.vaddrout, req.size);
+		return -EINVAL;
+	}
+
+	return fastrpc_req_munmap_impl(fl, buf);
 }
 
 static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
@@ -1693,7 +1694,6 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_buf *buf = NULL;
 	struct fastrpc_mmap_req_msg req_msg;
 	struct fastrpc_mmap_rsp_msg rsp_msg;
-	struct fastrpc_req_munmap req_unmap;
 	struct fastrpc_phy_page pages;
 	struct fastrpc_req_mmap req;
 	struct device *dev = fl->sctx->dev;
@@ -1755,11 +1755,8 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	spin_unlock(&fl->lock);
 
 	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
-		/* unmap the memory and release the buffer */
-		req_unmap.vaddrout = buf->raddr;
-		req_unmap.size = buf->size;
-		fastrpc_req_munmap_impl(fl, &req_unmap);
-		return -EFAULT;
+		err = -EFAULT;
+		goto err_assign;
 	}
 
 	dev_dbg(dev, "mmap\t\tpt 0x%09lx OK [len 0x%08llx]\n",
@@ -1767,6 +1764,8 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 
 	return 0;
 
+err_assign:
+	fastrpc_req_munmap_impl(fl, buf);
 err_invoke:
 	fastrpc_buf_free(buf);
 
-- 
2.25.1

