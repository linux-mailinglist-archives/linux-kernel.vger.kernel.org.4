Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238926C02CA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 16:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjCSP3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 11:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjCSP33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 11:29:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9C2E1B4;
        Sun, 19 Mar 2023 08:29:27 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so6072345wmq.1;
        Sun, 19 Mar 2023 08:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679239766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tOMPkpBRgRivxnPOH7XFVD7bd47oiyx4aO634gRangA=;
        b=j7FxfjErBxVkLfyqK8+CjjG/o/3XqirJwH3NiATirpxSDa9dJXip0WNO8EYiFinfWv
         KxZikdR0WLEvor8H92rFJNy6d3Yf4EmLgHBYwcMg4hyqJxK6w1A9mvCNGY7bG1JNLdt5
         bP1GgrjGEF2+COc5UL43ZmXLlJdFLguGy3wc3wbC1F7IPpGgSDXLgcJ4FKRnrFvD/ms+
         1Ll7Cu/T0NAfRY+GS43gSdkMQPH7idU8VSMraDfKcZXCJOYoqYMbosHHIJ2VqGVWaZSK
         D7ru/FMT7/DKfEcKa9BL8v7OCWJHGnfmQyc/MpjbW+KmieyA79tVkrIbjMO14byE7yGp
         SeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679239766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOMPkpBRgRivxnPOH7XFVD7bd47oiyx4aO634gRangA=;
        b=i+VxrCXaaH6rVDritWNYhRC4DzS+Zv1HVeIvnF4RbRyMI2YLQV4KpwLIpJeTebbSka
         wzcMXSq34MwAaPGXg73nT1jPOpkzvbNgc+5n560N3YEnUhjBnizad6lMbvm7CPsFBFst
         qVLyqu7iRHWnSqMw1FEjTv4bRquA83GCcTRKOEvAGeX068nkbuzBz0QQKYXR6jAJv2VN
         H3+ZBwxZcZCnyBFgchHCE5xJ6zH8+H9S7kzoeSr7bvzNDnEApTLRLT2+w2lLarHtXVON
         4GrYxEU/1KgmwLlQMh7f7pTs/XGadOewpDQ7x0y4rx1fIZb6jabeOLlQ/NdgV+2Pf6fG
         N/7A==
X-Gm-Message-State: AO0yUKUjfmKf1JHh7stQYYm77kjd4A9AXjM6Hro+d+cBEkSKZvl5G0iW
        CKewZ/id3GulC+KAOjo7KwVa0ExuV08SQCbX9DE=
X-Google-Smtp-Source: AK7set8Wy+4BbU3BpcV/tcwvESdcmSx5l8cGmB9WmC+3spldN6amF8PW6aDfCpu0iml5LpEeQ4XMAA==
X-Received: by 2002:a7b:c8d8:0:b0:3db:8de:6993 with SMTP id f24-20020a7bc8d8000000b003db08de6993mr7152538wml.4.1679239766249;
        Sun, 19 Mar 2023 08:29:26 -0700 (PDT)
Received: from krava (net-93-147-243-166.cust.vodafonedsl.it. [93.147.243.166])
        by smtp.gmail.com with ESMTPSA id f26-20020a7bc8da000000b003ed2d7f9135sm7715428wml.45.2023.03.19.08.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 08:29:25 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 19 Mar 2023 16:29:22 +0100
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org
Subject: Re: [PATCH 5/7] ftrace: Store direct called addresses in their ops
Message-ID: <ZBcqUoUTZSNyIjLx@krava>
References: <20230316173811.1223508-1-revest@chromium.org>
 <20230316173811.1223508-6-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316173811.1223508-6-revest@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 06:38:09PM +0100, Florent Revest wrote:
> All direct calls are now registered using the register_ftrace_direct API
> so each ops can jump to only one direct-called trampoline.
> 
> By storing the direct called trampoline address directly in the ops we
> can save one hashmap lookup in the direct call ops and implement arm64
> direct calls on top of call ops.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  include/linux/ftrace.h | 3 +++
>  kernel/trace/ftrace.c  | 7 +++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index abee60865fc7..6a532dd6789e 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -321,6 +321,9 @@ struct ftrace_ops {
>  	unsigned long			trampoline_size;
>  	struct list_head		list;
>  	ftrace_ops_func_t		ops_func;
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> +	unsigned long			direct_call;
> +#endif
>  #endif
>  };
>  
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 33530198d1ca..66c91fa4b6ab 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2582,9 +2582,8 @@ ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
>  static void call_direct_funcs(unsigned long ip, unsigned long pip,
>  			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
>  {
> -	unsigned long addr;
> +	unsigned long addr = ops->direct_call;

nice, should it be read with READ_ONCE ?

jirka

>  
> -	addr = ftrace_find_rec_direct(ip);
>  	if (!addr)
>  		return;
>  
> @@ -5380,6 +5379,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  	ops->func = call_direct_funcs;
>  	ops->flags = MULTI_FLAGS;
>  	ops->trampoline = FTRACE_REGS_ADDR;
> +	ops->direct_call = addr;
>  
>  	err = register_ftrace_function_nolock(ops);
>  
> @@ -5454,6 +5454,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  	/* Enable the tmp_ops to have the same functions as the direct ops */
>  	ftrace_ops_init(&tmp_ops);
>  	tmp_ops.func_hash = ops->func_hash;
> +	tmp_ops.direct_call = addr;
>  
>  	err = register_ftrace_function_nolock(&tmp_ops);
>  	if (err)
> @@ -5475,6 +5476,8 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  			entry->direct = addr;
>  		}
>  	}
> +	/* Prevent store tearing if a trampoline concurrently accesses the value */
> +	WRITE_ONCE(ops->direct_call, addr);
>  
>  	mutex_unlock(&ftrace_lock);
>  
> -- 
> 2.40.0.rc2.332.ga46443480c-goog
> 
