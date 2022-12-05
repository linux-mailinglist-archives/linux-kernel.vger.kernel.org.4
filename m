Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD476425CF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 10:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiLEJao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 04:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiLEJae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:30:34 -0500
Received: from out30-1.freemail.mail.aliyun.com (out30-1.freemail.mail.aliyun.com [115.124.30.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F04186DA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 01:30:31 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=0;PH=DS;RN=8;SR=0;TI=SMTPD_---0VWQvSYN_1670232627;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VWQvSYN_1670232627)
          by smtp.aliyun-inc.com;
          Mon, 05 Dec 2022 17:30:29 +0800
Date:   Mon, 5 Dec 2022 17:30:26 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     syzbot <syzbot+2ae90e873e97f1faf6f2@syzkaller.appspotmail.com>
Cc:     chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiang@kernel.org
Subject: Re: [syzbot] KASAN: use-after-free Read in z_erofs_transform_plain
Message-ID: <Y426Mo9cweiBi77q@B-P7TQMD6M-0146.local>
References: <00000000000041127805ef10446a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00000000000041127805ef10446a@google.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 12:13:47AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    97ee9d1c1696 Merge tag 'block-6.1-2022-12-02' of git://git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1786b2f5880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
> dashboard link: https://syzkaller.appspot.com/bug?extid=2ae90e873e97f1faf6f2
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115e5c47880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170fa3d5880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6a6a9ff34dfa/disk-97ee9d1c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2a01a4182c2b/vmlinux-97ee9d1c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4371158e8c25/bzImage-97ee9d1c.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/22dcea976d97/mount_0.gz
> 

It seems another report due to mixed ztailpacking (inline) and
non-inlined pclusters at once.

(Although I need to add another check for mixed algorithm formats for
 a single pcluster as well..)

#syz fix: erofs: Fix pcluster memleak when its block address is zero 

> The issue was bisected to:
> 
> commit dcbe6803fffd387f72b48c2373b5f5ed12a5804b
> Author: Gao Xiang <hsiangkao@linux.alibaba.com>
> Date:   Thu May 12 11:58:33 2022 +0000
> 
>     erofs: fix buffer copy overflow of ztailpacking feature
> 

It caused KASAN to begin to report, but it's not the root cause. Just
ignore it.

Thanks,
Gao Xiang
