Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061AE634DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 03:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbiKWChY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 21:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbiKWChT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 21:37:19 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1548725E7;
        Tue, 22 Nov 2022 18:37:17 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 0E319420CF;
        Wed, 23 Nov 2022 02:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1669171034; bh=Yn5X5ms6gE6PGm6GarmnveA4sX7BBMwg+HOe4jvW0eE=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=Vi1oe3ru2bHkTXegGyGHCEmv0Cx0JRyzJI01GIOUmw8mMbFZcvFs6w6azWgEVI2wX
         hiHe0i1GIA9eb2UYUBKXApDPgM4CregUwPx+fkWxBL6aqjD6rsCRBvIPJKg2KXj5rO
         zwG8Keynicpky04kylEvvezcpH9qO8erqMytnWqBqRBQdhkyPeADXt1DEOaaueexv7
         EWg0NTrt51nFJXfJd6i34i+kTK7CpqdNW/rHNijk0xVWlRO1zDg5PptoxBZK//GHR1
         FjfrXjGzIxvwo2BBdkgoisYjdLQeiZ0SuWBiVgUz45YyghFLxDPHpk9+jHcXgyqgAK
         hgDPgaTldNrcg==
Message-ID: <29c800dd-efdf-ddab-3ad2-466e1a8eb7d2@marcan.st>
Date:   Wed, 23 Nov 2022 11:37:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc:     thierry.reding@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        sven@svenpeter.dev, alyssa@rosenzweig.io, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221121174228.93670-1-fnkl.kernel@gmail.com>
 <20221121174228.93670-3-fnkl.kernel@gmail.com>
 <20221123022438.GA1006695-robh@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH RESEND v3 2/4] pwm: Add Apple PWM controller
In-Reply-To: <20221123022438.GA1006695-robh@kernel.org>
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

On 23/11/2022 11.24, Rob Herring wrote:
> On Mon, Nov 21, 2022 at 08:42:26PM +0300, Sasha Finkelstein wrote:
>> diff --git a/drivers/pwm/pwm-apple.c b/drivers/pwm/pwm-apple.c
>> new file mode 100644
>> index 000000000000..b0c3f86fd578
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-apple.c
>> @@ -0,0 +1,127 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> 
> Kernel code is generally GPL-2.0 only. No other PWM driver is MIT 
> licensed. So why this one.
> 
> Mixing licenses is a problem because few people look at the licenses 
> when copying code around.

*Sigh*. We encourage the use of MIT dual-licensing as a project to allow
other OSes to port the drivers over without having to rewrite them, for
any driver written from scratch. We've had this conversation quite a few
times already...

>> +
>> +	ret = devm_pwmchip_add(&pdev->dev, &pwm->chip);
> 
> This symbol is EXPORT_SYMBOL_GPL. So how can this module be MIT 
> licensed?

Because they are compatible licenses. The combination of this driver and
the kernel is GPL, but this driver itself is MIT. People are free to
port it to other OSes and reimplement devm_pwmchip_add or replace the
call with something else.

The EXPORT_SYMBOL_GPL stuff is about blocking *proprietary*
GPL-incompatible modules from using those symbols. This is a
GPL-compatible, explicitly dual-licensed module.

In this case the driver is trivial enough there isn't much to gain from
dual-licensing since the parts that matter (the reverse engineering) are
not copyrightable, but I still find it silly that we keep getting told
more permissive licensing is a problem. People are free to dual-license
their work as they see fit, it's a fundamental freedom in free software,
and plenty of kernel code is dual-licensed like this (including much of
DRM and entire GPU drivers).

- Hector
