Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F336BDFD4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 04:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjCQDw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 23:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjCQDw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:52:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6464B328D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 20:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679025135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P6nMELQc3aZhdTBOjYGwUQAGi/KtZk4HGyGLW+5OJoY=;
        b=hOikX4Skj9/abVUR7ex3h0qyO7syPa9Uey8LjW7PHwE2poMZodbG8nF36Wi7tzswXG1ENB
        a52+TlTnaMCBSyZYDN+10LGGxFkSraLeZiaJvneHE3MveL8E7bFYWxfUoMO2wWZC2tivdI
        zsUx8VrMd48ANh0vEJxsKQxcJysCB0c=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-JNAS7nTXNwm7tYg9K4POew-1; Thu, 16 Mar 2023 23:52:14 -0400
X-MC-Unique: JNAS7nTXNwm7tYg9K4POew-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-17270774b8fso2286384fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 20:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679025133;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6nMELQc3aZhdTBOjYGwUQAGi/KtZk4HGyGLW+5OJoY=;
        b=VCEptWQZgWtyCHkrWSrl4F4l67PJH1l/R2c/CzcGuqI3H9UwUvETHsBBzJ88Blp30n
         zTk6WhdeeQ+3FRAvKqPaSBxvoKfXijqgxKWhWewMu+9sDMeDFL7ewetnNHrF7W6eWDP3
         losGPtIFPVtjd+MAJKRyfp+uh3igAxA7y50Bxz+9z8fkUUAVFlQm2GPbjRQmZkJHPwS6
         32VNzq3tVKc1f8UvDZjNeNl+jr2MbMIvvERqRrnJ7+0XaTPYuL2+MhipxTvzFW/V5jQx
         ylf7x1OiDLO1XtfY/wnA+nrjm3dyRkEicBQmxPIUuxj1CAbBX9MNcLNo0YxnzX7PIIG2
         +Q/A==
X-Gm-Message-State: AO0yUKUMKp3GV8Q7OCMT/nR8BOZRzWD5+EtksE74ZQPwnSx45ZALjQpW
        sLGVf2tagCo8p4Z5bgozAOQqW58vb8H5ft2RHrbVkgivPTjJhsjrB4IhwXLbsRiT2/AL/ZgcSZt
        v9Fm/qZ5V5NPwrFelRCucN2rRXuCHoTxoJJM/JjJh
X-Received: by 2002:a05:6870:6787:b0:177:b9c0:bcba with SMTP id gc7-20020a056870678700b00177b9c0bcbamr692844oab.3.1679025133298;
        Thu, 16 Mar 2023 20:52:13 -0700 (PDT)
X-Google-Smtp-Source: AK7set+HLa7SD6B2zxDDOqrsOs8bhWBQxhde0VgKL5Xs4K0OY4goOSfhodGeCKuYam6F1f33DaY2jy2T+ziwM4Vf/SE=
X-Received: by 2002:a05:6870:6787:b0:177:b9c0:bcba with SMTP id
 gc7-20020a056870678700b00177b9c0bcbamr692829oab.3.1679025133047; Thu, 16 Mar
 2023 20:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230307113621.64153-1-gautam.dawar@amd.com> <20230307113621.64153-2-gautam.dawar@amd.com>
 <CACGkMEubKv-CGgTdTbt=Ja=pbazXT3nOGY9f_VtRwrOsmf8-rw@mail.gmail.com>
 <ZA8OBEDECFI4grXG@gmail.com> <071329fe-7215-235c-06b7-f17bf69d872b@redhat.com>
 <ZBLcKs+IsgJBjqeT@gmail.com>
In-Reply-To: <ZBLcKs+IsgJBjqeT@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 17 Mar 2023 11:52:02 +0800
Message-ID: <CACGkMEtOV7pcMZ2=bdUr4BtE4ZTf0wZZSdTB8+OQrwHiZrHrEA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 01/14] sfc: add function personality support
 for EF100 devices
