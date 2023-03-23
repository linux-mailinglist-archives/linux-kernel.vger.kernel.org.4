Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6BA6C7067
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjCWSm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjCWSmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:42:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66E312076
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 11:42:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7270F6285F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 18:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A5DC433A0;
        Thu, 23 Mar 2023 18:42:21 +0000 (UTC)
Date:   Thu, 23 Mar 2023 14:42:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tracepoint: Fix CFI failures with tp_stub_func
Message-ID: <20230323144220.2729561c@gandalf.local.home>
In-Reply-To: <ed29379c-d683-7140-ba82-b3fe8e4d49a5@efficios.com>
References: <20230323114012.2162285-1-mark.rutland@arm.com>
        <20230323085321.0f8d1b98@gandalf.local.home>
        <ZBxX/uu/s5IKBQOw@FVFF77S0Q05N.cambridge.arm.com>
        <ZBx9+ZyiF6LoKbPr@FVFF77S0Q05N.cambridge.arm.com>
        <20230323123455.36dd83f6@gandalf.local.home>
        <ed29379c-d683-7140-ba82-b3fe8e4d49a5@efficios.com>
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

On Thu, 23 Mar 2023 14:37:15 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > Repeated again so Mathieu doesn't have to search for it.
> > 
> >      [ Note, this version does use undefined compiler behavior (assuming that
> >        a stub function with no parameters or return, can be called by a location
> >        that thinks it has parameters but still no return value. Static calls
> >        do the same thing, so this trick is not without precedent.
> > 
> >        There's another solution that uses RCU tricks and is more complex, but
> >        can be an alternative if this solution becomes an issue.
> > 
> >        Link: https://lore.kernel.org/lkml/20210127170721.58bce7cc@gandalf.local.home/
> >      ]  
> 
> Ugh. The last thing we need there is more RCU complexity. My brain is still recovering
> from fixing the last time the introduction of static calls special-cases ended up subtly
> breaking tracepoints.

Well, we can go back to your approach with doing the check in the iterator.
Setting it to 0x1UL I think is what you wanted (to know it's a removed
function and not a random NULL).

I could write that up if you want.

-- Steve
