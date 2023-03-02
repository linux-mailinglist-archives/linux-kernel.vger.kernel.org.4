Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC74C6A8D07
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 00:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCBX2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 18:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjCBX2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:28:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F03269B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 15:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8W0GXVgRuSB9B6rebynfjhy7dE20zjSrVQrM74z6Jks=; b=fsbQHlBuN24Stwq+YBoeoK7D2D
        xa/36UVjFZQ+53YYTYfzpTGwzxM2v78TQZNvAZ6zy5RZLZskqbS74QYOwkr5QsOg93EcNTdyh2hzP
        EdQvVZCGBmsu2JZgryEKE8jENfPsHxZBzKj4xDQzmcVcJEOI8XvSYh8kg9lS0f2HPTMcIz+BiSFXQ
        CR3O5p5sCpe7pD8eNwWDWg30MKpvo494xBd2wY5gL1X9MafuTrO9KS+/aI/UWUrOGMYXxlZlIGujc
        cjTp85aO+7bXzNUwc0iZxFhNih0RUqaCQN7DBfw8qH1i4Ku+3vlBt58EYExHXIYXoWiSc1/keVEbR
        Jf9t6Y7Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXsL9-003j3G-0d; Thu, 02 Mar 2023 23:27:59 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org
Cc:     linux-mm@kvack.org, p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, mcgrof@kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] tmpfs: add the option to disable swap
Date:   Thu,  2 Mar 2023 15:27:52 -0800
Message-Id: <20230302232758.888157-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
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

After a couple of RFCs I think this is ready for PATCH form. Review
is appreciated. Below the changes I also list the series of tests
I performed to verify correctness. In short you either create a fs
with swap or without, but if you can't change that option later.
If we really wanted to, we could work on accepting this change on
reconfigure (remount) but its not clear yet that is desirable so
for now keep things simple.

Changes since last RFCv2:

  o Added Christian Brauner'd Acked-by for the noswap patch (the only
    change in that patch is just the new shmem_show_options() change I
    describe below).
  o Embraced Yosry Ahmed's recommendation to use mapping_set_unevictable()
    to at ensure the folios at least appear in the unevictable LRU.
    Since that is the goal, this accomplishes what we want and the VM
    takes care of things for us. The shem writepage() still uses a stop-gap
    to ensure we don't get called for swap when its shmem uses
    mapping_set_unevictable().
  o I had evaluated using shmem_lock() instead of calling mapping_set_unevictable()
    but upon my review this doesn't make much sense, as shmem_lock() was
    designed to make use of the RLIMIT_MEMLOCK and this was designed for
    files / IPC / unprivileged perf limits. If we were to use
    shmem_lock() we'd bump the count on each new inode. Using
    shmem_lock() would also complicate inode allocation on shmem as
    we'd to unwind on failure from the user_shm_lock(). It would also
    beg the question of when to capture a ucount for an inode, should we
    just share one for the superblock at shmem_fill_super() or do we
    really need to capture it at every single inode creation? In theory
    we could end up with different limits. The simple solution is to
    juse use mapping_set_unevictable() upon inode creation and be done
    with it, as it cannot fail.
  o Update the documentation for tmpfs before / after my patch to
    reflect use cases a bit more clearly between ramfs, tmpfs and brd
    ramdisks.
  o I updated the shmem_show_options() to also reveal the noswap option
    when its used.
  o Address checkpatch style complaint with spaces before tabs on
    shmem_fs.h.

Chances since first RFC:

  o Matthew suggested BUG_ON(!folio_test_locked(folio)) is not needed
    on writepage() callback for shmem so just remove that.
  o Based on Matthew's feedback the inode is set up early as it is not
    reset in case we split the folio. So now we move all the variables
    we can set up really early.
  o shmem writepage() should only be issued on reclaim, so just move
    the WARN_ON_ONCE(!wbc->for_reclaim) early so that the code and
    expectations are easier to read. This also avoid the folio splitting
    in case of that odd case.
  o There are a few cases where the shmem writepage() could possibly
    hit, but in the total_swap_pages we just bail out. We shouldn't be
    splitting the folio then. Likewise for VM_LOCKED case. But for
    a writepage() on a VM_LOCKED case is not expected so we want to
    learn about it so add a WARN_ON_ONCE() on that condition.
  o Based on Yosry Ahmed's feedback the patch which allows tmpfs to
    disable swap now just uses mapping_set_unevictable() on inode
    creation. In that case writepage() should not be called so we
    augment the WARN_ON_ONCE() for writepage() for that case to ensure
    that never happens.

