Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBF460E79F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 20:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbiJZSr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 14:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiJZSrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:47:55 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150B1BB041
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 11:47:54 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id i12so12371122qvs.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 11:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ri/V70PuN7YE034eBVrKO+65hlxsDWHRaEAqsCWyzp0=;
        b=W1vAJPTEgLgFYKZDmntaUewFXJRoS5SLYpwNKHQaxuRPhk16gmO8vKWHC/uwRfHyKW
         nYZb73p9M8oASZmW82NdRcO6Hkf/qYD5F3GXc1h97z8RWjlaA7ncXdpBLCmVRPCKWpjS
         WAGAUeO2XRxEnLGuaPCfRaClQZfyu1KtW2YDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ri/V70PuN7YE034eBVrKO+65hlxsDWHRaEAqsCWyzp0=;
        b=KDVaPuDoU4iS+B76fZ7OPnjPdOmXTJvcvknJulpjRg78Ir/jk58pUmwdIOOUaXgEkn
         4w5JliDiLJGOnC3ZmWUkIPpd3BJriQkET1NwHlE/oM1iAwP0AXzhZi9O2LfIT7yaB3Lm
         cKVi0u+tH7StJA8NHzPHFk26aC8WejxYQRZ9MiQqPdkCmfvOJERBtiCjavMgkh4BekbA
         I2eUkDUJF0jE8IyhTAhCsfPSupWy055ZhYUmo1KHS3LrkhF9q3M8YK3KO8uJH7HxiOYV
         IMhn3KeD+fLNPMSfEBDlY3JO1ZhFNBJoeIxifIZujYLIHPvQREcRF7OWAf1vqULFcuYH
         SeWQ==
X-Gm-Message-State: ACrzQf0QXAw7X8O+y5lIdZzj9kWgMOB8OOhbDDrpStklQBxo1a2Wl41n
        h4LmhNoBLJKHgQI3PEeMTjCMO39VFBfzog==
X-Google-Smtp-Source: AMsMyM45ADg/JADUaOvHbsPoKA4x1iAvFmAtXRovncZOdJNVbWzt3mvFmZyyd1qlmGNlFag/8qwF+Q==
X-Received: by 2002:a05:6214:1d2e:b0:4b6:95ab:eb79 with SMTP id f14-20020a0562141d2e00b004b695abeb79mr32618200qvd.113.1666810073015;
        Wed, 26 Oct 2022 11:47:53 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id m17-20020ae9e711000000b006ed61f18651sm4323655qka.16.2022.10.26.11.47.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 11:47:52 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-36ad4cf9132so128780057b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 11:47:51 -0700 (PDT)
X-Received: by 2002:a81:2544:0:b0:360:c270:15a1 with SMTP id
 l65-20020a812544000000b00360c27015a1mr39348282ywl.67.1666810071636; Wed, 26
 Oct 2022 11:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221025231627.never.000-kees@kernel.org> <CAKwvOdkDaSQZ_e0hX0ggNqsWn+=0xyqMdbf6J+YW0-iZ=ewViQ@mail.gmail.com>
In-Reply-To: <CAKwvOdkDaSQZ_e0hX0ggNqsWn+=0xyqMdbf6J+YW0-iZ=ewViQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Oct 2022 11:47:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whybqnsbCe=+xfxx3ncjg-JG5+GQAZ70M8WKeAnVrZd5Q@mail.gmail.com>
Message-ID: <CAHk-=whybqnsbCe=+xfxx3ncjg-JG5+GQAZ70M8WKeAnVrZd5Q@mail.gmail.com>
Subject: Re: [PATCH] fortify: Do not cast to "unsigned char"
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 11:26 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> If the intent of __p is to avoid repeated application of side effects
> from the evaluation of the macro parameter p, this could also be:

Not the only intent.

The code also does

        __builtin_constant_p(*__p))

which basically checks for "is this a compile-time constant string"
(yes, I realize that it only checks the first character, but it ends
up being the same thing).

That would fail horribly with __auto_type and people using "void *".

It is true that we could probably use __auto_type in a lot of other
places where we currently use

        __typeof__(ptr) _p_ = (ptr)

but our "typeof" pattern is

 (a) much more common because of historical reasons

 (b) much more generic because it often uses a different ptr type (ie
macros that have a value and a pointer, like "put_user()", the type
comes from the pointer, but the initializer comes from the value, so
"__auto_type" ends up being completely the wrong thing).

We do have a couple of "__auto_type" uses, but because it can't
replace our __typeof__ users in general anyway, I'm not convinced we
should strive to make it hugely more common (even if the __auto_type
model probably can replace a lot of them).

                  Linus
