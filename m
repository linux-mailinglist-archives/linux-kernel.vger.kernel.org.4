Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C0F605536
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 03:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiJTBwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 21:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiJTBwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:52:46 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1947E16EA39;
        Wed, 19 Oct 2022 18:52:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VScdp8u_1666230756;
Received: from 30.221.97.125(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VScdp8u_1666230756)
          by smtp.aliyun-inc.com;
          Thu, 20 Oct 2022 09:52:38 +0800
Message-ID: <5fa1f75a-1641-771e-3670-2d8978c99d2a@linux.alibaba.com>
Date:   Thu, 20 Oct 2022 09:52:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH V3 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
To:     =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= 
        <k-hagio-ab@nec.com>, Baoquan He <bhe@redhat.com>,
        lijiang <lijiang@redhat.com>
Cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "mick@ics.forth.gr" <mick@ics.forth.gr>,
        "alexandre.ghiti@canonical.com" <alexandre.ghiti@canonical.com>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Conor.Dooley@microchip.com" <Conor.Dooley@microchip.com>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "crash-utility@redhat.com" <crash-utility@redhat.com>,
        "heinrich.schuchardt@canonical.com" 
        <heinrich.schuchardt@canonical.com>,
        "hschauhan@nulltrace.org" <hschauhan@nulltrace.org>,
        "yixun.lan@gmail.com" <yixun.lan@gmail.com>
References: <20221018081755.6214-1-xianting.tian@linux.alibaba.com>
 <20221018081755.6214-2-xianting.tian@linux.alibaba.com>
 <Y05tfxRenMs5d+bt@MiWiFi-R3L-srv>
 <049ec19e-60c3-2854-5f5e-9850231108b4@linux.alibaba.com>
 <Y05540td7lLz+0BY@MiWiFi-R3L-srv>
 <a66a5b16-5f1f-3d80-3cdc-4b82d38d604f@linux.alibaba.com>
 <0f0a77a9-c824-8aa4-77de-a75c2139d791@nec.com>
 <811bdf09-be38-ce2a-a1d3-ada9f7c85b97@linux.alibaba.com>
 <52023285-172a-97cc-bad4-4ab4e709885c@nec.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <52023285-172a-97cc-bad4-4ab4e709885c@nec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/10/20 上午9:35, HAGIO KAZUHITO(萩尾 一仁) 写道:
> On 2022/10/19 12:17, Xianting Tian wrote:
>
>>>>>>>> +    if (IS_ENABLED(CONFIG_64BIT)) {
>>>>>>>> +#ifdef CONFIG_KASAN
>>>>>>>> +        vmcoreinfo_append_str("NUMBER(KASAN_SHADOW_START)=0x%lx\n", KASAN_SHADOW_START);
>>>>>>>> +        vmcoreinfo_append_str("NUMBER(KASAN_SHADOW_END)=0x%lx\n", KASAN_SHADOW_END);
>>>>>>>> +#endif
>>>>>>>> +        vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n", KERNEL_LINK_ADDR);
>>>>>>>> +        vmcoreinfo_append_str("NUMBER(ADDRESS_SPACE_END)=0x%lx\n", ADDRESS_SPACE_END);
>>>>>>> Seems this is the firsr ARCH where kasan and kernel link/bpf space are
>>>>>>> added to dump and analyze. Just curious, have you got code change to
>>>>>>> make use of them to do dumping and analyze?
>>>>>> KASAN_SHADOW_START is not used, KERNEL_LINK_ADDR is used in the crash patch set:
>>>>>> https://patchwork.kernel.org/project/linux-riscv/cover/20220813031753.3097720-1-xianting.tian@linux.alibaba.com/
>>>>> Oh, I would say please no. Sometime we got tons of objection when adding an
>>>>> necessary one, we definitely should not add one for possible future
>>>>> use.
>>>>>
>>>>> For this kind of newly added one, we need get ack from
>>>>> makedumpfile/crash utility maintainer so that we know they are necessary
>>>>> to have. At least they don't oppose.
>>>> Hi Kazu, Li Jiang
>>>>
>>>> Could you help comment whether we need KASAN_SHADOW_START and KERNEL_LINK_ADDR area export for vmcore from crash point of view？
>>>>
>>>> In my crash patch set, I don't use KASAN_SHADOW_START,
>>>> And only get the value of KERNEL_LINK_ADDR, not realy use it.
>>>> https://patchwork.kernel.org/project/linux-riscv/cover/20220813031753.3097720-1-xianting.tian@linux.alibaba.com/
>>> In your crash patch set, KERNEL_LINK_ADDR is used in VTOP() and looks
>>> necessary to me.
>>>
>>> The others (KASAN_SHADOW_START, KASAN_SHADOW_END and ADDRESS_SPACE_END)
>>> are not currently used.  It may be better to add them when they are
>>> really used.
>> I am very sorry, I missed it , KERNEL_LINK_ADDR is used indeed.
>>
>> KASAN_SHADOW_START is not used, so I don't need to send crash patch set> again. only need to remove KASAN_SHADOW_END in kernel patch set.
> I see that your v4 kernel patch set does not have ADDRESS_SPACE_END,
> so it seems there would be need to change this part and related ones
> at crash side.
>
>           if ((string = pc->read_vmcoreinfo("NUMBER(ADDRESS_SPACE_END)"))) {
>                   ms->address_space_end = htol(string, QUIET, NULL);
>                   free(string);
>           } else
>                   goto error;
> ...
> error:
>           error(FATAL, "cannot get vm layout\n");

thanks,

I just send V4 of crash patch set, the issue is also fixed in V4.

>
> Thanks,
> Kazu
