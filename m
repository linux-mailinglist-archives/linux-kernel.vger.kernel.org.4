Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E73C73A017
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjFVLtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjFVLts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:49:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD6C198
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/hBMqGEXGgKsMRT6giEKvNALvuKz9PGl6SIeiNVw60M=; b=NSW0YUyKBLRQdO1HniWQcK82rY
        nKb4X3Kuft9OpacchKUitlQOF1fyat92vX5xDHykr9W2yOpZOHJV8mT2KoxOTJKKQy7LsF7a1GvCa
        Dni3GbLm3CpGZhJxxwZ6l6Yw5AoIJ0UNMCot0IAF827MqI4MmmDJBlxqRAjlnHxU/0QFgXjZ51wqr
        Mn2wHLgdkkmORGzbSTrN/omnp1oZs74bUZpgyWfcmwbL1THK5nYQ6luNCmtVMWun29BNUEvxWTxt8
        b25AlDk2EmO70AEyV4PUMJQteDWxci+Z3lVKboCzllYu2n89QdF9TGJlWAW/AKZC3QmWbrLoCxwtJ
        Jfi0yMFw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qCIoW-001Aqe-2q;
        Thu, 22 Jun 2023 11:49:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 87C6B300137;
        Thu, 22 Jun 2023 13:49:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 77E1224263362; Thu, 22 Jun 2023 13:49:24 +0200 (CEST)
Date:   Thu, 22 Jun 2023 13:49:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Naveen N Rao <naveen@kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 12/14] objtool: Add support for more complex UACCESS
 control
Message-ID: <20230622114924.GN4253@hirez.programming.kicks-ass.net>
References: <cover.1687430631.git.christophe.leroy@csgroup.eu>
 <02c7ecdfe636f078027fc110ab73b90331d9eb70.1687430631.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02c7ecdfe636f078027fc110ab73b90331d9eb70.1687430631.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 12:54:34PM +0200, Christophe Leroy wrote:
> On x86, UACCESS is controlled by two instructions: STAC and CLAC.
> STAC instruction enables UACCESS while CLAC disables UACCESS.
> This is simple enough for objtool to locate UACCESS enable and
> disable.
> 
> But on powerpc it is a bit more complex, the same instruction is
> used for enabling and disabling UACCESS, and the same instruction
> can be used for many other things. It would be too complex to use
> exclusively instruction decoding.
> 
> To help objtool, mark such instruction into .discard.uaccess_begin
> and .discard.uaccess_end sections, on the same principle as for
> reachable/unreachable instructions. And add ASM_UACCESS_BEGIN
> and ASM_UACCESS_END macros to be used in inline assembly code to
> annotate UACCESS enable and UACCESS disable instructions.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  include/linux/objtool.h | 14 +++++++++++++
>  tools/objtool/check.c   | 44 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/include/linux/objtool.h b/include/linux/objtool.h
> index 03f82c2c2ebf..d8fde4158a40 100644
> --- a/include/linux/objtool.h
> +++ b/include/linux/objtool.h
> @@ -57,6 +57,18 @@
>  	".long 998b - .\n\t"						\
>  	".popsection\n\t"
>  
> +#define ASM_UACCESS_BEGIN						\
> +	"998:\n\t"							\
> +	".pushsection .discard.uaccess_begin\n\t"			\
> +	".long 998b - .\n\t"						\
> +	".popsection\n\t"
> +
> +#define ASM_UACCESS_END							\
> +	"998:\n\t"							\
> +	".pushsection .discard.uaccess_end\n\t"				\
> +	".long 998b - .\n\t"						\
> +	".popsection\n\t"
> +
>  #else /* __ASSEMBLY__ */

Yeah, this can work. Josh wanted a more generic hints infra, but I'm not
sure we should make you do that work now.
