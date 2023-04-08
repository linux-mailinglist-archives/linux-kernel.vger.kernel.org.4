Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24A66DBB71
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 16:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjDHOFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 10:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjDHOFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 10:05:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8601026B
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 07:04:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CC36609FF
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 14:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB09C433D2;
        Sat,  8 Apr 2023 14:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680962629;
        bh=mHNb6f80yV6HAqlcDpofJ/tN8EubMjP7pWEZDrzIG3o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=puPebhxdOUMmy5BqO08AOWiOeqXlX7Pcb1ehTkaLEi594ZcPdzBnbM3wWmnP7GR8x
         Othlp8nbXAiEuaXMfXok4BaOFVVMdXXgtxfSDU8du1Y6Xty+kBhyaXXg4Gn0+n3SgW
         08l1qCH9GpmO2OAwfXVBbglz2mxJkD9lBlavPvoHj/sZFdngl53Z4O0eBNIuR9s8BG
         1NgXqTk1lsUHIUaI8rpz3J8FYXeHPN+7kVa8wYuIpKr3vYgvWW4H4n87uN8x9qxu4C
         ifml6RRXOtLL6mmUOoeXn30OsPIQL0z6kgCtmSt1MbNTJAPZJcJdcD7VpUGRNbrwkg
         6MaBfjvfykDvg==
Date:   Sat, 8 Apr 2023 23:03:44 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] tracepoint: Fix CFI failures with tp_sub_func
Message-Id: <20230408230344.06f9c6c95d4659b2f5363ba0@kernel.org>
In-Reply-To: <20230404162232.1b2f4c2f@gandalf.local.home>
References: <20230324123142.7463-1-mathieu.desnoyers@efficios.com>
        <75dbeff6-fd0c-aec1-5821-919088eda6c4@efficios.com>
        <ZCwDAnRHjNr9ZftR@FVFF77S0Q05N>
        <20230404162232.1b2f4c2f@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2023 16:22:41 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 4 Apr 2023 11:59:26 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > Sorry to ping, but are you planning to pick this up, and/or did you want this
> > resent with the Testing-by typo fixed?
> > 
> > I couldn't spot it in the tracing tree, and I'm not sure if it's still on your
> > TODO list for review or has just been missed.
> 
> Actually, we may be going back to your original patches, as having a stub
> function for every trace event will allow us to attach fprobes to them. And
> we actually have a need to do that (connecting to tracepoints to get more
> info than the trace event gives).
> 
> Masami is currently working on this.

I think we need another stub function similar to the original patch, because
the __tracestub_* functions are usually not called back. Even if I enabled
the static key to enable the stub callback, if user sets another callback
handler to the tracepoint (e.g. enable trace event on it), the __tracestub_*
function is not called anymore.

Thus I think we just pick this version and add another patch to introduce
__probestub_* functions in macro, and fprobe on it. This new stub function is
something like the original one so that it doesn't break CFI. And it will be
registered to tracepoint when the new fprobe based dynamic event is enabled.


Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
