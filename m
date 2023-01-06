Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439D065FF75
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjAFLWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjAFLWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:22:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA6B687B0
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 03:22:00 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6983B24ADE;
        Fri,  6 Jan 2023 11:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673004119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YiV5SWV15+9OzyG0Y8H/4VK8eyQ6JV6OIY3FhAWQtVI=;
        b=IrEkYmNPjsAXgbfuU+KwM1v3dEwdnOTABq3BJCz5jcA9EHzXuVVOQzreYeQh8OCtFkN3Vg
        JfaNsH9bpUEda0oJQRGAy2cuTPj2jff+jB0HcxbpLyMo8x7HstwG9nU84e32GkC3+atKni
        UnF49JvOMK8MIEfPHSkNn/wVRAbTXnM=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 493592C143;
        Fri,  6 Jan 2023 11:21:59 +0000 (UTC)
Date:   Fri, 6 Jan 2023 12:21:58 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v4 0/8] printk: cleanup buffer handling
Message-ID: <Y7gEVpMTvI0WzPH7@alley>
References: <20230105103735.880956-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105103735.880956-1-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-01-05 11:43:27, John Ogness wrote:
> Hi,
> 
> This is v4 of a series to cleanup console buffer handling and
> prepare for code sharing with the upcoming threaded/atomic
> consoles. v3 is here [0].
> 
> The main purpose of the series is to introduce two new lockless
> functions to handle reading and formatting of printk messages. These
> functions can then be used from any context, which is important for
> the upcoming threaded/atomic consoles. The series also helps to
> cleanup some of the internal printk interfaces and cleanly separate
> formatting code from outputting code.
> 
> John Ogness (6):
>   printk: move size limit macros into internal.h
>   printk: introduce struct printk_buffers
>   printk: introduce printk_get_next_message() and printk_message
>   printk: introduce console_prepend_dropped() for dropped messages

This patch would need a followup fix to prevent the compiler warning.

>   printk: use printk_buffers for devkmsg

This one would need respin to fix the problem with suppressed messages.

>   printk: adjust string limit macros
> 
> Thomas Gleixner (2):
>   console: Use BIT() macros for @flags values
>   console: Document struct console

The rest looks ready for linux-next.

I see three ways how to move forward:

1. Respin the entire patchset.
2. Respin only 7th patch + send the follow up fix seperately
3. Push first 6 patches and handle the rest separately.

What would be more convenient for you, please?
Honestly, I do not have any real preference.

Best Regards,
Petr
