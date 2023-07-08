Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12F674BBA3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 05:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjGHD7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 23:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGHD7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 23:59:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468EE1BD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 20:59:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31590e4e27aso50964f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 20:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1688788742; x=1691380742;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjvUtkQ3iSWBoIXII2O90sxep5PUoLyeZZs21ibyqjE=;
        b=OiGMrex+gulqtkoETcR+WaKt21x/HEwIkx++ZMV9YncQp8qrx4JouSq84CndRxpw/O
         II0c24xYjWbAfJB7VODNtppQjhuoqL/xuHUAWtHaZVxEdm5/NGk9Uwx1qmorxSIJAzhk
         3d3qK6KzbiG0JIAWjal42kX9AYZVEsa+MkvD4H2OGIVUf9xF10lB+K8H6TNoSmJs2UeM
         EKbAxMx8yKJ1W6SNzv030t1zNfY4Txg4JxnE4RiAnCWnTuZc9mEoeAtmsFuc/6iD+6o0
         2pP4ctBkEX3CQBOAW+7+9fgZ+p5eLMJgvIlxVsdUJ3Lw6J+uYQBax+WSl3c00B0bdSKi
         o2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688788742; x=1691380742;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjvUtkQ3iSWBoIXII2O90sxep5PUoLyeZZs21ibyqjE=;
        b=dBV7O8KWxKlbYd27BEU7qan7fVN+fnOv6C2U+AOaTAWdf0fmdwiM8CiFfTPBxPTkhq
         QNNxdAvT9eFJOTOUkLo20OnxxUkcFpDK1nkVompo6VY0LjkM4fdxy1rVDMIgpgrqEVqp
         z1XkpRLLCXSN0b4OiY4cCnSt9D4kzdw82BQ2hDbWNO/fJArW+GagF1Yt1ToxAuS5/mI/
         hbjCBKrUsTlswXx6uvbITn7Ya+hk7ZwToyH0tQNcHNCtm7hRD9+/LYL7FqRSEIu33CbE
         GCWTkotLSitGts0yrDMWqFl20fT5IpWACpGRbV5tIYAS+/HryAGsEcmqiwyIw2RvvCzj
         y1sw==
X-Gm-Message-State: ABy/qLbF822BRM1FMCRO+QAUQlfBzv3Bf1csrQErlJAwrzBpYvCQT78t
        nEjwiFdct5hyihHaBAEeg8xcXg==
X-Google-Smtp-Source: APBJJlHjSZhzcSxXjiOPVSwvNw3AfG2kOjO024Ri9E7Ji/WRfODTBuXMu9V/vShqT5QR7KrOwOjXvg==
X-Received: by 2002:adf:dd92:0:b0:314:53a4:42a5 with SMTP id x18-20020adfdd92000000b0031453a442a5mr5247095wrl.51.1688788741411;
        Fri, 07 Jul 2023 20:59:01 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.246])
        by smtp.gmail.com with ESMTPSA id i4-20020adfefc4000000b003143be36d99sm5915882wrp.58.2023.07.07.20.58.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jul 2023 20:59:00 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [External] [PATCH v3 0/4] Obtain SMBIOS and ACPI entry from FFI
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CAEEQ3wnhCRnDsa2Un=J_VOo2JZqf0nMXX11okqpyhMbLAWsKJQ@mail.gmail.com>
Date:   Sat, 8 Jul 2023 04:58:49 +0100
Cc:     Dong Wei <Dong.Wei@arm.com>, Conor Dooley <conor@kernel.org>,
        =?utf-8?B?6JGb5aOr5bu6?= <geshijian@bytedance.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        ron minnich <rminnich@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <9F6A932E-6FFE-4CF1-BF20-D5D80AC26F37@jrtc27.com>
