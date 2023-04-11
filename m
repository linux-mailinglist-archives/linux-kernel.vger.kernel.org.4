Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB786DD99F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjDKLmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjDKLmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:42:40 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797AF3AA3;
        Tue, 11 Apr 2023 04:42:38 -0700 (PDT)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PwkTD51jGzDsW6;
        Tue, 11 Apr 2023 19:41:52 +0800 (CST)
Received: from [10.67.101.184] (10.67.101.184) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 19:42:34 +0800
Subject: Re: [PATCH V4 23/23] crypto: hisilicon/qm: Workaround to enable build
 with RISC-V clang
To:     Arnd Bergmann <arnd@arndb.de>,
        Sunil V L <sunilvl@ventanamicro.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <llvm@lists.linux.dev>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-24-sunilvl@ventanamicro.com>
 <dcd04005-2dba-4ccc-a235-a809220f9dbd@app.fastmail.com>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
From:   Weili Qian <qianweili@huawei.com>
Message-ID: <487a20e7-2894-218a-47e9-b222aef4ec6e@huawei.com>
Date:   Tue, 11 Apr 2023 19:42:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <dcd04005-2dba-4ccc-a235-a809220f9dbd@app.fastmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.184]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/5 16:16, Arnd Bergmann wrote:
> On Tue, Apr 4, 2023, at 20:20, Sunil V L wrote:
>> With CONFIG_ACPI enabled for RISC-V, this driver gets enabled in
>> allmodconfig build. The gcc tool chain builds this driver removing the
>> inline arm64 assembly code. However, clang for RISC-V tries to build
>> the arm64 assembly and below error is seen.
>>
>> drivers/crypto/hisilicon/qm.c:627:10: error: invalid output constraint 
>> '+Q' in asm
>>                        "+Q" (*((char __iomem *)fun_base))
>>                        ^
>> It appears that RISC-V clang is not smart enough to detect
>> IS_ENABLED(CONFIG_ARM64) and remove the dead code.
>>
>> As a workaround, move this check to preprocessing stage which works
>> with the RISC-V clang tool chain.
>>
>> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> 
> Your patch looks correct for this particular problem, but I
> see that there are a couple of other issues in the same function:
> 
>> -	}
>> +#if IS_ENABLED(CONFIG_ARM64)
>> +	unsigned long tmp0 = 0, tmp1 = 0;
>>
>>  	asm volatile("ldp %0, %1, %3\n"
>>  		     "stp %0, %1, %2\n"
>> @@ -627,6 +623,11 @@ static void qm_mb_write(struct hisi_qm *qm, const 
>> void *src)
>>  		       "+Q" (*((char __iomem *)fun_base))
>>  		     : "Q" (*((char *)src))
>>  		     : "memory");
> 
> For the arm64 version:
> 
> - the "dmb oshst" barrier needs to come before the stp, not after
>   it,  otherwise there is no guarantee that data written to memory
>   is visible by the device when the mailbox gets triggered
> - The input/output arguments need to be pointers to 128-bit types,
>   either a struct or a __uint128_t
> - this lacks a byteswap on big-endian kernels
Sorry for the late reply.

- the execution order relies on the data dependency between ldp and stp:
  load "src" to "tmp0" and "tmp1", then
  store "tmp0" and "tmp1" to "fun_base";
  The "dmb oshst" is used to ensure that the stp instruction has been executed
  before CPU checking mailbox status. Whether the execution order
  cannot be guaranteed via data dependency?

- The input argument "src" is struct "struct qm_mailbox".
- Before call this funcion, the data has been byteswapped.

	mailbox->w0 = cpu_to_le16((cmd) |
		((op) ? 0x1 << QM_MB_OP_SHIFT : 0) |
		(0x1 << QM_MB_BUSY_SHIFT));
	mailbox->queue_num = cpu_to_le16(queue);
	mailbox->base_l = cpu_to_le32(lower_32_bits(base));
	mailbox->base_h = cpu_to_le32(upper_32_bits(base));
	mailbox->rsvd = 0;

> 
>> +#else
>> +	memcpy_toio(fun_base, src, 16);
>> +	dma_wmb();
>> +#endif
> 
> This version has the same problems, plus the write is not actually
> atomic. I wonder if a pair of writeq() calls would just do the
> right thing here for both arm64 and others, or possibly a
> writeq() followed by a writeq_relaxed() to avoid the extra dmb()
> in the middle.
> 
>      Arnd
> .
> 
We have to do a 128bit atomic write here to trigger a mailbox. The reason
is that the PF and related VFs of a hardware cannot write mailbox MMIO at the
same time.
For this SoC(Kunpeng) which has QM, if the address is 128bit aligned, stp will
be atomic. The offset of QM mailbox is 128bit aligned, so it is safe here.

Best regards,
Weili
