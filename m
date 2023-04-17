Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D086E4B7A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjDQOat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDQOar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:30:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA6310C0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:30:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09BA0625FD
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65424C433EF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681741845;
        bh=/dSHVIj2jm0FvpvKTK7PhYg5O2oiOqCxENl9j3Mpo5A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HOJ6+K45kic3e83OKsUdwPNQR9ZGfxkPFUkrn/yY3Yt/WpxrdwZqePGTAHQf3MRYF
         Copd8gWdrqLsNElWrwHKNOumvgiz42kWiwBtFBiRjPH0r9ekqN48XW2sTbVOfEyS+m
         cbVP8XGa+SpCcoYgXiM3HBQCwte/E0u9wZpfhCR4U+Zv42p6VTkeaCdrdzEHRt7GLv
         ThV0cRpJBAhkX951WQSbVsxYdavvsgeB90/wpZOo3fyjtejxqWpzLiJsHQbOvmMoC6
         KluDTnqFZqjcRJNKRm8Np9xpKLM3K1C/Hp7sQstagl1bOBpfxkkwI2OzR4llpOxt0a
         6XeNDdjsEFSow==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4ec817060cdso1487438e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:30:45 -0700 (PDT)
X-Gm-Message-State: AAQBX9edE2kacxDJzWM55xOumOzHc+Xm9BFjMtO3wi5Z/rDV/G45frqe
        A+cGV87b3dtq6bTvbBBrlEErqvwMllzeQvuDZ/M=
X-Google-Smtp-Source: AKy350Y4B5WDHKcSD5KyHhdI2n0auFgqE4pOL4VPfVKggVfYkSt5Agu71dR6E/NZgItM+QWZ0RcVaHPSlgMhrZzFfdc=
X-Received: by 2002:ac2:4a9c:0:b0:4ec:a218:4f92 with SMTP id
 l28-20020ac24a9c000000b004eca2184f92mr2249292lfp.9.1681741843461; Mon, 17 Apr
 2023 07:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230307140522.2311461-1-ardb@kernel.org> <20230307140522.2311461-31-ardb@kernel.org>
 <c4d4f543-9dae-9514-3411-7061192af530@arm.com>
In-Reply-To: <c4d4f543-9dae-9514-3411-7061192af530@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 17 Apr 2023 16:30:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFK3uAMXgrtFofb0e2Z=eW+bMQBkbU-3MAazV3PgX_SpA@mail.gmail.com>
Message-ID: <CAMj1kXFK3uAMXgrtFofb0e2Z=eW+bMQBkbU-3MAazV3PgX_SpA@mail.gmail.com>
Subject: Re: [PATCH v3 30/60] arm64: idreg-override: Create a pseudo feature
 for rodata=off
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023 at 16:28, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 07/03/2023 14:04, Ard Biesheuvel wrote:
> > Add rodata=off to the set of kernel command line options that is parsed
> > early using the CPU feature override detection code, so we can easily
> > refer to it when creating the kernel mapping.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/include/asm/cpufeature.h   | 1 +
> >  arch/arm64/kernel/pi/idreg-override.c | 2 ++
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> > index bc10098901808c00..edc7733aa49846b2 100644
> > --- a/arch/arm64/include/asm/cpufeature.h
> > +++ b/arch/arm64/include/asm/cpufeature.h
> > @@ -16,6 +16,7 @@
> >  #define cpu_feature(x)               KERNEL_HWCAP_ ## x
> >
> >  #define ARM64_SW_FEATURE_OVERRIDE_NOKASLR    0
> > +#define ARM64_SW_FEATURE_OVERRIDE_RODATA_OFF 4
>
> I assume these are bit numbers? Why not just use the next available bit (bit 1)
> for this new flag?
>

This (ab)uses the CPU feature framework, which is based on 4-bit
quantities. I don't remember if it matters or not, but IIRC the
default macros use 4-bit wide values.
