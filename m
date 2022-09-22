Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFE05E6528
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiIVO0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiIVOZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:25:39 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7057798A57;
        Thu, 22 Sep 2022 07:25:34 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MYHZK38VTzHpvG;
        Thu, 22 Sep 2022 22:23:21 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 22:25:32 +0800
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 22:25:31 +0800
Message-ID: <71274d7a-8a79-3954-d462-5cc8b5a5e874@huawei.com>
Date:   Thu, 22 Sep 2022 22:25:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH -next 1/3] arm64: efi-header: Mark efi header as data
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <broonie@kernel.org>,
        <maz@kernel.org>, <mark.rutland@arm.com>,
        <anshuman.khandual@arm.com>
References: <20220922130452.233323-1-chenzhongjin@huawei.com>
 <20220922130452.233323-2-chenzhongjin@huawei.com>
 <CAMj1kXGSjGr_yBC_9DiFu4k3JpDRPB+BPuKdNu2XeSWT2BSZvQ@mail.gmail.com>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <CAMj1kXGSjGr_yBC_9DiFu4k3JpDRPB+BPuKdNu2XeSWT2BSZvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/9/22 21:13, Ard Biesheuvel wrote:
> On Thu, 22 Sept 2022 at 15:08, Chen Zhongjin <chenzhongjin@huawei.com> wrote:
>> This file only contains a set of constants forming the efi header.
>>
>> Make the constants part of data symbols by wrapping them with
>> SYM_DATA.
>>
>> Signed-off-by: Julien Thierry <jthierry@redhat.com>
>> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
>> Reviewed-by: Mark Brown <broonie@kernel.org>
> Why is this necessary? These are not emitted into a .text section, and
> are not even covered by the kernel's mapping of memory. So the .L
> prefixed labels are deliberate: it prevents the symbols from polluting
> the symbol namespace with symbols pointing nowhere.
>
This is basically because when I'm developing objtool and these 
constants will disrupts

the instruction decoding so I just mark them as x86 did.


I tried to sent this patch set is because now the objtool patch set is 
growing huge so I

want to split some independent part. But now I found you are right that 
this are

meaningless. They are not even inside vmlinux. I'll discard them.


Sorry for bothering and thanks for your advise and patient!

Best,

Chen

>> ---
>>   arch/arm64/kernel/efi-header.S | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/efi-header.S b/arch/arm64/kernel/efi-header.S
>> index 28d8a5dca5f1..3eacd27ab761 100644
>> --- a/arch/arm64/kernel/efi-header.S
>> +++ b/arch/arm64/kernel/efi-header.S
>> @@ -28,6 +28,7 @@
>>          .macro  __EFI_PE_HEADER
>>   #ifdef CONFIG_EFI
>>          .set    .Lpe_header_offset, . - .L_head
>> +SYM_DATA_START_LOCAL(arm64_efi_header)
>>          .long   PE_MAGIC
>>          .short  IMAGE_FILE_MACHINE_ARM64                // Machine
>>          .short  .Lsection_count                         // NumberOfSections
>> @@ -160,6 +161,7 @@
>>
>>          .balign SEGMENT_ALIGN
>>   .Lefi_header_end:
>> +SYM_DATA_END_LABEL(arm64_efi_header, SYM_L_LOCAL, efi_header_end)
>>   #else
>>          .set    .Lpe_header_offset, 0x0
>>   #endif
>> --
>> 2.17.1
>>
