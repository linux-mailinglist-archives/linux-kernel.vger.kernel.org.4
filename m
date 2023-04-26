Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2926EF9D8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 20:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbjDZSLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 14:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjDZSLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 14:11:31 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA27F76A9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:11:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-94f1d0d2e03so1100442866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682532689; x=1685124689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emz2lWVV+R7IDYMbl3F7GGb15o68eHk4V8lZiXE9F0I=;
        b=JIk06fFDX5QQr1JjweV7oXucAFe0Jax1E7iBQBKBxra+E+hZeRsvNZHY0rd1KTEe6l
         fl/sEh4oQ57S6MkbgBXSkZ9oFSxMZFxKvh3t/ZFS9dHq/7Yhzpt1/7Vt/vgIie6/SHHu
         MxR85hJA27Fr6NYOZZiBvz9VyDIKiFbWNPZXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682532689; x=1685124689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emz2lWVV+R7IDYMbl3F7GGb15o68eHk4V8lZiXE9F0I=;
        b=hIg1QZ3mzYCmZsGmAGio2QOZ1AR4wDHQROWmmPASiXJR44BCZ8GbvnS+nFVxlx+wJM
         SQHNlEOpt9gT795hq7+TgCh8rOqSW6wmLrt8k4lsyJU2AdNwVMReQUQAhNv9wWXKZrTn
         ubw7pk9MfxQYi+7mNo+QdJUMCgUk1y7429MbZF+qN6YvIEOcUu1NaK40IoQnTd9N5zC+
         GmMtB+07HSu++8+h4FXcm/PVeUZac+d2DKjfrK8lm6wBwNMQtww/V1fMK4kpGBldHIpm
         8+u0N4E1JxM+X3LbFI2Ay0eQ/TG+QAIVxszGeROBSzcieb/FBocYiJf7QEpzWLBWsFmX
         ZE3g==
X-Gm-Message-State: AAQBX9fIhzr4UJTE1aucxCviRFc3ZoIBAtUPdxaTLigWnl3OhGUj1FoF
        Msgie4kHtNfR8jE5iGIqHjbnVXjVFugOGT4bIeZ8mQ==
X-Google-Smtp-Source: AKy350YHejbQ/dXOpzJUbLkQ0dTu+k8V8+MVehMdwwPB9Rh3G/8tOFhHNR1Uc01G1/A+z6gGl6TwRg==
X-Received: by 2002:a17:906:16d5:b0:94f:1c90:cb71 with SMTP id t21-20020a17090616d500b0094f1c90cb71mr18987207ejd.65.1682532688771;
        Wed, 26 Apr 2023 11:11:28 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id aa21-20020a170907355500b00957dad777c1sm6204175ejc.107.2023.04.26.11.11.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 11:11:28 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5050497df77so11533076a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:11:27 -0700 (PDT)
X-Received: by 2002:aa7:c316:0:b0:506:c1a6:2771 with SMTP id
 l22-20020aa7c316000000b00506c1a62771mr19994132edq.39.1682532687659; Wed, 26
 Apr 2023 11:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230425041838.GA150312@mit.edu> <CAHk-=wiP0983VQYvhgJQgvk-VOwSfwNQUiy5RLr_ipz8tbaK4Q@mail.gmail.com>
 <CAKwvOdmXgThxzBaaL_Lt+gpc7yT1T-e7YgM8vU=c7sUita6aaw@mail.gmail.com>
In-Reply-To: <CAKwvOdmXgThxzBaaL_Lt+gpc7yT1T-e7YgM8vU=c7sUita6aaw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Apr 2023 11:11:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXDzU1j-cCB28Pxt-=NV5VTbnLimY3HG4uF0HPP7us_Q@mail.gmail.com>
Message-ID: <CAHk-=wjXDzU1j-cCB28Pxt-=NV5VTbnLimY3HG4uF0HPP7us_Q@mail.gmail.com>
Subject: Re: [GIT PULL] ext4 changes for the 6.4 merge window
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 10:34=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> That's what clang's _Nonnull attribute does (with -Wnullability-extension=
).

No, that's a warning about using it, not a warning about testing for
NULL when it's there.

I actually tested _Nonnull.  It seems to work for arguments. But it
does not work for return values.

Of course, maybe there's some other magic needed, but it does seem to
be sadly not working for us.

> But it's not toolchain portable, at the moment.  Would require changes
> to clang to use the GNU C __attribute__ syntax, too (which I'm not
> against adding support for).

No need for using the __attribute__ syntax at all, that would _not_ be
a show-stopper.

While it's true that it's the common syntax, and we sometimes use it
explicitly because of that, it's by no means the only syntax, and we
actually tend to try to have more legible wrappers around it.

So, for example, we prefer using '__weak' instead of writing
'__attribute__((__weak__))'.

And no, it very much doesn't have to use __attibute__ at all. We
already have things like

    #define __diag(s)          _Pragma(__diag_str(GCC diagnostic s))

so we already use other syntaxes.

End result: if it actually worked, I'd happily do something like

   #define __return_nonnull _Nonnull

in <linux/compiler-clang.h>, with then <linux/compiler-gcc.h> then just hav=
ing

     #define __return_nonnull

along with a big comment about how __attribute__((nonnull)) is
horrible garbage that should never every be used.

             Linus
