Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F297380AA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjFUJSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjFUJSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:18:44 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7936E68
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:18:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b51488ad67so29317735ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1687339123; x=1689931123;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pB2kKOyXmNJk2e2QsKOkbUZlQ9krtQWymG1tqTKND7M=;
        b=JEl+WD8TxC8kp5VqXUE8dKNh2/i7vnWvgiUcocUBtcvkMYbkJ/3i/v1xwcQI/dnAYD
         OocJ0aboXF1NcZDeOK+0y/eEiy2dSnUKH8qOOzAKez+JCw7tFekIKtwqCFhRfiNAKlLt
         q5+gV8VlyclcWMQHTWua5wpsF/9nEXJZj/nZagINJw6yXeij1vuicd7+vVmeUoHRt4If
         bnBpQ8XUnXOkoLSp2bYEahv6V/k4PyCu7yOSZCqc7nu5EzRWafvELH50E9xAkYQwv7Jn
         SJe9vOVGMBBXv8+yJMdaxMtks4idFDRhUSiJN05C/KeQ6BdmEBhTcbqL7PropsMzaMpq
         pqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339123; x=1689931123;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pB2kKOyXmNJk2e2QsKOkbUZlQ9krtQWymG1tqTKND7M=;
        b=VQ+J/YWc4lGhHK7SU5lIpFcA+DV5VY73nfhXoOOTsIWLtLXtQqti/9bWE8OXVYWU8o
         k1JlihnzWii9iozCGE+PxtJFlEu6FL1BtDF3apUO/p1S2zwZFqfenfFRj8hdQlSlzCEv
         xLoaHxkpJEOeIERPH5DZ4VnOsoAvMk4qbTgeN6weCLHvkPp9PTsbaNu1wUZoBpGFn8/1
         mrN6dro7PKSGGOMdrJtbL3h44/HFC602YPv1lLWwUdO0lRCaLmhC3pf6CRZqk9txwtzl
         EPRrN1UaCUhWdNQ3vABHkv/VQ5NI/++fl2yTqrAVZO7yImmbdo875m3Sb5s3kPnYYZwv
         n/RA==
X-Gm-Message-State: AC+VfDwhpneVM9XsZlrn6U5lgYZdGjLslT74NJZEBVqRilqwx8hK4e1W
        wABOApAdVGARViIfOQYUjSN/SQ==
X-Google-Smtp-Source: ACHHUZ7Lr9AUWR6pAzVAfNdiplGzzD94FoKQ4yBkZgab3ADs+Jo6JR2/ENdEGi0ao1yboNbI01pSuQ==
X-Received: by 2002:a17:902:ce91:b0:1b6:8f1f:fc8d with SMTP id f17-20020a170902ce9100b001b68f1ffc8dmr2804577plg.0.1687339123052;
        Wed, 21 Jun 2023 02:18:43 -0700 (PDT)
Received: from sunil-laptop ([106.51.184.72])
        by smtp.gmail.com with ESMTPSA id n21-20020a170902969500b001ab1b7bae5asm3007337plp.184.2023.06.21.02.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:18:42 -0700 (PDT)
Date:   Wed, 21 Jun 2023 14:48:35 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Subject: Re: [PATCH v2 2/3] Documentation: riscv: Add early boot document
Message-ID: <ZJLAa5AdJfHNJyPv@sunil-laptop>
References: <20230621072234.9900-1-alexghiti@rivosinc.com>
 <20230621072234.9900-2-alexghiti@rivosinc.com>
 <131BBACE35371733+d5902eda-c4ea-b74d-a17c-70fd1a166b6f@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <131BBACE35371733+d5902eda-c4ea-b74d-a17c-70fd1a166b6f@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 04:15:07PM +0800, Song Shuai wrote:
