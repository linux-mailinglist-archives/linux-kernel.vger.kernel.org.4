Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1224718508
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbjEaOdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjEaOdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:33:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9487995;
        Wed, 31 May 2023 07:33:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2863263CCF;
        Wed, 31 May 2023 14:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A6CC433D2;
        Wed, 31 May 2023 14:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685543625;
        bh=L/dTiuT+ktTPMYaEXn8ndEBWIS2gWoNfI9OE21M1RCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DAWDh6MT2/MOtKpYopxqF6yhYjN3Qup3Cr0wyjAksB7/WUJjjrXFFe6DjOfpMfBM4
         QZowXDJ9uBub7Qjj5Vt1XAJTM/HlFOmmg4X09fqxPu164R8LFPiGxGF1yOhpELJ1P9
         SPBfjOB3mU8YdPM0ZSV0XgBA2bNFvS9E2sjK5KI5GSl5GToBpbbt6q1+bT+xJX1Htr
         ZkXqctLQYhkudRx5Inv6rqeTVwzKiI6w3ReyywcO/G2KiKFB5hSZ3IjNKosI0kAeoN
         43otBMx5iqyOI883q+oSEOCBdmreGVQmmSR7FOm0SMAsitUknO+pk8V8xrmBnxnO0v
         PPH+G4yJm2wCg==
Date:   Wed, 31 May 2023 07:33:42 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Joan Bruguera =?iso-8859-1?Q?Mic=F3?= <joanbrugueram@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] s390/purgatory: Do not use fortified string functions
Message-ID: <20230531143342.GA2250333@dev-arch.thelio-3990X>
References: <20230531003414.never.050-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230531003414.never.050-kees@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 05:34:15PM -0700, Kees Cook wrote:
> With the addition of -fstrict-flex-arrays=3, struct sha256_state's
> trailing array is no longer ignored by CONFIG_FORTIFY_SOURCE:
> 
> struct sha256_state {
>         u32 state[SHA256_DIGEST_SIZE / 4];
>         u64 count;
>         u8 buf[SHA256_BLOCK_SIZE];
> };
> 
> This means that the memcpy() calls with "buf" as a destination in
> sha256.c's code will attempt to perform run-time bounds checking, which
> could lead to calling missing functions, specifically a potential
> WARN_ONCE, which isn't callable from purgatory.
> 
> Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> Closes: https://lore.kernel.org/lkml/175578ec-9dec-7a9c-8d3a-43f24ff86b92@leemhuis.info/
> Bisected-by: "Joan Bruguera Micó" <joanbrugueram@gmail.com>
> Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Linux Kernel Functional Testing <lkft@linaro.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reading https://lore.kernel.org/202305301658.BF6ECF65C@keescook/ was
some good additional context.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/s390/purgatory/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
> index 32573b4f9bd2..cf14740abd1c 100644
> --- a/arch/s390/purgatory/Makefile
> +++ b/arch/s390/purgatory/Makefile
> @@ -10,7 +10,7 @@ PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
>  $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
>  	$(call if_changed_rule,cc_o_c)
>  
> -CFLAGS_sha256.o := -D__DISABLE_EXPORTS
> +CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
>  
>  $(obj)/mem.o: $(srctree)/arch/s390/lib/mem.S FORCE
>  	$(call if_changed_rule,as_o_S)
> -- 
> 2.34.1
> 
