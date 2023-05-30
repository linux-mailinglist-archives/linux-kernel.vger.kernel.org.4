Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73AE7171DD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbjE3Xkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbjE3Xkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:40:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFA011C;
        Tue, 30 May 2023 16:40:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB5D760AF6;
        Tue, 30 May 2023 23:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DF72C4339B;
        Tue, 30 May 2023 23:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685490024;
        bh=NbVJnIWsVlIURPyBpA3Lby5LZNxGV0r+iqlqJl6ahYA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Zr0kvzpeMIl43tHFAXn9pvEltKpVsacwIAhdfHRtLy15frJ6YZzKyA/CFbW51bgvV
         1MJc1wh6KoNZ/EgwJU61VZWTy4xjrxiD93akf+3SHfr00mdi2nOQc+9nvwGbOanIpa
         B5mKBcKyRc9syYeGKKXgU7ZkB/n8+1G8g6vRUYMPdtKHiMtcB2Jd3zJKJIwf5gSFLk
         uRbbVFu/P/gJPUXg4V0DGoBI1qUAaonDiwELCAklF+WGGNycxug1emElrKWqwu0cLG
         Gi+bvqm9+0KF1mhqrI1QNo9ga/qKFvQT6p4F4AMQp4GXuvSvh4qKqgy/Tt/kN6vQTx
         L37A0ngLiXESQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0647AE52C03;
        Tue, 30 May 2023 23:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't reset unchangable mount option in
 f2fs_remount()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168549002402.8773.6116896933670248806.git-patchwork-notify@kernel.org>
Date:   Tue, 30 May 2023 23:40:24 +0000
References: <20230523035822.578123-1-chao@kernel.org>
In-Reply-To: <20230523035822.578123-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org,
        syzbot+d015b6c2fbb5c383bf08@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 23 May 2023 11:58:22 +0800 you wrote:
> syzbot reports a bug as below:
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000009: 0000 [#1] PREEMPT SMP KASAN
> RIP: 0010:__lock_acquire+0x69/0x2000 kernel/locking/lockdep.c:4942
> Call Trace:
>  lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5691
>  __raw_write_lock include/linux/rwlock_api_smp.h:209 [inline]
>  _raw_write_lock+0x2e/0x40 kernel/locking/spinlock.c:300
>  __drop_extent_tree+0x3ac/0x660 fs/f2fs/extent_cache.c:1100
>  f2fs_drop_extent_tree+0x17/0x30 fs/f2fs/extent_cache.c:1116
>  f2fs_insert_range+0x2d5/0x3c0 fs/f2fs/file.c:1664
>  f2fs_fallocate+0x4e4/0x6d0 fs/f2fs/file.c:1838
>  vfs_fallocate+0x54b/0x6b0 fs/open.c:324
>  ksys_fallocate fs/open.c:347 [inline]
>  __do_sys_fallocate fs/open.c:355 [inline]
>  __se_sys_fallocate fs/open.c:353 [inline]
>  __x64_sys_fallocate+0xbd/0x100 fs/open.c:353
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: don't reset unchangable mount option in f2fs_remount()
    https://git.kernel.org/jaegeuk/f2fs/c/c12f1bf28196

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


