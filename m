Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57AE6B0482
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjCHKeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjCHKdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:33:19 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804052057B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:33:03 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id by13so14949489vsb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678271582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTy8L/bjoQ+eUTbs+SF3teVKfIdqhIWOgK22nmCkyus=;
        b=pfMpzZyUSU4NMXOHiamdefO53InD/hLu0bAZST+wrc8Cm21SEFmZWSeC6xc3XoUZD9
         wFViwQhJVHIKDomTV7MvlXtIpxUra0Ldlk+QL2FpQO8VLt69+2ZtRrd3OcB7N4k9Wyv1
         SXb622Eh9STkc00RLupgn9pe3fojxDuZbgUWfw7U6dKgaVYNDZvO8Sugwly/uAaXBwxe
         /qT/phgnapUHsSfhzduyySE2VM/mLf2dFWaiHZVlpyRpdudgkWQC7jnOcQb/WPURNn0u
         U8limiYANJOkGejj99FvFp+NEqf+3g2oHZftPTwuLYslAZfJIO1Gd9SA//PDDUM5mCce
         mNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678271582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTy8L/bjoQ+eUTbs+SF3teVKfIdqhIWOgK22nmCkyus=;
        b=HNluM3ZYKwR0YthoQ7gOgfnszwvaxdJZe516beDXC7j5d0OOPdc5s/VY/PCZ6RfAFg
         F0xfmVBQQSTwFNkDfvtcSpVk9VvvQrsNOwvPL4CZ4AYrJt3zW28C2KnM9+r2Xdia9F5v
         aOgjZsYxCiPxYPhY7zQfJSvBexIig3fCQL1d2vgqMOoXODJyBSjFe3BvcYjpe2FNus8d
         ctF3xL5z6BnTutLsqQs3gsMNL8uktjtwjZ+8ybLoEb+tdzTLEZ9SSZrMqOwFKYbQ46gY
         JD1MJq2hnerd73xKJb0dUpFCO4iI3LM5Pa1XWeDVzmFsmCs5ylIYRzRQC/SFaJpWXb2k
         6pCw==
X-Gm-Message-State: AO0yUKWRcLuHlkse/L2toRFUoszMIjBPb0TaTFSYrwZOdhpQYdZMqrZC
        du1UHKABdubM52Nkq8WfYKof5pqMSN0d6RN9jyB3Cw==
X-Google-Smtp-Source: AK7set85zkFB8VYS++p5ySf7PMA2zEfRnO11fBZIjQFxTf6oWJyd1aTxO2CIyS+BSLOpmI2qhfMtISJvRiIHKSvO2O4=
X-Received: by 2002:a05:6102:38d1:b0:402:99ed:ad3e with SMTP id
 k17-20020a05610238d100b0040299edad3emr18005363vst.2.1678271582597; Wed, 08
 Mar 2023 02:33:02 -0800 (PST)
MIME-Version: 1.0
References: <20230307165432.25484-1-afd@ti.com> <20230307165432.25484-3-afd@ti.com>
 <CAMRc=MeLM-S+HEuaDPp0UpbHJYmAXfLuFMU2TyvK5KEywSxtQA@mail.gmail.com>
In-Reply-To: <CAMRc=MeLM-S+HEuaDPp0UpbHJYmAXfLuFMU2TyvK5KEywSxtQA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 8 Mar 2023 11:32:51 +0100
Message-ID: <CAMRc=MfAqx5Wz2d5K1wWM0ZZ4WBu+Jhercw-z95zGvo_-v=OTg@mail.gmail.com>
Subject: Re: [PATCH 3/6] gpio: sch311x: Use devm_gpiochip_add_data() to
 simplify remove path
To:     Andrew Davis <afd@ti.com>
Cc:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 11:24=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Tue, Mar 7, 2023 at 5:54=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
> >
> > Use devm version of gpiochip add function to handle removal for us.
> >
> > Signed-off-by: Andrew Davis <afd@ti.com>
> > ---
> >  drivers/gpio/gpio-sch311x.c | 25 ++-----------------------
> >  1 file changed, 2 insertions(+), 23 deletions(-)
> >
>
> Applied, thanks!
>
> Bart

I see there's v2 out, backing it out then.

Bart
