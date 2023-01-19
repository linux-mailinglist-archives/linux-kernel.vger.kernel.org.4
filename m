Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A36E674359
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 21:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjASUN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 15:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjASUNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:13:24 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5329519D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674159203; x=1705695203;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=+3Q0D0Jugsvb2TexainnB5PwnLYuzF2qzDGI8ulotJU=;
  b=KrIEvrAF+/WtPvwaKsM5ZLaoYQr/VwuYTCgohuT1UwhnGQ8/jUP09RTC
   UrXJFcyzMb3IvtDKQJbUtL6cQ+M1PC7riyh/0jfbCFmGsazt98xZD18+L
   bNeHSNuehXOEcJSZtO84gebKgkbOac4GBz7O5etHiXq1Erh1/gb2RVxTD
   oaephQfWgHt2ctdJ6ERKnwVYqTCgYZ6d8PBaTpsoWut8uZliMKcnkdpOt
   69GSwwZaIodbZXyMHZMFxy3+tZ8d96hhAnWmxuBJTnz0Pd0WT/HNI3kmi
   PSK0VWcLJUsNZIqD+pUhhOococj7wR1VnRQ28Z0xZnG3j8EaF6B9Dn4A9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="327502034"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="327502034"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 12:13:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="637845790"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="637845790"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by orsmga006.jf.intel.com with ESMTP; 19 Jan 2023 12:13:19 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v1 2/6] virtio console: Harden port adding
In-Reply-To: <Y8mSs68JfW6t4mjl@kroah.com>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-3-alexander.shishkin@linux.intel.com>
 <Y8lfz8C5uvx2w4fC@kroah.com> <87ilh2quto.fsf@ubik.fi.intel.com>
 <Y8mSs68JfW6t4mjl@kroah.com>
Date:   Thu, 19 Jan 2023 22:13:18 +0200
Message-ID: <87a62eqo4h.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> Then you need to copy it out once, and then only deal with the local
> copy.  Otherwise you have an incomplete snapshot.

Ok, would you be partial to something like this:

From 1bc9bb84004154376c2a0cf643d53257da6d1cd7 Mon Sep 17 00:00:00 2001
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Date: Thu, 19 Jan 2023 21:59:02 +0200
Subject: [PATCH] virtio console: Keep a local copy of the control structure

When handling control messages, instead of peeking at the device memory
to obtain bits of the control structure, take a snapshot of it once and
use it instead, to prevent it from changing under us. This avoids races
between port id validation and control event decoding, which can lead
to, for example, a NULL dereference in port removal of a nonexistent
port.

The control structure is small enough (8 bytes) that it can be cached
directly on the stack.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Amit Shah <amit@kernel.org>
---
 drivers/char/virtio_console.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 6a821118d553..42be0991a72f 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1559,23 +1559,24 @@ static void handle_control_message(struct virtio_device *vdev,
 				   struct ports_device *portdev,
 				   struct port_buffer *buf)
 {
-	struct virtio_console_control *cpkt;
+	struct virtio_console_control cpkt;
 	struct port *port;
 	size_t name_size;
 	int err;
 
-	cpkt = (struct virtio_console_control *)(buf->buf + buf->offset);
+	/* Keep a local copy of the control structure */
+	memcpy(&cpkt, buf->buf + buf->offset, sizeof(cpkt));
 
-	port = find_port_by_id(portdev, virtio32_to_cpu(vdev, cpkt->id));
+	port = find_port_by_id(portdev, virtio32_to_cpu(vdev, cpkt.id));
 	if (!port &&
-	    cpkt->event != cpu_to_virtio16(vdev, VIRTIO_CONSOLE_PORT_ADD)) {
+	    cpkt.event != cpu_to_virtio16(vdev, VIRTIO_CONSOLE_PORT_ADD)) {
 		/* No valid header at start of buffer.  Drop it. */
 		dev_dbg(&portdev->vdev->dev,
-			"Invalid index %u in control packet\n", cpkt->id);
+			"Invalid index %u in control packet\n", cpkt.id);
 		return;
 	}
 
-	switch (virtio16_to_cpu(vdev, cpkt->event)) {
+	switch (virtio16_to_cpu(vdev, cpkt.event)) {
 	case VIRTIO_CONSOLE_PORT_ADD:
 		if (port) {
 			dev_dbg(&portdev->vdev->dev,
@@ -1583,21 +1584,21 @@ static void handle_control_message(struct virtio_device *vdev,
 			send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
 			break;
 		}
-		if (virtio32_to_cpu(vdev, cpkt->id) >=
+		if (virtio32_to_cpu(vdev, cpkt.id) >=
 		    portdev->max_nr_ports) {
 			dev_warn(&portdev->vdev->dev,
 				"Request for adding port with "
 				"out-of-bound id %u, max. supported id: %u\n",
-				cpkt->id, portdev->max_nr_ports - 1);
+				cpkt.id, portdev->max_nr_ports - 1);
 			break;
 		}
-		add_port(portdev, virtio32_to_cpu(vdev, cpkt->id));
+		add_port(portdev, virtio32_to_cpu(vdev, cpkt.id));
 		break;
 	case VIRTIO_CONSOLE_PORT_REMOVE:
 		unplug_port(port);
 		break;
 	case VIRTIO_CONSOLE_CONSOLE_PORT:
-		if (!cpkt->value)
+		if (!cpkt.value)
 			break;
 		if (is_console_port(port))
 			break;
@@ -1618,7 +1619,7 @@ static void handle_control_message(struct virtio_device *vdev,
 		if (!is_console_port(port))
 			break;
 
-		memcpy(&size, buf->buf + buf->offset + sizeof(*cpkt),
+		memcpy(&size, buf->buf + buf->offset + sizeof(cpkt),
 		       sizeof(size));
 		set_console_size(port, size.rows, size.cols);
 
@@ -1627,7 +1628,7 @@ static void handle_control_message(struct virtio_device *vdev,
 		break;
 	}
 	case VIRTIO_CONSOLE_PORT_OPEN:
-		port->host_connected = virtio16_to_cpu(vdev, cpkt->value);
+		port->host_connected = virtio16_to_cpu(vdev, cpkt.value);
 		wake_up_interruptible(&port->waitqueue);
 		/*
 		 * If the host port got closed and the host had any
@@ -1658,7 +1659,7 @@ static void handle_control_message(struct virtio_device *vdev,
 		 * Skip the size of the header and the cpkt to get the size
 		 * of the name that was sent
 		 */
-		name_size = buf->len - buf->offset - sizeof(*cpkt) + 1;
+		name_size = buf->len - buf->offset - sizeof(cpkt) + 1;
 
 		port->name = kmalloc(name_size, GFP_KERNEL);
 		if (!port->name) {
@@ -1666,7 +1667,7 @@ static void handle_control_message(struct virtio_device *vdev,
 				"Not enough space to store port name\n");
 			break;
 		}
-		strncpy(port->name, buf->buf + buf->offset + sizeof(*cpkt),
+		strncpy(port->name, buf->buf + buf->offset + sizeof(cpkt),
 			name_size - 1);
 		port->name[name_size - 1] = 0;
 
-- 
2.39.0

