Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC96C689244
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjBCI3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 03:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjBCI3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:29:06 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2D72E82C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 00:29:05 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ud5so13286600ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 00:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dpL84PC61XGF4bI1Wp4i7V82ClX0FVUoqHPOZVNLf30=;
        b=mHHKr460++WYAIvEx5JU2iUaIvdk9UW65RFfKcHiFc86BODpqyH67HRAwgBt2PXSV5
         ZN9LDYktu3cp0FVv/f7qw61YCU9Xxi7jeKQiyWEV2twNstPED2916MeO0M8l6CmM2tde
         GdwwPXRXM56HKTVpwsU3VlnOq0L/JxiCiij7MiZVQBEl7LsoObFEfZNYhFLShR2PqgkQ
         ++d9WUJ7Rl+Lc5jA0b5m3jJV5Pnb2t0AA83/uEq4UyG2zH5A4If2filJQ2R6nbJr1S4p
         7QSCPK2IZvcvylot16WOH17wpR9I/41zANfBN8nn5Q4+QOllVL5udWp8fIvLYM7/MyGO
         nKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpL84PC61XGF4bI1Wp4i7V82ClX0FVUoqHPOZVNLf30=;
        b=5ojN+xLSBXDt8sBR78oWoCWTlbEE8HF2NKDgkuAxz9mu8hykg5erOsuIG3yubgALtY
         iqz85ajkbOSxee1JnHciCce/3/fqN1kN7OxTR+QEKRtOZVW6osFezqrxxU91j3JKh/le
         vCEnjgHOQUZPqwrJ5MXeGRk7dzBtKwuT0U0Dm923BZS0FH+q4NVGu0jHT2/u8+tYPV12
         cIyIlt1xVgh5WsiYECGeMytgL9jTKZqYwlx/GVMsirf/4qze/dMuP/2SbF+Nzn63A8Y2
         y/39MtMoYEWvMmCQ1FNOdSwg4NU9OhhtPeF/EEeDrugQc0ZIBfXNO8WFxwS8HNbRiggP
         PDCA==
X-Gm-Message-State: AO0yUKXexXlhPUm0bTh2OHZlhqOKgAKBysGdCC5l6ZuznbC1GkHNCcO1
        5cZr3VTu5UJ/ZNXrpMq3WHsNqA==
X-Google-Smtp-Source: AK7set96VaXe7HSA/IoJo/3YWNZuEdA5SfkAOuZGoAYBrho81HrEjwcYQIWC05c//oqcQ0RyWiJIbw==
X-Received: by 2002:a17:906:22c9:b0:878:61d8:d7c2 with SMTP id q9-20020a17090622c900b0087861d8d7c2mr9236402eja.39.1675412944139;
        Fri, 03 Feb 2023 00:29:04 -0800 (PST)
Received: from jade (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id m24-20020a170906849800b0088b24b3aff8sm1021604ejx.183.2023.02.03.00.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 00:29:03 -0800 (PST)
Date:   Fri, 3 Feb 2023 09:29:01 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [RFC PATCH 0/2] introduce op-tee based EFI Runtime Variable
 Service
Message-ID: <Y9zFzW2yj7uMI0XR@jade>
References: <20230126132120.1661-1-masahisa.kojima@linaro.org>
 <CAFA6WYMdTxkcFkSux7F3fwxx2OqHP9UzqbWxdGnxuzjNU75PxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFA6WYMdTxkcFkSux7F3fwxx2OqHP9UzqbWxdGnxuzjNU75PxA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

On Thu, Feb 02, 2023 at 05:35:49PM +0530, Sumit Garg wrote:
> Hi Masahisa,
> 
> On Thu, 26 Jan 2023 at 18:52, Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
> >
> > This RFC series introduces the op-tee based EFI Runtime Variable
> > Service.
> >
> > The eMMC device is typically owned by the non-secure world(linux in
> > this case). There is an existing solution utilizing eMMC RPMB partition
> > for EFI Variables, it is implemented by interacting with
> > OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> > and tee-supplicant. The last piece is the tee-based variable access
> > driver to interact with OP-TEE and StandaloneMM.
> >
> 
> After an overall look at the APIs, following are some initial comments:
> - Is there any reason to have the edk2 specific StandaloneMM stack in
> Linux to communicate with OP-TEE pseudo TA?
> - I think the OP-TEE pseudo TA should be able to expose a rather
> generic invoke commands such as:
>      TEE_EFI_GET_VARIABLE
>      TEE_EFI_GET_NEXT_VARIABLE
>      TEE_EFI_SET_VARIABLE
>   So it should no longer be tied to StMM stack and other TEE
> implementations can re-use the abstracted interface to communicate
> with its corresponding secure storage TA.

In the current setup we have the following layers in the kernel:
1. efivar_operations
2. MM
3. PTA_STMM
4. OP-TEE MSG

and in the secure world:
S1. internal to StMM
S2. MM interface to StMM
S3. PTA_STMM
S4. OP-TEE MSG

If I understand you correctly you'd like to see this instead:
Kernel:
1. efivar_operations
2. PTA_EFIVAR
4. OP-TEE MSG

Since we still have the MM interface with StMM we'd have this in the secure
world:
S1. internal to StMM
S2. MM interface to StMM
S3. PTA_EFIVAR
S4. OP-TEE MSG

At S3 we'd have to convert between EFIVAR and MM messages. The
difference is that we're moving the EFIVAR <-> MM conversion from the
non-secure world into the secure world. We're still using OP-TEE
specific communication at the fourth layer. So we're only moving problem
around, I'd rather avoid growing the OP-TEE part in the secure world.

Cheers,
Jens

> 
> -Sumit
> 
> > Masahisa Kojima (2):
> >   efi: expose efivar generic ops register function
> >   tee: Add op-tee helper functions for variable access
> >
> >  drivers/firmware/efi/efi.c           |  12 +
> >  drivers/tee/optee/Kconfig            |  10 +
> >  drivers/tee/optee/Makefile           |   1 +
> >  drivers/tee/optee/mm_communication.h | 249 +++++++++++
> >  drivers/tee/optee/optee_private.h    |   5 +-
> >  drivers/tee/optee/optee_stmm_efi.c   | 598 +++++++++++++++++++++++++++
> >  drivers/tee/tee_core.c               |  23 ++
> >  include/linux/efi.h                  |   4 +
> >  include/linux/tee_drv.h              |  23 ++
> >  9 files changed, 924 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/tee/optee/mm_communication.h
> >  create mode 100644 drivers/tee/optee/optee_stmm_efi.c
> >
> > --
> > 2.30.2
> >
