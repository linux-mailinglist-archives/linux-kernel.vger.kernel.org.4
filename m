Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B3B68CCDD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjBGCxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBGCxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:53:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C225F8F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 18:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=i4yenvsgq3ZGN+thpbBGgSGc/CQ/bzRD70KdvQeiS/c=; b=AfWwCM1/rprXxexkw1OpAUb+qK
        RjH2OlPja0doEdVyL7mxPu04NI8R/H5WjYyO5TPZnI55ztBFyoApXbpZUok0F+U4NH3oXi7VaVfHG
        1ql9FkBIeeHvgE86tI30wvSdGoXS0TQd5It1QRBR69aXHjVJ+IRLt+8/yva4KeXpOocInYYK8iSha
        cKYBzfZBkKtKnfrexkLk2ES8mvARG1zRFV5RrHgopElmsKuHXOYm96pIokFzD8Ke4BS6YnuBjS3I7
        NZiD4Sweg20lmCISgFdyo2XVRYVoG5nW9dooZZMxQPzUGN3fMv2NdCMpL3qHu6KkGE1VwPQOclpDD
        3AtdDf5g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPE6Q-00AaIT-Uu; Tue, 07 Feb 2023 02:53:02 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org
Cc:     linux-mm@kvack.org, p.raghav@samsung.com, dave@stgolabs.net,
        a.manzanares@samsung.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 0/2] tmpfs: add the option to disable swap
Date:   Mon,  6 Feb 2023 18:52:57 -0800
Message-Id: <20230207025259.2522793-1-mcgrof@kernel.org>
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

Many folks suggest using tmpfs is not great because it can use swap.
That's not a good reason to *not* use tmpfs, what's just missing is just
the option to let you disable it. And so this does that, to enable that
and also let users experiment with it.

Reconfiguring is not supported, so what you set up first is what you can keep
with regards to swap options. Enabling support to disable on the fly and
add swap on the fly *is* possible, but I'm not sure we need that yet.

Matthew -- the first patch just makes it easier to read the second, but it does
beg a few questions in it with regards to semantics about the folio and
the inode after splitting a huge page so review for that would be
greatly appreciated.

To test I've used kdevops [0] 8 vpcu 4 GiB libvirt guest on linux-next.

I'm doing this work as part of future experimentation with tmpfs and the
page cache, but given a common complaint found about tmpfs is the
innability to work without the page cache I figured this might be useful
to others. It would also prove useful if folks ask for patches for future
experimentation we are doing.

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

Luis Chamberlain (2):
  shmem: set shmem_writepage() variables early
  shmem: add support to ignore swap

 include/linux/shmem_fs.h |  1 +
 mm/shmem.c               | 33 ++++++++++++++++++++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

-- 
2.39.0

