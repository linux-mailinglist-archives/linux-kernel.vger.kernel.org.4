Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A126B4B24
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjCJPby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjCJPba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:31:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCE713789F;
        Fri, 10 Mar 2023 07:19:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 88517CE2460;
        Fri, 10 Mar 2023 15:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CB8C4339E;
        Fri, 10 Mar 2023 15:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678461558;
        bh=TVIFAEXwdGY93sxI4vQsn88Ku12GrQL9LqJyB7qunzo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CU6QjWYhxZpYilM1JOl3Lx8osCvf36p0VGoXtR0lJziYSJ1hx4zoOjr4DRU9r2g65
         TPTpWMkWHfPglwTXXlIKLBmOC2CKhQCVYOAJyfb8bIPh45tSH4mQTeNnE28wZIniYc
         bVa365768gdQVMnJsdO6c4mWAUJ8RL0HLzmfa9RnKhqV4Y3h+nsES+05irgdIsBpGG
         3vBpYZO85AFgGh6+62h776AQnrxpt/kkYTfxyTW5P1pEr6V9klqFFp4OelYbRleIHD
         2zanQkBZrDkd+9JxVasg4fmVXmh6Nka8nfA1mYtgnUeCEGouWR1p57OjFUvXF47wCN
         /Jj6X6fYgiWDA==
Date:   Sat, 11 Mar 2023 00:19:14 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Douglas RAILLARD <douglas.raillard@arm.com>
Subject: Re: [PATCH] tracing: Error if a trace event has an array for a
 __field()
Message-Id: <20230311001914.9274a39d5291ff118cc85346@kernel.org>
In-Reply-To: <20230309221302.642e82d9@gandalf.local.home>
References: <20230309221302.642e82d9@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
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

On Thu, 9 Mar 2023 22:13:02 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> A __field() in the TRACE_EVENT() macro is used to set up the fields of the
> trace event data. It is for single storage units (word, char, int,
> pointer, etc) and not for complex structures or arrays. Unfortunately,
> there's nothing preventing the build from accepting:
> 
>     __field(int, arr[5]);
> 
> from building. It will turn into a array value. This use to work fine, as
> the offset and size use to be determined by the macro using the field name,
> but things have changed and the offset and size are now determined by the
> type. So the above would only be size 4, and the next field will be
> located 4 bytes from it (instead of 20).
> 
> The proper way to declare static arrays is to use the __array() macro.
> 
> Instead of __field(int, arr[5]) it should be __array(int, arr, 5).
> 
> Add some macro tricks to the building of a trace event from the
> TRACE_EVENT() macro such that __field(int, arr[5]) will fail to build. A
> comment by the failure will explain why the build failed.
> 
> Link: https://lore.kernel.org/lkml/20230306122549.236561-1-douglas.raillard@arm.com/
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> Reported-by: Douglas RAILLARD <douglas.raillard@arm.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/trace/stages/stage5_get_offsets.h | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/stages/stage5_get_offsets.h b/include/trace/stages/stage5_get_offsets.h
> index ac5c24d3beeb..e30a13be46ba 100644
> --- a/include/trace/stages/stage5_get_offsets.h
> +++ b/include/trace/stages/stage5_get_offsets.h
> @@ -9,17 +9,30 @@
>  #undef __entry
>  #define __entry entry
>  
> +/*
> + * Fields should never declare an array: i.e. __field(int, arr[5])
> + * If they do, it will cause issues in parsing and possibly corrupt the
> + * events. To prevent that from happening, test the sizeof() a fictitious
> + * type called "struct _test_no_array_##item" which will fail if "item"
> + * contains array elements (like "arr[5]").
> + *
> + * If you hit this, use __array(int, arr, 5) instead.
> + */
>  #undef __field
> -#define __field(type, item)
> +#define __field(type, item)					\
> +	{ (void)sizeof(struct _test_no_array_##item *); }
>  
>  #undef __field_ext
> -#define __field_ext(type, item, filter_type)
> +#define __field_ext(type, item, filter_type)			\
> +	{ (void)sizeof(struct _test_no_array_##item *); }
>  
>  #undef __field_struct
> -#define __field_struct(type, item)
> +#define __field_struct(type, item)				\
> +	{ (void)sizeof(struct _test_no_array_##item *); }
>  
>  #undef __field_struct_ext
> -#define __field_struct_ext(type, item, filter_type)
> +#define __field_struct_ext(type, item, filter_type)		\
> +	{ (void)sizeof(struct _test_no_array_##item *); }
>  
>  #undef __array
>  #define __array(type, item, len)
> -- 
> 2.39.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
