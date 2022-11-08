Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7DB620AAE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 08:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbiKHHsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 02:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiKHHsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 02:48:52 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D9413D3D;
        Mon,  7 Nov 2022 23:48:50 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2DF4067373; Tue,  8 Nov 2022 08:48:47 +0100 (CET)
Date:   Tue, 8 Nov 2022 08:48:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Gerd Bayer <gbayer@linux.ibm.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: nvme-pci: NULL pointer dereference in nvme_dev_disable() on
 linux-next
Message-ID: <20221108074846.GA22674@lst.de>
References: <fad4d2d5e24eabe1a4fcab75c5d080a6229dc88b.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fad4d2d5e24eabe1a4fcab75c5d080a6229dc88b.camel@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the minimal fix.  I'll see if I sort out the mess that is
probe/reset failure vs ->remove a bit better, though.

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f94b05c585cbc..577bacdcfee08 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5160,6 +5160,8 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
+	if (!ctrl->tagset)
+		return;
 	if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
 		blk_mq_quiesce_tagset(ctrl->tagset);
 	else
@@ -5169,6 +5171,8 @@ EXPORT_SYMBOL_GPL(nvme_stop_queues);
 
 void nvme_start_queues(struct nvme_ctrl *ctrl)
 {
+	if (!ctrl->tagset)
+		return;
 	if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
 		blk_mq_unquiesce_tagset(ctrl->tagset);
 }
