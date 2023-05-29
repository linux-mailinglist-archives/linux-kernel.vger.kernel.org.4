Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B352F714842
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjE2K7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjE2K7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:59:34 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45B3B2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:59:32 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d341bdedcso2298985b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685357972; x=1687949972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tYonR6LNuZCooEmlmgTKMf28bl9/ZTlTCygYn5q1Cw=;
        b=PSmEwZz643pnW8Xse8tY1hqnFmGInOC5b4zZrlmoZFPpZqkupjDpaW0LrQGo32BJdz
         D3swe/ZRiykdDI52GI9N2wuHsVJRr8A8/3hLLzaYua7xRDSzc7zHYUfFUxqSEQRDX6UP
         5lbDKZJXhwnj0sy6UezOo11WA4GLf/hZ/uCT+XTXMu3F24J2h5L+zc3Sq2BrXBsYldVs
         8uaIGxKQ9zgSj5Dld/rykhraq95m+PLW8Ucxs0Gu5MZ4JDcm9JAisnQxQmyc49Gszvio
         340nBpOxwIVEYY2nEEhhrjoM25k++YkFbTDzTWZXzbLjFRGRLb8P5f2EsRs+c+DivbMe
         4eGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685357972; x=1687949972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tYonR6LNuZCooEmlmgTKMf28bl9/ZTlTCygYn5q1Cw=;
        b=iQFwn1HySEx0oZkbG516Qr9vtVfKAhX6IAM2kgUZIYhmDhf3y2RWhhf4Np+Buf1ypd
         X1cXKItswHH27657fyb3Da57UkVmNZ+B2+TPGCfo2T/2YinkRBAAhvhS7CDx7HuNbsOF
         GjYx0ptRBGEMscu2M366TM94/GSOZ12zlKEwbwDfYpn5yoXhYGqUfKuGHXGexMNDpidM
         27eHZX7Mt9CdU7qgpBTI9o8/RXV6n6+vOwLhSX2IveoWfyOQYnptiRLPkvO0WsCjOzVH
         Cnf/cAVNtUwFkMQwp5BZvZoxJ8ZjaghBzmC1Iqb6FxvcPvhPuqYuPhv2s8VpNJFVAAuB
         G7CA==
X-Gm-Message-State: AC+VfDx3MPZS7aOh0vssVZa2QLQLKfFxeHNP6Vtu0Ynb/M2rHDP+E+8A
        fz/YwB8ipSE+RJPLm70qGxs=
X-Google-Smtp-Source: ACHHUZ4ygugDxsqcfbKWLBrVviCK5pvhu9JvUr44CQ8V7ogK9Db/5jSaRcvpGuwthUjh+dHPoY1zgg==
X-Received: by 2002:a05:6a20:12d6:b0:110:7edc:fb50 with SMTP id v22-20020a056a2012d600b001107edcfb50mr7535813pzg.9.1685357972097;
        Mon, 29 May 2023 03:59:32 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id v7-20020a63d547000000b0053f22b76cdcsm6863110pgi.82.2023.05.29.03.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 03:59:31 -0700 (PDT)
From:   "brookxu.cn" <brookxu.cn@gmail.com>
To:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/4] nvme: unfreeze while exit from recovery or resetting
Date:   Mon, 29 May 2023 18:59:23 +0800
Message-Id: <fd205548c8102ebbea3d09a7020b9b1fbc4beefb.1685350577.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685350577.git.chunguang.xu@shopee.com>
References: <cover.1685350577.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunguang Xu <chunguang.xu@shopee.com>

Remove controller will interrupt err_work/connect_work, leave
controller at freezed and IO queues at quiescing. Then IOs
issued by scan_work will be blocked,  nvme_remove_namespaces()
will hang on fush scan_work. Try to fix that we should unfreeze
contrller and unquiescing IO queues while exit from
error_recovery or resetting.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/tcp.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bf0230442d57..cfebcae7fc9b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2031,12 +2031,24 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	nvme_tcp_destroy_io_queues(ctrl, remove);
 }
 
+static inline void nvme_ctrl_reconnect_exit(struct nvme_ctrl *ctrl)
+{
+	/* fast fail all pending requests */
+	blk_mq_unquiesce_queue(ctrl->admin_q);
+
+	if (ctrl->queue_count > 1) {
+		nvme_unquiesce_io_queues(ctrl);
+		nvme_unfreeze(ctrl);
+	}
+}
+
 static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
 {
 	/* If we are resetting/deleting then do nothing */
 	if (ctrl->state != NVME_CTRL_CONNECTING) {
 		WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
 			ctrl->state == NVME_CTRL_LIVE);
+		nvme_ctrl_reconnect_exit(ctrl);
 		return;
 	}
 
@@ -2107,13 +2119,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	return 0;
 
 destroy_io:
-	if (ctrl->queue_count > 1) {
-		nvme_quiesce_io_queues(ctrl);
-		nvme_sync_io_queues(ctrl);
-		nvme_tcp_stop_io_queues(ctrl);
-		nvme_cancel_tagset(ctrl);
-		nvme_tcp_destroy_io_queues(ctrl, new);
-	}
+	nvme_tcp_teardown_io_queues(ctrl, new);
 destroy_admin:
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
@@ -2166,6 +2172,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 		/* state change failure is ok if we started ctrl delete */
 		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
 			     ctrl->state != NVME_CTRL_DELETING_NOIO);
+		nvme_ctrl_reconnect_exit(ctrl);
 		return;
 	}
 
@@ -2197,6 +2204,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 		/* state change failure is ok if we started ctrl delete */
 		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
 			     ctrl->state != NVME_CTRL_DELETING_NOIO);
+		nvme_ctrl_reconnect_exit(ctrl);
 		return;
 	}
 
@@ -2213,7 +2221,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
 {
 	flush_work(&to_tcp_ctrl(ctrl)->err_work);
-	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
+	flush_delayed_work(&to_tcp_ctrl(ctrl)->connect_work);
 }
 
 static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
-- 
2.25.1

