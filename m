Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B376365E1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237943AbiKWQdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbiKWQdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:33:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DCD22515;
        Wed, 23 Nov 2022 08:33:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 744EA61DF6;
        Wed, 23 Nov 2022 16:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E966C433D6;
        Wed, 23 Nov 2022 16:33:05 +0000 (UTC)
Date:   Wed, 23 Nov 2022 11:33:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing/eprobe: Update cond flag before enabling
 trigger
Message-ID: <20221123113304.3f41ff1b@gandalf.local.home>
In-Reply-To: <20221124010152.75846db3bc63a5c6c109945f@kernel.org>
References: <20221116192552.1066630-1-rafaelmendsr@gmail.com>
        <20221117211726.4bbbb96a@gandalf.local.home>
        <20221117213109.6119750e@gandalf.local.home>
        <Y3d9KcpcwrEUUYKT@macondo>
        <Y3eJ8GiGnEvVd8/N@macondo>
        <20221118111940.1268da2b@gandalf.local.home>
        <20221124010152.75846db3bc63a5c6c109945f@kernel.org>
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

On Thu, 24 Nov 2022 01:01:52 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Fri, 18 Nov 2022 11:19:40 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 18 Nov 2022 10:34:40 -0300
> > Rafael Mendonca <rafaelmendsr@gmail.com> wrote:
> >   
> > > It did not trigger the NULL pointer issue to be more specific. When
> > > creating event probe for all events I was unable to create any event for
> > > the xhci-hcd system:
> > > 
> > > root@localhost:/sys/kernel/tracing# echo 'e xhci-hcd/xhci_add_endpoint' > dynamic_events 
> > > -bash: echo: write error: Invalid argument
> > > 
> > > Debugging the issue it seems that the problem is in the is_good_name()
> > > check, which returns false for "xhci-hcd". Should we sanitize it by  
> > 
> > Ouch. I didn't realize that.  
> 
> Maybe we need better error message so that user can notice which character
> caused the error. 
> 
> >   
> > > converting '-' into '_'?  
> > 
> > Actually, it's just the system name that's an issue. I tested this patch
> > and it appears to work.  
> 
> Ah, the system name is more flexible than the event name because it has
> TRACE_SYSTEM_VAR.
> 
> Steve, can you send me the below patch?

I already did ;-)

  https://patchwork.kernel.org/project/linux-trace-kernel/patch/20221122122345.160f5077@gandalf.local.home/


> 
> BTW, TRACE_DEFINE_ENUM() and TRACE_DEFINE_SIZEOF() macros are using
> TRACE_SYSTEM instead of TRACE_SYSTEM_VAR. Should those use TRACE_SYSTEM_VAR
> for defining a variable?

Hmm, good question. Probably. But since nothing that has a bad name uses
it, we can fix that whenever (but before a system with a hyphen uses those
macros). Do you want to make the change, or shall I?

-- Steve
