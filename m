Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE47674AD1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjATEgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjATEgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:36:03 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49D7BCE02
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674189241; x=1705725241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vkH/geR8Ac3bg/SlAe70kTG4lkCo5fDV5PnPvmhuzPY=;
  b=HvLQullaSPXwiO1mrkot1EBX5aqFeZLkBT+1VhzzjqnL8pJ6pE89+tPY
   mcnOipP5GafzlL4o3Vhm2gKpzCy4hCHSe9yrsKL+Srvkrqg5R6Y92vQJl
   Ah1xDrdQCJigzGQiAMM3yDvfrTwIbCO5n6Rg8g55LAa3e53nvgaO1dIzE
   7J3e47MkyEGKBA67QzenUuze0F3lJZs+4gLp6lbUBYCtsO3dgycLxGI0q
   8Bzt1UlR78qtnSlX3LVOMkvebxMi7d8RdY1dplG4gd0z1w3GsCRXNTP0A
   SbwtU5eOpdY10ndbITyOu8Is3JvKGPYFquzRfkHvY18vGsK3UUvqpYe2h
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="411526144"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="411526144"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 05:57:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="988993960"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="988993960"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jan 2023 05:57:12 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 4/6] virtio console: Harden control message handling
Date:   Thu, 19 Jan 2023 15:57:19 +0200
Message-Id: <20230119135721.83345-5-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In handle_control_message(), we look at the ->event field twice, which
gives a malicious VMM a window in which to switch it from PORT_ADD to
PORT_REMOVE, triggering a null dereference further down the line:

RIP: 0010:spin_lock_irq ./include/linux/spinlock.h:388
RIP: 0010:unplug_port+0x9/0x150 drivers/char/virtio_console.c:1512
Call Trace:
 handle_control_message+0x108/0x2c0 drivers/char/virtio_console.c:1600
 elfcorehdr_read+0x40/0x40 ??:?
 process_one_work+0x1b4/0x310 kernel/workqueue.c:2297
 worker_thread+0x5c/0x3a0 kernel/workqueue.c:2444
 kthread+0x120/0x140 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Read the event code once instead, basing all following decisions on the
same value.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Amit Shah <amit@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/virtio_console.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 6599c2956ba4..62f69f949cb7 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1563,22 +1563,22 @@ static void handle_control_message(struct virtio_device *vdev,
 	struct port *port;
 	size_t name_size;
 	int err;
-	unsigned id;
+	unsigned id, event;
 
 	cpkt = (struct virtio_console_control *)(buf->buf + buf->offset);
 
-	/* Make sure the host cannot change id under us */
+	/* Make sure the host cannot change id or event under us */
 	id = virtio32_to_cpu(vdev, READ_ONCE(cpkt->id));
+	event = virtio16_to_cpu(vdev, cpkt->event);
 	port = find_port_by_id(portdev, id);
-	if (!port &&
-	    cpkt->event != cpu_to_virtio16(vdev, VIRTIO_CONSOLE_PORT_ADD)) {
+	if (!port && event != VIRTIO_CONSOLE_PORT_ADD) {
 		/* No valid header at start of buffer.  Drop it. */
 		dev_dbg(&portdev->vdev->dev,
 			"Invalid index %u in control packet\n", cpkt->id);
 		return;
 	}
 
-	switch (virtio16_to_cpu(vdev, cpkt->event)) {
+	switch (event) {
 	case VIRTIO_CONSOLE_PORT_ADD:
 		if (port) {
 			dev_dbg(&portdev->vdev->dev,
-- 
2.39.0

