Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE2F6F5B22
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 17:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjECP3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 11:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjECP3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 11:29:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381475592
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 08:29:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CACFD618EA
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 15:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698D9C433EF;
        Wed,  3 May 2023 15:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683127744;
        bh=c5fHNZL9gOzBsNhK0yGMsJoyKVL5D1e08PMrRpEg6W4=;
        h=Date:To:References:From:Subject:In-Reply-To:From;
        b=Fj95HdonyQmZbSiFkZHqpx3KwX9ypTLHx4FgwR4mZ4N8x6dgwXuj2ytfnByfZTOsv
         cpkmVXfgCoWf/k8OljZNJKEnDn9gAxhLVIa40sRfFBCJ7GI4wbM/iBp0yGeH6WHXAV
         2k1s2ZcObPDTo3lqPjNq/akF4C4tCECmlMhUEPBo03SAFKgfNSP1nReBzIhMbmhIOG
         tfF9Ejt01gVUIEsUF55+lw+ZgfDdWkzMmxV4pTGztBejxD19jZRcH4NDq6cqWdGpqD
         OW0cXa+MfJZ+iwdiovYT97HsDShiW4FqXin/mZupp513c0w1PNnG762lZBnsqW0qzK
         as0pz7TP1A9DA==
Message-ID: <5540e94e-d744-bf51-6344-95c8a173e89a@kernel.org>
Date:   Wed, 3 May 2023 23:28:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
To:     syzbot <syzbot+eb6201248f684e99b9f8@syzkaller.appspotmail.com>,
        jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000000534da05faa4d3d4@google.com>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
Subject: Re: [syzbot] [f2fs?] WARNING: lock held when returning to user space
 in f2fs_write_single_data_page
In-Reply-To: <0000000000000534da05faa4d3d4@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/2 1:05, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    58390c8ce1bd Merge tag 'iommu-updates-v6.4' of git://git.k..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=136e6ef8280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5eadbf0d3c2ece89
> dashboard link: https://syzkaller.appspot.com/bug?extid=eb6201248f684e99b9f8
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bbb03c280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140d36f8280000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/60130779f509/disk-58390c8c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d7f0cdd29b71/vmlinux-58390c8c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/de415ad52ae4/bzImage-58390c8c.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/dc89d01cd6e9/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+eb6201248f684e99b9f8@syzkaller.appspotmail.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git dev-test

> 
> syz-executor768: attempt to access beyond end of device
> loop0: rw=2049, sector=77824, nr_sectors = 2048 limit=63271
> syz-executor768: attempt to access beyond end of device
> loop0: rw=2049, sector=79872, nr_sectors = 2048 limit=63271
> ================================================
> WARNING: lock held when returning to user space!
> 6.3.0-syzkaller-12049-g58390c8ce1bd #0 Not tainted
> ------------------------------------------------
> syz-executor768/4998 is leaving the kernel with locks still held!
> 1 lock held by syz-executor768/4998:
>   #0: ffff88807e800448 (&sbi->node_write){++++}-{3:3}, at: f2fs_down_read fs/f2fs/f2fs.h:2087 [inline]
>   #0: ffff88807e800448 (&sbi->node_write){++++}-{3:3}, at: f2fs_write_single_data_page+0xa10/0x1d50 fs/f2fs/data.c:2842
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
