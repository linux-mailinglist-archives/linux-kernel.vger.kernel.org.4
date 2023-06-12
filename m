Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9BD72CC0A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjFLRHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjFLRHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:07:01 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E7110C9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:06:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f7e7fc9fe6so45933485e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686589616; x=1689181616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZ/IrEjFcCV2x/CivdwBWaEryH9Wc7q/asiFBrPanUc=;
        b=pdd96pl8DNCim3cK0vMZGWh18h572HgJCXrkFdWt47XV6bDajZB8GjYgHMFtouiwja
         gsjhT1WKucS/dsrwPMLnv4yPJDf8uIdgHCSSfnY90fafkGvFhdOM8T6wLeGl1bli/UB6
         HyrplWjoYLAfnzNCJRitiRQRxllL/aeLhXkAuyEfthBfO2xVnlS8umjMZqCpq9As6dYK
         wIIxPlOeFmNnc2z37nfX00WvtrwEEaTJwMg432e8f9QZ8p8qkmuQR/+joF/cxkipwIwQ
         FF57GYv1kDM4xxNPUUp2q3fOsFqH2eYZ2Wu4foCZmOwGWjGeN3Qw55saAkl+Eldzltxp
         6QNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686589616; x=1689181616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZ/IrEjFcCV2x/CivdwBWaEryH9Wc7q/asiFBrPanUc=;
        b=LxmDFSUH2lTTrRrp5aXThIMbqHpSic1Q6BEI6UJlKDyls17+lyD/HHG9vUYzNzr0ig
         llAEKAiiJrYPdUd3Vq/LUR4gOTeMqgA1wX3TN+DLNOGieww9Ll1phAY/nhF/OV5N1JHl
         1e9iBf+723wdGy+nWLrRmeZfCza9RZryX85Z6Gk0iUGgmpLS8snP1UVGe9XL8wCd9pMX
         agTE9pU9JW49PHbHDw2JCJNJG4U8hZLE81KxYAfpU9jq3FCYS7F8yD5919ITLeh9IoCT
         bW3gDRxb4KfnN/XGs1JHhTP3VjAebTbh+kjN4nuXzrcikd6hFjiOLjSznqjv99Ix4n1p
         d4Mg==
X-Gm-Message-State: AC+VfDyK4yMbItjvbkw3esxrff/sqhNdB49aecpECYlKPuivDZjLNrwr
        P96WUaf8bSxY9QMo2X7WAO3yD+/R5cPSTEA0RhtZvw==
X-Google-Smtp-Source: ACHHUZ4Oo+5RtePTqbz4//Obk2Tzr5QhfB4BXojrvhaU0n42oTkH3RDF/7ND8Bi5A+eFFTdIdZzuw980EwBm84enBe0=
X-Received: by 2002:a7b:c8c4:0:b0:3f6:6da:3ad1 with SMTP id
 f4-20020a7bc8c4000000b003f606da3ad1mr7776351wml.34.1686589615908; Mon, 12 Jun
 2023 10:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220405093759.1126835-1-alex.bennee@linaro.org>
 <20230531191007.13460-1-shyamsaini@linux.microsoft.com> <SN7PR11MB6850DA4A185E3429B62531CD84499@SN7PR11MB6850.namprd11.prod.outlook.com>
 <CAC_iWjKAdimEH0SsC_z9QuFS4sGLp2BVzx03s+RKvcLXY25kuQ@mail.gmail.com>
 <CAFA6WYPKeJYTzvnZkoL_dw6uXSkhAh6uxoEOWHYU7oLNRDRWaA@mail.gmail.com> <CAC_iWjLOhUvp5ggCCkHN5MRNfB_h6FZ2Z14yrtR3aqGn0Ovxig@mail.gmail.com>
In-Reply-To: <CAC_iWjLOhUvp5ggCCkHN5MRNfB_h6FZ2Z14yrtR3aqGn0Ovxig@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 12 Jun 2023 19:06:45 +0200
Message-ID: <CAHUa44F4CRM7zr8EevejPcCiGOjNgg7AtPy20L4h5S68SL9-_g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
To:     "alex.bennee@linaro.org" <alex.bennee@linaro.org>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        "Zhu, Bing" <bing.zhu@intel.com>,
        Shyam Saini <shyamsaini@linux.microsoft.com>,
        "code@tyhicks.com" <code@tyhicks.com>,
        "Matti.Moell@opensynergy.com" <Matti.Moell@opensynergy.com>,
        "arnd@linaro.org" <arnd@linaro.org>,
        "hmo@opensynergy.com" <hmo@opensynergy.com>,
        "joakim.bech@linaro.org" <joakim.bech@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "maxim.uvarov@linaro.org" <maxim.uvarov@linaro.org>,
        "ruchika.gupta@linaro.org" <ruchika.gupta@linaro.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "Huang, Yang" <yang.huang@intel.com>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Fri, Jun 2, 2023 at 10:26=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 1 Jun 2023 at 08:49, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > On Thu, 1 Jun 2023 at 11:02, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Bing
> > >
> > > On Thu, 1 Jun 2023 at 04:03, Zhu, Bing <bing.zhu@intel.com> wrote:
> > > >
> > > > As an alternative, Is it possible to change ftpm design not to depe=
nd on RPMB access at the earlier/boot stage? Because to my understanding, t=
ypically PCRs don't require persistent/NV storage (for example, before RPMB=
 or tee-supplicant is ready, use TEE memory instead as temporary storage)
