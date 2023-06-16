Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8441732896
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbjFPHQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjFPHQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:16:05 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BBE171F;
        Fri, 16 Jun 2023 00:16:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VlEyKMk_1686899756;
Received: from 30.240.112.107(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VlEyKMk_1686899756)
          by smtp.aliyun-inc.com;
          Fri, 16 Jun 2023 15:15:58 +0800
Message-ID: <a2b16cca-5449-1d16-f49c-7b83fb45771c@linux.alibaba.com>
Date:   Fri, 16 Jun 2023 15:15:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [RESEND PATCH v7 0/2] ACPI: APEI: handle synchronous exceptions
 with proper si_code
Content-Language: en-US
To:     rafael@kernel.org, wangkefeng.wang@huawei.com,
        tanxiaofei@huawei.com, mawupeng1@huawei.com, tony.luck@intel.com,
        naoya.horiguchi@nec.com
Cc:     linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, justin.he@arm.com,
        akpm@linux-foundation.org, ardb@kernel.org, ashish.kalra@amd.com,
        baolin.wang@linux.alibaba.com, bp@alien8.de,
        cuibixuan@linux.alibaba.com, dave.hansen@linux.intel.com,
        james.morse@arm.com, jarkko@kernel.org, lenb@kernel.org,
        linmiaohe@huawei.com, lvying6@huawei.com, xiexiuqi@huawei.com,
        zhuo.song@linux.alibaba.com
References: <20230606074238.97166-1-xueshuai@linux.alibaba.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20230606074238.97166-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
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



On 2023/6/6 15:42, Shuai Xue wrote:
> changes since v6:
> - add more explicty error message suggested by Xiaofei
> - pick up reviewed-by tag from Xiaofei
> - pick up internal reviewed-by tag from Baolin
> 
> changes since v5 by addressing comments from Kefeng:
> - document return value of memory_failure()
> - drop redundant comments in call site of memory_failure() 
> - make ghes_do_proc void and handle abnormal case within it
> - pick up reviewed-by tag from Kefeng Wang 
> 
> changes since v4 by addressing comments from Xiaofei:
> - do a force kill only for abnormal sync errors
> 
> changes since v3 by addressing comments from Xiaofei:
> - do a force kill for abnormal memory failure error such as invalid PA,
> unexpected severity, OOM, etc
> - pcik up tested-by tag from Ma Wupeng
> 
> changes since v2 by addressing comments from Naoya:
> - rename mce_task_work to sync_task_work
> - drop ACPI_HEST_NOTIFY_MCE case in is_hest_sync_notify()
> - add steps to reproduce this problem in cover letter
> 
> changes since v1:
> - synchronous events by notify type
> - Link: https://lore.kernel.org/lkml/20221206153354.92394-3-xueshuai@linux.alibaba.com/
> 
> 
> Shuai Xue (2):
>   ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on
>     synchronous events
>   ACPI: APEI: handle synchronous exceptions in task work
> 
>  arch/x86/kernel/cpu/mce/core.c |   9 +--
>  drivers/acpi/apei/ghes.c       | 113 ++++++++++++++++++++++-----------
>  include/acpi/ghes.h            |   3 -
>  mm/memory-failure.c            |  17 +----
>  4 files changed, 79 insertions(+), 63 deletions(-)
> 


Hi, Rafael,

Gentle ping.

Are you happy to queue this patch set or anything I can do to improve it?
As @Kefeng said, this issue is met in Alibaba and Huawei products, we hope it
could be fixed ASAP.

Thank you.

Best Regards,
Shuai
