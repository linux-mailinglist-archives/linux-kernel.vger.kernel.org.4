Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E34862C741
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiKPSI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPSI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:08:57 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC1C6441;
        Wed, 16 Nov 2022 10:08:54 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bp15so30742288lfb.13;
        Wed, 16 Nov 2022 10:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGPzAc+Fwv9glX3kTXQZEC8wdiu/HXobhJKfPZvAq8Q=;
        b=lIb6GWkjW3nm9obLcbKwJ5hHecVrnM0Mwa8ygrNEjhDOkvpSJv+SUgMFXMuyRTL9Eu
         pnoaEk7Fn5/f9OIwhrP9ZIoTQpKi6O5sRmEqXa/GFqzWM13SmBANP51XdQgklOv0Afn6
         CbMGyTtIaIqY0UigE/CDv7sOJ3aQFxjcRtoY5JkeKXqZNpLRQCGgEo6bt4DqBYghyOE3
         RbQRjO7OfoDIHP2XFFbg8tIcHNQLV0QWRE2SGHo+AvJ4PX2fDO1ju5FvCQBNBhnqXzgu
         XxAo8pJ8nvUa2GBbATBB3Q8bRY/AbissW9BjhEwtInKeGYPY77tsZDa/6Q1OasqJ+sSt
         5ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sGPzAc+Fwv9glX3kTXQZEC8wdiu/HXobhJKfPZvAq8Q=;
        b=OpLvnPhq67+C8ZpzuJDGSNem2W9XA3Qmczp3GROvjr8scXgos73LIYzLY4pLjNM2kz
         Yy32PNoFNVO2bXmwQP4Xg7YsQnN5to9FN6HP/MDpCKiI7oXc/+J5X/I4zUUm5tlnn+CD
         pEPNzaueTcq+T3bExOVt2cPPPx1ZTBI0j/YqPdqHd5AkDSObjQfF4kIeVzxrmx+RI0rk
         z7CAbqlqgojMF4SoKCDa+qR5ORMiKNVa8ujAXIrZQ4//bgOMQZ8OF6I7kpDA3S8YHkCL
         Af+Ymrt85MNRA83oqIJVKPj751+Jl1rd6U4F19VwZXF8k4tUgpYH6cq8WXaCStKANAnW
         wSlQ==
X-Gm-Message-State: ANoB5pmnhlwo5nStCxH8tDfD9X1S/xmWg+jnlqvl3dRpAK1VVPgmg/zk
        oUqn3ZsP1GsLCGZ+NjGbvLIiROVzgrTvtg==
X-Google-Smtp-Source: AA0mqf6Z9JMkR/b8e0qR+12V9efjvNZdrN1ukzJGnaa6eiokmlSLuDOIPzOVDtVZQripHRf/klb7Vg==
X-Received: by 2002:a05:6512:3d8d:b0:4a2:4aad:8fff with SMTP id k13-20020a0565123d8d00b004a24aad8fffmr7197273lfv.445.1668622132777;
        Wed, 16 Nov 2022 10:08:52 -0800 (PST)
Received: from razdolb (95-31-190-12.broadband.corbina.ru. [95.31.190.12])
        by smtp.gmail.com with ESMTPSA id i6-20020a2ea366000000b00278e5d12be3sm3033465ljn.127.2022.11.16.10.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 10:08:51 -0800 (PST)
References: <20220919210025.2376254-1-Jason@zx2c4.com>
 <32f8797a-4b65-69df-ee8e-7891a6b4f1af@arm.com>
 <YzMm4d3sZBHpitm9@aurel32.net> <YzNTB+RQK6yITi7/@Red>
 <YzNthZ0MtfwjIqdH@aurel32.net> <YzVNBcF7TCDldPwF@Red>
User-agent: mu4e 1.9.0; emacs 28.2
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Lin Jinhan <troy.lin@rock-chips.com>, wevsty <ty@wevs.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lin Huang <hl@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] hw_random: rockchip: import driver from vendor tree
Date:   Wed, 16 Nov 2022 21:04:07 +0300
In-reply-to: <YzVNBcF7TCDldPwF@Red>
Message-ID: <87y1sasrf2.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022-09-29 at 09:45 +02, LABBE Corentin <clabbe@baylibre.com> wrote:
> Le Tue, Sep 27, 2022 at 11:39:17PM +0200, Aurelien Jarno a =C3=A9crit :
>> On 2022-09-27 21:46, LABBE Corentin wrote:
>> > Le Tue, Sep 27, 2022 at 06:37:53PM +0200, Aurelien Jarno a =C3=A9crit :
>> > > On 2022-09-20 10:35, Robin Murphy wrote:
>> > > > On 2022-09-19 22:00, Jason A. Donenfeld wrote:
>> > > > > The Rockchip driver has long existed out of tree, but not upstre=
am.
>> > > > > There is support for it upstream in u-boot, but not in Linux pro=
per.
>> > > > > This commit imports the GPLv2 driver written by Lin Jinhan, toge=
ther
>> > > > > with the DTS and config blobs from Wevsty.
>> > > >
>> > > > Note that Corentin has a series enabling the full crypto driver for
>> > > > RK3328 and RK3399[1], so it would seem more sensible to add TRNG s=
upport
>> > > > to that. Having confliciting compatibles for the same hardware that
>> > > > force the user to change their DT to choose one functionality or t=
he
>> > > > other isn't good (plus there's also no binding for this one).
>> > >
>> > > It might make sense for the cryptov1-rng driver (I haven't checked).=
 For
>> > > the cryptov2-rng driver, I looked at the RK3568 TRM (I can't find the
>> > > RK3588 one), and from what I understand crypto and TRNG are two
>> > > different devices, using different address spaces, clock, reset and
>> > > interrupts. The vendor kernel uses two different drivers.
>> > >
>> >
>> > I confirm that TRNG is not on the same IP on rk3568, something I didnt=
 remark when doing my V2 driver. (I need to remove rng clock from rk3568 dt=
).
>> > But the rk3588 crypto IP and the TRNG are in the same device.
>>
>> Ok, thanks for confirming about the rk3568. It seems the only one in the
>> family with separate devices for TRNG and crypto. Does it means we need
>> a separate TRNG driver only for it? Or could we handle it the same way
>> than for instance rk3588 anyway?
>
> I just got now the part 1 of rk3588 TRM which I has missing and it show s=
ome conflicting information.
> rk3588 seems to have both a dedicated TRNG (TRNG_NS/TRNG_S) with dedicate=
d address space and a TRNG inside the crypto IP.
> But for the moment, the TRNG inside crypto IP seems defective.

So what's the ultimate decision? Does anyone work on merging this into
the existing crypto driver? I have a use case with an rk3399-based board,
where having hardware rng enhances boot times dramatically (at least for
some userspaces; see also [1]).

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D216502

--
Best regards,
Mikhail Rudenko
