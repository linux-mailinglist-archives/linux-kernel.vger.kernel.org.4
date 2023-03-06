Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1172F6AB3E0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 01:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjCFAps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 19:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCFApq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 19:45:46 -0500
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D591117A;
        Sun,  5 Mar 2023 16:45:44 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Vd7aT1x_1678063540;
Received: from 30.240.112.112(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vd7aT1x_1678063540)
          by smtp.aliyun-inc.com;
          Mon, 06 Mar 2023 08:45:41 +0800
Message-ID: <73f5261d-e170-ab27-cb4c-fc15bfd4c613@linux.alibaba.com>
Date:   Mon, 6 Mar 2023 08:45:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/2] ACPI: APEI: handle synchronous exceptions with
 proper si_code
To:     rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
        jarkko@kernel.org, naoya.horiguchi@nec.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org
Cc:     xiexiuqi@huawei.com, lvying6@huawei.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        cuibixuan@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20230227050315.5670-1-xueshuai@linux.alibaba.com>
Content-Language: en-US
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20230227050315.5670-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping.

On 2023/2/27 PM1:03, Shuai Xue wrote:
> changes since v1:
> - synchronous events by notify type
> - Link: https://lore.kernel.org/lkml/20221206153354.92394-3-xueshuai@linux.alibaba.com/
> 
> Currently, both synchronous and asynchronous error are queued and handled
> by a dedicated kthread in workqueue. And Memory failure for synchronous
> error is synced by a cancel_work_sync trick which ensures that the
> corrupted page is unmapped and poisoned. And after returning to user-space,
> the task starts at current instruction which triggering a page fault in
> which kernel will send SIGBUS to current process due to VM_FAULT_HWPOISON.
> 
> However, the memory failure recovery for hwpoison-aware mechanisms does not
> work as expected. For example, hwpoison-aware user-space processes like
> QEMU register their customized SIGBUS handler and enable early kill mode by
> seting PF_MCE_EARLY at initialization. Then the kernel will directy notify
> the process by sending a SIGBUS signal in memory failure with wrong
> si_code: BUS_MCEERR_AO si_code to the actual user-space process instead of
> BUS_MCEERR_AR.
> 
> To address this problem:
> 
> - PATCH 1 sets mf_flags as MF_ACTION_REQUIRED on synchronous events which
>   indicates error happened in current execution context
> - PATCH 2 separates synchronous error handling into task work so that the
>   current context in memory failure is exactly belongs to the task
>   consuming poison data.
> 
> Then, kernel will send SIGBUS with proper si_code in kill_proc().
> 
> Lv Ying and XiuQi also proposed to address similar problem and we discussed
> about new solution to add a new flag(acpi_hest_generic_data::flags bit 8) to
> distinguish synchronous event. [2][3] The UEFI community still has no response.
> After a deep dive into the SDEI TRM, the SDEI notification should be used for
> asynchronous error. As SDEI TRM[1] describes "the dispatcher can simulate an
> exception-like entry into the client, **with the client providing an additional
> asynchronous entry point similar to an interrupt entry point**". The client
> (kernel) lacks complete synchronous context, e.g. systeam register (ELR, ESR,
> etc). So notify type is enough to distinguish synchronous event.
> 
> [1] https://developer.arm.com/documentation/den0054/latest/
> [2] https://lore.kernel.org/linux-arm-kernel/20221205160043.57465-4-xiexiuqi@huawei.com/T/
> [3] https://lore.kernel.org/lkml/20221209095407.383211-1-lvying6@huawei.com/
> 
> Shuai Xue (2):
>   ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on
>     synchronous events
>   ACPI: APEI: handle synchronous exceptions in task work
> 
>  drivers/acpi/apei/ghes.c | 134 ++++++++++++++++++++++++---------------
>  include/acpi/ghes.h      |   3 -
>  mm/memory-failure.c      |  13 ----
>  3 files changed, 82 insertions(+), 68 deletions(-)
> 
