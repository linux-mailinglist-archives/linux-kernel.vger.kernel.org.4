Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CED73CF04
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 09:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjFYHnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 03:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjFYHnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 03:43:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990EDE41;
        Sun, 25 Jun 2023 00:43:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26C2360AEA;
        Sun, 25 Jun 2023 07:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BE9C433CB;
        Sun, 25 Jun 2023 07:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687678981;
        bh=4DzQjtRxHneuL3eA2r6av4sEVPFoqc5qwVhZFZgqaeU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MrDdZOEhvqGDQDWb6fSnEHQ+PBLHIsXGWvJWiUuUcm9oGe+iGP4o/v79bSO9KkDkX
         715PEc049i+uB4HAmckAhbRCTgYxCihDGUNlAiPAst6b9jyZ9sXtY8nrEGU4tok8wQ
         h+BQheEcM3xUZNV2bhanXsgY1ieHWvbEY+MX6UyfkZgdVPwoXId5cmYt2W7I23Gx0c
         kkpCxEglrxVyRMnbftk8O9P+CmZx9QfGuDDV8RKmvdM1dJTHn7tJnp5U84NZFn4gNN
         Fn0magupgSLJ+0Ff6J35JzuVfIa5BLW0QWEIpaRwr1FkyX5z2LKBpdNcmhuj6dKUDI
         FpIkhUa5y7aKw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2b698371937so9094001fa.3;
        Sun, 25 Jun 2023 00:43:01 -0700 (PDT)
X-Gm-Message-State: AC+VfDzzkZHOH5KFPh9AS9ITjQXXKyxwopwxD3pjOXEsjxxj6sRkbSo4
        X+KQpLIAKBl9Pqs5TsywZS3UW0RtsEi/ILATKaQ=
X-Google-Smtp-Source: ACHHUZ7L/712puiotVPd/3SBIg0l3nWirCL+6Yipvm5Pu4eQ2pNlelysgCDL0tvRT+qS3EBSRcJrPR02BD414mzsGMg=
X-Received: by 2002:a05:6512:32b0:b0:4f8:5f19:4b4e with SMTP id
 q16-20020a05651232b000b004f85f194b4emr13456810lfe.51.1687678979428; Sun, 25
 Jun 2023 00:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230426034001.16-1-cuiyunhui@bytedance.com> <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
 <CAEEQ3wkJB5CKm33mHXUOPX5makYOHF8By6FYGnNzRkM-Mo72OQ@mail.gmail.com>
 <ZEj33QLZqEeL+/y4@FVFF77S0Q05N> <CAEEQ3wmDBJkfOeKCQfcnuE+1=1K0D2pzu+Sn+zPEWk+RHs0NFQ@mail.gmail.com>
 <CAP6exY+ydbzh1EkWTFejzwaW+PA-ySVO2Qj+CVJ1XbSMce2S9Q@mail.gmail.com>
 <CAP6exY+tqAU0j1TVEMTzTb18M6_mPH5bWWiAS=94gyDGTY3hyQ@mail.gmail.com>
 <CAEEQ3w=wBdpZWnUd2WWVBC3BtFiUp-PQtNAtdXE4cO4n0XT-fg@mail.gmail.com>
 <CAMj1kXFGpXEPtYpy1+bs13F2P_LLZf9rTMfYMU=6jzgd3=SEcw@mail.gmail.com> <CAEEQ3wnbXE0vJnQRLo5MhfDc-Q4PbNWBoWS-oMn71CcJU51JdA@mail.gmail.com>
In-Reply-To: <CAEEQ3wnbXE0vJnQRLo5MhfDc-Q4PbNWBoWS-oMn71CcJU51JdA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 25 Jun 2023 09:42:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHfqkU2QxvjTkGBSkEcTf_HirbdOReOJwdpgz3hM8fBHw@mail.gmail.com>
Message-ID: <CAMj1kXHfqkU2QxvjTkGBSkEcTf_HirbdOReOJwdpgz3hM8fBHw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] firmware: added a firmware information
 passing method FFI
To:     =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Cc:     ron minnich <rminnich@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
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

On Sun, 25 Jun 2023 at 09:33, =E8=BF=90=E8=BE=89=E5=B4=94 <cuiyunhui@byteda=
nce.com> wrote:
>
> Hi Ard,
>
> On Sat, Jun 24, 2023 at 8:52=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > How do you intend to provide the ACPI core with the memory attribute
> > information that it needs to access SystemMemory OpRegions?
>
> Regarding memory segments and attributes, our solution does not need
> to build a memmap table in coreboot like EFI to connect to linux ACPI
> core.
>

So how do you expect the code below will behave?

arch/arm64/kernel/acpi.c:
270:void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size siz=
e)
271-{
272-   efi_memory_desc_t *md, *region =3D NULL;
273-   pgprot_t prot;
274-
275-   if (WARN_ON_ONCE(!efi_enabled(EFI_MEMMAP)))
276-           return NULL;

acpi_os_ioremap() is used by all ACPI core code that needs to map MMIO
regions or DRAM from AML code. AML does not pass memory type
attributes, so we have to consult the EFI memory map for these.

As I have explained to you multiple times, ACPI on arm64 is *broken*
without the EFI memory map.

> Because the memory segment and attributes have been passed through the
> "memory" node and "reserved-memory" node attributes of DTS.
>
> For Linux, no matter what kind of memory attributes of the firmware,
> it is ultimately connected to the memblock module.
>

Incorrect. We are talking about any physical region here, not just
DRAM. And some DRAM regions may not be covered by memblock.

> So the memory attributes you consider can be done through the existing
> DTS (like Ron said before, Chrombook does everything through DTS).
>
> So can we come to a consensus? Then start reviewing the code?
>

No, sorry. Please try to understand the objections that I am raising
first. I am not saying this to annoy you, I am saying this because
your approach is flawed.
