Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E88F5EBA4B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 08:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiI0GBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 02:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiI0GBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 02:01:06 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164FC9E8A6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 23:01:05 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so9150348pjl.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 23:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=KmMk56mDUlyDTTT32tWxFwynOn3qJ7x9u3+7ehaDfuo=;
        b=KCy0tVmVEkDRvL4k8tW4HdlD7/t4El1jiHZ/dK47R/aICnJoUkkAUmo7AfVY2Sum58
         STsc7/BM9qCcEUSA5QTukxQNCgmkxBPhsEv4X9Xd1HxclqWEjwEnOCwIDihX72hVZzZ3
         mzJ9bOI2bpGJ0+DRjaMHDCADTwuU28HL45U7c1RgaCbWVnmDNHSHhR1ugvspk6fEo2io
         4MnbydsfNVyETPaug3dBlYni4GsZrgNYc5N0+3W4AcLN+aP41jaQnrmhJxUORJAH5hpQ
         OBn6x69D4YMZN42Og6X9g6Wn8+cEnJmtxiHi80xbBnO5VmLlKHIYYk/FNbvLtI+mnIvs
         FRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KmMk56mDUlyDTTT32tWxFwynOn3qJ7x9u3+7ehaDfuo=;
        b=mUu5X1Og1hmjJH0z5bXvYHtAMbIxTkU/FzshwRL83NVcFzXAhFZLT6a3Vny5ld2m9Y
         mh+A/IgVa1k3iwDxFJm2SBJLwr7DpypEdW8jJRgV0U2JxBf8BCAX4WZ6B/pfJ49FKPp2
         KC0/wr1DpDo92pMiyKkB1aO6XuEyryCNoXrlCrsElIbCt1s5KWH5O6d9hOO++Nf41Jro
         /ytn6WQl/j3bpX/mF/QQ7OUdNTJyKcYv9ia2USjd1IE9v1r/NgUIolAlsGJYsIpRNFd9
         RVNrhsi4zGIoVNgPe7pAFPbIE2bVzKHXfk7fKFgWT8Il3lX6iibJg6+897IvCyXe8ckD
         DlGw==
X-Gm-Message-State: ACrzQf2Ij8eqAKXT2LIB1ihYZtA3OpNX72DqObqSlnPJU8XLXrxgsYeW
        muwWY7oEia+FFDzfEqKDX9s=
X-Google-Smtp-Source: AMsMyM6wTi9h110kts0nAn7gMK8AVBYLbc/xGdTaubZBOpxPIgmpCmDeU8r8ymWE0aiXhIs1JZ3bNg==
X-Received: by 2002:a17:903:2346:b0:178:4c17:eef7 with SMTP id c6-20020a170903234600b001784c17eef7mr25015442plh.30.1664258464390;
        Mon, 26 Sep 2022 23:01:04 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9739:ab49:3830:2cbb])
        by smtp.gmail.com with ESMTPSA id a203-20020a621ad4000000b0053b0d88220csm641172pfa.3.2022.09.26.23.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 23:01:03 -0700 (PDT)
Date:   Mon, 26 Sep 2022 23:01:01 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ssx@qnx.com" <ssx@qnx.com>
Subject: Re: Is PPC 44x PIKA Warp board still relevant?
Message-ID: <YzKRnaFYmaQd2XWD@google.com>
References: <Yy/hv2fOLzdWOuvT@google.com>
 <ed43b0d6-d6d4-73d2-b4ab-637f6d2e310e@csgroup.eu>
 <87o7v2zaby.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o7v2zaby.fsf@mpe.ellerman.id.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 08:41:53PM +1000, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> > Hi Dmitry
> >
> > Le 25/09/2022 à 07:06, Dmitry Torokhov a écrit :
> >> Hi Michael, Nick,
> >> 
> >> I was wondering if PIKA Warp board still relevant. The reason for my
> >> question is that I am interested in dropping legacy gpio APIs,
> >> especially OF-specific ones, in favor of newer gpiod APIs, and
> >> arch/powerpc/platforms/44x/warp.c is one of few users of it.
> >
> > As far as I can see, that board is still being sold, see
> >
> > https://www.voipon.co.uk/pika-warp-asterisk-appliance-p-932.html
> 
> On the other hand it looks like PIKA technologies went bankrupt earlier
> this year.
> 
> >> The code in question is supposed to turn off green led and flash red led
> >> in case of overheating, and is doing so by directly accessing GPIOs
> >> owned by led-gpio driver without requesting/allocating them. This is not
> >> really supported with gpiod API, and is not a good practice in general.
> >
> > As far as I can see, it was ported to led-gpio by
> >
> > ba703e1a7a0b powerpc/4xx: Have Warp take advantage of GPIO LEDs 
> > default-state = keep
> > 805e324b7fbd powerpc: Update Warp to use leds-gpio driver
> >
> >> Before I spend much time trying to implement a replacement without
> >> access to the hardware, I wonder if this board is in use at all, and if
> >> it is how important is the feature of flashing red led on critical
> >> temperature shutdown?
> >
> > Don't know who can tell it ?
> 
> I would be surprised if anyone is still running upstream kernels on it.
> 
> I can't find any sign of any activity on the mailing list related to it
> since it was initially merged.
> 
> > Maybe let's perform a more standard implementation is see if anybody 
> > screams ?
> 
> How much work is it to convert it?
> 
> Flashing a LED when the machine dies is nice, but not exactly critical,
> hopefully the machine *isn't* dying that often :)

OK, I think I figured out how to let platform code access the GPIOs
while still using leds-gpio driver for normal operation. I will send a
patch shortly.

Thanks.

-- 
Dmitry
