Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2D865C6BF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238666AbjACSut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238692AbjACSuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:50:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAF86464
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEC48B810AA
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 18:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B0A7C433F1;
        Tue,  3 Jan 2023 18:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672771816;
        bh=sWG9rZzpm0Uy4RsyJFum58ghvV4r6+MVa47kFQe/yhY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DyVkDAEfyYJAVG4YCa99Q0P5eGgeWPsv2HMIJtQIiIQlMrCqlI8oIo9YFPjj1w3Us
         78qyOpGXRs4uIncH4KO2jN1iSIKXhku3G7EhaAwkqHZm2TinS3Dnd+K0xXYulqBGjL
         1eptToGegMpyf85KxkoMWX4Ik6hsP80lYLRTz3Au3L9SiNcTTr9TlqKNMGIZtnG6ut
         75oP1+cUYHdJ5IkphJgzzArFm4kZ8Od8CZOW3nVPqJSxgEwGWgeqs/9myyDcTlXDPA
         wCoSeF9xtqValf9JE0TBwXU082b3Q5Ecjo9KJoOWuxZgGn3KHpubtTvqpzkodszLo9
         WIvmTzHSZ+l/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74EA3E5724B;
        Tue,  3 Jan 2023 18:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: let's avoid panic if extent_tree is not
 created
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167277181647.18849.14412830382084760443.git-patchwork-notify@kernel.org>
Date:   Tue, 03 Jan 2023 18:50:16 +0000
References: <20221222235458.957816-1-jaegeuk@kernel.org>
In-Reply-To: <20221222235458.957816-1-jaegeuk@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
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

On Thu, 22 Dec 2022 15:54:58 -0800 you wrote:
> This patch avoids the below panic.
> 
> pc : __lookup_extent_tree+0xd8/0x760
> lr : f2fs_do_write_data_page+0x104/0x87c
> sp : ffffffc010cbb3c0
> x29: ffffffc010cbb3e0 x28: 0000000000000000
> x27: ffffff8803e7f020 x26: ffffff8803e7ed40
> x25: ffffff8803e7f020 x24: ffffffc010cbb460
> x23: ffffffc010cbb480 x22: 0000000000000000
> x21: 0000000000000000 x20: ffffffff22e90900
> x19: 0000000000000000 x18: ffffffc010c5d080
> x17: 0000000000000000 x16: 0000000000000020
> x15: ffffffdb1acdbb88 x14: ffffff888759e2b0
> x13: 0000000000000000 x12: ffffff802da49000
> x11: 000000000a001200 x10: ffffff8803e7ed40
> x9 : ffffff8023195800 x8 : ffffff802da49078
> x7 : 0000000000000001 x6 : 0000000000000000
> x5 : 0000000000000006 x4 : ffffffc010cbba28
> x3 : 0000000000000000 x2 : ffffffc010cbb480
> x1 : 0000000000000000 x0 : ffffff8803e7ed40
> Call trace:
>  __lookup_extent_tree+0xd8/0x760
>  f2fs_do_write_data_page+0x104/0x87c
>  f2fs_write_single_data_page+0x420/0xb60
>  f2fs_write_cache_pages+0x418/0xb1c
>  __f2fs_write_data_pages+0x428/0x58c
>  f2fs_write_data_pages+0x30/0x40
>  do_writepages+0x88/0x190
>  __writeback_single_inode+0x48/0x448
>  writeback_sb_inodes+0x468/0x9e8
>  __writeback_inodes_wb+0xb8/0x2a4
>  wb_writeback+0x33c/0x740
>  wb_do_writeback+0x2b4/0x400
>  wb_workfn+0xe4/0x34c
>  process_one_work+0x24c/0x5bc
>  worker_thread+0x3e8/0xa50
>  kthread+0x150/0x1b4
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: let's avoid panic if extent_tree is not created
    https://git.kernel.org/jaegeux/f2fs/c/df9d44b645b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


