Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FD7634E3C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 04:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbiKWDRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 22:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiKWDRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 22:17:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9630D8CBAC;
        Tue, 22 Nov 2022 19:17:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B894B81CB2;
        Wed, 23 Nov 2022 03:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137EAC433D7;
        Wed, 23 Nov 2022 03:17:12 +0000 (UTC)
Date:   Tue, 22 Nov 2022 22:17:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] ftrace: Avoid needless updates of the ftrace function
 call
Message-ID: <20221122221711.402b360f@rorschach.local.home>
In-Reply-To: <CAAYs2=jdy7zrRDyTidUW1tFbKDLycLOZjSDt0_Ra7CbB6O1L2Q@mail.gmail.com>
References: <20221122180905.737b6f52@gandalf.local.home>
        <CAAYs2=jdy7zrRDyTidUW1tFbKDLycLOZjSDt0_Ra7CbB6O1L2Q@mail.gmail.com>
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

On Wed, 23 Nov 2022 10:29:28 +0800
Song Shuai <suagrfillet@gmail.com> wrote:

> > @@ -2783,7 +2796,7 @@ void ftrace_modify_all_code(int command)
> >          * traced.
> >          */
> >         if (update) {
> > -               err = ftrace_update_ftrace_func(ftrace_ops_list_func);
> > +               err = update_ftrace_func(ftrace_ops_list_func);
> >                 if (FTRACE_WARN_ON(err))
> >                         return;
> >         }
> > @@ -2799,7 +2812,7 @@ void ftrace_modify_all_code(int command)
> >                 /* If irqs are disabled, we are in stop machine */
> >                 if (!irqs_disabled())
> >                         smp_call_function(ftrace_sync_ipi, NULL, 1);
> > -               err = ftrace_update_ftrace_func(ftrace_trace_function);
> > +               err = update_ftrace_func(ftrace_trace_function);  
> The helper function should only serve the ftrace_ops_list_func.
> 
> And ftrace_trace_function is always different in this function with
> FTRACE_UPDATE_TRACE_FUNC command.
> 
> So this place should be left as it is.

But it is needed to update the static variable. Without this change,
then save_func will get set to ftrace_ops_list_func and never change
after that and then the update to ftrace_ops_list_func will stop happening.

-- Steve
