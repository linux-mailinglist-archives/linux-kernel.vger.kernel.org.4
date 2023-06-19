Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96C0734BCE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjFSGko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjFSGkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:40:42 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA42102
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 23:40:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VlQ13kY_1687156836;
Received: from 30.97.48.59(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VlQ13kY_1687156836)
          by smtp.aliyun-inc.com;
          Mon, 19 Jun 2023 14:40:37 +0800
Message-ID: <ec37f55a-181b-a035-8b71-3cde3cb8cc66@linux.alibaba.com>
Date:   Mon, 19 Jun 2023 14:40:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] mm: Fix shmem THP counters on migration
To:     Jan Glauber <jglauber@digitalocean.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230619055735.141740-1-jglauber@digitalocean.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230619055735.141740-1-jglauber@digitalocean.com>
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



On 6/19/2023 1:57 PM, Jan Glauber wrote:
> The per node numa_stat values for shmem don't change on
> page migration for THP:
> 
>    grep shmem /sys/fs/cgroup/machine.slice/.../memory.numa_stat:
> 
>      shmem N0=1092616192 N1=10485760
>      shmem_thp N0=1092616192 N1=10485760
> 
>    migratepages 9181 0 1:
> 
>      shmem N0=0 N1=1103101952
>      shmem_thp N0=1092616192 N1=10485760
> 
> Fix that by updating shmem_thp counters likewise to shmem counters
> on page migration.
> 
> Signed-off-by: Jan Glauber <jglauber@digitalocean.com>
> ---
>   mm/migrate.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 01cac26a3127..d2ba786ea105 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -492,6 +492,11 @@ int folio_migrate_mapping(struct address_space *mapping,
>   		if (folio_test_swapbacked(folio) && !folio_test_swapcache(folio)) {
>   			__mod_lruvec_state(old_lruvec, NR_SHMEM, -nr);
>   			__mod_lruvec_state(new_lruvec, NR_SHMEM, nr);
> +
> +			if (folio_test_transhuge(folio)) {
> +				__mod_lruvec_state(old_lruvec, NR_SHMEM_THP, -nr);
> +				__mod_lruvec_state(new_lruvec, NR_SHMEM_THP, nr);

Should be NR_SHMEM_THPS.
