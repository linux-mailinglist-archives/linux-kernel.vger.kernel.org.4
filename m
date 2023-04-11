Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816826DE1C7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjDKRBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjDKRAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:00:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C3B59CA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92FE76298C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 17:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB0AFC4339C;
        Tue, 11 Apr 2023 17:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681232420;
        bh=UNSRSV9N/VyQhvGkfoOPWdKjQBu0P4UsjBMlYKJS+hw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CPker5tChAsnSZapefS0UD5yHNC1NcLDv0bwoPc4z0HrfRv2eFGeQI2mMiFDxyd2A
         KlZjSaDPI4pbdCxf98o1BJBiwUJGRMXUIrft70j0rKo6UpQ03UoOQ+XLhzjSmjOIDH
         iY/5ogLJKyxdGDxtAUTD6yXxFKSJyrgajdgipGaDdUKPzXBSPBF2+1D8afylXNSmeg
         j1DX7HwbYg40jLet0Y/6I3a/N5E/12DQW+8xfpmbkA4p7RbSvJWeg6ktN/N1x+NFds
         951TCkvCZLgb2tAxniAx6ZvhqtccumbLk+x53DkPdQb+hCbvNYs8nKu1JS7rA50p3C
         NOH4e7+vGanyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5B9CE52441;
        Tue, 11 Apr 2023 17:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to drop all dirty pages during
 umount() if cp_error is set
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168123241980.4928.10692103692042697319.git-patchwork-notify@kernel.org>
Date:   Tue, 11 Apr 2023 17:00:19 +0000
References: <20230410021222.1826966-1-chao@kernel.org>
In-Reply-To: <20230410021222.1826966-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 10 Apr 2023 10:12:22 +0800 you wrote:
> xfstest generic/361 reports a bug as below:
> 
> f2fs_bug_on(sbi, sbi->fsync_node_num);
> 
> kernel BUG at fs/f2fs/super.c:1627!
> RIP: 0010:f2fs_put_super+0x3a8/0x3b0
> Call Trace:
>  generic_shutdown_super+0x8c/0x1b0
>  kill_block_super+0x2b/0x60
>  kill_f2fs_super+0x87/0x110
>  deactivate_locked_super+0x39/0x80
>  deactivate_super+0x46/0x50
>  cleanup_mnt+0x109/0x170
>  __cleanup_mnt+0x16/0x20
>  task_work_run+0x65/0xa0
>  exit_to_user_mode_prepare+0x175/0x190
>  syscall_exit_to_user_mode+0x25/0x50
>  do_syscall_64+0x4c/0x90
>  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to drop all dirty pages during umount() if cp_error is set
    https://git.kernel.org/jaegeuk/f2fs/c/c9b3649a934d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


