Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4529F6511AE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiLSSVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiLSSVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:21:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F6F2DD8;
        Mon, 19 Dec 2022 10:21:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1DA3B80ED7;
        Mon, 19 Dec 2022 18:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A31EC433EF;
        Mon, 19 Dec 2022 18:21:04 +0000 (UTC)
Date:   Mon, 19 Dec 2022 13:21:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <zwisler@google.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Add a way to filter function addresses to
 function names
Message-ID: <20221219132102.0dc6b7b9@gandalf.local.home>
In-Reply-To: <68fa6a9d-7a7f-00ba-e5a2-9b64f0aa7db3@huawei.com>
References: <20221214125209.09d736dd@gandalf.local.home>
        <68fa6a9d-7a7f-00ba-e5a2-9b64f0aa7db3@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2022 10:38:50 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > index 33e0b4f8ebe6..db6e2f399440 100644
> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c
> > @@ -2822,7 +2822,7 @@ static __init int setup_trace_triggers(char *str)
> >   		if (!trigger)
> >   			break;
> >   		bootup_triggers[i].event = strsep(&trigger, ".");
> > -		bootup_triggers[i].trigger = strsep(&trigger, ".");
> > +		bootup_triggers[i].trigger = strsep(&trigger, "");  
> 
> Would it be better to change to:
> 
>       bootup_triggers[i].trigger = trigger;
> 

Sure, I'll make the update.

> Because there is unnecessary loop if call strsep(s, "") :-)
>    strsep(s, ct) {
>      strpbrk(cs, ct) {
>        // when 'ct' is empty string, here will always return NULL
>        // after traversing string 'cs'

I'm not sure what you mean about an extra loop.

Thanks,

-- Steve
