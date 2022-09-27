Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11B75EB93A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 06:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiI0EbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 00:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiI0Ea5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 00:30:57 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9977B82746;
        Mon, 26 Sep 2022 21:30:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VQq1JZ-_1664253048;
Received: from 30.240.100.75(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VQq1JZ-_1664253048)
          by smtp.aliyun-inc.com;
          Tue, 27 Sep 2022 12:30:50 +0800
Message-ID: <0d3188a0-3e6f-4999-9fe8-92509d7cf0d5@linux.alibaba.com>
Date:   Tue, 27 Sep 2022 12:30:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 16/16] crypto: arm64/sm4 - add ARMv9 SVE cryptography
 acceleration implementation
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20220926093620.99898-1-tianjia.zhang@linux.alibaba.com>
 <20220926093620.99898-17-tianjia.zhang@linux.alibaba.com>
 <CAMj1kXF8Fi9cG4p6udRYT4LbCAj0UBXQL12nmQBFEWvZsVX7Wg@mail.gmail.com>
 <YzHd/U9vvSwuhKsx@sirena.org.uk>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <YzHd/U9vvSwuhKsx@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 9/27/22 1:14 AM, Mark Brown wrote:
> On Mon, Sep 26, 2022 at 12:02:04PM +0200, Ard Biesheuvel wrote:
> 
>> Given that we currently do not support the use of SVE in kernel mode,
>> this patch cannot be accepted at this time (but the rest of the series
>> looks reasonable to me, although I have only skimmed over the patches)
> 
>> In view of the disappointing benchmark results below, I don't think
>> this is worth the hassle at the moment. If we can find a case where
>> using SVE in kernel mode truly makes a [favorable] difference, we can
>> revisit this, but not without a thorough analysis of the impact it
>> will have to support SVE in the kernel. Also, the fact that SVE may
> 
> The kernel code doesn't really distinguish between FPSIMD and SVE in
> terms of state management, and with the sharing of the V and Z registers
> the architecture is very similar too so it shouldn't be too much hassle,
> the only thing we should need is some management for the VL when
> starting kernel mode SVE (probably just setting the maximum VL as a
> first pass).
> 
> The current code should *work* and on a system with only a single VL
> supported it'd be equivalent since setting the VL is a noop, it'd just
> mean that any kernel mode SVE would end up using whatever the last VL
> set on the PE happened to be in which could result in inconsistent
> performance.
> 
>> also cover cryptographic extensions does not necessarily imply that a
>> micro-architecture will perform those crypto transformations in
>> parallel and so the performance may be the same even if VL > 128.
> 
> Indeed, though so long as the performance is comparable I guess it
> doesn't really hurt - if we run into situations where for some
> implementations SVE performs worse then we'd need to do something more
> complicated than just using SVE if it's available but...
> 
>> In summary, please drop this patch for now, and once there are more
>> encouraging performance numbers, please resubmit it as part of a
>> series that explicitly enables SVE in kernel mode on arm64, and
>> documents the requirements and constraints.
> 
> ...in any case as you say until there are cases where SVE does better
> for some in kernel use case we probably just shouldn't merge things.
> 
> Having said that I have been tempted to put together a branch which has
> a kernel_sve_begin() implementation and collects proposed algorithm
> implementations so they're there for people to experiment with as new
> hardware becomes available.  There's clearly interest in trying to use
> SVE in kernel and it makes sense to try to avoid common pitfalls and
> reduce duplication of effort.
> 

Your reply helped me a lot, I did encounter problems when using qemu VL
larger than 128-bit environment, but I also tested it with the pure
user-mode library libgcrypt, it seems to be normal, maybe in 128-bit
It's just a coincidence that it works fine in the physical machine.

I am looking forward to your experimental branch, and I believe that
there will be breakthroughs in hardware in the near future.

> A couple of very minor comments on the patch:
> 
>>> +config CRYPTO_SM4_ARM64_SVE_CE_BLK
>>> +       tristate "Ciphers: SM4, modes: ECB/CBC/CFB/CTR (ARMv9 cryptography
>> +acceleration with SVE2)"
>>> +       depends on KERNEL_MODE_NEON
>>> +       select CRYPTO_SKCIPHER
>>> +       select CRYPTO_SM4
>>> +       select CRYPTO_SM4_ARM64_CE_BLK
>>> +       help
> 
> Our current baseline binutils version requirement predates SVE support
> so we'd either need to manually encode all SVE instructions used or add
> suitable dependency.  The dependency seems a lot more reasonable here,
> and we could require a new enough version to avoid the manual encoding
> that is done in the patch (though I've not checked how new a version
> that'd end up requiring, it might be unreasonable so perhaps just
> depending on binutils having basic SVE support and continuing with the
> manual encoding might be more helpful).
> 
>>> +.macro sm4e, vd, vn
>>> +       .inst 0xcec08400 | (.L\vn << 5) | .L\vd
>>> +.endm
> 
> For any manual encodings that do get left it'd be good to note the
> binutils and LLVM versions which support the instruction so we can
> hopefully at some point switch to assembling them normally.
> 
>>> +static int __init sm4_sve_ce_init(void)
>>> +{
>>> +       if (sm4_sve_get_vl() <= 16)
>>> +               return -ENODEV;
> 
> I'm not clear what this check is attempting to guard against - what's
> the issue with larger VLs?

Since there is no physical environment, this check is based on my naive
assumption that the performance when VL is 256-bit should theoretically
be twice that of 128-bit, because SVE needs to handle more complex data
shifting operations and CTR incrementing operations, so When VL is
greater than or equal to 256 bits, the use of SVE will bring performance
improvement, otherwise it is a suitable choice to degenerate to CE.

Now it seems that this assumption itself is not valid, I will drop
this patch first.

> 
> If it is needed then we already have a sve_get_vl() in the core kernel
> which we should probably be making available to modules rather than
> having them open code something (eg, making it a static inline rather
> than putting it in asm).

Yes, I agree, exporting sve_get_vl() to the module is the more
appropriate approach.

Best regards,
Tianjia

