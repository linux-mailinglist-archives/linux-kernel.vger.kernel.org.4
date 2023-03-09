Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A186B31E6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 00:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjCIXG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 18:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjCIXGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 18:06:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5129BF6C77
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 15:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=HRljb6Ys5Lzl4IACtcBUT03PpNYTz5wqznGQEKOrRfc=; b=scUUcJb5VQLufIBtkFg3uCT5Nh
        DhsU+ZQlGLXsS2zbfZ5+K4ZV65r5RxByHCqR/b8EDjRJoQUM5pUdG6CsE63b9hMdLyV55MCVMhL0S
        Kvw+JUBA7q3Hfu5Prr4Cj7mwoxTUXs4cTOrF/EDq3tid52JYugKjREsXulo+tCe3oW5dRZ0E5rqzY
        lapxpVN35UHOfC4IPxTXdtoyp2kASS7gMqWEYeGX0QUUoukHxBGoeBI4wffiJ+pTh35TXU2kRQ8TQ
        8S+R3G3uf0rH3SXjBJv0xM1pYcbo+5dB9mLnAbWSYeygnXa7IrOyaJaTj6hZWdnfGtcYw75Sqyhvh
        XomNNAUQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paPKW-00CIRK-19; Thu, 09 Mar 2023 23:05:48 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org
Cc:     linux-mm@kvack.org, p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, mcgrof@kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] tmpfs: add the option to disable swap
Date:   Thu,  9 Mar 2023 15:05:39 -0800
Message-Id: <20230309230545.2930737-1-mcgrof@kernel.org>
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

Changes on this v2 PATCH series:

  o Added all respective tags for Reviewed-by, Acked-by's
  o David Hildenbrand suggested on the update-docs patch to mention THP.
    It turns out tmpfs.rst makes absolutely no mention to THP at all
    so I added all the relevant options to the docs including the
    system wide sysfs file. All that should hopefully demistify that
    and make it clearer.
  o Yosry Ahmed spell checked my patch "shmem: add support to ignore swap"

Changes since RFCv2 to the first real PATCH series:

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

 Documentation/filesystems/tmpfs.rst  | 66 ++++++++++++++++++++++-----
 Documentation/mm/unevictable-lru.rst |  2 +
 include/linux/shmem_fs.h             |  1 +
 mm/shmem.c                           | 68 ++++++++++++++++++----------
 4 files changed, 103 insertions(+), 34 deletions(-)

-- 
2.39.1

