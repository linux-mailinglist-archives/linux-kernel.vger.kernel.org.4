Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBF7743F5E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjF3QCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbjF3QCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:02:15 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D7ECA
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:02:14 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b6985de215so33697171fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688140932; x=1690732932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sg13xGYv8z3aKMTOSuPSBHhxLlyyz33hg4HsG7ryfAA=;
        b=CALM6SuT/8o6doWToXXNL7LTLDWuUzc3TV0ANV9KXZmE4Zrtm0U9KjldAe4oSOtSty
         da6c9HQvgo5dKqW+zDiR+pWtgO9nd5cPQvoCsKZmI3rNcZX8NbKwpl3R2CmJ4DwlDrn7
         41VCViTnagM3DwE3QXrslgeMo/jhUfpbcps8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688140932; x=1690732932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sg13xGYv8z3aKMTOSuPSBHhxLlyyz33hg4HsG7ryfAA=;
        b=SiX4p2vxA+p1HniGGv5rBX/gfMx8xHXuI7z8xT4EYNCVfK3Ya0WgGeTYLW68ZP6H3v
         VAcoIArOcffKC4TzqKJcja6iGM/2SvjpZYJU+zv4yavEj2o67YqbuOkcusxz1K8dpcRC
         pz/u87pKZo8f7DLfzkp7wu3PR64MrsSh35jiXXJicPworm2g9NbI9lidgM8kA5jF0Fx9
         Oj9FSLyGQjfeCN9UM7x3HcbqVF4AAfs/EtkDhsVZM1Ei2+1ACL1/3rUYwYMCJ/e33+11
         CbgWI7NnhlD1n2tTltMWuha7z0+m/eTDZC+QIWeSqafd5tZ7RmRVV4eguneQjgelb5zN
         dnkg==
X-Gm-Message-State: ABy/qLZoHGj9lgxbeYIfpypJ137/sLlmpQHROs2VyUwaQyWenbf6hUoU
        lJ4xDXYc1RM2PVWqhq0nOrbi/JU92gp4sXMJR0Kq0sfh
X-Google-Smtp-Source: APBJJlE5nh59XR7k3PCK4niajxBgj87LyVyzEtbQ17HyjU9EJN7ulY33LGm7UqpYjM2AGndTYMRqcg==
X-Received: by 2002:a2e:878f:0:b0:2b5:84fb:5939 with SMTP id n15-20020a2e878f000000b002b584fb5939mr2654417lji.30.1688140931823;
        Fri, 30 Jun 2023 09:02:11 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a2-20020a1709065f8200b009827b97c89csm8173920eju.102.2023.06.30.09.02.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 09:02:11 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-51da8a744c4so2208004a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:02:11 -0700 (PDT)
X-Received: by 2002:a05:6402:321f:b0:51d:9231:b9fa with SMTP id
 g31-20020a056402321f00b0051d9231b9famr1860110eda.39.1688140931050; Fri, 30
 Jun 2023 09:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230628-pokal-puzzeln-5199c679b051@brauner> <CAHk-=wiBXJOzkez2Rd=cQ5ckttJq6OdYtArFmCtVQHyeuQBGrw@mail.gmail.com>
 <20230630-testphasen-orangen-0e54486a267d@brauner> <CAHk-=whJJbmfBk_8v_vFn1NdJ9O-AKCrjY+EArkzgFp9h-sKHA@mail.gmail.com>
 <20230630-stiefel-rotor-7f2d13fc084f@brauner> <8b73a39a359b4523a053efd614cd7dd7@AcuMS.aculab.com>
In-Reply-To: <8b73a39a359b4523a053efd614cd7dd7@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Jun 2023 09:01:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whY5wuS0QRtEym4d8D2hrNE3pSL9LfoHpSOUKHb2sZtjA@mail.gmail.com>
Message-ID: <CAHk-=whY5wuS0QRtEym4d8D2hrNE3pSL9LfoHpSOUKHb2sZtjA@mail.gmail.com>
Subject: Re: [GIT PULL] pid: use flex array
To:     David Laight <David.Laight@aculab.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 at 04:21, David Laight <David.Laight@aculab.com> wrote:
>
> The bit pattern used for a NULL pointer is implementation defined.

Oh, pretty much everything we do in the kernel is implementation defined.

And yes, we do indeed basically rely on the bit pattern for NULL being
all zeroes, and that example I gave with PCI_IOBASE is just one of
many.

And yes, compilers will sometimes complain about the things we do.

On s390, for example, the low memory range is special (and the kernel
mapping is special), so s390 uses all these pointers that are
*literally* small constants, and we've had to turn off some compiler
warnings because gcc would think that we're doing small offsets off
NULL.

But "implementation defined" is actually the good case.

The problem case is "undefined", when we sometimes want to do exactly
those kinds of things. We try to generally avoid it, but we sometimes
end up using compiler switches to say "turn off that part of your
logic" (strict overflow comes to mind).

             Linus
