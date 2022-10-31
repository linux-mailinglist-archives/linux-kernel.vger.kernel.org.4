Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD74613D61
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJaSag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiJaSae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:30:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BE5263D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:30:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52B6D61323
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 18:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDFFC433D6;
        Mon, 31 Oct 2022 18:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667241032;
        bh=SJ1Z220OaKsIBgx1R0J98wMJy/gtWfntG2gf3M3ljf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PfgjHGgCeq0tU3bP4CnPXKs0ndwNt3rpKv7/xhNwOjd8m+hihm7LI2pjFlmbflO/Q
         M9xeZ6+qyRAHq8F7SYnd3MhIlylR6dGnco4kIKSukxa6c7r8OSdVgpMhmLqeNo3/pK
         Z6Fr0mbG1CE4aFblkA31JVZ5ry6qqKGmLPX4j7IXmdnqrhMtkQ5teLKNjzigSN8gYo
         2pflaB8u3Y1KQDbWhBffaZwoBjKUBr5/vIaIx5sR5YSJ1G3WaQ7UQ3Y1noqIS+LEwK
         XSbp12ldLLmwo677+VLdXGJQx4d7+xWJgNKQ/0pus0JL+dEKqWJiu2qW2WzZ6bDjK7
         cwR9PboSQVq6g==
From:   SeongJae Park <sj@kernel.org>
To:     syzbot <syzbot+6087eafb76a94c4ac9eb@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, sj@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Write in dbgfs_rm_context_write
Date:   Mon, 31 Oct 2022 18:30:30 +0000
Message-Id: <20221031183030.7961-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <000000000000ede3ac05ec4abf8e@google.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, 30 Oct 2022 18:44:35 -0700 syzbot <syzbot+6087eafb76a94c4ac9eb@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    98555239e4c3 Merge tag 'arc-6.1-fixes' of git://git.kernel..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12508922880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
> dashboard link: https://syzkaller.appspot.com/bug?extid=6087eafb76a94c4ac9eb
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167e3f4a880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1262cb86880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b9ab8f713204/disk-98555239.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5efa1b178038/vmlinux-98555239.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/83329b87f1a8/bzImage-98555239.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6087eafb76a94c4ac9eb@syzkaller.appspotmail.com
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
> CPU: 1 PID: 3603 Comm: syz-executor414 Not tainted 6.1.0-rc2-syzkaller-00078-g98555239e4c3 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> RIP: 0010:dbgfs_rm_context mm/damon/dbgfs.c:928 [inline]
> RIP: 0010:dbgfs_rm_context_write+0x2e3/0x4d0 mm/damon/dbgfs.c:971

Thank you for this report.  I just posted a patchset[1] for the fix and
selftest repro of this bug.

[1] https://lore.kernel.org/damon/20221031182554.7882-1-sj@kernel.org/

Thanks,
SJ

[...]
