Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB44637E94
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiKXRvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKXRvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:51:40 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B34C1F77
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:51:40 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id b12so3486028wrn.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwNxnTC0a1IPalPxtww27IAv5/GUzCtpz/69xMVLEK0=;
        b=elT90pt/B9VByyHA/3c/7e0czDBA6h96oQ6bzTZ/E9XFY5M5gxv23hxIUyh1QQlesE
         XyImgwvR/6oqSjKG9BccPVC2jGn8ywdqpAHBAwLj8gM38e7X9x58gUnuXOqPLclOV6G1
         rl/DVSU+/7TUojQHXwd2q4ZJ9f114gOGY5KFD2rfI2HYx/4/Mpp2xnV8cxDFeEVzwr8y
         2wknpZruJkzTsp31lunPCOpw5J7lZ24I6SrWxkchpOI0VrFQX0kUphdaXAPEdgaBbKul
         MqUZMDAnWtUyVTn6lOQMw44l+t7FIctgohnuadps0ZbN12Y8R7vEBEBPgQSeTiiJYJbV
         MB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwNxnTC0a1IPalPxtww27IAv5/GUzCtpz/69xMVLEK0=;
        b=1rvIhUiFkTDShSi9+bSS7LVVW/1DOqBHFNyeiWEZLJyUrLQDPI9X3VyzOTsbTpkxgd
         7M7yKCNHBjO/8GUGXmUdVzYBKRF5d30vXBwAiZXXbxmbgheasRySuLBvxRhLDVcN8sIQ
         Toi+thDq5MWAzU3LayVBrT5qfb9yRJpzXQPAveV+aVpOO+V/m917P2idtsl0ik/VgilC
         Jfw/MC0ByNLcVAXSD/B1GXPg8soH27pZk8pdvHYrjhjrSkRIJbGcAy3RWfqECV2hicmF
         25DCg3jbAnndSIfMq1r8NaTfqCPySHJPj6Z5zDp5UiiRq3EgOPLxhMhf/Umbt+o8Gmvz
         2UmA==
X-Gm-Message-State: ANoB5plmS4ZNhGCNFpTB18qUOqVwTuvUTAPlE749x1u5cwtUY5ObnxxG
        7EtnH+9oH8WAAytJEbCiMoMlHBt7lqRtiA==
X-Google-Smtp-Source: AA0mqf79AyazuLtjXg72fI9A7E59qHQZ/9oSMktAk9Ii7br/oTDXqhkfZ3E5pk1RgElZplB0gDOuyQ==
X-Received: by 2002:a5d:4584:0:b0:241:ec41:9f1f with SMTP id p4-20020a5d4584000000b00241ec419f1fmr5453331wrq.162.1669312298504;
        Thu, 24 Nov 2022 09:51:38 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b003c701c12a17sm6394192wmb.12.2022.11.24.09.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:51:37 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/11] misc: fastrpc: Assert held reservation lock for dma-buf mmapping
Date:   Thu, 24 Nov 2022 17:51:15 +0000
Message-Id: <20221124175125.418702-2-srinivas.kandagatla@linaro.org>
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

When userspace mmaps dma-buf's fd, the dma-buf reservation lock must be
held. Add locking sanity check to the dma-buf mmaping callback to ensure
that the locking assumption won't regress in the future.

Suggested-by: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 80811e852d8f..c6b9ddaa698b 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-resv.h>
 #include <linux/idr.h>
 #include <linux/list.h>
 #include <linux/miscdevice.h>
@@ -692,6 +693,8 @@ static int fastrpc_mmap(struct dma_buf *dmabuf,
 	struct fastrpc_buf *buf = dmabuf->priv;
 	size_t size = vma->vm_end - vma->vm_start;
 
+	dma_resv_assert_held(dmabuf->resv);
+
 	return dma_mmap_coherent(buf->dev, vma, buf->virt,
 				 FASTRPC_PHYS(buf->phys), size);
 }
-- 
2.25.1

