Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B2B65EA7B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjAEMOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjAEMOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:14:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABE344C7B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:14:49 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672920888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tmi4Pi0M7Z+bsGbeb5MBybKzbvxIAT/ysqSDY6Bfdv4=;
        b=Q7wNhSKEmMeazvM5pMn7Gnemzq+mtBXVczIBjjGfEZKImrNua4ANCbseThVLruBIQIESke
        +Npojac4b+xsXE3bpCPdxeIiBYr2EhrfOr/M11xSxVIcG5XoQoRPDszrvVuf+Gx1DJJfbY
        0KTxL1AbpCoMZWoZLOixx6Hs8Jv1JbAo4FjqROBQ1iGtHXRa7LqhWNsW7ZV2l9O3RM2/qm
        fEUMPloN9WRzlFm8gm7gxig7VmsCFF+P79MSfN1FldmkQw03fszARGqD8YEla+ijCf+pUx
        lSrZO6VBVZkEVLwm5rbqEdAAf6TgTi8/y5GklZxNmAIVRp9UgCYgnBdmckmZmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672920888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tmi4Pi0M7Z+bsGbeb5MBybKzbvxIAT/ysqSDY6Bfdv4=;
        b=uOifAirjuP+QhxRnPrXBRC5mRKgO+4XXmrqEzJBs6sHyMKQwgooX0vQhFdVDPC00MwAMkI
        YYmNoB1sRmbGkyBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 7/8] printk: use printk_buffers for devkmsg
In-Reply-To: <20230105103735.880956-8-john.ogness@linutronix.de>
References: <20230105103735.880956-1-john.ogness@linutronix.de>
 <20230105103735.880956-8-john.ogness@linutronix.de>
Date:   Thu, 05 Jan 2023 13:20:08 +0106
Message-ID: <87fscpch67.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-05, John Ogness <john.ogness@linutronix.de> wrote:
>  /* /dev/kmsg - userspace message inject/listen interface */
>  struct devkmsg_user {
>  	atomic64_t seq;
>  	struct ratelimit_state rs;
>  	struct mutex lock;
> -	char buf[CONSOLE_EXT_LOG_MAX];
>  
> +	struct printk_buffers pbufs;
>  	struct printk_info info;
> -	char text_buf[CONSOLE_EXT_LOG_MAX];
>  	struct printk_record record;
>  };

There is also no need for the printk_info and printk_record
structs. printk_get_next_message() uses its own on the stack.

> @@ -797,7 +801,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
>  	if (ret)
>  		return ret;
>  
> -	if (!prb_read_valid(prb, atomic64_read(&user->seq), r)) {
> +	if (!printk_get_next_message(&pmsg, atomic64_read(&user->seq), true)) {

This needs to be a while loop because printk_get_next_message() should
be the only function reading from the ringbuffer. The
wait_event_interruptible() in this loop should just wait for the
existence of the new record. It should not be the one reading it.

I will reply to this message with the correct patch to replace this
patch.

John Ogness
