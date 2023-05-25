Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D408710597
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 08:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237221AbjEYGN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 02:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEYGNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 02:13:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFC7E6
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 23:13:52 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QRd313JLtzLq2L;
        Thu, 25 May 2023 14:10:53 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 14:13:49 +0800
Message-ID: <f7f68db4-c4ff-e06b-86ff-a07c47f3fa80@huawei.com>
Date:   Thu, 25 May 2023 14:13:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] mm: shmem: Fix UAF bug in shmem_show_options()
Content-Language: en-US
To:     Tu Jinjiang <tujinjiang@huawei.com>, <hughd@google.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sunnanyong@huawei.com>
References: <20230525031640.593733-1-tujinjiang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230525031640.593733-1-tujinjiang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/25 11:16, Tu Jinjiang wrote:
> shmem_show_options() uses sbinfo->mpol without adding it's refcnt. This
> may lead to race with replacement of the mpol by remount. The execution
> sequence is as follows.
> 
>         CPU0                                   CPU1
> shmem_show_options()                        shmem_reconfigure()
>      shmem_show_mpol(seq, sbinfo->mpol)          mpol = sbinfo->mpol
>                                                  mpol_put(mpol)
>          mpol->mode
> 
> The KASAN report is as follows.
> 
> BUG: KASAN: slab-use-after-free in shmem_show_options+0x21b/0x340
> Read of size 2 at addr ffff888124324004 by task mount/2388
> 
> CPU: 2 PID: 2388 Comm: mount Not tainted 6.4.0-rc3-00017-g9d646009f65d-dirty #8
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x37/0x50
>   print_report+0xd0/0x620
>   ? shmem_show_options+0x21b/0x340
>   ? __virt_addr_valid+0xf4/0x180
>   ? shmem_show_options+0x21b/0x340
>   kasan_report+0xb8/0xe0
>   ? shmem_show_options+0x21b/0x340
>   shmem_show_options+0x21b/0x340
>   ? __pfx_shmem_show_options+0x10/0x10
>   ? strchr+0x2c/0x50
>   ? strlen+0x23/0x40
>   ? seq_puts+0x7d/0x90
>   show_vfsmnt+0x1e6/0x260
>   ? __pfx_show_vfsmnt+0x10/0x10
>   ? __kasan_kmalloc+0x7f/0x90
>   seq_read_iter+0x57a/0x740
>   vfs_read+0x2e2/0x4a0
>   ? __pfx_vfs_read+0x10/0x10
>   ? down_write_killable+0xb8/0x140
>   ? __pfx_down_write_killable+0x10/0x10
>   ? __fget_light+0xa9/0x1e0
>   ? up_write+0x3f/0x80
>   ksys_read+0xb8/0x150
>   ? __pfx_ksys_read+0x10/0x10
>   ? fpregs_assert_state_consistent+0x55/0x60
>   ? exit_to_user_mode_prepare+0x2d/0x120
>   do_syscall_64+0x3c/0x90
>   entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
>   </TASK>
> 

Maybe drop the unreliable stack, not mandatory, the patch is look good 
to me,

[snip]

> 
> To fix the bug, shmem_get_sbmpol() / mpol_put() needs to be called
> before / after shmem_show_mpol() call.
> 
> Signed-off-by: Tu Jinjiang <tujinjiang@huawei.com>

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

> ---
>   mm/shmem.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index e40a08c5c6d7..5e54ab5f61f2 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3726,6 +3726,7 @@ static int shmem_reconfigure(struct fs_context *fc)
>   static int shmem_show_options(struct seq_file *seq, struct dentry *root)
>   {
>   	struct shmem_sb_info *sbinfo = SHMEM_SB(root->d_sb);
> +	struct mempolicy *mpol;
>   
>   	if (sbinfo->max_blocks != shmem_default_max_blocks())
>   		seq_printf(seq, ",size=%luk",
> @@ -3768,7 +3769,9 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
>   	if (sbinfo->huge)
>   		seq_printf(seq, ",huge=%s", shmem_format_huge(sbinfo->huge));
>   #endif
> -	shmem_show_mpol(seq, sbinfo->mpol);
> +	mpol = shmem_get_sbmpol(sbinfo);
> +	shmem_show_mpol(seq, mpol);
> +	mpol_put(mpol);
>   	if (sbinfo->noswap)
>   		seq_printf(seq, ",noswap");
>   	return 0;
