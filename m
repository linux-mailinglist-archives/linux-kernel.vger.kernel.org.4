Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4328D749E46
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjGFN4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjGFN43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:56:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349B81996;
        Thu,  6 Jul 2023 06:56:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C27C961973;
        Thu,  6 Jul 2023 13:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC0AC433C8;
        Thu,  6 Jul 2023 13:56:26 +0000 (UTC)
Date:   Thu, 6 Jul 2023 09:56:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] fprobe: Ensure running fprobe_exit_handler() finished
 before calling rethook_free()
Message-ID: <20230706095624.3a846b8e@gandalf.local.home>
In-Reply-To: <20230706141012.c1a0ae0901e0fdec7b3078c7@kernel.org>
References: <20230628012305.978e34d44f1a53fe20327fde@kernel.org>
        <168796344232.46347.7947681068822514750.stgit@devnote2>
        <20230705212657.5968daf7@gandalf.local.home>
        <20230706141012.c1a0ae0901e0fdec7b3078c7@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2023 14:10:12 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> With only Jiri's patch, following flow can happen;
> 
> ------
>  CPU1                              CPU2
>  call unregister_fprobe()
>  ...
>                                    __fprobe_handler()
>                                    rethook_hook() on probed function
>  unregister_ftrace_function()
>                                    return from probed function
>                                    rethook hooks
>                                    find rh->handler == fprobe_exit_handler
>                                    call fprobe_exit_handler()
>  rethook_free():
>    set rh->handler = NULL;
>  return from unreigster_fprobe;
>                                    call fp->exit_handler() <- (*)
> 
> (*) In this point, the exit handler is called after returning from 
> unregister_fprobe().
> ------
> 
> So, this patch changes it as following;
> ------
>  CPU1                              CPU2
>  call unregister_fprobe()
>  ...
>  rethook_stop():
>    set rh->handler = NULL;
>                                    __fprobe_handler()
>                                    rethook_hook() on probed function
>  unregister_ftrace_function()
>                                    return from probed function
>                                    rethook hooks
>                                    find rh->handler == NULL
>                                    return from rethook
>  rethook_free()
>  return from unreigster_fprobe;
> ------
> 
> I can also just put a synchronize_sched_rcu() right after rethook_free()
> to wait for all running fprobe_exit_handler() too.
> 

This makes more sense. Can you please add the above to the change log.

Thanks,

-- Steve
