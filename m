Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87496B31E5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 00:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjCIXGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 18:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjCIXGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 18:06:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210E1F4D93
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 15:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=KhIOryYi/WjMt1G9oWTtfKzfZj1AUYZk+i6xawkBgBo=; b=oZkr/qx3wEVfj1+ZVhCpyCYUCM
        jPh9BtYO/JSVE8KrDiP2o4+eSvNFTDhlZZMAGxJNUISY7r5Y2UQ9kJ7YZ7cFxmcydxWagnOYed0Og
        wDztp8ZfqI7TdvS/7rrodGjB1hRbxyZoDbRSj2Mhdxfex4+EkVe/kcw4urS7yVzUCrelwyN4OH53M
        pAguCzkK7m39yc+D18Yqzw4LPOmZDxW1iRJDItZjlzSejD1aNkbTxRX0HfkUWjGtOOtW3KhfjHCIZ
        HVtJ04r4g8q08N0npmkuwuhmFDnKnU1F4T7o6wh3xbBAlS8F2RA2HFNXQ2VjZe2ygU7wxl1qrFmMu
        jmuVMOqQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paPKW-00CIRa-Az; Thu, 09 Mar 2023 23:05:48 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org
Cc:     linux-mm@kvack.org, p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, mcgrof@kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 5/6] shmem: update documentation
Date:   Thu,  9 Mar 2023 15:05:44 -0800
Message-Id: <20230309230545.2930737-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230309230545.2930737-1-mcgrof@kernel.org>
References: <20230309230545.2930737-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the docs to reflect a bit better why some folks prefer tmpfs
over ramfs and clarify a bit more about the difference between brd
ramdisks.

While at it, add THP docs for tmpfs, both the mount options and the
sysfs file.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 Documentation/filesystems/tmpfs.rst | 57 +++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index 0408c245785e..1ec9a9f8196b 100644
--- a/Documentation/filesystems/tmpfs.rst
+++ b/Documentation/filesystems/tmpfs.rst
@@ -13,14 +13,25 @@ everything stored therein is lost.
 
 tmpfs puts everything into the kernel internal caches and grows and
 shrinks to accommodate the files it contains and is able to swap
-unneeded pages out to swap space. It has maximum size limits which can
-be adjusted on the fly via 'mount -o remount ...'
-
-If you compare it to ramfs (which was the template to create tmpfs)
-you gain swapping and limit checking. Another similar thing is the RAM
-disk (/dev/ram*), which simulates a fixed size hard disk in physical
-RAM, where you have to create an ordinary filesystem on top. Ramdisks
-cannot swap and you do not have the possibility to resize them.
+unneeded pages out to swap space, and supports THP.
+
+tmpfs extends ramfs with a few userspace configurable options listed and
+explained further below, some of which can be reconfigured dynamically on the
+fly using a remount ('mount -o remount ...') of the filesystem. A tmpfs
+filesystem can be resized but it cannot be resized to a size below its current
+usage. tmpfs also supports POSIX ACLs, and extended attributes for the
+trusted.* and security.* namespaces. ramfs does not use swap and you cannot
+modify any parameter for a ramfs filesystem. The size limit of a ramfs
+filesystem is how much memory you have available, and so care must be taken if
+used so to not run out of memory.
+
+An alternative to tmpfs and ramfs is to use brd to create RAM disks
+(/dev/ram*), which allows you to simulate a block device disk in physical RAM.
+To write data you would just then need to create an regular filesystem on top
+this ramdisk. As with ramfs, brd ramdisks cannot swap. brd ramdisks are also
+configured in size at initialization and you cannot dynamically resize them.
+Contrary to brd ramdisks, tmpfs has its own filesystem, it does not rely on the
+block layer at all.
 
 Since tmpfs lives completely in the page cache and on swap, all tmpfs
 pages will be shown as "Shmem" in /proc/meminfo and "Shared" in
@@ -85,6 +96,36 @@ mount with such options, since it allows any user with write access to
 use up all the memory on the machine; but enhances the scalability of
 that instance in a system with many CPUs making intensive use of it.
 
+tmpfs also supports Transparent Huge Pages which requires a kernel
+configured with CONFIG_TRANSPARENT_HUGEPAGE and with huge supported for
+your system (has_transparent_hugepage(), which is architecture specific).
+The mount options for this are:
+
+======  ============================================================
+huge=0  never: disables huge pages for the mount
+huge=1  always: enables huge pages for the mount
+huge=2  within_size: only allocate huge pages if the page will be
+        fully within i_size, also respect fadvise()/madvise() hints.
+huge=3  advise: only allocate huge pages if requested with
+        fadvise()/madvise()
+======  ============================================================
+
+There is a sysfs file which you can also use to control system wide THP
+configuration for all tmpfs mounts, the file is:
+
+/sys/kernel/mm/transparent_hugepage/shmem_enabled
+
+This sysfs file is placed on top of THP sysfs directory and so is registered
+by THP code. It is however only used to control all tmpfs mounts with one
+single knob. Since it controls all tmpfs mounts it should only be used either
+for emergency or testing purposes. The values you can set for shmem_enabled are:
+
+==  ============================================================
+-1  deny: disables huge on shm_mnt and all mounts, for
+    emergency use
+-2  force: enables huge on shm_mnt and all mounts, w/o needing
+    option, for testing
+==  ============================================================
 
 tmpfs has a mount option to set the NUMA memory allocation policy for
 all files in that instance (if CONFIG_NUMA is enabled) - which can be
-- 
2.39.1

