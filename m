Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFEA642912
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiLENQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiLENQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:16:25 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD8B13D45;
        Mon,  5 Dec 2022 05:16:24 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id v8so4841808qkg.12;
        Mon, 05 Dec 2022 05:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1IEd4mI8XLAQBexIi+9IpqUT3OWzPJE+9etDyFsEtDA=;
        b=oE4GEmTdC5yMQ2N4/NNW936SbQWyASzL2GuhCgJV06hdVm6aJV1VE+JWgnNKKaeEfo
         sNEfc0zY8Q4FnCXI+p0D7cXW5Atsp9oZJtjSe0d3OhOvJ8SKC9o43u5rA+4Xkt8+mGgm
         Ti4wx1Dz8q8Tcw951dsL7GPoSCVh+hqMEQ9i+BAO1UbkFAyFQLpifCAlIqZ89C4gkVHL
         01nWkpKl09O9Tigi+S9k+tLIO+N+BCVbWrVclaS9+Cj2YZYVbovBP8eqlynW72hrYtt0
         hp1iSQwBJ2fqvaLioSbqT0M4pAbEJkRL/GWK7oH2E6ojmEXRMneyPE05JXf+HlZU20AJ
         0hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1IEd4mI8XLAQBexIi+9IpqUT3OWzPJE+9etDyFsEtDA=;
        b=q0XPZU+GalljuOBJa+88px4QEhIn3355JVzqiyYam8Dk6PEX+4AqCYRsY65TFBhp24
         YcoZAZn5aQ5U8w6jcBTVNcjvNLOFQcuzaxQPlPSJwLNVEFTYgmSMbcj3Jr4vX4N4Ff6g
         l3lTuUeIzkJ/yg3PyxtR3f7ZiVg6se7z2v2scVm0Vp8qgztv/EGbIm4QKuTuKJ9KYd4k
         UEWBaGusC0+J+BVTN28MLgAe3uCtZSCo8MWpGpSZ3mSuQEJgZE3cRX43HVB2jWlegj1I
         G2eCHAmPQvmxtxsChbk5yQeLz3THc6VOxsCEVMOPe1EgpjGuR3vJRTRxROKAEPOJvbxe
         MZVg==
X-Gm-Message-State: ANoB5pkR8Fd/o8KfBjUZYAems3yGl/YgSetyoHcyKm+0dTF+U4wNw71h
        ngHz1GXB8nW84L97HG8nyx8P1+zi6o5LHQIwBp2BgLCmppg14Q==
X-Google-Smtp-Source: AA0mqf5TkqKS5PRYCTdZo/ape7Psorn6DyU3gXrBcn4hxmOu1OKIkxxU/2lykVYJOjas/5oWPAneioPTyI0njsujhq0=
X-Received: by 2002:a05:620a:2053:b0:6fc:abc1:d154 with SMTP id
 d19-20020a05620a205300b006fcabc1d154mr14630302qka.320.1670246183553; Mon, 05
 Dec 2022 05:16:23 -0800 (PST)
MIME-Version: 1.0
References: <202212051942082259437@zte.com.cn> <CAHp75Vc-gMuv=HpiF-LURrpy+0MDiQUe0hVv24pRezhQg2E-Lw@mail.gmail.com>
In-Reply-To: <CAHp75Vc-gMuv=HpiF-LURrpy+0MDiQUe0hVv24pRezhQg2E-Lw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Dec 2022 15:15:47 +0200
Message-ID: <CAHp75VfLGUF4vqeObEOjRKzc+R+oYgsUZSdvVd+Echnq2DNRqw@mail.gmail.com>
Subject: Re: [PATCH linux-next v2] x86/platform/uv: use strscpy to instead of strncpy()
To:     yang.yang29@zte.com.cn
Cc:     steve.wahl@hpe.com, mike.travis@hpe.com, dimitri.sivanich@hpe.com,
        russ.anderson@hpe.com, dvhart@infradead.org, andy@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
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

On Mon, Dec 5, 2022 at 3:13 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Dec 5, 2022 at 1:42 PM <yang.yang29@zte.com.cn> wrote:

...

> >         char arg[ACTION_LEN], *p;
> >
> >         /* (remove possible '\n') */
> > -       strncpy(arg, val, ACTION_LEN - 1);
> > -       arg[ACTION_LEN - 1] = '\0';
> > -       p = strchr(arg, '\n');
> > -       if (p)
> > -               *p = '\0';
> > +       strscpy(arg, val, strnchrnul(val, ACTION_LEN, '\n') - val);
>
> And even better is to replace ACTION_LEN by sizeof(arg).

Btw, have you compiled this with `make W=1 ...`? I believe you will
get a new warning after your change.

-- 
With Best Regards,
Andy Shevchenko
