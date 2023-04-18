Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F916E62FC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjDRMhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjDRMhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:37:02 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707A212CA7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:36:56 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by andre.telenet-ops.be with bizsmtp
        id mCci290131C8whw01CciYR; Tue, 18 Apr 2023 14:36:53 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pokZe-00H56B-Ey;
        Tue, 18 Apr 2023 14:36:42 +0200
Date:   Tue, 18 Apr 2023 14:36:42 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Arnd Bergmann <arnd@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, llvm@lists.linux.dev,
        Vineet Gupta <vgupta@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Biju Das <biju.das.jz@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] [v2] mm: make arch_has_descending_max_zone_pfns()
 static
In-Reply-To: <20230415081904.969049-1-arnd@kernel.org>
Message-ID: <cab7df5e-a7d7-ce15-20fa-31afe6f7180@linux-m68k.org>
References: <20230415081904.969049-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 	Hi Arnd,

On Sat, 15 Apr 2023, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang produces a build failure on x86 for some randconfig builds
> after a change that moves around code to mm/mm_init.c:
>
> Cannot find symbol for section 2: .text.
> mm/mm_init.o: failed
>
> I have not been able to figure out why this happens, but the __weak
> annotation on arch_has_descending_max_zone_pfns() is the trigger here.
>
> Removing the weak function in favor of an open-coded Kconfig option
> check avoids the problem and becomes clearer as well as better to
> optimize by the compiler.
>
> Fixes: 9420f89db2dd ("mm: move most of core MM initialization to mm/mm_init.c")
> Cc: llvm@lists.linux.dev
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: fix logic bug reported-by: kernel test robot <oliver.sang@intel.com>,
> see https://lore.kernel.org/oe-lkp/202304151422.5e4d380b-oliver.sang@intel.com

Thanks, reverting commit 413d478d3b366d09 ("mm: make
arch_has_descending_max_zone_pfns() static") in next-20230417 and
applying your v2 makes Salvator-XS regain its DMA memory zone.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
