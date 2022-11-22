Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E939633DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbiKVN3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiKVN3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:29:11 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D44C64A08
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:29:09 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id b12so10910438wrn.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wEZwlBsaNUHpzzIaIKYU5AHosPkhDJnwQiQeyEIzxao=;
        b=hR4YQdlV1EkXRHumuFyTMUphoGnSOoi+kBYKhoZwncrNATTRb4Aq+D8dU84gikCAjg
         NJH5I3o17DN36Fu5o0sd5qptScMWUHOddYlLHDb4o3o9tnkrBSxmC8N7hMJRdogxkQ5C
         NtzV5tAPHOweNoXQbGVy2H49TkRp5XyA/jXXP1y4gmbC3BMzkUBtqkPj9DLPoBDdUuq/
         tqgPfK1483mmQEIe6eJUmW6XeJ/OlQCgcFO3Sd8361s1aNDohJL+x1lrI/rivrqWawxj
         0bOjWe9JX0T06VXEqDzilosZb0nr9FUQgQ49TzmVGRRO7XwDBJm/1wBnwobvB496NVYp
         877Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wEZwlBsaNUHpzzIaIKYU5AHosPkhDJnwQiQeyEIzxao=;
        b=AOtjeXmxGpPNllFwQmjpSzMIw6LOQZfmZMaLo0+5Zix3obfPg7BcbTdIeCQ+/FsUGc
         yUXACQOJBQ0WuueerslhV4wQCbDuwG0DXwmzVmRg+qdYj7Owbyg/5OnmOcn37yo3EFia
         ZFv65q35J9iYzJQC6rySh+S3Nt4zgTIR8f9+SAfAidI1/LHTZNU3y9bsmFES0UYt9mUu
         YjWpLmvbWUkAsltIGzQ9T/GhZW1ZRr097LI/cEtknmFA9Emt4TDQHZavAHSpZwe6Le7a
         ifayrXxCGoCVu/OS9SO8vuqhX0pNaQr3G1MUL3ONpVvrYBYKC1ST5fEuM579xgY+zXXa
         4vKQ==
X-Gm-Message-State: ANoB5pnNbErHd4coXAXdqHP+ys6aw55m1x4zVgRjmxyWOGLplb2n1ZeK
        RAc4LEzInqwNTwjhhk0iqfJuLg==
X-Google-Smtp-Source: AA0mqf6TJNdia6Nf3lWNpAMXvciXnOpBoF68QQGih3K11l7S5CRfE3Qn1emQkxJlMHXKWTmqnaMjpg==
X-Received: by 2002:adf:f50d:0:b0:23a:cdf5:3676 with SMTP id q13-20020adff50d000000b0023acdf53676mr15105069wro.336.1669123748006;
        Tue, 22 Nov 2022 05:29:08 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id o2-20020a05600c510200b003cf5ec79bf9sm19435110wms.40.2022.11.22.05.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 05:29:07 -0800 (PST)
Date:   Tue, 22 Nov 2022 14:29:03 +0100
From:   Corentin LABBE <clabbe@baylibre.com>
To:     Mikhail Rudenko <mike.rudenko@gmail.com>
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
Message-ID: <Y3zOn5IO1ziJXKUT@Red>
References: <20220919210025.2376254-1-Jason@zx2c4.com>
 <32f8797a-4b65-69df-ee8e-7891a6b4f1af@arm.com>
 <YzMm4d3sZBHpitm9@aurel32.net>
 <YzNTB+RQK6yITi7/@Red>
 <YzNthZ0MtfwjIqdH@aurel32.net>
 <YzVNBcF7TCDldPwF@Red>
 <87y1sasrf2.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y1sasrf2.fsf@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Nov 16, 2022 at 09:04:07PM +0300, Mikhail Rudenko a écrit :
> 
> On 2022-09-29 at 09:45 +02, LABBE Corentin <clabbe@baylibre.com> wrote:
> > Le Tue, Sep 27, 2022 at 11:39:17PM +0200, Aurelien Jarno a écrit :
> >> On 2022-09-27 21:46, LABBE Corentin wrote:
> >> > Le Tue, Sep 27, 2022 at 06:37:53PM +0200, Aurelien Jarno a écrit :
> >> > > On 2022-09-20 10:35, Robin Murphy wrote:
> >> > > > On 2022-09-19 22:00, Jason A. Donenfeld wrote:
> >> > > > > The Rockchip driver has long existed out of tree, but not upstream.
> >> > > > > There is support for it upstream in u-boot, but not in Linux proper.
> >> > > > > This commit imports the GPLv2 driver written by Lin Jinhan, together
> >> > > > > with the DTS and config blobs from Wevsty.
> >> > > >
> >> > > > Note that Corentin has a series enabling the full crypto driver for
> >> > > > RK3328 and RK3399[1], so it would seem more sensible to add TRNG support
> >> > > > to that. Having confliciting compatibles for the same hardware that
> >> > > > force the user to change their DT to choose one functionality or the
> >> > > > other isn't good (plus there's also no binding for this one).
> >> > >
> >> > > It might make sense for the cryptov1-rng driver (I haven't checked). For
> >> > > the cryptov2-rng driver, I looked at the RK3568 TRM (I can't find the
> >> > > RK3588 one), and from what I understand crypto and TRNG are two
> >> > > different devices, using different address spaces, clock, reset and
> >> > > interrupts. The vendor kernel uses two different drivers.
> >> > >
> >> >
> >> > I confirm that TRNG is not on the same IP on rk3568, something I didnt remark when doing my V2 driver. (I need to remove rng clock from rk3568 dt).
> >> > But the rk3588 crypto IP and the TRNG are in the same device.
> >>
> >> Ok, thanks for confirming about the rk3568. It seems the only one in the
> >> family with separate devices for TRNG and crypto. Does it means we need
> >> a separate TRNG driver only for it? Or could we handle it the same way
> >> than for instance rk3588 anyway?
> >
> > I just got now the part 1 of rk3588 TRM which I has missing and it show some conflicting information.
> > rk3588 seems to have both a dedicated TRNG (TRNG_NS/TRNG_S) with dedicated address space and a TRNG inside the crypto IP.
> > But for the moment, the TRNG inside crypto IP seems defective.
> 
> So what's the ultimate decision? Does anyone work on merging this into
> the existing crypto driver? I have a use case with an rk3399-based board,
> where having hardware rng enhances boot times dramatically (at least for
> some userspaces; see also [1]).
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=216502
> 

Hello

I started to work on adding RNG to rk3288_crypto.
I need to publish the work on my github and take time to send it for review.

Regards
