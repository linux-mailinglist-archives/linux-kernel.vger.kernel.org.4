Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA61D654597
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 18:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiLVRV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 12:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLVRVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 12:21:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E54795BC;
        Thu, 22 Dec 2022 09:21:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F708B81CFB;
        Thu, 22 Dec 2022 17:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A31C433D2;
        Thu, 22 Dec 2022 17:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1671729708;
        bh=gMuNx/ETzj/pkU8IgNrRcwRUZ5VOS050gceZG8hotd0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oaxbYeHTTs0NTDHc1u4zsA/7HQBinJcPSMs3s/KVnxc//k0Ntz1pPgpR2Dmr88gAU
         WZZBXxDL6Tc0QjJMc73INnk/0KOkuFbF7iNB59sbgWiBpJYnibIJSSo4sqTI8wPaJQ
         JdMD0wV8Cbb5JpT60P63Yh/T9dCr1NIuxhm2H/M4=
Date:   Thu, 22 Dec 2022 09:21:47 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@vger.kernel.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 00/19] Introduce __xchg, non-atomic xchg
Message-Id: <20221222092147.d2bb177c67870884f2e59a9b@linux-foundation.org>
In-Reply-To: <20221222114635.1251934-1-andrzej.hajda@intel.com>
References: <20221222114635.1251934-1-andrzej.hajda@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2022 12:46:16 +0100 Andrzej Hajda <andrzej.hajda@intel.com> wrote:

> Hi all,
> 
> I hope there will be place for such tiny helper in kernel.
> Quick cocci analyze shows there is probably few thousands places
> where it could be useful.

So to clarify, the intent here is a simple readability cleanup for
existing open-coded exchange operations.  The intent is *not* to
identify existing xchg() sites which are unnecessarily atomic and to
optimize them by using the non-atomic version.

Have you considered the latter?

> I am not sure who is good person to review/ack such patches,

I can take 'em.

> so I've used my intuition to construct to/cc lists, sorry for mistakes.
> This is the 2nd approach of the same idea, with comments addressed[0].
> 
> The helper is tiny and there are advices we can leave without it, so
> I want to present few arguments why it would be good to have it:
> 
> 1. Code readability/simplification/number of lines:
> 
> Real example from drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c:
> -       previous_min_rate = evport->qos.min_rate;
> -       evport->qos.min_rate = min_rate;
> +       previous_min_rate = __xchg(evport->qos.min_rate, min_rate);
> 
> For sure the code is more compact, and IMHO more readable.
> 
> 2. Presence of similar helpers in other somehow related languages/libs:
> 
> a) Rust[1]: 'replace' from std::mem module, there is also 'take'
>     helper (__xchg(&x, 0)), which is the same as private helper in
>     i915 - fetch_and_zero, see latest patch.
> b) C++ [2]: 'exchange' from utility header.
> 
> If the idea is OK there are still 2 qestions to answer:
> 
> 1. Name of the helper, __xchg follows kernel conventions,
>     but for me Rust names are also OK.

I like replace(), or, shockingly, exchange().

But...   Can we simply make swap() return the previous value?

	previous_min_rate = swap(&evport->qos.min_rate, min_rate);


