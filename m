Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F257C73644C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjFTHS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjFTHSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:18:52 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD9AE7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:18:51 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-5608a4eb782so488628eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1687245530; x=1689837530;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GUUYJwzB+/81t+QqwYXl7JaMezVbu3J4sAop8uSN7n0=;
        b=T0y9hsPa+jPUTVxUkXz+0ICo2jn5rn+hiUsX/dFa5RadKbF1gzcyfUYWAY4aGTpxwD
         ZBtdUA8plTc2UqbRyfn8cKPYRkFXH3QpVhToC9CYrn8Qujep8sW6frbR4txxejhcuBP1
         HPUQpOLVuzbh4UW4ud9udMhBegliJITKwJGJwiHa5G+A0RH2yKt/hvNQG0BNiOgy49AH
         XpQhCpkJdAC1agryyj1t17HiquhIDa0cYk+ew7WGs5YSSHGsl+FEkzclYtVt2fdHFtBd
         SAf749Qj11D/dGIpJyZ7vJ8xFUg91jczUVZhYdzCneeXdXp4/OnT42igbld0EVHPEw3G
         60xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687245530; x=1689837530;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GUUYJwzB+/81t+QqwYXl7JaMezVbu3J4sAop8uSN7n0=;
        b=HfdQL5grwKE0VAgEdBgflTuNzBvSJdA36WYjIISNQ8+CbEHXNhHuqzRpxRdBRHV9FV
         uLVQL+463XX1YhmplzCW4xaVWNdEd7Yt+Wf2cYfpOYTfADcMsBH5u9ZRczKFSE2On0yW
         +ENOC2hExiWpDypdlJhaNprkSCi2D6coqsBZ0Tx3MwUYZLugLFoQI4X+QHHqGRkkJMwm
         CAZIMNG/X+jn5d4ByKMqO8ypx73nWU2vlqF8EN8v/A3pJ3kDO9SbN/YdrsE59LGuttcv
         4vLJAQ7IBv24weHsT/1LThBFEOvq0cDWLCGhu0vY/mf7ufQCRuQkEE8PbnJcI8gIvp89
         /woQ==
X-Gm-Message-State: AC+VfDxSmZySXmiiuJmLc0fC5pya9/c+D8qmPab6MKwblLvQDR+BjYps
        gvVV6/VnepgCrsdg/oJBbWvGMw==
X-Google-Smtp-Source: ACHHUZ76mpc84tL5SCQDDRTPwRHiQaar30lEGbUyp8ywnhEF/JtZ8To/ByVviDLmfe4jc2+uod5cFA==
X-Received: by 2002:a05:6808:200e:b0:39a:ab69:778e with SMTP id q14-20020a056808200e00b0039aab69778emr11361190oiw.23.1687245530444;
        Tue, 20 Jun 2023 00:18:50 -0700 (PDT)
Received: from sunil-laptop ([106.51.184.72])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090a2a8a00b0025e2358f146sm7168228pjd.13.2023.06.20.00.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 00:18:50 -0700 (PDT)
Date:   Tue, 20 Jun 2023 12:48:44 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [PATCH 1/2] Documentation: riscv: Add early boot document
Message-ID: <ZJFS1K/LltE57MJ4@sunil-laptop>
References: <20230619094705.51337-1-alexghiti@rivosinc.com>
 <CAHVXubjOUeEtnFnERjT2YOG+h5=2YX7kxeEBFSStO3WZvcv36A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHVXubjOUeEtnFnERjT2YOG+h5=2YX7kxeEBFSStO3WZvcv36A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Alex,

Many thanks for writing this up!

On Mon, Jun 19, 2023 at 11:49:13AM +0200, Alexandre Ghiti wrote:
> @Sunil V L Something about ACPI is more than welcome :)
> 
> And thanks to @Björn Töpel and @Atish Kumar Patra for helping in
> writing this document!
> 
> On Mon, Jun 19, 2023 at 11:47 AM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
> >
> > This document describes the constraints and requirements of the early
> > boot process in a RISC-V kernel.
> >
> > Szigned-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  Documentation/riscv/boot-image-header.rst |   3 -
> >  Documentation/riscv/boot.rst              | 181 ++++++++++++++++++++++
> >  Documentation/riscv/index.rst             |   1 +
> >  3 files changed, 182 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/riscv/boot.rst
> >
> > diff --git a/Documentation/riscv/boot-image-header.rst b/Documentation/riscv/boot-image-header.rst
> > index d7752533865f..a4a45310c4c4 100644
> > --- a/Documentation/riscv/boot-image-header.rst
> > +++ b/Documentation/riscv/boot-image-header.rst
> > @@ -7,9 +7,6 @@ Boot image header in RISC-V Linux
> >
> >  This document only describes the boot image header details for RISC-V Linux.
> >
> > -TODO:
> > -  Write a complete booting guide.
> > -
> >  The following 64-byte header is present in decompressed Linux kernel image::
> >
> >         u32 code0;                /* Executable code */
> > diff --git a/Documentation/riscv/boot.rst b/Documentation/riscv/boot.rst
> > new file mode 100644
> > index 000000000000..b02230818b79
> > --- /dev/null
> > +++ b/Documentation/riscv/boot.rst
> > @@ -0,0 +1,181 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=============================================
> > +Early boot requirements/constraints on RISC-V
> > +=============================================
> > +
> > +:Author: Alexandre Ghiti <alexghiti@rivosinc.com>
> > +:Date: 23 May 2023
> > +
> > +This document describes what the RISC-V kernel expects from the previous stages
> > +and the firmware, but also the constraints that any developer must have in mind
> > +when touching the early boot process, e.g. before the final virtual mapping is
> > +setup.
> > +
> > +Pre-kernel boot (Expectations from firmware)
> > +============================================
> > +
> > +Registers state
> > +---------------
> > +
> > +The RISC-V kernel expects:
> > +
> > +  * `$a0` to contain the hartid of the current core.
> > +  * `$a1` to contain the address of the device tree in memory.
> > +
> > +CSR state
> > +---------
> > +
> > +The RISC-V kernel expects:
> > +
> > +  * `$satp = 0`: the MMU must be disabled.
> > +
> > +Reserved memory for resident firmware
> > +-------------------------------------
> > +
> > +The RISC-V kernel expects the firmware to mark any resident memory with the
> > +`no-map` flag, thus the kernel won't map those regions in the direct mapping
> > +(avoiding issues with hibernation, speculative accesses and probably other
> > +subsystems).
> > +
> > +Kernel location
> > +---------------
> > +
> > +The RISC-V kernel expects to be placed at a PMD boundary (2MB for rv64 and 4MB
> > +for rv32). Note though that the EFI stub will physically relocate the kernel if
> > +that's not the case.
> > +
> > +Device-tree
> > +-----------
> > +
> > +The RISC-V kernel always expects a device tree, it is:
> > +
In general, the firmware can pass either DT or ACPI (not both at the
same time) to the OS. So, I think the statement that kernel always
expects DT probably causes confusion. Can we mention some thing like
below?

The firmware can pass either DeviceTree or ACPI tables to the RISC-V
kernel.

The DeviceTree is either passed directly to the kernel from the
previous stage using the `$a1` register, or when booting with UEFI, it
can be passed using the EFI configuration table.

The ACPI tables are passed to the kernel using the EFI configuration
table. In this case, a tiny DeviceTree is still created by the EFI
stub. Please refer to "EFI stub and device" tree section below for
details of the tiny DeviceTree.

Thanks,
Sunil
