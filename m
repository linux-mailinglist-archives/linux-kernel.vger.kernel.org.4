Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F94774BD68
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 14:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjGHMDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 08:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGHMDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 08:03:13 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E86810EA
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 05:03:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-26598fc0825so422288a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 05:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688817792; x=1691409792;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pmW+hS9M/nuHr1o+UJdiTC8iEB1m1jPftzrxBZrYbqo=;
        b=Cgx32CzVjbgsu10mxr5sIU/3c+N6ldXoy6BzzWOBMTIGC9t2Mg4tZtwqFYZ2z7JZpL
         EeGF6w355DMuzE85qokbs18VK9Gvqqm2Qorj24pqu8E84cO2bG2p11UShZMr3wpsCF0k
         1WR8q8vC68MrUMmUOdtnQh2Hsi+dYU7MJIOLJA8DgGA4JjGPMFVCeKsBkySaQKPLKwsL
         MKzDPTuDc5dgc4qLxIxAm89ois4f+C3c+M5Qb4NoYh29nDvjF0Dn8AOBYIUSm07sxQ/j
         RESBR25MqbVD+tva7z63hUlEXq0GZAoFS8HgWibdOnNJp2FYh6N2Fqlk4HC+8qaTcGw5
         nByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688817792; x=1691409792;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmW+hS9M/nuHr1o+UJdiTC8iEB1m1jPftzrxBZrYbqo=;
        b=QN6I6xZo7jeqxirtEkhzyjf5jRhStzL/3Tod420+2e1iElb5JwK0Fet9JSK34bh7PB
         nXMW9Q3j/M1/lJ+zHSPiTLOidjTsC+N0dylkx9XwRLYssWjcDBOBcTePOjP9T9p+9t9B
         8ZPFccsl6EU5lSSyoBLKhjT21W69wubNCwwgXUeac+6AE+48QkQ7163U5H3rLIA9/87n
         W9vFmiQ7Cuy6aeHXj3aqPH6SAIoYF2H8sOaN9qksuPrfEnzI0duVY8Uh0Y1KMlSPZY0P
         FpAmUNdMjw/KcfToHsc+U+nx0b6KDVl9VbqJBy0HUGBwoyy5GeXtWgrnBTkfst4NMbdo
         xCOw==
X-Gm-Message-State: ABy/qLZsOUIG9++m0buIyj1eiG/Zduj5V6KCTHpU6v5QZJTg9IEKBtiT
        ohQBIdkdbiPypMxxQi7VE/rIDg==
X-Google-Smtp-Source: APBJJlFRc9kwODiRcw6uSg+iVQe/4Kk5wsuH2F52nIAIw5ZGfOzMcKcldwdMs7dd4MdwFE3W7lBf7w==
X-Received: by 2002:a17:90b:357:b0:262:ec04:4ff7 with SMTP id fh23-20020a17090b035700b00262ec044ff7mr16375949pjb.16.1688817791704;
        Sat, 08 Jul 2023 05:03:11 -0700 (PDT)
Received: from sunil-laptop ([106.51.184.72])
        by smtp.gmail.com with ESMTPSA id v2-20020a17090a960200b00262e9fbd5fbsm2932101pjo.32.2023.07.08.05.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 05:03:11 -0700 (PDT)
Date:   Sat, 8 Jul 2023 17:33:01 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Dong Wei <Dong.Wei@arm.com>, Conor Dooley <conor@kernel.org>,
        =?utf-8?B?6JGb5aOr5bu6?= <geshijian@bytedance.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        ron minnich <rminnich@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "cuiyunhui@bytedance.com" <cuiyunhui@bytedance.com>,
        "jrtc27@jrtc27.com" <jrtc27@jrtc27.com>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "yc.hung@mediatek.com" <yc.hung@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "allen-kh.cheng@mediatek.com" <allen-kh.cheng@mediatek.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "tinghan.shen@mediatek.com" <tinghan.shen@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "weidong.wd@bytedance.com" <weidong.wd@bytedance.com>
Subject: Re: [External] Re: [PATCH v3 0/4] Obtain SMBIOS and ACPI entry from
 FFI
