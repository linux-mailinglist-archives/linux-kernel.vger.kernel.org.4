Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4D96168F7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiKBQbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiKBQa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:30:29 -0400
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C97E2DA9D;
        Wed,  2 Nov 2022 09:27:07 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id AA6D141CDE;
        Wed,  2 Nov 2022 11:51:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1667404310;
        bh=OHKw2Y24NEK51ghFh6NlAXRAmdKb1WQljbkubdtdUAA=;
        h=From:To:Subject:Date:From;
        b=eqiBjpgiBrZFhvUBURD1MAlU15e1oZPGzWqHlAQMg16SLE3sKWUBNxBVDKQzsFavh
         f+PGtvAPFPmr0VqrVUjMu+7sA6ihnHBYbP1Ht7L5vDY2k/scOfiSna0w1sjqfG7v0e
         P2PbmhNS1r+hQ/1KpkV7xOLDYL2aHVwDSlIb56Xwh3oBgcwtq2i4VArzST/5P302Ey
         rN7dhdgbc3xew4F0LxrqcFkzNbyjCqBDl1qJFlQ23r24B4rcOXpdVnB7gB77nDvvZ4
         0MZFwdXMAuBrLQuAQ4VuHMl4CpKSglLFsxifr9ad3Jz9lVsQf/5u/954tWZtv3/Ghd
         q5ZnGZPKRGEyA==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 2 Nov 2022 16:51:13 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hch@infradead.org>,
        <sergei.shtepa@veeam.com>
Subject: [PATCH v1 00/17] blksnap - creating non-persistent snapshots for backup
Date:   Wed, 2 Nov 2022 16:50:44 +0100
Message-ID: <20221102155101.4550-1-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A292403155666726A
X-Veeam-MMEX: True
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I suggest a modified version of the blksnap kernel module for consideration.
It allows to create non-persistent snapshots of any block devices. The main
purpose of such snapshots is to create a backup of block devices.

A snapshot is created simultaneously for several block devices, ensuring
their mutual consistency in the backup.

A change tracker is implemented in the module. It allows to determine
which blocks were changed during the time between the last snapshot
created and any of the previous snapshots of the same generation.
This allows to implement incremental and differential backups.

An arbitrary range of sectors on any block device can be used to store
snapshot changes. The size of the storage for changes can be increased after the
snapshot is created by adding new sector ranges. This allows to create a
storage of differences in individual files on a file system that can occupy
the entire space of a block device and increase the storage of differences
as needed.

To create images of snapshots of block devices, the module stores blocks
of the original block device that have been changed since the snapshot was
taken. To do this, the module intercepts write requests and reads blocks
that need to be overwritten. This algorithm guarantees the safety of the
data of the original block device in case of overflow of the snapshot and
even in case of unpredictable critical errors.

To connect and disconnect the module to the block layer, the concept of a
block device filter is introduced. Functions for connecting filters are
added to the block layer and the ability to intercept I/O requests is
provided.

The blksnap module was created specifically for upstream based on the
experience of operating the out-of-tree veeamsnap module, which is part of
the Veeam Agent for Linux product. I am sure that the module will be in
demand by other creators of backup tools and will save them from having to
use their out-of-tree kernel modules.

A tool, a library for working with blksnap, tests and some documentations
can be found at www.github.com/veeam/blksnap.

The first version was suggested at 13.06.2022. Many thanks to Christoph Hellwig
and Randy Dunlap for the review of that version. In this version, I tried to
eliminate all the defects.

Changes:
- Forgotten "static" declarations have been added.
- The text of the comments has been corrected.
- It is possible to connect only one filter, since there are no others in
  upstream.
- Do not have additional locks for attach/detach filter.
- blksnap.h moved to include/uapi/.
- #pragma once and commented code removed.
- uuid_t removed from user API.
- Removed default values for module parameters from the configuration file.
- The debugging code for tracking memory leaks has been removed.
- Simplified Makefile.
- Optimized work with large memory buffers, CBT tables are now in virtual
  memory.
- The allocation code of minor numbers has been optimized.
- The implementation of the snapshot image block device has been simplified,
  now it is a bio-based block device.
- Removed initialization of global variables with null values.
- Only one bio is used to copy one chunk.
- Checked on ppc64le.

