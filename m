Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9DF735752
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjFSMvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjFSMvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:51:00 -0400
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E281731;
        Mon, 19 Jun 2023 05:50:20 -0700 (PDT)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Mon, 19 Jun 2023 14:50:17 +0200 (CEST)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id 3F9B781FD7;
        Mon, 19 Jun 2023 14:50:17 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 32B0318207E; Mon, 19 Jun 2023 14:50:17 +0200 (CEST)
Date:   Mon, 19 Jun 2023 14:50:17 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2 1/2] kbuild: revive "Entering directory" for Make >=
 4.4.1
Message-ID: <ZJBPCb6DmHACwwq4@buildd.core.avm.de>
References: <20230616145751.945864-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230616145751.945864-1-masahiroy@kernel.org>
X-purgate-ID: 149429::1687179017-A14E50AE-C5C897CC/0/0
X-purgate-type: clean
X-purgate-size: 4548
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 11:57:50PM +0900, Masahiro Yamada wrote:
> With commit 9da0763bdd82 ("kbuild: Use relative path when building in
> a subdir of the source tree"), compiler messages in out-of-tree builds
> include relative paths, which are relative to the build directory, not
> the directory where make was started.
> 
> To help IDEs/editors find the source files, Kbuild lets GNU Make print
> "Entering directory ..." when it changes the working directory. It has
> been working fine for a long time, but David reported it is broken with
> the latest GNU Make.
> 
> The behavior was changed by GNU Make commit 8f9e7722ff0f ("[SV 63537]
> Fix setting -w in makefiles"). Previously, setting --no-print-directory
> to MAKEFLAGS only affected child makes, but it is now interpreted in
> the current make as soon as it is set.
> 
> [test code]
> 
>   $ cat /tmp/Makefile
>   ifneq ($(SUBMAKE),1)
>   MAKEFLAGS += --no-print-directory
>   all: ; $(MAKE) SUBMAKE=1
>   else
>   all: ; :
>   endif
> 
> [before 8f9e7722ff0f]
> 
>   $ make -C /tmp
>   make: Entering directory '/tmp'
>   make SUBMAKE=1
>   :
>   make: Leaving directory '/tmp'
> 
> [after 8f9e7722ff0f]
> 
>   $ make -C /tmp
>   make SUBMAKE=1
>   :
> 
> Previously, the effect of --no-print-directory was delayed until Kbuild
> started the directory descending, but it is no longer true with GNU Make
> 4.4.1.
> 
> This commit adds one more recursion to cater to GNU Make >= 4.4.1.
> 
> When Kbuild needs to change the working directory, __submake will be
> executed twice.
> 
>   __submake without --no-print-directory  --> show "Entering directory ..."
>   __submake with    --no-print-directory  --> parse the rest of Makefile
> 
> We end up with one more recursion than needed for GNU Make < 4.4.1, but
> I do not want to complicate the version check.
> 
> Reported-by: David Howells <dhowells@redhat.com>
> Closes: https://lore.kernel.org/all/2427604.1686237298@warthog.procyon.org.uk/
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> Changes in v2:
>   - Fix the code. V1 did not work.
>   - Remove the version check to simplify the code

Tested-by: Nicolas Schier <n.schier@avm.de>

> 
>  Makefile | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index cc3fe09c4dec..916c1a7984b0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -189,13 +189,6 @@ else
>  abs_objtree := $(CURDIR)
>  endif # ifneq ($(KBUILD_OUTPUT),)
>  
> -ifeq ($(abs_objtree),$(CURDIR))
> -# Suppress "Entering directory ..." unless we are changing the work directory.
> -MAKEFLAGS += --no-print-directory
> -else
> -need-sub-make := 1
> -endif
> -
>  this-makefile := $(lastword $(MAKEFILE_LIST))
>  abs_srctree := $(realpath $(dir $(this-makefile)))
>  
> @@ -214,6 +207,23 @@ endif
>  export abs_srctree abs_objtree
>  export sub_make_done := 1
>  
> +endif # sub_make_done
> +
> +ifeq ($(abs_objtree),$(CURDIR))
> +# Suppress "Entering directory ..." if we are at the final work directory.
> +no-print-directory := --no-print-directory
> +else
> +# Recursion to show "Entering directory ..."
> +need-sub-make := 1
> +endif
> +
> +ifeq ($(filter --no-print-directory, $(MAKEFLAGS)),)
> +# If --no-print-directory is unset, recurse once again to set it.
> +# You may end up with recursing into __sub-make twice. This is due to the
> +# behavior change for GNU Make 4.4.1.
> +need-sub-make := 1
> +endif
> +
>  ifeq ($(need-sub-make),1)
>  
>  PHONY += $(MAKECMDGOALS) __sub-make
> @@ -223,18 +233,12 @@ $(filter-out $(this-makefile), $(MAKECMDGOALS)) __all: __sub-make
>  
>  # Invoke a second make in the output directory, passing relevant variables
>  __sub-make:
> -	$(Q)$(MAKE) -C $(abs_objtree) -f $(abs_srctree)/Makefile $(MAKECMDGOALS)
> +	$(Q)$(MAKE) $(no-print-directory) -C $(abs_objtree) \
> +	-f $(abs_srctree)/Makefile $(MAKECMDGOALS)
>  
> -endif # need-sub-make
> -endif # sub_make_done
> +else # need-sub-make
>  
>  # We process the rest of the Makefile if this is the final invocation of make
> -ifeq ($(need-sub-make),)
> -
> -# Do not print "Entering directory ...",
> -# but we want to display it when entering to the output directory
> -# so that IDEs/editors are able to understand relative filenames.
> -MAKEFLAGS += --no-print-directory
>  
>  ifeq ($(abs_srctree),$(abs_objtree))
>          # building in the source tree
> -- 
> 2.39.2
> 