Message-ID: <ZKlQdXnPVTrYIUzb@sunil-laptop>
References: <mhng-b66b085a-eb15-4c9b-b2aa-93ddf16ec7aa@palmer-ri-x1c9a>
 <CAP6exYKwZG=_47r0jAUFYNL5-P-SS==k6vWdKiMJ9nB0upH5Zw@mail.gmail.com>
 <20230707-attach-conjuror-306d967347ce@wendy>
 <ZKfsSsdiso0W8mW6@sunil-laptop>
 <CAN3iYbMhQU5Ng4r6_rQDnLmit1GCmheC5T49rsUP5NgHFEXsHA@mail.gmail.com>
 <ZKgLKvBoWKSxzm6r@sunil-laptop>
 <CAN3iYbOe+i4jVhz0sSQwVQ2PMB7UvaTPyN_sLtZj0uiOD2emDA@mail.gmail.com>
 <20230707-gargle-enjoyable-f9f7f87fc7ea@spud>
 <DBAPR08MB5783AED8329E38D840B7015D9C2DA@DBAPR08MB5783.eurprd08.prod.outlook.com>
 <CAMj1kXEkL0gF8uGcy2AjJvD-yZHmyLX9jiVVDtR+uBAYf+BfUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXEkL0gF8uGcy2AjJvD-yZHmyLX9jiVVDtR+uBAYf+BfUg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2023 at 10:45:27AM +0200, Ard Biesheuvel wrote:
> On Fri, 7 Jul 2023 at 18:21, Dong Wei <Dong.Wei@arm.com> wrote:
> >
> > On Arm systems today, the ACPI RSDP is found using the UEFI Configuration Table. This is true for all Arm SystemReady compliant systems: 1) SystemReady LS: LBBRv1 is using a minimal UEFI FW to load LinuxBoot, that minimal UEFI FW is producing the UEFI Configuration Table. We are working on LBBRv2. LBBRv2 is based on Coreboot loading LinuxBoot. But we do not have a way today to get CoreBoot to produce this pointer to ACPI RSDP. Arm does not support x86 E820 BIOS interface. 2) SystemReady IR: this solution uses DT rather than ACPI. 3) SystemReady ES: this solution can use UBoot or EDK2, and it requires ACPI. Since both UBoot and EDK2 support UEFI now, so ACPI RSDP can be found using the UEFI Configuration Table. 4) SystemReady SR: this solution typically uses EDK2 and requires ACPI, so no issue finding RSDP via UEFI Configuration Table.
> >
> >
> >
> > So the ACPI RSDP issue only exist if we want to remove the minimum UEFI FW and go to CoreBoot completely to load LinuxBoot. We are currently exploring how to solve that issue…
> >
> 
> Hello Dong,
> 
> This fixes the RSDP issue perhaps, but that is not the only problem. I
> have mentioned this many times already, but let me mention it again
> for completeness:
> 
> ACPI does not have a memory map, and ARM is much more finicky about
> mapping memory regions with the right attributes, given that uncached
> accesses don't snoop the caches like they do on x86. This means it is
> essential that memory mappings constructed from AML code (which
> doesn't provide any context pertaining to the memory type either) are
> created with the right memory type.
> 
> Currently, the Linux/arm64 glue code for the ACPI core
> cross-references every memory mapping created from a SystemMemory
> OpRegion by AML code against the EFI memory map, and uses the EFI
> memory type and attributes to infer the memory type to program into
> the page tables. So simply providing the RSDP is *not* sufficient: on
> arm64, more work is needed and currently, booting ACPI without a EFI
> memory map results in SystemMemory OpRegions not working at all.
> 
> Of course, we might be able to work around that by providing a
> 'coreboot' memory map for doing ACPI on arm64, but that results in
> more fragmentation and an inflated validation matrix, which puts the
> burden on the Linux subsystem maintainers to make sure that all these
> different combinations remain supported.
> 
> AIUI, this memory type issue does not exist for RISC-V today, but I'd
> suggest to the RISC-V maintainers to take a careful look at arm64's
> acpi_os_ioremap() implementation and decide whether or not RISC-V
> needs similar logic.

Currently, basic ACPI support is merged for RISC-V. Still many features
including external interrupt controller support are WIP. Enhancing the
acpi_os_ioremap() similar to arm64 version is in plan for next series.
Bjorn had also provided this feedback.
https://lore.kernel.org/lkml/87leidtvn9.fsf@all.your.base.are.belong.to.us/

So, the issue will be applicable to RISC-V also even if the
implementation may differ slightly.
