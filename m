Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5182F5FD5CD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 09:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiJMH6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 03:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiJMH6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 03:58:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E509F1326B4;
        Thu, 13 Oct 2022 00:58:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C0D3616A0;
        Thu, 13 Oct 2022 07:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D643C433C1;
        Thu, 13 Oct 2022 07:58:27 +0000 (UTC)
Date:   Thu, 13 Oct 2022 03:58:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Track event ref in tracefs enable/disable
Message-ID: <20221013035827.43f7f25c@rorschach.local.home>
In-Reply-To: <20221013001938.GA281@W11-BEAU-MD.localdomain>
References: <20221012215717.10492-1-beaub@linux.microsoft.com>
        <20221012182639.5a607add@rorschach.local.home>
        <20221013001938.GA281@W11-BEAU-MD.localdomain>
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

On Wed, 12 Oct 2022 17:19:38 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> > 
> > The events are only called from the module code, and when the module is
> > unloaded, they are no longer called. Why keep the module from unloading
> > when enabled?  
> 
> Won't the modules remove the event calls? At the very least the event
> call structure in memory goes away during module unload. If it gets
> reused odd things will happen, right? IE: trace_module_remove_events().

Yes it gets removed along with the module. But everything about the
static event is part of the module.

> 
> Maybe I have a bad assumption:
> I thought the point of trace_event_try_get_ref()/put_ref() was to tell
> the system the call cannot go away. However, if ftrace enable doesn't
> use these the lifetime is ambigious in this case. If this was
> intentional, how are event call lifetimes described if not within the
> ref?
> 

The purpose of trace_event_try_get_ref and friends is for the case of
dynamic events (eprobes and synthetic events) that can attach to any
event (including module events), and the module removal does not remove
the dynamic portion that was attached to them. And in this case, the
removal would have dire results.

> In my namespace patches I hit this case when user_events try to go away
> during namespace teardown. Since there is no reference to the event
> being used I removed the call. However, it was clearly being used within
> tracefs at that point. When I cat "enable" in this case instead of "0"
> or "1" I get "?". I suppose worse things could happen when the memory of
> the call gets reused?
>

Could you have a callback telling tracefs that it is going away (like
the module notifier does)?

-- Steve
