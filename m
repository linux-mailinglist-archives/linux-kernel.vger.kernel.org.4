Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969FA735757
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjFSMwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjFSMwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:52:04 -0400
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2140710C6;
        Mon, 19 Jun 2023 05:51:39 -0700 (PDT)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Mon, 19 Jun 2023 14:51:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1687179061; bh=F9qbwFu08/cDlUcRp5xRazMlWpEcmmgXT90TjPKR7Dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AAz7d5NyIoPLTcatKRIy3Gu/U4ZnoL3/QGnvps7Spt/jjvqj62ET3smeeZEPWPPzF
         KUw7jBzmpcgLaLHuYAU/xMMZ295bV3W+1GyKKKwyNyhs86FujuMo1cZk+S5KKkBJxz
         /HMK/xxnltfeuE94xNBElFt5fq+cGILghZb1K/6U=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id DDA2581ECE;
        Mon, 19 Jun 2023 14:51:00 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id D8F7F18207E; Mon, 19 Jun 2023 14:51:00 +0200 (CEST)
Date:   Mon, 19 Jun 2023 14:51:00 +0200
From:   Nicolas Schier <n.schier@avm.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 2/2] kbuild: respect GNU Make -w flag
Message-ID: <ZJBPNBrLSX+M2e4l@buildd.core.avm.de>
References: <20230616145751.945864-1-masahiroy@kernel.org>
 <20230616145751.945864-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230616145751.945864-2-masahiroy@kernel.org>
X-purgate-ID: 149429::1687179060-27DFF3F9-02FD9815/0/0
X-purgate-type: clean
X-purgate-size: 2303
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 11:57:51PM +0900, Masahiro Yamada wrote:
> Currently, -w (--print-directory) option is ignored, but it is better
> to respect the user's choice.
> 
> This commit changes the behavior of "Entering directory ..." logging.
> 
> If -w (or --print-directory) is given via the command line or the
> MAKEFLAGS environment variable, print "Entering directory ..." for every
> sub make.
> 
> If --no-print-directory is given via the command line or the MAKEFLAGS
> environment variable, suppress "Entering directory ..." completely.
> 
> If none of them is given, print "Entering directory ..." only when Kbuild
> changes the working directory. (default)
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Tested-by: Nicolas Schier <n.schier@avm.de>

> 
> Changes in v2:
>   - new patch
> 
>  Makefile | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 916c1a7984b0..3867cdc3de5d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -38,6 +38,12 @@ __all:
>  # descending is started. They are now explicitly listed as the
>  # prepare rule.
>  
> +ifeq ($(filter 3.%,$(MAKE_VERSION)),)
> +short-opts := $(firstword -$(MAKEFLAGS))
> +else
> +short-opts := $(filter-out --%,$(MAKEFLAGS))
> +endif
> +
>  ifneq ($(sub_make_done),1)
>  
>  # Do not use make's built-in rules and variables
> @@ -91,12 +97,6 @@ endif
>  # commands
>  # make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
>  
> -ifeq ($(filter 3.%,$(MAKE_VERSION)),)
> -short-opts := $(firstword -$(MAKEFLAGS))
> -else
> -short-opts := $(filter-out --%,$(MAKEFLAGS))
> -endif
> -
>  ifneq ($(findstring s,$(short-opts)),)
>  quiet=silent_
>  override KBUILD_VERBOSE :=
> @@ -217,12 +217,16 @@ else
>  need-sub-make := 1
>  endif
>  
> +ifeq ($(findstring w, $(short-opts)),)
>  ifeq ($(filter --no-print-directory, $(MAKEFLAGS)),)
>  # If --no-print-directory is unset, recurse once again to set it.
>  # You may end up with recursing into __sub-make twice. This is due to the
>  # behavior change for GNU Make 4.4.1.
>  need-sub-make := 1
>  endif
> +else
> +no-print-directory :=
> +endif
>  
>  ifeq ($(need-sub-make),1)
>  
> -- 
> 2.39.2
> 
