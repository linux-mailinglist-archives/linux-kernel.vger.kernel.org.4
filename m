Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10CE6C63E7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjCWJng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCWJn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:43:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761AEC155;
        Thu, 23 Mar 2023 02:43:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0468A33AFE;
        Thu, 23 Mar 2023 09:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679564602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=klNWhIy8hiXGSUgaFtlmoMw45I3AHJjiiJxXlBCB2YE=;
        b=y4bAYuP0tUJ3WO7M9lYm1GYFACckupaP7f4nLoIji81aKWP13DWy7vrrxxcK+E/DnRROQy
        OzxG4JcYmNC9gf4Lq3S7tEMWWmzgw9yw+lupH3uAtlc42Rgj+nSwO9iuFPAIPXMoymZCi7
        IjgcsnSULtkBXblwaSPAXU7/r3nNa9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679564602;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=klNWhIy8hiXGSUgaFtlmoMw45I3AHJjiiJxXlBCB2YE=;
        b=lCCTR4LTrC40Hd8pcwb7sUO5Hc564tiR4anU1tdXp0GhiqbkppSIVUSZOvAah/90rHxqz6
        aTVZYD0sd55bwLCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3BE6132C2;
        Thu, 23 Mar 2023 09:43:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CZGvMjkfHGToTwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 23 Mar 2023 09:43:21 +0000
Message-ID: <1fcc9df0-10a6-f31c-e3d3-e2474c9da817@suse.cz>
Date:   Thu, 23 Mar 2023 10:43:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: mm/mmap.c:939:11: error: variable 'next' is used uninitialized
 whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        linux-mm <linux-mm@kvack.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <CA+G9fYvEqk8tC7w3xxPcFhycctZeOj4CMJj3JbrtWKkp3w9qPQ@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CA+G9fYvEqk8tC7w3xxPcFhycctZeOj4CMJj3JbrtWKkp3w9qPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/23 08:58, Naresh Kamboju wrote:
> Following multiple build warnings / errors noticed while building
> Linux next-20230323 with clang-16 for x86_64.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build warnings / errors:
> ---------
> mm/mmap.c:939:11: error: variable 'next' is used uninitialized
> whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>         else if (!curr)
>                  ^~~~~
> mm/mmap.c:952:15: note: uninitialized use occurs here
>         merge_next = next && mpol_equal(policy, vma_policy(next)) &&
>                      ^~~~
> mm/mmap.c:939:7: note: remove the 'if' if its condition is always true
>         else if (!curr)
>              ^~~~~~~~~~
> mm/mmap.c:912:36: note: initialize the variable 'next' to silence this warning
>         struct vm_area_struct *curr, *next, *res;
>                                           ^
>                                            = NULL

Same issue as https://lore.kernel.org/all/CA%2BG9fYvBxp38KEggtvtvVtGMaSBdL3NDV9ns%3DZi9-Jtx7H9g1A@mail.gmail.com/
Thus already resolved in the next -next hopefully.

> 1 error generated.
> make[3]: *** [scripts/Makefile.build:252: mm/mmap.o] Error 1
> 
> mm/vmalloc.c:3543:6: error: variable 'remains' is used uninitialized
> whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (bitmap_empty(vb->used_map, VMAP_BBMAP_BITS)) {
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> mm/vmalloc.c:3587:17: note: uninitialized use occurs here
>         return count - remains + zero_iter(iter, remains);
>                        ^~~~~~~
> mm/vmalloc.c:3543:2: note: remove the 'if' if its condition is always false
>         if (bitmap_empty(vb->used_map, VMAP_BBMAP_BITS)) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> mm/vmalloc.c:3539:6: error: variable 'remains' is used uninitialized
> whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (!vb)
>             ^~~
> mm/vmalloc.c:3587:17: note: uninitialized use occurs here
>         return count - remains + zero_iter(iter, remains);
>                        ^~~~~~~
> mm/vmalloc.c:3539:2: note: remove the 'if' if its condition is always false
>         if (!vb)
>         ^~~~~~~~
> mm/vmalloc.c:3524:16: note: initialize the variable 'remains' to
> silence this warning
>         size_t remains, n;
>                       ^
>                        = 0
> 2 errors generated.
> make[3]: *** [scripts/Makefile.build:252: mm/vmalloc.o] Error 1
> make[3]: Target 'mm/' not remade because of errors.
> 
> steps to reproduce:
> ----------
> 
> tuxmake  \
>   --runtime podman \
>   --target-arch x86_64 \
>   --toolchain clang-16 LLVM=1 LLVM_IAS=1 \
>   --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2NOjxURhByyb4dR3Ld788iuYvAR/config
> 
> Related discussion on mailing list,
>  - https://lore.kernel.org/llvm/202303231055.DeninwHS-lkp@intel.com/
>  - https://lore.kernel.org/llvm/14c60785-2427-45db-9613-683410ff6802@lucifer.local/T/#t
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> 

