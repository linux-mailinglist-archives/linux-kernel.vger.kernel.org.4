Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6795FD2A7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 03:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJMBgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 21:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJMBgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 21:36:42 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 335BD192AC;
        Wed, 12 Oct 2022 18:36:41 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0A13E20F0F69;
        Wed, 12 Oct 2022 17:19:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0A13E20F0F69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1665620384;
        bh=TrWcVfc0FlEvL8iIF087mHrCnqLoN9nK4Ry9f1tyt7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qc6qmNNsisb4r+OSTBT6HR8/GOtSmX3Av1vJXQ6rSt9tQktoeZ4Si0bk/Ytaw0w+9
         wZ7OixLeOa2qGcGK/87dkD6slLD8eQweuxXXciCepgTlpiuc8e/PynyZWkcQogSu8/
         ywWlknSxmXnMYLnhBUhKWDrzV5TVOs2W2Xo5K+Ig=
Date:   Wed, 12 Oct 2022 17:19:38 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Track event ref in tracefs enable/disable
Message-ID: <20221013001938.GA281@W11-BEAU-MD.localdomain>
References: <20221012215717.10492-1-beaub@linux.microsoft.com>
 <20221012182639.5a607add@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012182639.5a607add@rorschach.local.home>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 06:26:39PM -0400, Steven Rostedt wrote:
> On Wed, 12 Oct 2022 14:57:17 -0700
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > When events are enabled via the "enable" file within tracefs there is no
> > get or put ref. Add these to ensure modules and dynamic events do not
> > unload while the event is enabled via tracefs.
> 
> Why is this an issue?

It depends on the scenario, it may or may not cause a issue.

> 
> The events are only called from the module code, and when the module is
> unloaded, they are no longer called. Why keep the module from unloading
> when enabled?

Won't the modules remove the event calls? At the very least the event
call structure in memory goes away during module unload. If it gets
reused odd things will happen, right? IE: trace_module_remove_events().

Maybe I have a bad assumption:
I thought the point of trace_event_try_get_ref()/put_ref() was to tell
the system the call cannot go away. However, if ftrace enable doesn't
use these the lifetime is ambigious in this case. If this was
intentional, how are event call lifetimes described if not within the
ref?

In my namespace patches I hit this case when user_events try to go away
during namespace teardown. Since there is no reference to the event
being used I removed the call. However, it was clearly being used within
tracefs at that point. When I cat "enable" in this case instead of "0"
or "1" I get "?". I suppose worse things could happen when the memory of
the call gets reused?

> 
> -- Steve

Thanks,
-Beau
