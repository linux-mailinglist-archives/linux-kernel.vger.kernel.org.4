Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FDD637FAE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 20:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKXTdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 14:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKXTdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 14:33:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5C282212;
        Thu, 24 Nov 2022 11:33:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B397DB821DD;
        Thu, 24 Nov 2022 19:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D94DC433D7;
        Thu, 24 Nov 2022 19:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669318398;
        bh=G56naonxExe7awqWZ+LhcMgkDZMstSLkFYMHI57lu1g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SU39a5DBzMXR3TEnheVgcYN0443XrbpK2XZtZmfh8dhOCXZv7H18uGN8Gw1E5LbGG
         epCdVT9C/k2lKHeqsrKeuGUbhFegzpALqmpA+JpAdW/HI4aPlKaxNYcR6JnYI59I36
         WqHDawhZv9UwCUt5ZAR4nrlJPcW4T6jstzu+ane0=
Date:   Thu, 24 Nov 2022 11:33:17 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        vishal.moola@gmail.com, Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: next: x86: clang: mm/khugepaged.c:1428:45: error: variable
 'pmd' is uninitialized when used here
Message-Id: <20221124113317.37ca142d58b5e7efecd1facf@linux-foundation.org>
In-Reply-To: <CA+G9fYtMoRLC0-9hnpw6+fb_i-6jqLNQH83Q90JqyXO7aCJwNw@mail.gmail.com>
References: <CA+G9fYtMoRLC0-9hnpw6+fb_i-6jqLNQH83Q90JqyXO7aCJwNw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2022 21:07:48 +0530 Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> LKFT CI system noticed clang-15 build failures on x86_64 and i386.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/1/build LLVM=1 LLVM_IAS=1
> ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu-
> 'HOSTCC=sccache clang' 'CC=sccache clang'
> mm/khugepaged.c:1428:45: error: variable 'pmd' is uninitialized when
> used here [-Werror,-Wuninitialized]
>         page_table_check_pte_clear_range(mm, addr, pmd);
>                                                    ^~~
> mm/khugepaged.c:1415:2: note: variable 'pmd' is declared here
>         pmd_t pmd;
>         ^

Thanks.  Due to "mm/khugepaged: fix GUP-fast interaction by freeing
ptes via mmu_gather".

Jann, I'll just do this for now:

--- a/mm/khugepaged.c~mm-khugepaged-fix-gup-fast-interaction-by-freeing-ptes-via-mmu_gather-fix
+++ a/mm/khugepaged.c
@@ -1431,7 +1431,6 @@ static void collapse_and_free_pmd(struct
 	 */
 	if (vma->anon_vma)
 		lockdep_assert_held_write(&vma->anon_vma->root->rwsem);
-	page_table_check_pte_clear_range(mm, addr, pmd);
 
 	tlb_gather_mmu(&tlb, mm);
 	pmd = READ_ONCE(*pmdp);
_

please check.
