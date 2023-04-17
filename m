Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4846E5073
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjDQSzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjDQSzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:55:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7F4171A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:55:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29E9961FE9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 18:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245CAC433EF;
        Mon, 17 Apr 2023 18:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681757728;
        bh=jpvGVC73BKKb3zx3vqvMtfK1QJtXKHouU9cI0yUXfAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nOK8sMjEU4Wb4MD/qUb4cZSsCxNFAA3MKO0hekNxrSMI973fsTIRwQbtfPWlHiUOZ
         CL1UxIVw2mK5N1SyVVJufbiWMVt9zAvrnGQrLsb2Y/VP+C5vRUX0/K+H772BxBrnqW
         gV76kKx1vWJgQ/GSQMsAmsvKeNWqBpQZAejLoQVL7+2ISot2MyJVxgxHl3mzMKqghK
         fSxQgS/yktU520k2AyHVAefJzS0Vv3xSOSgHn0ZyLM8JVhlOjLNY2YlcF7yE6WZqp2
         nUASHScS5EGGleflSPArRKwjWGJOmiX0SIfs+JOLrRUXEE4PGZke7FTHmbREz9aX/P
         SCV2DFfCIIaFw==
From:   SeongJae Park <sj@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        linux-mm@kvack.org, SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH] [v2] mm: make arch_has_descending_max_zone_pfns() static
Date:   Mon, 17 Apr 2023 18:55:25 +0000
Message-Id: <20230417185525.1420-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230415081904.969049-1-arnd@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Apr 2023 10:18:20 +0200 Arnd Bergmann <arnd@kernel.org> wrote:

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

I was also encountering similar issue, and confirmed replacing the old version
of this patch with this one fixes it.

Tested-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  arch/arc/mm/init.c | 5 -----
>  include/linux/mm.h | 1 -
>  mm/mm_init.c       | 4 ++--
>  3 files changed, 2 insertions(+), 8 deletions(-)
