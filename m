Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A887364FA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjFTHmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjFTHl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:41:58 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3690FE4D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:41:15 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-543c6a2aa07so2309817a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1687246874; x=1689838874;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VNlkE9w8+4f9Owz1VR7DDy4a4R4dy/xTsJ/TjLKMtek=;
        b=bIFBmbK7FiaHLaGDgWmmB8jUjaecxgDpHm0ygwpqqg5bHBVtNXttGwGxPwQo1YYQ7Y
         ZYlopM4IUXYJTd9dQvjq7ZsHlFV6SDvOM0ePY0PyCktChM1feYusty5BHSInAs1Td43g
         nc11Q98qxk0UJzEZ1zwFu8gtOAL3ZLkQtCnkMneDVIEJTVe9ttfRLgQdm7xE0tduQIBB
         uaxQ/DaCgChdzcJ3h0cvQslVCVDWrj5T8TpJj8LUBZycoBSfkmEKVsXzpfW/m+IXAetN
         DcEWlT04weeu/jZAvmCiw5LBjQmAlVpkN6e67RhWhdS/40ees722j8iArp1zPRh96yj1
         h2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687246874; x=1689838874;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNlkE9w8+4f9Owz1VR7DDy4a4R4dy/xTsJ/TjLKMtek=;
        b=H7JTN9115HM/DxwyHGX7zsakFwqKvu7KPnufWEFZGvEfXfWrbXCmdq5HKeVpj442V9
         v5EmKK20EvEDo/lqIEYoCjClcmZAQZv3vqaZtvXqERkIiDy75gk3nayG9wLZBhe6uKfT
         b52n+FdCP8xM2WEMtugMtjSodjqDIPfxsNIDIiB7yzNNXlcBJhjcirzNT0k54qaoKKIx
         PsuAcvqI9GWUANhZzzjrAurR/xBXC62rSdBe8FEIFEzWrPNMMGfzymdE1uTHx0avHjBV
         oLIzWWcBj6FVQ4hyheV6fZ5KkllkrPj2+XSQ2VWP8xeqP+scSM85K8d8sEE1OeUfr0IX
         hZKw==
X-Gm-Message-State: AC+VfDwhdkXy4AcwzRfRlocUn3XvvRl93AaHtNpMIwffr91EIvljOly3
        LTIvVlIc14P04726Sx4gkmm5kg==
X-Google-Smtp-Source: ACHHUZ5/e/h5oqwfG3pVdVPiHyiKMor0pHhGX3SJ5BK89WAqKnQnNXoBBy0OZtgzAZuM8gP+Tw3exQ==
X-Received: by 2002:a05:6a21:339a:b0:115:dfb:da59 with SMTP id yy26-20020a056a21339a00b001150dfbda59mr10678421pzb.3.1687246874592;
        Tue, 20 Jun 2023 00:41:14 -0700 (PDT)
Received: from sunil-laptop ([106.51.184.72])
        by smtp.gmail.com with ESMTPSA id r1-20020a1709028bc100b001a1b66af22fsm975645plo.62.2023.06.20.00.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 00:41:14 -0700 (PDT)
Date:   Tue, 20 Jun 2023 13:11:07 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: riscv: Add early boot document
Message-ID: <ZJFYE+Ss/OgMIjda@sunil-laptop>
References: <20230619094705.51337-1-alexghiti@rivosinc.com>
 <20230619-kerchief-unmixed-cfdbeb1cf242@wendy>
 <CAHVXubjV=0HNyc0-UMAQRQfi4ZUnwH8dmghV-BGogZsJiumtZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHVXubjV=0HNyc0-UMAQRQfi4ZUnwH8dmghV-BGogZsJiumtZA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 04:04:52PM +0200, Alexandre Ghiti wrote:
