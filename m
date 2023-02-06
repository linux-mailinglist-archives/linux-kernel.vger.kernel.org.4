Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF5468B6A0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 08:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjBFHsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 02:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjBFHsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 02:48:07 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9EB10268
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 23:48:05 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id o18so9490887wrj.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 23:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QV/i54z1LX+3FCUVLkH4lFJ0fZu85Y/K1Mf25JbTbNU=;
        b=POdXTM9eBbT1PfSBuZ87yAQ6fVZy3x+QyqkDoULMI1ayUWA0tSFtLleT2Zkm2oMSkt
         1fMLaYrakk0uE6DTar33LMqMQKcOXzx/YTVB4rvZiVYc+V0tvsR0LGKttpUf2CiwoOaG
         TY/b64whVXBRr3a8vu/UZNTSU7byUNddc3eNRreVBqBTVI0a8+Fgdzps+tTIahZxXvUy
         RinisiCYaC1l+VdO2Dxp9DVFd4hzrgTxvA40S0FouQDfaYVsn9OpZJdF+c9ON5wlzypc
         uS8Cs0S0C+THo6bEuwiukKifsChQZ+ZWLozKXxo190zTPupVuidIYIrh7I3HZm2o2jxH
         9a2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QV/i54z1LX+3FCUVLkH4lFJ0fZu85Y/K1Mf25JbTbNU=;
        b=4T80J43oitzBpghTGeWO0Hu543LFuU2wQBSrz2NVOsGm8v3DVuNbxwFsu4R57CnBkQ
         10Gg9Co0lco3kcuJvItdkXl9cMKxA/OPja4M6w+PyIFEq4wy0cNmVp4gtmAicMOFFaF9
         igXDG5Xso51VUTqlSEdhsNiU42YVTJv/+gSIulDVtFbubgzRyoTgQzuqqb1Ado8sFSzT
         0bbe8BFzI91eqValt2S3ehs1SNtGiBzidrbE1HXj0k9sFVI8tvmAKK6oszynYo84PNND
         3wcPiQYuh8ghpdTI0CEavj8UVRV/a0mCDWJ1RYFN1TwCtpxkYTTp5Slp50PXNPoGn8zS
         uYOg==
X-Gm-Message-State: AO0yUKWyfn4mfHJm0nzXTALknxOLIN6Xf1/8i7sn0U4otkZJPFTvx4Hj
        EYE+7wYD361DRvlCp+FPC/jWeeObvnsHY/SI/AZK9Q==
X-Google-Smtp-Source: AK7set/EyQI2ODO0d8ncCHkctE71XtMBZh0cTYrEuzVz4OUR+5qaHYy13/tPQJaOrdmaub4crbZjT+O7xNgAlj9uyXM=
X-Received: by 2002:a5d:43c2:0:b0:2c3:e6b3:950c with SMTP id
 v2-20020a5d43c2000000b002c3e6b3950cmr116140wrr.280.1675669684156; Sun, 05 Feb
 2023 23:48:04 -0800 (PST)
MIME-Version: 1.0
References: <20230126132120.1661-1-masahisa.kojima@linaro.org>
 <CAFA6WYMdTxkcFkSux7F3fwxx2OqHP9UzqbWxdGnxuzjNU75PxA@mail.gmail.com>
 <Y9zFzW2yj7uMI0XR@jade> <CAFA6WYOp-NQxvqOmemiW2D5Au549f-u4LJA7XEK2aJgMiXRUYg@mail.gmail.com>
 <Y9zoMJcbrKIvbDdh@jade> <CAFA6WYPLeN5tUY8JA=J9T3XVNfq5jAQ62i=qSk-6eesM-9_K=Q@mail.gmail.com>
