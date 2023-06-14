Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164A372F9C5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbjFNJvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbjFNJvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:51:41 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE9818C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:51:38 -0700 (PDT)
X-QQ-mid: bizesmtp80t1686736285t42fgc5x
Received: from [192.168.1.114] ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 14 Jun 2023 17:51:23 +0800 (CST)
X-QQ-SSF: 00200000000000908000000A0000000
X-QQ-FEAT: 3M0okmaRx3jzgAw+wb429lo2o1gXaW/FxYZHzmCIb34GNNzzsix5dtaZLgYla
        op1QCU6hjX5k7wFcefIaFsrzIo6jJoSaPuYUXw0ZO6tVvAM5xqKW8TX1T6xul2qe6EUPlsj
        XXFyj/8VkeYGiamiZdgxSzLqT773i32qA3wEeuA+ZDlo96EEHnIwLt7/SLCTSw3k/xzVBmX
        ZVPO5xF8EHVd7KW+wPVswrIdb7l+/xLVwBHJ2bz+/RkhvIXe/KzTlI1I+oItKt5in7OuR9l
        xthWFkKIvUWzPBNFtzpShYTZSpkd8FmhCHx4ib77G/604w2VCuU/pD47O0thPPcZdaHaGCI
        aeiNVsJu/c1NS6ELWSrLTCO/tplKA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10273009568546625320
Message-ID: <6B512C74DCAB0BF0+0ad9a892-6933-baa3-0848-1e1efc685c9f@tinylab.org>
Date:   Wed, 14 Jun 2023 17:51:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] riscv: move memblock_allow_resize() after lm is ready
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Woody Zhang <woodylab@foxmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <tencent_D656D683705F41324657ED3393C3384C7408@qq.com>
 <CAHVXubiYHQCYkymde2y_okNb2XcE-xVBMj8iZ7kM5d08bhqxiQ@mail.gmail.com>
From:   Song Shuai <songshuaishuai@tinylab.org>
In-Reply-To: <CAHVXubiYHQCYkymde2y_okNb2XcE-xVBMj8iZ7kM5d08bhqxiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/12 15:15, Alexandre Ghiti 写道:
> Hi Woody,
> 
> On Sat, Jun 10, 2023 at 1:49 AM Woody Zhang <woodylab@foxmail.com> wrote:
>>
>> The initial memblock metadata is accessed from kernel image mapping. The
>> regions arrays need to "reallocated" from memblock and accessed through
>> linear mapping to cover more memblock regions. So the resizing should
>> not be allowed until linear mapping is ready. Note that there are
>> memblock allocations when building linear mapping.
>>
>> Signed-off-by: Woody Zhang <woodylab@foxmail.com>
>> ---
>>   arch/riscv/mm/init.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 9e9da69720ce..8a33ecbb4d0f 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -258,7 +258,6 @@ static void __init setup_bootmem(void)
>>          dma_contiguous_reserve(dma32_phys_limit);
>>          if (IS_ENABLED(CONFIG_64BIT))
>>                  hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
>> -       memblock_allow_resize();
>>   }
>>
>>   #ifdef CONFIG_MMU
>> @@ -1250,6 +1249,9 @@ static void __init setup_vm_final(void)
>>          csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | satp_mode);
>>          local_flush_tlb_all();
>>
>> +       /* Depend on that Linear Mapping is ready */
>> +       memblock_allow_resize();
>> +
>>          pt_ops_set_late();
>>   }
>>   #else
>> --
>> 2.39.2
>>
> 
> The commit log does not describe the issue thoroughly enough to me,
> maybe you could point to the arm64 commit that did the same? I mean
> commit 24cc61d8cb5a ("arm64: memblock: don't permit memblock resizing
> until linear mapping is up").
@Alex

I reproduced the problem as the arm64 commit describes.
You can find the complete log via this link: https://termbin.com/bx0o

I constructed the dtb with numerous discrete /memreserve/ regions
(the numbers of these regions approximate INIT_MEMBLOCK_REGIONS) which 
full the reserved regions up.

When memblock_allow_resize was set, the calling of memblock_reserve() would
double/resize the reserved regions and do the __memcopy() from the old 
regions ( mapped by kernel)
to the new ones (provided by __va()).
But before the linear mapping was ready (like: during the creating of 
linear mapping),
memblock_reserve() was called and the memcopy would trigger a Store/AMO 
page fault.

> 
> Another point is that I would not put this call into setup_vm_final(),
> I'd rather add it in paging_init() as it does not seem like a good fit
> for setup_vm_final(). But that's a nit so up to you of course.
> 
I agree.

@Woody

I noticed your V2 [1] didn't take this suggestion, maybe you can take it 
at V3.
And it will be more sound if you supplement the commit-msg with the 
panic info from the log.

[1]: 
https://lore.kernel.org/linux-riscv/tencent_97F6C19BAF7C99B22BB1199FE16B266C2B07@qq.com/
> Anyway, that's a good catch, thanks!
> 
> Alex
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

-- 
Thanks
Song Shuai

