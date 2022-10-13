Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8155FDE5C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 18:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJMQjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 12:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiJMQjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 12:39:41 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D70781F2;
        Thu, 13 Oct 2022 09:39:35 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id 30E5320F3D02;
        Thu, 13 Oct 2022 09:39:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 30E5320F3D02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1665679175;
        bh=G/uNRMLSN6vYIqvoohGz3jalPyKYsyfvCErVNkCJVsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WlCfKrckuJBL3dAWBtaYwBVKEE1OBwncV+CxjHeoN/d5vuOhkHzT13toW7/gxLURL
         35bsrZn3Yzet8GzpHLfmU6080pLC5kiosYLGFgA4DeJ1v0NxdntNg7Ht8GPSI5suJz
         m6z2ZyIRMoH2OmYbEjSGUPvwR3oVrxQY9xhQNhpc=
Date:   Thu, 13 Oct 2022 09:39:28 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Track event ref in tracefs enable/disable
Message-ID: <20221013163928.GA80@W11-BEAU-MD.localdomain>
References: <20221012215717.10492-1-beaub@linux.microsoft.com>
 <20221012182639.5a607add@rorschach.local.home>
 <20221013001938.GA281@W11-BEAU-MD.localdomain>
 <20221013035827.43f7f25c@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013035827.43f7f25c@rorschach.local.home>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 03:58:27AM -0400, Steven Rostedt wrote:
> On Wed, 12 Oct 2022 17:19:38 -0700
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > > 
> > > The events are only called from the module code, and when the module is
> > > unloaded, they are no longer called. Why keep the module from unloading
> > > when enabled?  
> > 
> > Won't the modules remove the event calls? At the very least the event
> > call structure in memory goes away during module unload. If it gets
> > reused odd things will happen, right? IE: trace_module_remove_events().
> 
> Yes it gets removed along with the module. But everything about the
> static event is part of the module.
> 

I see, trace_module_remove_events() does remove the trace call for
module cases only.

> > 
> > Maybe I have a bad assumption:
> > I thought the point of trace_event_try_get_ref()/put_ref() was to tell
> > the system the call cannot go away. However, if ftrace enable doesn't
> > use these the lifetime is ambigious in this case. If this was
> > intentional, how are event call lifetimes described if not within the
> > ref?
> > 
> 
> The purpose of trace_event_try_get_ref and friends is for the case of
> dynamic events (eprobes and synthetic events) that can attach to any
> event (including module events), and the module removal does not remove
> the dynamic portion that was attached to them. And in this case, the
> removal would have dire results.
> 

Got it, uprobes and user_events are also dynamic events. Here are things
I found and am thinking about and questioning:

Uprobe specifically calls trace_event_dyn_busy() during
unregister_trace_uprobe(). This will return false in this case, since
there is no reference. Fortunately trace_uprobe_is_busy() used by
dyn_events checks the event flags to see if something really hooked
there.

User_events also tracks usage via the event.class.reg() REG/UNREG
callback. It's dyn_events is_busy() op also checks internal flags.

So normally these are not issues for either above system.

However, once we have a tracing_namespace with put/get ref semantics for
lifetime, those corner case checks won't keep us from removing the
calls.

It appears if perf attaches to any event it will take a reference. This
would imply the module won't be allowed to go away while perf is
running. I'm not sure why we wouldn't want consistency, perhaps it might
break some scenarios I'm unaware of around module unload.

> > In my namespace patches I hit this case when user_events try to go away
> > during namespace teardown. Since there is no reference to the event
> > being used I removed the call. However, it was clearly being used within
> > tracefs at that point. When I cat "enable" in this case instead of "0"
> > or "1" I get "?". I suppose worse things could happen when the memory of
> > the call gets reused?
> >
> 
> Could you have a callback telling tracefs that it is going away (like
> the module notifier does)?
> 

I could, would it be limited to just tracefs? I don't believe perf or
eBPF currently hooks into those notifiers?

If we had a consistent get/put ref model I don't think we would need
the notifiers (unless we cannot trust all legacy code doing a get/put
ref). It appears in my testing that perf is always doing get/put refs
in these cases to ensure the call cannot go away underneath it.

Thanks,
-Beau
