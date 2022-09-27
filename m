Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585AF5EB935
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 06:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiI0E0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 00:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiI0E0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 00:26:38 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E396B5E54B;
        Mon, 26 Sep 2022 21:26:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VQq1IO4_1664252789;
Received: from 30.240.100.75(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VQq1IO4_1664252789)
          by smtp.aliyun-inc.com;
          Tue, 27 Sep 2022 12:26:31 +0800
Message-ID: <cb061cbb-5f28-9dde-270e-6d7ccb6d4433@linux.alibaba.com>
Date:   Tue, 27 Sep 2022 12:26:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 16/16] crypto: arm64/sm4 - add ARMv9 SVE cryptography
 acceleration implementation
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, Mark Brown <broonie@kernel.org>
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
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <CAMj1kXF8Fi9cG4p6udRYT4LbCAj0UBXQL12nmQBFEWvZsVX7Wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On 9/26/22 6:02 PM, Ard Biesheuvel wrote:
> (cc Mark Brown)
> 
> Hello Tianjia,
> 
> On Mon, 26 Sept 2022 at 11:37, Tianjia Zhang
> <tianjia.zhang@linux.alibaba.com> wrote:
>>
>> Scalable Vector Extension (SVE) is the next-generation SIMD extension for
>> arm64. SVE allows flexible vector length implementations with a range of
>> possible values in CPU implementations. The vector length can vary from a
>> minimum of 128 bits up to a maximum of 2048 bits, at 128-bit increments.
>> The SVE design guarantees that the same application can run on different
>> implementations that support SVE, without the need to recompile the code.
>>
>> SVE was originally introduced by ARMv8, and ARMv9 introduced SVE2 to
>> expand and improve it. Similar to the Crypto Extension supported by the
>> NEON instruction set for the algorithm, SVE also supports the similar
>> instructions, called cryptography acceleration instructions, but this is
>> also optional instruction set.
>>
>> This patch uses SM4 cryptography acceleration instructions and SVE2
>> instructions to optimize the SM4 algorithm for ECB/CBC/CFB/CTR modes.
>> Since the encryption of CBC/CFB cannot be parallelized, the Crypto
>> Extension instruction is used.
>>
> 
> Given that we currently do not support the use of SVE in kernel mode,
> this patch cannot be accepted at this time (but the rest of the series
> looks reasonable to me, although I have only skimmed over the patches)
> 
> In view of the disappointing benchmark results below, I don't think
> this is worth the hassle at the moment. If we can find a case where
> using SVE in kernel mode truly makes a [favorable] difference, we can
> revisit this, but not without a thorough analysis of the impact it
> will have to support SVE in the kernel. Also, the fact that SVE may
> also cover cryptographic extensions does not necessarily imply that a
> micro-architecture will perform those crypto transformations in
> parallel and so the performance may be the same even if VL > 128.
> 
> In summary, please drop this patch for now, and once there are more
> encouraging performance numbers, please resubmit it as part of a
> series that explicitly enables SVE in kernel mode on arm64, and
> documents the requirements and constraints.
> 
> I have cc'ed Mark who has been working on the SVE support., who might
> have something to add here as well.
> 
> Thanks,
> Ard.
> 
> 

Thanks for your reply, the current performance of SVE is really
unsatisfactory. One reason is that the optimization of SVE needs to deal
with more and more complex data shifting operations, such as in CBC/CFB
mode, but also in CTR mode. needing more instruction to complete the
128-bit count increment, and the use of CE optimization does not have
these complications.

In addition, I naively thought that when the VL is 256-bit, the
performance will simply double compared to 128-bit. At present, this is
not the case. Maybe it is worth using SVE until there are significantly
improved performance data. I'll follow your advice and drop this
patch.

Best regards,
Tianjia

