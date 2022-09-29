Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEFC5EEE07
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbiI2Gsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbiI2Gsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:48:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF0112F749
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 23:48:49 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MdP3d6mCqzlXCg;
        Thu, 29 Sep 2022 14:44:29 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 14:48:47 +0800
Received: from [10.67.111.83] (10.67.111.83) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 29 Sep
 2022 14:48:47 +0800
Message-ID: <0412bd8a-aa49-e2b1-ed9f-57ad37ecea19@huawei.com>
Date:   Thu, 29 Sep 2022 14:48:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next] init/Kconfig: fix unmet direct dependencies
To:     Arnd Bergmann <arnd@arndb.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        Masahiro Yamada <masahiroy@kernel.org>, <seanjc@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, <ojeda@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        <atomlin@redhat.com>, <ddiss@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        <linux-kernel@vger.kernel.org>
References: <20220928064934.70867-1-renzhijie2@huawei.com>
 <YzPxMvjdjVEK1/b1@linutronix.de>
 <CAKXUXMxGt9UGhw9Ap_M3U2AF1vw2dX7WpDO71=UwV0Be3t4sNw@mail.gmail.com>
 <YzQQfW3h70OIiT14@linutronix.de>
 <e33cc08b-612b-4786-9b68-262c43af5ccb@www.fastmail.com>
From:   Ren Zhijie <renzhijie2@huawei.com>
In-Reply-To: <e33cc08b-612b-4786-9b68-262c43af5ccb@www.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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


在 2022/9/28 17:32, Arnd Bergmann 写道:
> On Wed, Sep 28, 2022, at 11:14 AM, Sebastian Andrzej Siewior wrote:
>> On 2022-09-28 09:20:42 [+0200], Lukas Bulwahn wrote:
>>>> Couldn't this become a depends?
>>> It could also be a depends (to resolve the warning).
>> …
>>> It is just the question whether:
>>>
>>> When PROC_FS is not set, should the CHECKPOINT_RESTORE still be
>>> visible as a config option to add (and then automatically add
>>> PROC_FS)? Then select is right here.
>> then CHECKPOINT_RESTORE is the only option selecting PROC_FS while
>> everyone else depends on it _or_ avoids using it in the absence of
>> PROC_FS.
> Right, we should not mix 'select' and 'depends on' for the same
> symbol, as that leads to circular dependencies and general
> confusion.
>
> If there is no way to use CHECKPOINT_RESTORE without procfs,
> then the symbol should just not be visible (it will still show
> up with the dependency when one searches in menuconfig).
> Force-enabling a major subsystem like procfs from another
> symbol is not a good solution.

Agree that,  i will fix it in patch v2.

Thanks,

Ren

>      Arnd
> .
