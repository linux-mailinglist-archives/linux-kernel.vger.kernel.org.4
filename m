Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D205EA5B8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 14:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbiIZMOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 08:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239492AbiIZMNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 08:13:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390D583F1F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:58:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MbfT156Rjz4xH5;
        Mon, 26 Sep 2022 20:41:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1664188918;
        bh=HEZDX+hdmRlnC2dInj5wRFncKIFIv8zPT5vq6JPI16A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dYviKgQeC4a6K5nLk1Dv/VPO7kO6Ovmv762fsLquZbh3oMyW8e7qk702YBsbgN5qE
         PVbdL1P0+kg6Bh9IzEemQH/382L9UuPQ9BidydMU8HR3oPEx7XoCmIDycRreWTAqa7
         USdX9ohZ8DcdKHh5F6OpVUMaNOvuflL3F7TP+essB5wEl5qVR4FPEGukHEW3GJPEdZ
         MeHuO/kz5SJayA+e18msw3Alk7VqCar6joboLex+d3R9lmFBE8lkOE++laCQaoecFx
         hD599rgI+AfnyTF0Zdm6mIEUL30jz3aEuapDPVSnBQp2qc5oRu//AM7mNs/wEU+oQs
         9I6Orm0RPT/QQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ssx@qnx.com" <ssx@qnx.com>
Subject: Re: Is PPC 44x PIKA Warp board still relevant?
In-Reply-To: <ed43b0d6-d6d4-73d2-b4ab-637f6d2e310e@csgroup.eu>
References: <Yy/hv2fOLzdWOuvT@google.com>
 <ed43b0d6-d6d4-73d2-b4ab-637f6d2e310e@csgroup.eu>
Date:   Mon, 26 Sep 2022 20:41:53 +1000
Message-ID: <87o7v2zaby.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Hi Dmitry
>
> Le 25/09/2022 =C3=A0 07:06, Dmitry Torokhov a =C3=A9crit=C2=A0:
>> Hi Michael, Nick,
>>=20
>> I was wondering if PIKA Warp board still relevant. The reason for my
>> question is that I am interested in dropping legacy gpio APIs,
>> especially OF-specific ones, in favor of newer gpiod APIs, and
>> arch/powerpc/platforms/44x/warp.c is one of few users of it.
>
> As far as I can see, that board is still being sold, see
>
> https://www.voipon.co.uk/pika-warp-asterisk-appliance-p-932.html

On the other hand it looks like PIKA technologies went bankrupt earlier
this year.

>> The code in question is supposed to turn off green led and flash red led
>> in case of overheating, and is doing so by directly accessing GPIOs
>> owned by led-gpio driver without requesting/allocating them. This is not
>> really supported with gpiod API, and is not a good practice in general.
>
> As far as I can see, it was ported to led-gpio by
>
> ba703e1a7a0b powerpc/4xx: Have Warp take advantage of GPIO LEDs=20
> default-state =3D keep
> 805e324b7fbd powerpc: Update Warp to use leds-gpio driver
>
>> Before I spend much time trying to implement a replacement without
>> access to the hardware, I wonder if this board is in use at all, and if
>> it is how important is the feature of flashing red led on critical
>> temperature shutdown?
>
> Don't know who can tell it ?

I would be surprised if anyone is still running upstream kernels on it.

I can't find any sign of any activity on the mailing list related to it
since it was initially merged.

> Maybe let's perform a more standard implementation is see if anybody=20
> screams ?

How much work is it to convert it?

Flashing a LED when the machine dies is nice, but not exactly critical,
hopefully the machine *isn't* dying that often :)

cheers
