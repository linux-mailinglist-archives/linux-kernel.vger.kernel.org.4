Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4DB6D44EE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjDCMxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjDCMxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:53:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A7E44B9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 05:53:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0C5DC21CCD;
        Mon,  3 Apr 2023 12:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680526386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wWP43UEjIhSOrpWkPnDsO8fIdGTKQp3AyeDzseDGv1Y=;
        b=rBcgbjWPxK9kYA6qX1WnnzkvdYL+6qXWN/bZ62OAZMj0CeWPPAYsuQTvkhxJ1UjDiizJfs
        9ZbqtWp5e9X/esVs2FfrwwKZhDqSKWrd4Dk32EWLXEzD9jdhao2bZOyGoVD6uSEOupLqbY
        oRfHeUO404V4Yf5Nml8jx2306jsERWU=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B6C1F2C141;
        Mon,  3 Apr 2023 12:53:05 +0000 (UTC)
Date:   Mon, 3 Apr 2023 14:53:05 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
        GyeongHwan Hong <gh21.hong@samsung.com>
Subject: Re: [RFC] vsprintf: compile error on %09pK
Message-ID: <ZCrMMQt2xnnZIyz6@alley>
References: <CGME20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42@epcms1p3>
 <20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42@epcms1p3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42@epcms1p3>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-04-03 19:46:17, Jaewon Kim wrote:
> Hello
> 
> I've just changed %09lx to %09pK on my driver code to hide the address, but I
> faced compiler error. The %9pK without 0 worked.

What exactly do you want to achieve, please?

Note that printk() hashes pointers by default. It means that %p does not
print the value but a hash based on the value.

If you print the same pointer twice, you will see the same hash, so
you know that the pointer is the same. But you do not see the address
so that you could not use the value for a security attack.

See Documentation/core-api/printk-formats.rst

Anyway, the main question if it makes sense to print the pointer value
at all. The address is not useful if it can't be compared with
other pointers or if the data on the address could not be checked.

> Is there restriction on %pK which does now allow %0 ? I've wondered whether I
> did wrong or it is a printk problem.
> 
> To show easily I tried to add pr_info("%09pK\n", nodemask); in page_alloc.c
> Then here's what I did.
> 
> $ ARCH=x86 make x86_64_defconfig ; make mm/page_alloc.o
> #
> # No change to .config
> #
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>   CC      mm/page_alloc.o
> In file included from ./include/asm-generic/bug.h:22:0,
>                  from ./arch/x86/include/asm/bug.h:87,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/mmdebug.h:5,
>                  from ./include/linux/mm.h:6,
>                  from mm/page_alloc.c:19:
> mm/page_alloc.c: In function ‘__alloc_pages’:
> ./include/linux/kern_levels.h:5:18: error: '0' flag used with ‘%p’ gnu_printf format [-Werror=format=]
>  #define KERN_SOH "\001"  /* ASCII Start Of Header */

As Sergey already wrote. %p does not support any modification flags.

Best Regards,
Petr
