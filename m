Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1547464254B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 10:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiLEJBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 04:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbiLEJAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:00:45 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CCE18B11
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:59:11 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id fc4so19117465ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 00:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZFVG2GHKql4mObap2ourAu7QFKuQou+XwSrycPDhCj4=;
        b=h0mnTCNOjIf3URNf8DcO22NFH34k+ScsW5BQAoDEFdCuHnl5B1JZhm9PA5niOgIBeH
         5+d5a0WEeZbzqX044JciEYRXR4sz9I2SVL0NMHIxbDh0/trQbfTOOja0p8DfqkdVbG76
         ssFwjAtjDjrdwYLcSMayNxcfux3pweAH1CMCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFVG2GHKql4mObap2ourAu7QFKuQou+XwSrycPDhCj4=;
        b=CgZW0B+6/yAtwEGu7bcazIcTpELJPMkzU3nsNOmXp3Bp1D+QvQ1oEiOKdtK3gNo6mw
         KbV5jmZOek3KoreoSAF3LHLTiP5AMlsMZKAuHFgt+cFd/FcOiltWjbnibItS8QMTTsqF
         4HNNKhbsHbDUrwbI1M1+IlXzpdsWDpl+NbDt4YHjIbHYUS/pKTV8UPpUzCjn3FYz0mIc
         +sah5YKSpMQRcIF+sP0/bhoXnj9wrjNaAr/X8whwu4K+XJbn4S3509yHYoWpyuECH6pQ
         +I7HIul7X2nIGnSUFta9brK2IJM0XeHUw+3RfUAdYqF6/XeZUrPnFdw4ZkXqA9qC0xWu
         zZYA==
X-Gm-Message-State: ANoB5pnXjsduxiK/E+bxaYZeGcDFbAwGxs7c15CP/RuVwN1zishvEl7j
        YcgZHxw5NWRJBosInzfpbhYKeA==
X-Google-Smtp-Source: AA0mqf4qIT7jRbrwZ33Vg9jF3l0QT6efgVndCgFN9dWGR81zwv/iapk5WBmvw1GEVILBSLdIZgsv9Q==
X-Received: by 2002:a17:906:7e4c:b0:7c0:e990:27c4 with SMTP id z12-20020a1709067e4c00b007c0e99027c4mr4789870ejr.677.1670230750347;
        Mon, 05 Dec 2022 00:59:10 -0800 (PST)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id l4-20020aa7c304000000b00458dc7e8ecasm5946590edq.72.2022.12.05.00.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 00:59:09 -0800 (PST)
Message-ID: <58ec9951-32d7-6967-3571-d18c667ae478@rasmusvillemoes.dk>
Date:   Mon, 5 Dec 2022 09:59:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] Input: edt-ft5x06 - always do msleep(300) during
 initialization
Content-Language: en-US, da
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org
References: <20221202105800.653982-1-linux@rasmusvillemoes.dk>
 <Y4pCtm4J3HWhYl8/@nixie71>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <Y4pCtm4J3HWhYl8/@nixie71>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2022 19.23, Jeff LaBundy wrote:
> + Mark
> 
> Hi Rasmus,
> 
> On Fri, Dec 02, 2022 at 11:57:59AM +0100, Rasmus Villemoes wrote:
>> We have a board with an FT5446, which is close enough to a
>> FT5506 (i.e. it also supports up to 10 touch points and has similar
>> register layout) for this driver to work. However, on our board the
>> iovcc and vcc regulators are indeed controllable (so not always-on),
>> but there is no reset or wakeup gpio hooked up.
>>
>> Without a large enough delay between the regulator_enable() calls and
>> edt_ft5x06_ts_identify(), the first edt_ft5x06_ts_readwrite() call
>> fails with -ENXIO and thus the device fails to probe. So
>> unconditionally do an mdelay(300) instead of only when a reset-gpio is
>> present.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> This is just my $.02, but it does not seem we are on the correct path
> here. 300 ms sounds more like bulk capacitor charge time rather than
> anything to do with this specific IC; is that a reasonable assumption?
> 
> Normally, we want to do the following:
> 
> 1. Enable regulator
> 2. Wait for voltage rail to stabilize (RC time constant)
> 3. Wait for any applicable POR delay (IC datasheet)
> 4. Deassert reset
> 5. Wait for any applicable reset delay (IC datasheet)
> 6. Start communication
> 
> Here we are dealing with step (2), 

Nope, we are really essentially dealing with step 5, even if there's no
reset gpio that we've flipped around. The data sheet says to wait 200 ms
(and I don't know why the driver does 300, perhaps there's some other
chip in the family with that value, or perhaps it was just a
belt-and-suspenders choice) after releasing reset. It's just that
"releasing reset" is, in my case, effectively happens at the same time
as the regulators are enabled.

I also played around with some smaller values. As I wrote, with no
delay, I would get -ENXIO, but with both 50 and 100, the chip would
"respond", but the values were essentially garbage (and not reproducible
from one boot to the next). So even if it's a rather long time, it most
definitely is a hard requirement to wait that long - perhaps we could
make it 200, but I'd rather not reduce that time when I don't know if
other variants have that 300 as a requirement.

Even if we could interrogate the regulator and ask it if "are you
actually always-on", I'd rather not make the delay conditional on that;
we cannot know if it has been on for 300+ ms, and since the device does
respond, but not correctly, we could end up with probing and
initializing the device, but in a wrong state. That's a recipe for
impossible debugging (add a single printk somewhere earlier and the
timing changes so that suddenly it gets initialized correctly...).

Rasmus

