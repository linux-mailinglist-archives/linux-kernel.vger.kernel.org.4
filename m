Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E9F6688F5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 02:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240216AbjAMBPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 20:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjAMBPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 20:15:23 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74F1271A5;
        Thu, 12 Jan 2023 17:15:21 -0800 (PST)
Received: from kwepemm600010.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NtNjM716gzJrJT;
        Fri, 13 Jan 2023 09:13:59 +0800 (CST)
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 13 Jan 2023 09:15:18 +0800
Subject: Re: [PATCH 4/8] ftrace: Add DYNAMIC_FTRACE_WITH_CALL_OPS
To:     Mark Rutland <mark.rutland@arm.com>
CC:     <catalin.marinas@arm.com>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mhiramat@kernel.org>, <ndesaulniers@google.com>,
        <ojeda@kernel.org>, <peterz@infradead.org>,
        <rafael.j.wysocki@intel.com>, <revest@chromium.org>,
        <robert.moore@intel.com>, <rostedt@goodmis.org>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230109135828.879136-1-mark.rutland@arm.com>
 <20230109135828.879136-5-mark.rutland@arm.com>
 <ec65815e-a8c9-470a-ff89-41626c94df28@huawei.com>
 <Y7/oUy2fIOoq1yFC@FVFF77S0Q05N>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <95f421a3-383f-5d05-adaf-3d8188ae3a36@huawei.com>
Date:   Fri, 13 Jan 2023 09:15:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <Y7/oUy2fIOoq1yFC@FVFF77S0Q05N>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.237]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/1/12 19:00, Mark Rutland wrote:
> On Thu, Jan 12, 2023 at 02:48:45PM +0800, Li Huafei wrote:
>> On 2023/1/9 21:58, Mark Rutland wrote:
>>
>>> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
>>> index 99f1146614c04..5eeb2776124c5 100644
>>> --- a/include/linux/ftrace.h
>>> +++ b/include/linux/ftrace.h
>>> @@ -57,6 +57,9 @@ void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip);
>>>  void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
>>>  			       struct ftrace_ops *op, struct ftrace_regs *fregs);
>>>  #endif
>>> +extern const struct ftrace_ops ftrace_nop_ops;
>>> +extern const struct ftrace_ops ftrace_list_ops;
>>> +struct ftrace_ops *ftrace_find_unique_ops(struct dyn_ftrace *rec);
>>
>> Hi Mark,
> 
> Hi Huafei,
> 
> Thanks for the reporrt.
> 
>> This patch has build issues on x86:
>>
>>     CC      mm/readahead.o
>>   In file included from include/linux/perf_event.h:52:0,
>>                    from arch/x86/events/amd/lbr.c:2:
>>   include/linux/ftrace.h:62:50: error: ‘struct dyn_ftrace’ declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>>    struct ftrace_ops *ftrace_find_unique_ops(struct dyn_ftrace *rec);
>>
>> Here we should need 'struct dyn_ftrace' forward declaration.
> 
> The build robot spotted this a couple of days ago (from my branch rather than
> the list), and I fixed it there a couple of days ago. The relevant messages were:
> 
>   https://lore.kernel.org/oe-kbuild-all/202301100944.E0mV3kSO-lkp@intel.com/
>   https://lore.kernel.org/oe-kbuild-all/Y72TJ3qQuvx3gIOi@FVFF77S0Q05N/#t
> 
> ... and the updated commit is at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=arm64/ftrace/per-callsite-ops&id=acab29d6ea2f20d8d156cdd301ad9790bd1d888f
> 

Okay, you've fixed it. Thanks for pointing out.

> 
> ... I'll post a v2 with that folded in once this has had a bit more time to gather comments.
> 
> Thanks,	
> Mark.
> 
> .
> 