References: <CAMj1kXFZren0Q19DimwQaETCLz64D4bZQC5B2N=i3SAWHygkTQ@mail.gmail.com>
 <mhng-b66b085a-eb15-4c9b-b2aa-93ddf16ec7aa@palmer-ri-x1c9a>
 <CAP6exYKwZG=_47r0jAUFYNL5-P-SS==k6vWdKiMJ9nB0upH5Zw@mail.gmail.com>
 <20230707-attach-conjuror-306d967347ce@wendy> <ZKfsSsdiso0W8mW6@sunil-laptop>
 <CAN3iYbMhQU5Ng4r6_rQDnLmit1GCmheC5T49rsUP5NgHFEXsHA@mail.gmail.com>
 <ZKgLKvBoWKSxzm6r@sunil-laptop>
 <CAN3iYbOe+i4jVhz0sSQwVQ2PMB7UvaTPyN_sLtZj0uiOD2emDA@mail.gmail.com>
 <20230707-gargle-enjoyable-f9f7f87fc7ea@spud>
 <DBAPR08MB57836AE63A1F5D3902B95BFE9C2DA@DBAPR08MB5783.eurprd08.prod.outlook.com>
 <CAEEQ3wnhCRnDsa2Un=J_VOo2JZqf0nMXX11okqpyhMbLAWsKJQ@mail.gmail.com>
To:     =?utf-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Jul 2023, at 04:22, =E8=BF=90=E8=BE=89=E5=B4=94 =
<cuiyunhui@bytedance.com> wrote:
>=20
> Hey,
>=20
> On Sat, Jul 8, 2023 at 12:39=E2=80=AFAM Dong Wei <Dong.Wei@arm.com> =
wrote:
>>=20
>>=20
>>=20
>>> I don't think that's the limitation on RISC-V. BTW, how does OSPM =
find the
>>=20
>>> RSDP on ARM systems? Does it meet 5.2.5?
>>=20
>>>=20
>>=20
>>=20
>>=20
>> On Arm systems today, the ACPI RSDP is found using the UEFI =
Configuration Table. This is true for all Arm SystemReady compliant =
systems: 1) SystemReady LS: LBBRv1 is using a minimal UEFI FW to load =
LinuxBoot, that minimal UEFI FW is producing the UEFI Configuration =
Table. We are working on LBBRv2. LBBRv2 is based on Coreboot loading =
LinuxBoot. But we do not have a way today to get CoreBoot to produce =
this pointer to ACPI RSDP. Arm does not support x86 E820 BIOS interface. =
2) SystemReady IR: this solution uses DT rather than ACPI. 3) =
SystemReady ES: this solution can use UBoot or EDK2, and it requires =
ACPI. Since both UBoot and EDK2 support UEFI now, so ACPI RSDP can be =
found using the UEFI Configuration Table. 4) SystemReady SR: this =
solution typically uses EDK2 and requires ACPI, so no issue finding RSDP =
via UEFI Configuration Table.
>=20
> Looks like ARM has a similar problem,

If by =E2=80=9Cproblem=E2=80=9D you mean =E2=80=9Cthere=E2=80=99s only =
one standard that I=E2=80=99m choosing
to not follow=E2=80=9D.

> Indeed, as Ron said, many companies may encounter this issue. More
> developers are embracing Coreboot. When the platform guided by
> Coreboot requires ACPI support, they are faced with how to pass ACPI
> RSDP to Linux.

It=E2=80=99s called UEFI. EBBR=E2=80=99s requirements are pretty =
minimal.

Please just follow the one standard. Having one standard is good for
compatibility; there needs to be a very good reason beyond =E2=80=9CI =
don=E2=80=99t
like the standard=E2=80=9D to introduce a competing one and the =
fragmentation
that results from it that becomes shared pain for the ecosystem.

Jess

>> So the ACPI RSDP issue only exist if we want to remove the minimum =
UEFI FW and go to CoreBoot completely to load LinuxBoot. We are =
currently exploring how to solve that issue=E2=80=A6
>>=20
>>=20
>>=20
>> -DW
>>=20
>>=20
>>=20
>> IMPORTANT NOTICE: The contents of this email and any attachments are =
confidential and may also be privileged. If you are not the intended =
recipient, please notify the sender immediately and do not disclose the =
contents to any other person, use it for any purpose, or store or copy =
the information in any medium. Thank you.
>=20
> Thanks,
> Yunhui


