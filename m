Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9944E687E7C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjBBNUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjBBNTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:19:48 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3316EDE6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 05:19:46 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ml19so6024113ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 05:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oP4tU/oimimjTyBMTUPR2167cMA++UPu/sF+5GZ/iYU=;
        b=w5W7+EGNKC1WsOeqxK2FaFPVN+HS+hLSidkTSu2fLVmi884o0RmOn084kLjJb0crwv
         PpMd8cJVGourBUiyFE7Pghy/9sL7DizmkQaxINonXgrY/slvIRX0Y9NdWFD3ugw6RC8B
         eyDvbNneKxv0Z9wP2GSwJrH3SDBGGK/9RlNZVN28cnqNPG5/AqEQBx/IzWobKylcSuGq
         1SnJLHv7KXskHei73tqp0vLhtgBTItaI1Eo/utUDX0oqK3DOD8Ocq9bpsWfV4MfcPg2k
         j9OYoXItOc+ux1NPGyHOIspM4QZHsU6sClYGamY/FeMmDWlsDl2hkSODgOC97VsgoY9b
         rBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP4tU/oimimjTyBMTUPR2167cMA++UPu/sF+5GZ/iYU=;
        b=4UypW3Y7EXOe7JOYhkU7yXTrxmOtnnsvTzpZ4qH9SAul9PiffhGE53d22YxHF6gh1Q
         rUNtj2JdYb2fUbIix4yluQuZggD3eFPH+17Dc4wvKk58vzmaYa+bTs8cWhkTiK73rGT5
         edeI2AB1taMjhiSesIVuZSVwzdawJpZBT+otC8qYuc/CmXDsNilXdjf00036XFFNjgnO
         Sy5Js9iCINlKsExSk2ffpB1TpyQ86mVB8TB7XvpkdlYkKc/wur023fZD2Oy6/Q8AOSSR
         W99s2H78U59esS8IwT3NgRuOoxJc4RP9givtgnkVoWJ6DKP+CgE/PUtJmtVEx965ivQ0
         jQGg==
X-Gm-Message-State: AO0yUKXihoIbcyKaHD8OBzU3395xmnAjA/rgA/5xtl0DuupJ027+vq1V
        pEhiJ1ynxUcorVF3DMFnVR91kwgZpjbE+ycN
X-Google-Smtp-Source: AK7set9NlrBjmMcjX9FTNz5ys27QzUuwd/udKLpjtrRtNX0h42mrWHrDtN36/J9Y7+IMRs37cNhvuQ==
X-Received: by 2002:a17:906:199b:b0:87d:dd22:a93 with SMTP id g27-20020a170906199b00b0087ddd220a93mr6620194ejd.54.1675343985307;
        Thu, 02 Feb 2023 05:19:45 -0800 (PST)
Received: from hera (ppp079167090036.access.hol.gr. [79.167.90.36])
        by smtp.gmail.com with ESMTPSA id j4-20020a170906474400b00856ad9108e7sm11641896ejs.70.2023.02.02.05.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 05:19:44 -0800 (PST)
Date:   Thu, 2 Feb 2023 15:19:42 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [RFC PATCH 0/2] introduce op-tee based EFI Runtime Variable
 Service
Message-ID: <Y9u4bih4jZlg3Kb6@hera>
References: <20230126132120.1661-1-masahisa.kojima@linaro.org>
 <CAFA6WYMdTxkcFkSux7F3fwxx2OqHP9UzqbWxdGnxuzjNU75PxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

The problem is StMM is not a pseudo-TA and pretending to be one
is not easy.  It looks like one, but due to the internal ABI, it's compiled
and launched differently within OP-TEE.  We could still add this but...

> - I think the OP-TEE pseudo TA should be able to expose a rather
> generic invoke commands such as:
>      TEE_EFI_GET_VARIABLE
>      TEE_EFI_GET_NEXT_VARIABLE
>      TEE_EFI_SET_VARIABLE
>   So it should no longer be tied to StMM stack and other TEE
> implementations can re-use the abstracted interface to communicate
> with its corresponding secure storage TA.

I talked about this with Jens, but there's an assumption here that every
TEE from that point onward will implement this.  But without a standard
describing this, I don't see how we can convince others.  The current code
puts the responsibility back to the tee/core subsystem, so any vendor can
provide his own callbacks

Regards
/Ilias
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
