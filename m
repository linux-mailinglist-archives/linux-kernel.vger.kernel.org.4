Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D840F6FF31F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbjEKNhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238379AbjEKNft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:35:49 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96B2D2E0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:34:43 -0700 (PDT)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2665C3F550
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 13:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683812080;
        bh=011K5wvvIoIZK715UN1HjkgAo3VxiaK+uINHfyAtcqg=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=rsJeGs1byvqB01fvP1Ms/VqC9aEHrba+Ob4gfkJY/ld7mSME9V2GDos24gogmXpr/
         CMHiJgCtRkuCh5xPJ55UFpyffvR724XT/8OsnbJ6agm/LnnTYDHp0VLXepHn+Ll6Wd
         Lrk4eXgAOeqAS+N5yMIdfS8Z1gfH9JZ3iaQFN/frotnStNRIZYte/cnb6Nkxk/pFLz
         p8cuxBhq4s93WBAO0Rh+XnrHf/enf9I1/ND9Bt86GCjVOBAjrHjcpOEJgqUorJyZUQ
         otXve44skLJ0uGmYqsjEbL826T62XdiJzDIxT9zMQXUbsFBF6H0/+a5GcheGrVMjd0
         fO4IWooqlmKPQ==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-24dfb0c13dbso4816684a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683812078; x=1686404078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=011K5wvvIoIZK715UN1HjkgAo3VxiaK+uINHfyAtcqg=;
        b=PG4SynfCkA6ADRI0du76HFZzGEo+bsLI4aShayUr5R9pZ2OnTvUqbjAt8KFRnxDqQ1
         dmMzorVULlKtcccmKENMQQrYfKirwG2SGm/v4lZEm0NV/PC8PxDPCG0owXUnMG4T4/lb
         fIzu7wyhtMDC2kziuSkwFlKeofchl6PZNznqKYst+Je6FrJkeLMcOly/R+BNeCleYy/g
         Z6nICgf+IcvKi/5mAWYm6JNkyZWLTpt1KaLusqbNMGGiwE1yEJCQRXGF3FqhFaoqoCoc
         dimMVDJNuIQ/vjCJ4oYAEXO3Fv2j+i8eOPyH7XnQCeIe3vea914U4oP9QXP17qAmbTTC
         Sh1A==
X-Gm-Message-State: AC+VfDw7e0cPnVd2fj2OhwHTWzu/MoWsnW0VdX5PRvvh76KM4t5gqB8W
        3eLPd8EdeT+7jUgq4gb57e+4PQ3v4tKcJNX0I7W2xzaNT9kRhyOTOLKJBBPmDkOHeYQ8LIzSu3/
        m0/EjkGxTYJCHEe89asgfOBfSPB0woMc++UsFxXWF/HLl2GO7VUnIZMzHcQ==
X-Received: by 2002:a17:90a:db4d:b0:250:8258:1a5 with SMTP id u13-20020a17090adb4d00b00250825801a5mr15729702pjx.33.1683812077995;
        Thu, 11 May 2023 06:34:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4PM1BwcYbS1lb5Q9CzUvOu/d5br84AluARyXzOfos8pADmP57XceNs9VQKShDZU3Dx3q9SP47ED8gQ1AomNMk=
X-Received: by 2002:a17:90a:db4d:b0:250:8258:1a5 with SMTP id
 u13-20020a17090adb4d00b00250825801a5mr15729681pjx.33.1683812077662; Thu, 11
 May 2023 06:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230424055249.460381-1-kai.heng.feng@canonical.com>
 <20230424055249.460381-2-kai.heng.feng@canonical.com> <97260e8b-1892-49a5-3792-0e3c28378fc0@linux.intel.com>
In-Reply-To: <97260e8b-1892-49a5-3792-0e3c28378fc0@linux.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 11 May 2023 21:34:26 +0800
Message-ID: <CAAd53p5FUJpd2jENOo6YV8MhXdA1pZiO8G3Ho0x26=gL+vDAqw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] PCI/AER: Disable AER interrupt on suspend
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        koba.ko@canonical.com, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 7:47=E2=80=AFAM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 4/23/23 10:52 PM, Kai-Heng Feng wrote:
> > PCIe service that shares IRQ with PME may cause spurious wakeup on
> > system suspend.
> >
> > PCIe Base Spec 5.0, section 5.2 "Link State Power Management" states
> > that TLP and DLLP transmission is disabled for a Link in L2/L3 Ready
> > (D3hot), L2 (D3cold with aux power) and L3 (D3cold), so we don't lose
> > much here to disable AER during system suspend.
> >
> > This is very similar to previous attempts to suspend AER and DPC [1],
> > but with a different reason.
> >
> > [1] https://lore.kernel.org/linux-pci/20220408153159.106741-1-kai.heng.=
feng@canonical.com/
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216295
> >
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
>
> IIUC, you encounter AER errors during the suspend/resume process, which
> results in AER IRQ. Because AER and PME share an IRQ, it is regarded as a
> spurious wake-up IRQ. So to fix it, you want to disable AER reporting,
> right?
>
> It looks like it is harmless to disable the AER during the suspend/resume
> path. But, I am wondering why we get these errors? Did you check what err=
ors
> you get during the suspend/resume path? Are these errors valid?

AFAIK those errors comes from firmware/hardware side, especially when
the device gets put to D3hot/D3cold.

Kai-Heng

>
>
> >  drivers/pci/pcie/aer.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 1420e1f27105..9c07fdbeb52d 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1356,6 +1356,26 @@ static int aer_probe(struct pcie_device *dev)
> >       return 0;
> >  }
> >
> > +static int aer_suspend(struct pcie_device *dev)
> > +{
> > +     struct aer_rpc *rpc =3D get_service_data(dev);
> > +     struct pci_dev *pdev =3D rpc->rpd;
> > +
> > +     aer_disable_irq(pdev);
> > +
> > +     return 0;
> > +}
> > +
> > +static int aer_resume(struct pcie_device *dev)
> > +{
> > +     struct aer_rpc *rpc =3D get_service_data(dev);
> > +     struct pci_dev *pdev =3D rpc->rpd;
> > +
> > +     aer_enable_irq(pdev);
> > +
> > +     return 0;
> > +}
> > +
> >  /**
> >   * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
> >   * @dev: pointer to Root Port, RCEC, or RCiEP
> > @@ -1420,6 +1440,8 @@ static struct pcie_port_service_driver aerdriver =
=3D {
> >       .service        =3D PCIE_PORT_SERVICE_AER,
> >
> >       .probe          =3D aer_probe,
> > +     .suspend        =3D aer_suspend,
> > +     .resume         =3D aer_resume,
> >       .remove         =3D aer_remove,
> >  };
> >
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
