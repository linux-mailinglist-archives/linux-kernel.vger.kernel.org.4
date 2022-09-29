Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD465EEF7F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbiI2HpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbiI2HpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:45:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E925A89E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:45:12 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h7so788439wru.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date;
        bh=guoNLlLK+w+Celq4Xs8AUibS5WLsjCvsO7YfOGTaInU=;
        b=Y+rRU8KWKGamxRVQBlnjssoWflVvUel0TRkBu/ixzRRosKwL3tpkpFu/tlbtGSjABT
         Ap8uEGQIMjaUagsF8Whox/TJN4SPhvMGNQlxdGypGLna4zs4kOMpDsZPHTWCk8Ix2+bK
         6g5UtGpVGAI3sIVza2zjDBqv13XtBGAx9DYqLeELHEtKdw/HQw8Uw9ZXQVK9vFPgCosH
         +4SnNVsqVpnqlrziBgsIB/rkUUXD60nEztCGRwP6SKxMFlFfLnapzGl4bnCddTxBgR7Z
         5+OlEMxcfMwAyLjltlJZBBP6niz/+jniu25Sj46SteH/K5O0FVvsz5fdjHdFxO5bHTar
         9S3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=guoNLlLK+w+Celq4Xs8AUibS5WLsjCvsO7YfOGTaInU=;
        b=fRtouJ7rzq7DGXUA6atfrGGT/dTgqTLsINM5NlCGUJRSf2o9hk6wnJxbr4ZLE6J4ak
         J/1RqyswhGB2Q66yRa6z50gvH3P9gXQqIRANjXKWhauhREzCE+RJlii3IluqoDQqkz9s
         hEsgTWgFwKicEA1UdYlXgZoGVIvCBlFboK3244TjJOiPnVtQN+02H/oG6Oa9aD2lQOjs
         DLkC8VoNbje/EDXO4g2wC3IalzjGsW4CzAeibE+mlv7uHhfUeFMcqJSelXQCCxyBA6Lm
         LocX+F9osKVYdEqnLu3MN+7FaSYELeqdO5HC5wRYzq4rjgE3ezOdhSX26Zbv3tGEl8h/
         Ia5A==
X-Gm-Message-State: ACrzQf3fgvtfktH5pIik+Ozo3knOTGEwU9qDWVNlGRksXcb8UumA+gXM
        ZP9ccs2weHlDS97KWmoUKw8Z+w==
X-Google-Smtp-Source: AMsMyM5qOr+aKl6CXVmJsgvwSPzOsOYlyFFdl+ywgcOSzX9E3l2wuQHCXQIF2AtTfj4K9rQjaguPYA==
X-Received: by 2002:adf:f342:0:b0:22c:c3ea:c6da with SMTP id e2-20020adff342000000b0022cc3eac6damr1151741wrp.567.1664437511407;
        Thu, 29 Sep 2022 00:45:11 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id w1-20020a5d5441000000b0022cc0a2cbecsm5625633wrv.15.2022.09.29.00.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 00:45:11 -0700 (PDT)
Date:   Thu, 29 Sep 2022 09:45:09 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Lin Jinhan <troy.lin@rock-chips.com>, wevsty <ty@wevs.org>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lin Huang <hl@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] hw_random: rockchip: import driver from vendor tree
Message-ID: <YzVNBcF7TCDldPwF@Red>
References: <20220919210025.2376254-1-Jason@zx2c4.com>
 <32f8797a-4b65-69df-ee8e-7891a6b4f1af@arm.com>
 <YzMm4d3sZBHpitm9@aurel32.net>
 <YzNTB+RQK6yITi7/@Red>
 <YzNthZ0MtfwjIqdH@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzNthZ0MtfwjIqdH@aurel32.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Sep 27, 2022 at 11:39:17PM +0200, Aurelien Jarno a écrit :
> On 2022-09-27 21:46, LABBE Corentin wrote:
> > Le Tue, Sep 27, 2022 at 06:37:53PM +0200, Aurelien Jarno a écrit :
> > > On 2022-09-20 10:35, Robin Murphy wrote:
> > > > On 2022-09-19 22:00, Jason A. Donenfeld wrote:
> > > > > The Rockchip driver has long existed out of tree, but not upstream.
> > > > > There is support for it upstream in u-boot, but not in Linux proper.
> > > > > This commit imports the GPLv2 driver written by Lin Jinhan, together
> > > > > with the DTS and config blobs from Wevsty.
> > > > 
> > > > Note that Corentin has a series enabling the full crypto driver for 
> > > > RK3328 and RK3399[1], so it would seem more sensible to add TRNG support 
> > > > to that. Having confliciting compatibles for the same hardware that 
> > > > force the user to change their DT to choose one functionality or the 
> > > > other isn't good (plus there's also no binding for this one).
> > > 
> > > It might make sense for the cryptov1-rng driver (I haven't checked). For
> > > the cryptov2-rng driver, I looked at the RK3568 TRM (I can't find the
> > > RK3588 one), and from what I understand crypto and TRNG are two
> > > different devices, using different address spaces, clock, reset and
> > > interrupts. The vendor kernel uses two different drivers.
> > > 
> > 
> > I confirm that TRNG is not on the same IP on rk3568, something I didnt remark when doing my V2 driver. (I need to remove rng clock from rk3568 dt).
> > But the rk3588 crypto IP and the TRNG are in the same device.
> 
> Ok, thanks for confirming about the rk3568. It seems the only one in the
> family with separate devices for TRNG and crypto. Does it means we need
> a separate TRNG driver only for it? Or could we handle it the same way
> than for instance rk3588 anyway?

I just got now the part 1 of rk3588 TRM which I has missing and it show some conflicting information.
rk3588 seems to have both a dedicated TRNG (TRNG_NS/TRNG_S) with dedicated address space and a TRNG inside the crypto IP.
But for the moment, the TRNG inside crypto IP seems defective.

