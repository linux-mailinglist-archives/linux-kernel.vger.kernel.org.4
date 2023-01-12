Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A416687D1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 00:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjALX0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 18:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjALX0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:26:32 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E0E59D33
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:26:31 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id d10so10101543ilc.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YN3h+2e9LlRoJQY+cOQKqTDFq1o3A0FXklNmBBS/AyM=;
        b=LnxiIFu/sY1fEVR8odODwZns74Rl8nliou+v/w6/x1c6VKUkA5bVFR9MH2FVz0cFO/
         eaDPayWxgN7VRO70B8Ha+BLMaSOL9F2CyXmz6/LbWirqKC+f9mgnWEwvamiSaqpWJMXw
         nbztvveZlAWIr0AueERPTiid7jR7CyMbL7CjvEC6OinxhSGuPs2o+0iO/BCOc4p2In89
         ERrXVMSLSo7ejrP5rhobFVpPFiRcUBJNyyMqoBMpvBcDc9lkGDwwNXyo9xmZ0VpC9oJ8
         nLhsMtcOBSp804qg3mdNzSpAgu8vQ2DSnOnQ9f8T6aUwtNRW6Jg/JQaW93cZL9qsAN26
         38QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YN3h+2e9LlRoJQY+cOQKqTDFq1o3A0FXklNmBBS/AyM=;
        b=mhRjQNSVj/EesY7h2x6h9VLFXgfsNrwXT94t4/PXhEIGd/kc0MJIjpdjspBvROQ1h/
         Ii97yQ4gSMXmZMT1IsdBQ4GIayUknOHz4AMOitfE0YjD5cASgmVdO2rjfRDBXXU8DaJ4
         fZXlt9E2Efw5UF1zRPa7HUPc2+KMVsxA0rbAUY1zfZb5Xt2CXsa9SaxIlQCB+WCzCzjZ
         I5adgc9tZOKi5oNMb7zujN715W5qElFWCIGWxph00eOj82snQCP9YFEYxEfVvIRCZ6eL
         v53hbPBLsA2+HCv3PoSe/SOqYbGaz/KFa7ad7qAOxxXtiq/syEgGakrtQxju/jOzNYaj
         RWaQ==
X-Gm-Message-State: AFqh2kp5hn1oCQmgxBU/2ezzUvSXXmDyvVy2ZxvLJ87kYrRcSXovv430
        MbtuOZqcK7bNnp3ly1bZHeD1G9LMyyr5ztT2
X-Google-Smtp-Source: AMrXdXv9IgLxOVnLwFFqLWzmkmQcYUw4SLMTSgux4s5U1J6WQ02IqXCVxyo8hYXgISlmjatSk/RpZg==
X-Received: by 2002:a92:cd8d:0:b0:30e:d7f3:216b with SMTP id r13-20020a92cd8d000000b0030ed7f3216bmr2327206ilb.8.1673565990785;
        Thu, 12 Jan 2023 15:26:30 -0800 (PST)
Received: from google.com ([2620:15c:183:200:4a23:5fbb:9bb3:1279])
        by smtp.gmail.com with ESMTPSA id p2-20020a92d682000000b0030ceac941dcsm5578481iln.17.2023.01.12.15.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 15:26:30 -0800 (PST)
Date:   Thu, 12 Jan 2023 16:26:27 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/4] tracing: Add trace_array_puts() to write into
 instance
Message-ID: <Y8CXI1h9hsPeiu6u@google.com>
References: <20230111145636.450953217@goodmis.org>
 <20230111145842.694147820@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111145842.694147820@goodmis.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 09:56:39AM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Add a generic trace_array_puts() that can be used to "trace_puts()" into
> an allocated trace_array instance. This is just another variant of
> trace_array_printk().
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/linux/trace.h | 13 +++++++++++++
>  kernel/trace/trace.c  | 27 +++++++++++++++++----------
>  2 files changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/trace.h b/include/linux/trace.h
> index 80ffda871749..afe61949e83a 100644
> --- a/include/linux/trace.h
> +++ b/include/linux/trace.h
> @@ -33,6 +33,19 @@ struct trace_array;
>  int register_ftrace_export(struct trace_export *export);
>  int unregister_ftrace_export(struct trace_export *export);
>  
> +/**
> + * trace_array_puts - write a constant string into the trace buffer.
> + * @tr:    The trace array to write to
> + * @ip:	   The address of the caller

@ip is not an arg to trace_array_puts(), an can be dropped from the comment.

Other than that, you can add:

Reviewed-by: Ross Zwisler <zwisler@google.com>
