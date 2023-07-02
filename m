Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E7A744BF4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 03:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjGBBIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 21:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGBBIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 21:08:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6301717;
        Sat,  1 Jul 2023 18:08:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF88B601BE;
        Sun,  2 Jul 2023 01:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3ADEC433C8;
        Sun,  2 Jul 2023 01:08:41 +0000 (UTC)
Date:   Sat, 1 Jul 2023 21:08:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] tracing/probes: Fix to avoid double count of the
 string length on the array
Message-ID: <20230701210840.5cb46a79@rorschach.local.home>
In-Reply-To: <168804801788.2028538.4620519547242506783.stgit@mhiramat.roam.corp.google.com>
References: <8819b154-2ba1-43c3-98a2-cbde20892023@moroto.mountain>
        <168804801788.2028538.4620519547242506783.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 23:13:37 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> If there is an array is specified with the ustring or symstr, the length of

 "If there is an array specified with ustring or .." or "If an array is specified with ustring"

I prefer the latter.

> the strings are accumlated on both of 'ret' and 'total', which means the
> length is double counted.
> Just set the length to the 'ret' value to aviud double count.

					"avoid"

> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/8819b154-2ba1-43c3-98a2-cbde20892023@moroto.mountain/
> Fixes: 88903c464321 ("tracing/probe: Add ustring type for user-space string")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_probe_tmpl.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
> index 00707630788d..4735c5cb76fa 100644
> --- a/kernel/trace/trace_probe_tmpl.h
> +++ b/kernel/trace/trace_probe_tmpl.h
> @@ -156,11 +156,11 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
>  			code++;
>  			goto array;
>  		case FETCH_OP_ST_USTRING:
> -			ret += fetch_store_strlen_user(val + code->offset);
> +			ret = fetch_store_strlen_user(val + code->offset);
>  			code++;
>  			goto array;
>  		case FETCH_OP_ST_SYMSTR:
> -			ret += fetch_store_symstrlen(val + code->offset);
> +			ret = fetch_store_symstrlen(val + code->offset);

Other than the above,

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


>  			code++;
>  			goto array;
>  		default:

