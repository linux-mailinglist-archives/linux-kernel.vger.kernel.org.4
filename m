Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EB56246B4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiKJQRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiKJQRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:17:44 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D9819C1B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:17:37 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l6so1944601pjj.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bkSGDXPg6SJzvEs4XpsjJXXciVKxFTGfB+OBGN4kblY=;
        b=AnFETkrsVJJqBrsF335uPUsaYE8VQwzKw+7NH6AE51dCXKLkIuUl3ydcBWKECQxyzg
         PRPZcLLeYBI9Dpus6z4kG2pW/16OU6W07kKzanMVdGGnLoNXxeB7bGnefKytK93ExGGG
         MVJcnNF/YeDEsFFKW0JkD24SvOTLWO9UcKVOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkSGDXPg6SJzvEs4XpsjJXXciVKxFTGfB+OBGN4kblY=;
        b=y1oVbm4SseXKr2pxc7pMDNUwc2CGOGGPSYxyd+RvjYysZ8NYKBSVGhhROV1zZhbgH3
         bOuDubrQysGbQtdFkmBeynpPt9T0z/f7fhZrlTvlACNZmVbOI6BkOYRxN4RQPLJ2OX6e
         6nfgCFCqX/kDpw3WBEhL4CyJC0Uc6EVmZmIcuUoGbNnZjGSt9bnuvyj/8fdrsKmL4v9g
         OOAKg7m7Ypg2Hmpx4G0Gh5XMLxTt1A8rMr92ZBPxNW2yL7AF96tLD3mDRrzuGZkPA521
         jTqAIPxOlHsyRd5jEYe5odzo09S7j90cvpoIQeahFMQGA28KKNbfQvaHVQyeqJdIe6bt
         abcw==
X-Gm-Message-State: ACrzQf3bx+cgHxipDgV0NcbQgmHiC9ys+ughkjedKFR3ZBWa4S+Mi2yX
        xVy9x/nn8TvYoO+HJNXDLSMAQg==
X-Google-Smtp-Source: AMsMyM7Jrpt3ZFQjF+trFjU+RRUhzpv728jIYoSkYV+1lmT6sxEOWtIaF7lJQzkC53uldCs/vMAO/w==
X-Received: by 2002:a17:90b:4f45:b0:213:ccc6:87df with SMTP id pj5-20020a17090b4f4500b00213ccc687dfmr61500305pjb.227.1668097057311;
        Thu, 10 Nov 2022 08:17:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z25-20020aa79599000000b0056c702a370dsm10328039pfj.117.2022.11.10.08.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:17:36 -0800 (PST)
Date:   Thu, 10 Nov 2022 08:17:35 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Evan Green <evgreen@chromium.org>
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
Subject: Re: [PATCH v4 09/11] PM: hibernate: Mix user key in encrypted
 hibernate
Message-ID: <202211100816.FEF5A3305C@keescook>
References: <20221103180120.752659-1-evgreen@chromium.org>
 <20221103105558.v4.9.I87952411cf83f2199ff7a4cc8c828d357b8c8ce3@changeid>
 <202211041147.DEDC1F64F@keescook>
 <CAE=gft41=5uWwPfDZ=nyjcOzk21YCAeg6cheUNy-m0j79CgNfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=gft41=5uWwPfDZ=nyjcOzk21YCAeg6cheUNy-m0j79CgNfQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 04:30:10PM -0800, Evan Green wrote:
