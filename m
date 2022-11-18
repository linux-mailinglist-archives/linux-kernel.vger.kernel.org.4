Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3938462EFA3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241371AbiKRIf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241405AbiKRIff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:35:35 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BF28E0B5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:35:14 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id g12so7105697lfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0YWUFR1K0AdQwhBBk1QGoqIU48WrJ6fIhbloOFLZs/g=;
        b=X6zxOsSK4rUUthEmp2P+Lwku13VFzCo9DyZ3QoTJZKTgpYnJQyG5+InN5mNv4AaESo
         rnora71GL+4BGMZaY3hcR1GSGGIjdLzQwpI5aLueleXUM3bETaQicTXKVcalougjrxY8
         fVVJPglLq7E8GAj1zrooA/eqBWhow9CdBxg7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0YWUFR1K0AdQwhBBk1QGoqIU48WrJ6fIhbloOFLZs/g=;
        b=brodU/HI0i7RwYUTAebIvCQyw4jNjl1z2jqM9Z/GmPWH8NXnYh0FEimuvha3y/elDQ
         fb3/12+iihXA9UB3O9CZ7uQ83B3IEPhW/a4WeuK4zg1veZ7yTifd73e+GvYAD/eOhLkn
         sgQHNvPOoXJNeMN22tb5+k3c8heJkfzqUQ30jHWc2LwnAOMxFRKv1P8x6X4FhgeTx38N
         i+dwhF1TA7yqHQxcCoBraoN0Ud8g3iGMpPL92fkVSabggNObarwJuQg+z9ueJqYy4uLE
         Z28KRT+Q/sloXq4g7FjNU6zjEgGvWuMeymqqM9kEJ2xbDEM/+jCcg4hAs6wLM6Q4HoVL
         y4Nw==
X-Gm-Message-State: ANoB5pk2dpRIsSP3n6vPlHixGrGQZwnxZrSlyb13IWTC1mxI+J8qZzZC
        I+6xVzldHb3cr3MWtJtEuHVAkQ==
X-Google-Smtp-Source: AA0mqf7DJq0j7pfPRdGrwhr/vqpSiF/rq95c7pCTI9lTkOFfwjGyDz06Cr8omSK46eWVUshsA9Z1Yw==
X-Received: by 2002:a19:654e:0:b0:4a4:4e49:f2c9 with SMTP id c14-20020a19654e000000b004a44e49f2c9mr2329127lfj.194.1668760512487;
        Fri, 18 Nov 2022 00:35:12 -0800 (PST)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u3-20020a05651220c300b00496d3e6b131sm566779lfr.234.2022.11.18.00.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 00:34:36 -0800 (PST)
Message-ID: <cd6e153b-953f-0374-364e-af649c82d8b4@rasmusvillemoes.dk>
Date:   Fri, 18 Nov 2022 09:33:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] of: fdt: parse early params before adding bootloader
 randomness
Content-Language: en-US, da
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
References: <20221105014613.113503-1-Jason@zx2c4.com>
 <CAL_JsqKA1_HV5V17mHkKn8X72c_UN2Jg=TYtJkt93YM6SSDMSg@mail.gmail.com>
 <Y2lBj1ZIdFRf9HdR@zx2c4.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <Y2lBj1ZIdFRf9HdR@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2022 18.34, Jason A. Donenfeld wrote:
> On Mon, Nov 07, 2022 at 11:28:20AM -0600, Rob Herring wrote:
>> On Fri, Nov 4, 2022 at 8:46 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>>>
>>> FDT is examined so early that it's before the first incidental call to
>>> parse_early_param(). This is similar to EFI, except EFI actually added
>>> an explicitly call to parse_early_param(). Let's do the same here, so
>>> that specifying `random.trust_bootloader=0` is not ignored.
>>>
>>> Fixes: d97c68d178fb ("random: treat bootloader trust toggle the same way as cpu trust toggle")
>>> Cc: Rob Herring <robh@kernel.org>
>>> Cc: Frank Rowand <frowand.list@gmail.com>
>>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>>> ---
>>>  drivers/of/fdt.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>>> index 7b571a631639..6d959117fd4f 100644
>>> --- a/drivers/of/fdt.c
>>> +++ b/drivers/of/fdt.c
>>> @@ -1195,6 +1195,9 @@ int __init early_init_dt_scan_chosen(char *cmdline)
>>>
>>>         rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
>>>         if (rng_seed && l > 0) {
>>> +               /* Parse random.trust_bootloader if it's in command line. */
>>> +               parse_early_param();
>>
>> I don't think it's good that the timing of calling this is dependent
>> on "rng-seed" being present or not. So perhaps move it up to after the
>> cmdline is set.
>>
>> Either way, the other issue is the cmdline is not necessarily fixed at
>> this point with some architectures doing their own
>> append/prepend/override of the cmdline. We can't seem to get common
>> implementation there finished. I'm doubtful that corner case would
>> actually be hit though.
> 
> Hm, yea. I'm actually now having second thoughts about this one too for
> other reasons: FDT isn't the only arch that has this issue. It's also a
> problem on x86 and m68k. Maybe the random.trust_bootloader toggle should
> just go away, since already your bootloader can do whatever it wants to
> the kernel it executes? Not sure; I'll think on it a bit I guess...

Well, for the FDT case it least one could preserve the ability for the
bootloader to say "hey, here's a bunch of bytes, but I have reason to
believe they're not as random as you'd like" by setting a boolean
"rng-seed-is-crap" [pick a better name] property alongside the rng-seed
property. Then the kernel logic could be CONFIG_TRUST_BOOT_LOADER &&
!of_get_bool("rng-seed-is-crap"). Currently, the only thing the
bootloader could do in that case is to just elide the rng-seed
completely (or set the not-actually-working cmdline flag).

I don't think it's a loss to not have a way for the bootloader to turn
on a trust-me flag.

Rasmus

