Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217595B399C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiIINmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiIINlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:41:04 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C890BCC17
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:40:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bq9so2817302wrb.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 06:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TgMhe1L8Z5pQw5Ws1qnT8lOmOJIjYgKzz95gp2a8iEk=;
        b=bnmqBLRDNQn2Mb58Y6ESTUJYa+iA9fmvtbOVYzMwUov6f9xlJGwKJPPlZfCPsyT4Wy
         hah4ALy4eL3j6G2OY6Bm/RIKVWrSki8lnpP3RUJ50qp6TJm0lfb+bUtgudc/6Yp3CgEa
         qW87ToXBDcDROP8Xd9cchbH1Jc/m1z+08VVUwho/+TOqeWsQW+zDOBhjVYnwaIAYTYPz
         DulSjwl6wlxd1QMOWbGUw+PN016p2XSCcHNEl+VJ944mej7qyknBcJpVzytmTZpSWNho
         IWiSIxniokTgh/bQDMOLA3ljnl9O52CbQlMFNAdUBzuiFAcZ/VjwEZFmYjPr90aqdBP3
         Z9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TgMhe1L8Z5pQw5Ws1qnT8lOmOJIjYgKzz95gp2a8iEk=;
        b=a11Gl7lAKn9etCbPWgWGWUtXUkCTIhezw7pGA+7ozMBdJMu1biG71e3o+iOWbl7b6X
         5DUtpfaXAr0uofdIyFKOiDx5rfwV7GjNdkb69I8UwmOaJidu0HBfinm0s32qTK8KJm+0
         Dvw6sEgDZzTeKeVBjBH2iOyUGsEn8UsrTta7ThszZnzy9CvcfsIimrz8dTRkwK8uPR8s
         6V3V4UHMmUTUySWj55AICttLfFBeg85wKVxkzcjgQGtFR9KJBygNXOu2TL7FH4efi5eB
         5QPX5E6wFw4W4ZfzYCRUgJPgLo/v5D8/B1Wy6Cab6jA+LTAfvW+1xKTf0zN1pFurb/aW
         Q7Pw==
X-Gm-Message-State: ACgBeo2VhipBzg/82mNxd3+Cg7RnER4p9/iwSwErsVXYtgP0ymSi7/j1
        1+rC/xeL7omJ3YGht5dEIQYipw==
X-Google-Smtp-Source: AA6agR7HInY3oUDj7yMj3lEAHDafm56nkIx3Djb5LkY8OSJOG8Ct7r05ZLtDImMrIN0iUj/YLF8yzw==
X-Received: by 2002:a5d:458e:0:b0:228:cd6e:dc56 with SMTP id p14-20020a5d458e000000b00228cd6edc56mr8365812wrq.614.1662730850778;
        Fri, 09 Sep 2022 06:40:50 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id q20-20020a1cf314000000b003a604a29a34sm660622wmq.35.2022.09.09.06.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 06:40:50 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>,
        Bharath Kumar <bkumar@qti.qualcomm.com>,
        Himateja Reddy <hmreddy@quicinc.com>,
        Anirudh Raghavendra <araghave@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 08/10] misc: fastrpc: Safekeep mmaps on interrupted invoke
Date:   Fri,  9 Sep 2022 16:39:36 +0300
Message-Id: <20220909133938.3518520-9-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909133938.3518520-1-abel.vesa@linaro.org>
References: <20220909133938.3518520-1-abel.vesa@linaro.org>
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

If the userspace daemon is killed in the middle of an invoke (e.g.
audiopd listerner invoke), we need to skip the unmapping on device
release, otherwise the DSP will crash. So lets safekeep all the maps
only if there is in invoke interrupted, by attaching them to the channel
context (which is resident until RPMSG driver is removed), and free them
on RPMSG driver remove.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/misc/fastrpc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 6b2a552dbdba..bc1e8f003d7a 100644
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
 
@@ -2277,6 +2287,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	dev_set_drvdata(&rpdev->dev, data);
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
+	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
 	spin_lock_init(&data->lock);
 	idr_init(&data->ctx_idr);
 	data->domain_id = domain_id;
@@ -2301,6 +2312,7 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
 static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 {
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
+	struct fastrpc_buf *buf, *b;
 	struct fastrpc_user *user;
 	unsigned long flags;
 
@@ -2315,6 +2327,9 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	if (cctx->secure_fdevice)
 		misc_deregister(&cctx->secure_fdevice->miscdev);
 
+	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
+		list_del(&buf->node);
+
 	if (cctx->remote_heap)
 		fastrpc_buf_free(cctx->remote_heap);
 
-- 
2.34.1

