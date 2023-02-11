Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBC869300D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 11:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjBKKlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 05:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBKKlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 05:41:46 -0500
Received: from mx.flying-snail.de (mx.flying-snail.de [IPv6:2a06:1c40:3::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EEC1F93A;
        Sat, 11 Feb 2023 02:41:43 -0800 (PST)
Received: from [2a02:908:1b0:8800:2ff:ffff:fe11:2236] (helo=mondbasis.internal.flying-snail.de)
        by mx.flying-snail.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pelzi@flying-snail.de>)
        id 1pQnK3-002gx7-FD; Sat, 11 Feb 2023 11:41:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=feldner-bv.de; s=s1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=dWip9VTCW6cC5nOrzzG2T6wLCYe6+fumRe1N9al6DHc=; b=oLdhkUPtQRGGNj7U+VkxL9yAvh
        VgaJOBYwcH38HW3cxk3d3+PyJvJIugH3XzvguiJumiV4LSX/yZjdxwiTyKj1DPRyOThmwEPoZGrZR
        xactQJdS/cMlBuclOzHmpVEN9gMniEtxBoRQddvmFQsZC+XhDMGhpey7kBqibhLyMvxlixhqxIedz
        T8J4k/AEN2toRZwmVTJSMMMZMznw7QDf3y21lYVvsQac/ICVSUWdn5Y+9N7/nNgL1Zm+k8mXIW2c/
        QszZtg1nHBCsU8Zn2x7/7eWaWjKQnYJpVmmXVGfyRxhHpkBPl4ld3f5eu35Y6csuLft82zxIjgPoU
        kIyyDi9g==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=flying-snail.de; s=s1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To
        :From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=dWip9VTCW6cC5nOrzzG2T6wLCYe6+fumRe1N9al6DHc=; b=JpQMAZsDLay7v3t9XuT5gDz05W
        XXcbqM4UIfUB3RAK2UkEtJEA6CoHJvnd0TJk8vbtfzZTQbvxWUJfoIiKApOJhlX8oZiK+OMTZHerB
        RQtI/ACU5wP+bX/9U0V01c6AqiZst2k9CUXZMEQDsMjYHH7XeDUGvqgl7OAoVnQw4ZCesZrBeneqh
        GJwCfVwt5ITBVk8ITjgmYHclfUZPV+tQzA7sW137cBdxDMhCazPeGRQE85WKVFZcK5EdV51uU/tDl
        kmJjHiLxui2G5VvDWoLizC98rJIudJOQJ6VDVoGscdxQBi5GZ+31PBPWi02VlKJFYxaCASKu2WNK7
        pcoUx9Cw==;
Received: from [2a02:908:1b0:8800:b4d0:2d46:3866:fddf]
        by mondbasis.internal.flying-snail.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <pelzi@flying-snail.de>)
        id 1pQnK0-000cQO-Of; Sat, 11 Feb 2023 11:41:34 +0100
Message-ID: <d96a7c1f-4a12-18c9-377d-df69b17168d2@feldner-bv.de>
Date:   Sat, 11 Feb 2023 11:41:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] iio: dht11: Read bit stream from IRQ on falling edges
 only
To:     harald@ccbib.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y9a0RZ+inWs44Kn8@debian-qemu.internal.flying-snail.de>
 <20230130202216.42034309@jic23-huawei>
 <45efc11e5b4cdba3766f19190bb65840@ccbib.org>
 <e1acd14e-400b-8896-bdc1-0b364cc52198@feldner-bv.de>
 <ac9ab2224ad19ac606de38fa474dce0c@ccbib.org>
From:   pelzi@flying-snail.de
In-Reply-To: <ac9ab2224ad19ac606de38fa474dce0c@ccbib.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 07.02.23 um 11:33 schrieb harald@ccbib.org:

> Thanks, these are indeed interresting results. If you want to move this
> forward, the next steps would be:
> 1) Sharing your test script - yes it's trivial, but still ...

That appears fairly easy, you find the script here:

https://github.com/pelzvieh/banana_resources/tree/main/test_dht11

> 2) A theoretical analysis about possible regressions depending on timer
> resolution as mentioned in an earlier message.

This sounds as if you were doing such an analysis for the original
version. Can you share this work so I can attempt to repeat it
for the modified algorithm?

> 3) Ideally figuring out, why your version performs better then what we
> currently have. I have some suspicions, but better understanding might
> lead to a better approach. E.g. maybe recording the other edges isn't
> the problem so long as we ignore them during decoding?
>
> As I see it, the main thing we are losing with your current proposal is
> some diagnostic features. If we keep them as much as possible and have
> regressions understood and covered, I see no reason to reject your idea.

That's why I changed the script to separately count EIO and ETIMEDOUT.
The latter indicates missed edges, the former failure to interpret
the data read.

What I see is that the patched driver's errors mostly result from missed
IRQ (note in contrast to last results, I cut the number of reads):

#    real[s]    user[s]    sys[s]    success    EIO    timeout err per succ
1     20.57    0.25    0.03    10    0    0    0
2     24.74    0.25    0.07    10    0    4    0,4
3     21.55    0.20    0.07    10    0    0    0
4     25.81    0.25    0.08    10    0    5    0,5
5     21.56    0.23    0.05    10    0    0    0
6     21.58    0.22    0.05    10    1    0    0,1
7     25.86    0.24    0.08    10    1    5    0,6
8     22.69    0.27    0.05    10    1    1    0,2
9     23.67    0.26    0.04    10    0    2    0,2
10     20.55    0.23    0.04    10    0    0    0

Whereas the original driver has more errors resulting from
mis-interpreted data:

#    real[s]    user[s]    sys[s]    success    EIO    timeout err per succ
1     24.88    0.26    0.07    10    5    4    0,9
2     25.91    0.26    0.07    10    4    5    0,9
3     31.27    0.31    0.10    10    6    10    1,6
4     29.17    0.32    0.11    10    7    8    1,5
5     22.73    0.24    0.08    10    4    2    0,6
6     46.46    0.35    0.25    10    19    24    4,3
7     23.79    0.23    0.09    10    3    3    0,6
8     30.17    0.27    0.11    10    6    9    1,5
9     23.77    0.26    0.06    10    3    2    0,5
10     20.58    0.24    0.06    10    1    0    0,1

I tried a variant that reads falling and rising edges and
uses the redundany of information to eliminate some errors.
This did not work out at all. It seems a relevant source of
trouble is delayed call to the IRQ handler. The problem is
that only then you try to find out if this IRQ is due to
rising or falling edge by reading the current GPIO level. When
you are to late, this might already have changed and you read
a level, but for the edge of _this_ level you'll receive another
IRQ a few us later.

So the reason that this patch here is showing
lower error rates seems to be the lower probability of such
things happening by halving the IRQs to be handled, _plus_
the information from the hardware, that this IRQ was due
to a falling edge.

Yours,

Andreas.

