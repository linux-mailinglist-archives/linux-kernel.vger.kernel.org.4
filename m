Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24124698A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 02:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBPBmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 20:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBPBmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 20:42:33 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE80460BF;
        Wed, 15 Feb 2023 17:41:55 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id n2so338353pgb.2;
        Wed, 15 Feb 2023 17:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KJvtPQS/ldYbIm0gu0EUzflwW0VeUmr45xI0vpFNSbc=;
        b=bZxprndWm9OEACtOp+faKKzt2TXoFYQGanqshNyeDfV432AUgl6iFO7xZQ2dBBam7Q
         NVmui8XBimnw3EiuKxUdQJ0E42Sl5ixz/Tpsljc0jnqnOZYKb8GyS9NHJm11i64EvfNj
         82Yjq0Sqs75rcAjxREWiKfdhdNuGHWbIph7gMjUTY5qGqUxZeDOpo3f9fYPLKmHPiBdw
         GRoP8wEP18hH5JrRBC5lXdgE2mVYQqfUrkMZ1yHzQQ23HPInn/4NwDLqRG2NIfSnGIZJ
         9krjnoo9eovmEVRgsK+bFFz7/UyaZHMyZuLd3/Ur4AgP1u//kNfXuC4YbNpNflZIUvK1
         T50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJvtPQS/ldYbIm0gu0EUzflwW0VeUmr45xI0vpFNSbc=;
        b=noqXpYs9kbFCgvUu+BE25lqWKA03O/e8BP3fPrtGa4OLV7/NVmRrNa4XLl5TtU/Yj9
         +ksF9BLOqhyEugdC2iYTHcywudNZRkv9VMdVLkqWZVKPubrIzHSoePuG9XeRCL2LBaCL
         pZ1BujvghfmmznP2xVRR92B9517lPg2RkkLcGHZVCMq/aFNcPi736hv2tu+Gr7L/JyPD
         EsfkvDfJos86EAFE4cNhSA8KQC2vK2S+O9HFKbLh5IMbjDg5q13Hf8+a2HpHCr41Y5oD
         hTNEXEzhrd+pBH6KxUx0r8QEbEbxaXQC5GTXDIVPO7DnsnfOapN4qlZxcJRLh467AdAU
         zzNA==
X-Gm-Message-State: AO0yUKW+yG9Oneua+YX43lXx/Fx5X84/VsbIC5NE5K9aj9LCLdaoiH39
        W+OeCA8ZfbhnziVJLODIr63cXnxbtt5FdQ==
X-Google-Smtp-Source: AK7set+jPFm0K3sb4DvFxR98vOXDivAdwpThbeX81qftanIWVs4/oA+vGoXwtA8zFDCT6D8nSQcAEA==
X-Received: by 2002:aa7:9e9d:0:b0:5a8:b6cf:1a74 with SMTP id p29-20020aa79e9d000000b005a8b6cf1a74mr3167084pfq.18.1676511689788;
        Wed, 15 Feb 2023 17:41:29 -0800 (PST)
Received: from fuzzing.localdomain ([219.254.222.254])
        by smtp.gmail.com with ESMTPSA id u12-20020a62ed0c000000b0059085684b54sm1618pfh.140.2023.02.15.17.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 17:41:29 -0800 (PST)
From:   Sangsup Lee <k1rh4.lee@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: fastrpc: Fix a Use after-free-bug by race condition
Date:   Wed, 15 Feb 2023 17:41:20 -0800
Message-Id: <20230216014120.3110-1-k1rh4.lee@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds mutex_lock for fixing an Use-after-free bug.
fastrpc_req_munmap_impl can be called concurrently in multi-threded environments.
The buf which is allocated by list_for_each_safe can be used after another thread frees it.

Signed-off-by: Sangsup Lee <k1rh4.lee@gmail.com>
---
 drivers/misc/fastrpc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 5310606113fe..c4b5fa4a50a6 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1806,10 +1806,12 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_buf *buf = NULL, *iter, *b;
 	struct fastrpc_req_munmap req;
 	struct device *dev = fl->sctx->dev;
+	int err;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
 
+	mutex_lock(&fl->mutex);
 	spin_lock(&fl->lock);
 	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
 		if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
@@ -1822,10 +1824,13 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	if (!buf) {
 		dev_err(dev, "mmap\t\tpt 0x%09llx [len 0x%08llx] not in list\n",
 			req.vaddrout, req.size);
+		mutex_unlock(&fl->mutex);
 		return -EINVAL;
 	}
 
-	return fastrpc_req_munmap_impl(fl, buf);
+	err = fastrpc_req_munmap_impl(fl, buf);
+	mutex_unlock(&fl->mutex);
+	return err;
 }
 
 static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
-- 
2.25.1

