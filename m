Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E22637E8F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiKXRuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKXRty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:49:54 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D50914A2EB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:49:49 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id x5so3459424wrt.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnrDbdRJkbksqZItXruR6kyL5+sqtubhQgH9dDxfehQ=;
        b=xoMkl3EeeMJyo2ElRyotEqbHF4q3toa1fIBVElAPlmfzfxIlN/Tv9nzrFEvqKil4U/
         T75C7W15kUrJq4v5/Pp6sX+DBu/0JPFeMJE04JZ0B8+1qRZkB74QFhAfJu5fQpuMLsg2
         NG15tCUEQrlJI+1nTxOou0+jKdYTrAdqzZJOEgc1r5sMNasBL/fbyfIRDVQtVyVrpxxp
         AmwszvnbzSEqM2HkdCprCvHXGKr8ZH4y7QeTTjJNynOcy3ezTJtZVTfc3lrNqUCFSMoF
         l765G/f21FSHhFSMS984AihwFVeebbBXbkIfHYV59Lch5+Gn3B6BUAbGu5rLbXl1F7wm
         D8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnrDbdRJkbksqZItXruR6kyL5+sqtubhQgH9dDxfehQ=;
        b=mnVCSLw8rQ4keoJMScOGohluU/WMOlRXl94NfnuX/qjjG4IG+ea7+dHwstu+R89m5g
         XIZ/HuwhlWqpIJ/WqKavG/oDFJaa3U+/9ztQ57uTuth4qcOWXO2AOLhLK4PJrWHghp0g
         3yMosvXIZYc1eL6CoxWTro5ZCZ9OFKCyUwiwQk1IZxzoVTvG3/iSl0P9l5ciHKYciWBF
         tXP/4mkffY2lScYtZ5V1vuzscssGL3vrxE3RXEsRBekyBeIBGyjg3ViLiAdkcL5ippnc
         JinTb/0S9KKWiZ1nhD2HjHrNcrx9v5cooDvtimP6Y827ZH/SsabGGNTcXTUWCDISyqVf
         io6Q==
X-Gm-Message-State: ANoB5pnDhMnArzJ2dkWuhLu7wk5lvFZ+Lna7QUoG56Ye/D5WFI8b9dkx
        t2MKxKhjb5g65/nXw0TMoX1dow==
X-Google-Smtp-Source: AA0mqf6zIsKV2cNw5MNIc5hWrXSQbLgOgCA06wPURrAvGy4D6Zu6D4mui3Y6CpYaH4oDMecauRctqw==
X-Received: by 2002:a5d:6b46:0:b0:236:56a6:823e with SMTP id x6-20020a5d6b46000000b0023656a6823emr20762122wrw.495.1669312188150;
        Thu, 24 Nov 2022 09:49:48 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l11-20020a1c790b000000b003b4a699ce8esm6250863wme.6.2022.11.24.09.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:49:47 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Ola Jeppsson <ola@snap.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/3] misc: fastrpc: Don't remove map on creater_process and device_release
Date:   Thu, 24 Nov 2022 17:49:40 +0000
Message-Id: <20221124174941.418450-3-srinivas.kandagatla@linaro.org>
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

Do not remove the map from the list on error path in
fastrpc_init_create_process, instead call fastrpc_map_put, to avoid
use-after-free. Do not remove it on fastrpc_device_release either,
call fastrpc_map_put instead.

The fastrpc_free_map is the only proper place to remove the map.
This is called only after the reference count is 0.

Fixes: b49f6d83e290 ("misc: fastrpc: Fix a possible double free")
Co-developed-by: Ola Jeppsson <ola@snap.com>
Signed-off-by: Ola Jeppsson <ola@snap.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index fc2173c59f8b..9ecbf673d321 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -316,6 +316,13 @@ static void fastrpc_free_map(struct kref *ref)
 		dma_buf_put(map->buf);
 	}
 
+	if (map->fl) {
+		spin_lock(&map->fl->lock);
+		list_del(&map->node);
+		spin_unlock(&map->fl->lock);
+		map->fl = NULL;
+	}
+
 	kfree(map);
 }
 
@@ -1266,12 +1273,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	fl->init_mem = NULL;
 	fastrpc_buf_free(imem);
 err_alloc:
-	if (map) {
-		spin_lock(&fl->lock);
-		list_del(&map->node);
-		spin_unlock(&fl->lock);
-		fastrpc_map_put(map);
-	}
+	fastrpc_map_put(map);
 err:
 	kfree(args);
 
@@ -1347,10 +1349,8 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 		fastrpc_context_put(ctx);
 	}
 
-	list_for_each_entry_safe(map, m, &fl->maps, node) {
-		list_del(&map->node);
+	list_for_each_entry_safe(map, m, &fl->maps, node)
 		fastrpc_map_put(map);
-	}
 
 	list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
 		list_del(&buf->node);
-- 
2.25.1

