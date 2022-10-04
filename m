Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36835F45C0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJDOkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJDOj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:39:57 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5FB13F5D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 07:39:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l12so12871072pjh.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 07:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date;
        bh=P4mAFWZB0+2J3lrFgog0vkkIuYbueNQMwGoFAxLXWhc=;
        b=QzwCA1xVTTqT6fCfAm8Py7ZjFkw2+gH8V6VFcZaT/LhAyDJVoI9Jx2b8O11E0lPEhT
         qq8PV/1eSl1zjAge1q8F5uP2bG321yaHaszvYz97HUAXIbg2N97VdRuGx0u1GvERKvHF
         Lv77rD3YPpHfCstz+S+XEtjgpeE6K92GL8XVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=P4mAFWZB0+2J3lrFgog0vkkIuYbueNQMwGoFAxLXWhc=;
        b=uqLpXDZTfj4eOhnXYIIrLuuPFQFmjc8HR+MamT7+Wo2MgQSf7ZPGV5kTuFDVNDYJZZ
         JeXWvxfQsyFVfwbWqdVTsMQ2Bwz4aahbDqJlYii8AFsav8jI9yQINFjg8jYucu/7m1vg
         ERn4E3T5MaFrF0hx8Fqc3azJgpTeTYoYB7w7K6mtMYcXpbGVlCrJbTIuU4UsFxM2K3Xr
         AVpwadNn3qbRons0WnIDLCc2+o9pihn2DXaOg4fLgLeez4MzPQQDF0j/1RzY5qKphT9z
         XIOx8hSgtrNjgibaIldbe8MTN3+5Av61Cw14ICL+/zZc3YU5eyEHoJEZdeiTLcc1rxpj
         jnRA==
X-Gm-Message-State: ACrzQf0a0q90y7fHBIOmPKEPKifYZ9j3VDrxgWnaUGaHTR6ODCjUfTP8
        dM4kRIj8WpZ0RuFB1dLWlwPrGA==
X-Google-Smtp-Source: AMsMyM7Wkg4hTMYhkwfQbGcZMFPIzxRVjhbiGNb6SGrEfmmes2L9g0q4gEyuG04jwC5kL33DyBoGFA==
X-Received: by 2002:a17:90a:d181:b0:205:e100:3000 with SMTP id fu1-20020a17090ad18100b00205e1003000mr91143pjb.184.1664894396030;
        Tue, 04 Oct 2022 07:39:56 -0700 (PDT)
Received: from [127.0.0.1] (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y20-20020aa78f34000000b005617c676344sm3699186pfr.89.2022.10.04.07.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 07:39:55 -0700 (PDT)
Date:   Tue, 04 Oct 2022 07:39:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/2] minmax: sanity check constant bounds when clamping
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHmME9qAqJrds_R6R6+5MpxJyP-H_w-pwCHQfh26SnLhWJ-2Vg@mail.gmail.com>
References: <CAHmME9pRXpTc2g5R-xj7hTrG00iQ6WLSSRooag1NPzJnyV90Nw@mail.gmail.com> <20220926133435.1333846-1-Jason@zx2c4.com> <202209261125.8AEBF245@keescook> <CAHmME9qAqJrds_R6R6+5MpxJyP-H_w-pwCHQfh26SnLhWJ-2Vg@mail.gmail.com>
Message-ID: <1DA96D23-12A0-4B5B-8032-90D13D4700E4@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On October 4, 2022 6:41:48 AM PDT, "Jason A=2E Donenfeld" <Jason@zx2c4=2Ec=
om> wrote:
>On Mon, Sep 26, 2022 at 8:26 PM Kees Cook <keescook@chromium=2Eorg> wrote=
:
>>
>> On Mon, Sep 26, 2022 at 03:34:34PM +0200, Jason A=2E Donenfeld wrote:
>> > The clamp family of functions only makes sense if hi>=3Dlo=2E If hi a=
nd lo
>> > are compile-time constants, then raise a build error=2E Doing so has
>> > already caught buggy code=2E This also introduces the infrastructure =
to
>> > improve the clamping function in subsequent commits=2E
>> >
>> > Cc: Andy Shevchenko <andriy=2Eshevchenko@linux=2Eintel=2Ecom>
>> > Cc: Andrew Morton <akpm@linux-foundation=2Eorg>
>> > Cc: Kees Cook <keescook@chromium=2Eorg>
>> > Signed-off-by: Jason A=2E Donenfeld <Jason@zx2c4=2Ecom>
>>
>> Reviewed-by: Kees Cook <keescook@chromium=2Eorg>
>
>Wondering - did you ever queue this up for 6=2E1? I assume the plan is
>to hold off on 2/2 for the time being, but this 1/2 is good to have
>either way=2E

Since it produced at least one warning, there may be others in weird archs=
/configs, so I wanted it to bake in -next after the merge window for 6=2E1 =
closes=2E It's a good feature, but I didn't want to risk new build warnings=
 so close to the merge=2E :)

--=20
Kees Cook
