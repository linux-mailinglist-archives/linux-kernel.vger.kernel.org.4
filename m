Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456226D1760
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjCaG0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCaG0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:26:32 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D37D52B;
        Thu, 30 Mar 2023 23:26:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so14332731wmq.2;
        Thu, 30 Mar 2023 23:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680243974;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mu9CebZO0eshSauLlTyKtS5NCzddpSF3sP6M8+rl2s4=;
        b=dRGX3JBTxDGgR4gPCe5vC+difAx6W8kPn7GB1KHDSL+C6xJi9wWuUU2cygrfOX9QM5
         kEWtw4k6M4ltWSjsfWUlqA7cPQeyF8l5TkhDyF26E8NqxEyeRS+uxj/3Mr67QPFMLVhD
         bMW9VVkwHTQQ6OA8n98CjaLMoX+cTi1Q/RKJ3C7ccLHM4HcSpdWpUNdKLQdP4aB5WvYi
         4Ms5fbkDZ8fv5H4Dne0FHWgT8ENPOwK//XTglfj+dmskRi1EUo0i7MGNhRJEn+XK1VXb
         QZGweSoO2WFqR1ed3qIF//SgIL5d3U0mL/6ihxBEVO+AQynheqXDX4W6o4Y2YC5Xsgwi
         fb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680243974;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mu9CebZO0eshSauLlTyKtS5NCzddpSF3sP6M8+rl2s4=;
        b=6+Vp7STD7r3Q8I/MWCUQl+RgrrXcMH/PMvHEfWqd0c6SKXF8mOyABijytGDXk4BJOs
         s6BgKbk7fSs6dLTEQMmYWGObTmb//4PYTQPELxwjuBnh9znydA0uFOyxthWm0oK0TMIW
         EHN+WUZpbyrFcyKiFbMWljv2IdesdRQgQ4Sx6DPhO2rjB2BHV1wNqRQK2z9PCVn05S2Z
         227NQ2uUa6GKG8T3At9cskc6W1sWGxDpfbMP7b3TUKkx4KLvsHx+LURjt3iZyP8iKamg
         V6nWaLIWdCdfqutZB7st1jnW6zJy+MXEoguuPi68Hb7ytDVMQorht2YObmW+cFveLvl1
         CRIg==
X-Gm-Message-State: AAQBX9cbMV5Q5H2zIXgiWWOSBeCveHLaxvzjsELwFpzeDRUyEwv6Wdvs
        SVtZ1mQSKq/rVkme9u+l+WXZwDsA81QrU/Xl
X-Google-Smtp-Source: AKy350asWuF9LXvvqpmz/y3EOVXRzpCtGaOXxVSLqp8MpRVy9w2kpOGRruJ6CE/ZCbrsIDw90baQ4g==
X-Received: by 2002:a1c:f216:0:b0:3ef:5e17:1ed9 with SMTP id s22-20020a1cf216000000b003ef5e171ed9mr17061834wmc.31.1680243974054;
        Thu, 30 Mar 2023 23:26:14 -0700 (PDT)
Received: from ?IPv6:2001:a61:2b4b:9d01:5416:2b94:da5d:3156? ([2001:a61:2b4b:9d01:5416:2b94:da5d:3156])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b003ef6708bc1esm8812464wmq.43.2023.03.30.23.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 23:26:13 -0700 (PDT)
Message-ID: <cf20f272465717da960ae3a3c04eb6c1ebfaf3d3.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7192: Change "shorted" channels to
 differential
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alisa Roman <alisa.roman@analog.com>
Date:   Fri, 31 Mar 2023 08:26:12 +0200
In-Reply-To: <20230330102100.17590-1-paul@crapouillou.net>
References: <20230330102100.17590-1-paul@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-03-30 at 12:21 +0200, Paul Cercueil wrote:
> The AD7192 provides a specific channel configuration where both
> negative
> and positive inputs are connected to AIN2. This was represented in
> the
> ad7192 driver as a IIO channel with .channel =3D 2 and .extended_name
> set
> to "shorted".
>=20
> The problem with this approach, is that the driver provided two IIO
> channels with the identifier .channel =3D 2; one "shorted" and the
> other
> not. This goes against the IIO ABI, as a channel identifier should be
> unique.
>=20
> Address this issue by changing "shorted" channels to being
> differential
> instead, with channel 2 vs. itself, as we're actually measuring AIN2
> vs.
> itself.
>=20
> Note that the fix tag is for the commit that moved the driver out of
> staging. The bug existed before that, but backporting would become
> very
> complex further down and unlikely to happen.
>=20
> Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of
> staging")
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Co-developed-by: Alisa Roman <alisa.roman@analog.com>
> Signed-off-by: Alisa Roman <alisa.roman@analog.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



