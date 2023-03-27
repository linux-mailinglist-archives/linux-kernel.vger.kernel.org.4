Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C6C6CA9C3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjC0QA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjC0QAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC8F3AA1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9658561365
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3697C433D2;
        Mon, 27 Mar 2023 16:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679932820;
        bh=yzXF6ms5tVBoUp0idIE08tuqYR4d0j0UFOeE0fNkEvg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NGY/co5tgkbRThir2Su3xDF7HDta4k5Y0KJImNPt9mO46KlCIBXhks/5yecv2W6gD
         xr2LDlAnLvutSDMhp2AeHmUr50drQ7QassBeG2F2oLKhQbM+QdNMTT4GA+q3UfaSro
         EswhVu4cQyaJxy9qUU8n+aF6kcZxtj/6D7uYUhKW/OacwMNCxpqp5aCQXiBxIS8yc1
         zCaGyJIIjtN9b78zrTBCA3nudX2FM9LxXNFrRtKGq1ZH22uAiMJGTsYlIgOKWurp7/
         D4uzGiUkzhDBuqJ67PiqBGAiRD7RP2elk+ZEtWyrZVLjjowoA+vPpHRrxJUH4zhvtH
         FMcRi3tDJdFxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1685E4D022;
        Mon, 27 Mar 2023 16:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix scheduling while atomic in
 decompression path
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167993281985.32120.768472186310508340.git-patchwork-notify@kernel.org>
Date:   Mon, 27 Mar 2023 16:00:19 +0000
References: <20230323224734.2041173-1-jaegeuk@kernel.org>
In-Reply-To: <20230323224734.2041173-1-jaegeuk@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
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

On Thu, 23 Mar 2023 15:47:34 -0700 you wrote:
> [   16.945668][    C0] Call trace:
> [   16.945678][    C0]  dump_backtrace+0x110/0x204
> [   16.945706][    C0]  dump_stack_lvl+0x84/0xbc
> [   16.945735][    C0]  __schedule_bug+0xb8/0x1ac
> [   16.945756][    C0]  __schedule+0x724/0xbdc
> [   16.945778][    C0]  schedule+0x154/0x258
> [   16.945793][    C0]  bit_wait_io+0x48/0xa4
> [   16.945808][    C0]  out_of_line_wait_on_bit+0x114/0x198
> [   16.945824][    C0]  __sync_dirty_buffer+0x1f8/0x2e8
> [   16.945853][    C0]  __f2fs_commit_super+0x140/0x1f4
> [   16.945881][    C0]  f2fs_commit_super+0x110/0x28c
> [   16.945898][    C0]  f2fs_handle_error+0x1f4/0x2f4
> [   16.945917][    C0]  f2fs_decompress_cluster+0xc4/0x450
> [   16.945942][    C0]  f2fs_end_read_compressed_page+0xc0/0xfc
> [   16.945959][    C0]  f2fs_handle_step_decompress+0x118/0x1cc
> [   16.945978][    C0]  f2fs_read_end_io+0x168/0x2b0
> [   16.945993][    C0]  bio_endio+0x25c/0x2c8
> [   16.946015][    C0]  dm_io_dec_pending+0x3e8/0x57c
> [   16.946052][    C0]  clone_endio+0x134/0x254
> [   16.946069][    C0]  bio_endio+0x25c/0x2c8
> [   16.946084][    C0]  blk_update_request+0x1d4/0x478
> [   16.946103][    C0]  scsi_end_request+0x38/0x4cc
> [   16.946129][    C0]  scsi_io_completion+0x94/0x184
> [   16.946147][    C0]  scsi_finish_command+0xe8/0x154
> [   16.946164][    C0]  scsi_complete+0x90/0x1d8
> [   16.946181][    C0]  blk_done_softirq+0xa4/0x11c
> [   16.946198][    C0]  _stext+0x184/0x614
> [   16.946214][    C0]  __irq_exit_rcu+0x78/0x144
> [   16.946234][    C0]  handle_domain_irq+0xd4/0x154
> [   16.946260][    C0]  gic_handle_irq.33881+0x5c/0x27c
> [   16.946281][    C0]  call_on_irq_stack+0x40/0x70
> [   16.946298][    C0]  do_interrupt_handler+0x48/0xa4
> [   16.946313][    C0]  el1_interrupt+0x38/0x68
> [   16.946346][    C0]  el1h_64_irq_handler+0x20/0x30
> [   16.946362][    C0]  el1h_64_irq+0x78/0x7c
> [   16.946377][    C0]  finish_task_switch+0xc8/0x3d8
> [   16.946394][    C0]  __schedule+0x600/0xbdc
> [   16.946408][    C0]  preempt_schedule_common+0x34/0x5c
> [   16.946423][    C0]  preempt_schedule+0x44/0x48
> [   16.946438][    C0]  process_one_work+0x30c/0x550
> [   16.946456][    C0]  worker_thread+0x414/0x8bc
> [   16.946472][    C0]  kthread+0x16c/0x1e0
> [   16.946486][    C0]  ret_from_fork+0x10/0x20
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix scheduling while atomic in decompression path
    https://git.kernel.org/jaegeuk/f2fs/c/8906fb10b77f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


