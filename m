Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609E96933FF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 22:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBKVZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 16:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBKVZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 16:25:50 -0500
Received: from mail.multiname.org (h4.multiname.org [94.130.68.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB92B444;
        Sat, 11 Feb 2023 13:25:47 -0800 (PST)
Received: from webmail.multiname.org (unknown [10.0.10.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.multiname.org (Postfix) with ESMTPSA id 4PDkD913TjzPLtZ3;
        Sat, 11 Feb 2023 22:25:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ccbib.org; s=20220806;
        t=1676150745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k6EufGqREBPwPsUWjo0kh2zq6qE8EzqtdiieAXNT5C4=;
        b=Uj9TZrucHMe1XdYpNPJDGIJOXKKfNcLBiJnmxKPpdUM0aku4c7Or/LKzJ35Pe9Uj38bB4o
        kApbAOX1P5D2HI/p4IzwXM+9HREoHCtoqWzMW1ORn/lCBvWLNEtdKeSpCc/eadUGVmFJwl
        5iwnv8tle/rOXgYMkSu0P9zTg6S6ZSP+DBCkew0oIfE+irotryKVNuXuqZaXylrhJargHP
        tl3VQ/oVE3rT0KYaswa0EV+8qpQXeecImkvDBVSI601l5uGAMQohMWQBIib0Iep73DNTqa
        dTwyVZhhjWvvEcjjYl4dkeHZADSIkHwqVvngrpfGRkam/ArL+uzRAjPiE80Q2jaaiQuL/W
        6dVrlDlBqsmXqEInbiK5jeDdfef6vR+5OymQouCVGmxkQPktjBheMSFYJundoAtL1vhe6y
        ijYXJxIArNAOsiS6SQZpLHnLvsh7+Ho+beU3oV0mztAqXO6tj91lN+OmVATLgCfVT0gPb/
        SdhFKt+3bq9e+7icWhbyC3nV7+C0IdiYy8u2axbat90qLkrWA7ukbfMWcSiZyYydR6IXzk
        o5f90FEUSvZlSNCrmW3Ng6a4pTrDL+yjWVfD+mOW1a8CTIUGp3luETd1vV5847f5Iphrgb
        49tRY6uowU2vSzaDpj1dnbCaLRmyN6bpdDj1zeTkORBS4nNYZYJxw=
MIME-Version: 1.0
Date:   Sat, 11 Feb 2023 22:25:44 +0100
From:   harald@ccbib.org
To:     pelzi@flying-snail.de
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dht11: Read bit stream from IRQ on falling edges
 only
In-Reply-To: <d96a7c1f-4a12-18c9-377d-df69b17168d2@feldner-bv.de>
References: <Y9a0RZ+inWs44Kn8@debian-qemu.internal.flying-snail.de>
 <20230130202216.42034309@jic23-huawei>
 <45efc11e5b4cdba3766f19190bb65840@ccbib.org>
 <e1acd14e-400b-8896-bdc1-0b364cc52198@feldner-bv.de>
 <ac9ab2224ad19ac606de38fa474dce0c@ccbib.org>
 <d96a7c1f-4a12-18c9-377d-df69b17168d2@feldner-bv.de>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <130ee4a2c77ac9bd14a11aa38efa6d72@ccbib.org>
X-Sender: harald@ccbib.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-11 11:41, pelzi@flying-snail.de wrote:
> Am 07.02.23 um 11:33 schrieb harald@ccbib.org:
>> 2) A theoretical analysis about possible regressions depending on 
>> timer
>> resolution as mentioned in an earlier message.
> 
> This sounds as if you were doing such an analysis for the original
> version. Can you share this work so I can attempt to repeat it
> for the modified algorithm?

The short version is in the comments. The relevant section is:
/*
  * Data transmission timing:
  * Data bits are encoded as pulse length (high time) on the data line.
  * 0-bit: 22-30uS -- typically 26uS (AM2302)
  * 1-bit: 68-75uS -- typically 70uS (AM2302)
  * The acutal timings also depend on the properties of the cable, with
  * longer cables typically making pulses shorter.
  *
  * Our decoding depends on the time resolution of the system:
  * timeres > 34uS ... don't know what a 1-tick pulse is
  * 34uS > timeres > 30uS ... no problem (30kHz and 32kHz clocks)
  * 30uS > timeres > 23uS ... don't know what a 2-tick pulse is
  * timeres < 23uS ... no problem

The long version I probably don't have anymore, but it's not rocket
science. Just multiples of the time resolution. Eg:
34 = 68/2
23 = 68/3

>> 3) Ideally figuring out, why your version performs better then what we
>> currently have. I have some suspicions, but better understanding might
>> lead to a better approach. E.g. maybe recording the other edges isn't
>> the problem so long as we ignore them during decoding?
>> 
>> As I see it, the main thing we are losing with your current proposal 
>> is
>> some diagnostic features. If we keep them as much as possible and have
>> regressions understood and covered, I see no reason to reject your 
>> idea.
> 
> That's why I changed the script to separately count EIO and ETIMEDOUT.
> The latter indicates missed edges, the former failure to interpret
> the data read.
> 
> What I see is that the patched driver's errors mostly result from 
> missed
> IRQ (note in contrast to last results, I cut the number of reads):
> 
> #    real[s]    user[s]    sys[s]    success    EIO    timeout err per 
> succ
> 1     20.57    0.25    0.03    10    0    0    0
> 2     24.74    0.25    0.07    10    0    4    0,4
> 3     21.55    0.20    0.07    10    0    0    0
> 4     25.81    0.25    0.08    10    0    5    0,5
> 5     21.56    0.23    0.05    10    0    0    0
> 6     21.58    0.22    0.05    10    1    0    0,1
> 7     25.86    0.24    0.08    10    1    5    0,6
> 8     22.69    0.27    0.05    10    1    1    0,2
> 9     23.67    0.26    0.04    10    0    2    0,2
> 10     20.55    0.23    0.04    10    0    0    0
> 
> Whereas the original driver has more errors resulting from
> mis-interpreted data:
> 
> #    real[s]    user[s]    sys[s]    success    EIO    timeout err per 
> succ
> 1     24.88    0.26    0.07    10    5    4    0,9
> 2     25.91    0.26    0.07    10    4    5    0,9
> 3     31.27    0.31    0.10    10    6    10    1,6
> 4     29.17    0.32    0.11    10    7    8    1,5
> 5     22.73    0.24    0.08    10    4    2    0,6
> 6     46.46    0.35    0.25    10    19    24    4,3
> 7     23.79    0.23    0.09    10    3    3    0,6
> 8     30.17    0.27    0.11    10    6    9    1,5
> 9     23.77    0.26    0.06    10    3    2    0,5
> 10     20.58    0.24    0.06    10    1    0    0,1
> 
> I tried a variant that reads falling and rising edges and
> uses the redundany of information to eliminate some errors.
> This did not work out at all.

That's an interesting data point. Care to share the code?

> It seems a relevant source of
> trouble is delayed call to the IRQ handler. The problem is
> that only then you try to find out if this IRQ is due to
> rising or falling edge by reading the current GPIO level. When
> you are to late, this might already have changed and you read
> a level, but for the edge of _this_ level you'll receive another
> IRQ a few us later.

I doubt this interpretation. Mostly I don't think you would even
get a second interrupt in this case: It is just a flag that
indicates something has changed, not a counter.

I expect, that you just get one missing edge (which we don't notice,
because we are tolerant about a missing preamble), which would
show as two consecutive edges of the same value - not three as
your explanation suggests.

I don't see, why it wouldn't be possible to recover from that,
in cases, where the delay is small enough for your version to work.

> So the reason that this patch here is showing
> lower error rates seems to be the lower probability of such
> things happening by halving the IRQs to be handled, _plus_
> the information from the hardware, that this IRQ was due
> to a falling edge.

The first part is likely true at the moment and seems enough to
explain the data you have shown. I still believe we could be
smart about the second part in software.

Thanks,
Harald
