Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1443F638989
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiKYMSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKYMSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:18:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9660217419;
        Fri, 25 Nov 2022 04:18:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3262A623BC;
        Fri, 25 Nov 2022 12:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB08C43470;
        Fri, 25 Nov 2022 12:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669378688;
        bh=2QQ3gkT8M4ne/f/6SMJfPCcoYNo2dNjFDj4PF9DSWIc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HurY4q/yF+peulV7cvOO7tegNpqJMAftwxJ/HfA90kCJRh5gKLHbacaMXDqq4TBBF
         UnZJqEzFBWuFNipA/KgLMK7QPG1SIOaKjAU1NW5bQ/rB87Hwbz0LDOXjl81jbkaOR7
         xq4peTK2aiu/PiYMyds1P5XvlAZNzJhc4K7/xPDpdmU2e82pfQCBhYel2eSN0JfJLC
         3Ue3BuPUJWq11QwyzHluDrzKqvVgYUFHJn3jgZLozJOQKSxWtkW37sh3rZj1zbYdrt
         sjSkueGKaQ5qeJYk1l7CC+09XMVJM2576vH2pHzGbL+NI+ySnJSEtHauEdXTG+HVr1
         6PMqs4Dr3V1Og==
Received: by mail-lj1-f175.google.com with SMTP id a15so4975647ljb.7;
        Fri, 25 Nov 2022 04:18:08 -0800 (PST)
X-Gm-Message-State: ANoB5pmy8xs7+GWuk5H/kPP14SMilP3GYuE7XwzbbZcLoV3/SrkM5Xor
        5toyO4KeoObPC3j3VsC80aFtqJy5jGhrP0HLuAM=
X-Google-Smtp-Source: AA0mqf6CxETx94Nasnco4cIEVleHJVePOuucHyZEljEzF94SI+7etB5m2ezhOcBypmHyucIqtfdrsFWGOcllieCaWAo=
X-Received: by 2002:a2e:95d2:0:b0:277:96a:5c32 with SMTP id
 y18-20020a2e95d2000000b00277096a5c32mr11115105ljh.415.1669378686498; Fri, 25
 Nov 2022 04:18:06 -0800 (PST)
MIME-Version: 1.0
References: <Y4BGC2BPesy3qsEm@gondor.apana.org.au>
In-Reply-To: <Y4BGC2BPesy3qsEm@gondor.apana.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 25 Nov 2022 13:17:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFAN2xDt+tKzOJt8zbhXA64U4qi28rzmrSSRoQDbsRHmA@mail.gmail.com>
Message-ID: <CAMj1kXFAN2xDt+tKzOJt8zbhXA64U4qi28rzmrSSRoQDbsRHmA@mail.gmail.com>
Subject: Re: [v2 PATCH 0/9] crypto: Add helpers for allocating with DMA alignment
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2022 at 05:35, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> This patch series adds helpers to allow drivers to explicitly
> request ARCH_DMA_MINALIGN when allocating memory through the
> Crypto API.
>
> Note that I've only converted one file in one driver as this
> is only meant to show how it's done and find out what else we
> may need.
>
> Other drivers will be added later.
>

Hi Herbert,

This approach seems conceptually similar to what I proposed a while ago:
https://lore.kernel.org/all/20220406142715.2270256-1-ardb@kernel.org/

If we agree that creating a distinction between ordinary allocations
and ones that are rounded up to DMA alignment is ok, I wonder if we
could minimize the churn by simply choosing between one or the other
by taking the CRYPTO_ALG_ASYNC flag into account. On x86 and other
arches that don't care about the distinction, none of this has any
effect anyway. And on arm64, only hardware implementations use the
CRYPTO_ALG_ASYNC flag, which makes its presence a reasonable heuristic
to decide whether an algo implementation is backed by hardware that
relies on DMA (the penalty for getting it wrong would be to use DMA
ailgnment unnecessarily, which we already do today anyway)

We'd still need changes in the generic crypto layer to distinguish the
two cases, but we wouldn't need any changes to the drivers, which
seems like a huge benefit to me
