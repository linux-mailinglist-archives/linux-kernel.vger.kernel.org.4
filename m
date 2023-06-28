Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F679740B37
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjF1IYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:24:30 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:58888 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbjF1ITt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:19:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CA61612E6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 05:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF05C433C0;
        Wed, 28 Jun 2023 05:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687931573;
        bh=PPV5gFBUM+cLvTsnfUr0wCzl2695GOcuHmjuhb1pj24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LBpuumsnAWP8myDiXNDsmwsMUtxg5NoppaXFXDdBSjkhjck8TUBEgUhtmyPJbB/Pa
         cvAV6FTrWfoVgZloADtlRbNkbxFN83upW3iQCqBY+3xfzCLHl3oph/JZepjO+oOQiV
         G6zYZoL10K8nIrW6JSi5TYzWhVSNRelzJnzuvhnCz6XH/uli+f0jrTYBz7+7ghsK/F
         OPR2K8IXJ9MO8D+FWW5ln8H0HteyDnEuiRksR0w66R0WOMuvnct8pGzX5wLcGc5MsU
         zwFN8wNRGYlCUoN8AfHSZMEycFEsRONnfitjFbA2YNVDRy+AcvjWFzphcv/LTIRKQ1
         B04+mw/5BhZ0Q==
Date:   Tue, 27 Jun 2023 22:52:51 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+b67b270114065129f12b@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [syzbot] [mm?] possible deadlock in f2fs_file_write_iter
Message-ID: <20230628055251.GB1908@sol.localdomain>
References: <0000000000003b764f05ff09c1e2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003b764f05ff09c1e2@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 08:10:45AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c87d46a9e8eb Add linux-next specific files for 20230622
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=129edf4b280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d8ac8dd33677e8e0
> dashboard link: https://syzkaller.appspot.com/bug?extid=b67b270114065129f12b
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/bdf5ea2db527/disk-c87d46a9.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3201e576e2ad/vmlinux-c87d46a9.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d011d9fa4e63/bzImage-c87d46a9.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b67b270114065129f12b@syzkaller.appspotmail.com
> 
> F2FS-fs (loop5): Mounted with checkpoint version = 48b305e5
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.4.0-rc7-next-20230622-syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor.5/16876 is trying to acquire lock:
> ffff88802a033120 (&mm->mmap_lock){++++}-{3:3}, at: percpu_ref_put include/linux/percpu-refcount.h:351 [inline]
> ffff88802a033120 (&mm->mmap_lock){++++}-{3:3}, at: put_dev_pagemap include/linux/memremap.h:251 [inline]
> ffff88802a033120 (&mm->mmap_lock){++++}-{3:3}, at: gup_pte_range mm/gup.c:2583 [inline]
> ffff88802a033120 (&mm->mmap_lock){++++}-{3:3}, at: gup_pmd_range mm/gup.c:2950 [inline]
> ffff88802a033120 (&mm->mmap_lock){++++}-{3:3}, at: gup_pud_range mm/gup.c:2978 [inline]
> ffff88802a033120 (&mm->mmap_lock){++++}-{3:3}, at: gup_p4d_range mm/gup.c:3003 [inline]
> ffff88802a033120 (&mm->mmap_lock){++++}-{3:3}, at: gup_pgd_range mm/gup.c:3031 [inline]
> ffff88802a033120 (&mm->mmap_lock){++++}-{3:3}, at: lockless_pages_from_mm mm/gup.c:3084 [inline]
> ffff88802a033120 (&mm->mmap_lock){++++}-{3:3}, at: internal_get_user_pages_fast+0x135f/0x3370 mm/gup.c:3133
> 
> but task is already holding lock:
> ffff88808b20ea30 (&fi->i_gc_rwsem[WRITE]){++++}-{3:3}, at: f2fs_down_read fs/f2fs/f2fs.h:2107 [inline]
> ffff88808b20ea30 (&fi->i_gc_rwsem[WRITE]){++++}-{3:3}, at: f2fs_dio_write_iter fs/f2fs/file.c:4643 [inline]
> ffff88808b20ea30 (&fi->i_gc_rwsem[WRITE]){++++}-{3:3}, at: f2fs_file_write_iter+0x1161/0x2500 fs/f2fs/file.c:4766
> 

This was caused by the patch
"f2fs: fix to avoid mmap vs set_compress_option case"
(https://lore.kernel.org/linux-f2fs-devel/20230529104709.2560779-1-chao@kernel.org/)
which has been dropped.

#syz set subsystems: f2fs
#syz invalid

- Eric
