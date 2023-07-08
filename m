Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18C574BCE5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 10:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjGHIpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 04:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGHIpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 04:45:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5881FEB;
        Sat,  8 Jul 2023 01:45:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 709E460B67;
        Sat,  8 Jul 2023 08:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2DEC433D9;
        Sat,  8 Jul 2023 08:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688805941;
        bh=2LWJgp5ERD9gY+Q3hNf/V4SPoiIF64mJOI5ZyVdhqvU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EcZDIaTulO3ipM951jXLqZhmGNK5+EFpckoYJYtc5U1/Oek8rzdaDVcrilG82ISqd
         Xt8kD1g2kWOg6O+aHV1ALx14T/HQqokvxSdC0hYkA3MqesMOsCRaEsADgRGwrSybh4
         14Hv66/yxuKNolr5mkkAqBRYbPWxtToBNEzkRua2x6shcJuGih4fBvlzxl7P0F/u1P
         KY8gyDg+dRd700+qmJrdA4EGJLR5QfeWHLEqELp97zeVZMHCpTwNcZuBLrdIocY+pi
         HYShgvNSh5lAS6kWvvsOgf4oyZTeeRyehDFxGeYv87RKVMpCfeeE3OJiB6KkxL98B9
         AYvBgV64X74Ng==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2b69e6d324aso41961951fa.0;
        Sat, 08 Jul 2023 01:45:41 -0700 (PDT)
X-Gm-Message-State: ABy/qLYZBBwQpSQbuXHdVszw4lBbj99KUAyA+fR2B1rfaInXA2X5Yt2g
        UvrW1Q2QwxGRHwy/BCKTzYkDpwG063hkkOM8Vio=
X-Google-Smtp-Source: APBJJlFRK8ftU5BePwYYhTW3J+ojTKybCPmG4i1nrzUpUPVkgKrj9biwnV07fagKbGe8iUTK9kp4Y6gHmA03jOWjUXI=
X-Received: by 2002:a05:6512:1104:b0:4fb:cff5:3963 with SMTP id
 l4-20020a056512110400b004fbcff53963mr3616338lfg.60.1688805939743; Sat, 08 Jul
 2023 01:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXFZren0Q19DimwQaETCLz64D4bZQC5B2N=i3SAWHygkTQ@mail.gmail.com>
 <mhng-b66b085a-eb15-4c9b-b2aa-93ddf16ec7aa@palmer-ri-x1c9a>
 <CAP6exYKwZG=_47r0jAUFYNL5-P-SS==k6vWdKiMJ9nB0upH5Zw@mail.gmail.com>
 <20230707-attach-conjuror-306d967347ce@wendy> <ZKfsSsdiso0W8mW6@sunil-laptop>
 <CAN3iYbMhQU5Ng4r6_rQDnLmit1GCmheC5T49rsUP5NgHFEXsHA@mail.gmail.com>
 <ZKgLKvBoWKSxzm6r@sunil-laptop> <CAN3iYbOe+i4jVhz0sSQwVQ2PMB7UvaTPyN_sLtZj0uiOD2emDA@mail.gmail.com>
 <20230707-gargle-enjoyable-f9f7f87fc7ea@spud> <DBAPR08MB5783AED8329E38D840B7015D9C2DA@DBAPR08MB5783.eurprd08.prod.outlook.com>
In-Reply-To: <DBAPR08MB5783AED8329E38D840B7015D9C2DA@DBAPR08MB5783.eurprd08.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 8 Jul 2023 10:45:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEkL0gF8uGcy2AjJvD-yZHmyLX9jiVVDtR+uBAYf+BfUg@mail.gmail.com>
Message-ID: <CAMj1kXEkL0gF8uGcy2AjJvD-yZHmyLX9jiVVDtR+uBAYf+BfUg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 0/4] Obtain SMBIOS and ACPI entry from FFI
To:     Dong Wei <Dong.Wei@arm.com>
Cc:     Conor Dooley <conor@kernel.org>,
        =?UTF-8?B?6JGb5aOr5bu6?= <geshijian@bytedance.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2023 at 18:21, Dong Wei <Dong.Wei@arm.com> wrote:
>
> On Arm systems today, the ACPI RSDP is found using the UEFI Configuration=
 Table. This is true for all Arm SystemReady compliant systems: 1) SystemRe=
ady LS: LBBRv1 is using a minimal UEFI FW to load LinuxBoot, that minimal U=
EFI FW is producing the UEFI Configuration Table. We are working on LBBRv2.=
 LBBRv2 is based on Coreboot loading LinuxBoot. But we do not have a way to=
day to get CoreBoot to produce this pointer to ACPI RSDP. Arm does not supp=
ort x86 E820 BIOS interface. 2) SystemReady IR: this solution uses DT rathe=
r than ACPI. 3) SystemReady ES: this solution can use UBoot or EDK2, and it=
 requires ACPI. Since both UBoot and EDK2 support UEFI now, so ACPI RSDP ca=
n be found using the UEFI Configuration Table. 4) SystemReady SR: this solu=
tion typically uses EDK2 and requires ACPI, so no issue finding RSDP via UE=
FI Configuration Table.
>
>
>
> So the ACPI RSDP issue only exist if we want to remove the minimum UEFI F=
W and go to CoreBoot completely to load LinuxBoot. We are currently explori=
ng how to solve that issue=E2=80=A6
>

Hello Dong,

This fixes the RSDP issue perhaps, but that is not the only problem. I
have mentioned this many times already, but let me mention it again
for completeness:

ACPI does not have a memory map, and ARM is much more finicky about
mapping memory regions with the right attributes, given that uncached
accesses don't snoop the caches like they do on x86. This means it is
essential that memory mappings constructed from AML code (which
doesn't provide any context pertaining to the memory type either) are
created with the right memory type.

Currently, the Linux/arm64 glue code for the ACPI core
cross-references every memory mapping created from a SystemMemory
OpRegion by AML code against the EFI memory map, and uses the EFI
memory type and attributes to infer the memory type to program into
the page tables. So simply providing the RSDP is *not* sufficient: on
arm64, more work is needed and currently, booting ACPI without a EFI
memory map results in SystemMemory OpRegions not working at all.

Of course, we might be able to work around that by providing a
'coreboot' memory map for doing ACPI on arm64, but that results in
more fragmentation and an inflated validation matrix, which puts the
burden on the Linux subsystem maintainers to make sure that all these
different combinations remain supported.

AIUI, this memory type issue does not exist for RISC-V today, but I'd
suggest to the RISC-V maintainers to take a careful look at arm64's
acpi_os_ioremap() implementation and decide whether or not RISC-V
needs similar logic.
