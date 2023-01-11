Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A70566527C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 04:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjAKDqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 22:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjAKDqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 22:46:49 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8F422C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 19:46:47 -0800 (PST)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NsD8h2PSHz16MWg;
        Wed, 11 Jan 2023 11:45:08 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 11 Jan 2023 11:46:41 +0800
Message-ID: <fb27e5cf-9056-3698-9e6f-9386f9cdf991@huawei.com>
Date:   Wed, 11 Jan 2023 11:46:40 +0800
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
        <liwei391@huawei.com>
References: <20230110102745.2514694-1-zengheng4@huawei.com>
 <Y71FJ+G0NGQe3Ppq@gmail.com> <Y71TglxSLJKO17SY@gmail.com>
 <Y71V8SRLxZ/Uqkfs@zn.tnic> <684a2472-f388-b2e1-4a7a-7bc9a07650b4@huawei.com>
 <Y7174pEWZ8IzCdQ9@zn.tnic>
Content-Language: en-US
From:   Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <Y7174pEWZ8IzCdQ9@zn.tnic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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


On 2023/1/10 22:53, Borislav Petkov wrote:
> On Tue, Jan 10, 2023 at 08:32:07PM +0800, Zeng Heng wrote:
>> And here is the context of mce-inject:
>>
>> #0  relocate_kernel () at arch/x86/kernel/relocate_kernel_64.S:55
>> #1  0xffffffff81a57fc2 in machine_kexec (image=0xffff888101ef8400)
>>      at arch/x86/kernel/machine_kexec_64.c:391
> Before we continue with this any further: are you doing this "exercise" in
> qemu/kvm and nothing of that is happening on real hardware?

Real hardware and QEMU both can reproduce the issue.

Here is description about NMI from Intel 64 and IA-32 Architectures 
Software Developer's Manual in chapter 6.7.1:

While an NMI interrupt handler is executing, the processor blocks 
delivery of subsequent NMIs until the next execution of the IRET 
instruction. This blocking of NMIs prevents nested execution of the NMI 
handler. It is recommended that the NMI interrupt handler be accessed 
through an interrupt gate to disable maskable hardware interrupts (see 
Section 6.8.1, “Masking Maskable Hardware Interrupts”).

