Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15BF638457
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 08:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiKYHPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 02:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiKYHO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:14:56 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2032CCA3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:14:49 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q7so4544607wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOy39E3z+tLbSKBZY/E/x0gfjAwKzajrIG8av3Fi5No=;
        b=gWPgHUNHXi7xQrJEH1IwSQ8ct/pWAFcE8MyedJ7tPvOowbCS/OFbGw406kyV397FDT
         Fbo51jESZLTK5QvsfDGFRotmoPkR96/Rm5bgH6XmBPkUT4FPyfZ5KDVp8QW7qYn5EhbO
         3zGmCshM8Io4b/5d6611DoKsJSapjlvf+q+jqMz30fG6XA3+NMWguBZ+edJlyCLgHXCp
         tKouT3ElvRg5BnOTo4tUfgLuicQtAyJuwAmryvA7LgdgXHGkU2YXgtVXnEM5EM8L9fbc
         XIV8rsorvbeUnkVyj0AkdlrJt7xlYyzdW46FbWTo5KRZ7MY2WlL6d6ULflnJeoIC3qLa
         sHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOy39E3z+tLbSKBZY/E/x0gfjAwKzajrIG8av3Fi5No=;
        b=POvBHB1nI37UUneD/U9OyNKxeYlWRQYfhgzUzsmtV6qq2J8u6KJX4/It5NZDpqcT4M
         Qo3uXHZY+CconepVAf4zF31gXor2wYD739L/YUJWRnG/u+cy274J4pbw5lX4HufMllps
         B4bWWH1rauR7BOiuV8FZxl5qz3GsIzHGhPh0SSUvQ3GR3rtT0xQwSbx1SdG1PBenkU4H
         irRPbaoZa7NCxVrWwvDOi4i3hXlML5gc+Ryi6Tqi57ZeMZ5zuTO3H2OnI4qG06ijzDgs
         fCBKtS2m9VHHnVjmZ0vXx/rZHaBgG6p2VDhgeJOMrmqMaVtmapmKnJE7IyzQGZfh7ZOT
         Z0Kg==
X-Gm-Message-State: ANoB5pky/t8FLONsj3eyFOacC7/6uE5bkWhQWlr9FTqbuMS10bx4UtwD
        EdBoCsaiDE1z+sfV/iyw+rX1Sw==
X-Google-Smtp-Source: AA0mqf6cnaru8ogX9EGpKG3CjRl+g0DTd3/Id836OxJ4SBKsoxKADscmV8Ltw9pt+wD0jGaf+tIiBg==
X-Received: by 2002:a5d:6551:0:b0:236:8fa1:47cf with SMTP id z17-20020a5d6551000000b002368fa147cfmr23245207wrv.50.1669360487867;
        Thu, 24 Nov 2022 23:14:47 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003cfd4cf0761sm9108444wmq.1.2022.11.24.23.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 23:14:47 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 04/10] misc: fastrpc: Add fastrpc_remote_heap_alloc
Date:   Fri, 25 Nov 2022 07:13:59 +0000
Message-Id: <20221125071405.148786-5-srinivas.kandagatla@linaro.org>
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

Split fastrpc_buf_alloc in such a way it allows allocation of remote
heap too and add fastrpc_remote_heap_alloc to do so.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 395036a10e15..9e83743eaca1 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -379,7 +379,7 @@ static void fastrpc_buf_free(struct fastrpc_buf *buf)
 	kfree(buf);
 }
 
-static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
+static int __fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
 			     u64 size, struct fastrpc_buf **obuf)
 {
 	struct fastrpc_buf *buf;
@@ -407,14 +407,37 @@ static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
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

