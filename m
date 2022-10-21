Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EF3606CC3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 03:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiJUBBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 21:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJUBBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 21:01:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A70721CD52
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 18:01:29 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MtmJB0dTKzmV7q;
        Fri, 21 Oct 2022 08:56:42 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 09:01:28 +0800
Received: from [10.174.176.230] (10.174.176.230) by
 kwepemm600008.china.huawei.com (7.193.23.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 09:01:27 +0800
Message-ID: <07232902-0e64-fab5-c60c-570e7004d6c9@huawei.com>
Date:   Fri, 21 Oct 2022 09:01:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH] tools lib traceevent: Fix double free in
 event_read_fields()
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <acme@redhat.com>, <linux-kernel@vger.kernel.org>,
        <namhyung@kernel.org>
References: <20221017085937.8583-1-shangxiaojing@huawei.com>
 <20221020172324.66c6927f@gandalf.local.home>
From:   shangxiaojing <shangxiaojing@huawei.com>
In-Reply-To: <20221020172324.66c6927f@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.230]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/10/21 5:23, Steven Rostedt wrote:
> On Mon, 17 Oct 2022 16:59:37 +0800
> Shang XiaoJing <shangxiaojing@huawei.com> wrote:
> 
>> There is a double free in event_read_fields(). After calling free_token()
>> to free the token, if append() failed, then goto fail, which will call
>> free_token() again. Triggered by compiling with perf and run "perf sched
>> record". Fix the double free by goto fail_expect instead of fail while
>> append() failed, which won't call redundant free_token().
>>
>> BUG: double free
>> free(): double free detected in tcache 2
>> Aborted
>>
>> Fixes: d286447f23cd ("tools lib traceevent: Handle realloc() failure path")
>> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
>> ---
>>   tools/lib/traceevent/event-parse.c | 2 +-
> 
> tool/lib/traceevent is deprecated.
> 
> Can you send this patch to linux-trace-devel@vger.kernel.org against
> 
>    https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/
> 
ok, thanks for the reminder.

Thanks,
-- 
Shang XiaoJing
