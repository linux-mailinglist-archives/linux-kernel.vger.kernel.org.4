Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD727358BD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjFSNiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjFSNiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:38:10 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D53E58;
        Mon, 19 Jun 2023 06:38:09 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ql9lH1KhczLmqY;
        Mon, 19 Jun 2023 21:36:11 +0800 (CST)
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 19 Jun 2023 21:38:06 +0800
Message-ID: <3544fa2b-ce22-c2fa-ad22-77d3a897d53a@huawei.com>
Date:   Mon, 19 Jun 2023 21:38:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 5.10] tracing: Add
 tracing_reset_all_online_cpus_unlocked() function
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20230615204931.3250659-1-zhengyejian1@huawei.com>
 <2023061913-dosage-repacking-678e@gregkh>
Content-Language: en-US
From:   Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <2023061913-dosage-repacking-678e@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.218]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/19 16:26, Greg KH wrote:
> On Fri, Jun 16, 2023 at 04:49:31AM +0800, Zheng Yejian wrote:
>> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>>
>> commit e18eb8783ec4949adebc7d7b0fdb65f65bfeefd9 upstream.
>>
>> Currently the tracing_reset_all_online_cpus() requires the
>> trace_types_lock held. But only one caller of this function actually has
>> that lock held before calling it, and the other just takes the lock so
>> that it can call it. More users of this function is needed where the lock
>> is not held.
>>
>> Add a tracing_reset_all_online_cpus_unlocked() function for the one use
>> case that calls it without being held, and also add a lockdep_assert to
>> make sure it is held when called.
>>
>> Then have tracing_reset_all_online_cpus() take the lock internally, such
>> that callers do not need to worry about taking it.
>>
>> Link: https://lkml.kernel.org/r/20221123192741.658273220@goodmis.org
>>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Zheng Yejian <zhengyejian1@huawei.com>
>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>> [this patch is pre-depended by be111ebd8868d4b7c041cb3c6102e1ae27d6dc1d
>> due to tracing_reset_all_online_cpus() should be called after taking lock]
>> Fixes: be111ebd8868 ("tracing: Free buffers when a used dynamic event is removed")
>> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
>> ---
> 
> 
> What about for 5.15.y?  You can't apply a fix to just an older tree as
> you will then have a regression when you update.
> 
> I'll drop this one from my queue, please resend a backport for all
> relevent stable releases.

Hi, greg,

I have resend the patch to relevent stable releases:
5.15.y: 
https://lore.kernel.org/all/20230620013052.1127047-1-zhengyejian1@huawei.com/
5.10.y: 
https://lore.kernel.org/all/20230620013104.1127100-1-zhengyejian1@huawei.com/
5.4.y: 
https://lore.kernel.org/all/20230620013113.1127152-1-zhengyejian1@huawei.com/

---

Thanks,
Zheng Yejian

> 
> thanks,
> 
> greg k-h

