Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0988960ED8F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 03:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbiJ0Bnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 21:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbiJ0Bn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 21:43:29 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF64C12B36F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 18:43:27 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id z24so183859ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 18:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbk0eEYbnn7UKEVn0VjxKM1ZNInMpSiFCIPCtUXFOvs=;
        b=vcuEklMwyzYukZhXgOEh3NEm2Y2yZpbE0LQpHdGh6ef/G/JA5hh4MOdbOtCXt2HIez
         N4efK9tWJruDjEfO7wdMeQGUlPR0aZxqq+A7QySZgCJwHnN8UgMK8M6cK+zhfvVEsgPB
         6Au7w+PZgloWRtYIORIzvH/fQV0XKsXGe6qOkDNtmekbGDTjW30ZUYXFHsBO6uEtunk8
         u9By8xMiIfnkI35rw2zP10T1RGbNczd7Aie6P65nEjGBC98vkNTdjhGcc9x/7eiz6+xd
         brNmpfHoVTPQdUpjYUSuujMNaErYgMsI6V+Kf37Rx/6vAVxcj5X3uTwaAxPGU7PMZEaG
         PXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbk0eEYbnn7UKEVn0VjxKM1ZNInMpSiFCIPCtUXFOvs=;
        b=VjCBufDE2lHcgwTKyIj97h0NgFd1KSu/EZTTmQTCQ7SNF6VcLTvOqPWUjc+Q8xh3Jj
         YR4FLawWAmVuqtJQlObcvoPu4iM8h2BzjNJ+7OmX8juBwC/u0NarcMTpuGQ5BxCo4Nc5
         kfHYiXfpAP9wD13yhlPrKeqWUYJlqRdYzplHJlUdyfltp7AVnkCaLEDrOXraTkFGD6Dq
         IAEVEGDmYznCmPd4+4DzcUuRMl1WdPEsloppdXUxZ5enPvBf0xCuxcUS1ELJpP7QHLyq
         epano10QgLaz4Qw5f58vxyp0KcimWh15tS1bQP5BJCu4nlIcDJq9FqTezXNgkAVVyeHl
         ku7g==
X-Gm-Message-State: ACrzQf0bJJEz6IBCes8SZDftZ//824dXyY77QnqK6E8BfhGXHAqaSNWj
        eoOQJZOEjL7xaED6qwW9TXvnyJgWAk2B9FPRCD/f8g==
X-Google-Smtp-Source: AMsMyM5clIdvVzDYgyLVmEepWcsuZSR1iy0Hq+hnVqzut780N0uW5jW40yCDD3lXn6vo7uZGtKTCO9CXsMk7cAngM3A=
X-Received: by 2002:a2e:8881:0:b0:255:7790:25e6 with SMTP id
 k1-20020a2e8881000000b00255779025e6mr17440388lji.525.1666835006300; Wed, 26
 Oct 2022 18:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220922092357.123732-1-mie@igel.co.jp> <20221025142143.GA109941@thinkpad>
 <HE1PR0401MB233126D2C7410EC5F6C3976488319@HE1PR0401MB2331.eurprd04.prod.outlook.com>
In-Reply-To: <HE1PR0401MB233126D2C7410EC5F6C3976488319@HE1PR0401MB2331.eurprd04.prod.outlook.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Thu, 27 Oct 2022 10:43:15 +0900
Message-ID: <CANXvt5qjnbZMzFJt8kBtQz6FHc_QQYw7=fZp8kK87mZ-t75z+g@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2] PCI: endpoint: pci-epf-{,v}ntb: fix a check
 for no epc alignment constraint
To:     Frank Li <frank.li@nxp.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

2022=E5=B9=B410=E6=9C=8826=E6=97=A5(=E6=B0=B4) 1:07 Frank Li <frank.li@nxp.=
com>:
>
>
>
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: Tuesday, October 25, 2022 9:22 AM
> > To: Shunsuke Mie <mie@igel.co.jp>
> > Cc: Jon Mason <jdmason@kudzu.us>; Dave Jiang <dave.jiang@intel.com>;
> > Allen Hubbe <allenbh@gmail.com>; Kishon Vijay Abraham I
> > <kishon@ti.com>; Lorenzo Pieralisi <lpieralisi@kernel.org>; Krzysztof
> > Wilczy=C5=84ski <kw@linux.com>; Bjorn Helgaas <bhelgaas@google.com>;
> > ntb@lists.linux.dev; linux-pci@vger.kernel.org; linux-kernel@vger.kerne=
l.org
> > Subject: [EXT] Re: [PATCH v2] PCI: endpoint: pci-epf-{,v}ntb: fix a che=
ck for no
> > epc alignment constraint
> >
> > Caution: EXT Email
> >
> > On Thu, Sep 22, 2022 at 06:23:57PM +0900, Shunsuke Mie wrote:
> > > Some PCI endpoint controllers have no alignment constraints, and the
> > > epc_features->align becomes 0. In this case, IS_ALIGNED() in
>
> [Frank Li] why not set epc_features->align 1
> no alignment constraints should mean align to byte.
It is one of the solutions too I think. But in that case,  we need to
write epc_features->align =3D 1 to all epc drivers, dwc, qcom, rcar,
tegra, and etc.

I think that my change is better.

> > > epf_ntb_config_spad_bar_alloc() doesn't work well. Check for this bef=
ore
> > > IS_ALIGNED().
> > >
> > > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> >
> > Reviewed-by: Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org>
> >
> > Thanks,
> > Mani
> >
> > > ---
> > > Changes in v2:
> > > * Fix the commit message in phrasings and words.
> > > ---
> > > ---
> > >  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 2 +-
> > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> > b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> > > index 9a00448c7e61..f74155ee8d72 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> > > @@ -1021,7 +1021,7 @@ static int epf_ntb_config_spad_bar_alloc(struct
> > epf_ntb *ntb,
> > >       peer_size =3D peer_epc_features->bar_fixed_size[peer_barno];
> > >
> > >       /* Check if epc_features is populated incorrectly */
> > > -     if ((!IS_ALIGNED(size, align)))
> > > +     if (align && (!IS_ALIGNED(size, align)))
> > >               return -EINVAL;
> > >
> > >       spad_count =3D ntb->spad_count;
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > index 0ea85e1d292e..5e346c0a0f05 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > @@ -418,7 +418,7 @@ static int epf_ntb_config_spad_bar_alloc(struct
> > epf_ntb *ntb)
> > >       size =3D epc_features->bar_fixed_size[barno];
> > >       align =3D epc_features->align;
> > >
> > > -     if ((!IS_ALIGNED(size, align)))
> > > +     if (align && !IS_ALIGNED(size, align))
> > >               return -EINVAL;
> > >
> > >       spad_count =3D ntb->spad_count;
> > > --
> > > 2.17.1
> > >
> >
> > --
> > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=
=AE=E0=AF=8D

Best,
Shunsuke
