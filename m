Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB147635225
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbiKWITW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbiKWITT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:19:19 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412A5D06D4;
        Wed, 23 Nov 2022 00:19:18 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NHDY11xyzzmW64;
        Wed, 23 Nov 2022 16:18:45 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 16:19:16 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 16:19:16 +0800
Subject: Re: linux-next: build warnings after merge of the rcu tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Paul E. McKenney" <paulmck@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>
References: <20221123163255.48653674@canb.auug.org.au>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <2be7872b-3978-9ea2-c00b-6b075516ec74@huawei.com>
Date:   Wed, 23 Nov 2022 16:19:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20221123163255.48653674@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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



On 2022/11/23 13:32, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the rcu tree, today's linux-next build (htmldocs) produced
> these warnings:
> 
> Documentation/RCU/stallwarn.rst:401: WARNING: Literal block expected; none found.
> Documentation/RCU/stallwarn.rst:428: WARNING: Literal block expected; none found.
> Documentation/RCU/stallwarn.rst:445: WARNING: Literal block expected; none found.
> Documentation/RCU/stallwarn.rst:459: WARNING: Literal block expected; none found.
> Documentation/RCU/stallwarn.rst:468: WARNING: Literal block expected; none found.
> 
> Introduced by commit
> 
>   3d2788ba4573 ("doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information")
> 

Strange thing, I specially executed make htmldocs before, unexpectedly did not
find these warnings.

I already know why. The literal block is not indented. I will post a new version to
Paul E. McKenney. Excuse me for causing trouble to everyone.

For example:
@@ -398,9 +398,9 @@ In kernels built with CONFIG_RCU_CPU_STALL_CPUTIME=y or booted with
 rcupdate.rcu_cpu_stall_cputime=1, the following additional information
 is supplied with each RCU CPU stall warning::

-rcu:          hardirqs   softirqs   csw/system
-rcu:  number:      624         45            0
-rcu: cputime:       69          1         2425   ==> 2500(ms)
+  rcu:          hardirqs   softirqs   csw/system
+  rcu:  number:      624         45            0
+  rcu: cputime:       69          1         2425   ==> 2500(ms)


-- 
Regards,
  Zhen Lei
