Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C4A7450C0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjGBTlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjGBTlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:41:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3461996;
        Sun,  2 Jul 2023 12:40:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D78B60C99;
        Sun,  2 Jul 2023 19:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E532C433C9;
        Sun,  2 Jul 2023 19:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326842;
        bh=RhaCunHARopufR5I3XXRldbzyzzXk7ELThH/jc++d8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qgsn5qUr+btrSVkFtfKWt+krMVmWFAwekHMTR57VPRZrkynEvcT44cy4+aPi7YhrX
         WfyDUD6mXlVxD9NpPbgYAPDzxU4Dd+RU/UaOw5fhg42SLWHj+SQ0OXCL8mHWi3GPgC
         Pji4a7NvJ5lsD6BCo3clsL19GUdMXM/5qJcPWQQpDgWZ9uFPF6ZT2fBaA+2HtfVc8h
         dFR78DSN/WoA0xvNk2FiwI13H7lXV/LGeXqINtQDii03hW0GDcnIDgk65paVd3Oqo6
         xSnA1Pi49EbZCKedzBlfEyxB23aYquFQSfWFtxQUhg7WJDa5mJmuH9Mgt6l2X1LdpE
         n1BpZ32WMKHEA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yu Kuai <yukuai3@huawei.com>, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        dgilbert@interlog.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 09/15] scsi: sg: fix blktrace debugfs entries leakage
Date:   Sun,  2 Jul 2023 15:40:14 -0400
Message-Id: <20230702194020.1776895-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702194020.1776895-1-sashal@kernel.org>
References: <20230702194020.1776895-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit db59133e927916d8a25ee1fd8264f2808040909d ]

sg_ioctl() support to enable blktrace, which will create debugfs entries
"/sys/kernel/debug/block/sgx/", however, there is no guarantee that user
will remove these entries through ioctl, and deleting sg device doesn't
cleanup these blktrace entries.

This problem can be fixed by cleanup blktrace while releasing
request_queue, however, it's not a good idea to do this special handling
in common layer just for sg device.

Fix this problem by shutdown bltkrace in sg_device_destroy(), where the
device is deleted and all the users close the device, also grab a
scsi_device reference from sg_add_device() to prevent scsi_device to be
freed before sg_device_destroy();

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Link: https://lore.kernel.org/r/20230610022003.2557284-3-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/sg.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 037f8c98a6d36..0adfbd77437f3 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1496,6 +1496,10 @@ sg_add_device(struct device *cl_dev)
 	int error;
 	unsigned long iflags;
 
+	error = scsi_device_get(scsidp);
+	if (error)
+		return error;
+
 	error = -ENOMEM;
 	cdev = cdev_alloc();
 	if (!cdev) {
@@ -1553,6 +1557,7 @@ sg_add_device(struct device *cl_dev)
 out:
 	if (cdev)
 		cdev_del(cdev);
+	scsi_device_put(scsidp);
 	return error;
 }
 
@@ -1560,6 +1565,7 @@ static void
 sg_device_destroy(struct kref *kref)
 {
 	struct sg_device *sdp = container_of(kref, struct sg_device, d_ref);
+	struct request_queue *q = sdp->device->request_queue;
 	unsigned long flags;
 
 	/* CAUTION!  Note that the device can still be found via idr_find()
@@ -1567,6 +1573,9 @@ sg_device_destroy(struct kref *kref)
 	 * any other cleanup.
 	 */
 
+	blk_trace_remove(q);
+	scsi_device_put(sdp->device);
+
 	write_lock_irqsave(&sg_index_lock, flags);
 	idr_remove(&sg_index_idr, sdp->index);
 	write_unlock_irqrestore(&sg_index_lock, flags);
-- 
2.39.2

