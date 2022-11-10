Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263DF624988
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiKJSct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiKJScr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:32:47 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359A84AF3C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:32:46 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id f27so7268572eje.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J3uD4IlWV8bRErz2ty7DD3vY43w7ZbMSPYfwQhj5zkM=;
        b=gIYnIIr9Jh5x+95F5Z3ddQ1QaR5P6ZcDsx9hn7+F/o/XWev2KE/gn/gQBT9R6MLUDw
         K8y5kgNGKI2Yvy1ApfzYN4KOOlNADkBCKUH2WQIGr9usqA8fB+tH10WIPpJTlNyehxPk
         GltwHE1NYeRYDQMSULwbuPyz7qq+gvg9kqH2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3uD4IlWV8bRErz2ty7DD3vY43w7ZbMSPYfwQhj5zkM=;
        b=rL92usAT39npfvGC/p6Q/EAd1ZP8eDWHcYd7x8GvI+24CGD7/PHpF0cRdMqMjWUoH/
         Y9wT/cRGqesG6FEknZ5q2RWpkazZ/YP8bMqJaKimj4osxLSIwNbqqVXh8Ez4q2rFK0WF
         qbJVZnqSYyCiri+ggK9QAYsV2QXT7IZG06pgeg3vEtjaVPkbANHc3gQbM+zKe6Rb3AYi
         LJOW27bkoDS24+O64TMFOgB6C43GG5qh2r2jFG2KPqvrby67FybDaet21ONla3PnaN9o
         1hv6gnIiv8aisVCgYNkZStgWsluq5e3QORUJQQcTDL2kCYfiwzQaRWM5hdmILEjJq0DA
         9/qQ==
X-Gm-Message-State: ACrzQf0fOuWrAnXZedtfqXV1snUjH6Mq/Pc4Se1BM8gafyswqQmtBKiH
        uOgUGTzGexVfe8l9DdSzzdTsl7ConcKTzA==
X-Google-Smtp-Source: AMsMyM5kPiruBJuNqeiA1ezZ1+IHt8TwHoxjbJbFcy5DhZV92vmUva3Ck2nvGGeW1npD3rM5atSRVQ==
X-Received: by 2002:a17:906:c208:b0:7ad:e197:5eeb with SMTP id d8-20020a170906c20800b007ade1975eebmr3605862ejz.207.1668105164486;
        Thu, 10 Nov 2022 10:32:44 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id oz36-20020a1709077da400b007ae4717bef1sm20455ejc.15.2022.11.10.10.32.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 10:32:43 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so1749505wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:32:43 -0800 (PST)
X-Received: by 2002:a7b:c34a:0:b0:3c6:e069:d41c with SMTP id
 l10-20020a7bc34a000000b003c6e069d41cmr54546532wmj.180.1668105162767; Thu, 10
 Nov 2022 10:32:42 -0800 (PST)
MIME-Version: 1.0
References: <20221103180120.752659-1-evgreen@chromium.org> <20221103105558.v4.9.I87952411cf83f2199ff7a4cc8c828d357b8c8ce3@changeid>
 <202211041147.DEDC1F64F@keescook> <CAE=gft41=5uWwPfDZ=nyjcOzk21YCAeg6cheUNy-m0j79CgNfQ@mail.gmail.com>
 <202211100816.FEF5A3305C@keescook>
In-Reply-To: <202211100816.FEF5A3305C@keescook>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 10 Nov 2022 10:32:06 -0800
X-Gmail-Original-Message-ID: <CAE=gft7-+EmnMTZJZGALK+UVGyypZODa0AKNiQNLrDh=xe21XA@mail.gmail.com>
Message-ID: <CAE=gft7-+EmnMTZJZGALK+UVGyypZODa0AKNiQNLrDh=xe21XA@mail.gmail.com>
Subject: Re: [PATCH v4 09/11] PM: hibernate: Mix user key in encrypted hibernate
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, gwendal@chromium.org,
        apronin@chromium.org, Pavel Machek <pavel@ucw.cz>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>, jarkko@kernel.org,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 8:17 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Nov 09, 2022 at 04:30:10PM -0800, Evan Green wrote:
