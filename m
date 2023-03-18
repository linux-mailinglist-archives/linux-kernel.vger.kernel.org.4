Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC216BFC5B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 20:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjCRTTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 15:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRTTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 15:19:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB311043F;
        Sat, 18 Mar 2023 12:19:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3BCD60AE2;
        Sat, 18 Mar 2023 19:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99282C433D2;
        Sat, 18 Mar 2023 19:19:04 +0000 (UTC)
Date:   Sat, 18 Mar 2023 15:19:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mhiramat@kernel.org, zanussi@kernel.org
Subject: Re: [PATCH 2/2] tracing/hist: add modulus operator
Message-ID: <20230318151902.78809fbe@rorschach.local.home>
In-Reply-To: <20230302171755.1821653-3-mark.rutland@arm.com>
References: <20230302171755.1821653-1-mark.rutland@arm.com>
        <20230302171755.1821653-3-mark.rutland@arm.com>
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

On Thu,  2 Mar 2023 17:17:55 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> @@ -436,6 +438,21 @@ static u64 hist_field_mult(struct hist_field *hist_field,
>  	return val1 * val2;
>  }
>  
> +static u64 hist_field_mod(struct hist_field *hist_field,
> +			  struct tracing_map_elt *elt,
> +			  struct trace_buffer *buffer,
> +			  struct ring_buffer_event *rbe,
> +			  void *event)
> +{
> +	struct hist_field *operand1 = hist_field->operands[0];
> +	struct hist_field *operand2 = hist_field->operands[1];
> +
> +	u64 val1 = hist_fn_call(operand1, elt, buffer, rbe, event);
> +	u64 val2 = hist_fn_call(operand2, elt, buffer, rbe, event);
> +
> +	return val1 % val2;

Is modulus operations on 64 bit integers valid on 32 bit architectures?

Don't we need to do something like:

	div64_u64_rem(val1, val2, &rem);
	return rem;

?

-- Steve


> +}
> +
