Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F3E61E0F5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 09:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiKFIrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 03:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiKFIrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 03:47:49 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C632EDF4D;
        Sun,  6 Nov 2022 01:47:44 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id e189so6776418iof.1;
        Sun, 06 Nov 2022 01:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tl8AdY8shZ6VR0Z35R5mpGYHWzkhOvd66q+gzVbH9aM=;
        b=h1doJXpsMSTQl4tzBG4ig/HF0x+HsG38yED6O46wvTwfxiXiRy4CrVjIs+4vWZCXxT
         5uOPa8xRkdSCI+vwWhy4aBrRsFk+m1KIzjcC7A0WypWTAqDGtEZUoYpWuFvIeob6YZyC
         5Gn0YM++R1CpKG6kbttUo8+uvwelB1UJTcagXaJaGwhhQXhG/Hl3YCsGeZf9sstp4239
         ldyOVfQIT5MzHa9t6Z+I9S6du/Vt3QTAoHVsy7EyKk0708R/jSCLDflFScXyeua61crp
         mqjULaZGgYxjzi2TwBGyJ36axUCwVOl4iRRn+4Ct6Q2G7s0FszJzUdienYP7p3wJXyy5
         ZcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tl8AdY8shZ6VR0Z35R5mpGYHWzkhOvd66q+gzVbH9aM=;
        b=S9OjY6qP29k+phr2T3Lntk7T3R1KDmWfqm/wGc/TL3wwrt3bgN2OZ47fc/hhjbyl8J
         73T8pvU2pmEvVWzy/hMNF3/8ROMVNevBox3Eh7p99IZpNslp1LULp3l2zIWZITLSvGkN
         DSHxeN7dQwRCBwiJuBm4qE6N+/f0CGz+bEJJxugaVj/zpKUwtYKoTCJtOrl+zJlhVziL
         3y6iUyWbIOebIk+M7hGjasXPumGczwr9kpQJ49IaIQzjtDWl37lW8w0PtHnf3YoUYis/
         dY9/CNky54gBOzK06e8QeQqk0DhKCvhMhhhKC9Rw+LvUWUJE0p3FbjAceEnQ3KpwmY1u
         tszQ==
X-Gm-Message-State: ACrzQf3qJfZ1+uFiULowd1dmTIrRQg7cgzztnix/9wvhCKhI/vgAGbrf
        6VFc02GC2cbSAuFtKuZ750HgHNZ9+lANoo9DNXY=
X-Google-Smtp-Source: AMsMyM65EOV0lgb6mo6/h3uBN1Q3BHFNwSwt4Rv+2PpTbOH0NSBnfT8jj1mHABRWQ4YgxTWTfsReEcXP04bbiZYfuCI=
X-Received: by 2002:a5d:9552:0:b0:6ce:64b7:5198 with SMTP id
 a18-20020a5d9552000000b006ce64b75198mr18581191ios.108.1667724464169; Sun, 06
 Nov 2022 01:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221031190159.1341027-1-lis8215@gmail.com> <W1FWKR.P26T1W42X3ND@crapouillou.net>
In-Reply-To: <W1FWKR.P26T1W42X3ND@crapouillou.net>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Sun, 6 Nov 2022 11:47:31 +0300
Message-ID: <CAKNVLfaK+XOSzJLurv5pDobvFqS+jAiub4P6n0DgO5RpUnw-hg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Input: adc-joystick: add detachable devices support
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=B2=D1=81, 6 =D0=BD=D0=BE=D1=8F=D0=B1. 2022 =D0=B3. =D0=B2 02:39, Paul C=
ercueil <paul@crapouillou.net>:
>
> Hi Siarhei,
>
> Le lun. 31 oct. 2022 =C3=A0 22:01:57 +0300, Siarhei Volkau
> <lis8215@gmail.com> a =C3=A9crit :
> > For detachable or lock-able joysticks the ADC lanes might
> > be biased to GND or AVDD when the joystick is detached/locked.
> >
> > One such kind of joystick is found in the Ritmix RZX-50 handheld.
> > The joystick is non-detachable, although ADC lane biased to power
> > supply when the "Hold" switch is activated.
>
> But the RZX-50 has no joystick...

Well, actually there's two versions in the wild (google "RZX-50 pictures"):
 - with analog joystick and speakers on the back side
 - without the joystick and speakers on the front side
I have only the first one at the moment, but I'm looking for another one.

> Or is the d-pad actually wired to the ADC instead of GPIOs?

The D-Pad is another kind of pain there - it's a part of the matrix-keypad
but the pad's row line is shared with the LCD HSYNC signal.

> > To avoid reporting old/broken measurements valid-range is introduced.
> > When measured value is outside valid-range the driver reports
> > safe center position for corresponding axis.
>
> First of all, you already have a "valid range", it is called
> "abs-range"; no need for a new one.
>
> Then, the driver has no business doing events filtering. Notice that
> when you activate the "hold" button and your joystick values go way
> off-range, you still get input events in userspace: that's because the
> kernel is not responsible for enforcing the deadzone, the userspace is.
>
> In your case, you need to update your userspace applications/libraries
> so that when the joystick values are way off-range, the assumed
> position is the center.

Many userspace apps use SDL library to handle joystick input, the SDL
unfortunately hides the fact that the joystick position is out of range -
it does normalization and clamping of the abs-range to an int16_t range.

I see two approaches to do that in userspace:
1. Make a quirk in the SDL library, which affects many types of joysticks
and lead to a fragmentation (special userspace apps for every hardware
isn't the right way in my opinion).
2. Make a special filter app which will filter out invalid joystick events =
and
route rest to the /dev/input/uinput. Not sure how to hide the real joystick
device from libraries like SDL then.
Both of them don't look like a "silver bullet", however feasible.

>
> Cheers,
> -Paul
>
>

Thank you.
