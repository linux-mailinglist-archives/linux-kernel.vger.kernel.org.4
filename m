Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A737D6149FF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 12:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiKALzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 07:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKALzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 07:55:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741A832C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 04:55:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3717AB81CC1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 11:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C950C433D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 11:55:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="alNktnbo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667303711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VlJEwXojWvDU34CSJ+DZumSMVmlHAaP55pYaPxI2KIM=;
        b=alNktnbohJtQ/jtfauGD+hTjjHSxR3BFRFDm3K1D1tuwrFduTLAD3LQD+RIL6c2A3k2xXL
        Rsj8WTtuc/zqf84RAjI0p/Z5BL2UiJzv7Tea9PxeBKkKJI6MjUIaABvx54tAwO+8jo/kPk
        o2Zb3Ch+45UBmQE/KUE/bQyJERsHYto=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 26ed5fbb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 1 Nov 2022 11:55:11 +0000 (UTC)
Received: by mail-vs1-f48.google.com with SMTP id p4so13635768vsa.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 04:55:11 -0700 (PDT)
X-Gm-Message-State: ACrzQf2X2wwHVQ+PhCMlthNO4psWzTviuFMwqEihcaJ7moXPiwDpYfee
        X62QCQ98M2TsxBb2EEX2ofzBr0680H0/GbmkuBc=
X-Google-Smtp-Source: AMsMyM7+PDQn7wdPe/fu3OuUhyysBAOAhjVIYkJEQ7LwbfvkffJXrP0BN6tlV6xUb6odyqEIm4Xh6RgVEONjjYKlTI8=
X-Received: by 2002:a05:6102:f9a:b0:3aa:1a11:2702 with SMTP id
 e26-20020a0561020f9a00b003aa1a112702mr7064693vsv.73.1667303710029; Tue, 01
 Nov 2022 04:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221030212123.1022049-1-Jason@zx2c4.com> <20221031102840.85621-1-Jason@zx2c4.com>
 <Y2EFX5wGsjLwtO8j@arm.com>
In-Reply-To: <Y2EFX5wGsjLwtO8j@arm.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 1 Nov 2022 12:54:59 +0100
X-Gmail-Original-Message-ID: <CAHmME9rNEiwPwaCz-b110vjAqZpaZuwXW6n+6mb=n7WwLHaGUQ@mail.gmail.com>
Message-ID: <CAHmME9rNEiwPwaCz-b110vjAqZpaZuwXW6n+6mb=n7WwLHaGUQ@mail.gmail.com>
Subject: Re: [PATCH v3] random: remove early archrandom abstraction
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On Tue, Nov 1, 2022 at 12:39 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > +static __always_inline bool __cpu_has_rng(void)
> > +{
> > +     if (!system_capabilities_finalized() && early_boot_irqs_disabled)
> > +             return __early_cpu_has_rndr();
> > +     return cpus_have_const_cap(ARM64_HAS_RNG);
> > +}
>
> I'm not sure about using early_boot_irqs_disabled, it is described as a
> debug helper.

Not sure that part matters much?

> It's also set to 'false' before
> system_capabilities_finalized() (once the full SMP is enabled).

Right, so there's still a "hole", where we'll ball back to
cpus_have_final_cap(), which might return false. In practice I don't
think this matters much. But it's still not perfect.

>
> Would something like this work:
>
>         if (system_capabilities_finalized())
>                 return cpus_have_final_cap(ARM64_HAS_RNG);
>         if (!preemptible())
>                 return __early_cpu_has_rndr();
>         return false;

That'd be fine. Of course that introduces a different sort of "hole",
when it's called from preemptable context. But again, that doesn't
matter in practice. So I'll send you a v4 doing that for you to ack.

I'm going to structure it like this, though:

static __always_inline bool __cpu_has_rng(void)
{
        if (!system_capabilities_finalized() && !preemptible())
                return __early_cpu_has_rndr();
        return cpus_have_const_cap(ARM64_HAS_RNG);
}

Because cpus_have_const_cap() itself has a fallback mode before
system_capabilities_finalized() is true, where it checks a big
bitmask. So that seems like a better fallback than `false`, in case it
happens to be true.

Jason
