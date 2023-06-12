Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276EA72BE5B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjFLKJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239069AbjFLKIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:08:51 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA1F55B2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:49:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VkwjQ3o_1686563395;
Received: from 30.97.48.52(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VkwjQ3o_1686563395)
          by smtp.aliyun-inc.com;
          Mon, 12 Jun 2023 17:49:56 +0800
Message-ID: <3e97e1a2-47e8-9223-426d-5089f8802ae5@linux.alibaba.com>
Date:   Mon, 12 Jun 2023 17:50:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] mm: compaction: mark kcompactd_run() and kcompactd_stop()
 __meminit
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230610034615.997813-1-linmiaohe@huawei.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230610034615.997813-1-linmiaohe@huawei.com>
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



On 6/10/2023 11:46 AM, Miaohe Lin wrote:
> Add __meminit to kcompactd_run() and kcompactd_stop() to ensure they're
> default to __init when memory hotplug is not enabled.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   include/linux/compaction.h | 4 ++--
>   mm/compaction.c            | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> index 57b16e69c19a..e94776496049 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -98,8 +98,8 @@ extern void compaction_defer_reset(struct zone *zone, int order,
>   bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
>   					int alloc_flags);
>   
> -extern void kcompactd_run(int nid);
> -extern void kcompactd_stop(int nid);
> +extern void __meminit kcompactd_run(int nid);
> +extern void __meminit kcompactd_stop(int nid);
>   extern void wakeup_kcompactd(pg_data_t *pgdat, int order, int highest_zoneidx);
>   
>   #else
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 3398ef3a55fe..8859cc91062f 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -3086,7 +3086,7 @@ static int kcompactd(void *p)
>    * This kcompactd start function will be called by init and node-hot-add.
>    * On node-hot-add, kcompactd will moved to proper cpus if cpus are hot-added.
>    */
> -void kcompactd_run(int nid)
> +void __meminit kcompactd_run(int nid)
>   {
>   	pg_data_t *pgdat = NODE_DATA(nid);
>   
> @@ -3104,7 +3104,7 @@ void kcompactd_run(int nid)
>    * Called by memory hotplug when all memory in a node is offlined. Caller must
>    * be holding mem_hotplug_begin/done().
>    */
> -void kcompactd_stop(int nid)
> +void __meminit kcompactd_stop(int nid)
>   {
>   	struct task_struct *kcompactd = NODE_DATA(nid)->kcompactd;
>   
