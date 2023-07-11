Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22E574E273
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 02:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjGKAHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 20:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjGKAG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 20:06:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4D71A8;
        Mon, 10 Jul 2023 17:06:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A57861142;
        Tue, 11 Jul 2023 00:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B435C433C8;
        Tue, 11 Jul 2023 00:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689034016;
        bh=r4CbhmkA5p+OqAZH09gczAtKwUy8UePSx9Y8E15JJgg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Sdwbi3ajG2ExQ5ypvuuw8Knk5tR19bzT9az/TlKEbi1k3GdUVlClBm/rUcTUbSfpa
         NXtM1nxD8fWSaw1UT9lE3N2DqbgotlTVqwNgoWN7SHfFCuUfqEQe0gE4YuZEtrxyqe
         RHCxSxcQPiA/i54ttLNSwIFWpIbAIKCExLlCwZgT9ZYq3nmTqeMgQeJqxDYO/9lj0v
         8SK4T3LOYwhpti5o1M5EFlks5twFV2JBHOFKj67Mjcw0fbSnQrRtrpRIRbWTvkkMt9
         JKbctBKky5OOFwMGVW1+n8jVAuxuK4ghVVi857SUfrdUKezqYPyKmntUVXD5emLKby
         mTuz/IBWvG9nw==
Date:   Tue, 11 Jul 2023 09:06:53 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] fprobe: Ensure running fprobe_exit_handler()
 finished before calling rethook_free()
Message-Id: <20230711090653.35e4cf97b2a9fcdd6e1b6884@kernel.org>
In-Reply-To: <20230710180422.572d7c21@gandalf.local.home>
References: <168873859949.156157.13039240432299335849.stgit@devnote2>
        <20230710180422.572d7c21@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 18:04:22 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri,  7 Jul 2023 23:03:19 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Ensure running fprobe_exit_handler() has finished before
> > calling rethook_free() in the unregister_fprobe() so that caller can free
> > the fprobe right after unregister_fprobe().
> > 
> > unregister_fprobe() ensured that all running fprobe_entry/exit_handler()
> > have finished by calling unregister_ftrace_function() which synchronizes
> > RCU. But commit 5f81018753df ("fprobe: Release rethook after the ftrace_ops
> > is unregistered") changed to call rethook_free() after
> > unregister_ftrace_function(). So call rethook_stop() to make rethook
> > disabled before unregister_ftrace_function() and ensure it again.
> > 
> > Here is the possible code flow that can call the exit handler after
> > unregister_fprobe().
> > 
> > ------
> >  CPU1                              CPU2
> >  call unregister_fprobe(fp)
> >  ...
> >                                    __fprobe_handler()
> >                                    rethook_hook() on probed function
> >  unregister_ftrace_function()
> >                                    return from probed function
> >                                    rethook hooks
> >                                    find rh->handler == fprobe_exit_handler
> >                                    call fprobe_exit_handler()
> >  rethook_free():
> >    set rh->handler = NULL;
> >  return from unreigster_fprobe;
> >                                    call fp->exit_handler() <- (*)
> > ------
> > 
> > (*) At this point, the exit handler is called after returning from
> > unregister_fprobe().
> > 
> > This fixes it as following;
> > ------
> >  CPU1                              CPU2
> >  call unregister_fprobe()
> >  ...
> >  rethook_stop():
> >    set rh->handler = NULL;
> >                                    __fprobe_handler()
> >                                    rethook_hook() on probed function
> >  unregister_ftrace_function()
> >                                    return from probed function
> >                                    rethook hooks
> >                                    find rh->handler == NULL
> >                                    return from rethook
> >  rethook_free()
> >  return from unreigster_fprobe;
> > ------
> > 
> > 
> > Fixes: 5f81018753df ("fprobe: Release rethook after the ftrace_ops is unregistered")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Looks good.
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thank you :)

> 
> 
> > ---
> >  Changes in v2:
> >  - Update changelog to add a problematic code flow.
> 
> Nit, for making forensic analysis easier in the future, I now always add a
> link to the previous version. That is:
> 
> Changes since v1: https://lore.kernel.org/linux-trace-kernel/168796344232.46347.7947681068822514750.stgit@devnote2/
> - Update changelog to add a problematic code flow.

OK, I'll add it for an isolated patch too.

Thanks!

> 
> -- Steve
> 
> 
> > ---
> >  include/linux/rethook.h |    1 +
> >  kernel/trace/fprobe.c   |    3 +++
> >  kernel/trace/rethook.c  |   13 +++++++++++++
> >  3 files changed, 17 insertions(+)
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
