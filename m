Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F8A64E583
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 02:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiLPBDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 20:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLPBDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 20:03:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FEE18B2C;
        Thu, 15 Dec 2022 17:03:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B632661FD0;
        Fri, 16 Dec 2022 01:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F43FC433EF;
        Fri, 16 Dec 2022 01:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671152608;
        bh=TG9mwD1bCYgozmgjbn31WXW3pQLmSYbDf0pX94TUrus=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=grLATeZAdiYRz94xFfJHWjEfxaPBp8WvZfBHUJJs17I2+fKLgKInGnp9r6e0tnJqJ
         kMr2+Pvs8u96X6Xzr7gDUtCw0zFu2cIbc+cLjZmAvoO1cqCJSvM7SiDCoFFmBWNu1V
         wk10SR7so/73VnWZFhcBmr/KtKo9Z2npxZFGfi3tu59N2+Zwqavc6ij28sdWg43MXI
         aWUcJQI5415K4vFzYJerfNWMhBTmTgolEqaDStXTl5+/bQ75jdMbE3azog1hSeHQQ7
         YdESHnVAxH8sNG/qGz3NcFpy35CPWfLEOlc9k5pmx0cZUeh/+4V2VzXy2cXr42jzAe
         Lp8b2qBn/VfKg==
Date:   Fri, 16 Dec 2022 10:03:25 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-Id: <20221216100325.038848b5b427684cd439dcee@kernel.org>
In-Reply-To: <20221215163548.7c321bb0fac2343a8ef7d202@linux-foundation.org>
References: <20221216112121.4bcb5c43@canb.auug.org.au>
        <20221215163548.7c321bb0fac2343a8ef7d202@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2022 16:35:48 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 16 Dec 2022 11:21:21 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Hi all,
> > 
> > After merging the mm tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> > 
> > In file included from fs/btrfs/tree-checker.c:20:
> > include/linux/error-injection.h: In function 'get_injectable_error_type':
> > include/linux/error-injection.h:22:17: error: 'EOPNOTSUPP' undeclared (first use in this function)
> >    22 |         return -EOPNOTSUPP;
> >       |                 ^~~~~~~~~~
> > include/linux/error-injection.h:22:17: note: each undeclared identifier is reported only once for each function it appears in
> > 
> > Caused by commit
> > 
> >   fcb9954aa1dc ("error-injection: remove EI_ETYPE_NONE")
> > 
> > I have reverted that commit for today (and the following one).
> 
> Thanks.  I'll try the obvious:

I sent v2 but it seems to be missed.

https://lore.kernel.org/all/167094068123.608798.9238149148720683524.stgit@devnote3/T/#u

Either your patch or v2 are OK for me. (doing the same thing)

Thank you,

> 
> --- a/include/linux/error-injection.h~error-injection-remove-ei_etype_none-fix
> +++ a/include/linux/error-injection.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/compiler.h>
>  #include <asm-generic/error-injection.h>
> +#include <linux/errno.h>
>  
>  #ifdef CONFIG_FUNCTION_ERROR_INJECTION
>  
> _
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
