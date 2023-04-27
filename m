Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D586F0882
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244225AbjD0PjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244020AbjD0PjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:39:01 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203AE2701
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:39:00 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-506bfe81303so14644477a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682609938; x=1685201938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOPDPkAjGzQYhj/N9AfC0/FiIQg/4kHF1MpXLBODbrU=;
        b=k4na/pLblhHbmmtex6/PfrXbwAmnm0KPNkO5bjnAoPnvCmetJB08nghxQgd+Zq/oo1
         OJIxju8LOeG3ujlUHrqg3+kZPihgYItis1Ttv2QRameabQd4nZmBop2MTRE0P45tNmur
         5d8qQbavxk0kmD53JzZMIgJzkWSGXK/uO6muc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682609938; x=1685201938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOPDPkAjGzQYhj/N9AfC0/FiIQg/4kHF1MpXLBODbrU=;
        b=cuG4ykiWrgbSZYBOqf5qXNVesb1hTpVV7eRQgiDWrLACzgURoXAulXVjeD2BwxoJT4
         Ly6Hbq4FrQLLyW6CxWn7lslP++AS60ek9R4XQNkmrW03FA04Cwo3nLyKSxgIvGCTjAu4
         SVQWgICoS7CoKSncQ3ZB2qs7Gc/SjfTe5k/Z+pAu27dYquTWQ1JNyMj56wXhED3OqaQD
         +X69yI0/FOTx7xpDTCPT2ulXS3bFkNEGIbJ1efNQQKYFzfDNqVPDHjakz/4lfEqoHHqw
         D222g7s5Cz/c0ClFBwOFGuFVGqJCUZlDXj1+P1o7zeW10XCpBg1jQOMHIJJHSH77+Tu4
         v/5Q==
X-Gm-Message-State: AC+VfDySvlbiJsuzNGMkDaAQqJNfkXY1Qpvc4KRyrXsXgOLUhQKp/Qdi
        k7t8MLS09vOij6ADfx/nzTOIu7HhL4kKh5AgCF0V7g==
X-Google-Smtp-Source: ACHHUZ4lUClq2LdfXbT6eMkXuy+BS7xLy5DAIZH/H6siIuTNbPqbBCE6U5qe/u2FYGF2JSvkCMxOsg==
X-Received: by 2002:a50:ff0b:0:b0:504:923f:e657 with SMTP id a11-20020a50ff0b000000b00504923fe657mr1817934edu.35.1682609938265;
        Thu, 27 Apr 2023 08:38:58 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id b13-20020aa7df8d000000b004fa012332ecsm8090688edy.1.2023.04.27.08.38.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 08:38:57 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3f19a80a330so41688975e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:38:57 -0700 (PDT)
X-Received: by 2002:a1c:7211:0:b0:3f1:830a:a345 with SMTP id
 n17-20020a1c7211000000b003f1830aa345mr1817435wmc.11.1682609936875; Thu, 27
 Apr 2023 08:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230421162749.360777-1-markyacoub@google.com>
 <20230421162749.360777-2-markyacoub@google.com> <ZEpHfxw5IhzGFStV@phenom.ffwll.local>
In-Reply-To: <ZEpHfxw5IhzGFStV@phenom.ffwll.local>
From:   Sean Paul <seanpaul@chromium.org>
Date:   Thu, 27 Apr 2023 11:38:07 -0400
X-Gmail-Original-Message-ID: <CAOw6vbKi5XRnBvAR1P+=pFYL7FUo3m=4xbHjBOEDU1BOoEowzQ@mail.gmail.com>
Message-ID: <CAOw6vbKi5XRnBvAR1P+=pFYL7FUo3m=4xbHjBOEDU1BOoEowzQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm: Create support for Write-Only property blob
To:     Mark Yacoub <markyacoub@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, seanpaul@chromium.org,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 5:59=E2=80=AFAM Daniel Vetter <daniel@ffwll.ch> wro=
te:
>
> On Fri, Apr 21, 2023 at 12:27:47PM -0400, Mark Yacoub wrote:
> > From: Mark Yacoub <markyacoub@chromium.org>
> >
> > [Why]
> > User space might need to inject data into the kernel without allowing i=
t
> > to be read again by any user space.
> > An example of where this is particularly useful is secret keys fetched
> > by user space and injected into the kernel to enable content protection=
.
> >
> > [How]
> > Create a DRM_MODE_CREATE_BLOB_WRITE_ONLY flag used by user space to
> > create a blob and mark the blob as write only.
> > On reading back the blob, data will be not be copied if it's a write
> > only blob
>
> This makes no sense at all, why would you want to disallow reading?
> Userspace already knows the key, there's not much point in hiding it from
> userspace?