To:     Jason Wang <jasowang@redhat.com>,
        Gautam Dawar <gautam.dawar@amd.com>, linux-net-drivers@amd.com,
        Edward Cree <ecree.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        eperezma@redhat.com, harpreet.anand@amd.com, tanuj.kamde@amd.com,
        koushik.dutta@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 5:07=E2=80=AFPM Martin Habets <habetsm.xilinx@gmail=
.com> wrote:
>
> On Wed, Mar 15, 2023 at 01:11:23PM +0800, Jason Wang wrote:
> >
> > =E5=9C=A8 2023/3/13 19:50, Martin Habets =E5=86=99=E9=81=93:
> > > On Fri, Mar 10, 2023 at 01:04:14PM +0800, Jason Wang wrote:
> > > > On Tue, Mar 7, 2023 at 7:36=E2=80=AFPM Gautam Dawar <gautam.dawar@a=
md.com> wrote:
> > > > > A function personality defines the location and semantics of
> > > > > registers in the BAR. EF100 NICs allow different personalities
> > > > > of a PCIe function and changing it at run-time. A total of three
> > > > > function personalities are defined as of now: EF100, vDPA and
> > > > > None with EF100 being the default.
> > > > > For now, vDPA net devices can be created on a EF100 virtual
> > > > > function and the VF personality will be changed to vDPA in the
> > > > > process.
> > > > >
> > > > > Co-developed-by: Martin Habets <habetsm.xilinx@gmail.com>
> > > > > Signed-off-by: Martin Habets <habetsm.xilinx@gmail.com>
> > > > > Signed-off-by: Gautam Dawar <gautam.dawar@amd.com>
> > > > > ---
> > > > >   drivers/net/ethernet/sfc/ef100.c     |  6 +-
> > > > >   drivers/net/ethernet/sfc/ef100_nic.c | 98 +++++++++++++++++++++=
++++++-
> > > > >   drivers/net/ethernet/sfc/ef100_nic.h | 11 ++++
> > > > >   3 files changed, 111 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/ethernet/sfc/ef100.c b/drivers/net/ether=
net/sfc/ef100.c
> > > > > index 71aab3d0480f..c1c69783db7b 100644
> > > > > --- a/drivers/net/ethernet/sfc/ef100.c
> > > > > +++ b/drivers/net/ethernet/sfc/ef100.c
> > > > > @@ -429,8 +429,7 @@ static void ef100_pci_remove(struct pci_dev *=
pci_dev)
> > > > >          if (!efx)
> > > > >                  return;
> > > > >
> > > > > -       probe_data =3D container_of(efx, struct efx_probe_data, e=
fx);
> > > > > -       ef100_remove_netdev(probe_data);
> > > > > +       efx_ef100_set_bar_config(efx, EF100_BAR_CONFIG_NONE);
> > > > >   #ifdef CONFIG_SFC_SRIOV
> > > > >          efx_fini_struct_tc(efx);
> > > > >   #endif
> > > > > @@ -443,6 +442,7 @@ static void ef100_pci_remove(struct pci_dev *=
pci_dev)
> > > > >          pci_disable_pcie_error_reporting(pci_dev);
> > > > >
> > > > >          pci_set_drvdata(pci_dev, NULL);
> > > > > +       probe_data =3D container_of(efx, struct efx_probe_data, e=
fx);
> > > > >          efx_fini_struct(efx);
> > > > >          kfree(probe_data);
> > > > >   };
> > > > > @@ -508,7 +508,7 @@ static int ef100_pci_probe(struct pci_dev *pc=
i_dev,
> > > > >                  goto fail;
> > > > >
> > > > >          efx->state =3D STATE_PROBED;
> > > > > -       rc =3D ef100_probe_netdev(probe_data);
> > > > > +       rc =3D efx_ef100_set_bar_config(efx, EF100_BAR_CONFIG_EF1=
00);
> > > > >          if (rc)
> > > > >                  goto fail;
> > > > >
> > > > > diff --git a/drivers/net/ethernet/sfc/ef100_nic.c b/drivers/net/e=
thernet/sfc/ef100_nic.c
> > > > > index 4dc643b0d2db..8cbe5e0f4bdf 100644
> > > > > --- a/drivers/net/ethernet/sfc/ef100_nic.c
> > > > > +++ b/drivers/net/ethernet/sfc/ef100_nic.c
> > > > > @@ -772,6 +772,99 @@ static int efx_ef100_get_base_mport(struct e=
fx_nic *efx)
> > > > >          return 0;
> > > > >   }
> > > > >
> > > > > +/* BAR configuration.
> > > > > + * To change BAR configuration, tear down the current configurat=
ion (which
> > > > > + * leaves the hardware in the PROBED state), and then initialise=
 the new
> > > > > + * BAR state.
> > > > > + */
> > > > > +struct ef100_bar_config_ops {
> > > > > +       int (*init)(struct efx_probe_data *probe_data);
> > > > > +       void (*fini)(struct efx_probe_data *probe_data);
> > > > > +};
> > > > > +
> > > > > +static const struct ef100_bar_config_ops bar_config_ops[] =3D {
> > > > > +       [EF100_BAR_CONFIG_EF100] =3D {
> > > > > +               .init =3D ef100_probe_netdev,
> > > > > +               .fini =3D ef100_remove_netdev
> > > > > +       },
> > > > > +#ifdef CONFIG_SFC_VDPA
> > > > > +       [EF100_BAR_CONFIG_VDPA] =3D {
> > > > > +               .init =3D NULL,
> > > > > +               .fini =3D NULL
> > > > > +       },
> > > > > +#endif
> > > > > +       [EF100_BAR_CONFIG_NONE] =3D {
> > > > > +               .init =3D NULL,
> > > > > +               .fini =3D NULL
> > > > > +       },
> > > > > +};
> > > > This looks more like a mini bus implementation. I wonder if we can
> > > > reuse an auxiliary bus here which is more user friendly for managem=
ent
> > > > tools.
> > > When we were in the design phase of vDPA for EF100 it was still calle=
d
> > > virtbus, and the virtbus discussion was in full swing at that time.
> > > We could not afford to add risk to the project by depending on it, as
> > > it might not have been merged at all.
> >
> >
> > Right.
> >
> >
> > > If we were doing the same design now I would definitely consider usin=
g
> > > the auxiliary bus.
> > >
> > > Martin
> >
> >
> > But it's not late to do the change now. Auxiliary bus has been used by =
a lot
> > of devices (even with vDPA device). The change looks not too complicate=
d.
>
> I'm surprised you think this would not be complicated. From my view it wo=
uld
> require redesign, redevelopment and retest of vdpa which would take month=
s. That is
> assuming we can get some of the resources back.

I think I'm fine if we agree to do it sometime in the future.

>
> > This looks more scalable and convenient for management layer.
>
> There is not much difference for the management layer, it uses the vdpa t=
ool now
> and it would do so with the auxiliary bus.

At the vDPA level it doesn't make too much difference.

> The difference is that with the
> auxiliary bus users would have to load another module for sfc vDPA suppor=
t.

The policy is fully under the control of the management instead of the
hard-coding policy now, more below.

> Are we maybe on 2 different trains of thought here?

If I read the code correct, when VF is probed:

1) vDPA mgmtdev is registered
2) netdev is probed, bar config set to netdev

This means when user want to create vDPA device

1) unregister netdev
2) vDPA is probed, bar config set to vDPA

And when vDPA device is deleted:

1) unregister vDPA
2) netdev is probed, bat config set to netdev

There would be a lot of side effects for the mandated policy of
registering/unregistering netdevs like udev events etc when adding and
removing vDPA devices.

Thanks

>
> Martin
>

