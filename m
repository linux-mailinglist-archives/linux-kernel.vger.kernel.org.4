Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448A0648488
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiLIPDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiLIPCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:02:55 -0500
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DABB10B7A;
        Fri,  9 Dec 2022 07:02:49 -0800 (PST)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id 111374241C;
        Fri,  9 Dec 2022 09:24:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1670595887;
        bh=zeXfmgb9Pnkj8I5+f4SyAhdIG1+QaLfkaugwopvU0zc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=qGvVUkwbU0wJWiSXSFyA6w+vPT5Mwpf/1fv+jPgxvis/rnfyDBLKDPYoerfnwQT3t
         cdY1Z/6/lNmNGB4RP6Q3OkW8Mb4q4tZotYZA5bUfRNMIy13MA/ufXJ/jl35jMzHk/t
         8Khx/dG6/2PVQ/Q8Z/qUHwv8G6lGkYJJmmp2b0lYuQa5ET5I3rmBNVmEFDmS8eMoH7
         7hlxGsfD5xr8XEAjK4krGXWFacPmb5fK2RDU+afk2FmSWeV+76yzOy8n2Rbyc/Kfls
         wOzZDhFezH++Re/gBOCuMIKteHuNoUoeyuwVjuTW7YOwx8XcDuSdWfYo//lfhiR3u9
         NrMu1vu4GnyyQ==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 9 Dec 2022 15:23:53 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <corbet@lwn.net>
CC:     <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH v2 01/21] documentation, blkfilter: Block Device Filtering Mechanism
Date:   Fri, 9 Dec 2022 15:23:11 +0100
Message-ID: <20221209142331.26395-2-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221209142331.26395-1-sergei.shtepa@veeam.com>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031556627C62
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The document contains:
* Describes the purpose of the mechanism
* A little historical background on the capabilities of handling I/O
  units of the Linux kernel
* Brief description of the design
* Reference to interface description

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 Documentation/block/blkfilter.rst | 50 +++++++++++++++++++++++++++++++
 Documentation/block/index.rst     |  1 +
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/block/blkfilter.rst

diff --git a/Documentation/block/blkfilter.rst b/Documentation/block/blkfilter.rst
new file mode 100644
index 000000000000..3482e16c1964
--- /dev/null
+++ b/Documentation/block/blkfilter.rst
@@ -0,0 +1,50 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================================
+Block Device Filtering Mechanism
+================================
+
+The block device filtering mechanism is an API that allows to attach block
+device filters. Block device filters allow perform additional processing
+for I/O units.
+
+Introduction
+============
+
+The idea of handling I/O units on block devices is not new. Back in the
+2.6 kernel, there was an undocumented possibility of handling I/O units
+by substituting the make_request_fn() function, which belonged to the
+request_queue structure. But no kernel module used this feature, and it
+was eliminated in the 5.10 kernel.
+
+The block device filtering mechanism returns the ability to handle I/O units.
+It is possible to safely attach filter to a block device "on the fly" without
+changing the structure of block devices.
+
+It supports attaching one filter to one block device, because there is only
+one filter implementation in the kernel.
+See Documentation/block/blksnap.rst.
+
+Design
+======
+
+The block device filtering mechanism provides functions for attaching and
+detaching the filter. The filter is a structure with a reference counter
+and callback functions.
+
+The submit_bio_cb() callback function is called for each I/O unit for a block
+device, providing I/O unit filtering. Depending on the result of filtering
+the I/O unit, it can either be passed for subsequent processing by the block
+layer, or skipped.
+
+The reference counter allows to control the filter lifetime. When the reference
+count is reduced to zero, the release_cb() callback function is called to
+release the filter. This allows the filter to be released when the block
+device is disconnected.
+
+Interface description
+=====================
+.. kernel-doc:: include/linux/blkdev.h
+	:functions: bdev_filter_operations bdev_filter bdev_filter_init bdev_filter_get bdev_filter_put
+.. kernel-doc:: block/bdev.c
+	:functions: bdev_filter_attach bdev_filter_detach
diff --git a/Documentation/block/index.rst b/Documentation/block/index.rst
index c4c73db748a8..bef6de22d651 100644
--- a/Documentation/block/index.rst
+++ b/Documentation/block/index.rst
@@ -10,6 +10,7 @@ Block
    bfq-iosched
    biovecs
    blk-mq
+   blkfilter
    capability
    cmdline-partition
    data-integrity
-- 
2.20.1

