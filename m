Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFCE73F911
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjF0Juz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjF0Juo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:50:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88242720;
        Tue, 27 Jun 2023 02:50:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C701E61090;
        Tue, 27 Jun 2023 09:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F74C4339A;
        Tue, 27 Jun 2023 09:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687859436;
        bh=GFjEtbcDTN8Gj6F61Z5J4CnRI2yWhEjnhaExEl2QQt4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mpvKAggZdcKqUinySEXJb2l8o87xhQH5+AEjcZKuMLX/Ew7ozKVZH8a6z7RIEu9qm
         OPiVma+XkbALTG59O5dnXT6NxK2ZDyZEavDo3gF0BQllRf29b5SAVUxbq1C84wLjHg
         hR7ov2m3WfClJNalzdUL38GPeeXiKBTI1ePxJ/+LfJnaUYYUHIJE0PW5w2sQG6raP2
         9m61CDYZrE1tKADK5cLGy5gaFPFBjnsaD3XhbLCTzgplVZ6+cAfZTqinLn+q5CCwLq
         Y+NbAfhFLxKEkQV+1Uf5DisI3HM/Ae4qoemlnt0kx15MOvgRRJehZW9t6D0sV/cGRD
         xX+t4bUT3DHsg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4f86dbce369so5760003e87.0;
        Tue, 27 Jun 2023 02:50:36 -0700 (PDT)
X-Gm-Message-State: AC+VfDytn76aUI2L2uyFfy8NdAOCKN+l/bJrQzgFFkPokgD+Tj0w6JhF
        ASp6dx9ICRxeLcU0jty+ivOa6gpjgohD8MPv0Us=
X-Google-Smtp-Source: ACHHUZ7HHGQJGU4j426QvpbyJvV5wc5YtrVrrBnwcEfMU/9RDmdooc9pB9TdUeU2Mf+9InL4PWDiJbIGNVh0G5MvEFM=
X-Received: by 2002:a05:6512:6cc:b0:4fb:7675:1ff9 with SMTP id
 u12-20020a05651206cc00b004fb76751ff9mr3473299lff.9.1687859434057; Tue, 27 Jun
 2023 02:50:34 -0700 (PDT)
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
 <CAEEQ3wnXJVBLdqW6GRFuCKuBtr38uKHz7E2+P8TAv1_+b6kBKA@mail.gmail.com>
 <CAMj1kXFAsG0nH+2OcG3CBZYqKg=hCRHp8wAmVBFy9vNx6rWgOQ@mail.gmail.com> <CAEEQ3wkT_2GbdsjfA_VA+LeyCzdeQ+Bh+admyVjz7rE3cSWSxA@mail.gmail.com>
In-Reply-To: <CAEEQ3wkT_2GbdsjfA_VA+LeyCzdeQ+Bh+admyVjz7rE3cSWSxA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 27 Jun 2023 11:50:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGT04HeMqmr7BWYaNQM6jYzYFLGEJY7TNtig-t48n7CLg@mail.gmail.com>
Message-ID: <CAMj1kXGT04HeMqmr7BWYaNQM6jYzYFLGEJY7TNtig-t48n7CLg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] firmware: added a firmware information
 passing method FFI
To:     =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc RISC-V maintainers and mailing list)

On Mon, 26 Jun 2023 at 12:20, =E8=BF=90=E8=BE=89=E5=B4=94 <cuiyunhui@byteda=
nce.com> wrote:
>
> Hi Ard, Mark,
>
> On Mon, Jun 26, 2023 at 4:23=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> =
wrote:
>
> > DT support for SMBIOS can live in generic code, but the binding has to
> > be sane. As I suggested before, it probably makes sense to supplant
> > the entrypoint rather than just carry its address - this means a 'reg'
> > property with base and size to describe the physical region, and at
> > least major/minor/docrev fields to describe the version.
>
> Regarding dts node binding, our current definition is as follows:
> /dts
> {
> ...
> cfgtables {
> acpi_phy_ptr =3D 0000000000000000; //u64
> smbios_phy_ptr =3D 0000000000000000; //u64
> ...
> }
> ...
> }
>
> x86 only gave a root_pointer entry address
> u64 x86_default_get_root_pointer(void)
> {
>        return boot_params.acpi_rsdp_addr;
> }
>
> Regarding the naming of the binding above, Mark,  do you have any suggest=
ions?
>

I will defer to Mark or other DT experts to help decide on the naming
and general shape of these.

However, as I have indicated twice now, it would be better to describe
the SMBIOS structured data directly, instead of passing the physical
address of one of the existing entry points. This avoids the need for
mapping and reserving additional pages that don't carry any relevant
information.

So the node in question should have at least (base, size) and the
major, minor and docrev version fields.

>
> > For the ACPI side, you should just implement
> > acpi_arch_get_root_pointer() under arch/riscv, and wire it up in
> > whichever way you want. But please check with the RISC-V maintainers
> > if they are up for this, and whether they want to see this mechanism
> > contributed to one of the pertinent specifications.
>
> You suggest putting SMBIOS in general code instead of ACPI, why?

SMBIOS is a separate set of firmware tables that have little
significance to the kernel itself, and describing it via DT makes
sense.

ACPI serves a similar purpose as DT, and so having both at the same
time results in a maintenance burden, where the arch code is forced to
reason about whether they are consistent with each other, and if not,
which description has precedence.

> From the perspective of firmware information passing, they are a class.
>
> SMBIOS and ACPI are not related to ARCH, nor is DTS to obtain firmware
> information,
>
> Why do you have to put part of the ACPI code under arch/risc-v/?

Yes. And I don't think it should be using this FFI scheme either.

If the firmware uses DT as a conduit to deliver the ACPI system
description to the OS, it is probably better to pass this via the
/chosen node as a special boot argument.

> The scope of the previous discussion was limited to RISC-V because of
> historical reasons such as the binding with EFI on ARM64. We will only
> enable this function on RISC-V in subsequent patches.
>
> The realization of the FFI scheme itself is irrelevant to the arch.
>

I don't think we need a FFI scheme or framework for this.
