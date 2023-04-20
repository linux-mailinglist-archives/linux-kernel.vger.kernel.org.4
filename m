Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1F46E97D1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 17:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjDTPAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 11:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjDTPAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 11:00:47 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D203135AF;
        Thu, 20 Apr 2023 08:00:45 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id a11so2398410ybm.3;
        Thu, 20 Apr 2023 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682002845; x=1684594845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jZr84TaNrsHBkXDcq7S+XPnDLhczJIO2B/rcwo5kl+U=;
        b=Q6DbU6jrrrl0MeDwpdNnG171UCRkBeLin3keeisf4sgJCu4VcEqwQ/oalqX8zU7JOL
         Md8/j5mn5JZZ/ZyCUbo/w9gboNxtQgdZCUvMx6tQCJzKws5yAsOksTsycClqC1v1oXwO
         0HOlCEjfp8VwpjP1LKhH/IslHbjdfFOr9M7qMqMYakppJIaSp0MmruBYB8WgSWjsr7cc
         nZjXM4/mqWRRqK9YcB1Ku5JeSz4NGBhqyyRYIGm1JQeziBdHR9o1P7FFaro85YNkAUp1
         YQasuPSqLPGtKg0VgKackMsoMJraZ77Ryyowyi8T9f+G5aWtbh9mIkJH5yPBYpm37CVm
         ImLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682002845; x=1684594845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZr84TaNrsHBkXDcq7S+XPnDLhczJIO2B/rcwo5kl+U=;
        b=CNMH/VQHwkNqSgS5mr4hvf1IQE0LFCFyQv4nF5lRalRPuCZzqckrH7mGDiH2oClj40
         9KAgJYIBXmZ/bG7HaD0oqC7rsJp66dHgrdRoL5/7FLfLbqyTKhOdhnw9OeGq2AneF7UA
         xB1ioFKX4n3UYvJWORQ+ITu73fON9cVADin7trUZRG0wl/dDVpeRgPkvnJ8WX54yQZ98
         lc7HWve8dPhUPsvix76fdNIOiLFVvMTj0rFioq/VrRHbm+kQUSntFb7ywmy1qf7zgtYf
         1N/WSZ7efYqrF4GCMfTahEKI4/e5XFKCLWfviD2tTT3ee6MeLoDFBFm/eLe51ICGwF5a
         3rTw==
X-Gm-Message-State: AAQBX9dmXGqZelLw9wXYJmQwdylZu2HdO4ithGjIfxo9q9qz1PKxDFn3
        pBmFVem8Ww5jNrMhI2JGlN4=
X-Google-Smtp-Source: AKy350Zz06ofQ07Heq9i94XNXQo9VeNZ5YVAYDVV+mFS0UjuOh3H9ckIko7IE/sEbVIZlnLu4WAZmw==
X-Received: by 2002:a25:2f12:0:b0:b92:5bf4:670d with SMTP id v18-20020a252f12000000b00b925bf4670dmr1393153ybv.5.1682002844552;
        Thu, 20 Apr 2023 08:00:44 -0700 (PDT)
Received: from obacon-Precision-3640-Tower.genetec.com ([68.67.62.2])
        by smtp.gmail.com with ESMTPSA id f15-20020a05620a280f00b0074df2ac52f8sm496850qkp.21.2023.04.20.08.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:00:44 -0700 (PDT)
From:   Olivier Bacon <olivierb89@gmail.com>
X-Google-Original-From: Olivier Bacon <obacon@genetec.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Olivier Bacon <obacon@genetec.com>,
        Sylvain Ouellet <souellet@genetec.com>
Subject: [PATCH] crypto: engine - fix crypto_queue backlog handling
Date:   Thu, 20 Apr 2023 11:00:35 -0400
Message-Id: <20230420150035.19369-1-obacon@genetec.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CRYPTO_TFM_REQ_MAY_BACKLOG tells the crypto driver that it should
internally backlog requests until the crypto hw's queue becomes
full. At that point, crypto_engine backlogs the request and returns
-EBUSY. Calling driver such as dm-crypt then waits until the
complete() function is called with a status of -EINPROGRESS before
sending a new request.

The problem lies in the call to complete() with a value of -EINPROGRESS
that is made when a backlog item is present on the queue. The call is
done before the successful execution of the crypto request. In the case
that do_one_request() returns < 0 and the retry support is available,
the request is put back in the queue. This leads upper drivers to send
a new request even if the queue is still full.

The problem can be reproduced by doing a large dd into a crypto
dm-crypt device. This is pretty easy to see when using
Freescale CAAM crypto driver and SWIOTLB dma. Since the actual amount
of requests that can be hold in the queue is unlimited we get IOs error
and dma allocation.

The fix is to call complete with a value of -EINPROGRESS only if
the request is not enqueued back in crypto_queue. This is done
by calling complete() later in the code. In order to delay the decision,
crypto_queue is modified to correctly set the backlog pointer
when a request is enqueued back.

Fixes: 6a89f492f8e5 ("crypto: engine - support for parallel requests based on retry mechanism")
Co-developed-by: Sylvain Ouellet <souellet@genetec.com>
Signed-off-by: Sylvain Ouellet <souellet@genetec.com>
Signed-off-by: Olivier Bacon <obacon@genetec.com>
---
 crypto/algapi.c        | 3 +++
 crypto/crypto_engine.c | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index d08f864f08be..18a8ca9cafbc 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -961,6 +961,9 @@ EXPORT_SYMBOL_GPL(crypto_enqueue_request);
 void crypto_enqueue_request_head(struct crypto_queue *queue,
 				 struct crypto_async_request *request)
 {
+	if (unlikely(queue->qlen >= queue->max_qlen))
+		queue->backlog = queue->backlog->prev;
+
 	queue->qlen++;
 	list_add(&request->list, &queue->list);
 }
diff --git a/crypto/crypto_engine.c b/crypto/crypto_engine.c
index 21f791615114..74fcc0897041 100644
--- a/crypto/crypto_engine.c
+++ b/crypto/crypto_engine.c
@@ -129,9 +129,6 @@ static void crypto_pump_requests(struct crypto_engine *engine,
 	if (!engine->retry_support)
 		engine->cur_req = async_req;
 
-	if (backlog)
-		crypto_request_complete(backlog, -EINPROGRESS);
-
 	if (engine->busy)
 		was_busy = true;
 	else
@@ -217,6 +214,9 @@ static void crypto_pump_requests(struct crypto_engine *engine,
 	crypto_request_complete(async_req, ret);
 
 retry:
+	if (backlog)
+		crypto_request_complete(backlog, -EINPROGRESS);
+
 	/* If retry mechanism is supported, send new requests to engine */
 	if (engine->retry_support) {
 		spin_lock_irqsave(&engine->queue_lock, flags);
-- 
2.40.0

