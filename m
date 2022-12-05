Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9696F64369E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbiLEVNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiLEVNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:13:15 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E0525EA1;
        Mon,  5 Dec 2022 13:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1670274790;
        bh=tx9uU3h4gLkJR6jBZh4TBzrIG5bXaAYgEAywX550KUo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K3fmuH4CDAALum8Go4LgkSHWHZzBz1feMwVc2v5tko/yOitT3Qab+f0odaGlN6iQQ
         wreXBkCrnreluVec2fQCd5jLKc8VMr1KkK4tJD6MG0AwQwAZZNWxpeIiPCMlSzt6sp
         QZtBCoHYmuqs2fj0bab3DUc/VHcRURlSqO2voIXV3T6qTm1kcNiKcB0DpCjKVhmX96
         INlNWZLPzgBSanFznoq3ZJn9cyk2pNwluKQysuM1ChUKRukrgsvFQA5NAKVi7UpqMr
         d/vhWCbwuXZyUJ/nBK2EN/HFKdEMXpHmGIONPdC+dMUYom2brkopuIUh2WdIPZMJuT
         XbT7EXyTttIig==
Received: from [172.16.0.118] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NQx9228JRzZdB;
        Mon,  5 Dec 2022 16:13:10 -0500 (EST)
Message-ID: <27f02c53-e837-67a1-fb59-570f2780fde0@efficios.com>
Date:   Mon, 5 Dec 2022 16:13:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 01/11] tracing/user_events: Split header into uapi and
 kernel
Content-Language: en-US
To:     Beau Belgrave <beaub@linux.microsoft.com>, rostedt@goodmis.org,
        mhiramat@kernel.org, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com, brauner@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221205210017.23440-1-beaub@linux.microsoft.com>
 <20221205210017.23440-2-beaub@linux.microsoft.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20221205210017.23440-2-beaub@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-05 16:00, Beau Belgrave wrote:
> The UAPI parts need to be split out from the kernel parts of user_events
> now that other parts of the kernel will reference it. Do so by moving
> the existing include/linux/user_events.h into
> include/uapi/linux/user_events.h.
> 
> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> ---
>   include/linux/user_events.h      | 52 +++++---------------------------
>   include/uapi/linux/user_events.h | 48 +++++++++++++++++++++++++++++
>   kernel/trace/trace_events_user.c |  5 ---
>   3 files changed, 56 insertions(+), 49 deletions(-)
>   create mode 100644 include/uapi/linux/user_events.h
> 
> diff --git a/include/linux/user_events.h b/include/linux/user_events.h
> index 592a3fbed98e..036b360f3d97 100644
> --- a/include/linux/user_events.h
> +++ b/include/linux/user_events.h
> @@ -1,54 +1,18 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* SPDX-License-Identifier: GPL-2.0-only */
>   /*
> - * Copyright (c) 2021, Microsoft Corporation.
> + * Copyright (c) 2022, Microsoft Corporation.
>    *
>    * Authors:
>    *   Beau Belgrave <beaub@linux.microsoft.com>
>    */
> -#ifndef _UAPI_LINUX_USER_EVENTS_H
> -#define _UAPI_LINUX_USER_EVENTS_H
>   
> -#include <linux/types.h>
> -#include <linux/ioctl.h>
> +#ifndef _LINUX_USER_EVENTS_H
> +#define _LINUX_USER_EVENTS_H
>   
> -#ifdef __KERNEL__
> -#include <linux/uio.h>
> +#include <uapi/linux/user_events.h>
> +
> +#ifdef CONFIG_USER_EVENTS
>   #else
> -#include <sys/uio.h>
>   #endif

Not sure why this is left here ?

#ifdef CONFIG_USER_EVENTS
#else
#endif

It seems useless at this stage. Perhaps it's meant to show up in a 
following patch ?

[...]

> -
> -#endif /* _UAPI_LINUX_USER_EVENTS_H */
> +#endif /* _LINUX_USER_EVENTS_H */
> diff --git a/include/uapi/linux/user_events.h b/include/uapi/linux/user_events.h
> new file mode 100644
> index 000000000000..7700759a7cd9
> --- /dev/null
> +++ b/include/uapi/linux/user_events.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (c) 2021-2022, Microsoft Corporation.
> + *
> + * Authors:
> + *   Beau Belgrave <beaub@linux.microsoft.com>
> + */
> +#ifndef _UAPI_LINUX_USER_EVENTS_H
> +#define _UAPI_LINUX_USER_EVENTS_H
> +
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +#define USER_EVENTS_SYSTEM "user_events"
> +#define USER_EVENTS_PREFIX "u:"
> +
> +/* Create dynamic location entry within a 32-bit value */
> +#define DYN_LOC(offset, size) ((size) << 16 | (offset))
> +
> +/*
> + * Describes an event registration and stores the results of the registration.
> + * This structure is passed to the DIAG_IOCSREG ioctl, callers at a minimum
> + * must set the size and name_args before invocation.
> + */
> +struct user_reg {
> +
> +	/* Input: Size of the user_reg structure being used */
> +	__u32 size;
> +
> +	/* Input: Pointer to string with event name, description and flags */
> +	__u64 name_args;
> +
> +	/* Output: Bitwise index of the event within the status page */
> +	__u32 status_bit;
> +
> +	/* Output: Index of the event to use when writing data */
> +	__u32 write_index;
> +} __attribute__((__packed__));
> +
> +#define DIAG_IOC_MAGIC '*'
> +
> +/* Requests to register a user_event */
> +#define DIAG_IOCSREG _IOWR(DIAG_IOC_MAGIC, 0, struct user_reg*)

Coding style: "struct user_reg *" (space before '*').

> +
> +/* Requests to delete a user_event */
> +#define DIAG_IOCSDEL _IOW(DIAG_IOC_MAGIC, 1, char*)

Coding style: space before '*'.

I notice the use of plural for "Requests". Are those batched requests, 
or a single request ?

Thanks,

Mathieu

> +
> +#endif /* _UAPI_LINUX_USER_EVENTS_H */
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index ae78c2d53c8a..890357b48c37 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -19,12 +19,7 @@
>   #include <linux/tracefs.h>
>   #include <linux/types.h>
>   #include <linux/uaccess.h>
> -/* Reminder to move to uapi when everything works */
> -#ifdef CONFIG_COMPILE_TEST
>   #include <linux/user_events.h>
> -#else
> -#include <uapi/linux/user_events.h>
> -#endif
>   #include "trace.h"
>   #include "trace_dynevent.h"
>   

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

