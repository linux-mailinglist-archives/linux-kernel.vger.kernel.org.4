Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF62D6FE9C4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 04:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjEKCQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 22:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjEKCQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 22:16:23 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B91A2D43
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 19:16:22 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-306281edf15so7509047f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 19:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683771381; x=1686363381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c7NhY70nKePpFKW1tNMvcsBAqsK2Oz2JiYYqlXCn6ek=;
        b=VzlDVeswYJTkHS18WfZGHZ94kK1HMGNiS+QWCFjD+YQvom1A9OAwXhkdBvdBe22xb1
         wo2+YNPN2MLaLnGPFkdicBRqtv0CqWMFPg8QmcSKYNV9CwYtC9HjcrmNGJ/D2dsCz3lb
         Z5PlRQDTuLjC9YYVM1X5I8xGDP/4vF1xu/GrZJojtbOuyCP+QJF9DWyY0/3Y99Q8a5ua
         eByKEUXFxYnoBU9GBECtwMdo6BJkmns+hZ8YD2GZV8eQReJfbHcXZ0zBy6866p8r3miX
         9dO9UeQ30UHWgOkJMCSmPXFkmsjsPkCrdbwew7yxIcitgBsJRx24CfkS0WtbbIPC8y/0
         lm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683771381; x=1686363381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7NhY70nKePpFKW1tNMvcsBAqsK2Oz2JiYYqlXCn6ek=;
        b=kW9xn28oY/yrOnIrpav/+sbOBTU+YDgWZrvHHMS7pLCsvcEmqOgvgERZHRzi6G7oax
         Yy4EntCD5MG3OOexg3qiMCUaLTup1zne5lPXD2BD6FwK7yNhwd5N+ADKCSbmV3ucaYXU
         FFDYgOmbMocFOb/XCpn539kEiVTyq/GjQkyArULOk1WYo0qBGNw9MhrrDvRvKrGbT4GU
         W8YermNinO2KZOmasiw0cmusb+EqLPNfdSElBhQC0OGa8mCOeFd0bW8/1DKWysPWhoPp
         x4nJv2k1d/gQ0NYZ/UkirbCPy86ZlIbA2cuwoLTBrFXxdqubxblmgnewVI79uCYFj5PF
         m/Mw==
X-Gm-Message-State: AC+VfDwWvv7LPwMob4xiMVeW+WZ6tWpTNFzZD45hJWhr2MfDrI+2DvwM
        cmEp0K2DfgbjTBo8MB4EQWu/7g==
X-Google-Smtp-Source: ACHHUZ7Sd+QhrUQhXDP5FYiCHBKYHYlWW2eiRLWyVaZMfV2uj0aNLztC4C2YUrLSDZA108qzs4//xg==
X-Received: by 2002:a5d:45c7:0:b0:306:3bac:e235 with SMTP id b7-20020a5d45c7000000b003063bace235mr11720300wrs.10.1683771380676;
        Wed, 10 May 2023 19:16:20 -0700 (PDT)
Received: from localhost.localdomain ([64.64.123.10])
        by smtp.gmail.com with ESMTPSA id j18-20020a5d4492000000b003021288a56dsm18945908wrq.115.2023.05.10.19.16.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 May 2023 19:16:20 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jean-philippe <jean-philippe@linaro.org>,
        Wangzhou <wangzhou1@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux.dev, acc@lists.linaro.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH] uacce: use filep->f_mapping to replace inode->i_mapping
Date:   Thu, 11 May 2023 10:15:53 +0800
Message-Id: <20230511021553.44318-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inode can be different in a container, for example, a docker and host
both open the same uacce parent device, which uses the same uacce struct
but different inode, so uacce->inode is not enough.

What's worse, when docker stops, the inode will be destroyed as well,
causing use-after-free in uacce_remove.

So use q->filep->f_mapping to replace uacce->inode->i_mapping.

Signed-off-by: Weili Qian <qianweili@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/misc/uacce/uacce.c | 16 +++++++++-------
 include/linux/uacce.h      |  4 ++--
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index 346bd7cf2e94..740ace422baa 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -166,8 +166,8 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
 
 	init_waitqueue_head(&q->wait);
 	filep->private_data = q;
-	uacce->inode = inode;
 	q->state = UACCE_Q_INIT;
+	q->private_data = filep;
 	mutex_init(&q->mutex);
 	list_add(&q->list, &uacce->queues);
 	mutex_unlock(&uacce->mutex);
@@ -574,12 +574,6 @@ void uacce_remove(struct uacce_device *uacce)
 
 	if (!uacce)
 		return;
-	/*
-	 * unmap remaining mapping from user space, preventing user still
-	 * access the mmaped area while parent device is already removed
-	 */
-	if (uacce->inode)
-		unmap_mapping_range(uacce->inode->i_mapping, 0, 0, 1);
 
 	/*
 	 * uacce_fops_open() may be running concurrently, even after we remove
@@ -589,6 +583,8 @@ void uacce_remove(struct uacce_device *uacce)
 	mutex_lock(&uacce->mutex);
 	/* ensure no open queue remains */
 	list_for_each_entry_safe(q, next_q, &uacce->queues, list) {
+		struct file *filep = q->private_data;
+
 		/*
 		 * Taking q->mutex ensures that fops do not use the defunct
 		 * uacce->ops after the queue is disabled.
@@ -597,6 +593,12 @@ void uacce_remove(struct uacce_device *uacce)
 		uacce_put_queue(q);
 		mutex_unlock(&q->mutex);
 		uacce_unbind_queue(q);
+
+		/*
+		 * unmap remaining mapping from user space, preventing user still
+		 * access the mmaped area while parent device is already removed
+		 */
+		unmap_mapping_range(filep->f_mapping, 0, 0, 1);
 	}
 
 	/* disable sva now since no opened queues */
diff --git a/include/linux/uacce.h b/include/linux/uacce.h
index 0a81c3dfd26c..64b800b74436 100644
--- a/include/linux/uacce.h
+++ b/include/linux/uacce.h
@@ -86,6 +86,7 @@ enum uacce_q_state {
  * @state: queue state machine
  * @pasid: pasid associated to the mm
  * @handle: iommu_sva handle returned by iommu_sva_bind_device()
+ * @private_data: private data for saving filep
  */
 struct uacce_queue {
 	struct uacce_device *uacce;
@@ -97,6 +98,7 @@ struct uacce_queue {
 	enum uacce_q_state state;
 	u32 pasid;
 	struct iommu_sva *handle;
+	void *private_data;
 };
 
 /**
@@ -114,7 +116,6 @@ struct uacce_queue {
  * @mutex: protects uacce operation
  * @priv: private pointer of the uacce
  * @queues: list of queues
- * @inode: core vfs
  */
 struct uacce_device {
 	const char *algs;
@@ -130,7 +131,6 @@ struct uacce_device {
 	struct mutex mutex;
 	void *priv;
 	struct list_head queues;
-	struct inode *inode;
 };
 
 #if IS_ENABLED(CONFIG_UACCE)
-- 
2.39.2 (Apple Git-143)

