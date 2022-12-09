Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDC164846C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiLIO7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLIO7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:59:10 -0500
Received: from mx4.veeam.com (mx4.veeam.com [104.41.138.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6546267;
        Fri,  9 Dec 2022 06:59:08 -0800 (PST)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 4067F7D480;
        Fri,  9 Dec 2022 17:23:51 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx4-2022; t=1670595831;
        bh=sZrGzF8yzlno69zi5D2w0dzytPjwjnHAf1IUHnFwems=;
        h=From:To:CC:Subject:Date:From;
        b=n78uzDeACM6EMCDmzDL0o1/NfUH2BYkC1e+Yd60z9UgD+5/YG4R/vAGCe7kDpZW73
         4TzCnDAyIlcTgAD9hvlYfZnHpoWYstUIBlUhKvxdamIKig6ViFfBwQ995ioaiKStrk
         ScLP7THZxvXvz2ZfefPA2QcJoSnPPK5IWQgkj8cbMp1tAvIP00gTXA0Duq8PCsE66D
         rPqanu2/zRgLq1mD05YNqS/yRcymdPfIsR9fG/obRr4y0hLPFOsKG8em/rpV8Qu0bP
         HfQUyltR+jby6ULIAgbPPZ7Vfpg4RhqPe4i/ygubPOKZGJdcI0jYcUv9gHFvC9HV7C
         FacJLzM1QNLJw==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 9 Dec 2022 15:23:48 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <corbet@lwn.net>
CC:     <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH v2 00/21] blksnap - block devices snapshots module
Date:   Fri, 9 Dec 2022 15:23:10 +0100
Message-ID: <20221209142331.26395-1-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens. Hi Jonathan. Hi all.

I am happy to offer a modified version of the Block Devices Snapshots
Module. It allows to create non-persistent snapshots of any block devices.
The main purpose of such snapshots is to provide backups of block devices.
See more in Documentation/block/blksnap.rst.

The Block Device Filtering Mechanism is added to the block layer. This
allows to attach and detach block device filters to the block layer.
Filters allow to extend the functionality of the block layer.
See more in Documentation/block/blkfilter.rst.

A tool, a library for working with blksnap and tests can be found at
www.github.com/veeam/blksnap.

The first version was suggested at 13 June 2022. Many thanks to
Christoph Hellwig and Randy Dunlap for the review of that version.

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
- The implementation of the snapshot image block device has been
  simplified, now it is a bio-based block device.
- Removed initialization of global variables with null values.
- Only one bio is used to copy one chunk.
- Checked on ppc64le.

The v1 version was suggested at 2 November 2022. Many thanks to Fabio
Fantoni for his for his participation in the "blksnap" project on github
and Jonathan Corbet for his article https://lwn.net/Articles/914031/.
Thanks to the impartial kernel test robot.

Changes:
- Added documentation for Block Device Filtering Mechanism.
- Added documentation for Block Devices Snapshots Module (blksnap).
- The MAINTAINERS file has been updated.
- Optimized queue code for snapshot images.
- Fixed comments, log messages and code for better readability.

Sergei Shtepa (21):
  documentation, blkfilter: Block Device Filtering Mechanism
  block, blkfilter: Block Device Filtering Mechanism
  documentation, capability: fix Generic Block Device Capability
  documentation, blksnap:  Block Devices Snapshots Module
  block, blksnap: header file of the module interface
  block, blksnap: module management interface functions
  block, blksnap: init() and exit() functions
  block, blksnap: interaction with sysfs
  block, blksnap: attaching and detaching the filter and handling I/O
    units
  block, blksnap: map of change block tracking
  block, blksnap: minimum data storage unit of the original block device
  block, blksnap: buffer in memory for the minimum data storage unit
  block, blksnap: functions and structures for performing block I/O
    operations
  block, blksnap: storage for storing difference blocks
  block, blksnap: event queue from the difference storage
  block, blksnap: owner of information about overwritten blocks of the
    original block device
  block, blksnap: snapshot image block device
  block, blksnap: snapshot
  block, blksnap: Kconfig and Makefile
  block, blksnap: adds a blksnap to the kernel tree
  block, blksnap: adds a maintainer for new files

 Documentation/block/blkfilter.rst    |  50 ++
 Documentation/block/blksnap.rst      | 348 ++++++++++++++
 Documentation/block/capability.rst   |   3 +
 Documentation/block/index.rst        |   2 +
 MAINTAINERS                          |  14 +
 block/bdev.c                         |  70 +++
 block/blk-core.c                     |  19 +-
 drivers/block/Kconfig                |   2 +
 drivers/block/Makefile               |   2 +
 drivers/block/blksnap/Kconfig        |  12 +
 drivers/block/blksnap/Makefile       |  18 +
 drivers/block/blksnap/cbt_map.c      | 268 +++++++++++
 drivers/block/blksnap/cbt_map.h      | 114 +++++
 drivers/block/blksnap/chunk.c        | 345 ++++++++++++++
 drivers/block/blksnap/chunk.h        | 139 ++++++
 drivers/block/blksnap/ctrl.c         | 410 ++++++++++++++++
 drivers/block/blksnap/ctrl.h         |   9 +
 drivers/block/blksnap/diff_area.c    | 655 +++++++++++++++++++++++++
 drivers/block/blksnap/diff_area.h    | 177 +++++++
 drivers/block/blksnap/diff_buffer.c  | 133 ++++++
 drivers/block/blksnap/diff_buffer.h  |  75 +++
 drivers/block/blksnap/diff_io.c      | 168 +++++++
 drivers/block/blksnap/diff_io.h      | 118 +++++
 drivers/block/blksnap/diff_storage.c | 317 +++++++++++++
 drivers/block/blksnap/diff_storage.h |  93 ++++
 drivers/block/blksnap/event_queue.c  |  86 ++++
 drivers/block/blksnap/event_queue.h  |  63 +++
 drivers/block/blksnap/main.c         | 164 +++++++
 drivers/block/blksnap/params.h       |  12 +
 drivers/block/blksnap/snapimage.c    | 275 +++++++++++
 drivers/block/blksnap/snapimage.h    |  69 +++
 drivers/block/blksnap/snapshot.c     | 670 ++++++++++++++++++++++++++
 drivers/block/blksnap/snapshot.h     |  78 +++
 drivers/block/blksnap/sysfs.c        |  80 ++++
 drivers/block/blksnap/sysfs.h        |   7 +
 drivers/block/blksnap/tracker.c      | 683 +++++++++++++++++++++++++++
 drivers/block/blksnap/tracker.h      |  74 +++
 drivers/block/blksnap/version.h      |  10 +
 include/linux/blk_types.h            |   2 +
 include/linux/blkdev.h               |  71 +++
 include/uapi/linux/blksnap.h         | 549 +++++++++++++++++++++
 41 files changed, 6452 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/block/blkfilter.rst
 create mode 100644 Documentation/block/blksnap.rst
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

