Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8E4747382
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjGDOAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjGDOAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:00:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29B11704
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 06:59:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88CC561173
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 13:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC5BC433C7;
        Tue,  4 Jul 2023 13:59:57 +0000 (UTC)
Date:   Tue, 4 Jul 2023 09:59:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Donglin Peng <pengdonglin@sangfor.com.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Florent Revest <revest@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: ftrace: fix build error with
 CONFIG_FUNCTION_GRAPH_TRACER=n
Message-ID: <20230704095953.6665eaf6@rorschach.local.home>
In-Reply-To: <ZJ78nyYR9ZDo+xWL@arm.com>
References: <20230623152204.2216297-1-arnd@kernel.org>
        <ZJ78nyYR9ZDo+xWL@arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 17:02:39 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:
> > diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> > index 757d01a68ffd0..5ff1942b04fcf 100644
> > --- a/arch/arm64/kernel/asm-offsets.c
> > +++ b/arch/arm64/kernel/asm-offsets.c
> > @@ -213,9 +213,9 @@ int main(void)
> >    DEFINE(FGRET_REGS_X7,			offsetof(struct fgraph_ret_regs, regs[7]));
> >    DEFINE(FGRET_REGS_FP,			offsetof(struct fgraph_ret_regs, fp));
> >    DEFINE(FGRET_REGS_SIZE,		sizeof(struct fgraph_ret_regs));
> > +#endif
> >  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> >    DEFINE(FTRACE_OPS_DIRECT_CALL,	offsetof(struct ftrace_ops, direct_call));
> > -#endif
> >  #endif
> >    return 0;
> >  }  
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Steven, since the fixed commit went in via your tree, could you please
> pick this up as well for -rc1? Otherwise I'll queue it for -rc2 once the
> ftrace changes turn up in -rc1.

I'm working on a fixes pull request for Linus. I'll apply this to it
and start my testing on it. I should have a pull request to Linus
before the end of the week.

-- Steve

