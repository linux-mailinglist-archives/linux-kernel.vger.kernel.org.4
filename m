Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513B75FDBCA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJMN7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiJMN6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:58:38 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B398FE09B5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 06:57:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso1494689wmq.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 06:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7OuLUBYXAOcE8pcq9/e9z3dyHvBPYPaNaSxybWb4IeQ=;
        b=iJPtJicN43I7vYtiBLEK061Z6o6nwoCYq95m9GtczXMd7MAZcAFqIwsQwmWIP2Om8h
         /k/wPtyoqztOS4XTz5bylrSJhmBEaWDkv9GRW2h0x2iiOpcbWozDnFkhJ2B6K1UbPIRP
         70yqwfG1Hl1LT6j76lVgmop9o+MO5IpUxW8CYGq07zLXfMhXxl5G2zCcqE3YKrZK/jJJ
         Ln0DSURFTkBeV/v9jX19Ol2tJzl9T9VMk90FXtr6aJOCY8UbtylOQVDkjosFGsBMd6Or
         WOVMfySpraUzGk3NDnmVVBA7Yvji7SGqmEpQUmyW+23u/9VwxuGMgLYvSUOvhHLwOpUe
         qa+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OuLUBYXAOcE8pcq9/e9z3dyHvBPYPaNaSxybWb4IeQ=;
        b=WtocWYUTBSwb22elo9E4InZHJm/Ez2ett9/vD5djnEU27M5rUHTJfWmwvk1Kmfwb/Z
         N8Q2nUG5ZHmUBB1OuZ49We+y+usfXfP9wdAHYOCTZwLN7vlctIgmv5aGuGmneEMqTRCD
         v/P6uurX2ClMI6mmAl6YPjHlCCsVUIMYf2bXBQKM2tAB0/V04dzgZyLvGAum1akVaa4+
         DyVYisJNKHXbsC5X/4wqMBZLb/UBXslvhxZinJUxRmo/dNdq6yLhawrfLV8ozxMd0Cs5
         T7oQnWlx2Z0YGqYGyD6zagY1BTz2FII3pb/hsRRyPetCHxkkFY1+m9XdoInRB9VOLDVE
         wnYw==
X-Gm-Message-State: ACrzQf2GEIAGkyEPOSi/vz1WGN0O+hdTUWofv3/piItMihh0T5jHRGDi
        UkX1MnXslxlgZtfWU/MdoMPWyQ==
X-Google-Smtp-Source: AMsMyM52nVzzf4JOMmR6/TA1aaThQ5YQ0URZybqKJb7Gldw54fnhQqj6kQv1Xev0LuxgOj2y5Zciww==
X-Received: by 2002:a05:600c:314a:b0:3c6:d75e:1abe with SMTP id h10-20020a05600c314a00b003c6d75e1abemr5342045wmo.71.1665669199953;
        Thu, 13 Oct 2022 06:53:19 -0700 (PDT)
Received: from localhost.localdomain (089144213149.atnat0022.highway.a1.net. [89.144.213.149])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c021400b003b4c979e6bcsm4473769wmi.10.2022.10.13.06.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 06:53:19 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <abxoe@kernel.dk>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH] drbd: only clone bio if we have a backing device
Date:   Thu, 13 Oct 2022 15:53:02 +0200
Message-Id: <20221013135302.933372-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
---
 drivers/block/drbd/drbd_req.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 8f7f144e54f3..5b9e025c2bc5 100644
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
@@ -1219,9 +1214,11 @@ drbd_request_prepare(struct drbd_device *device, struct bio *bio)
 	/* Update disk stats */
 	req->start_jif = bio_start_io_acct(req->master_bio);
 
-	if (!get_ldev(device)) {
-		bio_put(req->private_bio);
-		req->private_bio = NULL;
+	if (get_ldev(device)) {
+		req->private_bio = bio_alloc_clone(device->ldev->backing_bdev,
+						   bio, GFP_NOIO, &drbd_io_bio_set);
+		req->private_bio->bi_private = req;
+		req->private_bio->bi_end_io = drbd_request_endio;
 	}
 
 	/* process discards always from our submitter thread */
-- 
2.37.3

