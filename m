Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC3361FB02
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbiKGRRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiKGRRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:17:35 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3131C918
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:17:34 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13c569e5ff5so13427344fac.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 09:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SRHt20QQdW41qCnj/h+AEbqKGhHMt/R43V9B84bg+ZA=;
        b=fSO2QPhlm6JTbU5gJOnfsh1Vq2ERS2+ZP18Vs3OaG7KmqC1dEGgrTo80WC07DPZX+t
         rsnY6BN1lKWCGSVKmk0u+rrzilFaZHjrKjatdmbeOMyKTsJuQTl5qXBv+vAUoqS348fy
         oG/B+/clAS92cQ4DGK0NQ4rS9kIFa470qgsCbXsghBZurnNVrNa5rTiEEXWi52fBH9AZ
         VtNE3efqGOW+BGCI3n7ePBT+Rw8qFDytkPwsErt20SlWmzLqyG+0GJFas8YU4erE0Wvw
         KlWqxbXGQiM6yD2/oy5gzBS++QddW7dqm9CP4KP8lsarddLDNb1zwB5w2/lzJelfzH90
         eHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRHt20QQdW41qCnj/h+AEbqKGhHMt/R43V9B84bg+ZA=;
        b=lh4CrMneRugCnL+O5E5kHeT70fXwZgFongPOQ0gwHtPz+AlQYdVKLGVI0INInPaNTK
         nn1tLSPg5GT97jHuRt0Ahb017aERsegVd88VDpp4dOnn+5cInEA5v+HnqFVnS+T9S5Iz
         6nN3dprk6rEATLiOXW4kaDhj2JR6KD3xy9JvyjWNq/EUt1yX2mus+9cXXTN1HdFM7PbI
         iw/hN8dSoxYZgXKnIcWHe71dK3A7C2O82S0Xt7vl9U3EFXsgn4XWjMjk5FJJRjYzaZpa
         adNKAw3+AU3mRo/Semb+j9zAkx8WyTG6TFaj/rSlrKv26Z+0FML+VZMeImDZa7tTRu63
         d7/A==
X-Gm-Message-State: ACrzQf2Ddgjz0BnRpJYHCOqsSxUll/cu3MIGecSssR2hEyBGRKua9ES9
        NUavtkHCR+1jzJIBJjRIwVA=
X-Google-Smtp-Source: AMsMyM7H4xTZUOsEN8Jcv+dwvct3redLdzSnv5OEOa879RRQkQi2HyYzvgLO4OGcd7UKHvm8nyp9IA==
X-Received: by 2002:a05:6871:4107:b0:13b:becc:138 with SMTP id la7-20020a056871410700b0013bbecc0138mr582684oab.28.1667841453618;
        Mon, 07 Nov 2022 09:17:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bd6-20020a056870d78600b0013320d9d9casm3339440oab.44.2022.11.07.09.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 09:17:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 7 Nov 2022 09:17:29 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aashish Sharma <shraash@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arun Easi <aeasi@marvell.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix warning on variable 'struct trace_array'
Message-ID: <20221107171729.GA299776@roeck-us.net>
References: <20221107160556.2139463-1-shraash@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107160556.2139463-1-shraash@google.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 09:35:56PM +0530, Aashish Sharma wrote:
> Move the declaration of 'struct trace_array' out of #ifdef
> CONFIG_TRACING block, to fix the following warning when CONFIG_TRACING
> is not set:
> 
> >> include/linux/trace.h:63:45: warning: 'struct trace_array' declared
> inside parameter list will not be visible outside of this definition or
> declaration
> 
> Fixes: 1a77dd1c2bb5 ("scsi: tracing: Fix compile error in trace_array calls when TRACING is disabled")
> Cc: Arun Easi <aeasi@marvell.com>
> Signed-off-by: Aashish Sharma <shraash@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  include/linux/trace.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/trace.h b/include/linux/trace.h
> index b5e16e438448..80ffda871749 100644
> --- a/include/linux/trace.h
> +++ b/include/linux/trace.h
> @@ -26,13 +26,13 @@ struct trace_export {
>  	int flags;
>  };
>  
> +struct trace_array;
> +
>  #ifdef CONFIG_TRACING
>  
>  int register_ftrace_export(struct trace_export *export);
>  int unregister_ftrace_export(struct trace_export *export);
>  
> -struct trace_array;
> -
>  void trace_printk_init_buffers(void);
>  __printf(3, 4)
>  int trace_array_printk(struct trace_array *tr, unsigned long ip,
> -- 
> 2.38.1.431.g37b22c650d-goog
> 
