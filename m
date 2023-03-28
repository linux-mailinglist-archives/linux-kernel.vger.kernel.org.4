Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620BA6CCBBA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 22:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjC1U7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 16:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC1U7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:59:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BFE9B;
        Tue, 28 Mar 2023 13:59:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6C36B81E71;
        Tue, 28 Mar 2023 20:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D5AC433EF;
        Tue, 28 Mar 2023 20:59:42 +0000 (UTC)
Date:   Tue, 28 Mar 2023 16:59:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        brauner@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 03/11] tracing/user_events: Use remote writes for
 event enablement
Message-ID: <20230328165939.1dcddd1a@gandalf.local.home>
In-Reply-To: <20230221211143.574-4-beaub@linux.microsoft.com>
References: <20230221211143.574-1-beaub@linux.microsoft.com>
        <20230221211143.574-4-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 13:11:35 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

>  include/linux/user_events.h      |  53 ++-
>  include/uapi/linux/user_events.h |  15 +-
>  kernel/trace/Kconfig             |   5 +-
>  kernel/trace/trace_events_user.c | 586 ++++++++++++++++++++++++-------
>  4 files changed, 517 insertions(+), 142 deletions(-)
> 
> diff --git a/include/linux/user_events.h b/include/linux/user_events.h
> index 3d747c45d2fa..0120b3dd5b03 100644
> --- a/include/linux/user_events.h
> +++ b/include/linux/user_events.h
> @@ -9,13 +9,63 @@
>  #ifndef _LINUX_USER_EVENTS_H
>  #define _LINUX_USER_EVENTS_H
>  
> +#include <linux/list.h>
> +#include <linux/refcount.h>
> +#include <linux/mm_types.h>
> +#include <linux/workqueue.h>
>  #include <uapi/linux/user_events.h>
>  
>  #ifdef CONFIG_USER_EVENTS
>  struct user_event_mm {
> +	struct list_head link;
> +	struct list_head enablers;
> +	struct mm_struct *mm;
> +	struct user_event_mm *next;
> +	refcount_t refcnt;
> +	refcount_t tasks;
> +	struct rcu_work put_rwork;
>  };

This is more of a nit, and not something to change unless there's more real
content to change, but please when making structures tab out the field
names:

struct user_event_mm {
	struct list_head	link;
	struct list_head	enablers;
	struct mm_struct	*mm;
	struct user_event_mm	*next;
	refcount_t		refcnt;
	refcount_t		tasks;
	struct rcu_work		put_rwork;
};


See how much easier it is to read (and know what fields exist).



> -#endif
>  

>  #endif /* _LINUX_USER_EVENTS_H */
> diff --git a/include/uapi/linux/user_events.h b/include/uapi/linux/user_events.h
> index 03f92366068d..22521bc622db 100644
> --- a/include/uapi/linux/user_events.h
> +++ b/include/uapi/linux/user_events.h
> @@ -27,12 +27,21 @@ struct user_reg {
>  	/* Input: Size of the user_reg structure being used */
>  	__u32 size;
>  
> +	/* Input: Bit in enable address to use */
> +	__u8 enable_bit;
> +
> +	/* Input: Enable size in bytes at address */
> +	__u8 enable_size;
> +
> +	/* Input: Flags for future use, set to 0 */
> +	__u16 flags;
> +
> +	/* Input: Address to update when enabled */
> +	__u64 enable_addr;
> +
>  	/* Input: Pointer to string with event name, description and flags */
>  	__u64 name_args;
>  
> -	/* Output: Bitwise index of the event within the status page */
> -	__u32 status_bit;
> -
>  	/* Output: Index of the event to use when writing data */
>  	__u32 write_index;
>  } __attribute__((__packed__));

May want to tab the above too, but as each field is commented, it's not as
big of an issue.


> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index d7043043f59c..b61a1bfbfc22 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -791,9 +791,10 @@ config USER_EVENTS
>  	  can be used like an existing kernel trace event.  User trace
>  	  events are generated by writing to a tracefs file.  User
>  	  processes can determine if their tracing events should be
> -	  generated by memory mapping a tracefs file and checking for
> -	  an associated byte being non-zero.
> +	  generated by registering a value and bit with the kernel
> +	  that reflects when it is enabled or not.
>  
> +	  See Documentation/trace/user_events.rst.
>  	  If in doubt, say N.
>  
>  config HIST_TRIGGERS
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 070551480747..553a82ee7aeb 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -19,6 +19,7 @@
>  #include <linux/tracefs.h>
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
> +#include <linux/highmem.h>
>  #include <linux/user_events.h>
>  #include "trace.h"
>  #include "trace_dynevent.h"
> @@ -29,34 +30,11 @@
>  #define FIELD_DEPTH_NAME 1
>  #define FIELD_DEPTH_SIZE 2
>  
> -/*
> - * Limits how many trace_event calls user processes can create:
> - * Must be a power of two of PAGE_SIZE.
> - */
> -#define MAX_PAGE_ORDER 0
> -#define MAX_PAGES (1 << MAX_PAGE_ORDER)
> -#define MAX_BYTES (MAX_PAGES * PAGE_SIZE)
> -#define MAX_EVENTS (MAX_BYTES * 8)
> -
>  /* Limit how long of an event name plus args within the subsystem. */
>  #define MAX_EVENT_DESC 512
>  #define EVENT_NAME(user_event) ((user_event)->tracepoint.name)
>  #define MAX_FIELD_ARRAY_SIZE 1024
>  
> -/*
> - * The MAP_STATUS_* macros are used for taking a index and determining the
> - * appropriate byte and the bit in the byte to set/reset for an event.
> - *
> - * The lower 3 bits of the index decide which bit to set.
> - * The remaining upper bits of the index decide which byte to use for the bit.
> - *
> - * This is used when an event has a probe attached/removed to reflect live
> - * status of the event wanting tracing or not to user-programs via shared
> - * memory maps.
> - */
> -#define MAP_STATUS_BYTE(index) ((index) >> 3)
> -#define MAP_STATUS_MASK(index) BIT((index) & 7)
> -
>  /*
>   * Internal bits (kernel side only) to keep track of connected probes:
>   * These are used when status is requested in text form about an event. These
> @@ -70,20 +48,14 @@
>  #define EVENT_STATUS_OTHER BIT(7)
>  
>  /*
> - * Stores the pages, tables, and locks for a group of events.
> - * Each logical grouping of events has its own group, with a
> - * matching page for status checks within user programs. This
> - * allows for isolation of events to user programs by various
> - * means.
> + * Stores the system name, tables, and locks for a group of events. This
> + * allows isolation for events by various means.
>   */
>  struct user_event_group {
> -	struct page *pages;
> -	char *register_page_data;
>  	char *system_name;
>  	struct hlist_node node;
>  	struct mutex reg_mutex;
>  	DECLARE_HASHTABLE(register_table, 8);
> -	DECLARE_BITMAP(page_bitmap, MAX_EVENTS);
>  };
>  
>  /* Group for init_user_ns mapping, top-most group */
> @@ -106,12 +78,34 @@ struct user_event {
>  	struct list_head fields;
>  	struct list_head validators;
>  	refcount_t refcnt;
> -	int index;
> -	int flags;
>  	int min_size;
>  	char status;
>  };

But these should be tabbed out.

>  
> +/*
> + * Stores per-mm/event properties that enable an address to be
> + * updated properly for each task. As tasks are forked, we use
> + * these to track enablement sites that are tied to an event.
> + */
> +struct user_event_enabler {
> +	struct list_head link;
> +	struct user_event *event;
> +	unsigned long addr;
> +
> +	/* Track enable bit, flags, etc. Aligned for bitops. */
> +	unsigned int values;
> +};
> +

And the above.

> +/* Bits 0-5 are for the bit to update upon enable/disable (0-63 allowed) */
> +#define ENABLE_VAL_BIT_MASK 0x3F
> +

This is something that can be added later as a clean up, but if there's a
real issue found with these patches, then make the next version have the
updates.

If you do another version, update the tabs of existing structures in a
separate patch from any content change.

-- Steve
