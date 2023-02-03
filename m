Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C34C689757
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjBCKzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjBCKzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:55:51 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A16721C3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 02:55:47 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qw12so14288707ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 02:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YmibrdxDPfCEOU6aOpV1eMaFV8W8aFr81jZYLchROrI=;
        b=V2o8ktlS4zWjCl9KTmtnbP6nPlEWVCgZN//JZ6NmvYVNqrqabMBMtk4kXii6J8GkbC
         sgpv/JfrqVIAe3z0wUoXwyUA5AYFy6EZ3Yi1o16ZEIjnq5ilQwOYRbcPLK3ibeBd2Bql
         sGtKxybdEmgc2nQSXt0xrFQKzdAlC2p6nBnAygYxa47ACENSFG+jn/n1KtozPsDUIKS3
         HNNrGl13ClTEh7vgjY43u7Wg1/D07gZ8Esin5WVP1Uv6+Iu4eggVAVw/Z+yl6JAqYPWr
         hyHumbfIG7Rt1ib1t9zgUGMuQpeaIPyL5eBjxjVOapnGY9R3as2k7VKezfngWCUAG1qZ
         Ye6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmibrdxDPfCEOU6aOpV1eMaFV8W8aFr81jZYLchROrI=;
        b=yZQfVp5EkwBJ9ldOy5c8r7apLzc2qDh3fJb/bR4ZBnauK4qsoOJM/lIk10GgUTx0Vz
         sdcj1fW9g6+f+mATJUfKdGLGmitnY2/B37bq/A4odWbSSqlEcGi1dccRRmX2G7vi2JK5
         WBFd3vwsYuL4mnvMsp4tIfX4NkYL6KkApomqG0tMKCA/Frp9zvdgNBCocohyZ0dyNNJs
         XRDTYEMjQV6ePGyxQDAjCvxAIOsN2Hwa1TWYkLABtsjI0Kdo27Vh5yVvYwfULEatNK6z
         kiUcZlC7IuJp8XsiqHiqx1t3nBVcQrorovr0eG6ZZHufc7kPiM8ErL+sEU/HTt847Ska
         Qn8w==
X-Gm-Message-State: AO0yUKXIG+kG4D1KbKNi0DYLOPpQCGBc8Riz+B2UVRkdMZVm+7KFA/N8
        ApuViNRwe/CvaI9ennq1R5VS1KErfv2A6HEkyFc=
X-Google-Smtp-Source: AK7set8A4Hae6BBTgIv7+l3TFUxGcTPpizgLMSCfTeQGZV4nFC/aluUY32ibtKJPOUazjVwbvJ0JbQ==
X-Received: by 2002:a17:907:7094:b0:88a:72bf:9670 with SMTP id yj20-20020a170907709400b0088a72bf9670mr9778551ejb.50.1675421746445;
        Fri, 03 Feb 2023 02:55:46 -0800 (PST)
