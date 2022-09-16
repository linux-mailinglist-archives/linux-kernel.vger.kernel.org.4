Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3495BB06B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiIPPlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIPPlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:41:20 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0C0AB1A4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:41:19 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id 13so21312166ejn.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ldvybrosVi8MveMV26a/sw9frFQdtZWh0kJMoa+dSIc=;
        b=GzFxBcmy5kN+ZV5Tv2gg7T9qR8wN6l1M49Ln4xe+q+ItR0qNzzxhdBnD1bto1V/EmJ
         b5kfgpmuBfEpn5CK8akv1wtEZpYs6WWEYsKdY5VStSmvwm7i3FFfqDPfMWPLOteGIQYj
         qb09rl/HFtfRx4lc/7/HbNNIugYBwlkWsw/sqciA4T65PynOp+Vcihq2qxU6u0mrGfL2
         exg/2q8z9WqFKroHi7D94gqN49nLtmd1oQAfh6tB8FmTAH9gPyHxtdwtmQyYe+bq8GGO
         A+z2sVKs3d0vEtMJ/ErWeh31rLjvie3YqJm68NPusCs5DwgB9gC7dPHoj118w53TjYCH
         X4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ldvybrosVi8MveMV26a/sw9frFQdtZWh0kJMoa+dSIc=;
        b=V0+8hjQL47kIGy0Hlw4oouB4RdsWSmbCDqYvNDWXAIp7ZPfwbaFFMlGdykocgUQlde
         O6IhWRIOxbHQZ0r0ohiLjc3PWIXnCRZig4EsydnxwCjaixp/fKEPKaYbdvwyOFmHLVOD
         R21vH3IDzYt1VQFRnbfNSDZCskonZe2e6zTo0AnmnmTBcBC+t4p+2b8SkQtoBPVzRATT
         v51Mjm2e/+BGLxQqNY2y60dcffTjuDZFiRDBkeD7e+WpjgUc0JXz3oqmF/NrO03K+nDG
         +0QwbFQ1ihzgYEGpCqdA0LloQZvyUx6huAVNK0FaspDBCCSPWLHa7MaXVYLxZCucS9eX
         IdKQ==
X-Gm-Message-State: ACrzQf2+KKLElCRLnpfIEm40t9W47kkZIOM9FG2u06WxyHGP15pfd+1g
        qHLrx6k7tz0f+9OC1jc3F/Vn9g==
X-Google-Smtp-Source: AMsMyM7X5ou5QgnKxl4UqQ4fTjHWhE9NEb1laaf2fHPI5nLqXbjGnbKSDc1F2ohOxzx37Pnpbf1sBw==
X-Received: by 2002:a17:906:db0d:b0:77b:a7cd:8396 with SMTP id xj13-20020a170906db0d00b0077ba7cd8396mr4190962ejb.264.1663342878246;
        Fri, 16 Sep 2022 08:41:18 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id e10-20020a1709062c0a00b0073d638a7a89sm10567707ejh.99.2022.09.16.08.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 08:41:17 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>,
        Bharath Kumar <bkumar@qti.qualcomm.com>,
        Himateja Reddy <hmreddy@quicinc.com>,
        Anirudh Raghavendra <araghave@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/9] misc: fastrpc: Add fastrpc_remote_heap_alloc
Date:   Fri, 16 Sep 2022 18:40:56 +0300
Message-Id: <20220916154102.1768088-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220916154102.1768088-1-abel.vesa@linaro.org>
References: <20220916154102.1768088-1-abel.vesa@linaro.org>
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

Split fastrpc_buf_alloc in such a way it allows allocation of remote
heap too and add fastrpc_remote_heap_alloc to do so.

Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
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
2.34.1

