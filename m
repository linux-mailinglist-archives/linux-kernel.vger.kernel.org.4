Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6259645294
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 04:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiLGDfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 22:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLGDfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 22:35:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA4E554F4;
        Tue,  6 Dec 2022 19:35:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEF7FB81CB3;
        Wed,  7 Dec 2022 03:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901C1C4314A;
        Wed,  7 Dec 2022 03:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670384111;
        bh=jjhc7Y1PVNMbgXEZgFw82tejJpkbGa48gUtRIhqm8SI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sFjMYSBw4IZv/8gm4iYTF/aCs9nLblf2mR+O3NMHxTWtyBxz3f5f7Vpza89wVr6Bh
         srnuUIHlfx7Ld3vsjvQ0HR0VFSudqD2gqs/5ggcBw1XA0vmmLxYCWzXPJkA3BV1V9f
         9bhdMqr7ug6AaB0nT86eYEeHZxgiI7gdwk7jjh+dU2FDsV5Ei45CI6lslHozk7Pjk5
         2HDA4tSvGgUsrCvXD1ShO4jUimDzI4R4InZYAdbot/F+GPwCRjCpH+yBG9lRrNXz11
         cKSKwBSfrUOGUyqzHlRC4iJKu4uTjN8SbKyIv0dm2WR3Eqd5k+9jvlg5y8+RWfcaYJ
         SyM+f5Pa0GOVg==
Received: by mail-ed1-f51.google.com with SMTP id v8so23159516edi.3;
        Tue, 06 Dec 2022 19:35:11 -0800 (PST)
X-Gm-Message-State: ANoB5pk+o+SLjcaJa/LtVp1LpSVWyZvJE5BJO/juleCS5/7uh+fudWeX
        4bi+ewBlXtMKVKKa/EOgRSDIoAdmsoap3oEP+B4=
X-Google-Smtp-Source: AA0mqf6K2XjutXe3T4psbIGhFvGGoXKLPBc10tnHpjB5dxtXJMy3RO1253LIGiKiiGgrtRQQ1/MZOUormc7bxIVFcVs=
X-Received: by 2002:a05:6402:538a:b0:458:fbd9:e3b1 with SMTP id
 ew10-20020a056402538a00b00458fbd9e3b1mr23895842edb.6.1670384109611; Tue, 06
 Dec 2022 19:35:09 -0800 (PST)
MIME-Version: 1.0
References: <20221026144208.373504-1-xianting.tian@linux.alibaba.com>
 <167002857934.4256.16584443879212253129.b4-ty@rivosinc.com> <Y4/KoiFhdvRBDdzH@spud>
In-Reply-To: <Y4/KoiFhdvRBDdzH@spud>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 7 Dec 2022 11:34:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQX6361ME9UkOykvUEQifqioLMqovbfpqugkk174pKqfA@mail.gmail.com>
Message-ID: <CAJF2gTQX6361ME9UkOykvUEQifqioLMqovbfpqugkk174pKqfA@mail.gmail.com>
Subject: Re: [PATCH V5 0/2] Support VMCOREINFO export for RISCV64
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        mick@ics.forth.gr, corbet@lwn.net, alexandre.ghiti@canonical.com,
        vgoyal@redhat.com, bhe@redhat.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        bagasdotme@gmail.com, dyoung@redhat.com,
        Palmer Dabbelt <palmer@dabbelt.com>, heiko@sntech.de,
        anup@brainfault.org, aou@eecs.berkeley.edu,
        hschauhan@nulltrace.org, yixun.lan@gmail.com,
        kexec@lists.infradead.org, heinrich.schuchardt@canonical.com,
        linux-doc@vger.kernel.org, crash-utility@redhat.com,
        linux-kernel@vger.kernel.org, k-hagio-ab@nec.com,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 7:05 AM Conor Dooley <conor@kernel.org> wrote:
>
> Hey Palmer, Xianting,
>
> On Fri, Dec 02, 2022 at 04:49:39PM -0800, Palmer Dabbelt wrote:
> > On Wed, 26 Oct 2022 22:42:06 +0800, Xianting Tian wrote:
> > > As disscussed in below patch set, the patch of 'describe VMCOREINFO export in Documentation'
> > > need to update according to Bagas's comments.
> > > https://lore.kernel.org/linux-riscv/22AAF52E-8CC8-4D11-99CB-88DE4D113444@kernel.org/
> > >
> > > As others patches in above patch set already applied, so this patch set only contains below two
> > > patches.
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
> >       https://git.kernel.org/palmer/c/649d6b1019a2
>
> So this patch seems to be causing issues for the nommu build:
> https://lore.kernel.org/oe-kbuild-all/202212062250.tR0otHcz-lkp@intel.com/
>
> I had a bit of a poke at trying to see if there were some headers we
> could pull in before actually checking the .config only to see:
> # CONFIG_MMU is not set
>
> Do we have to wrap the whole thing in a `#ifdef CONFIG_MMU` to fix
> compilation here?
The problem does not belong to the patch.

Could I send a fixup patch? like this?

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ef8d66de5f38..d8c07999426c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -512,6 +512,7 @@ config ARCH_HAS_KEXEC_PURGATORY

 config CRASH_DUMP
        bool "Build kdump crash kernel"
+       depends on KEXEC
        help
          Generate crash dump after being started by kexec. This should
          be normally only set in special crash dump kernels which are

>
> Thanks,
> Conor.
>


-- 
Best Regards
 Guo Ren
