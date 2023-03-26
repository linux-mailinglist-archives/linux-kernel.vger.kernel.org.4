Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2AB6C94DB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 15:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCZN66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 09:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCZN6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 09:58:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB7E7A9C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 06:58:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FBF360E9F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F05FC433EF;
        Sun, 26 Mar 2023 13:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679839080;
        bh=/6z6edxSb80/I6cx38gQBCVrzqiPeU6hxd3Z5IhF9u8=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=VyCc7QYE8KuCV6WV+f8EVIgn7wm2w3QnFL+2JhJIOw62vshh/LyYlMOGrWUunL9Pp
         +9n6Ej/fMJIJrJzv0Tmz5haXrHL4ip1u2H5irSWCfSzeTwa1NYaej8gpNVH9TUWh+2
         2SEUv41UzDnq49jZGhDJ7oA/K3sXttD5IQhjzWlrh3TKHQUNsyQkX2f90Eu8dbPdH5
         x/5wzPxvD5ImhXxIm0YQH/izh5bN6Vmjan6MyYMmzSIgeARySON5Y/4Ip7EZXzHutL
         XldXc+rMy+cIUnFOmtunCstyXwLQm4tEsRk58XbUB01Q40ficQAaooC7tl6d3yD7Ce
         3dWZ0ffLrQKrQ==
Message-ID: <4e34660e-e3c8-fba7-e5ee-d26d4df83cab@kernel.org>
Date:   Sun, 26 Mar 2023 21:57:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix scheduling while atomic in
 decompression path
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230323224734.2041173-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230323224734.2041173-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/24 6:47, Jaegeuk Kim wrote:
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
> Fixes: bff139b49d9f ("f2fs: handle decompress only post processing in softirq")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Fixes: 95fa90c9e5a7 ("f2fs: support recording errors into superblock")

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
