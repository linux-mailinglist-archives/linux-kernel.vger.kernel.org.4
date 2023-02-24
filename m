Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C576A1E50
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjBXPPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjBXPPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:15:41 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DF96CF2D;
        Fri, 24 Feb 2023 07:15:16 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id f31so22225215vsv.1;
        Fri, 24 Feb 2023 07:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mDokjp+52USuJ0wUYWp6uoXjAB+HXWFXB2zkn32gQ/U=;
        b=CCjg5p9NvsYE3qr9A4RakWCCOuZ+hdiUnBRZ/B7Qrk2DxBzm//fbtzKkbYkulMovR9
         GVyOp5gH1vhCVI1QUgQ8n8yr50JCQfnln5uhGMU9StNRy32MfBEruC5JAyDCyXw28fc2
         MmTIgfcw2CUwwGRYrOgbfO6o2RwWmmMca7a/R1jawmblsKKXysm4AEKq4hEVtD3YIxxA
         9wyM0xOD6+oZhONsojyc2Tm5bR6+WOJNDP7TJ5HKiFuWwdjRX3GW6zGIsFdG3sNWnoVZ
         M0tCIP7qzwDEj/7fCKSgWcP73b++UoMOpdyqHeesQsEGHewWWv0YdERD375ULO71/g1B
         AmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDokjp+52USuJ0wUYWp6uoXjAB+HXWFXB2zkn32gQ/U=;
        b=Po8iVcYlPWPdMCXLvi6yw8bSl01IYSq7lNDMM10BN44HdAWRStEeg2DO7Mk22GeZAX
         KrZYzEHF7V6SayqbqMlwkj6F0m00B5vL5+coHuXXcUvPIjuSPRlcz3D/SlPbHDVLj+ms
         UbcOfO1zafY6sD8Zcl1H3cr/scCr18qwg7vvQz8my31RLxXn9t0Iu4aayxYLLmqhOqJA
         KBG124rOO6aHjSzjBumGz4HzAxsOJjOjyqYRgC+6mp3LwmdJWDfW3Hjf3f1OkaY0gu5j
         QD72rsvD/Juy9UygbwslJfO405sOOQafzF3w/Dlr4s1+izdw0uMKpQHOw0muHRQSpImt
         A6aw==
X-Gm-Message-State: AO0yUKXN6n9R5YjN9Cvf/ToiXIvImOKCAy9eIjuJ6pFAJasQ7rE1OIkf
        /pwyfiA3vCkSFzVTCoNBenpUW833b82A1x7yRtc=
X-Google-Smtp-Source: AK7set/ibmdOpvOGHpsjjgVVOPwyDdBA6sxtYIoPVK0XXVGL4ynQjuq0Aw/irHug+Qs3q7tWlFW0k1fRGAibVi1nOrw=
X-Received: by 2002:a05:6102:292a:b0:419:5d5:a62f with SMTP id
 cz42-20020a056102292a00b0041905d5a62fmr40566vsb.3.1677251713405; Fri, 24 Feb
 2023 07:15:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676042188.git.asmaa@nvidia.com> <cover.1676668853.git.asmaa@nvidia.com>
 <28f0d670407c127614b64d9c382b11c795f5077d.1676668853.git.asmaa@nvidia.com>
 <CAHp75VdeVpjzg5Y_4Y+Ke9=3wog28vUBN4Fd8zxfa8dWGrqUUA@mail.gmail.com>
 <CH2PR12MB3895520749883D912E5021F1D7AA9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75Vc+iSt2XvpOYzwZnzX7Qg013e-E27CPjPaO-QmtferWVg@mail.gmail.com>
 <CH2PR12MB389509F68E6AFE776C5B0AC6D7AB9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75VdoUDMvVk1uMQcAKQteL6gbYGpoKpFn96ysdS81LjPGCQ@mail.gmail.com>
 <CH2PR12MB389530C5929100CB54396CF5D7AB9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75VfZ1r_sNus_qMYumja3YrJawA6hRHUbi-uPFUprorQ_Kw@mail.gmail.com>
 <CH2PR12MB3895124032E3276B54570676D7A89@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75VecFVO4jZa3T7P2N5u4fSb-ruFBv9juyCaHnj8HVTPvtg@mail.gmail.com>
In-Reply-To: <CAHp75VecFVO4jZa3T7P2N5u4fSb-ruFBv9juyCaHnj8HVTPvtg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 24 Feb 2023 17:14:36 +0200
Message-ID: <CAHp75VfJ6iBm-cszqnZ3eSE15BYXNByt-9EroukR8wEXT035+Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] gpio: gpio-mlxbf3: Add gpio driver support
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 5:13 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Feb 24, 2023 at 4:42 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:
>
> >            Package () { "gpio-reserved-ranges", Package () {5, 1, 7, 3, 11, 31}},
>
> Side note, doesn't it the same to
>
>            Package () { "gpio-reserved-ranges", Package () {5, 1, 7, 34}},
>
> ?

Ah, now I got it, the 10 is OK, while 7-9 and 11+ are not.

Sorry for the noise.

-- 
With Best Regards,
Andy Shevchenko
