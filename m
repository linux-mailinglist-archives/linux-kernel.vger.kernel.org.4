Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40F374E55B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjGKDeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGKDeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:34:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D72E8;
        Mon, 10 Jul 2023 20:34:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18037612D5;
        Tue, 11 Jul 2023 03:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1523C433C7;
        Tue, 11 Jul 2023 03:34:03 +0000 (UTC)
Date:   Mon, 10 Jul 2023 23:34:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] tracing/probes: Fix to record 0-length data_loc
 in fetch_store_string*() if fails
Message-ID: <20230710233400.5aaf024e@gandalf.local.home>
In-Reply-To: <168904151104.2908673.8401909922292791503.stgit@mhiramat.roam.corp.google.com>
References: <168904147563.2908673.18054267804278861545.stgit@mhiramat.roam.corp.google.com>
        <168904151104.2908673.8401909922292791503.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Tue, 11 Jul 2023 11:11:51 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> --- a/kernel/trace/trace_probe_tmpl.h
> +++ b/kernel/trace/trace_probe_tmpl.h
> @@ -267,9 +267,7 @@ store_trace_args(void *data, struct trace_probe *tp, void *rec,
>  		if (unlikely(arg->dynamic))
>  			*dl = make_data_loc(maxlen, dyndata - base);
>  		ret = process_fetch_insn(arg->code, rec, dl, base);
> -		if (unlikely(ret < 0 && arg->dynamic)) {
> -			*dl = make_data_loc(0, dyndata - base);
> -		} else {
> +		if (unlikely(ret > 0 && arg->dynamic)) {

To match the current code, that should be:

		if (likely(ret >= 0 || !arg->dynamic)) {

But I'm guessing that the original code was buggy, as the else block should
only have been processed if arg->dynamic was set? That is, it should have been:

	if (arg->dynamic) {
		if (unlikely(ret < 0)) {
			*dl = make_data_loc(0, dyndata - base);
		} else {
  			dyndata += ret;
  			maxlen -= ret;
  		}
	}


I guess you only want to update if arg->dynamic is true (even though that
wasn't the case before :-/) But in any case, I think you want likely() and
not unlikely().

		if (arg->dynamic && likely(ret > 0)) {

That is, if we only want to updated this if the arg is dynamic.

And I don't think that the arg->dynamic() should have likely/unlikely
around it, as that's determined by user space, and the kernel should not be
adding assumptions about what user space wants.

-- Steve

>  			dyndata += ret;
>  			maxlen -= ret;
>  		}
