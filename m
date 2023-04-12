Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3438E6DFB27
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjDLQUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDLQUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:20:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A246961B4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA443636F1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 16:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 315B7C4339B;
        Wed, 12 Apr 2023 16:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681316419;
        bh=dD6JLHaY5QGrUy9uSU5rAL+T4OMswT/1bJQe6jI91Pw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BplGQgkC6NIBwqKcDa9PYMQuw1KC/Pph0eCWuCRWmDUgQ7Vifipe4ygmb1gw4G7js
         3NUYkD7DvHDXqgxPIaBvaSZs5/pwMjmiMHM7YbxaRTFHvAoTkMfr2gV/dLaEmCl/u9
         hk1arFk1WeWJ84wGwOXu9P85ZaIO6kBtNguYl2x1hCxm6jmRmxyRhKf/K2ViGkBtJI
         ezWk8KWiJsB4J8HvYY70kJKcKxXbmuyxwHxb85cXgBVskizEnjsTbMT445gryxpXRz
         mxcd0kzwrQ2X5PfGU5eCp7bzluy8QJU6hgk0epCpXNev0U0MRFbQu/hzvx3pDUWZLT
         R/KQRw0NQFbnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CC1EE5244F;
        Wed, 12 Apr 2023 16:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to recover quota data correctly
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168131641904.15557.7224086713255348466.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Apr 2023 16:20:19 +0000
References: <20230402112706.42211-1-chao@kernel.org>
In-Reply-To: <20230402112706.42211-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun,  2 Apr 2023 19:27:06 +0800 you wrote:
> With -O quota mkfs option, xfstests generic/417 fails due to fsck detects
> data corruption on quota inodes.
> 
> [ASSERT] (fsck_chk_quota_files:2051)  --> Quota file is missing or invalid quota file content found.
> 
> The root cause is there is a hole f2fs doesn't hold quota inodes,
> so all recovered quota data will be dropped due to SBI_POR_DOING
> flag was set.
> - f2fs_fill_super
>  - f2fs_recover_orphan_inodes
>   - f2fs_enable_quota_files
>   - f2fs_quota_off_umount
> <--- quota inodes were dropped --->
>  - f2fs_recover_fsync_data
>   - f2fs_enable_quota_files
>   - f2fs_quota_off_umount
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to recover quota data correctly
    https://git.kernel.org/jaegeuk/f2fs/c/cbb356d60c54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


