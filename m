Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC4973DC1A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjFZKUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFZKT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:19:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA6319A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 03:19:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3113dabc549so4672665f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 03:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687774795; x=1690366795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dsFv4FgmnPd67WQkT8yMKl3a2nj9aCiexx+yXgesZ4=;
        b=KZ5sT0LEQJcO8YZzBdW2ecUYfzYHVnA1IABWN1LZqFzx0in22M2xIMLMoifEmB+aqw
         6wphw8n3AxBQFjTofDyuAq4+kdX4oogbTaFzjzcTTKcYTUiGoX5c1aMVaxGzlzlINWFQ
         Xhr2gz39JeOU48jJnQPsE4rSFeT4GctvyVchE9ja8FJU18O0mLswIWkTjAg/PU3nQ87g
         8+yXWB4P4gLxADJR2Y/5Hvvc6iZMitWRfhn+ykRFv2jsJWRNA5AU+SBsFRHrCP2POhoc
         5ZxfDSl8FGJlkXVDSK6KZ1ZbkfHk3I+g/ZeDg4obCjnpOXOdEaMaFM0YxJLZSN4/jxZP
         4VcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687774795; x=1690366795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dsFv4FgmnPd67WQkT8yMKl3a2nj9aCiexx+yXgesZ4=;
        b=gLcKg14xC5eoMvAkwIbLzX2/LETN3tv9bDSCE1/K3xXgIZOzl4+N3r2ZHHhBkjXkEU
         7SjYtfE6qq769xIrYFHu48t4fTYy3oLiQ6W6z/O+fF5UH8LSSYEzfIjykTb8OPZQ2SKD
         dDgnF7/QdNXh8eYElzrUSGqzhy1cHV/6o/1hFTC2uMXxMbMVCpyFEkxVlDnPEUvE50ft
         WTXgHJIalRikB96Bi345H+AMSDSxCFTUu0nLj1vOG3xfzsk9OPujxTdZeP1riIM9KEwg
         7ZHyTQFBRdFfdzqJq2XqOJms7Uqz8VaJ0vL4KP/xYSSo9D4ENjqmeEf9xgRx6hvOOdfA
         Ke7A==
X-Gm-Message-State: AC+VfDyo7m3/B/Ue2dHBsDVwP2QYNz9QaVmdmLnNxPdHbR4ZQxOctqMJ
        G0fcc5PBf5zL5kZl4mjttAN5T7dA8gb5J9Vo083iog==
