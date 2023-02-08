Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F5A68F693
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjBHSHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjBHSHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:07:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B1D2729;
        Wed,  8 Feb 2023 10:06:34 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675879572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TJyyEP+2zyH/1oQ9zD72ku6IC7RttH4uz95V08xZf24=;
        b=Ljf4DP4AD6qeHR1CdXi7ByaqM03TLrPFtZ/Vzg1lhWFHtisaVisHHqt8osWevPNSzlK1XY
        M7bg7Z/oLs8IN4UB9TuXyiV3o7dHRqRWKa2gZ3wdH7gW7mDu+QohHnaSuQbLlSqFKh/XvX
        VOhY4Zgx8J/K7fsfKunXiezyzt+jNaBHNUmq5tF4OMZ8cpA9RsKldutwckCqE+GzISKwmw
        +tNmIxX9C5k3kuD8c8Ox6Scl0wfFwyH24PiDVwDkVggv6P1SVcwXnZS6wXET6ohqGelmjK
        NvyVtrrE8RAtX96heAeDXj36RHx4S2IjsIOHLzKqmy1GuPzzcr7Xyip0v6eDow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675879572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TJyyEP+2zyH/1oQ9zD72ku6IC7RttH4uz95V08xZf24=;
        b=jjfrI34yUr2unTU5GIfvn8Yc4INbZj5pjttak/YqQmsEpyVZCttuS+Jd70aXZ7u7XOaD5i
        +HxnjC+zfu0oIkCw==
To:     Michael Trimarchi <michael@amarulasolutions.com>
Cc:     Michael <michael@mipisi.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Problem when function alarmtimer_suspend returns 0 if time
 delta is zero
In-Reply-To: <Y+O+VBSNywC7LKhn@panicking>
References: <S1728511AbfHaSEm/20190831180442Z+580@vger.kernel.org>
 <08fbdf25-faa1-aa13-4f13-d30acbf27dda@mipisi.de>
 <20190902074917.GA21922@piout.net>
 <alpine.DEB.2.21.1909021247250.3955@nanos.tec.linutronix.de>
 <4fc3a016-ec2f-a15e-5fd1-6794a001e2d9@mipisi.de>
 <alpine.DEB.2.21.1909040047210.1902@nanos.tec.linutronix.de>
 <Y+O+VBSNywC7LKhn@panicking>
Date:   Wed, 08 Feb 2023 19:06:11 +0100
Message-ID: <87edr02fsc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael!

On Wed, Feb 08 2023 at 16:23, Michael Trimarchi wrote:
> On Wed, Sep 04, 2019 at 12:49:21AM +0200, Thomas Gleixner wrote:
>> On Tue, 3 Sep 2019, Michael wrote:
>> > 
>> > thank you very much for your patch. Unfortunately currently I can only test it
>> > with a kernel 4.1.52 but i've tried to patch
>> > your new logic into my older kernel version.
>>
> Is this patch valid on mainline too? because apply it was let rtc
> working 100% of the time

I wrote that patch against the back then mainline code. No idea if it's
still applying, but the underlying issue is still the same AFAICT.

It needs some polishing and a proper changelog.

Thanks,

        tglx


