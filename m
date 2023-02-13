Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D20694BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjBMP5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMP5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:57:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A7C124;
        Mon, 13 Feb 2023 07:57:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 295AF61177;
        Mon, 13 Feb 2023 15:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14CBC433D2;
        Mon, 13 Feb 2023 15:56:59 +0000 (UTC)
Date:   Mon, 13 Feb 2023 10:56:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, akpm@linux-foundation.org,
        zwisler@google.com, chinglinyu@google.com
Subject: Re: [PATCH 1/4] tracing/histogram: Don't use strlen to find length
 of stacktrace variables
Message-ID: <20230213105633.006a22fc@rorschach.local.home>
In-Reply-To: <20230214002418.0103b9e765d3e5c374d2aa7d@kernel.org>
References: <cover.1676063532.git.zanussi@kernel.org>
        <1ed6906cd9d6477ef2bd8e63c61de20a9ffe64d7.1676063532.git.zanussi@kernel.org>
        <20230214002418.0103b9e765d3e5c374d2aa7d@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 00:24:18 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > -				e = stack_trace_save((void *)str,
> > +				e = stack_trace_save((void *)stack_start,
> >  						     HIST_STACKTRACE_DEPTH,
> >  						     HIST_STACKTRACE_SKIP);  
> 
> BTW, the size of "str" is enough to store HIST_STACKTRACE_DEPTH?
> In string case, 
> 
> size = min(val->size, STR_VAR_LEN_MAX);
> 
> will limit the max size.

Well, we have:

#define HIST_STACKTRACE_DEPTH  16

And 16 * 8 = 128

#define STR_VAR_LEN_MAX              MAX_FILTER_STR_VAL
#define MAX_FILTER_STR_VAL 256U

So 128 < 256, with plenty of room. I wouldn't do this runtime, but we
should add here:

	BUILD_BUG_ON((HIST_STACKTRACE_DEPTH + 1) * sizeof(long) >= STR_VAR_LEN_MAX);

-- Steve
