Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43BE605A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJTIxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiJTIwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:52:55 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505A7192B8C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:52:53 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bp11so33236629wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fxJKiEotGSWnJtU5023vvPUDcYNa2O9fl/RCysq+NZA=;
        b=CmP3VgGnictPB7LKKm5de97ljCHY369aWKMvv2xLSdFmS2DeCVFc6Z9czgE1Dk/U7/
         VyK1kIEbW0pmuuLffv8j6kySncqAJ8V9/FDA1rg8qQGVo3ke0WGrPRmcg2urSSs29hxk
         LBg3V8XSAVOzs2K7dp1kc8pTw4iPmcmRHqJdR1vWCDbpsTEG9crmhrOB3HYQYGUODobE
         jAVnxtjHyfPe2VgdaZn00vNh09lrjBVkifh2je1viTI9LGoZpAkogxDSA5IoWxLEoTj5
         YemzS5ly8MaTIiJIdGpBIk8eFHW+wOLh6jfbyP6OB20QNb0LgRCgvIR80Rm21DN6wlOX
         AF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxJKiEotGSWnJtU5023vvPUDcYNa2O9fl/RCysq+NZA=;
        b=Mbi3UDXgY5QLHIEVsNIJpemBXU5JimEbHQq1KsVogasScr2lEf4oSiZGajtEVz5kDY
         vrG6DvUHon9SPFnqcZOSb1WT55BHzWAE811Bz5qbXOvKCe+hiI62ebUMTeuFrFiZFXxx
         jAv0Y2MHPBI5rAYfVwS9Lyb1l0+BDsKVqi0jODScM9pR3qVvwv/gLyMMCJ16YSplup9J
         oQ1+CHY+BOL/tVh6CqVV5d1jodn/jgfPUSX85+0q1JSLzAUeZ3VcHfYX7xc3gEmQXDgT
         7RJ17fAoebEn4iklQnmbvuKPqNfYZ4x49Bdnz/SkQcobyzO5ECKYp+Cv+bionzXlOJlU
         Vf0A==
X-Gm-Message-State: ACrzQf1/XpxLagkS4XWO7yckT/mcNtS5rOb1Ek+hBQbVhIO8/6wEcym6
        3U1BMvXHtxTcLMBKcEpRbbkLThqQJLKHsV44
X-Google-Smtp-Source: AMsMyM5aImbG8bVRLMpXktjc/gAOVl/L1zQG4Vzf0bERE8RpGUb1vgAIW6AnFp5nhL1A0UyViy7sBQ==
X-Received: by 2002:a5d:4683:0:b0:22e:6be0:dfc6 with SMTP id u3-20020a5d4683000000b0022e6be0dfc6mr7915288wrq.573.1666255970764;
        Thu, 20 Oct 2022 01:52:50 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id f10-20020a05600c4e8a00b003a84375d0d1sm2409409wmq.44.2022.10.20.01.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 01:52:50 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] drbd: only clone bio if we have a backing device
Date:   Thu, 20 Oct 2022 10:52:05 +0200
Message-Id: <20221020085205.129090-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.37.3
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

Commit c347a787e34cb (drbd: set ->bi_bdev in drbd_req_new) moved a
bio_set_dev call (which has since been removed) to "earlier", from
drbd_request_prepare to drbd_req_new.

The problem is that this accesses device->ldev->backing_bdev, which is
not NULL-checked at this point. When we don't have an ldev (i.e. when
the DRBD device is diskless), this leads to a null pointer deref.

So, only allocate the private_bio if we actually have a disk. This is
also a small optimization, since we don't clone the bio to only to
immediately free it again in the diskless case.

Fixes: c347a787e34cb ("drbd: set ->bi_bdev in drbd_req_new")
Co-developed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Co-developed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Joel Colledge <joel.colledge@linbit.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
Changes in v2:
    - Fix an overly long line
---
 drivers/block/drbd/drbd_req.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 8f7f144e54f3..7f9bcc82fc9c 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -30,11 +30,6 @@ static struct drbd_request *drbd_req_new(struct drbd_device *device, struct bio
 		return NULL;
 	memset(req, 0, sizeof(*req));
 
-	req->private_bio = bio_alloc_clone(device->ldev->backing_bdev, bio_src,
-					   GFP_NOIO, &drbd_io_bio_set);
-	req->private_bio->bi_private = req;
-	req->private_bio->bi_end_io = drbd_request_endio;
-
 	req->rq_state = (bio_data_dir(bio_src) == WRITE ? RQ_WRITE : 0)
 		      | (bio_op(bio_src) == REQ_OP_WRITE_ZEROES ? RQ_ZEROES : 0)
 		      | (bio_op(bio_src) == REQ_OP_DISCARD ? RQ_UNMAP : 0);
@@ -1219,9 +1214,12 @@ drbd_request_prepare(struct drbd_device *device, struct bio *bio)
 	/* Update disk stats */
 	req->start_jif = bio_start_io_acct(req->master_bio);
 
-	if (!get_ldev(device)) {
-		bio_put(req->private_bio);
-		req->private_bio = NULL;
+	if (get_ldev(device)) {
+		req->private_bio = bio_alloc_clone(device->ldev->backing_bdev,
+						   bio, GFP_NOIO,
+						   &drbd_io_bio_set);
+		req->private_bio->bi_private = req;
+		req->private_bio->bi_end_io = drbd_request_endio;
 	}
 
 	/* process discards always from our submitter thread */
-- 
2.37.3

