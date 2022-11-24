Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835776379EE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiKXN2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiKXN2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:28:24 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A84EE0EB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:28:23 -0800 (PST)
Received: from zn.tnic (p200300ea9733e75b329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e75b:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3032A1EC0495;
        Thu, 24 Nov 2022 14:28:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669296502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TaewtBDqu/25yf994GoEuh2zYLDng8qjigaVQ1a0K4s=;
        b=SbVhENhafFgnim1V36S6iVUKMezXbe45j39COpUhd1soYaGLp7QFv0k7XjQFy0RmES4RxU
        j5JjT1hwld9O5UxgxOdbN4h+IWSAzYsTIL+/dRqJiPnk0QngX+Nfx5c7y/bH4esqY4K1s4
        rPW3eB3RyGATypLILLooN+oN8KNmlow=
Date:   Thu, 24 Nov 2022 14:28:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3] x86/boot: skip realmode init code when running as Xen
 PV guest
Message-ID: <Y39xcnKCkbYQZjaE@zn.tnic>
References: <20221123114523.3467-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221123114523.3467-1-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 12:45:23PM +0100, Juergen Gross wrote:
> When running as a Xen PV guest there is no need for setting up the
> realmode trampoline, as realmode isn't supported in this environment.
> 
> Trying to setup the trampoline has been proven to be problematic in
> some cases, especially when trying to debug early boot problems with
> Xen requiring to keep the EFI boot-services memory mapped (some
> firmware variants seem to claim basically all memory below 1M for boot
> services).
> 
> Introduce new x86_platform_ops operations for that purpose, which can
> be set to a nop by the Xen PV specific kernel boot code.
> 
> Fixes: 084ee1c641a0 ("x86, realmode: Relocator for realmode code")

This text and Fixes: tag sounds like this needs to go to Linus and
stable now?

> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index 41d7669a97ad..247aca9f8ed1 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -200,14 +200,18 @@ static void __init set_real_mode_permissions(void)
>  	set_memory_x((unsigned long) text_start, text_size >> PAGE_SHIFT);
>  }
>  
> -static int __init init_real_mode(void)
> +void __init init_real_mode(void)
>  {
>  	if (!real_mode_header)
>  		panic("Real mode trampoline was not allocated");
>  
>  	setup_real_mode();
>  	set_real_mode_permissions();
> +}
>  
> +static int __init call_init_real_mode(void)
> +{
> +	x86_platform.realmode_init();
>  	return 0;
>  }
> -early_initcall(init_real_mode);
> +early_initcall(call_init_real_mode);

I'll name that one "do_init_real_mode" as "call init" sounds weird.

Otherwise, it is as straightforward as it gets.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
