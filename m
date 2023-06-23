Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2B073AE79
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 04:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjFWCHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 22:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFWCHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 22:07:17 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA06B2122
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 19:07:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VlkdzUw_1687486029;
Received: from 192.168.0.106(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VlkdzUw_1687486029)
          by smtp.aliyun-inc.com;
          Fri, 23 Jun 2023 10:07:10 +0800
Message-ID: <9ff605a5-a989-01f2-e629-e52bb50201a7@linux.alibaba.com>
Date:   Fri, 23 Jun 2023 10:07:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3] mm: Fix shmem THP counters on migration
To:     Jan Glauber <jglauber@digitalocean.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Huang, Ying" <ying.huang@intel.com>
References: <20230622094720.510540-1-jglauber@digitalocean.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230622094720.510540-1-jglauber@digitalocean.com>
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



On 6/22/2023 5:47 PM, Jan Glauber wrote:
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

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
> v3: Use folio_test_pmd_mappable instead of folio_test_transhuge
> v2: Fix compile error
> ---
>   mm/migrate.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 01cac26a3127..6ef8b1dea2e6 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -492,6 +492,11 @@ int folio_migrate_mapping(struct address_space *mapping,
>   		if (folio_test_swapbacked(folio) && !folio_test_swapcache(folio)) {
>   			__mod_lruvec_state(old_lruvec, NR_SHMEM, -nr);
>   			__mod_lruvec_state(new_lruvec, NR_SHMEM, nr);
> +
> +			if (folio_test_pmd_mappable(folio)) {
> +				__mod_lruvec_state(old_lruvec, NR_SHMEM_THPS, -nr);
> +				__mod_lruvec_state(new_lruvec, NR_SHMEM_THPS, nr);
> +			}
>   		}
>   #ifdef CONFIG_SWAP
>   		if (folio_test_swapcache(folio)) {
