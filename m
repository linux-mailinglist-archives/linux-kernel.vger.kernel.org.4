Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC146DE223
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjDKROp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjDKROm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:14:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E944228
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:14:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4735621E4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 17:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB5BC433EF;
        Tue, 11 Apr 2023 17:14:39 +0000 (UTC)
Date:   Tue, 11 Apr 2023 13:14:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] tracepoint: Fix CFI failures with tp_sub_func
Message-ID: <20230411131423.37b001f7@gandalf.local.home>
In-Reply-To: <20230408230344.06f9c6c95d4659b2f5363ba0@kernel.org>
References: <20230324123142.7463-1-mathieu.desnoyers@efficios.com>
        <75dbeff6-fd0c-aec1-5821-919088eda6c4@efficios.com>
        <ZCwDAnRHjNr9ZftR@FVFF77S0Q05N>
        <20230404162232.1b2f4c2f@gandalf.local.home>
        <20230408230344.06f9c6c95d4659b2f5363ba0@kernel.org>
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

On Sat, 8 Apr 2023 23:03:44 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> I think we need another stub function similar to the original patch, because
> the __tracestub_* functions are usually not called back. Even if I enabled
> the static key to enable the stub callback, if user sets another callback
> handler to the tracepoint (e.g. enable trace event on it), the __tracestub_*
> function is not called anymore.
> 
> Thus I think we just pick this version and add another patch to introduce
> __probestub_* functions in macro, and fprobe on it. This new stub function is
> something like the original one so that it doesn't break CFI. And it will be
> registered to tracepoint when the new fprobe based dynamic event is enabled.
> 

If we are going to add *another* stub, then no, I don't want to use it. But
I don't see why we can't use one stub for both?

What's the issue you are having?

-- Steve
