Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BB7674ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjATEgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjATEgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:36:02 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DD9BC8B2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674189238; x=1705725238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rYq6vhVbEN0C0wtg/aG1JBfgnzFIZAFF2Xt8UqDJh9o=;
  b=ak1dukcsXVxzzzj/T9FTs9vDePHlwIZ8xVA+GpPqUekQLimUrP/qinSM
   GUvPmSkIUHZ5TuYenTVb5Z8P9Qvm7FSjKm/o9nLfY7DqVFKlaZ0RZxJLs
   w6vs0SiMcFeynBT7xOOB/XjzFsrfIkyH8BYCszk/+q9YXu6HtBWy2+UV6
   XWqDUZU8EYabuHuWF4pYHmAMo79ZwhnnQ4A1WM34/2TINkapXJp9JE/Kf
   kF3uaY4ksEA/kntzUMoklgR6HmshZTAqusoidW8haNQWaN/hh8kdAezmx
   SKuTZc4VILdmaa6GrXw7vf0ZFYwUcYaBESQRZs1rGUG0eoOhlLpLSYLya
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="411526091"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="411526091"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 05:57:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="988993908"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="988993908"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jan 2023 05:57:03 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/6] virtio console: Harden multiport against invalid host input
Date:   Thu, 19 Jan 2023 15:57:16 +0200
Message-Id: <20230119135721.83345-2-alexander.shishkin@linux.intel.com>
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

It's possible for the host to set the multiport flag, but pass in
0 multiports, which results in:

BUG: KASAN: slab-out-of-bounds in init_vqs+0x244/0x6c0 drivers/char/virtio_console.c:1878
Write of size 8 at addr ffff888001cc24a0 by task swapper/1

CPU: 0 PID: 1 Comm: swapper Not tainted 5.15.0-rc1-140273-gaab0bb9fbaa1-dirty #588
Call Trace:
 init_vqs+0x244/0x6c0 drivers/char/virtio_console.c:1878
 virtcons_probe+0x1a3/0x5b0 drivers/char/virtio_console.c:2042
 virtio_dev_probe+0x2b9/0x500 drivers/virtio/virtio.c:263
 call_driver_probe drivers/base/dd.c:515
 really_probe+0x1c9/0x5b0 drivers/base/dd.c:601
 really_probe_debug drivers/base/dd.c:694
 __driver_probe_device+0x10d/0x1f0 drivers/base/dd.c:754
 driver_probe_device+0x68/0x150 drivers/base/dd.c:786
 __driver_attach+0xca/0x200 drivers/base/dd.c:1145
 bus_for_each_dev+0x108/0x190 drivers/base/bus.c:301
 driver_attach+0x30/0x40 drivers/base/dd.c:1162
 bus_add_driver+0x325/0x3c0 drivers/base/bus.c:618
 driver_register+0xf3/0x1d0 drivers/base/driver.c:171
...

Add a suitable sanity check.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Amit Shah <amit@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/virtio_console.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 6a821118d553..f4fd5fe7cd3a 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1843,6 +1843,9 @@ static int init_vqs(struct ports_device *portdev)
 	int err;
 
 	nr_ports = portdev->max_nr_ports;
+	if (use_multiport(portdev) && nr_ports < 1)
+		return -EINVAL;
+
 	nr_queues = use_multiport(portdev) ? (nr_ports + 1) * 2 : 2;
 
 	vqs = kmalloc_array(nr_queues, sizeof(struct virtqueue *), GFP_KERNEL);
-- 
2.39.0