> 
> 
> 在 2023/6/21 15:22, Alexandre Ghiti 写道:
> > This document describes the constraints and requirements of the early
> > boot process in a RISC-V kernel.
> > 
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> > ---
> >   Documentation/riscv/boot-image-header.rst |   3 -
> >   Documentation/riscv/boot.rst              | 170 ++++++++++++++++++++++
> >   Documentation/riscv/index.rst             |   1 +
> >   3 files changed, 171 insertions(+), 3 deletions(-)
> >   create mode 100644 Documentation/riscv/boot.rst
> > 
> > diff --git a/Documentation/riscv/boot-image-header.rst b/Documentation/riscv/boot-image-header.rst
> > index d7752533865f..a4a45310c4c4 100644
> > --- a/Documentation/riscv/boot-image-header.rst
> > +++ b/Documentation/riscv/boot-image-header.rst
> > @@ -7,9 +7,6 @@ Boot image header in RISC-V Linux
> >   This document only describes the boot image header details for RISC-V Linux.
> > -TODO:
> > -  Write a complete booting guide.
> > -
> >   The following 64-byte header is present in decompressed Linux kernel image::
> >   	u32 code0;		  /* Executable code */
> > diff --git a/Documentation/riscv/boot.rst b/Documentation/riscv/boot.rst
> > new file mode 100644
> > index 000000000000..019ee818686d
> > --- /dev/null
> > +++ b/Documentation/riscv/boot.rst
> > @@ -0,0 +1,170 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +===============================================
> > +RISC-V Kernel Boot Requirements and Constraints
> > +===============================================
> > +
> > +:Author: Alexandre Ghiti <alexghiti@rivosinc.com>
> > +:Date: 23 May 2023
> > +
> > +This document describes what the RISC-V kernel expects from bootloaders and
> > +firmware, but also the constraints that any developer must have in mind when
> > +touching the early boot process. For the purposes of this document, the
> > +'early boot process' refers to any code that runs before the final virtual
> > +mapping is set up.
> > +
> > +Pre-kernel Requirements and Constraints
> > +=======================================
> > +
> > +The RISC-V kernel expects the following of bootloaders and platform firmware:
> > +
> > +Register state
> > +--------------
> > +
> > +The RISC-V kernel expects:
> > +
> > +  * `$a0` to contain the hartid of the current core.
> > +  * `$a1` to contain the address of the devicetree in memory.
> > +
> > +CSR state
> > +---------
> > +
> > +The RISC-V kernel expects:
> > +
> > +  * `$satp = 0`: the MMU, if present, must be disabled.
> > +
> > +Reserved memory for resident firmware
> > +-------------------------------------
> > +
> > +The RISC-V kernel must not map any resident memory, or memory protected with
> > +PMPs, in the direct mapping, so the firmware must correctly mark those regions
> > +as per the devicetree specification and/or the UEFI specification.
> > +
> > +Kernel location
> > +---------------
> > +
> > +The RISC-V kernel expects to be placed at a PMD boundary (2MB aligned for rv64
> > +and 4MB aligned for rv32). Note that the EFI stub will physically relocate the
> > +kernel if that's not the case.
> > +
> > +Hardware description
> > +--------------------
> > +
> > +The firmware can pass either a devicetree or ACPI tables to the RISC-V kernel.
> > +
> > +The devicetree is either passed directly to the kernel from the previous stage
> > +using the `$a1` register, or when booting with UEFI, it can be passed using the
> > +EFI configuration table.
> > +
> > +The ACPI tables are passed to the kernel using the EFI configuration table. In
> > +this case, a tiny devicetree is still created by the EFI stub. Please refer to
> > +"EFI stub and devicetree" tree section below for details about this devicetree.
> > +
> > +Kernel entrance
> > +---------------
> > +
> > +On SMP systems, there are 2 methods to enter the kernel:
> > +
> > +- `RISCV_BOOT_SPINWAIT`: the firmware releases all harts in the kernel, one hart
> > +  wins a lottery and executes the early boot code while the other harts are
> > +  parked waiting for the initialization to finish. This method is mostly used to
> > +  support older firmwares without SBI HSM extension and M-mode RISC-V kernel.
> > +- `Ordered booting`: the firmware releases only one hart that will execute the
> > +  initialization phase and then will start all other harts using the SBI HSM
> > +  extension. The ordered booting method is the preferred booting method for
> > +  booting the RISC-V kernel because it can support cpu hotplug and kexec.
> > +
> > +UEFI
> > +----
> > +
> > +UEFI memory map
> > +~~~~~~~~~~~~~~~
> > +
> > +When booting with UEFI, the RISC-V kernel will use only the EFI memory map to
> > +populate the system memory.
> > +
> > +The UEFI firmware must parse the subnodes of the `/reserved-memory` devicetree
> > +node and abide by the devicetree specification to convert the attributes of
> > +those subnodes (`no-map` and `reusable`) into their correct EFI equivalent
> > +(refer to section "3.5.4 /reserved-memory and UEFI" of the devicetree
> > +specification v0.4-rc1).
> append this note ?
> 
> Note that RISC-V edk2 diverges from the devicetree specification to declare
> the !no-map regions as EfiReservedMemoryType instead of EfiBootServicesData.
> > +
Not required. It will be fixed in EDK2.
