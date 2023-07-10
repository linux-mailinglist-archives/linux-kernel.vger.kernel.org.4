Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEE874DAB3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjGJQDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbjGJQDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:03:47 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543BD1BB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:03:38 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51de9c2bc77so5586976a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689005017; x=1691597017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lbgr4cPVME1zyRcKyuyARahjBVKm6KiDwdVRCmA9Q64=;
        b=g5R3+f20/+qL7dipQIKkz5rxzLAR7Se9KH86BMP7iHZl/KmR6+RpSQ1K1ZNgqDOkfG
         X0gTMclAN8InrtMW3MctYvD2sbzkPpUq9rbw1n7uY+YRa5CInone/DIXMsBue8QkxfeU
         i/LrPBKRr3LW2eTswG6zPiVwfmm0WGQtILXhKU67oZU2vcZVR0quPs35oIU56N+Df9Nu
         WFKRsZP0Y37hIsmRGvcjv3BNmbiPry9RGbQUcL6gLdLTlfJ634TNkzLYg7oppQ/DmeyO
         jzEnP2uRwtbBhtxropinfJ/lj4bQQAh6PraO/Wny5HCKh++zqiXkNVohLbyyocgI0Wi1
         pfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689005017; x=1691597017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lbgr4cPVME1zyRcKyuyARahjBVKm6KiDwdVRCmA9Q64=;
        b=IH/Zc5WfyZyqnRM6/v2/Ur5+nolUO6ocZoiuc7viJ/jWup8bTRuawlB5hX1sqozJnb
         hB6Vaq346BS1hDx0v0hOZfw2lxl8TfEPKU2BIQ2SxGp3dxVb8/jCwJYCk76xsdS44Qp+
         aaq9t4e/sM+raSKfAcadyBiboc8cot80ZNQSh3ZtPGDnZSQCnnruSdFwg0fF4I1fZFv8
         Zt0BjfMX3op9IS4sHljXJoCTi1WIFaqeScUwNOYU4oGCxscs8o7Kb+T8ws5lJBXH0VdO
         arS2s9WBzJTwew47x2B5GrrQmKiqV8klu1PB4xQJ+pMf/8ZJjLc5mi2whxiMlFKlX7GT
         C9bQ==
X-Gm-Message-State: ABy/qLbtcP1HUnXaeEsqW2lVYDLSvf+1zRYfYWXml4OfeoisZw3g1Wo+
        qX7vjS1rV1ujuDs1lFBvCi8V+gRcXcOOu+/n4vz+Hw==
X-Google-Smtp-Source: APBJJlHoSKwoAYk9F+jStZaCU4tNJMEhp8d7NJP+u129T3kFtPxkskN1kPYs/YQCe1K98e0aaAgdStgdSWgKlBd1k90=
X-Received: by 2002:a05:6402:d3:b0:51d:9195:400f with SMTP id
 i19-20020a05640200d300b0051d9195400fmr12646823edu.17.1689005016719; Mon, 10
 Jul 2023 09:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXFZren0Q19DimwQaETCLz64D4bZQC5B2N=i3SAWHygkTQ@mail.gmail.com>
 <mhng-b66b085a-eb15-4c9b-b2aa-93ddf16ec7aa@palmer-ri-x1c9a>
 <CAP6exYKwZG=_47r0jAUFYNL5-P-SS==k6vWdKiMJ9nB0upH5Zw@mail.gmail.com>
 <20230707-attach-conjuror-306d967347ce@wendy> <ZKfsSsdiso0W8mW6@sunil-laptop>
 <CAN3iYbMhQU5Ng4r6_rQDnLmit1GCmheC5T49rsUP5NgHFEXsHA@mail.gmail.com>
 <ZKgLKvBoWKSxzm6r@sunil-laptop> <CAN3iYbOe+i4jVhz0sSQwVQ2PMB7UvaTPyN_sLtZj0uiOD2emDA@mail.gmail.com>
 <20230707-gargle-enjoyable-f9f7f87fc7ea@spud> <DBAPR08MB5783AED8329E38D840B7015D9C2DA@DBAPR08MB5783.eurprd08.prod.outlook.com>
 <CAMj1kXEkL0gF8uGcy2AjJvD-yZHmyLX9jiVVDtR+uBAYf+BfUg@mail.gmail.com>
In-Reply-To: <CAMj1kXEkL0gF8uGcy2AjJvD-yZHmyLX9jiVVDtR+uBAYf+BfUg@mail.gmail.com>
From:   =?UTF-8?B?6JGb5aOr5bu6?= <geshijian@bytedance.com>
Date:   Tue, 11 Jul 2023 00:03:25 +0800
Message-ID: <CAN3iYbMsUNMH27kdtwPwLeBSUfH0gTvyqjZ8ExZaoGcuv8CBdA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 0/4] Obtain SMBIOS and ACPI entry from FFI
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Dong Wei <Dong.Wei@arm.com>, Conor Dooley <conor@kernel.org>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 8, 2023 at 4:45=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Fri, 7 Jul 2023 at 18:21, Dong Wei <Dong.Wei@arm.com> wrote:
> >
> > On Arm systems today, the ACPI RSDP is found using the UEFI Configurati=
on Table. This is true for all Arm SystemReady compliant systems: 1) System=
Ready LS: LBBRv1 is using a minimal UEFI FW to load LinuxBoot, that minimal=
 UEFI FW is producing the UEFI Configuration Table. We are working on LBBRv=
2. LBBRv2 is based on Coreboot loading LinuxBoot. But we do not have a way =
today to get CoreBoot to produce this pointer to ACPI RSDP. Arm does not su=
pport x86 E820 BIOS interface. 2) SystemReady IR: this solution uses DT rat=
her than ACPI. 3) SystemReady ES: this solution can use UBoot or EDK2, and =
it requires ACPI. Since both UBoot and EDK2 support UEFI now, so ACPI RSDP =
can be found using the UEFI Configuration Table. 4) SystemReady SR: this so=
lution typically uses EDK2 and requires ACPI, so no issue finding RSDP via =
UEFI Configuration Table.
> >
> >
> >
> > So the ACPI RSDP issue only exist if we want to remove the minimum UEFI=
 FW and go to CoreBoot completely to load LinuxBoot. We are currently explo=
ring how to solve that issue=E2=80=A6
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

Thanks Ard and Sunil,

You are right, we need to work out a coreboot memory map for doing
ACPI on ARM64.
BTW, I don't suggest binding ACPI and UEFI together. On RISC-V,  the
current solution works well based on our experience, anyway, we will
study memory with DTS and update later.

Thanks,
-Nill
