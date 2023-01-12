Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8967A6668AB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 03:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjALCHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 21:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbjALCH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 21:07:27 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D500D140BF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 18:07:23 -0800 (PST)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NsnvX6tbyznVBL;
        Thu, 12 Jan 2023 10:05:44 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 12 Jan 2023 10:07:20 +0800
Message-ID: <4b3d00ff-fcda-e184-7121-9cd65ed1a602@huawei.com>
Date:   Thu, 12 Jan 2023 10:07:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH -v2] x86/boot/compressed: Register dummy NMI handler in
 EFI boot loader, to avoid kdump crashes
To:     Borislav Petkov <bp@alien8.de>
CC:     Ingo Molnar <mingo@kernel.org>, <michael.roth@amd.com>,
        <hpa@zytor.com>, <tglx@linutronix.de>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <kirill.shutemov@linux.intel.com>, <jroedel@suse.de>,
        <keescook@chromium.org>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <brijesh.singh@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <liwei391@huawei.com>, <xiexiuqi@huawei.com>
References: <20230110102745.2514694-1-zengheng4@huawei.com>
 <Y71FJ+G0NGQe3Ppq@gmail.com> <Y71TglxSLJKO17SY@gmail.com>
 <Y71V8SRLxZ/Uqkfs@zn.tnic> <684a2472-f388-b2e1-4a7a-7bc9a07650b4@huawei.com>
 <Y71goW5qTW5dZKcv@zn.tnic> <Y72NphKcBMQho02u@zn.tnic>
Content-Language: en-US
From:   Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <Y72NphKcBMQho02u@zn.tnic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/1/11 0:09, Borislav Petkov wrote:
> On Tue, Jan 10, 2023 at 01:57:05PM +0100, Borislav Petkov wrote:
>> I'm doubtful now as you're injecting errors so you're not really in #MC context
>> but in this contrived context which is actually an NMI one. So we need to think
>> about how to fix this case.
> I did some more thinking:
>
> *if* this really is a real issue - and not some silly qemu games - then
> native_machine_crash_shutdown() does all the cleanup before the kdump kernel is
> started.
>
> Any NMI clearing, maybe using iret_to_self() etc, #MC resetting etc should
> happen there and not anywhere else.

You mean native_machine_crash_shutdown() should cleanup the NMI 
interrupt status

before enter kexec?


But how about the watchdog raise NMI interrupt after 
native_machine_crash_shutdown()

or mce_wrmsrl(MSR_IA32_MCG_STATUS, 0) or any else cleanup function?


B.R.,

Zeng Heng

