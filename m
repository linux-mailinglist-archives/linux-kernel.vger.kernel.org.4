Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939FF74B492
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjGGPqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjGGPqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:46:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEBB173B;
        Fri,  7 Jul 2023 08:46:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32EEA619F7;
        Fri,  7 Jul 2023 15:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3241CC433C7;
        Fri,  7 Jul 2023 15:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688744807;
        bh=3wUUsaXCqiwwrVY4jOL3P/hQHlRF43O208Dodw1ZA/k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pHu6NRWtrXoOM0JOwFRfEZJFqCqcb93yP2xU1de6CUFWcqWvgkJbPtpYEUFmNG8+H
         4dho0Lw6Jj6ox+Tucusr1RYX3faS/6yxkmmeZZwu3HgR+KZb7VSLzKn1u9nq9vJ1X/
         o6us1eDtHC+01WYt9Imf34/iHMiDwWWoAo60KY+ngRi//XOJ/NzYZsG05yqEOVcpMx
         Z9JW/Q20fdj66Qnb2fMy7NBRayKPLGNHMiDIrsOhwt217ovDAdSUoCYeKcM88z7DOE
         S9GdgMpSEMTpytOExntKVhW2iNWXTm2Xwx5zsNWaM+T2PkJev0ugcnQnXspmvlVC1C
         6oFhE2OsuPQ4Q==
Date:   Sat, 8 Jul 2023 00:46:43 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] Revert
 "tracing: Add "(fault)" name injection to kernel probes"
Message-Id: <20230708004643.8f6335a2fa682d7dae1f0d0e@kernel.org>
In-Reply-To: <20230707101420.49b1fd54@gandalf.local.home>
References: <168873724526.2687993.15242662075324919195.stgit@mhiramat.roam.corp.google.com>
        <168873727209.2687993.6806850187024303094.stgit@mhiramat.roam.corp.google.com>
        <20230707101420.49b1fd54@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2023 10:14:20 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri,  7 Jul 2023 22:41:12 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > diff --git a/kernel/trace/trace_probe_kernel.h b/kernel/trace/trace_probe_kernel.h
> > index c4e1d4c03a85..6deae2ce34f8 100644
> > --- a/kernel/trace/trace_probe_kernel.h
> > +++ b/kernel/trace/trace_probe_kernel.h
> > @@ -2,8 +2,6 @@
> >  #ifndef __TRACE_PROBE_KERNEL_H_
> >  #define __TRACE_PROBE_KERNEL_H_
> >  
> > -#define FAULT_STRING "(fault)"
> > -
> 
> Instead of deleting this, why not use it in both places? After applying
> your patch, we have:
> 
>  $ git grep '(fault)' kernel/trace
> kernel/trace/trace_events_synth.c:                      strcpy(str_field, "(fault)");
> kernel/trace/trace_probe.c:             trace_seq_puts(s, "(fault)");
> 
> We could make that consistent with:
> 
> kernel/trace/trace_events_synth.c:                      strcpy(str_field, FAULT_STRING);
> kernel/trace/trace_probe.c:             trace_seq_puts(s, FAULT_STRING);

Indeed. So can I tweak the revert patch more for this?

I would like to move the definition to trace.h.

Thanks,

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
