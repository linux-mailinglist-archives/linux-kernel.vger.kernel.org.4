Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5202670241A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbjEOGHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238183AbjEOGHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:07:32 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037B32703;
        Sun, 14 May 2023 23:04:29 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id BD54D24DB84;
        Mon, 15 May 2023 14:04:27 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 15 May
 2023 14:04:27 +0800
Received: from [192.168.155.85] (202.188.176.82) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 15 May
 2023 14:04:24 +0800
Message-ID: <3ec4b399-48d8-0129-85b7-0fe30e6de9c5@starfivetech.com>
Date:   Mon, 15 May 2023 14:04:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v7 4/4] crypto: starfive - Add hash and HMAC support
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20230504073400.1170979-1-jiajie.ho@starfivetech.com>
 <20230504073400.1170979-5-jiajie.ho@starfivetech.com>
 <ZF4bKe0YkpcQakLs@gondor.apana.org.au>
 <2ae2d187-5db7-9207-7846-1a80e87047b2@starfivetech.com>
 <ZGGz4YFDMKQThG2x@gondor.apana.org.au>
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
In-Reply-To: <ZGGz4YFDMKQThG2x@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/5/2023 12:24 pm, Herbert Xu wrote:
> On Mon, May 15, 2023 at 11:27:35AM +0800, Jia Jie Ho wrote:
>>
>> I've added COMPILE_TEST in the Kconfig, then ran make W=1, sparse and smatch.
>> However it did not produce the error message.
> 
> I guess you weren't testing on a 64-bit platform.  BIT(2) is
> an unsigned long, so ~BIT(2) is 64-bit long on 64-bit platforms.
> 
I am cross-compiling on a 64-bit platform. 
I'll check my compiler settings again in case this masks errors in future patches.

> You're trying to feed it into writel which takes a 32-bit value,
> hence the warning.
> 
> If you have to use the BIT macro, then you need to cast the result
> to u32:
> 
> #define STARFIVE_IE_MASK_HASH_DONE ((u32)BIT(2))
> 
> But it's probably a lot clearer if you do it as:
> 
> #define STARFIVE_IE_MASK_HASH_DONE 0x4
Sure, I'll do this for the next version.

Thanks,
Jia Jie

