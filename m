Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC89674AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjATEgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjATEgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:36:03 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E54C13E1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674189238; x=1705725238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s0MLNXyh3mQKki8IqbR9mf6okk8J+XoJLrOwzthuHvM=;
  b=a/IFoQ0DKbYNsYnpzHz8EzqWL3CwX22sWNu89nIbaDyoiBCUJhU9uQbq
   tunBQNifxpRXmAUqxKo65dkYJzI6NVFo/I3A6bbOKzTk5Q7nD5J64o4PE
   DnIXJT16B5KkEfs4KlSCXhEc2wqvwuKQBT3kBR6G5qn6OMueQUbtToEi4
   M47c5UHViIbpIoUZ4/BKDf0+rhb1DT0KWdq5W2+L3gX1zODwd+70Czo7Y
   6FhJ6tOmDxUVJXfWs9rNn+ipdQbD4+sGSKSFWPNBdneBamtw0eVhS4Ott
   j8v3DCvyWCc5dAJEmlCVLAAPExfjOPob2rzMAjmyZWPSMJU6V6ISN96Qi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="411526113"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="411526113"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 05:57:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="988993915"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="988993915"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jan 2023 05:57:06 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 2/6] virtio console: Harden port adding
Date:   Thu, 19 Jan 2023 15:57:17 +0200
Message-Id: <20230119135721.83345-3-alexander.shishkin@linux.intel.com>
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

From: Andi Kleen <ak@linux.intel.com>

The ADD_PORT operation reads and sanity checks the port id multiple
times from the untrusted host. This is not safe because a malicious
host could change it between reads.

Read the port id only once and cache it for subsequent uses.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Amit Shah <amit@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/virtio_console.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index f4fd5fe7cd3a..6599c2956ba4 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1563,10 +1563,13 @@ static void handle_control_message(struct virtio_device *vdev,
 	struct port *port;
 	size_t name_size;
 	int err;
+	unsigned id;
 
 	cpkt = (struct virtio_console_control *)(buf->buf + buf->offset);
 
-	port = find_port_by_id(portdev, virtio32_to_cpu(vdev, cpkt->id));
+	/* Make sure the host cannot change id under us */
+	id = virtio32_to_cpu(vdev, READ_ONCE(cpkt->id));
+	port = find_port_by_id(portdev, id);
 	if (!port &&
 	    cpkt->event != cpu_to_virtio16(vdev, VIRTIO_CONSOLE_PORT_ADD)) {
 		/* No valid header at start of buffer.  Drop it. */
@@ -1583,15 +1586,14 @@ static void handle_control_message(struct virtio_device *vdev,
 			send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
 			break;
 		}
-		if (virtio32_to_cpu(vdev, cpkt->id) >=
-		    portdev->max_nr_ports) {
+		if (id >= portdev->max_nr_ports) {
 			dev_warn(&portdev->vdev->dev,
 				"Request for adding port with "
 				"out-of-bound id %u, max. supported id: %u\n",
 				cpkt->id, portdev->max_nr_ports - 1);
 			break;
 		}
-		add_port(portdev, virtio32_to_cpu(vdev, cpkt->id));
+		add_port(portdev, id);
 		break;
 	case VIRTIO_CONSOLE_PORT_REMOVE:
 		unplug_port(port);
-- 
2.39.0

