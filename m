Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC029734374
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 22:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346363AbjFQUOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 16:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjFQUOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 16:14:21 -0400
X-Greylist: delayed 433 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 17 Jun 2023 13:14:20 PDT
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E29AE6A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 13:14:20 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id E9926520331;
        Sat, 17 Jun 2023 22:07:04 +0200 (CEST)
Received: from lxhi-065 (10.72.94.8) by hi2exch02.adit-jv.com (10.72.92.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.23; Sat, 17 Jun
 2023 22:07:04 +0200
Date:   Sat, 17 Jun 2023 22:07:00 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
CC:     <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] kbuild: make clean rule robust against too long argument
 error
Message-ID: <20230617200700.GA31221@lxhi-065>
References: <20230617153025.1653851-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230617153025.1653851-1-masahiroy@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.72.94.8]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yamada-san,

Many thanks for your feedback and for your patch.
It indeed addresses the issue I have reported in [1].

On Sun, Jun 18, 2023 at 12:30:25AM +0900, Masahiro Yamada wrote:
> Commit cd968b97c492 ("kbuild: make built-in.a rule robust against too
> long argument error") made a build rule robust against "Argument list
> too long" error.
> 
> Eugeniu Rosca reported the same error occurred when cleaning an external
> module.
> 
> The $(obj)/ prefix can be a very long path for external modules.

Confirmed. I am seeing an instance of $(obj) being 150 characters long,
due to an out-of-tree module deeply buried in a specific Yocto build.

In the current vanilla version of 'make clean' (w/o this patch), the
$(obj) prefix is applied to each and every file being removed,
dramatically increasing the strlen of arguments passed to 'rm -rf'.

> 
> Apply a similar solution to 'make clean'.
> 
> Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/Makefile.clean | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
> index 3649900696dd..235408a44f90 100644
> --- a/scripts/Makefile.clean
> +++ b/scripts/Makefile.clean
> @@ -37,8 +37,9 @@ __clean-files   := $(wildcard $(addprefix $(obj)/, $(__clean-files)))
>  
>  # ==========================================================================
>  
> +# Use xargs to make this robust against "Argument list too long" error

Please, correct me if I am wrong, but it looks like the magic/brilliance
is in the 'patsubst' function, since below version also fails for me:

NOK: cmd_clean = printf '%s ' $(__clean-files) | xargs rm -rf

When running 'make clean' for my particular out-of-tree kernel module,
'patsubst' is able to decrease the total number of characters passed
to the shell's argument list from ~204k to ~47k, which elegantly
prevents the "Argument list too long" error.

>  quiet_cmd_clean = CLEAN   $(obj)
> -      cmd_clean = rm -rf $(__clean-files)
> +      cmd_clean = printf '$(obj)/%s ' $(patsubst $(obj)/%,%,$(__clean-files)) | xargs rm -rf
>  
>  __clean: $(subdir-ymn)
>  ifneq ($(strip $(__clean-files)),)
> -- 
> 2.39.2
> 

Since it fixes the problem reported in [1] (much appreciated):

Reviewed-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>

[1] https://lore.kernel.org/linux-kbuild/20230616194505.GA27753@lxhi-065/

-- 
Best regards,
Eugeniu Rosca
