Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7B7737B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjFUGs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjFUGsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:48:24 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF232703
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:46:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VletMLc_1687329983;
Received: from 30.97.48.59(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VletMLc_1687329983)
          by smtp.aliyun-inc.com;
          Wed, 21 Jun 2023 14:46:24 +0800
Message-ID: <3b05b046-9d0e-c9a4-5d3d-62b815ca020d@linux.alibaba.com>
Date:   Wed, 21 Jun 2023 14:46:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] mm: Fix shmem THP counters on migration
To:     Jan Glauber <jglauber@digitalocean.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Huang, Ying" <ying.huang@intel.com>
References: <20230619054955.140276-1-jglauber@digitalocean.com>
 <20230619103351.234837-1-jglauber@digitalocean.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230619103351.234837-1-jglauber@digitalocean.com>
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


Cc: Huang Ying

On 6/19/2023 6:33 PM, Jan Glauber wrote:
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

Please add your change history.

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

I am afraid this validation is fragile, IIUC the file backed folio can 
contain various numbers of pages in future.

So seems using folio_test_pmd_mappable() seems more suitable for THP.

> +				__mod_lruvec_state(old_lruvec, NR_SHMEM_THPS, -nr);
> +				__mod_lruvec_state(new_lruvec, NR_SHMEM_THPS, nr);
> +			}
>   		}
>   #ifdef CONFIG_SWAP
>   		if (folio_test_swapcache(folio)) {
> --
> 2.25.1
> 
