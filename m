Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CCC6DE1C4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjDKRA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjDKRAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:00:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40A255BC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81BF862996
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 17:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E715EC4339B;
        Tue, 11 Apr 2023 17:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681232419;
        bh=rIUcju8/EDwKVpm25ybPyuxz+Uf6Zu5FcwGold4D7j8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MYp9ShmwvBsxA7bxmx7Vf9CoTJBkrJrH7U/T2mGR1mQBEkRGEsrsk2/HtyYv+Ae2b
         c66vxWp9F0MCRI0FPMZSN8+E+diMYTWol8sRpzqliTECQc5N5GskJzNtPQbyYdCNcX
         /5SdbUpAW5xIRdXi9wqzTClBwOKSyubKVOLOISG0FqqXjRmv7xkJh5h39kWcyFLzZh
         UqKFM+tKodhTN6J+j0kYnvNgbZwAMVPDhFsncwE77WpCZQXRDtbeKzcnhDCNGjy6xH
         XtCay7tTIDf9yxmvlUTnPnq2f+ZQZoHunpVMuXQH9dOS0/gjm7sbz16ep4nZdcbKNz
         LcVUIGWbOAotg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC615C395C3;
        Tue, 11 Apr 2023 17:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid use-after-free for cached IPU
 bio
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168123241976.4928.5772798816044756759.git-patchwork-notify@kernel.org>
Date:   Tue, 11 Apr 2023 17:00:19 +0000
References: <20230410021402.1833220-1-chao@kernel.org>
In-Reply-To: <20230410021402.1833220-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 10 Apr 2023 10:14:02 +0800 you wrote:
> xfstest generic/019 reports a bug:
> 
> kernel BUG at mm/filemap.c:1619!
> RIP: 0010:folio_end_writeback+0x8a/0x90
> Call Trace:
>  end_page_writeback+0x1c/0x60
>  f2fs_write_end_io+0x199/0x420
>  bio_endio+0x104/0x180
>  submit_bio_noacct+0xa5/0x510
>  submit_bio+0x48/0x80
>  f2fs_submit_write_bio+0x35/0x300
>  f2fs_submit_merged_ipu_write+0x2a0/0x2b0
>  f2fs_write_single_data_page+0x838/0x8b0
>  f2fs_write_cache_pages+0x379/0xa30
>  f2fs_write_data_pages+0x30c/0x340
>  do_writepages+0xd8/0x1b0
>  __writeback_single_inode+0x44/0x370
>  writeback_sb_inodes+0x233/0x4d0
>  __writeback_inodes_wb+0x56/0xf0
>  wb_writeback+0x1dd/0x2d0
>  wb_workfn+0x367/0x4a0
>  process_one_work+0x21d/0x430
>  worker_thread+0x4e/0x3c0
>  kthread+0x103/0x130
>  ret_from_fork+0x2c/0x50
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to avoid use-after-free for cached IPU bio
    https://git.kernel.org/jaegeuk/f2fs/c/5cdb422c8391

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


