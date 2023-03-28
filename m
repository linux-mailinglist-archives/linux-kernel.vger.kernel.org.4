Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2E66CCC1D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 23:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjC1VcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 17:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC1VcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:32:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081351BF6;
        Tue, 28 Mar 2023 14:32:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 996126196F;
        Tue, 28 Mar 2023 21:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC12C433D2;
        Tue, 28 Mar 2023 21:32:04 +0000 (UTC)
Date:   Tue, 28 Mar 2023 17:32:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        brauner@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v9 05/11] tracing/user_events: Add ioctl for disabling
 addresses
Message-ID: <20230328173200.22ac45dc@gandalf.local.home>
In-Reply-To: <20230324223028.172-6-beaub@linux.microsoft.com>
References: <20230324223028.172-1-beaub@linux.microsoft.com>
        <20230324223028.172-6-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 15:30:22 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> Enablements are now tracked by the lifetime of the task/mm. User
> processes need to be able to disable their addresses if tracing is
> requested to be turned off. Before unmapping the page would suffice.
> However, we now need a stronger contract. Add an ioctl to enable this.
> 
> A new flag bit is added, freeing, to user_event_enabler to ensure that
> if the event is attempted to be removed while a fault is being handled
> that the remove is delayed until after the fault is reattempted.
> 
> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> ---
>  include/uapi/linux/user_events.h | 24 +++++++++
>  kernel/trace/trace_events_user.c | 93 +++++++++++++++++++++++++++++++-
>  2 files changed, 115 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/user_events.h b/include/uapi/linux/user_events.h
> index 22521bc622db..3e7275e3234a 100644
> --- a/include/uapi/linux/user_events.h
> +++ b/include/uapi/linux/user_events.h
> @@ -46,6 +46,27 @@ struct user_reg {
>  	__u32 write_index;
>  } __attribute__((__packed__));
>  
> +/*
> + * Describes an event unregister, callers must set the size, address and bit.
> + * This structure is passed to the DIAG_IOCSUNREG ioctl to disable bit updates.
> + */
> +struct user_unreg {
> +	/* Input: Size of the user_unreg structure being used */
> +	__u32 size;
> +
> +	/* Input: Bit to unregister */
> +	__u8 disable_bit;
> +
> +	/* Input: Reserved, set to 0 */
> +	__u8 __reserved;
> +
> +	/* Input: Reserved, set to 0 */
> +	__u16 __reserved2;

These are reserved so they must be set to zero, such that old programs do
not break when they become meaningful and something had it randomly set
(due to being uninitialized).


> +
> +	/* Input: Address to unregister */
> +	__u64 disable_addr;
> +} __attribute__((__packed__));
> +
>  #define DIAG_IOC_MAGIC '*'
> 

> @@ -2086,6 +2100,75 @@ static long user_events_ioctl_del(struct user_event_file_info *info,
>  	return ret;
>  }
>  
> +static long user_unreg_get(struct user_unreg __user *ureg,
> +			   struct user_unreg *kreg)
> +{
> +	u32 size;
> +	long ret;
> +
> +	ret = get_user(size, &ureg->size);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (size > PAGE_SIZE)
> +		return -E2BIG;
> +
> +	if (size < offsetofend(struct user_unreg, disable_addr))
> +		return -EINVAL;
> +
> +	ret = copy_struct_from_user(kreg, sizeof(*kreg), ureg, size);
> +
> +	return ret;
> +}
> +
> +/*
> + * Unregisters an enablement address/bit within a task/user mm.
> + */
> +static long user_events_ioctl_unreg(unsigned long uarg)
> +{
> +	struct user_unreg __user *ureg = (struct user_unreg __user *)uarg;
> +	struct user_event_mm *mm = current->user_event_mm;
> +	struct user_event_enabler *enabler, *next;
> +	struct user_unreg reg;
> +	long ret;
> +
> +	ret = user_unreg_get(ureg, &reg);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (!mm)
> +		return -ENOENT;
> +
> +	ret = -ENOENT;

Probably should add:

	if (reg.__reserved || reg.__reserved2)
		return -EINVAL;

here.

-- Steve

> +
> +	/*
> +	 * Flags freeing and faulting are used to indicate if the enabler is in
> +	 * use at all. When faulting is set a page-fault is occurring asyncly.
> +	 * During async fault if freeing is set, the enabler will be destroyed.
> +	 * If no async fault is happening, we can destroy it now since we hold
> +	 * the event_mutex during these checks.
> +	 */
> +	mutex_lock(&event_mutex);
> +
> +	list_for_each_entry_safe(enabler, next, &mm->enablers, link)
> +		if (enabler->addr == reg.disable_addr &&
> +		    (enabler->values & ENABLE_VAL_BIT_MASK) == reg.disable_bit) {
> +			set_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler));
> +
> +			if (!test_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler)))
> +				user_event_enabler_destroy(enabler);
> +
> +			/* Removed at least one */
> +			ret = 0;
> +		}
> +
> +	mutex_unlock(&event_mutex);
> +
> +	return ret;
> +}
> +
>  /*
>   * Handles the ioctl from user mode to register or alter operations.
>   */
> @@ -2108,6 +2191,12 @@ static long user_events_ioctl(struct file *file, unsigned int cmd,
>  		ret = user_events_ioctl_del(info, uarg);
>  		mutex_unlock(&group->reg_mutex);
>  		break;
> +
> +	case DIAG_IOCSUNREG:
> +		mutex_lock(&group->reg_mutex);
> +		ret = user_events_ioctl_unreg(uarg);
> +		mutex_unlock(&group->reg_mutex);
> +		break;
>  	}
>  
>  	return ret;

