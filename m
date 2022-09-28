Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38F55ED6DA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbiI1Hxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiI1Hxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:53:35 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E3910CA6A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:52:16 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4McpYd3L78zHq8X;
        Wed, 28 Sep 2022 15:49:57 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 15:52:14 +0800
Received: from [10.67.111.83] (10.67.111.83) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 28 Sep
 2022 15:52:14 +0800
Message-ID: <a7b7c161-1e9a-3fba-0ed4-6eb1cb341b6f@huawei.com>
Date:   Wed, 28 Sep 2022 15:52:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next] init/Kconfig: fix unmet direct dependencies
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     <akpm@linux-foundation.org>, <ndesaulniers@google.com>,
        <nathan@kernel.org>, <vbabka@suse.cz>, <masahiroy@kernel.org>,
        <arnd@arndb.de>, <seanjc@google.com>, <hannes@cmpxchg.org>,
        <ojeda@kernel.org>, <mhiramat@kernel.org>,
        <dmitry.torokhov@gmail.com>, <atomlin@redhat.com>, <ddiss@suse.de>,
        <christophe.leroy@csgroup.eu>, <linux-kernel@vger.kernel.org>
References: <20220928064934.70867-1-renzhijie2@huawei.com>
 <YzPxMvjdjVEK1/b1@linutronix.de>
 <CAKXUXMxGt9UGhw9Ap_M3U2AF1vw2dX7WpDO71=UwV0Be3t4sNw@mail.gmail.com>
From:   Ren Zhijie <renzhijie2@huawei.com>
In-Reply-To: <CAKXUXMxGt9UGhw9Ap_M3U2AF1vw2dX7WpDO71=UwV0Be3t4sNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.83]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/28 15:20, Lukas Bulwahn 写道:
> On Wed, Sep 28, 2022 at 9:01 AM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
>> On 2022-09-28 06:49:34 [+0000], Ren Zhijie wrote:
>>> --- a/init/Kconfig
>>> +++ b/init/Kconfig
>>> @@ -1273,6 +1273,7 @@ endif # NAMESPACES
>>>
>>>   config CHECKPOINT_RESTORE
>>>        bool "Checkpoint/restore support"
>>> +     select PROC_FS
>> Couldn't this become a depends?
>>
> It could also be a depends (to resolve the warning).
>
> It is just the question whether:
>
> When PROC_FS is not set, should the CHECKPOINT_RESTORE still be
> visible as a config option to add (and then automatically add
> PROC_FS)? Then select is right here.
>
> or:
>
> When PROC_FS is not set, should the CHECKPOINT_RESTORE not be visible
> as a config option to add? Instead the user first needs to add
> PROC_FS, then CHECKPOINT_RESTORE becomes visible as an option to add,
> and then the user can add it. Then depends would be right.
>
> For me, both seem reasonable. So, I assume Ren considered select the
> better choice.
>
> But maybe Ren can confirm.

My consider is that if CHECKPOINT_RESTORE depends on PROC_FS , when 
PROC_FS is not set the user have no chance to set it on.

Thanks,

Ren

>
> A kernel build configuration without PROC_FS is quite special
> anyway... and then being interested in CHECKPOINT_ RESTORE for such a
> system is really really special. I wonder if that user then really
> knows what he or she is configuring at that point.
>
>
> Lukas
> .
.
