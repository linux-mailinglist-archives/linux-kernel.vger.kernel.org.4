Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B08668F8D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbjAMHuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbjAMHtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:49:47 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE0F1B9E6;
        Thu, 12 Jan 2023 23:49:45 -0800 (PST)
Received: from kwepemm600006.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NtYNN6vt6zqVJB;
        Fri, 13 Jan 2023 15:44:52 +0800 (CST)
Received: from [10.110.53.113] (10.110.53.113) by
 kwepemm600006.china.huawei.com (7.193.23.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 13 Jan 2023 15:49:35 +0800
Message-ID: <f4424d36-b18e-d801-8657-85565817554b@huawei.com>
Date:   Fri, 13 Jan 2023 15:49:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] uprobes: list all active uprobes in the system
To:     Ravi Bangoria <ravi.bangoria@amd.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sangyan@huawei.com>, <luanjianhai@huawei.com>,
        <zhuling8@huawei.com>, <lizongwu@huawei.com>,
        <luolongjuna@gmail.com>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>, <oleg@redhat.com>
References: <20230111104825.1945418-1-luolongjun@huawei.com>
 <b4109593-1aa9-bf7a-cb1b-3ccd586f31d6@amd.com>
From:   Longjun Luo <luolongjun@huawei.com>
In-Reply-To: <b4109593-1aa9-bf7a-cb1b-3ccd586f31d6@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.110.53.113]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600006.china.huawei.com (7.193.23.105)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 1/13/2023 12:03 PM, Ravi Bangoria 写道:
> +cc: Steven, Oleg, Masami
>
> On 11-Jan-23 4:18 PM, luolongjun@huawei.com wrote:
>> From: Longjun Luo <luolongjun@huawei.com>
>>
>> Since uprobes will replace instructions in the process
>> memory, it is necessary to provide one way to list
>> all active uprobes. One can access this file through
>> /sys/kernel/debug/uprobes/list.
>>
>> Output looks like this
>> =====================
>> inode+offset/ref_ctr_offset    4160760670+0x30a10/0x0
>>      ref                        1
>>      register_rwsem             (unlocked)
>>      consumer_rwsem             (unlocked)
>>      consumers-1
>>          handler                0xffffffffc03ee02e(handler) uprobe
>>          ret_handler            0x0000000000000000( )
>>          filter                 0xffffffffc03ee010(filter) uprobe
>>      consumers-2
>>          handler                0xffffffffc03e902e(handler_1) uprobe_1
>>          ret_handler            0x0000000000000000( )
>>          filter                 0xffffffffc03e9010(filter_1) uprobe_1
> You can list uprobes via /sys/kernel/tracing/uprobe_events. Any specific reason
> to introduce another way?
>
> Thanks,
> Ravi

/sys/kernel/tracing/uprobe_events only lists tracing events, not all uprobe events.
For example, if I write a kernel module to call the uprobe_register to add a new uprobe event, it will not be listed by /sys/kernel/tracing/uprobe_events.

Compare it with the kprobe is like:
/sys/kernel/tracing/uprobe_events -> /sys/kernel/tracing/kprobe_events
/sys/kernel/debug/uprobes/list -> /sys/kernel/debug/kprobes/list

Nowadays, only the trace system uses the uprobe, so /sys/kernel/tracing/uprobe_events is enough.

But we try to extend the usage of the uprobe, and we add many uprobe events by calling the uprobe_register.

For this situation, we need a approach to see all the uprobe events in the kernel.

