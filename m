Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A402773D123
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 15:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjFYNNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 09:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFYNNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 09:13:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3751B7;
        Sun, 25 Jun 2023 06:13:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9E6C60B78;
        Sun, 25 Jun 2023 13:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BCF4C433CA;
        Sun, 25 Jun 2023 13:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687698788;
        bh=E+xepwben9vqxAh0oSk1MlseE+MhedOdYTv6e9aA7FU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MCqUd8FyjNonX9AA/C/BD2o2X2EyBBK07rB0wyj98n3Xw0qKiIgHa4HwaA19zSTPM
         LN3Hczxs+AFxKMtEVIK3rMHtGST1itZio1Nzz/MmHr0XCQrXZmsfUDqOJCXFZ8EkLy
         M7WWW7MMZJnVw7NY0BNQ1/eez0O7a0ZO6Gb2315bAh/k02nXT+/54bBO7mz22JyBjL
         zSsk3lJNhkWSoxqiFeJM9SEHxf3hPEgPAIdRIKAYXy+IMYwzY4wsNbrzeh2mMTW53l
         nVJQOVWwLujJYJ2ZCwj5/UUPEEt7veshFeHEzDUtQn0zbmSdDgq1/3Lyp7aFjxehXt
         34vH6xQSynfug==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4f86fbe5e4fso2725884e87.2;
        Sun, 25 Jun 2023 06:13:08 -0700 (PDT)
X-Gm-Message-State: AC+VfDxmq7oJFff9kezs56kKHSzYz5SB3a4ZMcGQDKWHH6T5pSH0+Wfw
        Ni6SyRW4CKwHLRU6Y7lQY9RysMXT5nOQbKgDixs=
X-Google-Smtp-Source: ACHHUZ4woVCWkdRrVMb4YhVeBsGxJk2OBo23Ltdllvk7lT6dJrxYSIquMXFrgzmzVA4zNTMR6xybFJnQWMcSbRSDvww=
X-Received: by 2002:a05:6512:2825:b0:4fa:9dc3:1d41 with SMTP id
 cf37-20020a056512282500b004fa9dc31d41mr925670lfb.51.1687698786295; Sun, 25
 Jun 2023 06:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230426034001.16-1-cuiyunhui@bytedance.com> <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
 <CAEEQ3wkJB5CKm33mHXUOPX5makYOHF8By6FYGnNzRkM-Mo72OQ@mail.gmail.com>
 <ZEj33QLZqEeL+/y4@FVFF77S0Q05N> <CAEEQ3wmDBJkfOeKCQfcnuE+1=1K0D2pzu+Sn+zPEWk+RHs0NFQ@mail.gmail.com>
 <CAP6exY+ydbzh1EkWTFejzwaW+PA-ySVO2Qj+CVJ1XbSMce2S9Q@mail.gmail.com>
 <CAP6exY+tqAU0j1TVEMTzTb18M6_mPH5bWWiAS=94gyDGTY3hyQ@mail.gmail.com>
 <CAEEQ3w=wBdpZWnUd2WWVBC3BtFiUp-PQtNAtdXE4cO4n0XT-fg@mail.gmail.com>
 <CAMj1kXFGpXEPtYpy1+bs13F2P_LLZf9rTMfYMU=6jzgd3=SEcw@mail.gmail.com>
 <CAEEQ3wnbXE0vJnQRLo5MhfDc-Q4PbNWBoWS-oMn71CcJU51JdA@mail.gmail.com>
 <CAMj1kXHfqkU2QxvjTkGBSkEcTf_HirbdOReOJwdpgz3hM8fBHw@mail.gmail.com> <CAEEQ3wn2n48TpNQ3MuvrRH4zzg28SaiOswunPeZ01jFm-TbJ5w@mail.gmail.com>
In-Reply-To: <CAEEQ3wn2n48TpNQ3MuvrRH4zzg28SaiOswunPeZ01jFm-TbJ5w@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 25 Jun 2023 15:12:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHgaLD43jx0f6hn_j209LGT_4G+w5XEGaYB9znV5p9tdA@mail.gmail.com>
Message-ID: <CAMj1kXHgaLD43jx0f6hn_j209LGT_4G+w5XEGaYB9znV5p9tdA@mail.gmail.com>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2023 at 13:54, =E8=BF=90=E8=BE=89=E5=B4=94 <cuiyunhui@byteda=
nce.com> wrote:
>
> Hi Ard,
>
> On Sun, Jun 25, 2023 at 3:43=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > acpi_os_ioremap() is used by all ACPI core code that needs to map MMIO
> > regions or DRAM from AML code. AML does not pass memory type
> > attributes, so we have to consult the EFI memory map for these.
> >
> > As I have explained to you multiple times, ACPI on arm64 is *broken*
> > without the EFI memory map.
> >
>
> As Ron's suggested:
> "...
> It would be nice to separate those pieces on RISC-V; certainly they
> were separate for a very long time in the x86 world (we had ACPI+SMM
> on coreboot laptops without UEFI for example)
> ...
> "
>
> If it cannot be solved temporarily on arm64, then we cannot let it
> continue to be bound in RISC-V.
> And on the linux-next branch, RISC-V arch is not bound to EFI.
> void *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
> {
>         return memremap(phys, size, MEMREMAP_WB);
> }
>
>
>
> >
> > Incorrect. We are talking about any physical region here, not just
> > DRAM. And some DRAM regions may not be covered by memblock.
> >
> It is very strange that so many devices can complete the hardware
> description through DTS without the problem you mentioned.
> Even if there is, then it shouldn't be the problem that this patch
> should solve, should it?
>
> > No, sorry. Please try to understand the objections that I am raising
> > first. I am not saying this to annoy you, I am saying this because
> > your approach is flawed.
>
> The implementation is right in front of us, we need to support ACPI on
> RISC-V based on coreboot.
>

If this is only used on RISC-V, and implemented under arch/riscv, I
have no objections.
