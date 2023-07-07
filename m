Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F83374AB94
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjGGHH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjGGHHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:07:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2396C1BF4;
        Fri,  7 Jul 2023 00:07:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AE39617BC;
        Fri,  7 Jul 2023 07:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75569C433C9;
        Fri,  7 Jul 2023 07:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688713672;
        bh=3UTkCpBwK2iQHAtoeNbf/AKfzPq8aQb03fC1G6e4X5c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vGLlCf3CCce1n1q1ujTHKwBviDH77kuZGTiWiTVLtd6VIM31Ifaxd6YmENJ0xQfCM
         CtTWwfryWM3AHwPd3mCFpkzoZegxWqXLIeHHu7akXoUV2PQYGRaF64rertbsYUEJzT
         7JC8OFPk8l/svUiam94JYHMkCZQr+oLsr1u52s4HyXjkqggC0dFPCUnD5uTZuv2qfj
         Uv3JV/uyo5F6qfbctfXPaqFyjE05ZeEXoDfd8fEEYOSEBOECQiKHkBgF93jLjFuW4r
         sp3Hr0P/oBjbfYg8Qvjhw/zhuG++7KMyOrFDXvxthWLyA+2ARB/py9BGqjVnDq7ELp
         6sClYzJubnwiA==
Date:   Fri, 7 Jul 2023 16:07:49 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] tracing/probes: Fix to exit fetching if an error is
 detected
Message-Id: <20230707160749.0dcf02cf0b7ee9e0ded2816e@kernel.org>
In-Reply-To: <168830924625.2278819.7022958622963157629.stgit@mhiramat.roam.corp.google.com>
References: <168830922841.2278819.9165254236027770818.stgit@mhiramat.roam.corp.google.com>
        <168830924625.2278819.7022958622963157629.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  2 Jul 2023 23:47:26 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fix to exit fetching arguments if an error is detected when storing
> strings. Without this fix, if an array is specified with string types
> it may store the data at the wrong address.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/8819b154-2ba1-43c3-98a2-cbde20892023@moroto.mountain/
> Fixes: 9b960a38835f ("tracing: probeevent: Unify fetch_insn processing common part")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_probe_tmpl.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
> index 4735c5cb76fa..d6f2bf69f9bc 100644
> --- a/kernel/trace/trace_probe_tmpl.h
> +++ b/kernel/trace/trace_probe_tmpl.h
> @@ -193,6 +193,8 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
>  	default:
>  		return -EILSEQ;
>  	}
> +	if (ret < 0)
> +		return ret;

I found this will leave a garbage data on the trace data if we are in the array.
Let me fix this issue.
(-EILSEQ case has another issue. I think it should not be recorded)

Thank you,

>  	code++;
>  
>  	/* 4th stage: modify stored value if needed */
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
