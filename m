Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB40D74454F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 01:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjF3Xkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 19:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjF3Xk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:40:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9364B2683
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 16:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CA3261827
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 23:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82B7CC433C7;
        Fri, 30 Jun 2023 23:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688168423;
        bh=bNCnDb33kESLzDYvWVvfK2jW6oK/8GxvCkD+l1MlPCw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kj8g45vZw2bOu++ciGtfJT0qqJuV89ttr6ZELTJEmKVgBr8izuBxQ5ldNH1FJuXlx
         WWh3xvC955RuzpcnJKe1aeua754ibT6oWNMHMK9D0ncXW9b9lwxGKsEegcwV+zJ4s0
         6R53Ag4VJjionaK8A+VhBzExxm5LjYmlShs6bL4xpvKQRKPf1HhCubeknr29ZBOuYs
         yMCSnM/VtwxTlHuayo77D1jWa2/DFpzIji2ud5wNby4qGHDg83MhAbTS7P2aJZo4oD
         e5MJHc21Xx2xL7NuucQawt8mkEatqM2/rV2eFihq7kbEbELOxl4OfYbO9WQdsCKI7d
         p0n+T4fGF/bdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57F2CC64458;
        Fri, 30 Jun 2023 23:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to do sanity check on direct node in
 truncate_dnode()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168816842335.31915.17270081956061195335.git-patchwork-notify@kernel.org>
Date:   Fri, 30 Jun 2023 23:40:23 +0000
References: <20230629111144.3582787-1-chao@kernel.org>
In-Reply-To: <20230629111144.3582787-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        syzbot+12cb4425b22169b52036@syzkaller.appspotmail.com,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Thu, 29 Jun 2023 19:11:44 +0800 you wrote:
> syzbot reports below bug:
> 
> BUG: KASAN: slab-use-after-free in f2fs_truncate_data_blocks_range+0x122a/0x14c0 fs/f2fs/file.c:574
> Read of size 4 at addr ffff88802a25c000 by task syz-executor148/5000
> 
> CPU: 1 PID: 5000 Comm: syz-executor148 Not tainted 6.4.0-rc7-syzkaller-00041-ge660abd551f1 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
>  print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
>  print_report mm/kasan/report.c:462 [inline]
>  kasan_report+0x11c/0x130 mm/kasan/report.c:572
>  f2fs_truncate_data_blocks_range+0x122a/0x14c0 fs/f2fs/file.c:574
>  truncate_dnode+0x229/0x2e0 fs/f2fs/node.c:944
>  f2fs_truncate_inode_blocks+0x64b/0xde0 fs/f2fs/node.c:1154
>  f2fs_do_truncate_blocks+0x4ac/0xf30 fs/f2fs/file.c:721
>  f2fs_truncate_blocks+0x7b/0x300 fs/f2fs/file.c:749
>  f2fs_truncate.part.0+0x4a5/0x630 fs/f2fs/file.c:799
>  f2fs_truncate include/linux/fs.h:825 [inline]
>  f2fs_setattr+0x1738/0x2090 fs/f2fs/file.c:1006
>  notify_change+0xb2c/0x1180 fs/attr.c:483
>  do_truncate+0x143/0x200 fs/open.c:66
>  handle_truncate fs/namei.c:3295 [inline]
>  do_open fs/namei.c:3640 [inline]
>  path_openat+0x2083/0x2750 fs/namei.c:3791
>  do_filp_open+0x1ba/0x410 fs/namei.c:3818
>  do_sys_openat2+0x16d/0x4c0 fs/open.c:1356
>  do_sys_open fs/open.c:1372 [inline]
>  __do_sys_creat fs/open.c:1448 [inline]
>  __se_sys_creat fs/open.c:1442 [inline]
>  __x64_sys_creat+0xcd/0x120 fs/open.c:1442
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to do sanity check on direct node in truncate_dnode()
    https://git.kernel.org/jaegeuk/f2fs/c/a6ec83786ab9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


