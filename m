Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23F863801E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 21:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiKXUVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 15:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXUVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 15:21:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74439B0412
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 12:21:06 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669321264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PhtG+5ai4v5n19/dXHQw5y9A8veO9GcqYNQBOwGfmd0=;
        b=xpw23yPR9UKX1fn/47aWsOgaYswdEbmL79DjR1KqBmywsle2dnloy+jrr/+DxJ5wnvkadV
        TFaVJr/Is11irTE6s/vM9Sqk5QTLJ7MzC+3w+A5np/PgysJaTN5ZMa27YphvLDl3CDlpZz
        /zVNBTR5MjGSRieruvpz1t9RU2LJNlp7+egvLLR07uo9Zg96eab7h5TSK2hR7uyWyqoic1
        +kqtjuO5ZQ/lOu57KNW/zwYyU39EOSGrWGEDQ7DMrzzREA8zQ4WZ03Ci/LhgHaFzCitsm5
        vfffflf3Wl/bJWGs6jatgkkEmRWBz/c3mkiVqVGvpbcv0W5lP03GJ9J9M2n/jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669321264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PhtG+5ai4v5n19/dXHQw5y9A8veO9GcqYNQBOwGfmd0=;
        b=RE+ldaPUvU67TaxGOoMh1eduRMg3NNqfih9fETK87RcRpGZ62AwCn3qsT/P161PBdaxSu8
        lPXMSv4NLUIOcqDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 1/7] printk: Move buffer size defines
In-Reply-To: <Y3+C7Znahs3q83wh@alley>
References: <20221123231400.614679-1-john.ogness@linutronix.de>
 <20221123231400.614679-2-john.ogness@linutronix.de>
 <Y39Q5TjoHUUKXC1S@alley> <87zgcgttmi.fsf@jogness.linutronix.de>
 <Y3+C7Znahs3q83wh@alley>
Date:   Thu, 24 Nov 2022 21:26:54 +0106
Message-ID: <87wn7kkst5.fsf@jogness.linutronix.de>
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

On 2022-11-24, Petr Mladek <pmladek@suse.com> wrote:
> The motivation is that only thread/atomic consoles would need
> the console-specific buffer. The other consoles might share
> the global one.

I understand what you are saying. I will change it to a pointer and
assign it to an internal shared global static buffer on
register_console(). Then we can keep the size defines private.

For the upcoming thread/atomic consoles, I will setup the sprint-buffers
differently.

> Also the atomic consoles would need these buffers for each context.
> It might be even more useful to allocate them dynamically.

Yes, atomic consoles need dedicated per-console, per-cpu, per-context
buffers. Some of these are allocated dynamically. I will revisit this
with the idea of minimizing static buffers.

John
