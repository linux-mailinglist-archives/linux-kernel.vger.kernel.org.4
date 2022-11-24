Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD745637E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiKXRwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiKXRvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:51:52 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B0714EC9A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:51:50 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o30so1805714wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKdWE5BFQ1ZKevg2FpHfyLdEPvi7Rl4963q2XP3WFlg=;
        b=grpg55XU7zA4v2+va0FqIXjIadVRsPFv/tdU7RfIr+Fx61qICib9L6ywZU1s94Ffw/
         k2nEsSSXbe5tOCXl6t1GsfSBWFYxswRSJ51o/SblcztdOR4hLS2F55yqr/jpib/xL/nZ
         xyPWPmyFSyc89emqgHvKRjJc5NJ7SIRwej5hfOKZxcnhIrHzP786BBsg3ouDGGOmUcKV
         TYirrleMbxPSWoUZevYa4P4yPfkjk3INNaTA+moRD+XW35mBQqqDSHKwe7gW/Sw2inKD
         QZywCleQNlyfZvt67ve5alXAVQuI/XsDbHkAi8KYqIDrFQUD+QmzQKWxLIrjB/Kesxp5
         U7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKdWE5BFQ1ZKevg2FpHfyLdEPvi7Rl4963q2XP3WFlg=;
        b=NEMjtpV0pgixoUaouvhQ34PBICqXOzCf2+kxTV3ymi368r/6sZhNwUEe9owCt85O6/
         lP96vY4hssRW6tzsrlgLS7EZ01CDenWo+1j6Y/VG6k8fBoQ4B8VbAZCXu+Om4eqZMgQS
         DsJkUkOUy5VmYYrb9gkIViVgX/OEg6bdiM6Ux2FZm4oPku7mn56lLVBVBJ3P+kgyZ6eF
         4KNjadz7ibUHRbIbEPLEaxi3Daz7ZSa8lJuv57CP9RX9UmF8KouYCLIILl2yhnJLVqUo
         Y2VXj+Hc2/nSuuQCwjTndYOnUoPiIuag9MTKVla2yYgts69QLZmZlDrCNR49f2AQtLvc
         /YMw==
X-Gm-Message-State: ANoB5pnNWBJqeNkJ0Czb4iNkf/qfmj1W+Wdrjb30Ip416zZmbixzpaCO
        k6TDHtSK/C952x/f2Tp3cwh6hQ==
X-Google-Smtp-Source: AA0mqf65gkLMVRSfmyn9wM2jKTEE9YhTB1jQSyKgnt2NsW5whLJNzJjP1GO8eWQzsXcQq49dF1aAwA==
X-Received: by 2002:a1c:ed01:0:b0:3cf:7d41:f2bb with SMTP id l1-20020a1ced01000000b003cf7d41f2bbmr12165600wmh.62.1669312308863;
        Thu, 24 Nov 2022 09:51:48 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b003c701c12a17sm6394192wmb.12.2022.11.24.09.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:51:48 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 09/11] misc: fastrpc: Safekeep mmaps on interrupted invoke
Date:   Thu, 24 Nov 2022 17:51:23 +0000
Message-Id: <20221124175125.418702-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124175125.418702-1-srinivas.kandagatla@linaro.org>
References: <20221124175125.418702-1-srinivas.kandagatla@linaro.org>
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
index 00e741fd6d91..3cf76a240b7a 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -276,6 +276,7 @@ struct fastrpc_channel_ctx {
 	struct fastrpc_device *secure_fdevice;
 	struct fastrpc_device *fdevice;
 	struct fastrpc_buf *remote_heap;
+	struct list_head invoke_interrupted_mmaps;
 	bool secure;
 	bool unsigned_support;
 };
@@ -1122,6 +1123,8 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 				   struct fastrpc_invoke_args *args)
 {
 	struct fastrpc_invoke_ctx *ctx = NULL;
+	struct fastrpc_buf *buf, *b;
+
 	int err = 0;
 
 	if (!fl->sctx)
@@ -1185,6 +1188,13 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
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
 
@@ -2284,6 +2294,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	dev_set_drvdata(&rpdev->dev, data);
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
+	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
 	spin_lock_init(&data->lock);
 	idr_init(&data->ctx_idr);
 	data->domain_id = domain_id;
@@ -2308,6 +2319,7 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
 static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 {
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
+	struct fastrpc_buf *buf, *b;
 	struct fastrpc_user *user;
 	unsigned long flags;
 
@@ -2322,6 +2334,9 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	if (cctx->secure_fdevice)
 		misc_deregister(&cctx->secure_fdevice->miscdev);
 
+	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
+		list_del(&buf->node);
+
 	if (cctx->remote_heap)
 		fastrpc_buf_free(cctx->remote_heap);
 
-- 
2.25.1

