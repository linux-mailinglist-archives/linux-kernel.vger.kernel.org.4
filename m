Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6DD7418A5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjF1TH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjF1THC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:07:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E3526AB
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:06:58 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51d9128494cso4556238a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1687979217; x=1690571217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k09MsLBHwTc+y9WYz50c8Y73VYgCsBkw4p9DqkCCN/M=;
        b=AMrm8MGS8YsjLjsAEPiKS0/uHUYlIE1gZyHmH/mHOzZRfp3DgrhhgqGOc7Y1du/0Ns
         +vrRD7Ix5cumjIVFj0Az8G3vMK7rGO6lgJLmLNw7UkFpQ8uQpzM5L78cp3UPSeLkBKkp
         2ndQ+7cCB1PoaCz4ekU6RKY0+lnwP8SvXJrBSeBahEYWsy0CP5TTUnGJzzVD7Bab8cwd
         0e4RqEYNzHRJOHjdxXtf+RLOPCaaP/KK9bx3sP94URvC41wNbwKDSJKppPK39KiJ5Net
         b3I+hpw0s1i2H0FeZkEqrxV7Pkx6sj+4+D2XKanPcpHe+rV2Jg/yvA9ONYOTThU+nfx6
         YCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687979217; x=1690571217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k09MsLBHwTc+y9WYz50c8Y73VYgCsBkw4p9DqkCCN/M=;
        b=lx2RgbBRr1CXnAGKJhnlLxKeFgi7g2hmFB3SbsE/fUiY4frj+GV/wKNrf0gpkfsGaq
         1UX5IuAknTu94t6Yg0/ZQ0BSfYXQkBbyOgFWExuzC29uIDVy3bSZkrdZAHJ15spmWcZV
         u5WscWZ0JSkL90y/gpNSir40qlmgk09TRVUAyhFeGcjeEHc9Sms3LuJfL+MchxleZ6hu
         9EpUze7vMohYyBLQ1jKsANndZF3newZtYVKR4VkHGAu7rfcEc171LI94eF8SXeWq8Pg3
         qUbdCdoi/vf8/vlyfIgwM3ufaJJPwMsmbHv3CYWLVsjokBhgSPmBj0EIuADaPMeXw/rU
         lWqg==
X-Gm-Message-State: AC+VfDw7QqRhxygo7gAdTAug35C2hFHr1ciQHqhr7aFC6CYaVQOSRjVG
        w+rTG3Aq5fg63mSxk7RPDj46Ww==
X-Google-Smtp-Source: ACHHUZ47B59+EwXNTtLbz5NYO9F7exmS/Irop+y0C3KyOndwvuKjPWPzYTPUFXHxPVU2OC0mnsgrZA==
X-Received: by 2002:a05:6402:892:b0:51d:d41b:26a5 with SMTP id e18-20020a056402089200b0051dd41b26a5mr1285108edy.14.1687979217241;
        Wed, 28 Jun 2023 12:06:57 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id e2-20020a170906080200b0098503ba0db4sm6150511ejd.149.2023.06.28.12.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 12:06:56 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Christoph Hellwig <hch@infradead.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org (open list),
        Damien Le Moal <dlemoal@kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH v4 4/4] ublk: add zone append
Date:   Wed, 28 Jun 2023 21:06:49 +0200
Message-ID: <20230628190649.11233-5-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628190649.11233-1-nmi@metaspace.dk>
References: <20230628190649.11233-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

Add zone append feature to ublk. This feature uses the `addr` field of `struct
ublksrv_io_cmd`. Therefore ublk must be used with the user copy
feature (UBLK_F_USER_COPY) for zone append to be available. Without this
feature, ublk will fail zone append requests.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 drivers/block/ublk_drv-zoned.c | 11 +++++++++
 drivers/block/ublk_drv.c       | 43 ++++++++++++++++++++++++++++++----
 drivers/block/ublk_drv.h       |  1 +
 include/uapi/linux/ublk_cmd.h  |  3 ++-
 4 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv-zoned.c b/drivers/block/ublk_drv-zoned.c
index ea86bf4b3681..007e8fc7ff25 100644
--- a/drivers/block/ublk_drv-zoned.c
+++ b/drivers/block/ublk_drv-zoned.c
@@ -16,6 +16,16 @@ void ublk_set_nr_zones(struct ublk_device *ub)
 		ub->ub_disk->nr_zones = p->dev_sectors / p->chunk_sectors;
 }
 
