Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A409749B50
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjGFMCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjGFMCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:02:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111FB19A0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 05:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688644907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dl3R31sG5o/qvveXTrvTvakzx+epZY7EL41Ub8ppMOk=;
        b=KVqyJKDFaKvm6j4XN+VpGYnNBzpuldbizTwYyfBhWOVBvCP6Y3DxrN3ePDd3WJ0rVpwVhu
        AfVS9zYlvr9gSVTSqiObyPNkjjMj63bkLK4FU7PKI5+R8X3+f47/bWOvPiqORzTpIEyzfy
        lFm6MUKV/7Kk0VQBon0IQW/Dqb1xFMQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-pLMvdz4SOBGD04mbxu2_8Q-1; Thu, 06 Jul 2023 08:01:43 -0400
X-MC-Unique: pLMvdz4SOBGD04mbxu2_8Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30e4943ca7fso291580f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 05:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688644902; x=1691236902;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dl3R31sG5o/qvveXTrvTvakzx+epZY7EL41Ub8ppMOk=;
        b=CkdBzWrMWqomfyAN0G0Vc1qGYUhaPc06dqVP1Pmtrko2LhhRnCJj5Xi0tc0Bqlf7A1
         WMybsei+B/NWcgJKlJDEDWobSqlwqTNKqlLIxQBkmg2+n2JPMq8LGp34I6V/MHQ5WLxa
         COMQnh2A/ubjlnB9ZN7EROyRbkqniA12+WanBboHyC6AnPwkHEZ7B4L2fTtPZZgh6mwy
         6q3BNr6s94kkq2EAw9nwlPBeRK4Tys0qoPEKv+YxqKd0458Ww2Wcy4R/A3D61tckRzLz
         ETOvAhjfs21i6MUSIJvEMXm41Jk0qxm4GSF+Ozw1zrMFaVE16CY+3BOmDVRv7YqFwzag
         nyXA==
X-Gm-Message-State: ABy/qLYjtTIXuZrCq5E3XBzoMFX9Laannj0dV6zNQHM+OCUVleKgwbEV
        AoJ2eecA57YDYWKmU7tT4Ot8XyIUFeVEdEDLnmFvVYL0ks+z9O27FKs/u7Cm5liVlNeK36bCBsm
        TrEr6RX+aujOFZuzxhCGjIq7n
X-Received: by 2002:adf:f286:0:b0:313:fd26:6fea with SMTP id k6-20020adff286000000b00313fd266feamr1327918wro.39.1688644902394;
        Thu, 06 Jul 2023 05:01:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE31M+FUJfq8JTtI3k5875XjLwapH1JoB6LWZXwQY8KfCzpowxsoaGORlSLUIj6iYqrAUkb3Q==
X-Received: by 2002:adf:f286:0:b0:313:fd26:6fea with SMTP id k6-20020adff286000000b00313fd266feamr1327897wro.39.1688644901987;
        Thu, 06 Jul 2023 05:01:41 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id q24-20020a056000137800b00314172ba213sm1688337wrz.108.2023.07.06.05.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 05:01:41 -0700 (PDT)
Message-ID: <e5296d91-f734-fc2a-4b96-1fd2eebcbca5@redhat.com>
Date:   Thu, 6 Jul 2023 14:01:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm/ksm: prepare to remove the redundant ksm_merging_pages
 in procfs
Content-Language: en-US
To:     Nanyong Sun <sunnanyong@huawei.com>, akpm@linux-foundation.org
Cc:     xu.xin16@zte.com.cn, wangkefeng.wang@huawei.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230706094917.588213-1-sunnanyong@huawei.com>
 <492be1c2-9078-1923-51f9-e01156455ea1@redhat.com>
 <848fb72a-60a3-bf1d-a091-c25090175eb7@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <848fb72a-60a3-bf1d-a091-c25090175eb7@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.07.23 13:59, Nanyong Sun wrote:
> On 2023/7/6 16:55, David Hildenbrand wrote:
> 
>> On 06.07.23 11:49, Nanyong Sun wrote:
>>> Since the ksm_merging_pages information already included in
>>> /proc/<pid>/ksm_stat, we could remove /proc/<pid>/ksm_merging_pages
>>> to make the directory more clean, and can save a little bit resources.
>>>
>>> To delete this interface more smoothly and avoid userspace break,
>>> retain this interface temporarily and modify its function to hint
>>> users to use ksm_stat instead.
>>>
>>> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
>>> ---
>>>    fs/proc/base.c | 9 +--------
>>>    1 file changed, 1 insertion(+), 8 deletions(-)
>>>
>>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>>> index eb2e498e3b8d..d080c58cbe6c 100644
>>> --- a/fs/proc/base.c
>>> +++ b/fs/proc/base.c
>>> @@ -3189,14 +3189,7 @@ static int proc_pid_patch_state(struct
>>> seq_file *m, struct pid_namespace *ns,
>>>    static int proc_pid_ksm_merging_pages(struct seq_file *m, struct
>>> pid_namespace *ns,
>>>                    struct pid *pid, struct task_struct *task)
>>>    {
>>> -    struct mm_struct *mm;
>>> -
>>> -    mm = get_task_mm(task);
>>> -    if (mm) {
>>> -        seq_printf(m, "%lu\n", mm->ksm_merging_pages);
>>> -        mmput(mm);
>>> -    }
>>> -
>>> +    seq_puts(m, "please use /proc/<pid>/ksm_stat instead\n");
>>>        return 0;
>>>    }
>>>    static int proc_pid_ksm_stat(struct seq_file *m, struct
>>> pid_namespace *ns,
>>
>>
>> Why do we care so much about removing 15 simple LOC? That change here
>> will already mess with user space.
>>
>> Sorry, but IMHO it's all not worth the churn.
>>
> We do not pay attention to these 15 LOC. We pay more attention to the
> redundant interface under procfs.
> 
> This interface is used by developers and has a short history. Therefore,
> changing it now has no big impact.
> 

Again, already 1 year old. And returning garbage instead of ripping it 
out might be even nastier.

-- 
Cheers,

David / dhildenb

