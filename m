Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0117749B40
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjGFL76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGFL75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:59:57 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7382110F7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 04:59:55 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QxZnm6SQrz1HBZb;
        Thu,  6 Jul 2023 19:59:24 +0800 (CST)
Received: from [10.174.179.79] (10.174.179.79) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 19:59:51 +0800
Subject: Re: [PATCH] mm/ksm: prepare to remove the redundant ksm_merging_pages
 in procfs
To:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>
CC:     <xu.xin16@zte.com.cn>, <wangkefeng.wang@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20230706094917.588213-1-sunnanyong@huawei.com>
 <492be1c2-9078-1923-51f9-e01156455ea1@redhat.com>
From:   Nanyong Sun <sunnanyong@huawei.com>
Message-ID: <848fb72a-60a3-bf1d-a091-c25090175eb7@huawei.com>
Date:   Thu, 6 Jul 2023 19:59:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <492be1c2-9078-1923-51f9-e01156455ea1@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.79]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/6 16:55, David Hildenbrand wrote:

> On 06.07.23 11:49, Nanyong Sun wrote:
>> Since the ksm_merging_pages information already included in
>> /proc/<pid>/ksm_stat, we could remove /proc/<pid>/ksm_merging_pages
>> to make the directory more clean, and can save a little bit resources.
>>
>> To delete this interface more smoothly and avoid userspace break,
>> retain this interface temporarily and modify its function to hint
>> users to use ksm_stat instead.
>>
>> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
>> ---
>>   fs/proc/base.c | 9 +--------
>>   1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> index eb2e498e3b8d..d080c58cbe6c 100644
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -3189,14 +3189,7 @@ static int proc_pid_patch_state(struct 
>> seq_file *m, struct pid_namespace *ns,
>>   static int proc_pid_ksm_merging_pages(struct seq_file *m, struct 
>> pid_namespace *ns,
>>                   struct pid *pid, struct task_struct *task)
>>   {
>> -    struct mm_struct *mm;
>> -
>> -    mm = get_task_mm(task);
>> -    if (mm) {
>> -        seq_printf(m, "%lu\n", mm->ksm_merging_pages);
>> -        mmput(mm);
>> -    }
>> -
>> +    seq_puts(m, "please use /proc/<pid>/ksm_stat instead\n");
>>       return 0;
>>   }
>>   static int proc_pid_ksm_stat(struct seq_file *m, struct 
>> pid_namespace *ns,
>
>
> Why do we care so much about removing 15 simple LOC? That change here 
> will already mess with user space.
>
> Sorry, but IMHO it's all not worth the churn.
>
We do not pay attention to these 15 LOC. We pay more attention to the 
redundant interface under procfs.

This interface is used by developers and has a short history. Therefore, 
changing it now has no big impact.

