Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201FC697F4A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjBOPQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBOPQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:16:17 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0483402D;
        Wed, 15 Feb 2023 07:15:50 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-16e353ce458so5717832fac.9;
        Wed, 15 Feb 2023 07:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYFKKjDn0nhmev+Hzlv1MO+o7pRZRef8Zb0/GHioFrI=;
        b=c+chdkp09iaUUUmJgGIHYJMBEefx7NMHlRgn4S0rHyaL6erqqEi47NlfNU+iEHXqy8
         JaD7gAsqhys0Ff2tI/2NyVJwO1QLqFjiSJHvwaEWqWXVbuSFzgaooM4UkbLYIJbvBJmT
         xKaIpS4auq/agvSpve3sm8sZ2kNR6ZNRKV71gJIHwgjOriNyWnhnOjQYftz3ag9jB7+A
         q8EALSD53L5VZ5Cq4i+8DOPHvjX98iaDF6+XG5blnS7mZ7FD6JElDveupXjIMiSx9FOR
         of18p7gkkB7Azc8H05K8LErLFK6A9CZEbVDVrOFCdCd6m6iHJSDUnTPEaBbou3+dPDBd
         BRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYFKKjDn0nhmev+Hzlv1MO+o7pRZRef8Zb0/GHioFrI=;
        b=Nj+DozNPz+BfgGeUoyIouihbuwHvvAazpBAHnhlIa3vBUy94IYJBRHPlpDjVwRqhMa
         F3hKbZvWHuuBp5lQH5u7uN+sxDKM8GHy6NnCr3kp2gdrG0e6JnBeB4pF1FiqDCdWZAPV
         heJ6V5ZOyXQawuNg4dy3aN9tI4j0D1BFgHhib5t/O4ZKT2gP1YYihWRxkxmhZeh+ZICx
         pelRvYKaYLC/Tvsf+V1jKDR93X/mjIO8vRqkyQXruaXyQNEUMzWTjQNEsfwSZP/PfoLo
         gRH2niyeNqKGR/btuY6VY2DfLfZvfs/dRph3iCwWto6anxnWlOVnT8R9FmUmj/fakzCx
         OP0g==
X-Gm-Message-State: AO0yUKX5ONufNZvbzhZtFun3UTO349E8gRPjdIjTK4P/N+JTjQc9XH3c
        A6ZDkTtFJd9qvnKUw/XSqvE=
X-Google-Smtp-Source: AK7set8q33o5Ctwu+YZMd4w+/Qt21cCGL/F+yk6gMyaShTnWijOSpEf8wmG5aKjzmjn9vPNk3ENbWw==
X-Received: by 2002:a05:6870:b6a9:b0:144:3ed1:1ec2 with SMTP id cy41-20020a056870b6a900b001443ed11ec2mr1259684oab.43.1676474149418;
        Wed, 15 Feb 2023 07:15:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j17-20020a056870d45100b0016e5ad3e892sm427387oag.14.2023.02.15.07.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 07:15:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 15 Feb 2023 07:15:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ia64@vger.kernel.org
Subject: Re: [RFC PATCH] MAINTAINERS: Mark Itanium/IA64 as 'dead'
Message-ID: <20230215151547.GA3766362@roeck-us.net>
References: <20230128122904.1345120-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128122904.1345120-1-ardb@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 01:29:04PM +0100, Ard Biesheuvel wrote:
> Create a new status 'dead' which conveys that a subsystem is
> unmaintained and scheduled for removal, and developers are free to
> behave as if it's already gone. Also, automated build tests should
> ignore such subsystems, or at least notify only those who are known to
> have an interest in the subsystem in particular.
> 
> Given that Itanium/IA64 has no maintainer, is no longer supported in
> QEMU (for boot testing under emulation) and does not seem to have a user
> base beyond a couple of machines used by distros to churn out packages,
> let's mark it as dead. This shall mean that any treewide changes (such
> as changes to the EFI subsystem, which I maintain) can be made even if
> they might cause build or boot time regressions on IA64 machines. Also,
> mark the port as scheduled for removal after the next LTS release.
> 

Since this just came up, I very much prefer complete removal. I don't
see the point of keeping dead code in the tree. That is still hidden
maintenance effort.

If this proliferates, we'll end up having to parse the MAINTAINERS file
for code marked "Dead" to ensure that we don't accidentally send e-mails
to the wrong people, or we risk getting complaints about sending reports
for such code. That puts extra burden on maintainers of automated test
beds, which I think is not really appropriate. If the code is dead,
remove it, period.

For my part, I'll drop my test bed support immediately after this patch
made it in, following the guidance above.

Guenter

> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Jessica Clarke <jrtc27@jrtc27.com>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-ia64@vger.kernel.org
> Link: https://lore.kernel.org/all/CAMj1kXEqbMEcrKYzz2-huLPMnotPoxFY8adyH=Xb4Ex8o98x-w@mail.gmail.com/
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  MAINTAINERS | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b74014994f5c1cc..5481967c2112e8ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -94,6 +94,14 @@ Descriptions of section entries and preferred order
>  	   Obsolete:	Old code. Something tagged obsolete generally means
>  			it has been replaced by a better system and you
>  			should be using that.
> +	   Dead:	Code has no maintainer and no significant user base,
> +			and is scheduled for removal. Developers are free to
> +			ignore it when it comes to testing bug fixes or other
> +			code changes, and automated build test systems must not
> +			report any detected issues, except possibly to mailing
> +			lists or other recipients that have opted in
> +			specifically to receiving reports about the state of
> +			this code.
>  	W: *Web-page* with status/info
>  	Q: *Patchwork* web based patch tracking system site
>  	B: URI for where to file *bugs*. A web-page with detailed bug
> @@ -9833,7 +9841,7 @@ F:	include/linux/i3c/
>  
>  IA64 (Itanium) PLATFORM
>  L:	linux-ia64@vger.kernel.org
> -S:	Orphan
> +S:	Dead # to be removed after the 2023 LTS release
>  F:	Documentation/ia64/
>  F:	arch/ia64/
>  
> -- 
> 2.39.0
> 