In-Reply-To: <CAFA6WYPLeN5tUY8JA=J9T3XVNfq5jAQ62i=qSk-6eesM-9_K=Q@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 6 Feb 2023 08:47:52 +0100
Message-ID: <CAHUa44ForNvjpAhMrVyTX-KzEyQoLHcuyU71tLaJGeiXi9i=Ug@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] introduce op-tee based EFI Runtime Variable Service
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 7:44 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Fri, 3 Feb 2023 at 16:25, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > On Fri, Feb 03, 2023 at 03:03:34PM +0530, Sumit Garg wrote:
> > > Hi Jens,
> > >
> > > On Fri, 3 Feb 2023 at 13:59, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > > >
> > > > Hi Sumit,
> > > >
> > > > On Thu, Feb 02, 2023 at 05:35:49PM +0530, Sumit Garg wrote:
> > > > > Hi Masahisa,
> > > > >
> > > > > On Thu, 26 Jan 2023 at 18:52, Masahisa Kojima
> > > > > <masahisa.kojima@linaro.org> wrote:
> > > > > >
> > > > > > This RFC series introduces the op-tee based EFI Runtime Variable
> > > > > > Service.
> > > > > >
> > > > > > The eMMC device is typically owned by the non-secure world(linux in
> > > > > > this case). There is an existing solution utilizing eMMC RPMB partition
> > > > > > for EFI Variables, it is implemented by interacting with
> > > > > > OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> > > > > > and tee-supplicant. The last piece is the tee-based variable access
> > > > > > driver to interact with OP-TEE and StandaloneMM.
> > > > > >
> > > > >
> > > > > After an overall look at the APIs, following are some initial comments:
> > > > > - Is there any reason to have the edk2 specific StandaloneMM stack in
> > > > > Linux to communicate with OP-TEE pseudo TA?
> > > > > - I think the OP-TEE pseudo TA should be able to expose a rather
> > > > > generic invoke commands such as:
> > > > >      TEE_EFI_GET_VARIABLE
> > > > >      TEE_EFI_GET_NEXT_VARIABLE
> > > > >      TEE_EFI_SET_VARIABLE
> > > > >   So it should no longer be tied to StMM stack and other TEE
> > > > > implementations can re-use the abstracted interface to communicate
> > > > > with its corresponding secure storage TA.
> > > >
> > > > In the current setup we have the following layers in the kernel:
> > > > 1. efivar_operations
> > > > 2. MM
> > > > 3. PTA_STMM
> > > > 4. OP-TEE MSG
> > > >
> > > > and in the secure world:
> > > > S1. internal to StMM
> > > > S2. MM interface to StMM
> > > > S3. PTA_STMM
> > > > S4. OP-TEE MSG
> > > >
> > > > If I understand you correctly you'd like to see this instead:
> > > > Kernel:
> > > > 1. efivar_operations
> > > > 2. PTA_EFIVAR
> > > > 4. OP-TEE MSG
> > > >
> > > > Since we still have the MM interface with StMM we'd have this in the secure
> > > > world:
> > > > S1. internal to StMM
> > > > S2. MM interface to StMM
> > > > S3. PTA_EFIVAR
> > > > S4. OP-TEE MSG
> > > >
> > > > At S3 we'd have to convert between EFIVAR and MM messages. The
> > > > difference is that we're moving the EFIVAR <-> MM conversion from the
> > > > non-secure world into the secure world. We're still using OP-TEE
> > > > specific communication at the fourth layer. So we're only moving problem
> > > > around, I'd rather avoid growing the OP-TEE part in the secure world.
> > > >
> > >
> > > If you look carefully, we are essentially defining an ABI towards the
> > > secure world. The approach in this patch-set adds the MM interface as
> > > a redundant ABI layer which makes it complex to maintain. Now think
> > > about if every TEE implementation would propose such a complex ABI. It
> > > looks like a maintenance nightmare to me.
> > >
> > > The concerns you are highlighting about OP-TEE size, I think those are
> > > implementation details which can be simplified later but once you have
> > > defined an ABI then you are stuck with its maintainability.
> >
> > You have a point, but keep in mind that it's StMM that matters here.
> > StMM uses the MM protocol. It was originially using raw SMCs as a
> > conduit, but with the need for OP-TEE accessing RPMB that's not usable.
> > So instead we use OP-TEE MSG as a conduit. Seen from that perspective
> > we're only resuing something established instead of inventing something
> > new.
>
> Aren't we already adding PTA_STMM?

Yes, something is need to recieve those messages and forward the MM
stuff to secure user space.

>
> Isn't the StMM specific to Arm as you already mentioned it was
> designed to specifically use raw SMCs? So if in future AMD TEE wants
> to implement EFI services, can we suggest they reuse the MM interface?

I wouldn't suggest anything until I understood that problem better.

>
> I am not sure why we need to redirect EFI variables via MM interface
> communication buffers rather than directly using the TEE shared memory
> approach.

I allways assumed that was done in order to keep the changes in StMM
at a mininum compared to non-TEE configurations.

Cheers,
Jens

>
> Ard,
>
> Since you have better insights into how EFI runtime services have to
> be implemented, can you share your opinion here? It may be something I
> am missing here.
>
> -Sumit
>
> >
> > Cheers,
> > Jens
> >
> > >
> > > -Sumit
> > >
> > > > Cheers,
> > > > Jens
> > > >
> > > > >
> > > > > -Sumit
> > > > >
> > > > > > Masahisa Kojima (2):
> > > > > >   efi: expose efivar generic ops register function
> > > > > >   tee: Add op-tee helper functions for variable access
> > > > > >
> > > > > >  drivers/firmware/efi/efi.c           |  12 +
> > > > > >  drivers/tee/optee/Kconfig            |  10 +
> > > > > >  drivers/tee/optee/Makefile           |   1 +
> > > > > >  drivers/tee/optee/mm_communication.h | 249 +++++++++++
> > > > > >  drivers/tee/optee/optee_private.h    |   5 +-
> > > > > >  drivers/tee/optee/optee_stmm_efi.c   | 598 +++++++++++++++++++++++++++
> > > > > >  drivers/tee/tee_core.c               |  23 ++
> > > > > >  include/linux/efi.h                  |   4 +
> > > > > >  include/linux/tee_drv.h              |  23 ++
> > > > > >  9 files changed, 924 insertions(+), 1 deletion(-)
> > > > > >  create mode 100644 drivers/tee/optee/mm_communication.h
> > > > > >  create mode 100644 drivers/tee/optee/optee_stmm_efi.c
> > > > > >
> > > > > > --
> > > > > > 2.30.2
> > > > > >
