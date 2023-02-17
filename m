Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E1969A375
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 02:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjBQBfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 20:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQBf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 20:35:27 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE31038EAE;
        Thu, 16 Feb 2023 17:35:24 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PHvWp0pQsz4x82;
        Fri, 17 Feb 2023 12:35:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1676597719;
        bh=Mr5UOSzMz1dF6Hwpyx5WmT4Yp7+jw+UVJVzxUI67Y90=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jJrlPrrqLIOcOrprv8svriZs0WsrN10uCdmke9m9QoWSY5OBgJKjBOzWqkwIO9e5n
         0eYLjw5+WSDG6eQNtn8y3M4O0Rpj82s6Vitc/sIZLoOaLQPepDlzH0kO69krn+uQVQ
         pF5QDgKdxvAB80hclDX96o2HRMN05YDMqniwaYg7jcOS0C4bZ/qXdiDO9DDfzDNrTy
         rneoIYMZ+6f8cx+W1cEWGeGOh473fjPp4RMP9QjsIjLIbV4IgykjuX/whrVk2Wclpb
         xdPIS37QfOPGZdrF93VNzXsJ8/uZnIeJYA6EhW48sM7JqvBmE5j0I/c2MySSH5jV3z
         3iVh70GdxU/Jg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the powerpc tree
In-Reply-To: <20230216180607.w666rnbtm5fumziq@treble>
References: <20230216144031.45b1fc12@canb.auug.org.au>
 <20230216180607.w666rnbtm5fumziq@treble>
Date:   Fri, 17 Feb 2023 12:35:17 +1100
Message-ID: <87k00hysyy.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Poimboeuf <jpoimboe@kernel.org> writes:
> On Thu, Feb 16, 2023 at 02:40:31PM +1100, Stephen Rothwell wrote:
>> Hi all,
>> 
>> After merging the powerpc tree, today's linux-next build (powerpc
>> pseries_le_defconfig) produced this warning:
>> 
>> arch/powerpc/kernel/head_64.o: warning: objtool: .text+0x6128: unannotated intra-function call
>> 
>> I have no idea what caused this.
>
> Adding Sathvika and Christophe.
>
> The short term fix would be something like the below, but...
>
> If powerpc objtool is only doing mcount, does it even make sense to run
> objtool on asm files?  If so, there are probably a lot more cleanups
> needed for the asm code.

I would like to enable more of the objtool checks eventually, although I
don't have a timeline for that. But I'd prefer to keep checking the asm
code seeing as we've already enabled that.

> So I'm thinking either we should cleanup all the powerpc asm code with
> annotations like below, or we should try to make objtool mcount-mode
> ignore asm files.

I think we have most of the code annotated already, this is a new
warning because that code is newly refactored by a commit I applied.

I'll have to fix my build scripts to error out on objtool warnings.

cheers


> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index 3a7266fa8a18..1febb56ebaeb 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -472,7 +472,7 @@ SYM_FUNC_START_LOCAL(__mmu_off)
>  	b	.	/* prevent speculative execution */
>  SYM_FUNC_END(__mmu_off)
>  
> -start_initialization_book3s:
> +SYM_FUNC_START_LOCAL(start_initialization_book3s)
>  	mflr	r25
>  
>  	/* Setup some critical 970 SPRs before switching MMU off */
> @@ -494,6 +494,7 @@ start_initialization_book3s:
>  
>  	mtlr	r25
>  	blr
> +SYM_FUNC_END(start_initialization_book3s)
>  #endif
>  
>  /*
