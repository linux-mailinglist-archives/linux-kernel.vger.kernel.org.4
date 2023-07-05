Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265F1748919
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjGEQUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjGEQUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:20:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE221703;
        Wed,  5 Jul 2023 09:20:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F414614CB;
        Wed,  5 Jul 2023 16:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62C5C433C8;
        Wed,  5 Jul 2023 16:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688574028;
        bh=G7AHsttbExuu7iAPGPc7tUyss2l3OZIYar6Xamqq4x0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bNbX5gJWlwKzmQM0I/oXUZ+R7essa/oB6vnimg9rh+m3t66g+SYMclgzVs2MDvEj3
         VmVOHYNMYPgkJJyC0vDP6+wpc6n8wNHz7lmjrE61vSP9/I7IV+gJkWF3KFmbEqernD
         dOe87ihG9SvM7Uu3I8Qss7XOMOl1djcULa9yG3nlFcTUWsD4x/zKXI7bTCSBHqjiPH
         6nNWRIhgpzwlMuOX+4eYRkLhusbzmdFHkQRh0/7cGuJx0/J3RaXKMoJZtBecMk1vPS
         sYfFSHI3+Xyytd7Lx0D9tD1VaNAjMYLrGHaVh7hK1L00yScCdbkJ0V7BD7rJNdT4se
         SzfodwUwkSLog==
Date:   Wed, 5 Jul 2023 09:20:26 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kbuild@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kbuild: Enable -Wenum-conversion by default
Message-ID: <20230705162026.GA2951@dev-arch.thelio-3990X>
References: <20230704221951.7396-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704221951.7396-1-bp@alien8.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 12:19:51AM +0200, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> This diagnostic checks whether there is a type mismatch when
> converting enums (assign an enum of type A to an enum of type B, for
> example) and it caught a legit issue recently. The reason it didn't show
> is because that warning is enabled only with -Wextra with GCC. Clang,
> however, enables it by default.
> 
> GCC folks were considering enabling it by default but it was too noisy
> back then:
> 
>   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=78736
> 
> Now that due to clang all those warnings have been fixed, enable it with
> GCC too.
> 
> allmodconfig tests done with: x86, arm{,64}, powerpc{,64}, riscv
> crossbuilds.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

Yes please :)

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 7a5a175f708f..428132b3d6dd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1082,6 +1082,9 @@ KBUILD_CFLAGS   += $(call cc-option,-Werror=incompatible-pointer-types)
>  # Require designated initializers for all marked structures
>  KBUILD_CFLAGS   += $(call cc-option,-Werror=designated-init)
>  
> +# Warn if there is an enum types mismatch
> +KBUILD_CFLAGS	+= $(call cc-option,-Wenum-conversion)
> +
>  # change __FILE__ to the relative path from the srctree
>  KBUILD_CPPFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
>  
> -- 
> 2.41.0
> 
