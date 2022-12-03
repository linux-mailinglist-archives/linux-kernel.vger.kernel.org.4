Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E416414D4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 08:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiLCHxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 02:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiLCHxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 02:53:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D5D7E409;
        Fri,  2 Dec 2022 23:53:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 909ACB81092;
        Sat,  3 Dec 2022 07:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E44C4314A;
        Sat,  3 Dec 2022 07:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670054016;
        bh=v+fh+f5UA4ZMllDwmHzwUHLTYaB/xEbSJdsmYPmGyc8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Nak2BiuBVIBjFil7xWnOsIfDvMuVuJBsI472Ldeg2GUE7pcB1ArCRx7eg17HRgeYH
         0TGSX+xJK4awCHCe6gQSEX3j2UzrqNjRi+WQZCbGMK3fJhdTW5ZetIv07E21tMha2U
         6UDJKKUbjpDogCTeeBe8mjjKIulcgFe7rBucQyDR7ceVA5CzibAJIqRJEq5CkW7O4Z
         Re4JncxHC1G5WYvVoKHbleoOJmX1zGPA+LmjSHM93CvBr6hg4Qk1NyBMXJZjsmG09/
         pSt2yVCi6kyx2OrYWxRfzSX9vOcVVUy5isUUhh3UORRTsNcZPSZX0ATi7CElgwvdVO
         NHxKWR4GUo3YQ==
Received: by mail-ej1-f52.google.com with SMTP id bj12so16400695ejb.13;
        Fri, 02 Dec 2022 23:53:36 -0800 (PST)
X-Gm-Message-State: ANoB5pm6RS90cgtdAW/q5Y+pbM+j/xuHguaFWGImF8G/Vx2CzMO4eh90
        9P1AvexeMgcmXsOtb6cfugiWofcKsY3PB6+rY2w=
X-Google-Smtp-Source: AA0mqf5v7PsMXkly2t9Dyuk1Ofpw2XwAbMWTqS1nzBeDCH1bbzqPn4lCENo9DXWjvMuC+kBTe4Amiepcel2hKDVj6Iw=
X-Received: by 2002:a17:906:99d3:b0:78d:c7fd:f755 with SMTP id
 s19-20020a17090699d300b0078dc7fdf755mr6375844ejn.702.1670054014194; Fri, 02
 Dec 2022 23:53:34 -0800 (PST)
MIME-Version: 1.0
References: <20221026144208.373504-1-xianting.tian@linux.alibaba.com> <167002857934.4256.16584443879212253129.b4-ty@rivosinc.com>
In-Reply-To: <167002857934.4256.16584443879212253129.b4-ty@rivosinc.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 3 Dec 2022 15:53:21 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRYwiPUTZWgWHTS5_k4mJsY9ZivbY+PCRfEDpANKNHXTA@mail.gmail.com>
Message-ID: <CAJF2gTRYwiPUTZWgWHTS5_k4mJsY9ZivbY+PCRfEDpANKNHXTA@mail.gmail.com>
Subject: Re: [PATCH V5 0/2] Support VMCOREINFO export for RISCV64
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     mick@ics.forth.gr, corbet@lwn.net, alexandre.ghiti@canonical.com,
        vgoyal@redhat.com, bhe@redhat.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        bagasdotme@gmail.com, dyoung@redhat.com,
        Palmer Dabbelt <palmer@dabbelt.com>, heiko@sntech.de,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
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

Hi Palmer,

Here are another two fix-up patches of kdump for the crash tool.

https://lore.kernel.org/linux-riscv/20221020141603.2856206-3-guoren@kernel.org/
https://lore.kernel.org/linux-riscv/20221020141603.2856206-2-guoren@kernel.org/

On Sat, Dec 3, 2022 at 8:56 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> On Wed, 26 Oct 2022 22:42:06 +0800, Xianting Tian wrote:
> > As disscussed in below patch set, the patch of 'describe VMCOREINFO export in Documentation'
> > need to update according to Bagas's comments.
> > https://lore.kernel.org/linux-riscv/22AAF52E-8CC8-4D11-99CB-88DE4D113444@kernel.org/
> >
> > As others patches in above patch set already applied, so this patch set only contains below two
> > patches.
> >
> > [...]
>
> Applied, thanks!
>
> [1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
>       https://git.kernel.org/palmer/c/649d6b1019a2
> [2/2] Documentation: kdump: describe VMCOREINFO export for RISCV64
>       https://git.kernel.org/palmer/c/c5b4216929eb
>
> Best regards,
> --
> Palmer Dabbelt <palmer@rivosinc.com>



-- 
Best Regards
 Guo Ren
