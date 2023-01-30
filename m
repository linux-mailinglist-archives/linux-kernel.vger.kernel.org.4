Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175446814BC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbjA3PUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238209AbjA3PUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:20:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E4238648;
        Mon, 30 Jan 2023 07:19:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37814B81185;
        Mon, 30 Jan 2023 15:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150FDC433D2;
        Mon, 30 Jan 2023 15:19:48 +0000 (UTC)
Date:   Mon, 30 Jan 2023 10:19:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pietro Borrello <borrello@diag.uniroma1.it>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/probe: trace_probe_primary_from_call(): checked
 list_first_entry
Message-ID: <20230130101947.311010c2@gandalf.local.home>
In-Reply-To: <20230128-list-entry-null-check-v1-1-8bde6a3da2ef@diag.uniroma1.it>
References: <20230128-list-entry-null-check-v1-1-8bde6a3da2ef@diag.uniroma1.it>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jan 2023 16:23:41 +0000
Pietro Borrello <borrello@diag.uniroma1.it> wrote:

> All callers of trace_probe_primary_from_call() check the return
> value to be non NULL. However, the function returns
> list_first_entry(&tpe->probes, ...) which can never be NULL.
> Additionally, it does not check for the list being possibly empty,
> possibly causing a type confusion on empty lists.
> Use list_first_entry_or_null() which solves both problems.
> 
> Fixes: 60d53e2c3b75 ("tracing/probe: Split trace_event related data from trace_probe")
> Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
> ---
>  kernel/trace/trace_probe.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 23acfd1c3812..f6b565dced56 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -307,7 +307,7 @@ trace_probe_primary_from_call(struct trace_event_call *call)
>  {
>  	struct trace_probe_event *tpe = trace_probe_event_from_call(call);
>  
> -	return list_first_entry(&tpe->probes, struct trace_probe, list);
> +	return list_first_entry_or_null(&tpe->probes, struct trace_probe, list);
>  }
>  
>  static inline struct list_head *trace_probe_probe_list(struct trace_probe *tp)

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> 
> ---
> base-commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
> change-id: 20230128-list-entry-null-check-37778efda18c
> 
> Best regards,

