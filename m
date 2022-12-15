Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FAB64E134
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiLOSqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiLOSpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:45:42 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B08260B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:45:39 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id a16so263083qtw.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+8kdbca7RYmzghu3wrDFH9WKgOWAt7+jGRtzBcbGXvg=;
        b=RDxuf4vWN8ZO5ssFcc25XiKKo/4GxNXFK5YWWvzMeoCeWVtkwg58xezK7KBo9Ss9xz
         cRmdZLa3PiR4GXoO+r7xTAIKFue3kCyWjSE9qpLAFUpETnMGbso2nsUUG+D7ToOMdWMt
         aeuSy8tbFKDtZg9a5LPo8i60QdC0Nq7oz1EM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8kdbca7RYmzghu3wrDFH9WKgOWAt7+jGRtzBcbGXvg=;
        b=PwnO5Ms5wJsS72r7+h7Awuw0HxOdJg0m0ercigQKAIUGUzS5x8NJoBlJIYrlRERtdR
         ylcTg9ZCgWluTG6gG4QP25LG6CFF3spxaKoIQzOobDF5M4NU+lvOOQqNO5pfAwnk25Ko
         FESEkKXmckzLDv4B+p2i+95DyBhb15itYLCVC2Nc4BuiPSIlunCEN3zQA6J6hwPbik1b
         jr0schNscN4yPpeFacEyBt157Z8L1uxKbM4cLSp6VcJBELCQ9JI5eqCk3rd+MkZDh31V
         4qe4Dq1xZ6JM7+Vu+lS7ilRWz6CVVldg0Em8+Sb6hxwVYE1+gU94DDpCY+vVqI1k0OX7
         ig7Q==
X-Gm-Message-State: AFqh2konzVna+7Nw/hNqUn8BG5Rntk0BpPKOu28soZzt2UmemK88FE+E
        yDBsnOiJ/CuathpeG0JdO6cavQ==
X-Google-Smtp-Source: AMrXdXtKc1qXGEu1lpOg9q/lsex/RBhHmz2vLTrGw4eI73/gi/6Pee1y9Cx54AsGsN+fgApbcwCoyQ==
X-Received: by 2002:ac8:668d:0:b0:3a9:1ada:930f with SMTP id d13-20020ac8668d000000b003a91ada930fmr4932696qtp.23.1671129938658;
        Thu, 15 Dec 2022 10:45:38 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w5-20020a05620a444500b006eed75805a2sm13009205qkp.126.2022.12.15.10.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 10:45:37 -0800 (PST)
Date:   Thu, 15 Dec 2022 18:45:37 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Ross Zwisler <zwisler@google.com>,
        Ching-lin Yu <chinglinyu@google.com>
Subject: Re: [RFC][PATCH] ACPI: tracing: Have ACPI debug go to tracing ring
 buffer
Message-ID: <Y5trUep9IvCv1Uwy@google.com>
References: <20221214233106.69b2c01b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214233106.69b2c01b@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, Dec 14, 2022 at 11:31:06PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> While debugging some firmware that was taking a bit of time to initialize,
> I enabled ACPI_DEBUG and added a bit too much info to the debug_layer and
> debug_level acpi command line options, and it made the computer not be
> able to boot (too much info! or too much printk).
> 
> I decided that this would be easier to handle if the acpi output was
> written instead into the trace buffer. This also has the added benefit of
> adding other trace events and seeing how ACPI interacts with the rest of
> the system.
> 
> Ideally, the ACPI trace should have proper trace events where data can be
> stored more efficiently and be filtered and parsed better. But for now,
> just writing the debug string into the buffer will suffice.  This makes it
> possible to enable all ACPI output (setting triggers on other events to
> stop tracing, to not lose the data you are looking for).
> 
> Even with all APCI debugging enable, the system continues to run perfectly
> fine.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> 
>  drivers/acpi/Kconfig        | 13 +++++++++++++
>  drivers/acpi/osl.c          |  9 ++++++++-
>  include/trace/events/acpi.h | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 51 insertions(+), 1 deletion(-)
>  create mode 100644 include/trace/events/acpi.h
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 473241b5193f..2dfeb3bf79a7 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -389,6 +389,19 @@ config ACPI_DEBUG
>  	  Documentation/admin-guide/kernel-parameters.rst to control the type and
>  	  amount of debug output.
>  
> +config ACPI_TRACE_PRINT
> +	bool "Write debug into trace buffer"
> +	depends on ACPI_DEBUG
> +	help
> +	  Instead of writing to the console, write to the trace ring buffer.
> +	  This is much faster than writing to the console, and can handle
> +	  all events.
> +
> +	  Use the acpi.debug_layer and acpi.debug_level kernel command-line
> +	  parameters documented in Documentation/firmware-guide/acpi/debug.rst and
> +	  Documentation/admin-guide/kernel-parameters.rst to control the type and
> +	  amount of debug output.
> +
>  config ACPI_PCI_SLOT
>  	bool "PCI slot detection driver"
>  	depends on SYSFS && PCI
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 3269a888fb7a..eeed5fd782ab 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -35,6 +35,9 @@
>  #include <linux/uaccess.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/acpi.h>
> +
>  #include "acpica/accommon.h"
>  #include "internal.h"
>  
> @@ -158,6 +161,8 @@ void acpi_os_vprintf(const char *fmt, va_list args)
>  #ifdef ENABLE_DEBUGGER
>  	if (acpi_in_debugger) {
>  		kdb_printf("%s", buffer);
> +	} else if (IS_ENABLED(CONFIG_ACPI_TRACE_PRINT)) {
> +		trace_acpi_print(buffer);

Wouldn't it be better to also check trace_acpi_print_enabled() here in the
else if() condition, along with IS_ENABLED()? That way if the CONFIG is
enabled but the tracepoint is not enabled, at least the messages will go to
dmesg instead of skipped.

>  	} else {
>  		if (printk_get_level(buffer))
>  			printk("%s", buffer);
> @@ -165,7 +170,9 @@ void acpi_os_vprintf(const char *fmt, va_list args)
>  			printk(KERN_CONT "%s", buffer);
>  	}
>  #else
> -	if (acpi_debugger_write_log(buffer) < 0) {
> +	if (IS_ENABLED(CONFIG_ACPI_TRACE_PRINT)) {
> +		trace_acpi_print(buffer);
> +	} else if (acpi_debugger_write_log(buffer) < 0) {

Ditto.


Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel



>  		if (printk_get_level(buffer))
>  			printk("%s", buffer);
>  		else
> diff --git a/include/trace/events/acpi.h b/include/trace/events/acpi.h
> new file mode 100644
> index 000000000000..dab4dd42b5d7
> --- /dev/null
> +++ b/include/trace/events/acpi.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM acpi
> +
> +#if !defined(_TRACE_ACPI_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_ACPI_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(acpi_print,
> +
> +	TP_PROTO(const char *buffer),
> +
> +	TP_ARGS(buffer),
> +
> +	TP_STRUCT__entry(
> +		__string(buffer, buffer)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(buffer, buffer);
> +	),
> +
> +	TP_printk("%s", __get_str(buffer))
> +);
> +
> +#endif /* _TRACE_SOCK_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> -- 
> 2.35.1
> 
