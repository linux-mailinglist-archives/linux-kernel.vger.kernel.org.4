Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE344637E99
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiKXRwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiKXRvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:51:45 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F1D13F4BE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:51:45 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id bs21so3462920wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTmLcUHM8TPUmaE0W/RaZtsLjw1tkQ7u3GK43vuBULU=;
        b=fO7DrylENu6t49oXq95ToTkrDPr9tSDxEM4MDfbVOrz7CbItBaACnnq6/eHUViKrje
         nZpa2kMdsY+ri9PUm/kdFP4UhMQDGAlABXG47GqzQ/01TzfsszJ2iP8irOGLb/0ggec3
         j3P7jXOKA8vMg0JBPDC3r+3w+V6U41xK5q4624MDGlcYM18iRBAHNmIm3A7ZqgTfGU0h
         /JOmxc2znQVFJ7EcveBmG6R251GG2aKpTP3hB5s6MsuzppAez+ItEVxnx2GkwtkXFQ95
         j233D917ZlzGwcOQIH0CprdE4Sddyg4Sl0FnkYZ0shS8K17MSCmDa4rSjUqjDUq/CRKY
         PhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTmLcUHM8TPUmaE0W/RaZtsLjw1tkQ7u3GK43vuBULU=;
        b=Om8zcpeBT65ttxoQKy7ofotFQs2w8O1AOvE58ni/wM+asuFSKUedfGehRQ+S4jhBY1
         JBa55FK9LeB1HwlnDTK+/4DtUQ2K+QKwy28L08Dd8ZBOqGVwHvGZIiYzsCaUJ4YsI/Ul
         FUKQ9nnv/qTQ5GilckxV8cG2m5kQj8Ep0yJBw7LeYZvya1FOGCBmfdE/HoLKdra55xJK
         oz/t9EuMkjg0XKGymM/8PRPYFep6cHAj++h3OkaUbCFGfccZXWrz0mYChgFNkxEAGnOl
         xb1knlmSygZZqNO1KPgqXRZXnHBvJ86+R7mTcOmegQc0X6ttWEuEmm6s9bV1Gm3prkzU
         mkrQ==
X-Gm-Message-State: ANoB5pmVqc0Tyu4jYKNMPCvFOGd1Ol0vUZwwauD8QVUppBRi2lyaRWSu
        arNGVa1814IqPpEvJRPoQmvqJQ==
X-Google-Smtp-Source: AA0mqf6JkG5XG2ut6luCUpi8fkJP/8kW9Ro0altTUIpC1y+0sl7prGtJQWrtDGVDSfg+5TgI6Dfimw==
X-Received: by 2002:adf:f48f:0:b0:236:715c:aaa6 with SMTP id l15-20020adff48f000000b00236715caaa6mr14334046wro.25.1669312303538;
        Thu, 24 Nov 2022 09:51:43 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b003c701c12a17sm6394192wmb.12.2022.11.24.09.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:51:43 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/11] misc: fastrpc: Add fastrpc_remote_heap_alloc
Date:   Thu, 24 Nov 2022 17:51:19 +0000
Message-Id: <20221124175125.418702-6-srinivas.kandagatla@linaro.org>
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

Split fastrpc_buf_alloc in such a way it allows allocation of remote
heap too and add fastrpc_remote_heap_alloc to do so.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 86d11ffadf29..0ddad976a4d2 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -380,7 +380,7 @@ static void fastrpc_buf_free(struct fastrpc_buf *buf)
 	kfree(buf);
 }
 
-static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
+static int __fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
 			     u64 size, struct fastrpc_buf **obuf)
 {
 	struct fastrpc_buf *buf;
@@ -408,14 +408,37 @@ static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
 		return -ENOMEM;
 	}
 
+	*obuf = buf;
+
+	return 0;
+}
+
+static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
+			     u64 size, struct fastrpc_buf **obuf)
+{
+	int ret;
+	struct fastrpc_buf *buf;
+
+	ret = __fastrpc_buf_alloc(fl, dev, size, obuf);
+	if (ret)
+		return ret;
+
+	buf = *obuf;
+
 	if (fl->sctx && fl->sctx->sid)
 		buf->phys += ((u64)fl->sctx->sid << 32);
 
-	*obuf = buf;
-
 	return 0;
 }
 
+static int fastrpc_remote_heap_alloc(struct fastrpc_user *fl, struct device *dev,
+				     u64 size, struct fastrpc_buf **obuf)
+{
+	struct device *rdev = &fl->cctx->rpdev->dev;
+
+	return  __fastrpc_buf_alloc(fl, rdev, size, obuf);
+}
+
 static void fastrpc_channel_ctx_free(struct kref *ref)
 {
 	struct fastrpc_channel_ctx *cctx;
-- 
2.25.1

