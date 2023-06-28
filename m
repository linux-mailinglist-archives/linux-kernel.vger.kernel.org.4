Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC54F74136C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjF1OIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjF1OGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:06:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BBE3580
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:06:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B83D61341
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70C1C433C0;
        Wed, 28 Jun 2023 14:06:39 +0000 (UTC)
Date:   Wed, 28 Jun 2023 10:06:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-linus][PATCH 0/3] tracing: Final updates for 6.4+
Message-ID: <20230628100634.7b95e358@rorschach.local.home>
In-Reply-To: <20230628125448.007243475@goodmis.org>
References: <20230628125448.007243475@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 08:54:48 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> The user events write currently returns the size of what was suppose to be
> written when tracing is disabled and nothing was written. Instead, behave like
> trace_marker and return -EBADF, as that is what is returned if a file is opened
> for read only,

I accidentally sent this before it was ready to go (I was editing the
change log from the previous one) I didn't finish the above paragraph,
and was suppose to delete the below one.

That's because I was about to rush to a talk at EOSS, and hit save and
exit forgetting that sends the emails out! (I'm using quilt)

I'll finish it properly for when I do the proper pull request.

-- Steve


> 
> Before user events become an ABI, fix the return value of the write
> operation when tracing is disabled. It should not return an error, but
> simply report it wrote zero bytes. Just like any other write operation
> that doesn't write but does not "fail".
> 
> This also includes test cases for this use case.
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> trace/urgent
> 
> Head SHA1: e155047e53d25f09d055c08ae9d6c269520e90d8
> 
> 
> sunliming (3):
>       tracing/user_events: Fix incorrect return value for writing operation when events are disabled
>       selftests/user_events: Enable the event before write_fault test in ftrace self-test
>       selftests/user_events: Add test cases when event is disabled
> 
> ----
>  kernel/trace/trace_events_user.c                  | 3 ++-
>  tools/testing/selftests/user_events/ftrace_test.c | 8 ++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)

