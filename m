Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB8E7077A6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 03:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjERBui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 21:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjERBuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 21:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D0C2D7F
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A061F64C41
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D846C433A8;
        Thu, 18 May 2023 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684374621;
        bh=iDRmiHP42z5SPaRMhEHGDBbuFT5qxpgNW+w2+vW00DU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CO/d25jNrqBnKYubsVVMKYjgDQA/5aL+BL9AJfMXtzmw9HRCPidfIpKvOYVbj4exD
         tFeLGiCbGNyogmaLKEKE0HzUKpfPNlDaV4JYxsDhSlRqUFoFyParNIw91PHshpyf4j
         4koOBiWLlOlETyCJ9KOMj3+h0n8Da1/ziU7QkPIp8vk2Hnt991IvFrjWkkIjJXUeiA
         0Wgtb/BHid2kxSDp4MDoKXqQil4wiHMt6glf9Il0BfkPjcW9i7ukyoUkDpL0dW2zGU
         UgmgiqBeTchZ+AYiBgAzUY9k6l53CokBetedWHfIk2RqeWFmSC4/aZpFru/G/Qz8ii
         +IObKnpLAaW9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7FFDFE21EF5;
        Thu, 18 May 2023 01:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix potential deadlock due to unpaired
 node_write lock use
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168437462152.19511.17219175731809504338.git-patchwork-notify@kernel.org>
Date:   Thu, 18 May 2023 01:50:21 +0000
References: <20230514080723.17313-1-chao@kernel.org>
In-Reply-To: <20230514080723.17313-1-chao@kernel.org>
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

On Sun, 14 May 2023 16:07:23 +0800 you wrote:
> If S_NOQUOTA is cleared from inode during data page writeback of quota
> file, it may miss to unlock node_write lock, result in potential
> deadlock, fix to use the lock in paired.
> 
> Kworker					Thread
> - writepage
>  if (IS_NOQUOTA())
>    f2fs_down_read(&sbi->node_write);
> 					- vfs_cleanup_quota_inode
> 					 - inode->i_flags &= ~S_NOQUOTA;
>  if (IS_NOQUOTA())
>    f2fs_up_read(&sbi->node_write);
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix potential deadlock due to unpaired node_write lock use
    https://git.kernel.org/jaegeuk/f2fs/c/a731b6aefbb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


