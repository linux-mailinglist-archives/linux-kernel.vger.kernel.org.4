Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EA360B5B6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiJXSiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiJXShg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:37:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A36746DA0;
        Mon, 24 Oct 2022 10:19:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 707956147C;
        Mon, 24 Oct 2022 16:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38206C433C1;
        Mon, 24 Oct 2022 16:19:16 +0000 (UTC)
Date:   Mon, 24 Oct 2022 12:19:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: Add trace events for rate requests
Message-ID: <20221024121926.1f11c57a@gandalf.local.home>
In-Reply-To: <20221018-clk-rate-request-tracing-v1-2-6f3aa0b0b9de@cerno.tech>
References: <20221018-clk-rate-request-tracing-v1-0-6f3aa0b0b9de@cerno.tech>
        <20221018-clk-rate-request-tracing-v1-2-6f3aa0b0b9de@cerno.tech>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 15:56:42 +0200
Maxime Ripard <maxime@cerno.tech> wrote:

I know I reviewed this but looking at this again, I noticed:


> +DECLARE_EVENT_CLASS(clk_rate_request,
> +
> +	TP_PROTO(struct clk_rate_request *req),
> +
> +	TP_ARGS(req),
> +
> +	TP_STRUCT__entry(
> +		__string(        name, req->core ? req->core->name : "none")
> +		__field(unsigned long,           min                       )
> +		__field(unsigned long,           max                       )
> +		__string(       pname, req->best_parent_hw ? clk_hw_get_name(req->best_parent_hw) : "none" )

It may be best to move the two __string() declarations together. The reason
is that dynamic strings (which __string() is) uses 4 bytes embedded in the
first part of the event. Two bytes for offset, where the dynamic string
exists, and two bytes for the strings length.

On 64 bit machines the above has:

	__string()		4 bytes
	__field(unsigned long)	8 bytes
	__field(unsigned long)	8 bytes
	__string()		4 bytes

and then another unsigned long field below, which is another 8 bytes.

> +		__field(unsigned long,           prate                     )
> +	),
> +
> +	

As compilers tend to use word alignment, the above turns into:

	__string()		4 bytes

	__PADDING__		4 bytes

	__field(unsigned long)	8 bytes
	__field(unsigned long)	8 bytes
	__string()		4 bytes

	__PADDING__		4 bytes

	__field(unsigned long)	8 bytes


Where there will be 8 bytes of padding in that event that wastes precious
ring buffer space. By changing the event to:

	TP_STRUCT__entry(
		__string(        name, req->core ? req->core->name : "none")
		__string(       pname, req->best_parent_hw ? clk_hw_get_name(req->best_parent_hw) : "none" )
		__field(unsigned long,           min                       )
		__field(unsigned long,           max                       )
		__field(unsigned long,           prate                     )
	),

It will turn the size into:

	__string()		4 bytes
	__string()		4 bytes
	__field(unsigned long)	8 bytes
	__field(unsigned long)	8 bytes
	__field(unsigned long)	8 bytes

With no padding and no wasted space.

I would suggest changing this.

-- Steve
