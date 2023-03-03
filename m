Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE9A6A9E04
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjCCRy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjCCRyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:54:25 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D7A5B5F2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 09:54:19 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id g3so13643144eda.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 09:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677866058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2o3rQetZgv6ewfCPpQy7L56u60VboNrnPcXuCAU8c9I=;
        b=e2Ior9ml2a6sA3xqp7/mjoi0eleFZCbAWkfIeYEfktk8tXziMAOZD/rb60OwD1S8Tq
         0ZKD5Fv3R1sSQd0bkxwWKqa3qP3F6K54E1OHOetzjSw1or205pyp9m8SbKstEClDabn9
         z96OmJ2w4kxlFMTrccZmn1jsSCSNXTRtfFVQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677866058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2o3rQetZgv6ewfCPpQy7L56u60VboNrnPcXuCAU8c9I=;
        b=sU146MQwo5M3w/XdEYr0Ks1SAQSLGFM82iArM03o5Nxz3Wad23UD0ejnQFcmbdvcIH
         W37DClVPYz8OGNC/RrsQGV54V4BMLElhI58l+PsYNjMAf/8pNn0WFAohWqRTb6ujod7E
         g0ctrUTzGK5zDqolUW8L6no3Z8aMDa+BW3KAZoNDqt9xd7TO7e5b7TRzf1+eLF9Nl9Xj
         FjjNFvcgkKflqKzXQRES1bbHSUB51qkT+Zoy5IviUtMFfvKdskcFeMTyZBXiIMnteogt
         Qj6mQiUflKAq9vzl8oHKJvAWbMQfCXZgNBgAkpHGuU2JqOIMYbytAsq++qBwJPAC+2Cf
         5W4g==
X-Gm-Message-State: AO0yUKUoSYIKJeWL7Wz9iyFafAE/te7yzGtfsqjEcXGAd7zqkAn2Gn1G
        2wuUJk4ab9Ug66eaqokggfHGRmr8/918Z4LzHIkJUQ==
X-Google-Smtp-Source: AK7set8BHZI14OzZncCww7YWnP5zUTBZKCEkVTp3nAKw8PnDAkyA6b9GubeHU20zg1L+hkSx3EhU8Q==
X-Received: by 2002:a17:907:8d02:b0:8ee:babc:d40b with SMTP id tc2-20020a1709078d0200b008eebabcd40bmr2775139ejc.58.1677866057923;
        Fri, 03 Mar 2023 09:54:17 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id kq17-20020a170906abd100b008e82cb55195sm1161112ejb.203.2023.03.03.09.54.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 09:54:17 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id i34so13519909eda.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 09:54:17 -0800 (PST)
X-Received: by 2002:a17:906:b281:b0:8b8:aef3:f2a9 with SMTP id
 q1-20020a170906b28100b008b8aef3f2a9mr1190087ejz.0.1677866056901; Fri, 03 Mar
 2023 09:54:16 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein> <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV> <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
 <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
 <CAHk-=wi11ZbOBdMR5hQDz0x0NNZ9gM-4SxXxK-7R3_yh7e10rQ@mail.gmail.com>
 <ZAD21ZEiB2V9Ttto@ZenIV> <6400fedb.170a0220.ece29.04b8@mx.google.com>
 <ZAEC3LN6oUe6BKSN@ZenIV> <CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com>
 <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
In-Reply-To: <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Mar 2023 09:54:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
Message-ID: <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>,
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

On Fri, Mar 3, 2023 at 9:39=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> So the key is: memset is underperforming at least on x86-64 for
> certain sizes and the init-on-alloc thingy makes it used significantly
> more, exacerbating the problem

One reason that the kernel memset isn't as optimized as memcpy, is
simply because under normal circumstances it shouldn't be *used* that
much outside of page clearing and constant-sized structure
initialization.

Page clearing is fine, and constant-sized structure inits are also
generally fine (ie the compiler does the small ones directly).

So this is literally a problem with pointless automated memset,
introduced by that hardening option. And hardening people generally
simply don't care about performance, and the people who _do _care
about performance usually don't enable the known-expensive crazy
stuff.

Honestly, I think the INIT_ONCE stuff is actively detrimental, and
only hides issues (and in this case adds its own). So I can't but help
to say "don't do that then". I think it's literally stupid to clear
allocations by default.

I'm not opposed to improving memset, but honestly, if the argument is
based on the stupid hardening behavior, I really think *that* needs to
be fixed first.

               Linus
