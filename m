Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E0B737961
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 04:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjFUCyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 22:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFUCyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:54:01 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E03A1B4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:54:00 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Qm7PC3Tj0z1FDhg;
        Wed, 21 Jun 2023 10:53:51 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 21 Jun 2023 10:53:57 +0800
Subject: Re: [PATCH] sched/topology: remove unneeded do while loop in
 cpu_attach_domain()
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <20230617081926.2035113-1-linmiaohe@huawei.com>
 <20230620141120.GA2016469@hirez.programming.kicks-ass.net>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <53a9ec35-8332-755c-40ed-54315ffb0d78@huawei.com>
Date:   Wed, 21 Jun 2023 10:53:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230620141120.GA2016469@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/20 22:11, Peter Zijlstra wrote:
> On Sat, Jun 17, 2023 at 04:19:26PM +0800, Miaohe Lin wrote:
>> When sg != sd->groups, the do while loop would cause deadloop here. But
>> that won't occur because sg is always equal to sd->groups now. Remove
>> this unneeded do while loop.
> 
> This Changelog makes no sense to me.. Yes, as is the do {} while loop is
> dead code, but it *should* have read like:
> 
> 	do {
> 		sg->flags = 0;
> 		sg = sg->next;
> 	} while (sg != sd->groups);
> 
> as I noted here:
> 
>   https://lore.kernel.org/all/20230523105935.GN83892@hirez.programming.kicks-ass.net/T/#u

[1]

> 
> So what this changelog should argue is how there cannot be multiple
> groups here -- or if there can be, add the missing iteration.

[1] said:
"
Yes, I missed that.

That being said, the only reason for sd to be degenerate is that there
is only 1 group. Otherwise we will keep it and degenerate parents
instead
"

IOW, "sg = sg->next;" is missed intentionally in the do while{} loop to show that
there's only 1 sched group. This looks weird to me but no persist on change the code.

Thanks.
