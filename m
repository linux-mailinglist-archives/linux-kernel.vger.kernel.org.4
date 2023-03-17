Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD376BF305
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjCQUsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCQUsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:48:05 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6063F2916A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:48:04 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id z11so3865408pfh.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679086084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuBt/2GYB4zlUmSNoni5wBFx2PIvhm01HofujPUXozE=;
        b=BeDJSvo4BUuGcyhTSvf6XsaOjajDfifCMOBxxWypdaRMIBNDfhTamZG6kFjtrhiQw/
         ACaCQ783l+KFo+Lh0RotkOSgiVMDdYbmGzeiEpdNdMbP3riYaQr56xvUbf5/+sTQgCgW
         Uh8nRGihKa5g/y8maf7ZfadngRVl3HPYHC7D6ITz3jVUuVTsihPnqA+wSJQ0V2p/UXxP
         zKYRITtUkDfsQhbuaWX0mGrnW+Zt7hn7ai9dFbQo2bhE1rPYNu0cnxVfB9oJM22tVeVc
         Ffs4FRDwZe5yhoWCYj9IjDb5o+37f5+mSirTDpjBQOUr8tbZQrK10fqdj/8ZRetI91v6
         z4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679086084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuBt/2GYB4zlUmSNoni5wBFx2PIvhm01HofujPUXozE=;
        b=qmmazcSIOKp6XrCwbwJwJWKDuYwA0iOtgarAjan8x42sY6EfE8uGaJP2FBu39VBB/g
         sY5aiQsht+azd7RzztGwMUZ6vP1zcHvlN9BnnVa1PF9s2zvlVVHt8476lmfyK9H6+ikV
         TYn/X5s/AtGm7eD6biYSCzT0Rn3WDb26lZugRxlgg6XZNWaVBSfl4GMexDSOnZMJPOSV
         sJnPCluTQu73IaeYiFWDcCzmcx1/UyiPqunfCrp03PXKL7L7t4mlD0G3lr2/EKpID1jU
         gum5tdSchMfJEWJKuU/XuHQiBEAEwDTW6T2lQMVjyESs2ruLtyREyHv1C5DuBQhsTvYB
         tLHg==
X-Gm-Message-State: AO0yUKWAgiMAhJ15/7d/Ai97xGHgk4ESs1r8jhj6rc1UbIO1LSSPu+nU
        6pNx6ogq+BJejqeG7sbTxxZUl8iv/TSCa2LL9eBQJQ==
X-Google-Smtp-Source: AK7set8Kpcsd/8RBCSaP4sAbXjoWOODA7lxT+EuORBe+QGWtoIQb0f4C4cAwJP1yw9FL83jGKCULsnGnXXgWbMKPM4A=
X-Received: by 2002:a65:4049:0:b0:50c:a00:c1fc with SMTP id
 h9-20020a654049000000b0050c0a00c1fcmr148690pgp.3.1679086083507; Fri, 17 Mar
 2023 13:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230317171943.941539-1-saravanak@google.com> <ZBStTXkZwMWj+Amj@kroah.com>
In-Reply-To: <ZBStTXkZwMWj+Amj@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 17 Mar 2023 13:47:27 -0700
Message-ID: <CAGETcx8nSE+-GmSpFNnXGPVmuLPSy6-ex23sE=bkD--tTzE7Xg@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: Add CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Anderson <dianders@chromium.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 11:11=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Mar 17, 2023 at 10:19:42AM -0700, Saravana Kannan wrote:
> > Add a build time equivalent of fw_devlink.sync_state=3Dtimeout so that
> > board specific kernels could enable it and not have to deal with settin=
g
> > or cluttering the kernel commandline.
> >
> > Cc: Doug Anderson <dianders@chromium.org>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/Kconfig | 12 ++++++++++++
> >  drivers/base/core.c  |  5 +++++
> >  2 files changed, 17 insertions(+)
> >
> > diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> > index 6f04b831a5c0..2b8fd6bb7da0 100644
> > --- a/drivers/base/Kconfig
> > +++ b/drivers/base/Kconfig
> > @@ -230,4 +230,16 @@ config GENERIC_ARCH_NUMA
> >         Enable support for generic NUMA implementation. Currently, RISC=
-V
> >         and ARM64 use it.
> >
> > +config FW_DEVLINK_SYNC_STATE_TIMEOUT
> > +     bool "sync_state() behavior defaults to timeout instead of strict=
"
> > +     help
> > +       This is build time equivalent of adding kernel command line par=
ameter
> > +       "fw_devlink.sync_state=3Dtimeout". Give up waiting on consumers=
 and
> > +       call sync_state() on any devices that haven't yet received thei=
r
> > +       sync_state() calls after deferred_probe_timeout has expired or =
by
> > +       late_initcall() if !CONFIG_MODULES. You should almost always wa=
nt to
> > +       select N here unless you have already successfully tested with =
the
> > +       command line option on every system/board your kernel is expect=
ed to
> > +       work on.
> > +
> >  endmenu
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index fe74a786e2c3..adc81871829f 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -1672,7 +1672,12 @@ early_param("fw_devlink.strict", fw_devlink_stri=
ct_setup);
> >  #define FW_DEVLINK_SYNC_STATE_STRICT 0
> >  #define FW_DEVLINK_SYNC_STATE_TIMEOUT        1
> >
> > +#ifndef CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT
> >  static int fw_devlink_sync_state;
> > +#else
> > +static int fw_devlink_sync_state =3D FW_DEVLINK_SYNC_STATE_TIMEOUT;
> > +#endif
> > +
> >  static int __init fw_devlink_sync_state_setup(char *arg)
> >  {
> >       if (!arg)
> > --
> > 2.40.0.rc2.332.ga46443480c-goog
> >
>
> Hi,
>
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>
> You are receiving this message because of the following common error(s)
> as indicated below:
>
> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/process/submitting-patches.rst for what
>   needs to be done here to properly describe this.

Ok, I'll send out a v4 with this added in. :)

-Saravana

>
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>
> thanks,
>
> greg k-h's patch email bot
