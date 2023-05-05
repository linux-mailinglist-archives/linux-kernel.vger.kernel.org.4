Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D317B6F7DA7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjEEHTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjEEHTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:19:06 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54CC17DFA
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 00:18:37 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-24df758db1cso1016054a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 00:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683271117; x=1685863117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGBat/CgRbSnTAh4bkNae0IKQQw8RA2H99O/HWbocVk=;
        b=YobhmHEqJpKwlGuxR+PdlcNg4pNFd/71XZGwRAh9iNQ16sBw3sPcCs2uhlb5Cioqjy
         bilwQ0r9fNFkGWIZ0vyS3G2QRcXQCRUbzws0lxBvDlmkZs4A51dFYMdxZXpZ6c0V0ZBf
         6ZhNLxFBuuwBny4YWzKXcRwL020Wv/mzJblp13ATG0sv9HzRbZxkd+Kc4T/lXwz5gwkX
         bUfuvg/lJIXKbOfxzel1+ZvWNTCuBB3SiuNfzql8CZa8jg0OTS+baB/l2rCTNk8jKO2r
         G2waFgQkbtNOkphgRKa3y7P+AjpJc1L1/wHnOzBmtPUZvNKlrkYrv6J75oDWbRU3RdQb
         tA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683271117; x=1685863117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MGBat/CgRbSnTAh4bkNae0IKQQw8RA2H99O/HWbocVk=;
        b=CDYUPL5TgKcNRjgmnkOZmn7qmFUFHe/FwDJnr6PYG4Yzmv3y7BdafkhD/0A5HwXkwf
         CfKKJSbr7j5gwSg9ssVpNQYJlEw1GuT5zsG2aY/5iD3tAlsrNR9fj1jtk7ANV9s1i7GG
         YZ+Z9hUWx2dDXWEUZzEvc7jVgFQQQAwE+3+2VX3O0xgvoGNIZOdiyvnC2zC4SajfgGTE
         bPeC+y/QplpXyRn6RuIkshlqE3to0awADprXbaIcV60ah841GE8gGcMIQljHDK6Wk9q7
         4uzg0d6i9tuUD1+JhyzIR51wZEL2THsIpSCZXI8+r20AcJV9ATNL2IrimLXvE9l/TNqd
         Jy2Q==
X-Gm-Message-State: AC+VfDztgnfOhSkP+0z8dOxIUp6e6ok1TFW+H4p6Oj/BaVmETcUVPlyU
        dJ96PjtLPH+V1UXuzPQvYjZ93A==
X-Google-Smtp-Source: ACHHUZ52pnllrRP8Kq0YP+n9IlYjk1yMj/IbEylG/jfXnVmVZOclgacQlNorsB22JL0FxY6OadbMYA==
X-Received: by 2002:a17:902:f547:b0:1a6:45e5:a26a with SMTP id h7-20020a170902f54700b001a645e5a26amr792709plf.27.1683271117016;
        Fri, 05 May 2023 00:18:37 -0700 (PDT)
Received: from [10.71.57.173] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id z12-20020a170903018c00b001aae64e9b36sm935313plg.114.2023.05.05.00.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 00:18:36 -0700 (PDT)
Message-ID: <f7a85b88-aa8c-a26a-8ccb-a20c62a76faa@bytedance.com>
Date:   Fri, 5 May 2023 15:18:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: Re: [PATCH bpf-next v6 1/2] bpf: Add bpf_task_under_cgroup()
 kfunc
To:     Hao Luo <haoluo@google.com>
Cc:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com,
        shuah@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, yangzhenze@bytedance.com,
        wangdongdong.6@bytedance.com
References: <20230505060818.60037-1-zhoufeng.zf@bytedance.com>
 <20230505060818.60037-2-zhoufeng.zf@bytedance.com>
 <CA+khW7g_gq1N=cNHC-5WG2nZ8a-wHSpwg_fc5=dQpkweGvROqA@mail.gmail.com>
From:   Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <CA+khW7g_gq1N=cNHC-5WG2nZ8a-wHSpwg_fc5=dQpkweGvROqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/5/5 14:58, Hao Luo 写道:
> On Thu, May 4, 2023 at 11:08 PM Feng zhou <zhoufeng.zf@bytedance.com> wrote:
>>
> <...>
>> ---
>>   kernel/bpf/helpers.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index bb6b4637ebf2..453cbd312366 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2149,6 +2149,25 @@ __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 cgid)
>>                  return NULL;
>>          return cgrp;
>>   }
>> +
>> +/**
>> + * bpf_task_under_cgroup - wrap task_under_cgroup_hierarchy() as a kfunc, test
>> + * task's membership of cgroup ancestry.
>> + * @task: the task to be tested
>> + * @ancestor: possible ancestor of @task's cgroup
>> + *
>> + * Tests whether @task's default cgroup hierarchy is a descendant of @ancestor.
>> + * It follows all the same rules as cgroup_is_descendant, and only applies
>> + * to the default hierarchy.
>> + */
>> +__bpf_kfunc long bpf_task_under_cgroup(struct task_struct *task,
>> +                                      struct cgroup *ancestor)
>> +{
>> +       if (unlikely(!ancestor || !task))
>> +               return -EINVAL;
>> +
>> +       return task_under_cgroup_hierarchy(task, ancestor);
>> +}
>>   #endif /* CONFIG_CGROUPS */
>>
> 
> I wonder in what situation a null 'task' or 'ancestor' can be passed.
> Please call out in the comment that the returned value can be a
> negative error, so that writing if(bpf_task_under_cgroup()) may cause
> surprising results.
> 
> Hao

Hmm, you are right. As kfunc, the NULL value of the parameter is judged, 
and bpf verify will prompt the developer to add it. There is really no 
need to add this part of the judgment. See other people's opinions.


