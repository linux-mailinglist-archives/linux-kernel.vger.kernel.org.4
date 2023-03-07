Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93286AEB84
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjCGRpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjCGRpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:45:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8547F974A9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:40:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A2B06152B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 17:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0699BC433A0;
        Tue,  7 Mar 2023 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678210825;
        bh=G624Y1RmqZOesd6378n2jmdY1VkeEqxM5hJbs/7/LxY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FMOj1vve9R18caTJLaP/8XmAoHF0gvEPHDmS3B+sW/V9TFpNRmyR7aTvhJ7gbW9WK
         LJj1N36E9W0VLoQbqHmqoP8++m3RP9sKtlwgHXg5iXzluYYGOiV7AzNlEqBOMCuIDw
         kDCz4ZYnJPp6thh8qyYjPLle0rWekbwqgtQ7cRVRPnC32Pacl/g+n6CINKr3cQCz75
         M+qhXkzkqpYvteYSLSzwYjQ+mW1JGvn/f37lmYhuinhcmvn7bGbzoHMlKo/nT9jGtV
         VBhHcYkoWf8tYHs8COaSfocs/2gvXpqFw1jdDMAEfPJAMQ5RLRDRF0ULurx+it9VWN
         hs1aVxTIljG6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5D13E61B69;
        Tue,  7 Mar 2023 17:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix unaligned field offset in 32-bits
 platform
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167821082486.1693.13833377074235792413.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Mar 2023 17:40:24 +0000
References: <20230307151408.58490-1-chao@kernel.org>
In-Reply-To: <20230307151408.58490-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, zhiguo.niu@unisoc.com,
        linux-kernel@vger.kernel.org,
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

On Tue,  7 Mar 2023 23:14:08 +0800 you wrote:
> F2FS-fs (dm-x): inconsistent rbtree, cur(3470333575168) next(3320009719808)
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/gc.c:602!
> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> PC is at get_victim_by_default+0x13c0/0x1498
> LR is at f2fs_check_rb_tree_consistence+0xc4/0xd4
> ....
> [<c04d98b0>] (get_victim_by_default) from [<c04d4f44>] (f2fs_gc+0x220/0x6cc)
> [<c04d4f44>] (f2fs_gc) from [<c04d4780>] (gc_thread_func+0x2ac/0x708)
> [<c04d4780>] (gc_thread_func) from [<c015c774>] (kthread+0x1a8/0x1b4)
> [<c015c774>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix unaligned field offset in 32-bits platform
    https://git.kernel.org/jaegeuk/f2fs/c/8cac643eaa93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


