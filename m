Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8E36980EC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjBOQcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBOQcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:32:12 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5496D3B0F9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 08:32:11 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id k3so12127566wrv.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 08:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tcb29/6rtQpwc/kpAeczx/YDjGscreJ2xzUEcJHD+jU=;
        b=SiULoR+ISmuhrNAnD07QKQb8SYSxgMwZ7pAAEstG7eURaU9WssGRca+FKa+4X46naD
         RXqTk1tz6ABgPP51rAEEECEvfmUX/HNqOPvIJiJed8Ykj2Fj3VhXCH8Sl4Cddk3+ct3Z
         3d+Na8/yxRgaBJffnSp1WRTCU4Nnvnabdx3flKmm5Rf+pqmXB/ixqs4yKvcAFP3QYKuH
         YuUv+Iz4ecDpzfPEUnQTvU8j4LxMsisURHuuedKlf6PQX7fXpWGph2koB8Aplg3Xz4BS
         Ibfpc8Vq8Di3IEDz2F35QQBkYR3yUt6368t7CMX/yLQBCjc5ILFfrcLcx9ClTy0sI6V2
         KnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tcb29/6rtQpwc/kpAeczx/YDjGscreJ2xzUEcJHD+jU=;
        b=T38rL8HVIJstrL6DTrIpXvcPGog+jpq38gPG3fAXee03yvoCHaoalbpj+W249hyOZY
         sondTGGTRMoCu/iHf9RjN9PvzLjnvUvrMoVwN1VgfVQAfgQ704+SxgH2ZgVhVa0lyMMa
         WqOUp/3bsGKI2u92lcILHh0uz3nIn4vt1MrkragpYK4qHv312G+EFh8zDg2rkdoIXrZR
         LZjXzLrbytSOASVluC1oKEG0Kk6kKpwXEgf0qXcntrhwjIU1e+5qYhIgv5wq37YTNz2X
         uu0k25g5VUrlIGm5IXQ7ziHdFmcvdTMF1bpY8X5Zvia43xcErf/YOL+Y0OuSCIzXahxd
         yx8A==
X-Gm-Message-State: AO0yUKUD2TmAyD0eprKjwXxkmMqtfxGm958JSVaZAHvMwZkJUIHOicLp
        KN5SwMc3VXL8ubW8HCSOshkyqA==
X-Google-Smtp-Source: AK7set+R1ETjxF5meR15HBFQTAyoHQ/uqK2I8nZZ1ZDgQj9yueHElN0lk1qd2JTeWXj5jk0CviwI+w==
X-Received: by 2002:a05:6000:120e:b0:2c5:4784:6f0c with SMTP id e14-20020a056000120e00b002c547846f0cmr2521322wrx.15.1676478729819;
        Wed, 15 Feb 2023 08:32:09 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d67c4000000b002c56287bd2csm4865055wrw.114.2023.02.15.08.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 08:32:09 -0800 (PST)
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
Subject: [PATCH 3/7] drbd: INFO_bm_xfer_stats(): Pass a peer device argument
Date:   Wed, 15 Feb 2023 17:32:00 +0100
Message-Id: <20230215163204.2856631-4-christoph.boehmwalder@linbit.com>
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
 drivers/block/drbd/drbd_int.h      | 4 ++--
 drivers/block/drbd/drbd_main.c     | 2 +-
 drivers/block/drbd/drbd_receiver.c | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 63919781fe30..8b4d06e10365 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -126,8 +126,8 @@ struct bm_xfer_ctx {
 	unsigned bytes[2];
 };
 
-extern void INFO_bm_xfer_stats(struct drbd_device *device,
-		const char *direction, struct bm_xfer_ctx *c);
+extern void INFO_bm_xfer_stats(struct drbd_peer_device *peer_device,
+			       const char *direction, struct bm_xfer_ctx *c);
 
 static inline void bm_xfer_ctx_bit_to_word_offset(struct bm_xfer_ctx *c)
 {
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 5d98017497e4..6f2955f2dcc9 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1247,7 +1247,7 @@ send_bitmap_rle_or_plain(struct drbd_peer_device *device, struct bm_xfer_ctx *c)
 	}
 	if (!err) {
 		if (len == 0) {
-			INFO_bm_xfer_stats(device, "send", c);
+			INFO_bm_xfer_stats(peer_device, "send", c);
 			return 0;
 		} else
 			return 1;
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 424748f6e4fa..aa896db1767d 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4766,11 +4766,11 @@ decode_bitmap_c(struct drbd_peer_device *peer_device,
 	return -EIO;
 }
 
-void INFO_bm_xfer_stats(struct drbd_device *device,
+void INFO_bm_xfer_stats(struct drbd_peer_device *peer_device,
 		const char *direction, struct bm_xfer_ctx *c)
 {
 	/* what would it take to transfer it "plaintext" */
-	unsigned int header_size = drbd_header_size(first_peer_device(device)->connection);
+	unsigned int header_size = drbd_header_size(peer_device->connection);
 	unsigned int data_size = DRBD_SOCKET_BUFFER_SIZE - header_size;
 	unsigned int plain =
 		header_size * (DIV_ROUND_UP(c->bm_words, data_size) + 1) +
@@ -4794,7 +4794,7 @@ void INFO_bm_xfer_stats(struct drbd_device *device,
 		r = 1000;
 
 	r = 1000 - r;
-	drbd_info(device, "%s bitmap stats [Bytes(packets)]: plain %u(%u), RLE %u(%u), "
+	drbd_info(peer_device, "%s bitmap stats [Bytes(packets)]: plain %u(%u), RLE %u(%u), "
 	     "total %u; compression: %u.%u%%\n",
 			direction,
 			c->bytes[1], c->packets[1],
@@ -4872,7 +4872,7 @@ static int receive_bitmap(struct drbd_connection *connection, struct packet_info
 			goto out;
 	}
 
-	INFO_bm_xfer_stats(device, "receive", &c);
+	INFO_bm_xfer_stats(peer_device, "receive", &c);
 
 	if (device->state.conn == C_WF_BITMAP_T) {
 		enum drbd_state_rv rv;
-- 
2.39.1

