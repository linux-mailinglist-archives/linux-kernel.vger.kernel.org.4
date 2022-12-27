Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5F56566C3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 03:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbiL0CZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 21:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbiL0CZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 21:25:45 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3779DBEE
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 18:25:43 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id b2so12027806pld.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 18:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fCw3ePbQ4sWf6yjA8O8Z29UEVxW6bYbx76RpPXO7aY=;
        b=PdEinY5QSfamx3Mg38O2RR2okv24jZTiIqqQZSzIQSP/5YXvP+Qly0wyKRgl/F1uNK
         JangFsfS4pMaDyShPoK7l8kkT9Zh44XnLQo8hUlqWrsz5qe4ILWqcvzmy/7bB35gV0xj
         oPa5StauWTQq1jb57VF3CVOllZ3LRnEAymbQLB1k1skqbLxXPkBCpUdtA5Yw6SJ1BnV0
         R2MH3gioA5e3yYrRTjTM1T/Ci+Xzh/WM2nvicePmWnVaad6WutwHYASqAk9pxsh9SI09
         Z0Y7XT5B461WhBeQqZuHi5ZIyJMHvH5RLI2+oprZjrQraOdWfe99ZOsuUD68p5Jr7mlL
         yLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fCw3ePbQ4sWf6yjA8O8Z29UEVxW6bYbx76RpPXO7aY=;
        b=nwVEZ7KulMXXj+ZSkhOeFeNLuQjOWHSG+DPoety/4E05pjq6jJWGhh+YMt0KMydC1r
         q8x8j/E4UbsVvrEFpwy1pLNIYx3nN4qsiYlE0/0ZFd0OAvV8MQXBJM5KN3sNbZEPUlWj
         skCRZgcP8Vflo8yS95oWqU0cPMvttf/bIIJt0VLoLTI05fRZDbUGNokcmVArZX10j4Gi
         klcM/lzY91myRNruOszMT8WmQHUODVE+5a078Lj0Wt5Aggc6T+BFoHMvi2Fc3Ed7UlAq
         SICuyPOYZ7HCg65YsoDh09HfUhSIcSzSXyzu8TzXtC3NjKXpsAYhh4hSoD5W9Tq+k0hL
         Ykog==
X-Gm-Message-State: AFqh2kqdBQka6Uq1cK70kFWCTS3qSEuVOtBVIpg/W45zjuIG7LtSvM4N
        A3r0AmQE/aGI8lXkU8O2pX1USg==
X-Google-Smtp-Source: AMrXdXtibhicJEAQU7zlMTYHTx9LNjc53ZCY1j8YzALFGnjrccnlQk473w/zeMGg3h4pH4QlYbUMRQ==
X-Received: by 2002:a17:902:f706:b0:190:fc28:8cca with SMTP id h6-20020a170902f70600b00190fc288ccamr24903066plo.10.1672107943300;
        Mon, 26 Dec 2022 18:25:43 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709026f0f00b001870dc3b4c0sm2465014plk.74.2022.12.26.18.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 18:25:43 -0800 (PST)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Rusty Russell <rusty@rustcorp.com.au>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shunsuke Mie <mie@igel.co.jp>
Subject: [RFC PATCH 3/9] tools/virtio: convert to new vringh user APIs
Date:   Tue, 27 Dec 2022 11:25:25 +0900
Message-Id: <20221227022528.609839-4-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221227022528.609839-1-mie@igel.co.jp>
References: <20221227022528.609839-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct vringh_iov is being remove, so convert vringh_test to use the
vringh user APIs. This has it change to use struct vringh_kiov instead of
the struct vringh_iov.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 tools/virtio/vringh_test.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 98ff808d6f0c..6c9533b8a2ca 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -193,8 +193,8 @@ static int parallel_test(u64 features,
 			errx(1, "Could not set affinity to cpu %u", first_cpu);
 
 		while (xfers < NUM_XFERS) {
-			struct iovec host_riov[2], host_wiov[2];
-			struct vringh_iov riov, wiov;
+			struct kvec host_riov[2], host_wiov[2];
+			struct vringh_kiov riov, wiov;
 			u16 head, written;
 
 			if (fast_vringh) {
@@ -216,10 +216,10 @@ static int parallel_test(u64 features,
 				written = 0;
 				goto complete;
 			} else {
-				vringh_iov_init(&riov,
+				vringh_kiov_init(&riov,
 						host_riov,
 						ARRAY_SIZE(host_riov));
-				vringh_iov_init(&wiov,
+				vringh_kiov_init(&wiov,
 						host_wiov,
 						ARRAY_SIZE(host_wiov));
 
@@ -442,8 +442,8 @@ int main(int argc, char *argv[])
 	struct virtqueue *vq;
 	struct vringh vrh;
 	struct scatterlist guest_sg[RINGSIZE], *sgs[2];
-	struct iovec host_riov[2], host_wiov[2];
-	struct vringh_iov riov, wiov;
+	struct kvec host_riov[2], host_wiov[2];
+	struct vringh_kiov riov, wiov;
 	struct vring_used_elem used[RINGSIZE];
 	char buf[28];
 	u16 head;
@@ -517,8 +517,8 @@ int main(int argc, char *argv[])
 	__kmalloc_fake = NULL;
 
 	/* Host retreives it. */
-	vringh_iov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
-	vringh_iov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
+	vringh_kiov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
+	vringh_kiov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
 
 	err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange, &head);
 	if (err != 1)
@@ -586,8 +586,8 @@ int main(int argc, char *argv[])
 	__kmalloc_fake = NULL;
 
 	/* Host picks it up (allocates new iov). */
-	vringh_iov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
-	vringh_iov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
+	vringh_kiov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
+	vringh_kiov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
 
 	err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange, &head);
 	if (err != 1)
@@ -613,8 +613,8 @@ int main(int argc, char *argv[])
 		assert(err < 3 || buf[2] == (char)(i + 2));
 	}
 	assert(riov.i == riov.used);
-	vringh_iov_cleanup(&riov);
-	vringh_iov_cleanup(&wiov);
+	vringh_kiov_cleanup(&riov);
+	vringh_kiov_cleanup(&wiov);
 
 	/* Complete using multi interface, just because we can. */
 	used[0].id = head;
@@ -638,8 +638,8 @@ int main(int argc, char *argv[])
 	}
 
 	/* Now get many, and consume them all at once. */
-	vringh_iov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
-	vringh_iov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
+	vringh_kiov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
+	vringh_kiov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
 
 	for (i = 0; i < RINGSIZE; i++) {
 		err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange, &head);
@@ -723,8 +723,8 @@ int main(int argc, char *argv[])
 		d[5].flags = 0;
 
 		/* Host picks it up (allocates new iov). */
-		vringh_iov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
-		vringh_iov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
+		vringh_kiov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
+		vringh_kiov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
 
 		err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange, &head);
 		if (err != 1)
@@ -744,7 +744,7 @@ int main(int argc, char *argv[])
 		/* Data should be linear. */
 		for (i = 0; i < err; i++)
 			assert(buf[i] == i);
-		vringh_iov_cleanup(&riov);
+		vringh_kiov_cleanup(&riov);
 	}
 
 	/* Don't leak memory... */
-- 
2.25.1

