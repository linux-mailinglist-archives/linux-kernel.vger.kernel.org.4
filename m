Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D156F34D9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 19:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjEARFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 13:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbjEARFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 13:05:20 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD395592;
        Mon,  1 May 2023 09:59:19 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-18f4a6d2822so17568548fac.1;
        Mon, 01 May 2023 09:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682960312; x=1685552312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/SEaAflvpetMi4+nxY06+P/T33MSQGH6sSrAaXI1BA=;
        b=r0nFRQ420je1KUNVV1fjvkaxY8mGnW4c0nNzaSdCTY96lsVdUrsIc9aP6a8nlDITeH
         iudvN3i23BRSdk5DRkQhVREKcFMshE1558fLxMjvWsaE8WMY/FA/DLa/UWH/n3In0ClD
         Ccz4QU/Gfg3xqrjHJrhzqH2athEIFp29haLGlIrxLBhrFhZtquZpkc/gyeeZksqAUJwp
         6xt65IWqWInuICIwc5XOdEfSjNyipsC5KAYuItr/781IUZZ6d6iBqzeHEm8VkCq/vKiy
         UUDEPfGVzYM57SjozYEamh1Lptd6/LckWWQYcSaoxgOnh/0n8uiLcRfJxtXE4GmDaUmx
         6Mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960312; x=1685552312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/SEaAflvpetMi4+nxY06+P/T33MSQGH6sSrAaXI1BA=;
        b=WSnhwPcvWG5mNjfGrFXWiML44GpUSROE8pNtcSmizo4HupItQC3dUZoWwi7fG+VQm8
         Y57KAiwnzRR5hGWABM+Xt8wOzWETJyZ1N8MWlbKTdsO06Sb1IwVgbS6OSVVmiCF6McCH
         HXhqrpw6oePYQA9RlV5w6TUwTkxLcaZuc7b54/KASr0OzJz40aH0PxiZq7IVHbQvEdMN
         O/1YKdGO8Bxtd+9jGVFPbmUwguTiuge/vQ0UauxErgbhPxPhKhDEaC6itkF3NMiJamGn
         ZNQJGQSRpP7L//Vsi8if0F+EHKCtmXTYs3/zKxJY69r6qIDwycjPB45B2tf0UnXLH3/i
         jjiA==
X-Gm-Message-State: AC+VfDxqVlQkueTg5Qxs4vV1aK8r0yJqY4frPbQLXTERgm4tPUsuKkmX
        KymuKFr/9h1g24qN2WKPj8XEF3aR+aZp5fTusd0=
X-Google-Smtp-Source: ACHHUZ7Vsn3Anj6mP2QaI4Qq50jdI1PMMkNhHYR4SnlhoFhmDZ6byO7UP7PKxiZi4wAEDY66lRfjKnnrkTBGQ913Gs4=
X-Received: by 2002:a05:6808:116:b0:38d:ed4a:52f4 with SMTP id
 b22-20020a056808011600b0038ded4a52f4mr6442335oie.14.1682960311714; Mon, 01
 May 2023 09:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230427175340.1280952-1-robdclark@gmail.com> <20230427175340.1280952-9-robdclark@gmail.com>
 <135ff649-e50c-50f4-55ba-a1b615865e02@linux.intel.com>
In-Reply-To: <135ff649-e50c-50f4-55ba-a1b615865e02@linux.intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 1 May 2023 09:58:20 -0700
Message-ID: <CAF6AEGvKnPgtna4yjN56mMjCLqpjs8B8K152VWxmPs1NdY78vA@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] drm/fdinfo: Add comm/cmdline override fields
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 4:05=E2=80=AFAM Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
>
> On 27/04/2023 18:53, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > These are useful in particular for VM scenarios where the process which
> > has opened to drm device file is just a proxy for the real user in a VM
> > guest.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   Documentation/gpu/drm-usage-stats.rst | 18 ++++++++++++++++++
> >   drivers/gpu/drm/drm_file.c            | 15 +++++++++++++++
> >   include/drm/drm_file.h                | 19 +++++++++++++++++++
> >   3 files changed, 52 insertions(+)
> >
> > diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/=
drm-usage-stats.rst
> > index 58dc0d3f8c58..e4877cf8089c 100644
> > --- a/Documentation/gpu/drm-usage-stats.rst
> > +++ b/Documentation/gpu/drm-usage-stats.rst
> > @@ -73,6 +73,24 @@ scope of each device, in which case `drm-pdev` shall=
 be present as well.
> >   Userspace should make sure to not double account any usage statistics=
 by using
> >   the above described criteria in order to associate data to individual=
 clients.