To test I've used kdevops [0] 8 vpcu 4 GiB libvirt guest on linux-next.

I'm doing this work as part of future experimentation with tmpfs and the
page cache, but given a common complaint found about tmpfs is the
innability to work without the page cache I figured this might be useful
to others. It turns out it is -- at least Christian Brauner indicates
systemd uses ramfs for a few use-cases because they don't want to use
swap and so having this option would let them move over to using tmpfs
for those small use cases, see systemd-creds(1).

To see if you hit swap:

mkswap /dev/nvme2n1
swapon /dev/nvme2n1
free -h

With swap - what we see today
=============================
mount -t tmpfs            -o size=5G           tmpfs /data-tmpfs/
dd if=/dev/urandom of=/data-tmpfs/5g-rand2 bs=1G count=5
free -h
               total        used        free      shared  buff/cache   available
Mem:           3.7Gi       2.6Gi       1.2Gi       2.2Gi       2.2Gi       1.2Gi
Swap:           99Gi       2.8Gi        97Gi


Without swap
=============

free -h
               total        used        free      shared  buff/cache   available
Mem:           3.7Gi       387Mi       3.4Gi       2.1Mi        57Mi       3.3Gi
Swap:           99Gi          0B        99Gi
mount -t tmpfs            -o size=5G -o noswap tmpfs /data-tmpfs/
dd if=/dev/urandom of=/data-tmpfs/5g-rand2 bs=1G count=5
free -h
               total        used        free      shared  buff/cache   available
Mem:           3.7Gi       2.6Gi       1.2Gi       2.3Gi       2.3Gi       1.1Gi
Swap:           99Gi        21Mi        99Gi

The mix and match remount testing
=================================

# Cannot disable swap after it was first enabled:
mount -t tmpfs            -o size=5G           tmpfs /data-tmpfs/
mount -t tmpfs -o remount -o size=5G -o noswap tmpfs /data-tmpfs/
mount: /data-tmpfs: mount point not mounted or bad option.
       dmesg(1) may have more information after failed mount system call.
dmesg -c
tmpfs: Cannot disable swap on remount

# Remount with the same noswap option is OK:
mount -t tmpfs            -o size=5G -o noswap tmpfs /data-tmpfs/
mount -t tmpfs -o remount -o size=5G -o noswap tmpfs /data-tmpfs/
dmesg -c

# Trying to enable swap with a remount after it first disabled:
mount -t tmpfs            -o size=5G -o noswap tmpfs /data-tmpfs/
mount -t tmpfs -o remount -o size=5G           tmpfs /data-tmpfs/
mount: /data-tmpfs: mount point not mounted or bad option.
       dmesg(1) may have more information after failed mount system call.
dmesg -c
tmpfs: Cannot enable swap on remount if it was disabled on first mount

[0] https://github.com/linux-kdevops/kdevops

Luis Chamberlain (6):
  shmem: remove check for folio lock on writepage()
  shmem: set shmem_writepage() variables early
  shmem: move reclaim check early on writepages()
  shmem: skip page split if we're not reclaiming
  shmem: update documentation
  shmem: add support to ignore swap

 Documentation/filesystems/tmpfs.rst  | 36 +++++++++-----
 Documentation/mm/unevictable-lru.rst |  2 +
 include/linux/shmem_fs.h             |  1 +
 mm/shmem.c                           | 70 +++++++++++++++++++---------
 4 files changed, 75 insertions(+), 34 deletions(-)

-- 
2.39.1

