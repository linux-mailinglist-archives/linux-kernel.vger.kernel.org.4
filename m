Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130766AACAA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 22:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjCDVK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 16:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjCDVKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 16:10:54 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D31FF765
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 13:10:53 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j11so4192238edq.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 13:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677964251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvqbdnccqQxI74XYqpTTG4hk8zHvB1aY939htM9r+Ro=;
        b=dyZuDfwyyGOipoxyi9sQq4hDXe1/TvYEcsWfiA/iDwo3oZk6TRozMUOEhGsFW93ZXr
         6XzkKr3hh+uZUZVvo4rwfcwQqwtYuaZnNiXD8PLmoMv/Gl9H0MhEnSGdcwBaCapOnMWr
         dPst0dMwPy9R3SooeCSrm6iSfRSsvguRNZ2xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677964251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvqbdnccqQxI74XYqpTTG4hk8zHvB1aY939htM9r+Ro=;
        b=qRZWhNAe168I98ryMFeFeEzwDX2DIPLXOMdDr0BkXmUoVCHFT5RHJoFpaF4hp1Ezfl
         10S47NQfy97PWRe8TmuHgimI17cY350PvtyJW2aA5VP5y+d+7WAIjShjiHKmMYac8Bwk
         vVtuSCeElIL7MnTQYnB5WtjKsQMd4sb+1wg7uXtgehGun3inWNxeFf3KwL0ywxBl4+ZU
         1wTomWXykaOsCGUt1ewt08h7M5Kmt5KA3gyEDCN/X+0LBEmfwocd0/kn4ia6dwKGGJsJ
         BvB1eBaARF5g1eXi6sha6gBhqLo9gqlzw19VQ0Yi4CgnLGkldzsXhxzRukbkZvqeW6ML
         m3fg==
X-Gm-Message-State: AO0yUKXM1DV2t7Ly2XXtBT1rNZRJ3G3+iY9MjLM+AuyyZ//NwMogPhCu
        yMtHCeq2phKQl90GqjHEPSRsMDNSAxl/FhdZNaYiTw==
X-Google-Smtp-Source: AK7set8OBN94E15dYrnKcy3UhXRfpv9SBEXvhDFPXeqEyzaIJYEDVKG1L59NVh50ACWKH9/TH/MSOw==
X-Received: by 2002:a17:906:3002:b0:8b2:fb3d:9f22 with SMTP id 2-20020a170906300200b008b2fb3d9f22mr5509905ejz.33.1677964251465;
        Sat, 04 Mar 2023 13:10:51 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id gj14-20020a170906e10e00b008df7d2e122dsm2402091ejb.45.2023.03.04.13.10.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 13:10:50 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id o15so23546545edr.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 13:10:49 -0800 (PST)
X-Received: by 2002:a17:906:3d51:b0:8f1:4c6a:e72 with SMTP id
 q17-20020a1709063d5100b008f14c6a0e72mr2690435ejf.0.1677964249715; Sat, 04 Mar
 2023 13:10:49 -0800 (PST)
MIME-Version: 1.0
References: <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
 <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com>
 <ZAK6Duaf4mlgpZPP@yury-laptop> <CAHk-=wh1r3KfATA-JSdt3qt2y3sC=5U9+wZsbabW+dvPsqRCvA@mail.gmail.com>
 <ZALcbQoKA7K8k2gJ@yury-laptop> <CAHk-=wjit4tstX3q4DkiYLTD6zet_7j=CfjbvTMqtnOwmY7jzA@mail.gmail.com>
 <ZAOvUuxJP7tAKc1e@yury-laptop> <CAHk-=wh2U3a7AdvekB3uyAmH+NNk-CxN-NxGzQ=GZwjaEcM-tg@mail.gmail.com>
In-Reply-To: <CAHk-=wh2U3a7AdvekB3uyAmH+NNk-CxN-NxGzQ=GZwjaEcM-tg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Mar 2023 13:10:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=whEwe1H1_YXki1aYwGnVwazY+z0=6deU-Zd855ogvLgww@mail.gmail.com>
Message-ID: <CAHk-=whEwe1H1_YXki1aYwGnVwazY+z0=6deU-Zd855ogvLgww@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 4, 2023 at 1:01=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It's still completely untested. Treat this very much as a "Let's make
> the common cases faster, at least for !MAXSMP".

Ok, so I started "testing" it in the sense that I actually looked at
the code it generated, and went all "why didn't it make any
difference".

And that's because the patch had the

  #ifdef CONFIG_CPUMASK_OFFSTACK

condition exactly the wrong way around.

So if somebody actually wants to play with that patch, you need to
change that to be

  #ifndef CONFIG_CPUMASK_OFFSTACK

(and then you obviously need to have a kernel config that does *not*
have MAXSMP set).

That at least simplifies some of the code generation when I look at
it. Whether the end result _works_ or not, I still haven't checked.
That patch is still very much meant as a "look, something like this
should make our cpumask handling much more efficient"

              Linus
