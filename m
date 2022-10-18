Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88E760214C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiJRCmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiJRCmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:42:01 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ABD95AF8;
        Mon, 17 Oct 2022 19:41:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VSSPzYT_1666060910;
Received: from 30.221.96.155(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VSSPzYT_1666060910)
          by smtp.aliyun-inc.com;
          Tue, 18 Oct 2022 10:41:52 +0800
Message-ID: <a4d2dc7e-7f45-00b7-6c31-cc934ba9c1f5@linux.alibaba.com>
Date:   Tue, 18 Oct 2022 10:41:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH V2 2/2] Documentation: kdump: describe VMCOREINFO export
 for RISCV64
To:     Conor Dooley <conor@kernel.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
        bagasdotme@gmail.com, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, crash-utility@redhat.com,
        heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
        hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <20221014134139.5151-1-xianting.tian@linux.alibaba.com>
 <20221014134139.5151-3-xianting.tian@linux.alibaba.com>
 <Y02vm7FrhdEoSXZ+@spud>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <Y02vm7FrhdEoSXZ+@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/10/18 上午3:40, Conor Dooley 写道:
> On Fri, Oct 14, 2022 at 09:41:39PM +0800, Xianting Tian wrote:
>> The following interrelated definitions and ranges are needed by the kdump
>> crash tool, they are exported by "arch/riscv/kernel/crash_core.c":
>>      VA_BITS,
>>      PAGE_OFFSET,
>>      phys_ram_base,
>>      MODULES_VADDR ~ MODULES_END,
>>      VMALLOC_START ~ VMALLOC_END,
>>      VMEMMAP_START ~ VMEMMAP_END,
>>      KASAN_SHADOW_START ~ KASAN_SHADOW_END,
>>      KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END
>>
>> Document these RISCV64 exports above.
>>
>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>> ---
>>   .../admin-guide/kdump/vmcoreinfo.rst          | 30 +++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
>> index 6726f439958c..8e2e164cf3db 100644
>> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
>> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
>> @@ -595,3 +595,33 @@ X2TLB
>>   -----
>>   
>>   Indicates whether the crashed kernel enabled SH extended mode.
>> +
>> +RISCV64
>> +=======
>> +
>> +VA_BITS
>> +-------
>> +
>> +The maximum number of bits for virtual addresses. Used to compute the
>> +virtual memory ranges.
>> +
>> +PAGE_OFFSET
>> +-----------
>> +
>> +Indicates the virtual kernel start address of direct-mapped RAM region.
> Apologies for not seeing this sooner, but should there not be a "the"
> prior to "direct-mapped"?
will fix in v3
>
>> +
>> +phys_ram_base
>> +-------------
>> +
>> +Indicates the start physical RAM address.
>> +
>> +MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END|KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
>> +----------------------------------------------------------------------------------------------------------------------------------------------------
>> +
>> +Used to get the correct ranges:
>> +
>> +  * MODULES_VADDR ~ MODULES_END : Kernel module space.
>> +  * VMALLOC_START ~ VMALLOC_END : vmalloc() / ioremap() space.
>> +  * VMEMMAP_START ~ VMEMMAP_END : vmemmap region, used for struct page array.
> Since I'm in pedant mode, it does look a little odd that you're using
> region for vmemmap but space for the others but idc that much.

Sorry, I didn't get your point :(

it contains vmemmap area with reference wth arch/arm64/kernel/crash_core.c.

>
> Thanks,
> Conor.
>
>> +  * KASAN_SHADOW_START ~ KASAN_SHADOW_END : kasan shadow space.
>> +  * KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END : Kernel link and BPF space.
>> -- 
>> 2.17.1
>>
>>
