Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA176567BF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 08:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiL0HQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 02:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiL0HQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 02:16:49 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D602363E2;
        Mon, 26 Dec 2022 23:16:47 -0800 (PST)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Nh5XJ3K3Sz16LrJ;
        Tue, 27 Dec 2022 15:15:28 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 27 Dec 2022 15:16:43 +0800
Subject: Re: [PATCH] kallsyms: Fix sleeping function called from invalid
 context when CONFIG_KALLSYMS_SELFTEST=y
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To:     Petr Mladek <pmladek@suse.com>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
References: <20221220063923.1937-1-thunder.leizhen@huawei.com>
 <df75bb4e-6cf8-7f41-b053-9619c13d1c72@csgroup.eu> <Y6GWInExu2m48K/C@alley>
 <c5a04eaa-2b8d-647a-7c70-9262e6147394@huawei.com> <Y6HYChz6pa9Aw0Sa@alley>
 <1f7c8542-ff47-106b-f651-71c1d555b027@huawei.com>
Message-ID: <07f7beec-2837-6bc1-eb24-db84462e035f@huawei.com>
Date:   Tue, 27 Dec 2022 15:16:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1f7c8542-ff47-106b-f651-71c1d555b027@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/21 20:37, Leizhen (ThunderTown) wrote:
>>>> I am not familiar with it. But task_cputime() in
>>>> kernel/sched/cputime.c looks promising. And there must be
>>>> the interface how the user space get this information.
>>>> Some is available via /proc/<PID>/... I am not sure
>>>> if there is a syscall.
>> Please, try to investigate the above hints.
> Yes, I will. Thanks.

Function task_cputime() works well when CONFIG_VIRT_CPU_ACCOUNTING_GEN=y,
but not when CONFIG_TICK_CPU_ACCOUNTING=y. The latter seems to be based on
tick interrupt sampling, rather than recording timestamps during task switches.

> 

-- 
Regards,
  Zhen Lei