> On Fri, Nov 4, 2022 at 11:54 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Nov 03, 2022 at 11:01:17AM -0700, Evan Green wrote:
> > > Usermode may have their own data protection requirements when it comes
> > > to encrypting the hibernate image. For example, users may want a policy
> > > where the hibernate image is protected by a key derived both from
> > > platform-level security as well as authentication data (such as a
> > > password or PIN). This way, even if the platform is compromised (ie a
> > > stolen laptop), sensitive data cannot be exfiltrated via the hibernate
> > > image without additional data (like the user's password).
> > >
> > > The kernel is already doing the encryption, but will be protecting its
> > > key with the TPM alone. Allow usermode to mix in key content of their own
> > > for the data portion of the hibernate image, so that the image
> > > encryption key is determined both by a TPM-backed secret and
> > > user-defined data.
> > >
> > > To mix the user key in, we hash the kernel key followed by the user key,
> > > and use the resulting hash as the new key. This allows usermode to mix
> > > in its key material without giving it too much control over what key is
> > > actually driving the encryption (which might be used to attack the
> > > secret kernel key).
> > >
> > > Limiting this to the data portion allows the kernel to receive the page
> > > map and prepare its giant allocation even if this user key is not yet
> > > available (ie the user has not yet finished typing in their password).
> > > Once the user key becomes available, the data portion can be pushed
> > > through to the kernel as well. This enables "preloading" scenarios,
> > > where the hibernate image is loaded off of disk while the additional
> > > key material (eg password) is being collected.
> > >
> > > One annoyance of the "preloading" scheme is that hibernate image memory
> > > is effectively double-allocated: first by the usermode process pulling
> > > encrypted contents off of disk and holding it, and second by the kernel
> > > in its giant allocation in prepare_image(). An interesting future
> > > optimization would be to allow the kernel to accept and store encrypted
> > > page data before the user key is available. This would remove the
> > > double allocation problem, as usermode could push the encrypted pages
> > > loaded from disk immediately without storing them. The kernel could defer
> > > decryption of the data until the user key is available, while still
> > > knowing the correct page locations to store the encrypted data in.
> > >
> > > Signed-off-by: Evan Green <evgreen@chromium.org>
> > > ---
> > >
> > > (no changes since v2)
> > >
> > > Changes in v2:
> > >  - Add missing static on snapshot_encrypted_byte_count()
> > >  - Fold in only the used kernel key bytes to the user key.
> > >  - Make the user key length 32 (Eric)
> > >  - Use CRYPTO_LIB_SHA256 for less boilerplate (Eric)
> > >
> > >  include/uapi/linux/suspend_ioctls.h |  15 ++-
> > >  kernel/power/Kconfig                |   1 +
> > >  kernel/power/power.h                |   1 +
> > >  kernel/power/snapenc.c              | 158 ++++++++++++++++++++++++++--
> > >  kernel/power/snapshot.c             |   5 +
> > >  kernel/power/user.c                 |   4 +
> > >  kernel/power/user.h                 |  12 +++
> > >  7 files changed, 185 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/include/uapi/linux/suspend_ioctls.h b/include/uapi/linux/suspend_ioctls.h
> > > index b73026ef824bb9..f93a22eac52dc2 100644
> > > --- a/include/uapi/linux/suspend_ioctls.h
> > > +++ b/include/uapi/linux/suspend_ioctls.h
> > > @@ -25,6 +25,18 @@ struct uswsusp_key_blob {
> > >       __u8 nonce[USWSUSP_KEY_NONCE_SIZE];
> > >  } __attribute__((packed));
> > >
> > > +/*
> > > + * Allow user mode to fold in key material for the data portion of the hibernate
> > > + * image.
> > > + */
> > > +struct uswsusp_user_key {
> > > +     /* Kernel returns the metadata size. */
> > > +     __kernel_loff_t meta_size;
> > > +     __u32 key_len;
> > > +     __u8 key[32];
> >
> > Why is this 32? (Is there a non-literal we can put here?)
> 
> Sure, I can make a new define for this: USWSUSP_USER_KEY_SIZE. Really
> it just needs to be enough key material that usermode feels like
> they've swizzled things up enough. I wanted to avoid using a
> particular implementation constant like AES_KEYSIZE_256 because I
> wanted that to be a kernel implementation detail, and also wanted to
> avoid adding additional header dependencies to suspend_ioctls.h.

Can this just use __aligned(8) etc?

-- 
Kees Cook
