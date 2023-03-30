Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1355A6D0126
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjC3K2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjC3K1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:27:53 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CCF83F2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:27:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r29so18503611wra.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112; t=1680172069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zMenm1DZpmHocR+5Pohn/nlHFQgV1jhAeYfGdQoef0=;
        b=IkZDbJDpMPzQRtZHRJvovLadMdzAd+SRx2aObpfWLH2VEl8OAwN/9PyG/SNXyUF4Z+
         5TP2/Q7EOEWXQLX6yha1AV/M+08uJB/HYiTG/DBDrfg4s+0nYK/dzdA1INywl8pbzoYM
         UoKrS3P37etkxbyIhI0b74uDjIP4a2BSoD6B2QKGlNHfV7lxsAzfAbJ1dEgIysYyebR4
         EtUHbydQiGjqU8TjMuBqC2XIIyHP27ZETFMHC8j3PPz+i4CMsSq9EVXjf4naMVHphndM
         2svTSwMst46MVuq2SIHZ9H3bW0zapv7n6mvFev7q9cSvBru1/+cP880QwzYTMSwl9tlQ
         TwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680172069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zMenm1DZpmHocR+5Pohn/nlHFQgV1jhAeYfGdQoef0=;
        b=NU9dByJfqYYPdFhHSUol3EGgYA2a22SWhbvtoGumMeW9NEdnBMazeIn2eDgZ5Uxjts
         2cU7JJ1aFtorUO0PzpR47W0P4EEk56mMzHRl1k7g6IjdOHPJLze4OeZnEYjmqkEiWCsX
         ukEzkADr6SPHMeV1hZ9UHczS0DW14scOvDzOe6FEUs+ngWy06SEYPgO4X500lw+ZXDre
         8qH7kFOreJOKk2zzXujjc2+TMiL0OGbZsFDfjjhuzIAeuS3Q0PMRfYVtkHTYEaeq0Voo
         cThn/ewz3z/j5dVxhlnlm2BSoZJwAftlh3WPz5BZOEadaTxEzrxpzoimhJ4qMZ9cZMT4
         n8Ag==
X-Gm-Message-State: AAQBX9dSh1rj01bU9+jS1SbszoroIgTM9oTG1jhEsf/piV/PIrOyFuHk
        MIn20eVt9pIw0O5TiBBiyFIKpg==
X-Google-Smtp-Source: AKy350YNTr9iU5PMyf0dtk1XSu7+m2gGnTT+oWZcNNxu2dPqnZkerqTVFTJJUGDTRemcjWti8zvFrw==
X-Received: by 2002:a5d:4bc2:0:b0:2e5:2e0a:d958 with SMTP id l2-20020a5d4bc2000000b002e52e0ad958mr238752wrt.65.1680172069377;
        Thu, 30 Mar 2023 03:27:49 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id s11-20020adff80b000000b002d6f285c0a2sm26352514wrp.42.2023.03.30.03.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 03:27:49 -0700 (PDT)
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
Subject: [PATCH v3 2/7] drbd: Rip out the ERR_IF_CNT_IS_NEGATIVE macro
Date:   Thu, 30 Mar 2023 12:27:39 +0200
Message-Id: <20230330102744.2128122-3-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330102744.2128122-1-christoph.boehmwalder@linbit.com>
References: <20230330102744.2128122-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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
2.39.2

