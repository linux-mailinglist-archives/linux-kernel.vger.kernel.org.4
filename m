Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70102637E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiKXRt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiKXRtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:49:53 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDDD146FA6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:49:47 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id x17so3453352wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETuS/ZDws2DT8KOkGYpc0M9sZjTmBC+kSqRug/kfs+s=;
        b=wBQ1HND9z8sejyb+zqjOaM1X1LrGU1oSlXQ4/ofgf+1t1AKE1EtwI6PZ8Tri+dvaJx
         VQJ6FPF+1+p2swQ4bE5bqd8cHj0nOJsRzwDqgsQbKfj5AbsAqDUiaTWXT17gumACJs7k
         kJFufmNX8c1lD0ZnRb6xG0y7EpnqvMfDF402l95eyB8lWi9Cd36i34Olm7EFmVfxMFkH
         DWOfNbxqMW9rRkAfL5v1tvTek/O+0RbmT+9iQHp7bcTvD+mjFFcxMQqlVX4Xwv9iav7x
         CCm3uUmc8bjqfubvE/kFgUYnlkLYVON1zPAQOCgZ9vtS20KgKI8gEuC95Kn+9dc0RFIW
         XurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETuS/ZDws2DT8KOkGYpc0M9sZjTmBC+kSqRug/kfs+s=;
        b=TxQ6dfI9FSvjNzukP4oo7G6+qaSYyhQ3qJCVUlDm7yZG/fQRqJ+k+m8TAzfx3kJOsf
         yL7JzQmlPrxU8GCAxf4M/CzbxDvseJ/umToxGAZzE3cvHwk+GyrZcxWr/TsdCTt+CEPV
         jQ0ckrTChN3wtPegYYlGrFAKHk6bvLcg33nbrP/bcIrjNo+gOzgLb+6oQHaGCuIr6miQ
         RmMtriNUEnQ4s1y4T27giInRuIBfTrVZcX1gKOk+G9Mkws1jjxxDPUDfmLsx2Wd9SbIF
         ICQHrJNlCc/ILoERTGiVGNJTVRpegsc8zwVKovge76/OLQj3bnlDoePJ+ZqvtV6Uv5hu
         KUPw==
X-Gm-Message-State: ANoB5pndiGEwWI0E/B3lKuR6dZLYpDqEWbdxvdEwsDIq7FGCgXK/+7Q1
        Q5qZt5FFncgh4K+Hgp4vnD8Bxg==
X-Google-Smtp-Source: AA0mqf64vXtoeEO51fLM7U/uUO6E1N1fp6snZEZr9TUArEDNMuTKKrl8fBcglSl3treU193O+3ZE0w==
X-Received: by 2002:a5d:4601:0:b0:241:bf7b:b2e5 with SMTP id t1-20020a5d4601000000b00241bf7bb2e5mr17704618wrq.626.1669312186316;
        Thu, 24 Nov 2022 09:49:46 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l11-20020a1c790b000000b003b4a699ce8esm6250863wme.6.2022.11.24.09.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:49:45 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Ola Jeppsson <ola@snap.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/3] misc: fastrpc: Fix use-after-free and race in fastrpc_map_find
Date:   Thu, 24 Nov 2022 17:49:39 +0000
Message-Id: <20221124174941.418450-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124174941.418450-1-srinivas.kandagatla@linaro.org>
References: <20221124174941.418450-1-srinivas.kandagatla@linaro.org>
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

Currently, there is a race window between the point when the mutex is
unlocked in fastrpc_map_lookup and the reference count increasing
(fastrpc_map_get) in fastrpc_map_find, which can also lead to
use-after-free.

So lets merge fastrpc_map_find into fastrpc_map_lookup which allows us
to both protect the maps list by also taking the &fl->lock spinlock and
the reference count, since the spinlock will be released only after.
Add take_ref argument to make this suitable for all callers.

Fixes: 8f6c1d8c4f0c ("misc: fastrpc: Add fdlist implementation")
Co-developed-by: Ola Jeppsson <ola@snap.com>
Signed-off-by: Ola Jeppsson <ola@snap.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 7ff0b63c25e3..fc2173c59f8b 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -333,30 +333,31 @@ static void fastrpc_map_get(struct fastrpc_map *map)
 
 
 static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
-			    struct fastrpc_map **ppmap)
+			    struct fastrpc_map **ppmap, bool take_ref)
 {
+	struct fastrpc_session_ctx *sess = fl->sctx;
 	struct fastrpc_map *map = NULL;
+	int ret = -ENOENT;
 
-	mutex_lock(&fl->mutex);
+	spin_lock(&fl->lock);
 	list_for_each_entry(map, &fl->maps, node) {
-		if (map->fd == fd) {
-			*ppmap = map;
-			mutex_unlock(&fl->mutex);
-			return 0;
-		}
-	}
-	mutex_unlock(&fl->mutex);
-
-	return -ENOENT;
-}
+		if (map->fd != fd)
+			continue;
 
-static int fastrpc_map_find(struct fastrpc_user *fl, int fd,
-			    struct fastrpc_map **ppmap)
-{
-	int ret = fastrpc_map_lookup(fl, fd, ppmap);
+		if (take_ref) {
+			ret = fastrpc_map_get(map);
+			if (ret) {
+				dev_dbg(sess->dev, "%s: Failed to get map fd=%d ret=%d\n",
+					__func__, fd, ret);
+				break;
+			}
+		}
 
-	if (!ret)
-		fastrpc_map_get(*ppmap);
+		*ppmap = map;
+		ret = 0;
+		break;
+	}
+	spin_unlock(&fl->lock);
 
 	return ret;
 }
@@ -703,7 +704,7 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 	struct fastrpc_map *map = NULL;
 	int err = 0;
 
-	if (!fastrpc_map_find(fl, fd, ppmap))
+	if (!fastrpc_map_lookup(fl, fd, ppmap, true))
 		return 0;
 
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
@@ -1026,7 +1027,7 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 	for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
 		if (!fdlist[i])
 			break;
-		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap))
+		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap, false))
 			fastrpc_map_put(mmap);
 	}
 
-- 
2.25.1