> > On Fri, Nov 4, 2022 at 11:54 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Thu, Nov 03, 2022 at 11:01:17AM -0700, Evan Green wrote:
> > > > Usermode may have their own data protection requirements when it comes
> > > > to encrypting the hibernate image. For example, users may want a policy
> > > > where the hibernate image is protected by a key derived both from
> > > > platform-level security as well as authentication data (such as a
> > > > password or PIN). This way, even if the platform is compromised (ie a
> > > > stolen laptop), sensitive data cannot be exfiltrated via the hibernate
> > > > image without additional data (like the user's password).
> > > >
> > > > The kernel is already doing the encryption, but will be protecting its
> > > > key with the TPM alone. Allow usermode to mix in key content of their own
> > > > for the data portion of the hibernate image, so that the image
> > > > encryption key is determined both by a TPM-backed secret and
> > > > user-defined data.
> > > >
> > > > To mix the user key in, we hash the kernel key followed by the user key,
> > > > and use the resulting hash as the new key. This allows usermode to mix
> > > > in its key material without giving it too much control over what key is
> > > > actually driving the encryption (which might be used to attack the
> > > > secret kernel key).
> > > >
> > > > Limiting this to the data portion allows the kernel to receive the page
> > > > map and prepare its giant allocation even if this user key is not yet
> > > > available (ie the user has not yet finished typing in their password).
> > > > Once the user key becomes available, the data portion can be pushed
> > > > through to the kernel as well. This enables "preloading" scenarios,
> > > > where the hibernate image is loaded off of disk while the additional
> > > > key material (eg password) is being collected.
> > > >
> > > > One annoyance of the "preloading" scheme is that hibernate image memory
> > > > is effectively double-allocated: first by the usermode process pulling
> > > > encrypted contents off of disk and holding it, and second by the kernel
> > > > in its giant allocation in prepare_image(). An interesting future
> > > > optimization would be to allow the kernel to accept and store encrypted
> > > > page data before the user key is available. This would remove the
> > > > double allocation problem, as usermode could push the encrypted pages
> > > > loaded from disk immediately without storing them. The kernel could defer
> > > > decryption of the data until the user key is available, while still
> > > > knowing the correct page locations to store the encrypted data in.
> > > >
> > > > Signed-off-by: Evan Green <evgreen@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v2)
> > > >
> > > > Changes in v2:
> > > >  - Add missing static on snapshot_encrypted_byte_count()
> > > >  - Fold in only the used kernel key bytes to the user key.
> > > >  - Make the user key length 32 (Eric)
> > > >  - Use CRYPTO_LIB_SHA256 for less boilerplate (Eric)
> > > >
> > > >  include/uapi/linux/suspend_ioctls.h |  15 ++-
> > > >  kernel/power/Kconfig                |   1 +
> > > >  kernel/power/power.h                |   1 +
> > > >  kernel/power/snapenc.c              | 158 ++++++++++++++++++++++++++--
> > > >  kernel/power/snapshot.c             |   5 +
> > > >  kernel/power/user.c                 |   4 +
> > > >  kernel/power/user.h                 |  12 +++
> > > >  7 files changed, 185 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/include/uapi/linux/suspend_ioctls.h b/include/uapi/linux/suspend_ioctls.h
> > > > index b73026ef824bb9..f93a22eac52dc2 100644
> > > > --- a/include/uapi/linux/suspend_ioctls.h
> > > > +++ b/include/uapi/linux/suspend_ioctls.h
> > > > @@ -25,6 +25,18 @@ struct uswsusp_key_blob {
> > > >       __u8 nonce[USWSUSP_KEY_NONCE_SIZE];
> > > >  } __attribute__((packed));
> > > >
> > > > +/*
> > > > + * Allow user mode to fold in key material for the data portion of the hibernate
> > > > + * image.
> > > > + */
> > > > +struct uswsusp_user_key {
> > > > +     /* Kernel returns the metadata size. */
> > > > +     __kernel_loff_t meta_size;
> > > > +     __u32 key_len;
> > > > +     __u8 key[32];
> > >
> > > Why is this 32? (Is there a non-literal we can put here?)
> >
> > Sure, I can make a new define for this: USWSUSP_USER_KEY_SIZE. Really
> > it just needs to be enough key material that usermode feels like
> > they've swizzled things up enough. I wanted to avoid using a
> > particular implementation constant like AES_KEYSIZE_256 because I
> > wanted that to be a kernel implementation detail, and also wanted to
> > avoid adding additional header dependencies to suspend_ioctls.h.
>
> Can this just use __aligned(8) etc?

It's possible this is more an FFI issue that trails off the end of my
knowledge, so I should just drop the pad. But I'll dump out my
thoughts anyway for posterity:

My understanding is that the compiler pads the size of a struct up to
its required alignment so that arrays of the struct always stay
aligned. In this case, the sizeof() the struct both with and without
the pad member is 0x30, since __kernel_off_t has a required alignment
of 8. I had a couple of worries about that led me to naming that
padding:
 * Though this structure isn't copied out of the kernel today, I
didn't want some future change that did it to accidentally leak kernel
memory via the unnamed padding.

 * Given that the sizeof the struct is encoded into the ioctl number,
and we're to some extent relying on bespoke compiler behavior, I
thought the padding member might make us more resilient to an
unexpected compiler change later.

 * On the usermode side, there are a bunch of Rust rules that I don't
totally understand related to "soundness", undefined values (which the
padding between struct members is), and transmuting structs back and
forth to byte arrays.

I confirmed with someone smarter than me that I'm not running afoul of
the Rust rules by dropping the padding and dropping the __packed I had
in Rust definition of the struct, so I'll plan to drop the pad member
here in the next spin. A very long-winded "OK, will do" :)

-Evan
