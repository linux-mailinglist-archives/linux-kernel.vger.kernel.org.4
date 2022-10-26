Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE1260E4F6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiJZPmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiJZPmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:42:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5197DD88F;
        Wed, 26 Oct 2022 08:42:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BA8761FAD;
        Wed, 26 Oct 2022 15:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB704C433C1;
        Wed, 26 Oct 2022 15:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666798957;
        bh=JVjHGhtOduan1YHejgdu5cvny0hpSJ1Ttt+TrgSzmx0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QnBjOq5qqhBq2AHOTu1JO4o1st3C5s+ONPm4KBesyA4YS4EpKKrw9OXBaTaiWYXRb
         cvsIo9twFbcblerwE5wRD6EZ0N/JpwoAdQb3l5jRjNwkJaaj+74USs51AJ10k/M93S
         iOrXCrgmPtrvSoP93uqt1+syHxrUM1pZPIXXG8wUvEC9plnpeWoxkbXsmd2ZFOZ2h7
         h9O6yG47mgiTVir4fRqgw37JB1FHgPki1AZ80bZ1/1ZNEpiCOe5VqfR+Rl3a9hNfHO
         4yTDY5WWDdA4i+cHR0wrZPnMAudpeByOGGq3tY3wfKHt2gjRyWVuTzNcAHBDCxkQiM
         SXxr7QKAMk/cQ==
Date:   Thu, 27 Oct 2022 00:42:34 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Primiano Tucci <primiano@google.com>
Subject: Re: [PATCH 1/2] tracing/probes: Add symstr type for dynamic events
Message-Id: <20221027004234.6f3097f4bf4a18dfddf9ae56@kernel.org>
In-Reply-To: <166642073074.718058.9841757174640040227.stgit@mhiramat.roam.corp.google.com>
References: <166642072204.718058.1479401089273534841.stgit@mhiramat.roam.corp.google.com>
        <166642073074.718058.9841757174640040227.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Oct 2022 15:38:50 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add 'symstr' type for storing the kernel symbol as a string data
> instead of the symbol address. This allows us to filter the
> events by wildcard symbol name.
> 
> e.g.
>   # echo 'e:wqfunc workqueue.workqueue_execute_start symname=$function:symstr' >> dynamic_events
>   # cat events/eprobes/wqfunc/format
>   name: wqfunc
>   ID: 2110
>   format:
>   	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
>   	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
>   	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
>   	field:int common_pid;	offset:4;	size:4;	signed:1;
> 
>   	field:__data_loc char[] symname;	offset:8;	size:4;	signed:1;
> 
>   print fmt: " symname=\"%s\"", __get_str(symname)
> 
> Note that there is already 'symbol' type which just change the
> print format (so it still stores the symbol address in the tracing
> ring buffer.) On the other hand, 'symstr' type stores the actual
> "symbol+offset/size" data as a string.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
[...]
> diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
> index b3bdb8ddb862..d57a3143929a 100644
> --- a/kernel/trace/trace_probe_tmpl.h
> +++ b/kernel/trace/trace_probe_tmpl.h
> @@ -67,6 +67,37 @@ probe_mem_read(void *dest, void *src, size_t size);
>  static nokprobe_inline int
>  probe_mem_read_user(void *dest, void *src, size_t size);
>  
> +static nokprobe_inline int
> +fetch_store_symstrlen(unsigned long addr)
> +{
> +	char namebuf[KSYM_SYMBOL_LEN];
> +	int ret;
> +
> +	ret = sprint_symbol(namebuf, addr);
> +	if (ret < 0)
> +		return 0;
> +
> +	return strlen(namebuf) + 1;

Ah, sprint_symbol() returns the length. This strlen() is redundant.
Let me update the patch.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
