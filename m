Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB3A6C4B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjCVNN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCVNN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:13:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0DD419C73;
        Wed, 22 Mar 2023 06:13:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65D864B3;
        Wed, 22 Mar 2023 06:14:39 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.53.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 736E03F6C4;
        Wed, 22 Mar 2023 06:13:54 -0700 (PDT)
Date:   Wed, 22 Mar 2023 13:13:51 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mhiramat@kernel.org, zanussi@kernel.org
Subject: Re: [PATCH 1/2] tracing/hist: simplify contains_operator()
Message-ID: <ZBr/DzoqOWdFvAOP@FVFF77S0Q05N>
References: <20230302171755.1821653-1-mark.rutland@arm.com>
 <20230302171755.1821653-2-mark.rutland@arm.com>
 <20230318151208.61d73823@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230318151208.61d73823@rorschach.local.home>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 03:12:08PM -0400, Steven Rostedt wrote:
> On Thu,  2 Mar 2023 17:17:54 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> FYI, we follow Linus's preference that subjects start with a capital
> letter. Unless of course you are a socialist and dislike capitalism?
> 
>   tracing/hist: Simplify contains_operator()
> 

Sorry; I always get this wrong since many other trees do everything lower case
(or support total commit message anarchy). I'll go fix that up.

> 
> > In a subsequent patch we'll add additional operators for histogram
> > expressions.
> 
> Refrain from using "subsequent patch", instead say:
> 
>  Simplify contains_operator() in order to support additional operators
>  for histogram expressions.

Sure.

> 
> > 
> > In preparation for adding additional operators, this patch refactors
> > contains_operator() to consider each operator within a precedence group
> > independently by using the 'sep' pointer as the current rightmost
> > operator, and removing the separate op pointers.
> > 
> > Within each precedence group, this allows operators to be checked
> > independently with a consistent pattern:
> > 
> > 	op = strrchr(str, $OP_CHAR);
> > 	if (op > *sep) {
> > 		*sep = op;
> > 		field_op = $FIELD_OP_TYPE;
> > 	}
> > 
> > This makes it easy to add new operators of the same precedence without
> > needing to check multiple pointers, and without needing a final switch
> > statement to recover the relevant pointer.
> > 
> > There should be no functional change as a result of this patch.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Cc: Tom Zanussi <zanussi@kernel.org>
> > Cc: linux-trace-kernel@vger.kernel.org
> > ---
> >  kernel/trace/trace_events_hist.c | 80 ++++++++++++--------------------
> >  1 file changed, 30 insertions(+), 50 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> > index 10d36f751fcd..a308da2cde2f 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -1813,13 +1813,15 @@ static char *expr_str(struct hist_field *field, unsigned int level)
> >  static int contains_operator(char *str, char **sep)
> >  {
> >  	enum field_op_id field_op = FIELD_OP_NONE;
> > -	char *minus_op, *plus_op, *div_op, *mult_op;
> > +	char *op;
> >  
> > +	*sep = NULL;
> 
> Hmm!

Ugh, sorry, I had completely glossed over the:

	if (sep) {
		...
		// assignments to *sep here
		...
	}

... in the existing code.

I'll go rework that...

> 
> >  
> >  	/*
> > -	 * Report the last occurrence of the operators first, so that the
> > -	 * expression is evaluated left to right. This is important since
> > -	 * subtraction and division are not associative.
> > +	 * For operators of the same precedence report the last occurrence of
> > +	 * the operators first, so that the expression is evaluated left to
> > +	 * right. This is important since subtraction and division are not
> > +	 * associative.
> >  	 *
> >  	 *	e.g
> >  	 *		64/8/4/2 is 1, i.e 64/8/4/2 = ((64/8)/4)/2
> > @@ -1830,68 +1832,46 @@ static int contains_operator(char *str, char **sep)
> >  	 * First, find lower precedence addition and subtraction
> >  	 * since the expression will be evaluated recursively.
> >  	 */
> > -	minus_op = strrchr(str, '-');
> > -	if (minus_op) {
> > +	op = strrchr(str, '-');
> > +	if (op > *sep) {
> 
> Why compare to *sep if it is always NULL?

As in the commit message, that was just so that every check for an operator had
the same shape. I can certainly drop this for the first check and just have:

	op = strrchr(str, '-');
	if (op) {
		...
	}

> 
> Oh! But later in the code we have:
> 
> 	if (contains_operator(field, NULL) || is_var_ref(field))
> 
> I wonder how *sep = NULL will handle that?

Yep, I got this wrong. I'll go rejig that.

Thanks,
Mark.
