Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A869A6120AF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 08:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJ2GZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 02:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ2GZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 02:25:41 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B631AE287;
        Fri, 28 Oct 2022 23:25:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 75B0F41A36;
        Sat, 29 Oct 2022 06:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1667024736; bh=JT3PnfJYuEQF82Wv2/4BQPk5WGhUbwUFWKKXPKTgxYg=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=bkCJsyDqMCBtZuEYdRkGZeedhmNAdbpH8FD1mnRE2NUkUl2N5H4fq8uyw28Icthxl
         TDfxaorgT52SBjS51eaJ4DiSnhy+8S1xACQtDGS5mirenbYxgb0E4wUCjItEwOl3CC
         AdT1SRgVg/CPx7aAaDZu1suz8YOzEIsuQGBWlZjdCUqqHGvvyGZY3VvTATFDw2iYgX
         cwDWedF0jcR4pIcUF4gYu7jJxZJdTz0yeBOpsLYcrH26IJCXG/RRIqEOGvb0IIx2O2
         j+eKOdJSBTZJFX6e92EU8PtupDTQnV5sG4r2vtP9ouskby01L/blQUMsp8ATvYeQri
         aJ3NnNw2wwKFA==
Message-ID: <fdc98171-e764-5be2-69ed-4395b13c06fe@marcan.st>
Date:   Sat, 29 Oct 2022 15:25:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sven@svenpeter.dev,
        alyssa@rosenzweig.io, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221028165215.43662-1-fnkl.kernel@gmail.com>
 <20221028165215.43662-3-fnkl.kernel@gmail.com>
 <02523fe5-bf99-9891-d00c-347893d5dabe@linaro.org>
 <CAMT+MTTE84XDf8c0D3MLxZ92HiDP6DhXfpHVyQZ7hfYMUkL7dg@mail.gmail.com>
 <3b8441da-31af-2414-1362-0efb05cbf8c0@linaro.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 2/4] pwm: Add Apple PWM controller
In-Reply-To: <3b8441da-31af-2414-1362-0efb05cbf8c0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2022 04.49, Krzysztof Kozlowski wrote:
> On 28/10/2022 14:51, Sasha Finkelstein wrote:
>> On Fri, 28 Oct 2022 at 20:54, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 28/10/2022 12:52, Sasha Finkelstein wrote:
>>>> +config PWM_APPLE
>>>> +     tristate "Apple SoC PWM support"
>>>> +     depends on ARCH_APPLE || (COMPILE_TEST && 64BIT)
>>>
>>> Why this code cannot be build on 32-bit?
>> It uses 64-bit divisions, which causes it to fail to build on 32-bit
>> mips. It should not be a
>> problem, since this hardware is only present on 64-bit SoCs.
> 
> Does not matter, code should be portable and buildable on 32-bit. If it
> does not build then your code is not correct.

This statement does not apply in general. There are plenty of drivers
which cannot reasonably build for 32-bit, and make no sense because no
32-bit hardware exists that could use them. Examples include anything
that accesses 64-bit registers on 64-bit SoCs the normal way, and
further anything that touches CPU stuff like system registers.

In *this* case, if the only issue is some 64-bit math, then yes, it
should be made to build on 32-bit (especially since this is likely to
also work for older 32-bit Apple SoCs). But the (COMPILE_TEST && 64BIT)
pattern is definitely valid in other cases, and I've been adding it
lately to shut up the kernel test bot since it makes no sense to compile
test a whole pile of our drivers on 32-bit architectures - they
fundamentally can't compile without adding pointless hypothetical broken
fluff to the driver like split MMIO accesses (which often can't work on
real hardware), and it serves no purpose.


- Hector
