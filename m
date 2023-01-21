Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22C8676502
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 08:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjAUHmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 02:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUHmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 02:42:09 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EAE6E0FF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 23:42:08 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B129841EF0;
        Sat, 21 Jan 2023 07:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1674286926;
        bh=aAAVm6ArULz2Uf8upWSlauZ9L+95sXBTHjoML9CoM6g=;
        h=From:To:Cc:Subject:Date;
        b=tOJqR1ACgXep0gtiM+Gfnl6LNMnZ/bUrUH9S2cbqnrFEiYjU5hy2E1v1TJPOpobNB
         5jFGtE0qrq/XG+bhfVF4H/ejwz4sMuxYKWI3CeY2frjzw/tUFDoh+fuNahV5MiGxQS
         Cgah1hXQIcJ21WLu9lwf3GY3HicuI+l+nDmaVLPiT+O+xKn9XWnhGxhsiBoKMTzbyn
         IcsMJxbcdndvvPL5h/2houLwRflBKD76bVKvwIcHFp3MNCWkjg90YluNvgCwd/1p60
         MC67vHcr8Lh8ZykXjmZSj/pP6ykkFaOCF7gLb/uKk0FsBLWsia8lwTBRWwrosQ8UqJ
         oNTi/CX8XqjTQ==
From:   Asahi Lina <lina@asahilina.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Asahi Lina <lina@asahilina.net>
Subject: [PATCH] soc: apple: rtkit: Export non-devm init/free functions
Date:   Sat, 21 Jan 2023 16:41:35 +0900
Message-Id: <20230121074135.8629-1-lina@asahilina.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While we normally encourage devm usage by drivers, some consumers (and
in particular the upcoming Rust abstractions) might want to manually
manage memory. Export the raw functions to make this possible.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 drivers/soc/apple/rtkit.c       | 15 ++++++++++-----
 include/linux/soc/apple/rtkit.h | 19 +++++++++++++++++++
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index fa3cda831d2b..bb33f3cd4efd 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -686,7 +686,7 @@ static int apple_rtkit_request_mbox_chan(struct apple_rtkit *rtk)
 	return mbox_start_channel(rtk->mbox_chan);
 }
 
-static struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
+struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
 					    const char *mbox_name, int mbox_idx,
 					    const struct apple_rtkit_ops *ops)
 {
@@ -739,6 +739,7 @@ static struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
 	kfree(rtk);
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(apple_rtkit_init);
 
 static int apple_rtkit_wait_for_completion(struct completion *c)
 {
@@ -922,10 +923,8 @@ int apple_rtkit_wake(struct apple_rtkit *rtk)
 }
 EXPORT_SYMBOL_GPL(apple_rtkit_wake);
 
-static void apple_rtkit_free(void *data)
+void apple_rtkit_free(struct apple_rtkit *rtk)
 {
-	struct apple_rtkit *rtk = data;
-
 	mbox_free_channel(rtk->mbox_chan);
 	destroy_workqueue(rtk->wq);
 
@@ -936,6 +935,12 @@ static void apple_rtkit_free(void *data)
 	kfree(rtk->syslog_msg_buffer);
 	kfree(rtk);
 }
+EXPORT_SYMBOL_GPL(apple_rtkit_free);
+
+static void apple_rtkit_free_wrapper(void *data)
+{
+	apple_rtkit_free(data);
+}
 
 struct apple_rtkit *devm_apple_rtkit_init(struct device *dev, void *cookie,
 					  const char *mbox_name, int mbox_idx,
@@ -948,7 +953,7 @@ struct apple_rtkit *devm_apple_rtkit_init(struct device *dev, void *cookie,
 	if (IS_ERR(rtk))
 		return rtk;
 
-	ret = devm_add_action_or_reset(dev, apple_rtkit_free, rtk);
+	ret = devm_add_action_or_reset(dev, apple_rtkit_free_wrapper, rtk);
 	if (ret)
 		return ERR_PTR(ret);
 
diff --git a/include/linux/soc/apple/rtkit.h b/include/linux/soc/apple/rtkit.h
index 2d837aa7b91f..62bfa37b5adb 100644
--- a/include/linux/soc/apple/rtkit.h
+++ b/include/linux/soc/apple/rtkit.h
@@ -77,6 +77,25 @@ struct apple_rtkit *devm_apple_rtkit_init(struct device *dev, void *cookie,
 					  const char *mbox_name, int mbox_idx,
 					  const struct apple_rtkit_ops *ops);
 
+/*
+ * Non-devm version of devm_apple_rtkit_init. Must be freed with
+ * apple_rtkit_free.
+ *
+ * @dev:         Pointer to the device node this coprocessor is assocated with
+ * @cookie:      opaque cookie passed to all functions defined in rtkit_ops
+ * @mbox_name:   mailbox name used to communicate with the co-processor
+ * @mbox_idx:    mailbox index to be used if mbox_name is NULL
+ * @ops:         pointer to rtkit_ops to be used for this co-processor
+ */
+struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
+					  const char *mbox_name, int mbox_idx,
+					  const struct apple_rtkit_ops *ops);
+
+/*
+ * Free an instance of apple_rtkit.
+ */
+void apple_rtkit_free(struct apple_rtkit *rtk);
+
 /*
  * Reinitialize internal structures. Must only be called with the co-processor
  * is held in reset.
-- 
2.35.1