Sergei Shtepa (17):
  block, bdev_filter: enable block device filters
  block, blksnap: header file of the module interface
  block, blksnap: module management interface functions
  block, blksnap: init() and exit() functions
  block, blksnap: interaction with sysfs
  block, blksnap: attaching and detaching the filter and handling a bios
  block, blksnap: map of change block tracking
  block, blksnap: minimum data storage unit of the original block device
  lock, blksnap: buffer in memory for the minimum data storage unit
  block, blksnap: functions and structures for performing block I/O
    operations
  block, blksnap: storage for storing difference blocks
  lock, blksnap: event queue from the difference storage
  block, blksnap: owner of information about overwritten blocks of the
    original block device
  block, blksnap: snapshot image block device
  block, blksnap: snapshot
  block, blksnap: Kconfig and Makefile
  block, blksnap: adds a blksnap to the kernel tree

 block/bdev.c                         |  73 +++
 block/blk-core.c                     |  19 +-
 drivers/block/Kconfig                |   2 +
 drivers/block/Makefile               |   2 +
 drivers/block/blksnap/Kconfig        |  12 +
 drivers/block/blksnap/Makefile       |  18 +
 drivers/block/blksnap/cbt_map.c      | 268 +++++++++++
 drivers/block/blksnap/cbt_map.h      | 114 +++++
 drivers/block/blksnap/chunk.c        | 349 ++++++++++++++
 drivers/block/blksnap/chunk.h        | 139 ++++++
 drivers/block/blksnap/ctrl.c         | 408 ++++++++++++++++
 drivers/block/blksnap/ctrl.h         |   9 +
 drivers/block/blksnap/diff_area.c    | 656 ++++++++++++++++++++++++++
 drivers/block/blksnap/diff_area.h    | 177 +++++++
 drivers/block/blksnap/diff_buffer.c  | 132 ++++++
 drivers/block/blksnap/diff_buffer.h  |  75 +++
 drivers/block/blksnap/diff_io.c      | 168 +++++++
 drivers/block/blksnap/diff_io.h      | 118 +++++
 drivers/block/blksnap/diff_storage.c | 292 ++++++++++++
 drivers/block/blksnap/diff_storage.h |  93 ++++
 drivers/block/blksnap/event_queue.c  |  86 ++++
 drivers/block/blksnap/event_queue.h  |  63 +++
 drivers/block/blksnap/main.c         | 164 +++++++
 drivers/block/blksnap/params.h       |  12 +
 drivers/block/blksnap/snapimage.c    | 319 +++++++++++++
 drivers/block/blksnap/snapimage.h    |  73 +++
 drivers/block/blksnap/snapshot.c     | 654 ++++++++++++++++++++++++++
 drivers/block/blksnap/snapshot.h     |  78 ++++
 drivers/block/blksnap/sysfs.c        |  79 ++++
 drivers/block/blksnap/sysfs.h        |   7 +
 drivers/block/blksnap/tracker.c      | 672 +++++++++++++++++++++++++++
 drivers/block/blksnap/tracker.h      |  74 +++
 drivers/block/blksnap/version.h      |  10 +
 include/linux/blk_types.h            |   2 +
 include/linux/blkdev.h               |  64 +++
 include/uapi/linux/blksnap.h         | 467 +++++++++++++++++++
 36 files changed, 5946 insertions(+), 2 deletions(-)
 create mode 100644 drivers/block/blksnap/Kconfig
 create mode 100644 drivers/block/blksnap/Makefile
 create mode 100644 drivers/block/blksnap/cbt_map.c
 create mode 100644 drivers/block/blksnap/cbt_map.h
 create mode 100644 drivers/block/blksnap/chunk.c
 create mode 100644 drivers/block/blksnap/chunk.h
 create mode 100644 drivers/block/blksnap/ctrl.c
 create mode 100644 drivers/block/blksnap/ctrl.h
 create mode 100644 drivers/block/blksnap/diff_area.c
 create mode 100644 drivers/block/blksnap/diff_area.h
 create mode 100644 drivers/block/blksnap/diff_buffer.c
 create mode 100644 drivers/block/blksnap/diff_buffer.h
 create mode 100644 drivers/block/blksnap/diff_io.c
 create mode 100644 drivers/block/blksnap/diff_io.h
 create mode 100644 drivers/block/blksnap/diff_storage.c
 create mode 100644 drivers/block/blksnap/diff_storage.h
 create mode 100644 drivers/block/blksnap/event_queue.c
 create mode 100644 drivers/block/blksnap/event_queue.h
 create mode 100644 drivers/block/blksnap/main.c
 create mode 100644 drivers/block/blksnap/params.h
 create mode 100644 drivers/block/blksnap/snapimage.c
 create mode 100644 drivers/block/blksnap/snapimage.h
 create mode 100644 drivers/block/blksnap/snapshot.c
 create mode 100644 drivers/block/blksnap/snapshot.h
 create mode 100644 drivers/block/blksnap/sysfs.c
 create mode 100644 drivers/block/blksnap/sysfs.h
 create mode 100644 drivers/block/blksnap/tracker.c
 create mode 100644 drivers/block/blksnap/tracker.h
 create mode 100644 drivers/block/blksnap/version.h
 create mode 100644 include/uapi/linux/blksnap.h

-- 
2.20.1