Received: from jade (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id s7-20020a1709060c0700b0088f88d1d364sm1181014ejf.163.2023.02.03.02.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 02:55:46 -0800 (PST)
Date:   Fri, 3 Feb 2023 11:55:44 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [RFC PATCH 0/2] introduce op-tee based EFI Runtime Variable
 Service
Message-ID: <Y9zoMJcbrKIvbDdh@jade>
References: <20230126132120.1661-1-masahisa.kojima@linaro.org>
 <CAFA6WYMdTxkcFkSux7F3fwxx2OqHP9UzqbWxdGnxuzjNU75PxA@mail.gmail.com>
 <Y9zFzW2yj7uMI0XR@jade>
 <CAFA6WYOp-NQxvqOmemiW2D5Au549f-u4LJA7XEK2aJgMiXRUYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFA6WYOp-NQxvqOmemiW2D5Au549f-u4LJA7XEK2aJgMiXRUYg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 03:03:34PM +0530, Sumit Garg wrote:
> Hi Jens,
> 
> On Fri, 3 Feb 2023 at 13:59, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Hi Sumit,
> >
> > On Thu, Feb 02, 2023 at 05:35:49PM +0530, Sumit Garg wrote:
> > > Hi Masahisa,
> > >
> > > On Thu, 26 Jan 2023 at 18:52, Masahisa Kojima
> > > <masahisa.kojima@linaro.org> wrote:
> > > >
> > > > This RFC series introduces the op-tee based EFI Runtime Variable
> > > > Service.
> > > >
> > > > The eMMC device is typically owned by the non-secure world(linux in
> > > > this case). There is an existing solution utilizing eMMC RPMB partition
> > > > for EFI Variables, it is implemented by interacting with
> > > > OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> > > > and tee-supplicant. The last piece is the tee-based variable access
> > > > driver to interact with OP-TEE and StandaloneMM.
> > > >
> > >
> > > After an overall look at the APIs, following are some initial comments:
> > > - Is there any reason to have the edk2 specific StandaloneMM stack in
> > > Linux to communicate with OP-TEE pseudo TA?
> > > - I think the OP-TEE pseudo TA should be able to expose a rather
> > > generic invoke commands such as:
> > >      TEE_EFI_GET_VARIABLE
> > >      TEE_EFI_GET_NEXT_VARIABLE
> > >      TEE_EFI_SET_VARIABLE
> > >   So it should no longer be tied to StMM stack and other TEE
> > > implementations can re-use the abstracted interface to communicate
> > > with its corresponding secure storage TA.
> >
> > In the current setup we have the following layers in the kernel:
> > 1. efivar_operations
> > 2. MM
> > 3. PTA_STMM
> > 4. OP-TEE MSG
> >
> > and in the secure world:
> > S1. internal to StMM
> > S2. MM interface to StMM
> > S3. PTA_STMM
> > S4. OP-TEE MSG
> >
> > If I understand you correctly you'd like to see this instead:
> > Kernel:
> > 1. efivar_operations
> > 2. PTA_EFIVAR
> > 4. OP-TEE MSG
> >
> > Since we still have the MM interface with StMM we'd have this in the secure
> > world:
> > S1. internal to StMM
> > S2. MM interface to StMM
> > S3. PTA_EFIVAR
> > S4. OP-TEE MSG
> >
> > At S3 we'd have to convert between EFIVAR and MM messages. The
> > difference is that we're moving the EFIVAR <-> MM conversion from the
> > non-secure world into the secure world. We're still using OP-TEE
> > specific communication at the fourth layer. So we're only moving problem
> > around, I'd rather avoid growing the OP-TEE part in the secure world.
> >
> 
> If you look carefully, we are essentially defining an ABI towards the
> secure world. The approach in this patch-set adds the MM interface as
> a redundant ABI layer which makes it complex to maintain. Now think
> about if every TEE implementation would propose such a complex ABI. It
> looks like a maintenance nightmare to me.
> 
> The concerns you are highlighting about OP-TEE size, I think those are
> implementation details which can be simplified later but once you have
> defined an ABI then you are stuck with its maintainability.

You have a point, but keep in mind that it's StMM that matters here.
StMM uses the MM protocol. It was originially using raw SMCs as a
conduit, but with the need for OP-TEE accessing RPMB that's not usable.
So instead we use OP-TEE MSG as a conduit. Seen from that perspective
we're only resuing something established instead of inventing something
new.

Cheers,
Jens

> 
> -Sumit
> 
> > Cheers,
> > Jens
> >
> > >
> > > -Sumit
> > >
> > > > Masahisa Kojima (2):
> > > >   efi: expose efivar generic ops register function
> > > >   tee: Add op-tee helper functions for variable access
> > > >
> > > >  drivers/firmware/efi/efi.c           |  12 +
> > > >  drivers/tee/optee/Kconfig            |  10 +
> > > >  drivers/tee/optee/Makefile           |   1 +
> > > >  drivers/tee/optee/mm_communication.h | 249 +++++++++++
> > > >  drivers/tee/optee/optee_private.h    |   5 +-
> > > >  drivers/tee/optee/optee_stmm_efi.c   | 598 +++++++++++++++++++++++++++
> > > >  drivers/tee/tee_core.c               |  23 ++
> > > >  include/linux/efi.h                  |   4 +
> > > >  include/linux/tee_drv.h              |  23 ++
> > > >  9 files changed, 924 insertions(+), 1 deletion(-)
> > > >  create mode 100644 drivers/tee/optee/mm_communication.h
> > > >  create mode 100644 drivers/tee/optee/optee_stmm_efi.c
> > > >
> > > > --
> > > > 2.30.2
> > > >
