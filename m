Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262496138CD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiJaOQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiJaOQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:16:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CC1F19;
        Mon, 31 Oct 2022 07:16:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85281B8188F;
        Mon, 31 Oct 2022 14:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034ACC433D6;
        Mon, 31 Oct 2022 14:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667225759;
        bh=1NjzKCQeF90TceJVq9hppXxp0Gw2AH3DhTZPPlIhx/k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qN0fneNmbZyBOAFNqYgzoXle0JuK84BF72xRAqDhcP1O+rNNLEE175NkKZRHrCJhk
         cIIwHGA8DLqpCUYDMyB2qTRZhVplP5Vu1boT9VhROGwU8Rx0o7rGfkjIwca9CX3/XJ
         U7ykerBYilVfbQXg63zyjVKTpudXDyR/kA3ABHyZmvkS6LRRJTj10hWTa7/IOv4PBs
         i5XXV4KYPZoT0RnxbigwJaOeR2SLocGNTJWEudw4nqYBW3saRl0w16dhCvVxgpII8l
         RECe2WIQro1nycClbeLMXdgruy00yx+4v/mtMizkZVYDJwEm9IRrt/PV3vTX9A5OGV
         0Pt0dKE1BDgyg==
Date:   Mon, 31 Oct 2022 23:15:56 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] tracing/user_events: Remote write ABI
Message-Id: <20221031231556.a15846fd3513641d48820d5b@kernel.org>
In-Reply-To: <20221027224011.2075-1-beaub@linux.microsoft.com>
References: <20221027224011.2075-1-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Beau,

On Thu, 27 Oct 2022 15:40:09 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> As part of the discussions for user_events aligned with user space
> tracers, it was determined that user programs should register a 32-bit
> value to set or clear a bit when an event becomes enabled. Currently a
> shared page is being used that requires mmap().
> 
> In this new model during the event registration from user programs 2 new
> values are specified. The first is the address to update when the event
> is either enabled or disabled. The second is the bit to set/clear to
> reflect the event being enabled. This allows for a local 32-bit value in
> user programs to support both kernel and user tracers. As an example,
> setting bit 31 for kernel tracers when the event becomes enabled allows
> for user tracers to use the other bits for ref counts or other flags.
> The kernel side updates the bit atomically, user programs need to also
> update these values atomically.

I think you means the kernel tracer (ftrace/perf) and user tracers (e.g. 
LTTng) use the same 32bit data so that traced user-application only checks
that data for checking an event is enabled, right?

If so, who the user tracer threads updates the data bit? Is that thread
safe to update both kernel tracer and user tracers at the same time?

And what is the actual advantage of this change? Are there any issue
to use mmaped page? I would like to know more background of this
change.

Could you also provide any sample program which I can play it? :)

> User provided addresses must be aligned on a 32-bit boundary, this
> allows for single page checking and prevents odd behaviors such as a
> 32-bit value straddling 2 pages instead of a single page.
> 
> When page faults are encountered they are done asyncly via a workqueue.
> If the page faults back in, the write update is attempted again. If the
> page cannot fault-in, then we log and wait until the next time the event
> is enabled/disabled. This is to prevent possible infinite loops resulting
> from bad user processes unmapping or changing protection values after
> registering the address.
> 
> NOTE:
> User programs that wish to have the enable bit shared across forks
> either need to use a MAP_SHARED allocated address or register a new
> address and file descriptor. If MAP_SHARED cannot be used or new
> registrations cannot be done, then it's allowable to use MAP_PRIVATE
> as long as the forked children never update the page themselves. Once
> the page has been updated, the page from the parent will be copied over
> to the child. This new copy-on-write page will not receive updates from
> the kernel until another registration has been performed with this new
> address.
> 
> Beau Belgrave (2):
>   tracing/user_events: Use remote writes for event enablement
>   tracing/user_events: Fixup enable faults asyncly
> 
>  include/linux/user_events.h      |  10 +-
>  kernel/trace/trace_events_user.c | 396 ++++++++++++++++++++-----------
>  2 files changed, 270 insertions(+), 136 deletions(-)
> 
> 
> base-commit: 23758867219c8d84c8363316e6dd2f9fd7ae3049
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
