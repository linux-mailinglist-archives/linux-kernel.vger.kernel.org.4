Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35DE614C32
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiKAOFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKAOF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:05:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9059C1A815
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 07:05:25 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N1sGn0cBxzHv6r;
        Tue,  1 Nov 2022 22:05:05 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 22:05:22 +0800
Subject: Re: [PATCH v2] x86/cpu: replacing the open-coded shift with BIT(x)
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <puwen@hygon.cn>, <TonyWWang-oc@zhaoxin.com>,
        <peterz@infradead.org>, <gregkh@linuxfoundation.org>,
        <andrew.cooper3@citrix.com>, <tony.luck@intel.com>,
        <mario.limonciello@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
        <chenyi.qiang@intel.com>, <rdunlap@infradead.org>,
        <jithu.joseph@intel.com>, <rafael.j.wysocki@intel.com>,
        <paulmck@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221101111418.816139-1-cuigaosheng1@huawei.com>
 <Y2EEY63DnDodJFoz@zx2c4.com>
 <eed4512b-ac6e-bcec-2f66-7ab45aef9be9@huawei.com>
 <CAHmME9rNE-fWcdJer-MsQJ224redaXJO-Vvcjy6xg0_Eib-RZQ@mail.gmail.com>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <e38b1702-c29a-96fc-8fa2-139006fd4d27@huawei.com>
Date:   Tue, 1 Nov 2022 22:05:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAHmME9rNE-fWcdJer-MsQJ224redaXJO-Vvcjy6xg0_Eib-RZQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, maybe we can do the same thing with BIT(), so I add other modifications, should I remove them?

Thanks very much!

On 2022/11/1 21:43, Jason A. Donenfeld wrote:
> On Tue, Nov 1, 2022 at 2:37 PM cuigaosheng <cuigaosheng1@huawei.com> wrote:
>>> 215 [ 0.953146][ T0] UBSAN: shift-out-of-bounds in mm/shmem.c:3749:18
>>> 216 [ 0.953863][ T0] left shift of 1 by 31 places cannot be represented in type 'int'
> Isn't this just an issue with `1 << 31` needing to be `1U << 31`?
>
> Jason
> .