+int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
+{
+	const struct ublk_param_zoned *p = &ub->params.zoned;
+
+	if (! p->max_zone_append_sectors)
+		return -EINVAL;
+
+	return 0;
+}
+
 void ublk_dev_param_zoned_apply(struct ublk_device *ub)
 {
 	const struct ublk_param_zoned *p = &ub->params.zoned;
@@ -23,6 +33,7 @@ void ublk_dev_param_zoned_apply(struct ublk_device *ub)
 	if (ub->dev_info.flags & UBLK_F_ZONED) {
 		disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
 		disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
+		blk_queue_max_zone_append_sectors(ub->ub_disk->queue, p->max_zone_append_sectors);
 	}
 }
 
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 88fa39853c61..6a949669b47e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -107,6 +107,11 @@ struct ublk_uring_cmd_pdu {
  */
 #define UBLK_IO_FLAG_NEED_GET_DATA 0x08
 
+/*
+ * Set when IO is Zone Append
+ */
+#define UBLK_IO_FLAG_ZONE_APPEND 0x10
+
 struct ublk_io {
 	/* userspace buffer address from io cmd */
 	__u64	addr;
@@ -230,6 +235,8 @@ static void ublk_dev_param_discard_apply(struct ublk_device *ub)
 
 static int ublk_validate_params(const struct ublk_device *ub)
 {
+	int ret = 0;
+
 	/* basic param is the only one which must be set */
 	if (ub->params.types & UBLK_PARAM_TYPE_BASIC) {
 		const struct ublk_param_basic *p = &ub->params.basic;
@@ -260,6 +267,13 @@ static int ublk_validate_params(const struct ublk_device *ub)
 	if (ub->params.types & UBLK_PARAM_TYPE_DEVT)
 		return -EINVAL;
 
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
+	    (ub->params.types & UBLK_PARAM_TYPE_ZONED)) {
+		ret = ublk_dev_param_zoned_validate(ub);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -690,6 +704,11 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 			return BLK_STS_IOERR;
 		}
 	case REQ_OP_ZONE_APPEND:
+		if (!(ubq->dev->dev_info.flags & UBLK_F_USER_COPY))
+			return BLK_STS_IOERR;
+		ublk_op = UBLK_IO_OP_ZONE_APPEND;
+		io->flags |= UBLK_IO_FLAG_ZONE_APPEND;
+		break;
 	case REQ_OP_ZONE_RESET_ALL:
 	case REQ_OP_DRV_OUT:
 		/* We do not support zone append or reset_all yet */
@@ -1112,6 +1131,12 @@ static void ublk_commit_completion(struct ublk_device *ub,
 	/* find the io request and complete */
 	req = blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
 
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
+		if (io->flags & UBLK_IO_FLAG_ZONE_APPEND)
+			req->__sector = ub_cmd->addr;
+		io->flags &= ~UBLK_IO_FLAG_ZONE_APPEND;
+	}
+
 	if (req && likely(!blk_should_fake_timeout(req->q)))
 		ublk_put_req_ref(ubq, req);
 }
@@ -1411,7 +1436,8 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			^ (_IOC_NR(cmd_op) == UBLK_IO_NEED_GET_DATA))
 		goto out;
 
-	if (ublk_support_user_copy(ubq) && ub_cmd->addr) {
+	if (ublk_support_user_copy(ubq) &&
+	    !(io->flags & UBLK_IO_FLAG_ZONE_APPEND) && ub_cmd->addr) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1534,11 +1560,14 @@ static inline bool ublk_check_ubuf_dir(const struct request *req,
 		int ubuf_dir)
 {
 	/* copy ubuf to request pages */
-	if (req_op(req) == REQ_OP_READ && ubuf_dir == ITER_SOURCE)
+	if ((req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_DRV_IN) &&
+	    ubuf_dir == ITER_SOURCE)
 		return true;
 
 	/* copy request pages to ubuf */
-	if (req_op(req) == REQ_OP_WRITE && ubuf_dir == ITER_DEST)
+	if ((req_op(req) == REQ_OP_WRITE ||
+	     req_op(req) == REQ_OP_ZONE_APPEND) &&
+	    ubuf_dir == ITER_DEST)
 		return true;
 
 	return false;
@@ -1867,6 +1896,12 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 	ub->dev_info.ublksrv_pid = ublksrv_pid;
 	ub->ub_disk = disk;
 
+	ub->dev_info.state = UBLK_S_DEV_LIVE;
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
+	    ub->dev_info.flags & UBLK_F_ZONED) {
+		disk_set_zoned(disk, BLK_ZONED_HM);
+	}
+
 	ret = ublk_apply_params(ub);
 	if (ret)
 		goto out_put_disk;
@@ -1877,7 +1912,6 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
 	    ub->dev_info.flags & UBLK_F_ZONED) {
-		disk_set_zoned(disk, BLK_ZONED_HM);
 		blk_queue_required_elevator_features(disk->queue, ELEVATOR_F_ZBD_SEQ_WRITE);
 		ret = ublk_revalidate_disk_zones(disk);
 		if (ret)
@@ -1885,7 +1919,6 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 	}
 
 	get_device(&ub->cdev_dev);
-	ub->dev_info.state = UBLK_S_DEV_LIVE;
 	ret = add_disk(disk);
 	if (ret) {
 		/*
diff --git a/drivers/block/ublk_drv.h b/drivers/block/ublk_drv.h
index 7242430fd6b9..f55e1c25531d 100644
--- a/drivers/block/ublk_drv.h
+++ b/drivers/block/ublk_drv.h
@@ -56,6 +56,7 @@ struct ublk_rq_data {
 };
 
 void ublk_set_nr_zones(struct ublk_device *ub);
+int ublk_dev_param_zoned_validate(const struct ublk_device *ub);
 void ublk_dev_param_zoned_apply(struct ublk_device *ub);
 int ublk_revalidate_disk_zones(struct gendisk *disk);
 
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 436525afffe8..4b6ad0b28598 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -351,7 +351,8 @@ struct ublk_param_devt {
 struct ublk_param_zoned {
 	__u32	max_open_zones;
 	__u32	max_active_zones;
-	__u8	reserved[24];
+	__u32   max_zone_append_sectors;
+	__u8	reserved[20];
 };
 
 struct ublk_params {
-- 
2.41.0

