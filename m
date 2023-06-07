Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBAA726761
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjFGRay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjFGRab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:30:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A165B210E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AD116420B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 17:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A4EAC433A7;
        Wed,  7 Jun 2023 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686159025;
        bh=FTQAYVqKB9ife58WmF198IKKuckRPuxdOSAEbzL9Z8M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pgk38fYN8e14fd/2uozhIzgYfAvKt4oB0beevz47NG4rs5Bvp+3j0Sorl8YhqjM+8
         8N46r2MRIiNW9mUr5Mpb7vla/3i0/LsHBk5tEvuDSUhXPAOU+9ZdjJ+kxdHNDm5Nsl
         VEelWvXMh9SQ1kgI9fvF66eckVzFjR+x/Je20J/jaKN6DaKuW74eI678U0712sw0Oq
         S96bPEx4Yvn5E/RwGxcjd2ouwQKl3B1+QrYqyQVscJ7FInwDGEpYOU1B8zmULeg15k
         rLn5OncfOPmtfdPuS2WRlR0ejPcWBy5oYwcKNTj1ziuDa+7ZULyhuSDb7j5jU40VYp
         g+16Q8qgbF8+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C2C7E29F37;
        Wed,  7 Jun 2023 17:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: avoid dead loop in
 f2fs_issue_checkpoint()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168615902530.7521.17675789730262728885.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Jun 2023 17:30:25 +0000
References: <20230602083605.2470674-1-chao@kernel.org>
In-Reply-To: <20230602083605.2470674-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
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

On Fri,  2 Jun 2023 16:36:05 +0800 you wrote:
> generic/082 reports a bug as below:
> 
> __schedule+0x332/0xf60
> schedule+0x6f/0xf0
> schedule_timeout+0x23b/0x2a0
> wait_for_completion+0x8f/0x140
> f2fs_issue_checkpoint+0xfe/0x1b0
> f2fs_sync_fs+0x9d/0xb0
> sync_filesystem+0x87/0xb0
> dquot_load_quota_sb+0x41b/0x460
> dquot_load_quota_inode+0xa5/0x130
> dquot_quota_on+0x4b/0x60
> f2fs_quota_on+0xe3/0x1b0
> do_quotactl+0x483/0x700
> __x64_sys_quotactl+0x15c/0x310
> do_syscall_64+0x3f/0x90
> entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,2/2] f2fs: avoid dead loop in f2fs_issue_checkpoint()
    https://git.kernel.org/jaegeuk/f2fs/c/81deabbb536c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