> On Mon, Jun 19, 2023 at 2:26 PM Conor Dooley <conor.dooley@microchip.com> wrote:
> >
> > Hey Alex,
> >
> > Thanks for working on this :) I've got a mix of suggestions and
> > questions below. Hopefully it is not too disjoint, since I didn't write
> > them in order.
> >
> > On Mon, Jun 19, 2023 at 11:47:04AM +0200, Alexandre Ghiti wrote:
> > > This document describes the constraints and requirements of the early
> > > boot process in a RISC-V kernel.
> > >
> > > Szigned-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > ---
> > >  Documentation/riscv/boot-image-header.rst |   3 -
> > >  Documentation/riscv/boot.rst              | 181 ++++++++++++++++++++++
> > >  Documentation/riscv/index.rst             |   1 +
> > >  3 files changed, 182 insertions(+), 3 deletions(-)
> > >  create mode 100644 Documentation/riscv/boot.rst
> > >
> > > diff --git a/Documentation/riscv/boot-image-header.rst b/Documentation/riscv/boot-image-header.rst
> > > index d7752533865f..a4a45310c4c4 100644
> > > --- a/Documentation/riscv/boot-image-header.rst
> > > +++ b/Documentation/riscv/boot-image-header.rst
> > > @@ -7,9 +7,6 @@ Boot image header in RISC-V Linux
> > >
> > >  This document only describes the boot image header details for RISC-V Linux.
> > >
> > > -TODO:
> > > -  Write a complete booting guide.
> > > -
> > >  The following 64-byte header is present in decompressed Linux kernel image::
> > >
> > >       u32 code0;                /* Executable code */
> > > diff --git a/Documentation/riscv/boot.rst b/Documentation/riscv/boot.rst
> > > new file mode 100644
> > > index 000000000000..b02230818b79
> > > --- /dev/null
> > > +++ b/Documentation/riscv/boot.rst
> > > @@ -0,0 +1,181 @@
> > > +.. SPDX-License-Identifier: GPL-2.0
> > > +
> > > +=============================================
> > > +Early boot requirements/constraints on RISC-V
> > > +=============================================
> >
> > Please use "title case", here and elsewhere in the doc.
> 
> You mean using "title: " instead of "===="? Or using uppercase for the
> first letter of each word? FYI I followed
> https://docs.kernel.org/doc-guide/sphinx.html?highlight=title#specific-guidelines-for-the-kernel-documentation
> 
> > I'd also be inclined to drop the "Early" from here, as it permits more
> > natural section headings. Perhaps "RISC-V Kernel Boot Requirements and
> > Constraints"?
> 
> Good suggestion, I'll go with that, thanks
> 
> >
> > > +
> > > +:Author: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > +:Date: 23 May 2023
> > > +
> > > +This document describes what the RISC-V kernel expects from the previous stages
> >
> > "the previous stages" is a bit vague IMO. You mean bootloader stages I
> > assume, but I think it should be explicit. Perhaps:
> > "...what a RISC-V kernel expects from bootloaders and firmware, and the
> > constraints..."
> >
> > > +and the firmware, but also the constraints that any developer must have in mind
> > > +when touching the early boot process, e.g. before the final virtual mapping is
> > > +setup.
> >
> > s/setup./set up./
> >
> > Do you mean to have "For example" here? Or is "before the final virtual
> > mapping is set up" the definition or "early boot"? If the latter, I
> > would reword this as something like:
> > "...when modifying the early boot process. For the purposes of this
> > document, the 'early boot process' refers to any code that runs before
> > the final virtual mapping is set up."
> 
> Thanks, that's what I meant.
> 
> >
> > > +Pre-kernel boot (Expectations from firmware)
> >
> > Firmware or bootloaders? TBH, I would just drop the section in () and
> > do something like:
> >         Pre-kernel Requirements and Constraints
> >         =======================================
> >
> >         The RISC-V kernel expects the following of bootloaders and platform
> >         firmware:
> >
> 
> Ok
> 
> > > +
> > > +Registers state
> >
> > s/Registers state/Register State/
> 
> Ok
> 
> >
> > > +---------------
> > > +
> > > +The RISC-V kernel expects:
> > > +
> > > +  * `$a0` to contain the hartid of the current core.
> > > +  * `$a1` to contain the address of the device tree in memory.
> > > +
> > > +CSR state
> > > +---------
> > > +
> > > +The RISC-V kernel expects:
> > > +
> > > +  * `$satp = 0`: the MMU must be disabled.
> >
> > "the MMU, if present, must be disabled." ;)
> 
> Ahah forgot the !mmu case, thanks :)
> 
> >
> > > +
> > > +Reserved memory for resident firmware
> > > +-------------------------------------
> > > +
> > > +The RISC-V kernel expects the firmware to mark any resident memory with the
> >
> > Should this be
> > "...resident memory, or memory it has protected with PMPs, with..."
> > ?
> 
> I used "resident" memory instead of "PMP" memory because it was more
> general. I mean you can have a region that is resident but not
> protected by PMP, and I don't think the kernel should ask for this
> resident memory to be protected with PMP right?
> 
> >
> > > +`no-map` flag, thus the kernel won't map those regions in the direct mapping
> >
> > "no-map" is a DT specific term, should this section be moved down under
> > DT, as a sub-section of that?
> 
> Maybe I can rephrase with something like that:
> 
> "The RISC-V kernel must not map any resident memory in the direct
> mapping, so the firmware must correctly mark those regions as follows:
> - when using a devicetree, using the `no-map` flag,
> - when booting with UEFI without devicetree, either as
> `EfiRuntimeServicesData/Code` or `EfiReserved`."
> 
Hi Alex,

I am not sure about the idea behind mentioning only UEFI boot without
DT since UEFI boot is supported with DT also. Should we just mention
that "when booting with UEFI, resident firmware ranges must be marked as
per UEFI specification" ? Converting reserved-memory node in DT to UEFI
memory map is anyway mentioned separately under UEFI memory map section
right?

Thanks,
Sunil
