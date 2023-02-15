Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7837B6980EB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjBOQcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjBOQcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:32:12 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C643B0E8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 08:32:09 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id by3so18446229wrb.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 08:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4P+RPLywpWRpuXMP+b0VdhJHn8q4YXA5NPmEVVhViGs=;
        b=jqC05K0Ho1hrsMzWog/Vj2NDt/KsetoaPaLVtCxz5LWRqwpaJbDkCgR0g8sF0sGjKo
         uCbuTdUW/4rsEMTs7OIjJm7ohBX0hk31tg+XbF+cqPgfhxWZNJ69hqExsS8nIwOQXDWt
         eFQ+lFTiLo0zxr6utMc6wnU+1zEScQS57tqzr6BGtlYXiti66EA8yh+DW1PUZHOQOuxO
         rDY2jmOJlQ+TsSNPslo/bIZgOBC06YXqI+0LOQiz2gMcIh/ZAoOGA+a6IbPzNHFvZqvD
         hMLW3GEEm4LuKBcMKfC+4qABiFVsWF0/OSvv6Bfr7IrwiDDVU69rP1WE34J21UAJha4g
         9zJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4P+RPLywpWRpuXMP+b0VdhJHn8q4YXA5NPmEVVhViGs=;
        b=3qKd8sQDaEKIdE1hZeDDiNN4q/ptE4Z86g2ddzIWdSF8ReK0SoAEydIDCEqRyY+QEo
         6E+1vGE5aV7stx3SPJ29dlLNFwGLpVgrHxljg5+KQ/aGVWVIkisBju2kV0iiXAFq9ZDX
         DaWAtIR6muNPD+0gFzhGvNDclgN7VD4LA4sCbplVroR5xHlsXz1/gNPGVMIazUHzi0yc
         781ajFOE3H1LSSmYcBeU9jXcziFvh7LLxxLiMsyCctgwIicMqADbQktDG4GCh7aKOXKU
         0o9Mcd5u/MLEYU3/CKBII2l4Y+978RlpubrRlzsPgZ/UvBIPYpEJSCPmJ45hiOUtbTW8
         gOag==
X-Gm-Message-State: AO0yUKVZgg0Ol9LxFhdP30BJywwgvT3Rj/0t58vYqRflJykQJIHe5RaI
        gmCmlpR5lZ3FA2rzSz8vkvux5Q==
X-Google-Smtp-Source: AK7set8yo+nR05XUU5SfBkkgGGbdufdJY7xKV1xT+c09XYB0KRfUeRc0qhk+yTsPaKlRCYJ5bIN7Vg==
X-Received: by 2002:adf:ed07:0:b0:2c5:55c3:d18d with SMTP id a7-20020adfed07000000b002c555c3d18dmr1893102wro.9.1676478728423;
        Wed, 15 Feb 2023 08:32:08 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d67c4000000b002c56287bd2csm4865055wrw.114.2023.02.15.08.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 08:32:08 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        Andreas Gruenbacher <agruen@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 1/7] drbd: Rip out the ERR_IF_CNT_IS_NEGATIVE macro
Date:   Wed, 15 Feb 2023 17:31:58 +0100
Message-Id: <20230215163204.2856631-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215163204.2856631-1-christoph.boehmwalder@linbit.com>
References: <20230215163204.2856631-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_int.h | 37 ++++++++++++++---------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index d89b7d03d4c8..772023ace749 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1918,18 +1918,14 @@ static inline void inc_ap_pending(struct drbd_device *device)
 	atomic_inc(&device->ap_pending_cnt);
 }
 
-#define ERR_IF_CNT_IS_NEGATIVE(which, func, line)			\
-	if (atomic_read(&device->which) < 0)				\
-		drbd_err(device, "in %s:%d: " #which " = %d < 0 !\n",	\
-			func, line,					\
-			atomic_read(&device->which))
-
-#define dec_ap_pending(device) _dec_ap_pending(device, __func__, __LINE__)
-static inline void _dec_ap_pending(struct drbd_device *device, const char *func, int line)
+#define dec_ap_pending(device) ((void)expect((device), __dec_ap_pending(device) >= 0))
+static inline int __dec_ap_pending(struct drbd_device *device)
 {
-	if (atomic_dec_and_test(&device->ap_pending_cnt))
+	int ap_pending_cnt = atomic_dec_return(&device->ap_pending_cnt);
+
+	if (ap_pending_cnt == 0)
 		wake_up(&device->misc_wait);
-	ERR_IF_CNT_IS_NEGATIVE(ap_pending_cnt, func, line);
+	return ap_pending_cnt;
 }
 
 /* counts how many resync-related answers we still expect from the peer
@@ -1943,11 +1939,10 @@ static inline void inc_rs_pending(struct drbd_device *device)
 	atomic_inc(&device->rs_pending_cnt);
 }
 
-#define dec_rs_pending(device) _dec_rs_pending(device, __func__, __LINE__)
-static inline void _dec_rs_pending(struct drbd_device *device, const char *func, int line)
+#define dec_rs_pending(device) ((void)expect((device), __dec_rs_pending(device) >= 0))
+static inline int __dec_rs_pending(struct drbd_device *device)
 {
-	atomic_dec(&device->rs_pending_cnt);
-	ERR_IF_CNT_IS_NEGATIVE(rs_pending_cnt, func, line);
+	return atomic_dec_return(&device->rs_pending_cnt);
 }
 
 /* counts how many answers we still need to send to the peer.
@@ -1964,18 +1959,16 @@ static inline void inc_unacked(struct drbd_device *device)
 	atomic_inc(&device->unacked_cnt);
 }
 
-#define dec_unacked(device) _dec_unacked(device, __func__, __LINE__)
-static inline void _dec_unacked(struct drbd_device *device, const char *func, int line)
+#define dec_unacked(device) ((void)expect(device, __dec_unacked(device) >= 0))
+static inline int __dec_unacked(struct drbd_device *device)
 {
-	atomic_dec(&device->unacked_cnt);
-	ERR_IF_CNT_IS_NEGATIVE(unacked_cnt, func, line);
+	return atomic_dec_return(&device->unacked_cnt);
 }
 
-#define sub_unacked(device, n) _sub_unacked(device, n, __func__, __LINE__)
-static inline void _sub_unacked(struct drbd_device *device, int n, const char *func, int line)
+#define sub_unacked(device, n) ((void)expect(device, __sub_unacked(device) >= 0))
+static inline int __sub_unacked(struct drbd_device *device, int n)
 {
-	atomic_sub(n, &device->unacked_cnt);
-	ERR_IF_CNT_IS_NEGATIVE(unacked_cnt, func, line);
+	return atomic_sub_return(n, &device->unacked_cnt);
 }
 
 static inline bool is_sync_target_state(enum drbd_conns connection_state)
-- 
2.39.1

