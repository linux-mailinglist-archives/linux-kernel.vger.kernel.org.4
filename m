Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB3974F48D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbjGKQLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjGKQLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:11:34 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81525171E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:11:10 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b89d47ffb6so29828495ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689091870; x=1691683870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=14BF34CA+deUxHLUvuKK0NdUXrmzEpT2HQriQO+aNSc=;
        b=lAX+nmUnvQh8Wr4sSat33joYcFucraRvBlLjDezD4gl2CuEiTvYwK1rISc2zz7VGl3
         4Z9xm4yMTWpiCWj83z0n3GITD7+A8laRk8aL0Ab2ADl3io+anea7vTXZTAG1PvdDyofW
         w0Vyjl/9h85bclpewVFAtdHzjAJ7OSyEq+mpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689091870; x=1691683870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14BF34CA+deUxHLUvuKK0NdUXrmzEpT2HQriQO+aNSc=;
        b=JjyKatxB9z0+/Murwj7KstfiMym2s2ntaLUXLiSl4G7VHzr01UaLoggM5Ug5yNNIE1
         0jw2mDPyBItvxy+ft5v7TCwTf8qA9xhNwYWOKJ1m2SbU+OFT/CRIMu59yk82XtmfzUon
         4cUEVkXS2FwM7cmAWj5A8Pdktygs7XlhaH26zAkmhcfyg7dfz5UD7hXCgTxON16jOCdq
         /w6gR7WzL30GuRPtRwGDwUrPIYlrUGhX+MBadYhkaP92UPwjGEpssF7dPaFdVGgJS7BO
         D+HMyCAk7Hbgel0gU6Uhb6R1wPoxgT3rtyverePzerQOVtmqaBaYxE6b6pbc7MyjW4mq
         P9XQ==
X-Gm-Message-State: ABy/qLboqGOuGZJRwtqyj0J9mYJ8oGFJ7BzxA7j/9kqheKw5AM2y+nJ2
        gLu+r2Ka5rsACXzBbX5AOvn2Pw==
X-Google-Smtp-Source: APBJJlGtLe6pwcli4y1GKQQMwNq1rjUHkyjEzCkkqTqxZcuk3wugA2wX5iXhBtkX+30AaZAOZXOf2g==
X-Received: by 2002:a17:902:e548:b0:1b9:e1d5:c826 with SMTP id n8-20020a170902e54800b001b9e1d5c826mr4519362plf.16.1689091869978;
        Tue, 11 Jul 2023 09:11:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902c1d200b001b872695c1csm2098419plc.256.2023.07.11.09.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 09:11:08 -0700 (PDT)
Date:   Tue, 11 Jul 2023 09:11:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Ungerer <gerg@kernel.org>
Cc:     linux-arm@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, brauner@kernel.org
Subject: Re: [PATCH] fs: binfmt_elf_efpic: fix personality for fdpic ELF
Message-ID: <202307110901.7E9A0D0AE5@keescook>
References: <20230711133955.483393-1-gerg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711133955.483393-1-gerg@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 11:39:55PM +1000, Greg Ungerer wrote:
> The elf-fdpic loader hard sets the process personality to either
> PER_LINUX_FDPIC for true elf-fdpic binaries or to PER_LINUX for
> normal ELF binaries (in this case they would be constant displacement
> compiled with -pie for example). The problem with that is that it
> will lose any other bits that may be in the ELF header personality
> (such as the "bug emulation" bits).
> 
> On the ARM architecture the ADDR_LIMIT_32BIT flag is used to signify
> a normal 32bit binary - as opposed to a legacy 26bit address binary.
> This matters since start_thread() will set the ARM CPSR register as
> required based on this flag. If the elf-fdpic loader loses this bit
> the process will be mis-configured and crash out pretty quickly.
> 
> Modify elf-fdpic loaders personality setting for ELF binaries so that
> it preserves the upper three bytes by using the SET_PERSONALITY macro
> to set it. This macro in the generic case sets PER_LINUX but and
> preserves the upper bytes. Architectures can override this for their
> specific use case, and ARM does exactly this.

Thanks for tracking this down!

There are some twisty macros in use across all the architectures here!

I notice the bare set_personality() call remains, though. Is that right?

For example, ARM (and sh and xtensa) also sets:

#define elf_check_fdpic(x) ((x)->e_ident[EI_OSABI] == ELFOSABI_ARM_FDPIC)

so it's possible the first half of the "if" below could get executed,
and ARM (and possibly other architectures) would again lose the other
flags, if I'm reading correctly.

(And the fact that PER_LINUX is actually 0x0 is oddly handled, leaving
it implicit in most architectures.)

What seems perhaps more correct is to remove the "if" entirely and make
sure that SET_PERSONALITY() checks the header flags on all architectures?

But I'm less familiar with this area, so please let me know what I'm
missing. :)

> 
> Signed-off-by: Greg Ungerer <gerg@kernel.org>
> ---
> 
> Is anyone out there using elf-fdpic on ARM?

It would seem you're the first? :) (_Should_ it be usable on ARM?)

-Kees

> This seems to break it rather badly due to the loss of that ADDR_LIMIT_32BIT
> bit from the process personality.
> 
>  fs/binfmt_elf_fdpic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index a05eafcacfb2..f29ae1d96fd7 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -348,7 +348,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
>  	if (elf_check_fdpic(&exec_params.hdr))
>  		set_personality(PER_LINUX_FDPIC);
>  	else
> -		set_personality(PER_LINUX);
> +		SET_PERSONALITY(exec_params.hdr);
>  	if (elf_read_implies_exec(&exec_params.hdr, executable_stack))
>  		current->personality |= READ_IMPLIES_EXEC;
>  
> -- 
> 2.25.1
> 

-- 
Kees Cook
