Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7846F57D3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 14:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjECMUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 08:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjECMUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 08:20:33 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D3D5B82
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 05:20:26 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f19b9d5358so51039955e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 05:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20221208.gappssmtp.com; s=20221208; t=1683116424; x=1685708424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HbIHW3WFJjCSlSmcogKsdyCdUd7ycb8fmjWMREeXjCw=;
        b=zm+0MHgI8YyjZvCVYCL/QFDiqrw357GfINXK71fw/0AwoNi4xZmbOshugboG9853+R
         LMpLqMeF77seN4g464PWWTnF+Pe21tgYZATz/nt/9KKkzpyl2rlZmipc6OgV9ASGhvDJ
         9UIJksnpNv3xYoqBz7bRAX7b2nRZksmJJLNtcrJhDiYCAhkPHPizhl357QAQZHzj/Roh
         /MPx0MMrofRRHdaSC4SdgM/8KduspCsmE6ssnfei5qeida9JCHvt/V0zPwnpilvmDRFG
         yuK3ySJ9GX6+nL4tTbFSYkLcIeC9prqfDrkX43lQ/LVvxusEpEKRbEbGAZunCYsGJQzt
         2eZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683116424; x=1685708424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbIHW3WFJjCSlSmcogKsdyCdUd7ycb8fmjWMREeXjCw=;
        b=I0IuBjuScn5p0wiFGR7SjJxJHiHwSxg5snePLKKROmfg0pz2+mSWbJPkUd/h5qWCsh
         bcw4zJLJU/V1murf0LsO8xC12XVvsKFU3rYHu2LM4yPBcMsfCKguvFVVyvM4SPdwiM3O
         ZW3SuIM6/a/NMhPmPUIronIioMlJyLdEOi7eL2OvP830JJ4RWmJRFsiLN17fL/HhOYeK
         Txqj9lPUbp0abSM2AAqhm2MTVzIGTk+pcZnpcbKuG67e8E+Ilm8vTrW4OTw9JA20nwKr
         cCUkjyiaC5uoy2FU7bvf1h8ZPlNMKL4afLE6Qjx+DKFiNbJ0jgxisLFdfjjSIRkQpAWo
         YjfQ==
X-Gm-Message-State: AC+VfDwty9gSjVxpZIwjE2PNom8tJhgivRldoU+lNsC1iXM4x3V99Dec
        B+UE3rLdQzw7GBszS56YCzfXkA==
X-Google-Smtp-Source: ACHHUZ4vVAbqI84nqD7SfKcPc/YM/bQUCMMrNM47k+DsevZb0DiO+zbCK2U2kzTlyFRPoxZOz/BdbA==
X-Received: by 2002:a7b:c047:0:b0:3f1:979f:a734 with SMTP id u7-20020a7bc047000000b003f1979fa734mr14560520wmc.11.1683116424668;
        Wed, 03 May 2023 05:20:24 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id q7-20020a1ce907000000b003f180d5b145sm1748027wmc.40.2023.05.03.05.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 05:20:24 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Christoph Hellwig <hch@infradead.org>, stable@vger.kernel.org,
        Thomas Voegtle <tv@lio96.de>
Subject: [PATCH] drbd: correctly submit flush bio on barrier
Date:   Wed,  3 May 2023 14:19:37 +0200
Message-Id: <20230503121937.17232-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we receive a flush command (or "barrier" in DRBD), we currently use
a REQ_OP_FLUSH with the REQ_PREFLUSH flag set.

The correct way to submit a flush bio is by using a REQ_OP_WRITE without
any data, and set the REQ_PREFLUSH flag.

Since commit b4a6bb3a67aa ("block: add a sanity check for non-write
flush/fua bios"), this triggers a warning in the block layer, but this
has been broken for quite some time before that.

So use the correct set of flags to actually make the flush happen.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: stable@vger.kernel.org
Fixes: f9ff0da56437 ("drbd: allow parallel flushes for multi-volume resources")
Reported-by: Thomas Voegtle <tv@lio96.de>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
Previous, incorrect version of this patch:
https://lore.kernel.org/all/20230502092922.175857-1-christoph.boehmwalder@linbit.com/

 drivers/block/drbd/drbd_receiver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index e54404c632e7..34b112752ab1 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1283,7 +1283,7 @@ static void one_flush_endio(struct bio *bio)
 static void submit_one_flush(struct drbd_device *device, struct issue_flush_context *ctx)
 {
 	struct bio *bio = bio_alloc(device->ldev->backing_bdev, 0,
-				    REQ_OP_FLUSH | REQ_PREFLUSH, GFP_NOIO);
+				    REQ_OP_WRITE | REQ_PREFLUSH, GFP_NOIO);
 	struct one_flush_context *octx = kmalloc(sizeof(*octx), GFP_NOIO);
 
 	if (!octx) {
-- 
2.39.2

