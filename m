Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EB863845D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 08:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiKYHP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 02:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiKYHPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:15:01 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7985E2C659
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:14:56 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bs21so5430286wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DqEDdvSkcIUCCVt3QJT84tX+bOxrH7SbknGjttr9wg=;
        b=mieiYWSGLod9p37sFFlMkDldsPo6nwGZ/G+ZJ9hDm0EAbNcMevA//1xDMdR2yAyedE
         Kw0M9qY3D8mqaCEDYWAj/9L4qsVbqK+bojmWi2sM4VITNoWZEsSrbV3K1+U0JLuikOc4
         NMr/JsK6DfcLUsdgZ8b/XhUBePpvXpmfH++6VDJUxMx12SnjjQhipbfELHqUXqo0QROj
         D9OCf8PhAsFoDLJMzdOjBUB9WwUsm2LgyuX0UZdwEETcGzNYCCXJz3F6QcL+gtnpavHV
         NtUbHzhTcoqH4EumkprY8gDF2w575Cxc0Nh6YMIE7hhpbS8pKKBhfu0gyXrE6cajVBNT
         gsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DqEDdvSkcIUCCVt3QJT84tX+bOxrH7SbknGjttr9wg=;
        b=VBuvbdpVgeOWl9w0O8FEC32YajRY6VJ40n7fXwRFBl0u8yjIE4HeuIITMjOI5UMri3
         eTiugFGergUMO4uO/SY/9CaaDA/HKUAyGJQ6AS1YfpQKadMUB7ZmYFnP5FZ3AYC1MAC5
         xz+87G87GVL7oFgfkPj1ia9UwIjECSKgoqoTfji4FLKkImVUk0RUoS64XgQx2wM6SSJQ
         J2AaITBy73c0+TC+txNNJoLMbx0rxBilonrjTGQJ4FKZv+1xGHVUcDpdXgB1QFT1lw3K
         UxxJjQ/a02eDgLk2oqhqggUtlothODEEj4sW23yPL/dRamjPzyfTL1XzB7cEf4vFjdT8
         5fww==
X-Gm-Message-State: ANoB5plfYlp1v95kxX9sJSn8X81BAUkePXV4mdo5ZpXSoXQBtPO5i1Tx
        X4O5gBqN6kdONlHAgnyF4ZNRsQ==
X-Google-Smtp-Source: AA0mqf60XZmVnnUYERZlaO4cxrDobn/B7nCU0dxqn7ZuqbExx9j6KWm3tCaL2T66hB/hCw/yhjFKuQ==
X-Received: by 2002:a5d:65ce:0:b0:241:e1c3:caaa with SMTP id e14-20020a5d65ce000000b00241e1c3caaamr10081237wrw.458.1669360495047;
        Thu, 24 Nov 2022 23:14:55 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003cfd4cf0761sm9108444wmq.1.2022.11.24.23.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 23:14:54 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 10/10] misc: fastrpc: Add dma_mask to fastrpc_channel_ctx
Date:   Fri, 25 Nov 2022 07:14:05 +0000
Message-Id: <20221125071405.148786-11-srinivas.kandagatla@linaro.org>
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

dma_set_mask_and_coherent only updates the mask to which the device
dma_mask pointer points to. Add a dma_mask to the channel ctx and set
the device dma_mask to point to that, otherwise the dma_set_mask will
return an error and the dma_set_coherent_mask will be skipped too.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 4b05cbd6083d..8dc6f8f932db 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -278,6 +278,7 @@ struct fastrpc_channel_ctx {
 	struct list_head invoke_interrupted_mmaps;
 	bool secure;
 	bool unsigned_support;
+	u64 dma_mask;
 };
 
 struct fastrpc_device {
@@ -2306,6 +2307,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	kref_init(&data->refcount);
 
 	dev_set_drvdata(&rpdev->dev, data);
+	rdev->dma_mask = &data->dma_mask;
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
 	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
-- 
2.25.1