> > >
> > > I am not entirely sure this will solve our problem here.  You are
> > > right that we shouldn't depend on the supplicant to extend PCRs. But
> > > what happens if an object is sealed against certain PCR values?  We
> > > are back to the same problem
> >
> > +1
> >
> > Temporary storage may be a stop gap solution for some use-cases but
> > having a fast path access to RPMB via kernel should be our final goal.
> > I would suggest we start small with the MMC subsystem to expose RPMB
> > access APIs for OP-TEE driver rather than a complete RPMB subsystem.
>
> I discussed with the OP-TEE maintainers about adding parts of the
> supplicant in the kernel.  The supplicant 'just' sends an ioctl to
> store/read stuff anyway.  So it would make sense to have a closer and
> see if that looks reasonable.
> Thanks

I was trying to create a setup to test this. I've added the kernel
patches on top of https://github.com/linaro-swg/linux/tree/optee. The
QEMU branch is a bit dated and I had to add
3a845a214b42 target/arm: allow setting SCR_EL3.EnTP2 when FEAT_SME is
implemented
d4a7b0ef1a03 hw/arm/boot: set CPTR_EL3.ESM and SCR_EL3.EnTP2 when
booting Linux with EL3
9745a003f878 hw/intc/arm_gicv3: fix prio masking on pmr write
beeec926d24a target/arm: mark SP_EL1 with ARM_CP_EL3_NO_EL2_KEEP
on top of that branch to be able to boot to the Linux kernel.

I have the vhost-user-rpmb process running and connected with QEMU,
but around (guessing really) when the RPMB subsystem is initializing
the process dies with:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Request: VHOST_USER_SET_VRING_ADDR (9)
Flags:   0x1
Size:    40
vhost-user-rpmb-INFO: 18:58:08.312: vrpmb_process_msg: msg
VHOST_USER_SET_VRING_ADDR(9)
vhost_vring_addr:
    index:  0
    flags:  0
    desc_user_addr:   0x00007ff15fa91000
    used_user_addr:   0x00007ff15fa91080
    avail_user_addr:  0x00007ff15fa91040
    log_guest_addr:   0x0000000041c91080
Setting virtq addresses:
    vring_desc  at (nil)
    vring_used  at (nil)
    vring_avail at (nil)

(vhost-user-rpmb:3236474): vhost-user-rpmb-CRITICAL **: 18:58:08.312:
Invalid vring_addr message

Among other options, I'm starting QEMU with -machine
virt,secure=3Don,mte=3Doff,gic-version=3D3,virtualization=3Dfalse to enable
the secure world.

Do you have an idea of what might be wrong? Where should I start looking?

Thanks,
Jens

>
> /Ilias
>
> >
> > -Sumit
> >
> > >
> > > Thanks
> > > /Ilias
> > > >
> > > > Bing
> > > >
> > > > IPAS Security Brown Belt (https://www.credly.com/badges/69ea809f-3a=
96-4bc7-bb2f-442c1b17af26)
> > > > System Software Engineering
> > > > Software and Advanced Technology Group
> > > > Zizhu Science Park, Shanghai, China
> > > >
> > > > -----Original Message-----
> > > > From: Shyam Saini <shyamsaini@linux.microsoft.com>
> > > > Sent: Thursday, June 1, 2023 3:10 AM
> > > > To: alex.bennee@linaro.org
> > > > Cc: code@tyhicks.com; Matti.Moell@opensynergy.com; arnd@linaro.org;=
 Zhu, Bing <bing.zhu@intel.com>; hmo@opensynergy.com; ilias.apalodimas@lina=
ro.org; joakim.bech@linaro.org; linux-kernel@vger.kernel.org; linux-mmc@vge=
r.kernel.org; linux-scsi@vger.kernel.org; maxim.uvarov@linaro.org; ruchika.=
gupta@linaro.org; Winkler, Tomas <tomas.winkler@intel.com>; ulf.hansson@lin=
aro.org; Huang, Yang <yang.huang@intel.com>; sumit.garg@linaro.org; jens.wi=
klander@linaro.org; op-tee@lists.trustedfirmware.org
> > > > Subject: [PATCH v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
> > > >
> > > > Hi Alex,
> > > >
> > > > [ Resending, Sorry for the noise ]
> > > >
> > > > Are you still working on it or planning to resubmit it ?
> > > >
> > > > [1] The current optee tee kernel driver implementation doesn't work=
 when IMA is used with optee implemented ftpm.
> > > >
> > > > The ftpm has dependency on tee-supplicant which comes once the user=
 space is up and running and IMA attestation happens at boot time and it re=
quires to extend ftpm PCRs.
> > > >
> > > > But IMA can't use PCRs if ftpm use secure emmc RPMB partition. As o=
ptee can only access RPMB via tee-supplicant(user space). So, there should =
be a fast path to allow optee os to access the RPMB parititon without waiti=
ng for user-space tee supplicant.
> > > >
> > > > To achieve this fast path linux optee driver and mmc driver needs s=
ome work and finally it will need RPMB driver which you posted.
> > > >
> > > > Please let me know what's your plan on this.
> > > >
> > > > [1] https://optee.readthedocs.io/en/latest/architecture/secure_stor=
age.html
> > > >
> > > > Best Regards,
> > > > Shyam
