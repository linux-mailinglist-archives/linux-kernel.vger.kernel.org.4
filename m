Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B7D74E548
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjGKD0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjGKD0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:26:35 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA29C0;
        Mon, 10 Jul 2023 20:26:34 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R0R711TZMzPk2H;
        Tue, 11 Jul 2023 11:24:13 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 11:26:31 +0800
Subject: Re: [PATCH 2/2] rcu: Don't dump the stalled CPU on where RCU GP
 kthread last ran twice
To:     <paulmck@kernel.org>, Joel Fernandes <joel@joelfernandes.org>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230705073020.2030-1-thunder.leizhen@huawei.com>
 <20230705073020.2030-3-thunder.leizhen@huawei.com>
 <39430021-dc0d-4abd-8266-642e4e2dc7df@paulmck-laptop>
 <CAEXW_YR_t-x-eYKLFmruOLqZv91oi=AJKEEeuqYosejjdscn1g@mail.gmail.com>
 <33ec8708-35be-446a-8cc5-58d366a6d75d@paulmck-laptop>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <fec44f45-f5d8-69e6-ebd5-f10fc70e4b2f@huawei.com>
Date:   Tue, 11 Jul 2023 11:26:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <33ec8708-35be-446a-8cc5-58d366a6d75d@paulmck-laptop>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/11 4:32, Paul E. McKenney wrote:
> On Mon, Jul 10, 2023 at 03:55:16PM -0400, Joel Fernandes wrote:
>> On Mon, Jul 10, 2023 at 3:06 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>>>
>>> On Wed, Jul 05, 2023 at 03:30:20PM +0800, Zhen Lei wrote:
>>>> The stacks of all stalled CPUs will be dumped. If the CPU on where RCU GP
>>>> kthread last ran is stalled, its stack does not need to be dumped again.
>>>>
>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>
>>> This one looks good.  Please feel free to rebase it before 1/2 and repost.
>>
>> Just a small comment:
>> I wondered if this would make it harder to identify which stack among
>> the various CPU stacks corresponds to the one the GP kthread is
>> running on. However, this line does print the CPU number of the
>> thread, so it is perhaps not an issue:
>>
>>                 pr_err("%s kthread starved for %ld jiffies! g%ld f%#x
>> %s(%d) ->state=%#x ->cpu=%d\n",
>>
>> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Thank you!  Zhen Lei, please feel free to add Joel's Reviewed-by on your
> next posting.

OK

> 
> 							Thanx, Paul
> .
> 

-- 
Regards,
  Zhen Lei
