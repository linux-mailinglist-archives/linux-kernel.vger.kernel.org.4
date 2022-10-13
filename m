Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4165FDBFC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiJMOF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJMOFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:05:23 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E9E40E2D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 07:05:07 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id i17so1476492lja.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 07:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7OuLUBYXAOcE8pcq9/e9z3dyHvBPYPaNaSxybWb4IeQ=;
        b=z5vPZmNilmP1yjz6rliV0fXjnjfKafx+zYGelFWnyz7OXmhxjlK2moya1FjN+W1fdp
         cAvV4v8NvLGkiUcLkPLUz+ANQ8PxeUGItIgtAeA+LpepSOoE2Joi1Q+CV6QoyiatLeKM
         dEesH8tJPD0lDG6oA2D+II6e9O2zamTOWVimdfghrhw7I9xSFLdpcOwqqtYa5z2ogyAJ
         FlSYzFktdHugGNdw+jIa1MS3JSaVjH65dx4VnPew8VLF48g+CA8MxtTEcrwHlqwEN1lj
         PleWrPMTIqEIypdb0cEzWYqUKK6CBl/8XkiE8P0ENW7nU4qoyhrMn9Y+vuRATB+o2DC2
         C3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OuLUBYXAOcE8pcq9/e9z3dyHvBPYPaNaSxybWb4IeQ=;
        b=eDrg1DWMjHuunFVk6HD6UhvvT0rZDYMWJY8T1+6sqyrfT0UAVs34xFX2z9BzfBKA98
         040rQ+rM5NDNXxDJlw4W3SFN0t0amMcXhX+kJLSQp2ctGiNRPXBaP2MLDTdnjBTIHcy9
         3F2KfkQoG0adcJ561+ZPhrYBHfWCWHe5WSNLRuDYq0Bz7ROptt7JJZSYapVP4eU12VxD
         EBco6EPOUxNoe4q0PTT7aJkJ5gmQTIQImkJhZjTqG8Mturjf3/Bb7MjkPYMcpatW9pHW
         aT2bAEm7gZCtS3M/Afw8zwRoFfoKu8f7qNJF5VBuGdrXasdg/jMpQ50dpsnki6MiBts8
         o4mQ==
X-Gm-Message-State: ACrzQf23GPo+PGARvpPRlBQ8YU1/dUFsIxHO5u4Xp7HeZOyopmbegDwK
        95AE1Rf+rgjxg+Pblcz9nFS3NS9DGUhKPQaS
X-Google-Smtp-Source: AMsMyM5hfn1dZeeqQqGVcZG4ukNtnCmoJ5ApnsgQva1teAak+8QSCMhsooZni9Qx85RwueqDDL4gYg==
X-Received: by 2002:adf:e19e:0:b0:22e:64de:39fa with SMTP id az30-20020adfe19e000000b0022e64de39famr39211wrb.369.1665669236071;
        Thu, 13 Oct 2022 06:53:56 -0700 (PDT)
Received: from localhost.localdomain (089144213149.atnat0022.highway.a1.net. [89.144.213.149])
        by smtp.gmail.com with ESMTPSA id y8-20020a05600c364800b003c6bd91caa5sm4441295wmq.17.2022.10.13.06.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 06:53:55 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH] drbd: only clone bio if we have a backing device
Date:   Thu, 13 Oct 2022 15:53:52 +0200
Message-Id: <20221013135352.933875-1-christoph.boehmwalder@linbit.com>
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

