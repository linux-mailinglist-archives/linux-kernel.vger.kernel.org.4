Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16576CA8E1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjC0P13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjC0P1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:27:25 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E279230C0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:27:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0D4E8CE17B9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 15:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A656EC433D2;
        Mon, 27 Mar 2023 15:27:19 +0000 (UTC)
Date:   Mon, 27 Mar 2023 11:27:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Enable histograms for events/ftrace/timerlat and osnoise
Message-ID: <20230327112715.023a94fd@gandalf.local.home>
In-Reply-To: <9a1bb631-587c-9771-99b7-55623c67bb83@redhat.com>
References: <ead16e4f-a05b-8b76-e1e6-52223effd6c5@redhat.com>
        <9a1bb631-587c-9771-99b7-55623c67bb83@redhat.com>
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

On Mon, 27 Mar 2023 14:37:11 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> On 3/24/23 17:13, Daniel Bristot de Oliveira wrote:
> > Hi Steven
> > 
> > I would like to collect histograms from timerlat and osnoise tracers event,
> > but I cannot collect them because they are not tracepoints but... tracer
> > events. So...
> > 
> >   # ls /sys/kernel/tracing/events/ftrace/timerlat/
> >   format	hist
> > 
> > no hist, filter, trigger files...  
> 
> Ooop, the hist file exists, what is missing is the trigger file, which is
> used to enable the histogram...
> 
> it seems that the "limitation" is around TRACE_EVENT_FL_IGNORE_ENABLE flag, and
> the fact that ftrace events cannot be enabled/disabled... 
> 
> but wait, as the hist file exist, is there any other way to enable
> the histogram? (or should we disable hist files for !TRACE_EVENT_FL_IGNORE_ENABLE)?

No, I think we just missed not creating the "hist" file, which should not
actually exist.

> 
> am I missing something?
> 
> > How hard would it be to enable histograms to the ftrace/osnoise and
> > ftrace/timerlat events?

I'll try to get some time to look at this. No guarantees :-p

-- Steve

> > 
> > This will allow me to reduce the overhead of rtla timerlat and rtla osnoise
> > tools...
> > 
> > Thanks in advance, Stephen!
> > -- Denny  

