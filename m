Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F2F63845B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 08:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiKYHPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 02:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKYHO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:14:58 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26A52CDCE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:14:54 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i12so5499924wrb.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veNnSQpqDWrWkaDlj9IuilDG/4lWQ8W0nq0CdjMpmho=;
        b=y0hcsX0GI6/STyNPFwkhgzSZpa3teB/MhpMx6UOIkgXcgfYFK8xpWOK5wX+VfYzwBS
         ID/urX0/cIOfPiDECl8y9BUJfhY2T01lRpTjSgbLU6TEe/tUJdPCGTZ4UTVy3m7mJsP1
         7sFwLK+92a5L8DU9x/Z/rCWbhCCDcNlDY4AxPqF5rsInU0n5kKJtVEMUCbpF8OzoVu8a
         Opw9XplJ0nGSVwofuocUVA2Eig8/aORV5h9slBz959+y5dIwi4peoPGlA0G63MfPdCU/
         Qqp3Rc/HMVBwuUgS4xA9VMHYz+eYrmAc7o2nob18NMdgAzFT52YQlQciWnqHXggTmLeO
         456A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=veNnSQpqDWrWkaDlj9IuilDG/4lWQ8W0nq0CdjMpmho=;
        b=4s/HT3po4kYFgH8mcHEHSA6a7b/Ik95s2O37BUzqluKAyr/rDG3set0iUrG9MAGtt1
         LXQeNGtKAR3op3nCnVKWdJS4etzyGh6Mtg/8ex6H0nBboccZAxQ7CRWZd0IV6NvPAusO
         dyfyL/DDJE6CvBMYZrloeaS6/bOxA/1BAHeFz2m/fDGIRDVZfwXmkCTS6WHuPTGJ06dY
         8TarWKRYlBZo/Lkcn/gfgpNr+eW7ZPp4q6oKi6GAPJ4xz8iEkKwFZHTqU/ribZGXgME0
         GHzqyS6ScVwb9A5jMb9yZV/sIxFzy3E5GYZlnvbCj/+6xYgFjefm3mO4HOFZ4/pf2wGO
         fM3w==
X-Gm-Message-State: ANoB5pnn6cocnVGHBH+gjbpJwOvfGfBz7FOMu2d78hlg54Q/2koo4Qfd
        EIgdttXu9QV3dX2azD3maEz3fcJNRqMddQ==
X-Google-Smtp-Source: AA0mqf6cJuUMdeDDy8I0aGxXTR0ZUZnSmg+VDezMjzZQH4YW4DgZTkQQPfnfndUU5bw3ucH48zWkPg==
X-Received: by 2002:a5d:408e:0:b0:22e:3397:2e96 with SMTP id o14-20020a5d408e000000b0022e33972e96mr21671604wrp.535.1669360492889;
        Thu, 24 Nov 2022 23:14:52 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003cfd4cf0761sm9108444wmq.1.2022.11.24.23.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 23:14:52 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 08/10] misc: fastrpc: Safekeep mmaps on interrupted invoke
Date:   Fri, 25 Nov 2022 07:14:03 +0000
Message-Id: <20221125071405.148786-9-srinivas.kandagatla@linaro.org>
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

If the userspace daemon is killed in the middle of an invoke (e.g.
audiopd listerner invoke), we need to skip the unmapping on device
release, otherwise the DSP will crash. So lets safekeep all the maps
only if there is in invoke interrupted, by attaching them to the channel
context (which is resident until RPMSG driver is removed), and free them
on RPMSG driver remove.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index b123b6783920..2dc9946c3d23 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -275,6 +275,7 @@ struct fastrpc_channel_ctx {
 	struct fastrpc_device *secure_fdevice;
 	struct fastrpc_device *fdevice;
 	struct fastrpc_buf *remote_heap;
+	struct list_head invoke_interrupted_mmaps;
 	bool secure;
 	bool unsigned_support;
 };
@@ -1119,6 +1120,8 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 				   struct fastrpc_invoke_args *args)
 {
 	struct fastrpc_invoke_ctx *ctx = NULL;
+	struct fastrpc_buf *buf, *b;
+
 	int err = 0;
 
 	if (!fl->sctx)
@@ -1182,6 +1185,13 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		fastrpc_context_put(ctx);
 	}
 
+	if (err == -ERESTARTSYS) {
+		list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
+			list_del(&buf->node);
+			list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
+		}
+	}
+
 	if (err)
 		dev_dbg(fl->sctx->dev, "Error: Invoke Failed %d\n", err);
 
@@ -2281,6 +2291,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	dev_set_drvdata(&rpdev->dev, data);
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
+	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
 	spin_lock_init(&data->lock);
 	idr_init(&data->ctx_idr);
 	data->domain_id = domain_id;
@@ -2305,6 +2316,7 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
 static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 {
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
+	struct fastrpc_buf *buf, *b;
 	struct fastrpc_user *user;
 	unsigned long flags;
 
@@ -2319,6 +2331,9 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	if (cctx->secure_fdevice)
 		misc_deregister(&cctx->secure_fdevice->miscdev);
 
+	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
+		list_del(&buf->node);
+
 	if (cctx->remote_heap)
 		fastrpc_buf_free(cctx->remote_heap);
 
-- 
2.25.1