> >
> > +- drm-comm-override: <valstr>
> > +
> > +Returns the client executable override string.  Some drivers support l=
etting
> > +userspace override this in cases where the userspace is simply a "prox=
y".
> > +Such as is the case with virglrenderer drm native context, where the h=
ost
> > +process is just forwarding command submission, etc, from guest userspa=
ce.
> > +This allows the proxy to make visible the executable name of the actua=
l
> > +app in the VM guest.
> > +
> > +- drm-cmdline-override: <valstr>
> > +
> > +Returns the client cmdline override string.  Some drivers support lett=
ing
> > +userspace override this in cases where the userspace is simply a "prox=
y".
> > +Such as is the case with virglrenderer drm native context, where the h=
ost
> > +process is just forwarding command submission, etc, from guest userspa=
ce.
> > +This allows the proxy to make visible the cmdline of the actual app in=
 the
> > +VM guest.
>
> Perhaps it would be okay to save space here by not repeating the
> description, like:
>
> drm-comm-override: <valstr>
> drm-cmdline-override: <valstr>
>
> Long description blah blah...
> This allows the proxy to make visible the _executable name *and* command
> line_ blah blah..
>
> > +
> >   Utilization
> >   ^^^^^^^^^^^
> >
> > diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> > index 9321eb0bf020..d7514c313af1 100644
> > --- a/drivers/gpu/drm/drm_file.c
> > +++ b/drivers/gpu/drm/drm_file.c
> > @@ -178,6 +178,8 @@ struct drm_file *drm_file_alloc(struct drm_minor *m=
inor)
> >       spin_lock_init(&file->master_lookup_lock);
> >       mutex_init(&file->event_read_lock);
> >
> > +     mutex_init(&file->override_lock);
> > +
> >       if (drm_core_check_feature(dev, DRIVER_GEM))
> >               drm_gem_open(dev, file);
> >
> > @@ -292,6 +294,8 @@ void drm_file_free(struct drm_file *file)
> >       WARN_ON(!list_empty(&file->event_list));
> >
> >       put_pid(file->pid);
> > +     kfree(file->override_comm);
> > +     kfree(file->override_cmdline);
> >       kfree(file);
> >   }
> >
> > @@ -995,6 +999,17 @@ void drm_show_fdinfo(struct seq_file *m, struct fi=
le *f)
> >                          PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
> >       }
> >
> > +     mutex_lock(&file->override_lock);
>
> You could add a fast unlocked check before taking the mutex for no risk
> apart a transient false negative. For 99.9999% of userspace it would
> mean no pointless lock/unlock cycle.

I'm not sure I get your point?  This needs to be serialized against
userspace setting the override values

>
> > +     if (file->override_comm) {
> > +             drm_printf(&p, "drm-comm-override:\t%s\n",
> > +                        file->override_comm);
> > +     }
> > +     if (file->override_cmdline) {
> > +             drm_printf(&p, "drm-cmdline-override:\t%s\n",
> > +                        file->override_cmdline);
> > +     }
> > +     mutex_unlock(&file->override_lock);
> > +
> >       if (dev->driver->show_fdinfo)
> >               dev->driver->show_fdinfo(&p, file);
> >   }
> > diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> > index 1339e925af52..604d05fa6f0c 100644
> > --- a/include/drm/drm_file.h
> > +++ b/include/drm/drm_file.h
> > @@ -370,6 +370,25 @@ struct drm_file {
> >        */
> >       struct drm_prime_file_private prime;
> >
> > +     /**
> > +      * @comm: Overridden task comm
> > +      *
> > +      * Accessed under override_lock
> > +      */
> > +     char *override_comm;
> > +
> > +     /**
> > +      * @cmdline: Overridden task cmdline
> > +      *
> > +      * Accessed under override_lock
> > +      */
> > +     char *override_cmdline;
> > +
> > +     /**
> > +      * @override_lock: Serialize access to override_comm and override=
_cmdline
> > +      */
> > +     struct mutex override_lock;
> > +
>
> I don't think this should go to drm just yet though. Only one driver can
> make use of it so I'd leave it for later and print from msm_show_fdinfo
> for now.

This was my original approach but danvet asked that it be moved into
drm for consistency across drivers.  (And really, I want the in-flight
amd and intel native-context stuff to motivate adding similar features
to amdgpu/i915/xe.)

BR,
-R

> Regards,
>
> Tvrtko
>
> >       /* private: */
> >   #if IS_ENABLED(CONFIG_DRM_LEGACY)
> >       unsigned long lock_count; /* DRI1 legacy lock count */
