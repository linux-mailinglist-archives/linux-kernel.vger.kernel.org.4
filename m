Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE53467F41C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 03:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjA1Crl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 21:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjA1Cri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 21:47:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8AB8B075
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 18:47:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21FDDB8220B
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1589C4339E
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674874054;
        bh=ERyDVuQcGxHlQvFe7UxhxT7d/oa1lfTJ1tWjBNFn0JY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NzFmIkIosaf0UZnSIFZKNB23huh7yfcsyAx80PE2FrhKN/Isz96H7FKG7IA7Ll8Ht
         slcyYeDLNZl3MmhUtBdNTyx9Y/MHHNE+n4gT4Cx5J57B6BODbpTCYqsBt6R2J0Mpqk
         GwRKzPiWH8vV5PR5DxuEwKwXfGDqkwDmnxU5dz8EBBwR2YBuH6R1J/fUQkBiteUWNd
         sTRBIYTrqN3x8BYA+YgyWKAmu8PDAT1GXJFYhZSr+CU9QM1Tz2vJSx6nMNPm7XXzOk
         vdeNp1DYd2ZIGq6jzEXsi+d9MkTNuHfApxtUPGR+CiXAqdmcVxSlPRS2sEBvCg+uZC
         mQq/KgCmBC1nA==
Received: by mail-ej1-f51.google.com with SMTP id m2so17892088ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 18:47:34 -0800 (PST)
X-Gm-Message-State: AFqh2kree3Wr5ix8f3Jd4IrfhiKdIDwR7m1l/oDjQF17TCTvsdSNZ6tm
        p6zfWA7koVgRFltKMx2SORzr8/bMz7Z399/35eo=
X-Google-Smtp-Source: AMrXdXsVUvOSSWf32xpCd00GV+QlU0zCda4LZigTo1vZLg+W5LKZ0dp29lcwDELLEX4AwyCpS6j6neY6bNraOEZgy6E=
X-Received: by 2002:a17:906:6d97:b0:85f:f320:2cea with SMTP id
 h23-20020a1709066d9700b0085ff3202ceamr6167528ejt.89.1674874052984; Fri, 27
 Jan 2023 18:47:32 -0800 (PST)
MIME-Version: 1.0
References: <20230127035306.1819561-1-guoren@kernel.org> <Y9RgBh9X6KM1/uvp@spud>
In-Reply-To: <Y9RgBh9X6KM1/uvp@spud>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 28 Jan 2023 10:47:21 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTdQOc1XFGx6UEZ6ABYTFkX6Ott53Z1ZDzeU9e4k=SRww@mail.gmail.com>
Message-ID: <CAJF2gTTdQOc1XFGx6UEZ6ABYTFkX6Ott53Z1ZDzeU9e4k=SRww@mail.gmail.com>
Subject: Re: [PATCH V2] riscv: Fixup race condition on PG_dcache_clean in flush_icache_pte
To:     Conor Dooley <conor@kernel.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, conor.dooley@microchip.com,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        mark.rutland@arm.com, bjorn@kernel.org, tongtiangen@huawei.com,
        ajones@ventanamicro.com, andrew@sifive.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 7:36 AM Conor Dooley <conor@kernel.org> wrote:
>
> Hey Guo Ren,
>
> On Thu, Jan 26, 2023 at 10:53:06PM -0500, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > In commit 588a513d3425 ("arm64: Fix race condition on PG_dcache_clean
> > in __sync_icache_dcache()"), we found RISC-V has the same issue as the
> > previous arm64. The previous implementation didn't guarantee the correct
> > sequence of operations, which means flush_icache_all() hasn't been
> > called when the PG_dcache_clean was set. That would cause a risk of page
> > synchronization.
> >
> > Fixes: 08f051eda33b ("RISC-V: Flush I$ when making a dirty page executable")
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> > Changelog:
> > V2:
> >  - Optimize commit log
>
> Probably would have benefited from providing the analysis that the arm64
> commit did, for riscv, rather than referring to theirs.
Maybe you are right, but they are almost the same for this patch. So I
didn't want to duplicate the commit log but gave out the original
instead.

> But that's not really important and the diff itself seems sound, so:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Thx.

>
> Thanks,
> Conor.
>
> >  - Rebase on riscv for-next (20230127)
> >
> > V1:
> > https://lore.kernel.org/linux-riscv/20221023133205.3493564-2-guoren@kernel.org/
> > ---
> >  arch/riscv/mm/cacheflush.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> > index 3cc07ed45aeb..fcd6145fbead 100644
> > --- a/arch/riscv/mm/cacheflush.c
> > +++ b/arch/riscv/mm/cacheflush.c
> > @@ -90,8 +90,10 @@ void flush_icache_pte(pte_t pte)
> >       if (PageHuge(page))
> >               page = compound_head(page);
> >
> > -     if (!test_and_set_bit(PG_dcache_clean, &page->flags))
> > +     if (!test_bit(PG_dcache_clean, &page->flags)) {
> >               flush_icache_all();
> > +             set_bit(PG_dcache_clean, &page->flags);
> > +     }
> >  }
> >  #endif /* CONFIG_MMU */
> >
> > --
> > 2.36.1
> >



-- 
Best Regards
 Guo Ren
