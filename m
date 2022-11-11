Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299F7626287
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 21:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbiKKUIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 15:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbiKKUIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 15:08:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8914569DED
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 12:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668197227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ztz/XLY+gVz+oUJ3nFqgwH/snUdD+Aa6fbqfFn0t54Q=;
        b=DrY4YYdHg3KHyXUdkRRXsW89ArIUR9LL+Xw4mFJv6rLxKSPgpiuj8iijzLd7TWDgOv1uXT
        nUN+dBT/Wtv3Ou25EXMvbZOwYu+D4feksSVuic+ypG9UZGH5PPqfuEDXVuzMQd51DHZpiy
        C9HM1xKNtaSyZ+O6pEaTSd/JIIekXoM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-211-Q3rq-cyHMo2ulWpQEbEaxQ-1; Fri, 11 Nov 2022 15:07:06 -0500
X-MC-Unique: Q3rq-cyHMo2ulWpQEbEaxQ-1
Received: by mail-qk1-f199.google.com with SMTP id i17-20020a05620a249100b006fa2e10a2ecso5522679qkn.16
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 12:07:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ztz/XLY+gVz+oUJ3nFqgwH/snUdD+Aa6fbqfFn0t54Q=;
        b=qr+zVfihAw1luQBLAcWbOXvyBr5QM30YAos5laj/mmM/qUUKvhZNd3/BBLlPd7hqy7
         NiEHvzeG94oQ+4OCFBxAmf1H65ATE/eOIUF2UgIYk0dWQj0u1nlfhqc9bPA52n86ZzM3
         CdkfefLWe13PGWBuw/H22IvPq7spWfIgb5Us/OmcYumE6CCL484DOjJNZs9zFJ5FaICn
         lmutxSXr+GLBnRQOHw+l7Cl9sAEJY9sTfyDgc3M8scZhY5s/jpKfS1g7x4yosElYapYQ
         0mRTnC8bkGuE0g0Qy76oZhCvPKatWxkJzogs64kr33xFZXaIO5QxZFQ2uJAkAk60QIiX
         CA/Q==
X-Gm-Message-State: ANoB5pkRiOOz4HX7pibpRZUSINTNqD7uNHa+Jqxoe0/so4GnWjkODzJS
        IjOxEq2s+VHPmVbhj4LPUPC4ENjm+9D9sALlCKk6eKvivWifQE55DMdyqZYFl7XCtUJaJEcvPXS
        PK4iTMlUBrScMgWDhw1u2sxwBh+FDZWS6l/max1uW
X-Received: by 2002:ad4:5841:0:b0:4b7:ebc1:ecd6 with SMTP id de1-20020ad45841000000b004b7ebc1ecd6mr3495813qvb.9.1668197225867;
        Fri, 11 Nov 2022 12:07:05 -0800 (PST)
X-Google-Smtp-Source: AA0mqf68Jn9djmiUd4uv1/cfDmbQ+VLUpDoROQzfpclynblmshr7W68Ci6lUZZl77R84XzS9JdKfuZgUrn+NrxImjwc=
X-Received: by 2002:ad4:5841:0:b0:4b7:ebc1:ecd6 with SMTP id
 de1-20020ad45841000000b004b7ebc1ecd6mr3495779qvb.9.1668197225586; Fri, 11 Nov
 2022 12:07:05 -0800 (PST)
MIME-Version: 1.0
References: <202211100850.7A8DD75@keescook> <87iljl6ehe.fsf@intel.com> <202211111110.11B554B@keescook>
In-Reply-To: <202211111110.11B554B@keescook>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 11 Nov 2022 21:06:54 +0100
Message-ID: <CACO55tt5KOgDYMEw=spDeoMaYuj2GQOuHU+BEgadr1nQiFOGhw@mail.gmail.com>
Subject: Re: Coverity: nouveau_dp_irq(): Null pointer dereferences
To:     Kees Cook <keescook@chromium.org>
Cc:     Jani Nikula <jani.nikula@intel.com>, Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Ilia Mirkin <imirkin@alum.mit.edu>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@gmail.com>,
        "Nathan E. Egge" <unlord@xiph.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Dave Airlie <airlied@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 8:21 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Nov 11, 2022 at 11:13:17AM +0200, Jani Nikula wrote:
> > On Thu, 10 Nov 2022, coverity-bot <keescook@chromium.org> wrote:
> > > Hello!
> > >
> > > This is an experimental semi-automated report about issues detected by
> > > Coverity from a scan of next-20221110 as part of the linux-next scan project:
> > > https://scan.coverity.com/projects/linux-next-weekly-scan
> > >
> > > You're getting this email because you were associated with the identified
> > > lines of code (noted below) that were touched by commits:
> > >
> > >   Mon Aug 31 19:10:08 2020 -0400
> > >     a0922278f83e ("drm/nouveau/kms/nv50-: Refactor and cleanup DP HPD handling")
> >
> > Hi Kees, this looks like a good idea, but maybe double check the Cc list
> > generation? I was Cc'd on four mails today that I thought were
> > irrelevant to me.
>
> Hi!
>
> Heh, I was recently asked to _expand_ the CC list. :)
>
> For these last pass of reports, I added a get_maintainers.pl run to the
> identified commit. In this instance, the commit touched:
>
>  drivers/gpu/drm/nouveau/dispnv04/disp.c     |    6 +
>  drivers/gpu/drm/nouveau/dispnv50/disp.c     |  192 ++++++++++++++++++++++--------------------------
>  drivers/gpu/drm/nouveau/nouveau_connector.c |   14 ---
>  drivers/gpu/drm/nouveau/nouveau_display.c   |    2
>  drivers/gpu/drm/nouveau/nouveau_display.h   |    2
>  drivers/gpu/drm/nouveau/nouveau_dp.c        |  132 ++++++++++++++++++++++++++++-----
>  drivers/gpu/drm/nouveau/nouveau_encoder.h   |   33 +++++++-
>  7 files changed, 244 insertions(+), 137 deletions(-)
>
> And the get_maintainers.pl rationale was:
>
> Ben Skeggs <bskeggs@redhat.com> (supporter:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS,commit_signer:1/1=100%,commit_signer:6/16=38%,authored:4/16=25%,added_lines:23/124=19%,removed_lines:36/152=24%)
> Karol Herbst <kherbst@redhat.com> (supporter:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS,commit_signer:2/1=100%)
> Lyude Paul <lyude@redhat.com> (supporter:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS,commit_signer:9/16=56%,authored:6/16=38%,added_lines:92/124=74%,removed_lines:107/152=70%)
> David Airlie <airlied@gmail.com> (maintainer:DRM DRIVERS)
> Daniel Vetter <daniel@ffwll.ch> (maintainer:DRM DRIVERS)
> Ilia Mirkin <imirkin@alum.mit.edu> (commit_signer:1/1=100%,authored:1/1=100%,added_lines:2/2=100%,removed_lines:2/2=100%)
> "Nathan E. Egge" <unlord@xiph.org> (commit_signer:1/1=100%)
> Jani Nikula <jani.nikula@intel.com> (commit_signer:6/16=38%)
> Dave Airlie <airlied@redhat.com> (commit_signer:5/16=31%)
> Thomas Zimmermann <tzimmermann@suse.de> (commit_signer:4/16=25%,authored:4/16=25%)
> dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS)
> nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS)
>

I'd say it's good enough to message supporters and the mailing lists
for at least Nouveau code, maybe even all drm drivers.

Not sure what to do about actual maintainers, but I doubt Dave and
Daniel want to be CCed on every Coverity report here either.

Karol

>
> --
> Kees Cook
>

