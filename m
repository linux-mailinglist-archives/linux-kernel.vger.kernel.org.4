Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3264D6BFC54
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 20:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjCRTMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 15:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRTMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 15:12:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934081CAD8;
        Sat, 18 Mar 2023 12:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A68860F0D;
        Sat, 18 Mar 2023 19:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294A8C4339B;
        Sat, 18 Mar 2023 19:12:10 +0000 (UTC)
Date:   Sat, 18 Mar 2023 15:12:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mhiramat@kernel.org, zanussi@kernel.org
Subject: Re: [PATCH 1/2] tracing/hist: simplify contains_operator()
Message-ID: <20230318151208.61d73823@rorschach.local.home>
In-Reply-To: <20230302171755.1821653-2-mark.rutland@arm.com>
References: <20230302171755.1821653-1-mark.rutland@arm.com>
        <20230302171755.1821653-2-mark.rutland@arm.com>
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

On Thu,  2 Mar 2023 17:17:54 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

FYI, we follow Linus's preference that subjects start with a capital
letter. Unless of course you are a socialist and dislike capitalism?

  tracing/hist: Simplify contains_operator()


> In a subsequent patch we'll add additional operators for histogram
> expressions.

Refrain from using "subsequent patch", instead say:

 Simplify contains_operator() in order to support additional operators
 for histogram expressions.

> 
> In preparation for adding additional operators, this patch refactors
> contains_operator() to consider each operator within a precedence group
> independently by using the 'sep' pointer as the current rightmost
> operator, and removing the separate op pointers.
> 
> Within each precedence group, this allows operators to be checked
> independently with a consistent pattern:
> 
> 	op = strrchr(str, $OP_CHAR);
> 	if (op > *sep) {
> 		*sep = op;
> 		field_op = $FIELD_OP_TYPE;
> 	}
> 
> This makes it easy to add new operators of the same precedence without
> needing to check multiple pointers, and without needing a final switch
> statement to recover the relevant pointer.
> 
> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> Cc: Tom Zanussi <zanussi@kernel.org>
> Cc: linux-trace-kernel@vger.kernel.org
> ---
>  kernel/trace/trace_events_hist.c | 80 ++++++++++++--------------------
>  1 file changed, 30 insertions(+), 50 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 10d36f751fcd..a308da2cde2f 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1813,13 +1813,15 @@ static char *expr_str(struct hist_field *field, unsigned int level)
>  static int contains_operator(char *str, char **sep)
>  {
>  	enum field_op_id field_op = FIELD_OP_NONE;
> -	char *minus_op, *plus_op, *div_op, *mult_op;
> +	char *op;
>  
> +	*sep = NULL;

Hmm!

>  
>  	/*
> -	 * Report the last occurrence of the operators first, so that the
> -	 * expression is evaluated left to right. This is important since
> -	 * subtraction and division are not associative.
> +	 * For operators of the same precedence report the last occurrence of
> +	 * the operators first, so that the expression is evaluated left to
> +	 * right. This is important since subtraction and division are not
> +	 * associative.
>  	 *
>  	 *	e.g
>  	 *		64/8/4/2 is 1, i.e 64/8/4/2 = ((64/8)/4)/2
> @@ -1830,68 +1832,46 @@ static int contains_operator(char *str, char **sep)
>  	 * First, find lower precedence addition and subtraction
>  	 * since the expression will be evaluated recursively.
>  	 */
> -	minus_op = strrchr(str, '-');
> -	if (minus_op) {
> +	op = strrchr(str, '-');
> +	if (op > *sep) {

Why compare to *sep if it is always NULL?

Oh! But later in the code we have:

	if (contains_operator(field, NULL) || is_var_ref(field))

I wonder how *sep = NULL will handle that?

-- Steve

> +		*sep = op;
> +
>  		/*
>  		 * Unary minus is not supported in sub-expressions. If
>  		 * present, it is always the next root operator.
>  		 */
> -		if (minus_op == str) {
> -			field_op = FIELD_OP_UNARY_MINUS;
> -			goto out;
> -		}
> +		if (op == str)
> +			return FIELD_OP_UNARY_MINUS;
>  
>  		field_op = FIELD_OP_MINUS;
>  	}
>  
