Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DF97395B7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjFVDIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjFVDH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:07:59 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636191BD0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 20:07:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VlhrUFi_1687403269;
Received: from 192.168.2.5(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VlhrUFi_1687403269)
          by smtp.aliyun-inc.com;
          Thu, 22 Jun 2023 11:07:50 +0800
Message-ID: <ce8a0526-be2d-7e80-7423-23c7c201d912@linux.alibaba.com>
Date:   Thu, 22 Jun 2023 11:07:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v1] erofs: Fix detection of atomic context
To:     Sandeep Dhavale <dhavale@google.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Will Shiu <Will.Shiu@mediatek.com>, kernel-team@android.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230621220848.3379029-1-dhavale@google.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230621220848.3379029-1-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/22 06:08, Sandeep Dhavale wrote:
> Current check for atomic context is not sufficient as
> z_erofs_decompressqueue_endio can be called under rcu lock
> from blk_mq_flush_plug_list(). See the stacktrace [1]
> 
> In such case we should hand off the decompression work for async
> processing rather than trying to do sync decompression in current
> context. Patch fixes the detection by checking for
> rcu_read_lock_any_held() and while at it use more appropriate
> !in_task() check than in_atomic().
> 
> Background: Historically erofs would always schedule a kworker for
> decompression which would incur the scheduling cost regardless of
> the context. But z_erofs_decompressqueue_endio() may not always
> be in atomic context and we could actually benefit from doing the
> decompression in z_erofs_decompressqueue_endio() if we are in
> thread context, for example when running with dm-verity.
> This optimization was later added in patch [2] which has shown
> improvement in performance benchmarks.
> 
> ==============================================
> [1] Problem stacktrace
> [name:core&]BUG: sleeping function called from invalid context at kernel/locking/mutex.c:291
> [name:core&]in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1615, name: CpuMonitorServi
> [name:core&]preempt_count: 0, expected: 0
> [name:core&]RCU nest depth: 1, expected: 0
> CPU: 7 PID: 1615 Comm: CpuMonitorServi Tainted: G S      W  OE      6.1.25-android14-5-maybe-dirty-mainline #1
> Hardware name: MT6897 (DT)
> Call trace:
>   dump_backtrace+0x108/0x15c
>   show_stack+0x20/0x30
>   dump_stack_lvl+0x6c/0x8c
>   dump_stack+0x20/0x48
>   __might_resched+0x1fc/0x308
>   __might_sleep+0x50/0x88
>   mutex_lock+0x2c/0x110
>   z_erofs_decompress_queue+0x11c/0xc10
>   z_erofs_decompress_kickoff+0x110/0x1a4
>   z_erofs_decompressqueue_endio+0x154/0x180
>   bio_endio+0x1b0/0x1d8
>   __dm_io_complete+0x22c/0x280
>   clone_endio+0xe4/0x280
>   bio_endio+0x1b0/0x1d8
>   blk_update_request+0x138/0x3a4
>   blk_mq_plug_issue_direct+0xd4/0x19c
>   blk_mq_flush_plug_list+0x2b0/0x354
>   __blk_flush_plug+0x110/0x160
>   blk_finish_plug+0x30/0x4c
>   read_pages+0x2fc/0x370
>   page_cache_ra_unbounded+0xa4/0x23c
>   page_cache_ra_order+0x290/0x320
>   do_sync_mmap_readahead+0x108/0x2c0
>   filemap_fault+0x19c/0x52c
>   __do_fault+0xc4/0x114
>   handle_mm_fault+0x5b4/0x1168
>   do_page_fault+0x338/0x4b4
>   do_translation_fault+0x40/0x60
>   do_mem_abort+0x60/0xc8
>   el0_da+0x4c/0xe0
>   el0t_64_sync_handler+0xd4/0xfc
>   el0t_64_sync+0x1a0/0x1a4
> 
> [2] Link: https://lore.kernel.org/all/20210317035448.13921-1-huangjianan@oppo.com/
> 
> Reported-by: Will Shiu <Will.Shiu@mediatek.com>
> Suggested-by: Gao Xiang <xiang@kernel.org>
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>


It looks good to me,

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