There are varying levels of trust amongst userspace applications. For
example, in CrOS we trust portions of Chrome to handle the key
securely, but would like to avoid access from other portions, or users
from exposing the key via modetest output. We could play whack-a-mole
and try to patch up all untrusted userspace, but that doesn't seem
like a scalable solution.

Sean

>
> Also for new uapi we need the igt patches and userspace, please link
> those.
> -Daniel
>
> >
> > Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> > ---
> >  drivers/gpu/drm/drm_property.c | 3 ++-
> >  include/drm/drm_property.h     | 2 ++
> >  include/uapi/drm/drm_mode.h    | 6 ++++++
> >  3 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_prope=
rty.c
> > index dfec479830e49..afedf7109d002 100644
> > --- a/drivers/gpu/drm/drm_property.c
> > +++ b/drivers/gpu/drm/drm_property.c
> > @@ -765,7 +765,7 @@ int drm_mode_getblob_ioctl(struct drm_device *dev,
> >       if (!blob)
> >               return -ENOENT;
> >
> > -     if (out_resp->length =3D=3D blob->length) {
> > +     if (out_resp->length =3D=3D blob->length && !blob->is_write_only)=
 {
> >               if (copy_to_user(u64_to_user_ptr(out_resp->data),
> >                                blob->data,
> >                                blob->length)) {
> > @@ -800,6 +800,7 @@ int drm_mode_createblob_ioctl(struct drm_device *de=
v,
> >               ret =3D -EFAULT;
> >               goto out_blob;
> >       }
> > +     blob->is_write_only =3D out_resp->flags & DRM_MODE_CREATE_BLOB_WR=
ITE_ONLY;
> >
> >       /* Dropping the lock between create_blob and our access here is s=
afe
> >        * as only the same file_priv can remove the blob; at this point,=
 it is
> > diff --git a/include/drm/drm_property.h b/include/drm/drm_property.h
> > index 65bc9710a4702..700782f021b99 100644
> > --- a/include/drm/drm_property.h
> > +++ b/include/drm/drm_property.h
> > @@ -205,6 +205,7 @@ struct drm_property {
> >   *   &drm_mode_config.property_blob_list.
> >   * @head_file: entry on the per-file blob list in &drm_file.blobs list=
.
> >   * @length: size of the blob in bytes, invariant over the lifetime of =
the object
> > + * @is_write_only: user space can't read the blob data.
> >   * @data: actual data, embedded at the end of this structure
> >   *
> >   * Blobs are used to store bigger values than what fits directly into =
the 64
> > @@ -219,6 +220,7 @@ struct drm_property_blob {
> >       struct list_head head_global;
> >       struct list_head head_file;
> >       size_t length;
> > +     bool is_write_only;
> >       void *data;
> >  };
> >
> > diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> > index 46becedf5b2fc..10403c9a73082 100644
> > --- a/include/uapi/drm/drm_mode.h
> > +++ b/include/uapi/drm/drm_mode.h
> > @@ -1168,6 +1168,9 @@ struct drm_format_modifier {
> >       __u64 modifier;
> >  };
> >
> > +#define DRM_MODE_CREATE_BLOB_WRITE_ONLY                               =
         \
> > +     (1 << 0) /* data of the blob can't be read by user space */
> > +
> >  /**
> >   * struct drm_mode_create_blob - Create New blob property
> >   *
> > @@ -1181,6 +1184,9 @@ struct drm_mode_create_blob {
> >       __u32 length;
> >       /** @blob_id: Return: new property ID. */
> >       __u32 blob_id;
> > +     /** Flags for special handling. */
> > +     __u32 flags;
> > +     __u32 pad;
> >  };
> >
> >  /**
> > --
> > 2.40.0.634.g4ca3ef3211-goog
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
