Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201C674937C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 04:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjGFCGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 22:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjGFCGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 22:06:00 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3581BD8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 19:05:01 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso1595555e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 19:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688609094; x=1691201094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34TMPqSfA3ijY4f7A0JqszQChtIKUD8qol2PfiviNwU=;
        b=bGZqZCL+3J4+L6h0jDV/c/XvS76akDDG0dWPaFBu6Iy9pMRr9L+P9G4avL1KjaiU0W
         5d2xQyg/ETXI5BaPrkg5hG+A1dEcsSLmN5vNEPxUhV6nh/1VDkC+bGCVavozwWhHbCPe
         BaVYvVLApuxCQgzzlEIGYa1IA2kVs726O4w37oIkoxB+pTpZWZ09keajJEbGkek9IxIj
         hrtY3WwVi0FE0pCIbscS2XxxE9nCon7p8kQsrZyXE73T7+hmRVcUUevymj2wA7Ggc29h
         +GUlSzaGhanvbPvSTMZnk+eAL0IsCxQgcMi4HGrsc7WGdM2Fz9A4TcXuxWVQV3jm1QpZ
         IZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688609094; x=1691201094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34TMPqSfA3ijY4f7A0JqszQChtIKUD8qol2PfiviNwU=;
        b=lSd8clHUp/GWeZuPc2YFSanrCK6MPOfRoEycPuMvRjy2X8h/D/n25CtPQWf3k2Fw8p
         nJOo1oM3egx+zCXJaAiMqUbn2t6Xhegn55dWJEmA1Et/UORqAZ55xK8XVq7mrrjD33ao
         uJUIoNQ09L3lX21XxmcPtUqoGB3aI0Emw1iQNBpv7wIDqU+z9KMU3dx54tPGUZafUHXF
         /FI8LZpHDoSNAFcaGxY2z6KVPRqGE0+PIC17F3qOv4nrzWyjeI3S/CSUd794sc47UOcc
         mn2b0++MzPoOeG87jxrFB3BzqV6rR5W+aWa/ZV28fkFq3gjiIN3gr8/CLYjBtOORwE/Y
         emuw==
X-Gm-Message-State: ABy/qLbQR4KIAbPGf8cpXat/wmnP1CIZ/Z6oPT+mXkCJLduisXHIPRtv
        8Z5lbzd3Y4pmL1/hBBaaLUg7tXRBNwK5wiii+qPLvA==
X-Google-Smtp-Source: APBJJlGVWzsd0V/3ij0Kz1pL53DsIqaMBF+Y/tKLbg5iO0mVv5HLtAihtyPm3joxaTQl/6r7rNhAZetiICw9F07vfaU=
X-Received: by 2002:a05:600c:2058:b0:3fb:c417:5e6 with SMTP id
 p24-20020a05600c205800b003fbc41705e6mr200410wmg.23.1688609093887; Wed, 05 Jul
 2023 19:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230705114251.661-1-cuiyunhui@bytedance.com> <mhng-48837062-b9f6-4968-be9e-9d3b352be117@palmer-ri-x1c9>
In-Reply-To: <mhng-48837062-b9f6-4968-be9e-9d3b352be117@palmer-ri-x1c9>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Thu, 6 Jul 2023 10:04:42 +0800
Message-ID: <CAEEQ3wmRZGHNMB+CyfmAAGmapvFeQMVsgtQJh5nE01KG_3UBiw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 0/4] Obtain SMBIOS and ACPI entry from FFI
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Conor Dooley <conor@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        sunilvl@ventanamicro.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, Mark Rutland <mark.rutland@arm.com>,
        lpieralisi@kernel.org, rafael@kernel.org, lenb@kernel.org,
        jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Wed, Jul 5, 2023 at 10:17=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.com>=
 wrote:
>
> On Wed, 05 Jul 2023 04:42:47 PDT (-0700), cuiyunhui@bytedance.com wrote:
> > Here's version 3 of patch series.
> >
> > V1: The FFI (FDT FIRMWARE INTERFACE) scheme has reached a
> > consensus with the Maintainers.
> > Please refer to:
> > https://patches.linaro.org/project/linux-acpi/patch/20230426034001.16-1=
-cuiyunhui@bytedance.com/
>
> From looking at that thread it seems that the consensus is this is a bad
> idea?  Sorry if I'm just missing something...
>

First of all, Coreboot does not support EFI, Ron has expressed, as follows:
"I am wondering if we can focus on risc-v here, and not drag in ARM,
b/c the ARM ACPI+UEFI ship has sailed. I had that discussion in 2013
;-) and it's clear we don't want to redo it.
In general, in my world, because of the many problems that come with
UEFI (security, code quality, performance), we'd like to avoid
requiring a dependency on UEFI just to get ACPI on RISC-V. It also
seems, from other discussions I'm having, that there is some belief
that ACPI will be wanted on RISC-V. It would be nice to separate those
pieces on RISC-V; certainly they were separate for a very long time in
the x86 world (we had ACPI+SMM on coreboot laptops without UEFI for
example)."

Then, a consensus was reached with Ard, that FFI can be applied to RISC-V.

Please look at this patch again: [PATCH v3 1/4] riscv: obtain ACPI
RSDP from devicetree
Why do you think it is a bad idea?


> > Changes v1->v2:
> > Adjusted the code structure, put the ACPI part under the RISC-V archite=
cture,
> > and put the general part of obtaining SMBIOS entry through FFI
> > under driver/firmware/.
> > Please refer to:
> > https://lore.kernel.org/lkml/20230703-71f67eb66a037f5c0fb825c6@orel/T/
> >
> > Changes v2->v3:
> > According to the suggestions of maintainers, the code has been modified=
 as follows:
> > 1. Modified the commit log.
> > 2. Added description of "ffitbl" subnod in dt-bindings.
> > 3. Add stub function to the function
> > 4. arch/riscv/ and driver/firmware/ use CONFIG_FDT_FW_INTERFACE to cont=
rol
> > 5. Modified the ffi_smbios_root_pointer() function logic and printing
> > etc.
> >
> > Yunhui Cui (4):
> >   riscv: obtain ACPI RSDP from devicetree
> >   firmware: introduce FFI for SMBIOS entry
> >   riscv: obtain SMBIOS entry from FFI
> >   dt-bindings: firmware: Document ffitbl binding
> >
> >  .../devicetree/bindings/firmware/ffitbl.txt   | 27 ++++++
> >  MAINTAINERS                                   | 13 +++
> >  arch/riscv/include/asm/acpi.h                 |  9 ++
> >  arch/riscv/include/asm/ffi.h                  | 14 +++
> >  arch/riscv/kernel/Makefile                    |  1 +
> >  arch/riscv/kernel/ffi.c                       | 40 ++++++++
> >  arch/riscv/kernel/setup.c                     |  2 +
> >  drivers/firmware/Kconfig                      | 11 +++
> >  drivers/firmware/Makefile                     |  1 +
> >  drivers/firmware/dmi_scan.c                   | 97 +++++++++++--------
> >  drivers/firmware/ffi.c                        | 42 ++++++++
> >  include/linux/ffi.h                           | 29 ++++++
> >  12 files changed, 246 insertions(+), 40 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/firmware/ffitbl.t=
xt
> >  create mode 100644 arch/riscv/include/asm/ffi.h
> >  create mode 100644 arch/riscv/kernel/ffi.c
> >  create mode 100644 drivers/firmware/ffi.c
> >  create mode 100644 include/linux/ffi.h

Thanks,
Yunhui
