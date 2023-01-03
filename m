Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF45965C630
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbjACS0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238839AbjACS0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:26:21 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E200B6A;
        Tue,  3 Jan 2023 10:26:02 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m3so14619274wmq.0;
        Tue, 03 Jan 2023 10:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aRzoYepSkl//ziJ1ySsV1tuFv4CAwJQc87Spdth6SZs=;
        b=LHPtwEsDLxDopS5vPBG5/7yCKyJME02A52f9mbnYvB8qXsIJphtU/CxV+bwqsbv8Je
         Sq3Rhtiuc4X04lI3z+oTM2s7p+/qQum2zqveO2PDy2nRm4OUJb69g3F48Vg12ozrAB4V
         BBsXYg4gVe9Ftv9ElQMid3simNahAm5JQy7yGkWEoa6Kp+z4JQzu6yyv15hWAvHQMi8q
         X11sW1qYuIlek8rkcfcNxcbfQvtaae4oB8u/s8c7wmSsPJ3QeFx9CvgTsx0/ohx6z+Jn
         2yOKzAUnS8PdeGeGe2bMIGvYyMb8Kr7HMGTXD/43WMosZGVXu0hvoj1jfEN7P45de8AQ
         InZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRzoYepSkl//ziJ1ySsV1tuFv4CAwJQc87Spdth6SZs=;
        b=6Qr/RCmrEsH8lJkLQ4k7/kSssguF4WRRgf+o07ealDut7vLNu8V/uBiXtY66xqn/7s
         yHdl5jM7PqVnstnGXPCADfFzFZqB3C3rbUr6z8m1d1PUxoSEUFGCiwDcWFTT805Gltpw
         SxZMQIQgTE3+9CnyMxlOzelCoZLFovh53hzuZgYOrS2kEyCuR/q3tAOCMT4H7/o4OgKA
         gA6W5GwNbw6fMQy93aI+aUubAQAnVPubRIzoWhXIzDROwlUaEy7mSHnyZCNvqYPPmJSi
         Phypm/D6o1RWTfZW1rEsrsGBl3rzYq/lcPuVXt/kSSoRxnnW1vgCU6PdcJAmXZcoV0Mf
         BqpA==
X-Gm-Message-State: AFqh2kqtUTwWAToWsezEU1Jy0rY8kXRW3YKVDDFD59lP1qWMdor7eCkB
        R/s597ipgadDTmBepHDZlvTpN7xNRmY=
X-Google-Smtp-Source: AMrXdXvTgaLqJaIX0z7u6gR4WtDhUDjJxeU6g8nd6mOzh+aOlhG38dQ+rO49Ieue3d9OtXykXgBP/g==
X-Received: by 2002:a05:600c:601e:b0:3d0:7fee:8a70 with SMTP id az30-20020a05600c601e00b003d07fee8a70mr34287826wmb.19.1672770360793;
        Tue, 03 Jan 2023 10:26:00 -0800 (PST)
Received: from localhost.localdomain (host-79-56-217-20.retail.telecomitalia.it. [79.56.217.20])
        by smtp.gmail.com with ESMTPSA id m22-20020a05600c161600b003cfa622a18asm45156598wmn.3.2023.01.03.10.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 10:26:00 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Brian King <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] scsi: ipr: Replace kmap() with kmap_local_page()
Date:   Tue,  3 Jan 2023 19:25:56 +0100
Message-Id: <20230103182556.29080-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of kmap() is deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

Therefore, replace kmap() with kmap_local_page() in
ipr_copy_ucode_buffer() and, instead of open-coding local mappings +
memcpy() + local un-mappings, use the better suited memcpy_to_page()
helper.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/scsi/ipr.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 2022ffb45041..7dff517a0858 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -3912,7 +3912,6 @@ static int ipr_copy_ucode_buffer(struct ipr_sglist *sglist,
 {
 	int bsize_elem, i, result = 0;
 	struct scatterlist *sg;
-	void *kaddr;
 
 	/* Determine the actual number of bytes per element */
 	bsize_elem = PAGE_SIZE * (1 << sglist->order);
@@ -3923,9 +3922,7 @@ static int ipr_copy_ucode_buffer(struct ipr_sglist *sglist,
 			buffer += bsize_elem) {
 		struct page *page = sg_page(sg);
 
-		kaddr = kmap(page);
-		memcpy(kaddr, buffer, bsize_elem);
-		kunmap(page);
+		memcpy_to_page(page, 0, buffer, bsize_elem);
 
 		sg->length = bsize_elem;
 
@@ -3938,9 +3935,7 @@ static int ipr_copy_ucode_buffer(struct ipr_sglist *sglist,
 	if (len % bsize_elem) {
 		struct page *page = sg_page(sg);
 
-		kaddr = kmap(page);
-		memcpy(kaddr, buffer, len % bsize_elem);
-		kunmap(page);
+		memcpy_to_page(page, 0, buffer, len % bsize_elem);
 
 		sg->length = len % bsize_elem;
 	}
-- 
2.39.0

