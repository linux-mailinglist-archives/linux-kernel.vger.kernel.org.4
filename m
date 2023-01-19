Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C63674B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjATEyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjATExr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:53:47 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00EDCE8A9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674189915; x=1705725915;
  h=resent-from:resent-date:resent-message-id:resent-to:from:
   to:cc:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=s0MLNXyh3mQKki8IqbR9mf6okk8J+XoJLrOwzthuHvM=;
  b=lUo663bAsLS0zaDwsBNES9Ypkm41C2BdNTjZDgghInUHnNqp27SUHR94
   scKNOIS4DI7xy54sk4J2JAR8hAcIx7iaaDDkEtlqBXvsAikAM6DPWwj5S
   XkOOTak+R5SgZPNO51RB76FKED+TeCZOzbJLGv0KHvUGoUXuEcae3pWLT
   fQYQTV1CMZ+9Nnzt0ZyVxNLzeU88esezGHy+vjM9NB8NFoh/G4CkjLKOr
   7dsT4yjQAQscVUL1kjsHWN7MtuyjBoj9bvKt+ZY4keHAd6ioZuRSqgMlc
   lC0cq+yEJMT9BUCRTmows3P2miRfTrBLY4TiYwkWrJc943xc8v06FwMXf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="387738019"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="387738019"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 10:14:30 -0800
X-ExtLoopCount2: 2 from 10.237.72.184
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="662201218"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="662201218"
Received: from ubik.fi.intel.com (HELO ubik) ([10.237.72.184])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jan 2023 10:14:29 -0800
Received: from ash by ubik with local (Exim 4.96)
        (envelope-from <alexander.shishkin@intel.com>)
        id 1pIZQQ-00EPIR-1f
        for linux-kernel@vger.kernel.org;
        Thu, 19 Jan 2023 20:14:10 +0200
X-Original-To: alexander.shishkin@linux.intel.com
Received: from linux.intel.com [10.54.29.200]
        by ubik.fi.intel.com with IMAP (fetchmail-6.4.29)
        for <ash@localhost> (single-drop); Thu, 19 Jan 2023 15:59:04 +0200 (EET)
Received: from fmsmga005.fm.intel.com (fmsmga005.fm.intel.com [10.253.24.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 5C417580AE0;
        Thu, 19 Jan 2023 05:57:09 -0800 (PST)
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
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
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

