Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC36E5FEEAF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiJNNdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJNNdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:33:00 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116831C8406;
        Fri, 14 Oct 2022 06:32:58 -0700 (PDT)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 29EDWZ6e031463;
        Fri, 14 Oct 2022 22:32:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 29EDWZ6e031463
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1665754356;
        bh=Af8VRUD+/Hcwkk/ID8/AEvvjJDSeo1Zqlxb098dd3aQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XCHtV2dgwkr5VqcLcmonNTybfWu4z7/VmeA0u21SRHCDS06mWhut4vIoOUEi69bIw
         OQJTa4nTX6o0WxZR8VYGNTH02jReaspDu9Sba5l+hBCEO/YKCO3RcXWnbpX8svxNZi
         POPolujeXPOLoM3WfCyhp0i9KcUEzVDf9imSV9PFM7fAKSXs7G57BU4sevGi5jFVcv
         zLMh+BR8QZ1JNYZ8LMMb1uKMHprZTxZ36iWZPpz6i00WUEygn9wznneaIKQ2bb4a72
         ftZyyuYq/zkM9sekoxQvrlVwVeWAVlCHoMJ8J5bNOP6TxdqQzqnlLg2q/vsnnuXE3v
         SsLhJvgPrggnQ==
X-Nifty-SrcIP: [209.85.167.171]
Received: by mail-oi1-f171.google.com with SMTP id x188so5036894oig.5;
        Fri, 14 Oct 2022 06:32:36 -0700 (PDT)
X-Gm-Message-State: ACrzQf2SxHSQMGK6qanEB2RkcNOAv7jDdqJuAMlf1KYsGuo+QGC3MayK
        MGeklNLw84/mbcRXuVD6g4ZdGtmlhcqiIJZ4OSo=
X-Google-Smtp-Source: AMsMyM4T3Arq2Att04v3qFajvz07NM2O+oXOd9p83VaEsW1UBM+Jze8Gqdc0QOowW4si1+cwhzEZAQE8TX3CgyVraas=
X-Received: by 2002:a05:6808:1b85:b0:34d:8ce1:d5b0 with SMTP id
 cj5-20020a0568081b8500b0034d8ce1d5b0mr7226697oib.194.1665754355183; Fri, 14
 Oct 2022 06:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221014124217.20fd0a27@canb.auug.org.au>
In-Reply-To: <20221014124217.20fd0a27@canb.auug.org.au>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 14 Oct 2022 22:31:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNARg8OpqLR_71PJV3ZoLuDV8+mz9mphg=CzEeEEMY0G3rw@mail.gmail.com>
Message-ID: <CAK7LNARg8OpqLR_71PJV3ZoLuDV8+mz9mphg=CzEeEEMY0G3rw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the kbuild tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 10:42 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the kbuild tree, today's linux-next build (i386 defconfig)
> failed like this:
>
> In file included from arch/x86/kernel/head_32.S:29:
> arch/x86/include/asm/pgtable_32.h:68:5: error: "PTRS_PER_PMD" is not defined, evaluates to 0 [-Werror=undef]
>    68 | #if PTRS_PER_PMD > 1
>       |     ^~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
> Exposed by commit
>
>   0a7606a9832a ("kbuild: move -Wundef from KBUILD_CFLAGS to KBUILD_CPPFLAGS")
>
> I have no idea what the root cause is. :-(
>
> It is a great pity that this commit was not in linux-next before the
> merge window opened. :-(



Sorry for the annoyance again.

I gave up this patch for now.

I will drop it and need to sort out warnings.





>
> I have applied the following hack for today.
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 14 Oct 2022 12:34:34 +1100
> Subject: [PATCH] i386: hack for "kbuild: move -Wundef from KBUILD_CFLAGS to KBUILD_CPPFLAGS"
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/x86/include/asm/pgtable_32.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
> index 7c9c968a42ef..0f3f186ca140 100644
> --- a/arch/x86/include/asm/pgtable_32.h
> +++ b/arch/x86/include/asm/pgtable_32.h
> @@ -65,7 +65,7 @@ do {                                          \
>   * With PAE paging (PTRS_PER_PMD > 1), we allocate PTRS_PER_PGD == 4 pages for
>   * the PMD's in addition to the pages required for the last level pagetables.
>   */
> -#if PTRS_PER_PMD > 1
> +#if defined(PTRS_PER_PMD) && (PTRS_PER_PMD > 1)
>  #define PAGE_TABLE_SIZE(pages) (((pages) / PTRS_PER_PMD) + PTRS_PER_PGD)
>  #else
>  #define PAGE_TABLE_SIZE(pages) ((pages) / PTRS_PER_PGD)
> --
> 2.35.1
>
> --
> Cheers,
> Stephen Rothwell



-- 
Best Regards
Masahiro Yamada
