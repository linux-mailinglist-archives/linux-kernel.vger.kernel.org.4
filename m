Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7916B88BB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 03:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjCNCqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 22:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjCNCqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 22:46:36 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE95C8EA33
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 19:46:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vdq38i0_1678761988;
Received: from 30.240.99.29(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0Vdq38i0_1678761988)
          by smtp.aliyun-inc.com;
          Tue, 14 Mar 2023 10:46:29 +0800
Message-ID: <e1de614b-25e1-5c21-933a-880412ac7421@linux.alibaba.com>
Date:   Tue, 14 Mar 2023 10:46:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/6] tmpfs: add the option to disable swap
To:     Luis Chamberlain <mcgrof@kernel.org>, hughd@google.com,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org
Cc:     linux-mm@kvack.org, p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230309230545.2930737-1-mcgrof@kernel.org>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20230309230545.2930737-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All these series looks good to me and i do some test on my virtual 
machine it works well.

so please add Tested-by: Xin Hao <xhao@linux.alibaba.com> .

just one question, if tmpfs pagecache occupies a large amount of memory, 
how can we ensure successful memory reclamation in case of memory shortage?

在 2023/3/10 上午7:05, Luis Chamberlain 写道:
> Changes on this v2 PATCH series:
>
>    o Added all respective tags for Reviewed-by, Acked-by's
>    o David Hildenbrand suggested on the update-docs patch to mention THP.
>      It turns out tmpfs.rst makes absolutely no mention to THP at all
>      so I added all the relevant options to the docs including the
>      system wide sysfs file. All that should hopefully demistify that
>      and make it clearer.
>    o Yosry Ahmed spell checked my patch "shmem: add support to ignore swap"
>
> Changes since RFCv2 to the first real PATCH series:
>
>    o Added Christian Brauner'd Acked-by for the noswap patch (the only
>      change in that patch is just the new shmem_show_options() change I
>      describe below).
>    o Embraced Yosry Ahmed's recommendation to use mapping_set_unevictable()
>      to at ensure the folios at least appear in the unevictable LRU.
>      Since that is the goal, this accomplishes what we want and the VM
>      takes care of things for us. The shem writepage() still uses a stop-gap
>      to ensure we don't get called for swap when its shmem uses
>      mapping_set_unevictable().
>    o I had evaluated using shmem_lock() instead of calling mapping_set_unevictable()
>      but upon my review this doesn't make much sense, as shmem_lock() was
>      designed to make use of the RLIMIT_MEMLOCK and this was designed for
>      files / IPC / unprivileged perf limits. If we were to use
>      shmem_lock() we'd bump the count on each new inode. Using
>      shmem_lock() would also complicate inode allocation on shmem as
>      we'd to unwind on failure from the user_shm_lock(). It would also
>      beg the question of when to capture a ucount for an inode, should we
>      just share one for the superblock at shmem_fill_super() or do we
>      really need to capture it at every single inode creation? In theory
>      we could end up with different limits. The simple solution is to
>      juse use mapping_set_unevictable() upon inode creation and be done
>      with it, as it cannot fail.
>    o Update the documentation for tmpfs before / after my patch to
>      reflect use cases a bit more clearly between ramfs, tmpfs and brd
>      ramdisks.
>    o I updated the shmem_show_options() to also reveal the noswap option
>      when its used.
>    o Address checkpatch style complaint with spaces before tabs on
>      shmem_fs.h.
>
> Chances since first RFC:
>
>    o Matthew suggested BUG_ON(!folio_test_locked(folio)) is not needed
>      on writepage() callback for shmem so just remove that.
>    o Based on Matthew's feedback the inode is set up early as it is not
>      reset in case we split the folio. So now we move all the variables
>      we can set up really early.
>    o shmem writepage() should only be issued on reclaim, so just move
>      the WARN_ON_ONCE(!wbc->for_reclaim) early so that the code and
>      expectations are easier to read. This also avoid the folio splitting
>      in case of that odd case.
>    o There are a few cases where the shmem writepage() could possibly
>      hit, but in the total_swap_pages we just bail out. We shouldn't be
>      splitting the folio then. Likewise for VM_LOCKED case. But for
>      a writepage() on a VM_LOCKED case is not expected so we want to
>      learn about it so add a WARN_ON_ONCE() on that condition.
>    o Based on Yosry Ahmed's feedback the patch which allows tmpfs to
>      disable swap now just uses mapping_set_unevictable() on inode
>      creation. In that case writepage() should not be called so we
>      augment the WARN_ON_ONCE() for writepage() for that case to ensure
>      that never happens.
>
> To test I've used kdevops [0] 8 vpcu 4 GiB libvirt guest on linux-next.
>
> I'm doing this work as part of future experimentation with tmpfs and the
> page cache, but given a common complaint found about tmpfs is the
> innability to work without the page cache I figured this might be useful
> to others. It turns out it is -- at least Christian Brauner indicates
> systemd uses ramfs for a few use-cases because they don't want to use
> swap and so having this option would let them move over to using tmpfs
> for those small use cases, see systemd-creds(1).
>
> To see if you hit swap:
>
> mkswap /dev/nvme2n1
> swapon /dev/nvme2n1
> free -h
>
> With swap - what we see today
> =============================
> mount -t tmpfs            -o size=5G           tmpfs /data-tmpfs/
> dd if=/dev/urandom of=/data-tmpfs/5g-rand2 bs=1G count=5
> free -h
>                 total        used        free      shared  buff/cache   available
> Mem:           3.7Gi       2.6Gi       1.2Gi       2.2Gi       2.2Gi       1.2Gi
> Swap:           99Gi       2.8Gi        97Gi
>
>
> Without swap
> =============
>
> free -h
>                 total        used        free      shared  buff/cache   available
> Mem:           3.7Gi       387Mi       3.4Gi       2.1Mi        57Mi       3.3Gi
> Swap:           99Gi          0B        99Gi
> mount -t tmpfs            -o size=5G -o noswap tmpfs /data-tmpfs/
> dd if=/dev/urandom of=/data-tmpfs/5g-rand2 bs=1G count=5
> free -h
>                 total        used        free      shared  buff/cache   available
> Mem:           3.7Gi       2.6Gi       1.2Gi       2.3Gi       2.3Gi       1.1Gi
> Swap:           99Gi        21Mi        99Gi
>
> The mix and match remount testing
> =================================
>
> # Cannot disable swap after it was first enabled:
> mount -t tmpfs            -o size=5G           tmpfs /data-tmpfs/
> mount -t tmpfs -o remount -o size=5G -o noswap tmpfs /data-tmpfs/
> mount: /data-tmpfs: mount point not mounted or bad option.
>         dmesg(1) may have more information after failed mount system call.
> dmesg -c
> tmpfs: Cannot disable swap on remount
>
> # Remount with the same noswap option is OK:
> mount -t tmpfs            -o size=5G -o noswap tmpfs /data-tmpfs/
> mount -t tmpfs -o remount -o size=5G -o noswap tmpfs /data-tmpfs/
> dmesg -c
>
> # Trying to enable swap with a remount after it first disabled:
> mount -t tmpfs            -o size=5G -o noswap tmpfs /data-tmpfs/
> mount -t tmpfs -o remount -o size=5G           tmpfs /data-tmpfs/
> mount: /data-tmpfs: mount point not mounted or bad option.
>         dmesg(1) may have more information after failed mount system call.
> dmesg -c
> tmpfs: Cannot enable swap on remount if it was disabled on first mount
>
> [0] https://github.com/linux-kdevops/kdevops
>
> Luis Chamberlain (6):
>    shmem: remove check for folio lock on writepage()
>    shmem: set shmem_writepage() variables early
>    shmem: move reclaim check early on writepages()
>    shmem: skip page split if we're not reclaiming
>    shmem: update documentation
>    shmem: add support to ignore swap
>
>   Documentation/filesystems/tmpfs.rst  | 66 ++++++++++++++++++++++-----
>   Documentation/mm/unevictable-lru.rst |  2 +
>   include/linux/shmem_fs.h             |  1 +
>   mm/shmem.c                           | 68 ++++++++++++++++++----------
>   4 files changed, 103 insertions(+), 34 deletions(-)
>
