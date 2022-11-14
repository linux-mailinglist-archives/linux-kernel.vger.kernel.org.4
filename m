Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A04562763C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbiKNHFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiKNHFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:05:44 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0109F18350;
        Sun, 13 Nov 2022 23:05:41 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N9gL84pyXzHvss;
        Mon, 14 Nov 2022 15:05:04 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 15:05:23 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 15:05:23 +0800
Subject: Re: [PATCH v2] rcu: Dump memory object info if callback function is
 invalid
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Neeraj Upadhyay" <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221111102822.224-1-thunder.leizhen@huawei.com>
 <MW5PR84MB1842F925447B4BD175CF23C9AB009@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <10b1fec4-d363-fc6b-9dd9-122512be48be@huawei.com>
Date:   Mon, 14 Nov 2022 15:05:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <MW5PR84MB1842F925447B4BD175CF23C9AB009@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/11 23:50, Elliott, Robert (Servers) wrote:
> 
> 
>> +static inline void debug_rcu_head_callback(struct rcu_head *rhp)
>> +{
>> +	if (unlikely(!rhp->func))
>> +		mem_dump_obj(rhp);
>> +}
>> +
> 
> The mm/util.c definition of mem_dump_object() says:
>  * This function uses pr_cont(), so that the caller is expected to have
>  * printed out whatever preamble is appropriate.
> 
> so this needs to call pr_alert() or pr_err() before that to explain what
> is being printed (with no \n), like these:
> 
> kernel/rcu/rcutorture.c: pr_alert("mem_dump_obj(%px):", &rhp);
> kernel/rcu/rcutorture.c: mem_dump_obj(&rhp);
> ...
> kernel/rcu/tree.c: pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head->func);
> kernel/rcu/tree.c: mem_dump_obj(head);

Yes, right, thanks.

> 
> 
> .
> 

-- 
Regards,
  Zhen Lei
