Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1426B9B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjCNQbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjCNQbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:31:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4440C2D45;
        Tue, 14 Mar 2023 09:31:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCBEBB81A43;
        Tue, 14 Mar 2023 16:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798E3C433EF;
        Tue, 14 Mar 2023 16:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678811461;
        bh=jSVVhOjC6ZBnBSzh2k3wAkD1l0qGs7Nu0B+0/i+GUA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c3cEYPa0JvYBFGk9nP2q7zg8PgGNCrYG8aJQt6staB2hXGWnXk7d3YDCfUagu+vcx
         vcklQy0PwInD8aNA/JThdb2H0c29SIjiaiS7P/uW9aHZMkm8MLUu634dVrUbt+LIPa
         e1cbOUXLghuEvJ5t1Bt8jYZzowhzoEfkK3l5BUBGI6bd2T/gMMdfn09+SQmBkAmi3D
         2FXANWTSfl8erX8RKY1qoYNbzsSXVFsrjCQBnBO0PxF5oJYIXDRUB8oT1imC6VvnO5
         1Tk7QNuAmoZnISptqZ94lq2Dt9i5lj8woSKcbws4jdvoJjz2SQe6rAHpjrGlNIoytZ
         whuLr55Z87fxw==
Date:   Tue, 14 Mar 2023 09:31:00 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] xfs: fix possible assert failed in xfs_fs_put_super()
 when do cpu offline
Message-ID: <20230314163100.GC11376@frogsfrogsfrogs>
References: <20230314090649.326642-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314090649.326642-1-yebin@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 05:06:49PM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> There's a issue when do cpu offline test:
> CPU: 48 PID: 1168152 Comm: umount Kdump: loaded Tainted: G L
> pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
> pc : assfail+0x8c/0xb4
> lr : assfail+0x38/0xb4
> sp : ffffa00033ce7c40
> x29: ffffa00033ce7c40 x28: ffffa00014794f30
> x27: ffffa00014f6ca20 x26: 1fffe0120b2e2030
> x25: ffff009059710188 x24: ffff00886c0a4650
> x23: 1fffe0110d8148ca x22: ffff009059710180
> x21: ffffa00015155680 x20: ffff00886c0a4000
> x19: 0000000000000001 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000
> x15: 0000000000000007 x14: 1fffe00304cef265
> x13: ffff00182642b200 x12: ffff8012d37757bf
> x11: 1fffe012d37757be x10: ffff8012d37757be
> x9 : ffffa00010603a0c x8 : 0000000041b58ab3
> x7 : ffff94000679cf44 x6 : 00000000ffffffc0
> x5 : 0000000000000021 x4 : 00000000ffffffca
> x3 : 1ffff40002a27ee1 x2 : 0000000000000004
> x1 : 0000000000000000 x0 : ffffa0001513f000
> Call trace:
>  assfail+0x8c/0xb4
>  xfs_destroy_percpu_counters+0x98/0xa4
>  xfs_fs_put_super+0x1a0/0x2a4
>  generic_shutdown_super+0x104/0x2c0
>  kill_block_super+0x8c/0xf4
>  deactivate_locked_super+0xa4/0x164
>  deactivate_super+0xb0/0xdc
>  cleanup_mnt+0x29c/0x3ec
>  __cleanup_mnt+0x1c/0x30
>  task_work_run+0xe0/0x200
>  do_notify_resume+0x244/0x320
>  work_pending+0xc/0xa0
> 
> We analyzed the data in vmcore is correct. But triggered above issue.
> As f689054aace2 ("percpu_counter: add percpu_counter_sum_all interface")
> commit describes there is a small race window between the online CPUs traversal
> of percpu_counter_sum and the CPU offline callback. This means percpu_counter_sum()
> may return incorrect result during cpu offline.
> To solve above issue use percpu_counter_sum_all() interface to make sure
> result is correct to prevent false triggering of assertions.

How about the other percpu_counter_sum callsites inside XFS?  Some of
them are involved in writing ondisk metadata (xfs_log_sb) or doing
correctness checks (fs/xfs/scrub/*); shouldn't those also be using the
_all variant?

--D

> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/xfs/xfs_super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 2479b5cbd75e..c0ce66f966ee 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1076,7 +1076,7 @@ xfs_destroy_percpu_counters(
>  	percpu_counter_destroy(&mp->m_ifree);
>  	percpu_counter_destroy(&mp->m_fdblocks);
>  	ASSERT(xfs_is_shutdown(mp) ||
> -	       percpu_counter_sum(&mp->m_delalloc_blks) == 0);
> +	       percpu_counter_sum_all(&mp->m_delalloc_blks) == 0);
>  	percpu_counter_destroy(&mp->m_delalloc_blks);
>  	percpu_counter_destroy(&mp->m_frextents);
>  }
> -- 
> 2.31.1
> 
