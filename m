Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF8865C2A3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237996AbjACPAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbjACPAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:00:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966F6FCFF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 07:00:43 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672758041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dyltWrd1W2nJE9Id3WrSJcwZcUPegvz9Nx4/qvQaUKE=;
        b=gKIlYMmJ0h5R+bOquhiZc0nALMmjsbTlS09FDOBHOlqiqJSZmwUBTmoANwEDVL4urdY57t
        JvSgyvHmpet3/KyiOiesURWkwUoZGy00DQWEYjZ2fC3Mt1dXhjQ76XiXEsxJ144orWCjr/
        Fe9iR/7je/T8WSVkoPu75tTkeOaCIYSzK2jTzIjMmFEv2YwMsm71wEhwdbJ7cma39NxyG4
        b74mBF1jijdUtUkGadJ2lVc+6jppSCYmqgNCiuLBaR7k4P4w1UE4mrHtbaoJ5HwUFXjaSF
        yNEnybh0oJLbvog6Q0VTM4RRFNNW23OiWx681UdgNy4TyhrmCIm/wIRf6vmSEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672758041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dyltWrd1W2nJE9Id3WrSJcwZcUPegvz9Nx4/qvQaUKE=;
        b=/fesHhHEMlax7Yj3qnd0g2fAvKxR7Z7ESKXIgRTO5JC6hGneokLFtfV6wx8UAQO+vKwhwz
        75EGzgkoXEd61bBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 6/6] printk: introduce
 console_prepend_dropped() for dropped messages
In-Reply-To: <Y7Q4u9ICptw0RnXb@alley>
References: <20221221202704.857925-1-john.ogness@linutronix.de>
 <20221221202704.857925-7-john.ogness@linutronix.de>
 <Y7MEDmP1zqWblj0N@alley> <87y1qjdimw.fsf@jogness.linutronix.de>
 <Y7QtusGlIX3AU+TN@alley> <87o7rfd96w.fsf@jogness.linutronix.de>
 <Y7Q4u9ICptw0RnXb@alley>
Date:   Tue, 03 Jan 2023 16:06:03 +0106
Message-ID: <87fscrd5os.fsf@jogness.linutronix.de>
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

On 2023-01-03, Petr Mladek <pmladek@suse.com> wrote:
>> Actually, I would like to rename all of those limit macros to something
>> that makes more sense for the new code base:
>> 
>> CONSOLE_EXT_LOG_MAX -> CONSOLE_MESSAGE_MAX
>> 
>> CONSOLE_LOG_MAX     -> SYSLOG_MESSAGE_MAX
>
> Heh, we actually do not need this. The size of @scratchbuf
> might be LOG_LINE_MAX/PRINTK_RECORD_MAX. The scratch buffer
> is newly used only to read the plain message. The prefixes
> are added to @outbuf.
>
>> LOG_LINE_MAX        -> PRINTK_RECORD_MAX

The scratch buffer would become PRINTK_RECORD_MAX, but we still need
SYSLOG_MESSAGE_MAX for the kmalloc's syslog buffers. Unless you think it
is OK to kmalloc 8KB instead of 1KB for the syslog calls. Then yes, we
do not need SYSLOG_MESSAGE_MAX.

John
