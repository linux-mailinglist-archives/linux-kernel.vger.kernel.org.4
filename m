Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5599165D0B2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbjADKdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjADKdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:33:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE6F1C93A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:33:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B3AF61683
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 10:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68315C433D2;
        Wed,  4 Jan 2023 10:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672828379;
        bh=vF8eiH+zfyKEbLyTZZlwHaQeGAk1Dm/ULe7hm039cJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q9sl2XkY5lsEtXSL383T5PFQGsqOeS+kdHqFL3K7rBpAjzktdfedZ1pR4QZyJDCZQ
         YroZZLjU2BlddB4YWS6bwaFPXjm7HTBAAKuyjktsIt6mXm3EbvK9/0tXS3hT3MOlSf
         cXRPCl1tkGv9T164rbjp63PoNWQHRrtyi4cJ4mlob4rqslW4eCPfofGwIMHoOJGnNi
         /l5hmeIuOQAXR9WxEar5SiAxsf7u6yM67yxuNohSqhH7mOTK+6enaSePGwlr0oHQgC
         ULd2e+UXfQddJ7zi/wrZ3vVs/iXB3IaPpA7yZ4+UdAvtIc85PygVYjXCNvC7+awqFl
         WmChIwE8/J71w==
Date:   Wed, 4 Jan 2023 12:32:47 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Aaron Thompson <dev@aaront.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock tests: Fix compilation error.
Message-ID: <Y7VVzxpxnun3HD3B@kernel.org>
References: <010101857c402765-96e2dbc6-b82b-47e2-a437-4834dbe0b96b-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010101857c402765-96e2dbc6-b82b-47e2-a437-4834dbe0b96b-000000@us-west-2.amazonses.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 10:07:37AM +0000, Aaron Thompson wrote:
> Commit cf4694be2b2cf ("tools: Add atomic_test_and_set_bit()") changed
> tools/arch/x86/include/asm/atomic.h to include <asm/asm.h>, which causes
> 'make -C tools/testing/memblock' to fail with:
> 
> In file included from ../../include/asm/atomic.h:6,
>                  from ../../include/linux/atomic.h:5,
>                  from ./linux/mmzone.h:5,
>                  from ../../include/linux/mm.h:5,
>                  from ../../include/linux/pfn.h:5,
>                  from ./linux/memory_hotplug.h:6,
>                  from ./linux/init.h:7,
>                  from ./linux/memblock.h:11,
>                  from tests/common.h:8,
>                  from tests/basic_api.h:5,
>                  from main.c:2:
> ../../include/asm/../../arch/x86/include/asm/atomic.h:11:10: fatal error: asm/asm.h: No such file or directory
>    11 | #include <asm/asm.h>
>       |          ^~~~~~~~~~~
> 
> Create a symlink to asm/asm.h in the same manner as the existing one to
> asm/cmpxchg.h.
> 
> Signed-off-by: Aaron Thompson <dev@aaront.org>

Applied, thanks!

> ---
>  tools/testing/memblock/.gitignore | 1 +
>  tools/testing/memblock/Makefile   | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/memblock/.gitignore b/tools/testing/memblock/.gitignore
> index 654338e0be52..4cc7cd5aac2b 100644
> --- a/tools/testing/memblock/.gitignore
> +++ b/tools/testing/memblock/.gitignore
> @@ -1,4 +1,5 @@
>  main
>  memblock.c
>  linux/memblock.h
> +asm/asm.h
>  asm/cmpxchg.h
> diff --git a/tools/testing/memblock/Makefile b/tools/testing/memblock/Makefile
> index 2310ac4d080e..7a1ca694a982 100644
> --- a/tools/testing/memblock/Makefile
> +++ b/tools/testing/memblock/Makefile
> @@ -29,13 +29,14 @@ include: ../../../include/linux/memblock.h ../../include/linux/*.h \
>  
>  	@mkdir -p linux
>  	test -L linux/memblock.h || ln -s ../../../../include/linux/memblock.h linux/memblock.h
> +	test -L asm/asm.h || ln -s ../../../arch/x86/include/asm/asm.h asm/asm.h
>  	test -L asm/cmpxchg.h || ln -s ../../../arch/x86/include/asm/cmpxchg.h asm/cmpxchg.h
>  
>  memblock.c: $(EXTR_SRC)
>  	test -L memblock.c || ln -s $(EXTR_SRC) memblock.c
>  
>  clean:
> -	$(RM) $(TARGETS) $(OFILES) linux/memblock.h memblock.c asm/cmpxchg.h
> +	$(RM) $(TARGETS) $(OFILES) linux/memblock.h memblock.c asm/asm.h asm/cmpxchg.h
>  
>  help:
>  	@echo  'Memblock simulator'
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
