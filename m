Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E8A72D12C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238003AbjFLU4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbjFLUzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:55:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E99E5FE1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:51:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0C90620A0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41FEDC4339B;
        Mon, 12 Jun 2023 20:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686603022;
        bh=u2/UkIhdf3DGxsdKdPni953WmZ7Tsrt6n89M2makI5s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=P4zdWrJ7I9ncv/xIsWpCfy1UOAmt34YqvBUf4TkPb4hI8MqHFKhcMkpXthRBW5ztu
         s7WkJrNKbp1i4awNH27GK1JFL0r/iNkGsNojanTitv9FyK9QDLo1tWrcAPf5qBISn6
         tr1Q8t8d/nCDQDDTr+NeiWzx8OpBonyfBgdUTawPVvQxFcp6s1jnduzpJdyZ0KLox3
         OLyW6ejA9EIfj3Ydq1bdDw2+tlczWcRCk1a1OFbOei/SCDEtpZmztb1zY0BSQYMspu
         4bv+11U777r4lNkMRIbfRogZJTAavvOmV5QN8p0HD55GirdTZphaFZfUwlTJG4z+rz
         rulesEWwo3zhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1DA9FC395F3;
        Mon, 12 Jun 2023 20:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to avoid mmap vs
 set_compress_option case
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168660302211.10168.11054570964013825555.git-patchwork-notify@kernel.org>
Date:   Mon, 12 Jun 2023 20:50:22 +0000
References: <20230529104709.2560779-1-chao@kernel.org>
In-Reply-To: <20230529104709.2560779-1-chao@kernel.org>
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

On Mon, 29 May 2023 18:47:09 +0800 you wrote:
> Compression option in inode should not be changed after they have
> been used, however, it may happen in below race case:
> 
> Thread A				Thread B
> - f2fs_ioc_set_compress_option
>  - check f2fs_is_mmap_file()
>  - check get_dirty_pages()
>  - check F2FS_HAS_BLOCKS()
> 					- f2fs_file_mmap
> 					 - set_inode_flag(FI_MMAP_FILE)
> 					- fault
> 					 - do_page_mkwrite
> 					  - f2fs_vm_page_mkwrite
> 					  - f2fs_get_block_locked
> 					 - fault_dirty_shared_page
> 					  - set_page_dirty
>  - update i_compress_algorithm
>  - update i_log_cluster_size
>  - update i_cluster_size
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to avoid mmap vs set_compress_option case
    https://git.kernel.org/jaegeuk/f2fs/c/4286ee3e6efe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


