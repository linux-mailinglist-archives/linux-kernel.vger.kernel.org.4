Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4D2623BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiKJGYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbiKJGXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:23:50 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B30F2B1AB;
        Wed,  9 Nov 2022 22:23:49 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N7Bc60S6Bz15MSy;
        Thu, 10 Nov 2022 14:23:34 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 14:23:46 +0800
Message-ID: <80252c82-9c34-aefe-8422-fa247092dcec@huawei.com>
Date:   Thu, 10 Nov 2022 14:23:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v3] bpf: Initialize same number of free nodes for
 each pcpu_freelist
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20221110035039.54859-1-xukuohai@huawei.com>
 <CAEf4BzYMExNVP353xUmkD=M7_QKDG8Ukm0T7D9aCZG=-GToiaA@mail.gmail.com>
From:   Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <CAEf4BzYMExNVP353xUmkD=M7_QKDG8Ukm0T7D9aCZG=-GToiaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 12:05 PM, Andrii Nakryiko wrote:
> On Wed, Nov 9, 2022 at 7:33 PM Xu Kuohai <xukuohai@huawei.com> wrote:
>>
>> pcpu_freelist_populate() initializes nr_elems / num_possible_cpus() + 1
>> free nodes for some CPUs, and then possibly one CPU with fewer nodes,
>> followed by remaining cpus with 0 nodes. For example, when nr_elems == 256
>> and num_possible_cpus() == 32, CPU 0~27 each gets 9 free nodes, CPU 28 gets
>> 4 free nodes, CPU 29~31 get 0 free nodes, while in fact each CPU should get
>> 8 nodes equally.
>>
>> This patch initializes nr_elems / num_possible_cpus() free nodes for each
>> CPU firstly, then allocates the remaining free nodes by one for each CPU
>> until no free nodes left.
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> Acked-by: Yonghong Song <yhs@fb.com>
>> ---
>> v3: Simplify code as suggested by Andrii
>> v2: Update commit message and add Yonghong's ack
>> ---
>>   kernel/bpf/percpu_freelist.c | 27 ++++++++++++++-------------
>>   1 file changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
>> index b6e7f5c5b9ab..bd60070c079f 100644
>> --- a/kernel/bpf/percpu_freelist.c
>> +++ b/kernel/bpf/percpu_freelist.c
>> @@ -100,22 +100,23 @@ void pcpu_freelist_populate(struct pcpu_freelist *s, void *buf, u32 elem_size,
>>                              u32 nr_elems)
>>   {
>>          struct pcpu_freelist_head *head;
>> -       int i, cpu, pcpu_entries;
>> +       unsigned int cpu, cpu_idx, i, j, n, m;
>>
>> -       pcpu_entries = nr_elems / num_possible_cpus() + 1;
>> -       i = 0;
>> +       n = nr_elems / num_possible_cpus();
>> +       m = nr_elems % num_possible_cpus();
>> +
>> +       cpu_idx = 0;
>>
>>          for_each_possible_cpu(cpu) {
>> -again:
>> -               head = per_cpu_ptr(s->freelist, cpu);
>> -               /* No locking required as this is not visible yet. */
>> -               pcpu_freelist_push_node(head, buf);
>> -               i++;
>> -               buf += elem_size;
>> -               if (i == nr_elems)
>> -                       break;
>> -               if (i % pcpu_entries)
>> -                       goto again;
>> +               j = min(n + (cpu_idx < m ? 1 : 0), nr_elems);
> 
> why the min() here?
> 

to avoid out-of-bounds in case nr_elems is less than the total number of CPUs,
seems not very necessary, but the original code avoids this as well, I just kept
the logic

>> +               for (i = 0; i < j; i++) {
>> +                       head = per_cpu_ptr(s->freelist, cpu);
>> +                       /* No locking required as this is not visible yet. */
>> +                       pcpu_freelist_push_node(head, buf);
>> +                       buf += elem_size;
>> +               }
>> +               nr_elems -= j;
>> +               cpu_idx++;
>>          }
>>   }
>>
>> --
>> 2.30.2
>>
> .

