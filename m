Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502DD6EA322
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 07:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjDUFcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 01:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjDUFc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 01:32:29 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA665B93
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 22:32:27 -0700 (PDT)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C9AFE44278
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 05:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1682055145;
        bh=6fZMAPxaQ2NtCFw/OrUJgDL+NjbElpsSBv71T4079w4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=gr1fCnULfyCNiWrIoIObRLAbjz6edhUrfK1lJTjtlQsAy6tqesCbgIa7VLtWFCyjE
         u/LoNXje++UsuPBpljvhzrdfs2AAxe3qNTyb+Qz07Ry7Vl+eOUj4uxGjkEiPhW1CZb
         qYzwkYqDOlUXdUGuHSlBNzeG8PtY7cVsbpPROoVOdFqpreHhgOMVkY4Ga1KKbW2zU8
         XeeEALATABwTaMPxlaP+6zfZaRhQ1PHqR3KdvIFMZmbyVp0o9rQcHyHySgcC1IawGG
         as7sszRMCOwPcx4WEp0M8NBf2kSn6zEN1IxecrhqFsV9rZy1I9ODnXrbWhqaz1xqiY
         FQYD678OM6s5g==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2473661358eso1656085a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 22:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682055144; x=1684647144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fZMAPxaQ2NtCFw/OrUJgDL+NjbElpsSBv71T4079w4=;
        b=FK1YCxFsu96C4MmWqj2jkhuj30Fv5ubxiPUl4gRQzkFVPrtuWEwHZHchYfa2xRW7Dt
         MQoaNgFw/XwM356ax+vGzMsw7O2COfTGjGXgb+Ia/NmB+c4MCkOa40DlDwU2Sa5GfUoy
         N/sM12h4R1DPl0Si2f6X7NSLq2nYRfYXGiarYgkhjd0ZlMeWoY8jwzBHZfxccRvWRHr8
         IyeaLlSOZHgl5MEIySQhWW38IWBbsjBnvC/+zH2nEgY6Z623uplLFDmQmMiYA1l1JOBU
         GsX1G9jZB0AbM//hkisxODGBSRO+Hv/wWbR33Di+WGwvBlfLKzG954mBkQA66eXgaj9Q
         sG6g==
X-Gm-Message-State: AAQBX9fpNw0M1Jrlez36oFkUBMGGSc00VmhI91U27eVW/mM3v7ktBEyQ
        8JaN9LprLpcZaI7+p/q/kcXnbDX3ujMdaVzu/Bbq8d4P0nCif3y8Py+oVpizaxdPJVFzsHBkktF
        GsbzKMoRVDZRP9jKs1zjl3YkpAOjiN8YVS7TFOtWT7tCNCCE92KdOqmQIwg==
X-Received: by 2002:a17:90b:3648:b0:247:35c7:bd67 with SMTP id nh8-20020a17090b364800b0024735c7bd67mr3754300pjb.46.1682055143745;
        Thu, 20 Apr 2023 22:32:23 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZW3SE5cSn/yddEPPQw5KYQiQxrGhjGAVAADd/GQ9uokNzzHmPpmqsq9Qa5iBnIp1hnHZ8RBNckOT4JFBvEcnM=
X-Received: by 2002:a17:90b:3648:b0:247:35c7:bd67 with SMTP id
 nh8-20020a17090b364800b0024735c7bd67mr3754285pjb.46.1682055143456; Thu, 20
 Apr 2023 22:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230420125941.333675-1-kai.heng.feng@canonical.com>
 <20230420125941.333675-3-kai.heng.feng@canonical.com> <f1409ba9-5370-1e0d-8b6c-e9782505937f@linux.intel.com>
In-Reply-To: <f1409ba9-5370-1e0d-8b6c-e9782505937f@linux.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 21 Apr 2023 13:32:12 +0800
Message-ID: <CAAd53p4chNHrHA8RhSjQYH4znVXHZHJ4m4JrzFiOsun_JsegXA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] PCI/AER: Disable AER interrupt on suspend
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 10:53=E2=80=AFPM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 4/20/23 5:59 AM, Kai-Heng Feng wrote:
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
> In Patch #1, you skip clearing AER errors in the resume path, right? So i=
f we disable
> interrupts here, will AER driver not be notified on resume path error?

I agree the driver should report the error via aer_isr_one_error() on
resume path.
But on the system I am using (Intel ADL PCH), once the interrupt is
disabled, PCI_ERR_ROOT_STATUS doesn't record error anymore.
Not sure if it's intended though.

Kai-Heng

>
> > v3:
> >  - No change.
> >
> > v2:
> >  - Only disable AER IRQ.
> >  - No more check on PME IRQ#.
> >  - Use helper.
> >
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
