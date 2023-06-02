Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF9571FC07
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbjFBI1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbjFBI1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:27:05 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A56C10DB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:26:24 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2af2d092d7aso25604491fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 01:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685694382; x=1688286382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SH+XgwSwmVykCt6k705IeR4vpGlDvItlRo4YBIrE2zM=;
        b=aqiWVm4c8Hn8cSRfsEJ/hmI3VoIAlmpI9kl1DqSIqgEaURRaI7eKgth0koicQfVIfe
         bCG9Lwed6N8mrzvAYua8KP2qCKJjzh164f0siWfvkIYThmwyY0BCLWiqqoq39w88sgua
         VgPuHyr6sRb5mH03MbTPb4NFu2bPSfIPF4KLIkqCnNBfZRpNcbJUxkoRCuDIWl69UukN
         QCk29QYHTBnJDtsxX/4Fp1eFcrLQJz5FYcSWvyO3VHWzErfyb9dro5NyUHyJyYj8u/ly
         CYXn2i6mVLKymc8LiCFVhNufS4gmv927LZgCF0HxxJETkeEi31GEJGQXCAKOiZAQf1ab
         /dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685694382; x=1688286382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SH+XgwSwmVykCt6k705IeR4vpGlDvItlRo4YBIrE2zM=;
        b=M7UX9/AIsrxkbYIsOuwUEwVYaQIlx+rdnX0is2jTmx5u+nh0d9OuOSSSbLKoGGC21B
         Q93eWpveMCVtny9Sg6BpXk1SySwFu21fDvrdFJoPAZQnLUmDmocH0TosJQoRRHd4PCZy
         MSsTnbelvle9qZO2hwQq+Kf1WUwICjdCz+W1A8gZUtGgpMys5XMI5zK3KOA323a6WJPv
         nGu7ABojcQ2LPx1ewxRZbQzQg68gyCeRReER5d8yGx2oY2BlzoQjE76htwt649TTxRej
         MV4Ye2jXD/T/8DCX2/ZM4F7M0Lm1dqKGgYlZuWj2CV0YprIzhmPFW7VzaMvk1RwWdEFt
         85IA==
X-Gm-Message-State: AC+VfDxiOYLNEQN9WpGbk2LhNLmVyDkH7K9JvcY8nhF0NJfrQ3+vmpX6
        DgUArdjExm3qEgxGqXt8l1khEWenCRNKqTL6NakADw==
X-Google-Smtp-Source: ACHHUZ4iDMKF9FrTWDJm5SWHKTXyozoTseWA3wZDneLvRJLbLpNAwsdhUZz9tXQvVuNWeiqCEhZWofU8BPErRbMrnZM=
X-Received: by 2002:a2e:9a8e:0:b0:2b1:b040:b5ff with SMTP id
 p14-20020a2e9a8e000000b002b1b040b5ffmr465605lji.4.1685694382379; Fri, 02 Jun
 2023 01:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220405093759.1126835-1-alex.bennee@linaro.org>
 <20230531191007.13460-1-shyamsaini@linux.microsoft.com> <SN7PR11MB6850DA4A185E3429B62531CD84499@SN7PR11MB6850.namprd11.prod.outlook.com>
 <CAC_iWjKAdimEH0SsC_z9QuFS4sGLp2BVzx03s+RKvcLXY25kuQ@mail.gmail.com> <CAFA6WYPKeJYTzvnZkoL_dw6uXSkhAh6uxoEOWHYU7oLNRDRWaA@mail.gmail.com>
In-Reply-To: <CAFA6WYPKeJYTzvnZkoL_dw6uXSkhAh6uxoEOWHYU7oLNRDRWaA@mail.gmail.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Fri, 2 Jun 2023 11:25:46 +0300
Message-ID: <CAC_iWjLOhUvp5ggCCkHN5MRNfB_h6FZ2Z14yrtR3aqGn0Ovxig@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     "Zhu, Bing" <bing.zhu@intel.com>,
        Shyam Saini <shyamsaini@linux.microsoft.com>,
        "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
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
        "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2023 at 08:49, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Thu, 1 Jun 2023 at 11:02, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Bing
