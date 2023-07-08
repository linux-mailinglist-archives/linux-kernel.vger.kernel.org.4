Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A541074BB8E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 05:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjGHDXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 23:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjGHDXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 23:23:13 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011B51FD7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 20:23:10 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so2697933f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 20:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688786589; x=1691378589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVcl5w2h3dWfxQlDZL0LIXyDZOTXizZNDdgurU3+buU=;
        b=YgLpkhZDqmuma2NsCUCmSNhnrdRc5oCcYqmI6DQU9CbkpN846OoU+pxyfx2ahevaNL
         0aMcsIxAQ6DkKB6UwJjNqZVoffATZ5iGkd5OoSwbjszPcepXweZ8cvitXITqVqgFX0y8
         CETCMF9b6MxaFALpCfumKoEXp9r21GUIg6nARQFSk76wQgdPNIYFeyp5Nm9UN6e7ZP/w
         jpHC3kSDsPH2EW8cSwM8TELKrZKPFoZpMUN+ioB3S12ldy0rHevr9mn9Hhc+kUFeW/X7
         vaB3QGWCnwM9fTLrrBZGSvgzqBYgitTPUq5fAJarWifVqHPN09ICbi7CpBnZNFdgdmus
         cz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688786589; x=1691378589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVcl5w2h3dWfxQlDZL0LIXyDZOTXizZNDdgurU3+buU=;
        b=CLDU+eZ3sXmaCFRMu//u+U3rtkwSEeKbOOWkzqNH8EPELc9VAD3yGDsYPELDkxr3yO
         huif+pDs2Z/NZfahqTxH4hPLzwJoqth45Q7j1hMiw4P5OW935ZkVx4Gqa4I8r14haiaC
         8IirK25v8rUE/DblpNE9Nzyp81Awpms5fK+x/5Pf6qiw2c5pWWroOYNngdX38yyyj6Oj
         RqD+Jaa/owIzCS7QxhfMNAomilpaULSgRPKiS7Cio52+mcdgVvWzDVo6OohT8+aF10Eo
         EKez3iVI+wep0vAg5mn3efGl8dKZ3NhTLYJIGil9IRSV3RUA0yursKBtZIuhIPFin36Z
         NZUA==
X-Gm-Message-State: ABy/qLaYgAHG6Wzv1PCzSjLhJhF9kXdmPR4Iak7IQatu0jq/6ZZxtItz
        BV+8c1laLMrHK3VWhaFDoOhzLwD0UjUih5mCR9QLMg==
X-Google-Smtp-Source: APBJJlGvIQje+MQfTdFy2c7xy0g+6AgrWcXwe3yPeDBQ2jC//QkTktkFaCqeFPUoo3C5dfpD7qkn48ITWlg/4nqSMgA=
X-Received: by 2002:a5d:4d8e:0:b0:314:3e77:f210 with SMTP id
 b14-20020a5d4d8e000000b003143e77f210mr5218578wru.59.1688786589423; Fri, 07
 Jul 2023 20:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXFZren0Q19DimwQaETCLz64D4bZQC5B2N=i3SAWHygkTQ@mail.gmail.com>
 <mhng-b66b085a-eb15-4c9b-b2aa-93ddf16ec7aa@palmer-ri-x1c9a>
 <CAP6exYKwZG=_47r0jAUFYNL5-P-SS==k6vWdKiMJ9nB0upH5Zw@mail.gmail.com>
 <20230707-attach-conjuror-306d967347ce@wendy> <ZKfsSsdiso0W8mW6@sunil-laptop>
 <CAN3iYbMhQU5Ng4r6_rQDnLmit1GCmheC5T49rsUP5NgHFEXsHA@mail.gmail.com>
 <ZKgLKvBoWKSxzm6r@sunil-laptop> <CAN3iYbOe+i4jVhz0sSQwVQ2PMB7UvaTPyN_sLtZj0uiOD2emDA@mail.gmail.com>
 <20230707-gargle-enjoyable-f9f7f87fc7ea@spud> <DBAPR08MB57836AE63A1F5D3902B95BFE9C2DA@DBAPR08MB5783.eurprd08.prod.outlook.com>
In-Reply-To: <DBAPR08MB57836AE63A1F5D3902B95BFE9C2DA@DBAPR08MB5783.eurprd08.prod.outlook.com>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Sat, 8 Jul 2023 11:22:58 +0800
Message-ID: <CAEEQ3wnhCRnDsa2Un=J_VOo2JZqf0nMXX11okqpyhMbLAWsKJQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 0/4] Obtain SMBIOS and ACPI entry from FFI
To:     Dong Wei <Dong.Wei@arm.com>
Cc:     Conor Dooley <conor@kernel.org>,
        =?UTF-8?B?6JGb5aOr5bu6?= <geshijian@bytedance.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        ron minnich <rminnich@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On Sat, Jul 8, 2023 at 12:39=E2=80=AFAM Dong Wei <Dong.Wei@arm.com> wrote:
>
>
>
> > I don't think that's the limitation on RISC-V. BTW, how does OSPM find =
the
>
> > RSDP on ARM systems? Does it meet 5.2.5?
>
> >
>
>
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

Looks like ARM has a similar problem,
Indeed, as Ron said, many companies may encounter this issue. More
developers are embracing Coreboot. When the platform guided by
Coreboot requires ACPI support, they are faced with how to pass ACPI
RSDP to Linux.

>
>
> So the ACPI RSDP issue only exist if we want to remove the minimum UEFI F=
W and go to CoreBoot completely to load LinuxBoot. We are currently explori=
ng how to solve that issue=E2=80=A6
>
>
>
> -DW
>
>
>
> IMPORTANT NOTICE: The contents of this email and any attachments are conf=
idential and may also be privileged. If you are not the intended recipient,=
 please notify the sender immediately and do not disclose the contents to a=
ny other person, use it for any purpose, or store or copy the information i=
n any medium. Thank you.

Thanks,
Yunhui
