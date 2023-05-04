Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76B46F68D8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjEDKJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjEDKI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:08:58 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B567349E7
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 03:08:56 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4efe9a98736so324127e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 03:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1683194935; x=1685786935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZAmyScVrPkNsLXEK4fdZlXng8x+vclTeru2m98xpxE=;
        b=CBQ5pnH42Ohd94dxCUEAgcTs58Bjj2cHsGwgZqaQRB1t868kD083pQ/dkTMp0CVbCI
         wU+okdwCaH+BD1/AFcfRb+tunxG5rFb55SPdH4m8Ztc4m2Im2woixI7M8KuXHnyGNWZ3
         8Oun4DSjxuKQShBi6RfHenX1YpAUJNYU+D880=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683194935; x=1685786935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZAmyScVrPkNsLXEK4fdZlXng8x+vclTeru2m98xpxE=;
        b=Qzvl1mWdyzGkGjlcT/ckCYgzjSPEof6xNHRoa4X7gw4n60mcTZoIQ+6dms0UVLuQhn
         fvqD8WyvbasGfBbwCG/Mk4bC12/JyWplS+RrUIyN4EBzW9uWw1f007I6D5wen31eGaCu
         g4y0p4btcfElYAIEaK72Buf3yNm4hyX0/bkbZKxMXAIs1+XybVj5pyLYiKEeJeoldmGu
         0CEX9G12Q5CsMGw52EK57qPNUxT6zj/JBOsLCuzBhn3R+ze4rWFpcBceJgBwWMAyzLN6
         kNWh2tCvGqjVqT901ZCAcS+zMP/2dbJeiNua0gjGaxDW92U1dyRY5G8SGZ7iAE1Rweka
         tKgw==
X-Gm-Message-State: AC+VfDzFoIZoiI/Y0jGz2SRnh0caQm52Yo3pSDzi2IojrhMg3lCKLxE4
        RhN05wj2FV9ErsEEXKHqfBcT/g==
X-Google-Smtp-Source: ACHHUZ7byu3BdUZ7FA1VaYFXOxUWDxGwJtItgLZoZKfOXIuj9pmiKJoUFaQp6x0ise2crvswKfHAEw==
X-Received: by 2002:a19:f012:0:b0:4ee:d766:5bf7 with SMTP id p18-20020a19f012000000b004eed7665bf7mr1522854lfc.13.1683194934919;
        Thu, 04 May 2023 03:08:54 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id k26-20020ac2457a000000b004f11eb32f20sm2214028lfm.13.2023.05.04.03.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 03:08:54 -0700 (PDT)
Message-ID: <6fcf4997-9d88-7e86-70f7-52f9d296bc6e@rasmusvillemoes.dk>
Date:   Thu, 4 May 2023 12:08:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] iio: addac: ad74413: don't set DIN_SINK for functions
 other than digital input
Content-Language: en-US, da
To:     =?UTF-8?Q?Nuno_S=c3=a1?= <noname.nuno@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230503105042.453755-1-linux@rasmusvillemoes.dk>
 <27fe41e402ea0d6ef42aa0ac80aa3d1488862cd8.camel@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <27fe41e402ea0d6ef42aa0ac80aa3d1488862cd8.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 09.28, Nuno Sá wrote:
> Hi Rasmus,
> 

> So, I'm not really that familiar with this part and, at this stage, I'm being
> lazy to check the datasheet. 

Well, the data sheet is not particularly helpful here, which is why I
ended up with this mess.

> My concern is about breaking some other users...

I highly doubt there are users yet (other than my customer); this
binding+driver implementation only just landed.

> So, does it make any sense for having drive-strength-microamp in a non digital
> input at all?

That's the problem with the data sheet, it doesn't really say that the
DIN_SINK register has any effect whatsoever when the channel function is
set to something other than digital input (either flavor). Perhaps it
does hint that setting it to something non-zero is probably not a good
idea, because DIN_SINK is automatically set to 0 whenever the channel
function is set/changed, so one needs a good reason to change DIN_SINK
afterwards.

We just experimentally found out that when we added the DIN_SINK to fix
the digital input functions, when we got around to testing the
resistance measurement function that ended up broken due to the non-zero
DIN_SINK.

> Can anyone have a working device by specifying that dt parameter
> on a non digital channel (or expect something from having that parameter set)?
> Or the only effect is to actually have some functions misbehaving?

The data sheet doesn't say that the DIN_SINK should have any effect for
other functions, so I'm pretty sure it's only the latter: some functions
misbehave.

> On the driver side, if it's never right to have
> these settings together, then the patch is valid since if someone has this, his
> configuration is broken anyways (maybe that's also a valid point for the
> bindings)...

Yes, I do believe that it's a broken description (whether or not the
bindings specify that), and drivers don't need to go out of their way to
validate or fixup such brokenness. But in this particular case, there's
really no extra burden on the driver to not put garbage in DIN_SINK when
a not-digital-input function has been chosen (the patch is a two-liner
with 'git show -w').

Rasmus