> >
> > On Thu, 1 Jun 2023 at 04:03, Zhu, Bing <bing.zhu@intel.com> wrote:
> > >
> > > As an alternative, Is it possible to change ftpm design not to depend=
 on RPMB access at the earlier/boot stage? Because to my understanding, typ=
ically PCRs don't require persistent/NV storage (for example, before RPMB o=
r tee-supplicant is ready, use TEE memory instead as temporary storage)
> >
> > I am not entirely sure this will solve our problem here.  You are
> > right that we shouldn't depend on the supplicant to extend PCRs. But
> > what happens if an object is sealed against certain PCR values?  We
> > are back to the same problem
>
> +1
>
> Temporary storage may be a stop gap solution for some use-cases but
> having a fast path access to RPMB via kernel should be our final goal.
> I would suggest we start small with the MMC subsystem to expose RPMB
> access APIs for OP-TEE driver rather than a complete RPMB subsystem.

I discussed with the OP-TEE maintainers about adding parts of the
supplicant in the kernel.  The supplicant 'just' sends an ioctl to
store/read stuff anyway.  So it would make sense to have a closer and
see if that looks reasonable.
Thanks

/Ilias

>
> -Sumit
>
> >
> > Thanks
> > /Ilias
> > >
> > > Bing
> > >
> > > IPAS Security Brown Belt (https://www.credly.com/badges/69ea809f-3a96=
-4bc7-bb2f-442c1b17af26)
> > > System Software Engineering
> > > Software and Advanced Technology Group
> > > Zizhu Science Park, Shanghai, China
> > >
> > > -----Original Message-----
> > > From: Shyam Saini <shyamsaini@linux.microsoft.com>
> > > Sent: Thursday, June 1, 2023 3:10 AM
> > > To: alex.bennee@linaro.org
> > > Cc: code@tyhicks.com; Matti.Moell@opensynergy.com; arnd@linaro.org; Z=
hu, Bing <bing.zhu@intel.com>; hmo@opensynergy.com; ilias.apalodimas@linaro=
.org; joakim.bech@linaro.org; linux-kernel@vger.kernel.org; linux-mmc@vger.=
kernel.org; linux-scsi@vger.kernel.org; maxim.uvarov@linaro.org; ruchika.gu=
pta@linaro.org; Winkler, Tomas <tomas.winkler@intel.com>; ulf.hansson@linar=
o.org; Huang, Yang <yang.huang@intel.com>; sumit.garg@linaro.org; jens.wikl=
ander@linaro.org; op-tee@lists.trustedfirmware.org
> > > Subject: [PATCH v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
> > >
> > > Hi Alex,
> > >
> > > [ Resending, Sorry for the noise ]
> > >
> > > Are you still working on it or planning to resubmit it ?
> > >
> > > [1] The current optee tee kernel driver implementation doesn't work w=
hen IMA is used with optee implemented ftpm.
> > >
> > > The ftpm has dependency on tee-supplicant which comes once the user s=
pace is up and running and IMA attestation happens at boot time and it requ=
ires to extend ftpm PCRs.
> > >
> > > But IMA can't use PCRs if ftpm use secure emmc RPMB partition. As opt=
ee can only access RPMB via tee-supplicant(user space). So, there should be=
 a fast path to allow optee os to access the RPMB parititon without waiting=
 for user-space tee supplicant.
> > >
> > > To achieve this fast path linux optee driver and mmc driver needs som=
e work and finally it will need RPMB driver which you posted.
> > >
> > > Please let me know what's your plan on this.
> > >
> > > [1] https://optee.readthedocs.io/en/latest/architecture/secure_storag=
e.html
> > >
> > > Best Regards,
> > > Shyam
