Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2574364ABF0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbiLMAEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbiLMAES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:04:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC51F7E;
        Mon, 12 Dec 2022 16:04:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58A3FB80F96;
        Tue, 13 Dec 2022 00:04:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5F2C433D2;
        Tue, 13 Dec 2022 00:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670889855;
        bh=ltNtU8mMG0gORd3H7lLvJSf1LW973EOpFs9cgyVj5Yw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uYdXsoFlQyV3S9zF1dAYruuz/CymS8gV7Z3uXv4srE50kwQ7InkzHygD9SP3iImKk
         sZnO1J7Fubvt52kWhlFwiHmL2TFzlQTtFvHiZBRAsNG4ZsUHLUJ9mmfmNZ1levrjyQ
         md0HMIQBqR6iZR0W716E7GxkXcGadcNu7vz0Crlg96AYuhPobouX9g2gQINMmBWdD2
         MPfW4mNrD2FHZ57eIQ11oq588Qs+VabnsThjco/VTs8tpR3mNZq+cp5j06J+55uv72
         7wxruginifsr/m4DqEO6OrzvhfqC1A6/C7oZB8ZHzNQ3AajjyuqGjEAzBcouMrAQ00
         rs2gmdqx+T1bw==
Date:   Tue, 13 Dec 2022 09:04:11 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Douglas Raillard <douglas.raillard@arm.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] tracing: Remove pointer (asterisk) from cpumask_t field
Message-Id: <20221213090411.676021b8fff2c9bc95fba53f@kernel.org>
In-Reply-To: <20221212130352.606d7ce2@gandalf.local.home>
References: <20221212130352.606d7ce2@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Dec 2022 13:03:52 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> To differentiate between long arrays and cpumasks, the __cpumask() field
> was created. Part of the TRACE_EVENT() macros test if the type is signed
> or not by using the is_signed_type() macro. The __cpumask() field used the
> __dynamic_array() helper but because cpumask_t is a structure, it could
> not be used in the is_signed_type() macro as that would fail to build, so
> instead it passed in the pointer to cpumask_t.
> 
> Unfortunately, that creates in the format file:
> 
>   field:__data_loc cpumask_t *[] mask;    offset:36;      size:4; signed:0;
> 
> Which looks like an array of pointers to cpumask_t and not a cpumask_t
> type, which is misleading to user space parsers.
> 
> Instead, create another helper called __dynamic_array_sign() that can be
> used directly by the __cpumaks() field macro where it passes in an
> unsigned value to avoid using the is_signed_type() and have the
> __dynamic_array() macro call it by passing it the is_signed_type() on the
> type.

What about renaming it as __dynamic_array_struct(), because the root issue
is that we can not pass the data structure to is_signed_tyep() macro?

Thank you,

> 
> This now produces:
> 
>   field:__data_loc cpumask_t[] mask;    offset:36;      size:4; signed:0;
> 
> Which is the correct type of the field.
> 
> Link: https://lore.kernel.org/lkml/6dda5e1d-9416-b55e-88f3-31d148bc925f@arm.com/
> 
> Fixes: 8230f27b1ccc ("tracing: Add __cpumask to denote a trace event field that is a cpumask_t")
> Reported-by: Douglas Raillard <douglas.raillard@arm.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/trace/stages/stage4_event_fields.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/stages/stage4_event_fields.h b/include/trace/stages/stage4_event_fields.h
> index f2990d22313c..9f0049c309f0 100644
> --- a/include/trace/stages/stage4_event_fields.h
> +++ b/include/trace/stages/stage4_event_fields.h
> @@ -28,11 +28,15 @@
>  	.size = sizeof(_type[_len]), .align = ALIGN_STRUCTFIELD(_type),	\
>  	.is_signed = is_signed_type(_type), .filter_type = FILTER_OTHER },
>  
> -#undef __dynamic_array
> -#define __dynamic_array(_type, _item, _len) {				\
> +#undef __dynamic_array_sign
> +#define __dynamic_array_sign(_type, _item, _len, _sign) {		\
>  	.type = "__data_loc " #_type "[]", .name = #_item,		\
>  	.size = 4, .align = 4,						\
> -	.is_signed = is_signed_type(_type), .filter_type = FILTER_OTHER },
> +	.is_signed = _sign, .filter_type = FILTER_OTHER },
> +
> +#undef __dynamic_array
> +#define __dynamic_array(_type, _item, _len)				\
> +	__dynamic_array_sign(_type, item, len, is_signed_type(_type))
>  
>  #undef __string
>  #define __string(item, src) __dynamic_array(char, item, -1)
> @@ -47,7 +51,7 @@
>  #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
>  
>  #undef __cpumask
> -#define __cpumask(item) __dynamic_array(cpumask_t *, item, -1)
> +#define __cpumask(item) __dynamic_array_sign(cpumask_t, item, -1, 0)
>  
>  #undef __sockaddr
>  #define __sockaddr(field, len) __dynamic_array(u8, field, len)
> -- 
> 2.35.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