X-Google-Smtp-Source: ACHHUZ7ehgoJaNj3F/jvPTcPeopXCTLJyYdmxpl36jAl+iaG9d8+PXf4o/K+qOyYWSp5lpS2ZqUDS3jFH+SG/GqE/Js=
X-Received: by 2002:a5d:62d2:0:b0:313:e8f9:dbfa with SMTP id
 o18-20020a5d62d2000000b00313e8f9dbfamr6753622wrv.35.1687774795509; Mon, 26
 Jun 2023 03:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230426034001.16-1-cuiyunhui@bytedance.com> <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
 <CAEEQ3wkJB5CKm33mHXUOPX5makYOHF8By6FYGnNzRkM-Mo72OQ@mail.gmail.com>
 <ZEj33QLZqEeL+/y4@FVFF77S0Q05N> <CAEEQ3wmDBJkfOeKCQfcnuE+1=1K0D2pzu+Sn+zPEWk+RHs0NFQ@mail.gmail.com>
 <CAP6exY+ydbzh1EkWTFejzwaW+PA-ySVO2Qj+CVJ1XbSMce2S9Q@mail.gmail.com>
 <CAP6exY+tqAU0j1TVEMTzTb18M6_mPH5bWWiAS=94gyDGTY3hyQ@mail.gmail.com>
 <CAEEQ3w=wBdpZWnUd2WWVBC3BtFiUp-PQtNAtdXE4cO4n0XT-fg@mail.gmail.com>
 <CAMj1kXFGpXEPtYpy1+bs13F2P_LLZf9rTMfYMU=6jzgd3=SEcw@mail.gmail.com>
 <CAEEQ3wnbXE0vJnQRLo5MhfDc-Q4PbNWBoWS-oMn71CcJU51JdA@mail.gmail.com>
 <CAMj1kXHfqkU2QxvjTkGBSkEcTf_HirbdOReOJwdpgz3hM8fBHw@mail.gmail.com>
 <CAEEQ3wn2n48TpNQ3MuvrRH4zzg28SaiOswunPeZ01jFm-TbJ5w@mail.gmail.com>
 <CAMj1kXHgaLD43jx0f6hn_j209LGT_4G+w5XEGaYB9znV5p9tdA@mail.gmail.com>
 <CAP6exYJRE8iM63SX3hQP9_5aKYcnN5x0KOAtZOgeEWU5bwLEBA@mail.gmail.com>
 <CAEEQ3wn2zHUZP8gs8ezCczQLdQJqU6MqAgpcG0YeDW2aYTz0TA@mail.gmail.com>
 <CAMj1kXFn7+W=ZGNcSLL6p383SbA8=wstutJ85+qvXzt2G66Seg@mail.gmail.com>
 <CAEEQ3wnXJVBLdqW6GRFuCKuBtr38uKHz7E2+P8TAv1_+b6kBKA@mail.gmail.com> <CAMj1kXFAsG0nH+2OcG3CBZYqKg=hCRHp8wAmVBFy9vNx6rWgOQ@mail.gmail.com>
In-Reply-To: <CAMj1kXFAsG0nH+2OcG3CBZYqKg=hCRHp8wAmVBFy9vNx6rWgOQ@mail.gmail.com>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Mon, 26 Jun 2023 18:19:44 +0800
Message-ID: <CAEEQ3wkT_2GbdsjfA_VA+LeyCzdeQ+Bh+admyVjz7rE3cSWSxA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] firmware: added a firmware information
 passing method FFI
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     ron minnich <rminnich@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        =?UTF-8?B?6JGb5aOr5bu6?= <geshijian@bytedance.com>,
        =?UTF-8?B?6Z+m5Lic?= <weidong.wd@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard, Mark,

On Mon, Jun 26, 2023 at 4:23=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:

> DT support for SMBIOS can live in generic code, but the binding has to
> be sane. As I suggested before, it probably makes sense to supplant
> the entrypoint rather than just carry its address - this means a 'reg'
> property with base and size to describe the physical region, and at
> least major/minor/docrev fields to describe the version.

Regarding dts node binding, our current definition is as follows:
/dts
{
...
cfgtables {
acpi_phy_ptr =3D 0000000000000000; //u64
smbios_phy_ptr =3D 0000000000000000; //u64
...
}
...
}

x86 only gave a root_pointer entry address
u64 x86_default_get_root_pointer(void)
{
       return boot_params.acpi_rsdp_addr;
}

Regarding the naming of the binding above, Mark,  do you have any suggestio=
ns?


> For the ACPI side, you should just implement
> acpi_arch_get_root_pointer() under arch/riscv, and wire it up in
> whichever way you want. But please check with the RISC-V maintainers
> if they are up for this, and whether they want to see this mechanism
> contributed to one of the pertinent specifications.

You suggest putting SMBIOS in general code instead of ACPI, why?
From the perspective of firmware information passing, they are a class.

SMBIOS and ACPI are not related to ARCH, nor is DTS to obtain firmware
information,

Why do you have to put part of the ACPI code under arch/risc-v/?
The scope of the previous discussion was limited to RISC-V because of
historical reasons such as the binding with EFI on ARM64. We will only
enable this function on RISC-V in subsequent patches.

The realization of the FFI scheme itself is irrelevant to the arch.

Thanks=EF=BC=8C
Yunhui
