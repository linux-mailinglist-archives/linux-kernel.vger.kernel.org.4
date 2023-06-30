Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79131743F62
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjF3QC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjF3QCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:02:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE72C3C2A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:02:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37B4C61798
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 16:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A283C433C0;
        Fri, 30 Jun 2023 16:02:41 +0000 (UTC)
Date:   Fri, 30 Jun 2023 17:02:39 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Donglin Peng <pengdonglin@sangfor.com.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Florent Revest <revest@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: ftrace: fix build error with
 CONFIG_FUNCTION_GRAPH_TRACER=n
Message-ID: <ZJ78nyYR9ZDo+xWL@arm.com>
References: <20230623152204.2216297-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623152204.2216297-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 05:21:55PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> It appears that a merge conflict ended up hiding a newly added constant
> in some configurations:
> 
> arch/arm64/kernel/entry-ftrace.S: Assembler messages:
> arch/arm64/kernel/entry-ftrace.S:59: Error: undefined symbol FTRACE_OPS_DIRECT_CALL used as an immediate value
> 
> FTRACE_OPS_DIRECT_CALL is still used when CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> is enabled, even if CONFIG_FUNCTION_GRAPH_TRACER is disabled, so change the
> ifdef accordingly.
> 
> Fixes: 3646970322464 ("arm64: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/kernel/asm-offsets.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index 757d01a68ffd0..5ff1942b04fcf 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -213,9 +213,9 @@ int main(void)
>    DEFINE(FGRET_REGS_X7,			offsetof(struct fgraph_ret_regs, regs[7]));
>    DEFINE(FGRET_REGS_FP,			offsetof(struct fgraph_ret_regs, fp));
>    DEFINE(FGRET_REGS_SIZE,		sizeof(struct fgraph_ret_regs));
> +#endif
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>    DEFINE(FTRACE_OPS_DIRECT_CALL,	offsetof(struct ftrace_ops, direct_call));
> -#endif
>  #endif
>    return 0;
>  }

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Steven, since the fixed commit went in via your tree, could you please
pick this up as well for -rc1? Otherwise I'll queue it for -rc2 once the
ftrace changes turn up in -rc1.

Thanks.

-- 
Catalin
