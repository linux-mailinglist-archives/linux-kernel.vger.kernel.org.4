Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7979D69C406
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 02:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjBTB4T convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Feb 2023 20:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBTB4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 20:56:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C039A25C;
        Sun, 19 Feb 2023 17:56:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB624B80AC6;
        Mon, 20 Feb 2023 01:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FA0C433D2;
        Mon, 20 Feb 2023 01:56:11 +0000 (UTC)
Date:   Sun, 19 Feb 2023 20:56:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, ionut_n2001@yahoo.com
Subject: Re: [PATCH] tracing: Check for NULL field_name in
 __synth_event_add_val()
Message-ID: <20230219205608.4664c310@rorschach.local.home>
In-Reply-To: <06c77bca76cd5679c8cd459480621b7db21f3a7b.camel@kernel.org>
References: <20230218105921.12ddb86f@gandalf.local.home>
        <06c77bca76cd5679c8cd459480621b7db21f3a7b.camel@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Feb 2023 15:46:24 -0600
Tom Zanussi <zanussi@kernel.org> wrote:


> No, because this code just above it makes sure you can't mix add_name
> with add_next.  Once add_name is set it will return -EINVAL if
> field_name is ever null after that, and add_name will never be changed
> once set:
> 
>        /* can't mix add_next_synth_val() with add_synth_val() */
>         if (field_name) {
>                 if (trace_state->add_next) {
>                         ret = -EINVAL;
>                         goto out;
>                 }
>                 trace_state->add_name = true;
>         } else {
>                 if (trace_state->add_name) {
>                         ret = -EINVAL;
>                         goto out;
>                 }
>                 trace_state->add_next = true;
>         }
> 
> 
> >  kernel/trace/trace_events_synth.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_events_synth.c
> > b/kernel/trace/trace_events_synth.c
> > index 70bddb25d9c0..fa28c1da06d2 100644
> > --- a/kernel/trace/trace_events_synth.c
> > +++ b/kernel/trace/trace_events_synth.c
> > @@ -1982,6 +1982,10 @@ static int __synth_event_add_val(const char
> > *field_name, u64 val,
> >  
> >         event = trace_state->event;
> >         if (trace_state->add_name) {
> > +               if (!field_name) {
> > +                       ret = -EINVAL;
> > +                       goto out;
> > +               }  
> 
> So if add_name is set here, it must also mean that field_name can't be
> null, because of the above.
> 
> >                 for (i = 0; i < event->n_fields; i++) {
> >                         field = event->fields[i];
> >                         if (strcmp(field->name, field_name) == 0)  
> 
> And if field_name can't be null, then I don't see how this strcmp could
> fail due to a null field_name.
> 
> So I don't see the need for this patch.  The bugzilla shows a compiler
> warning when using -Wnonnull - could this just be a spurious gcc
> warning?

Thanks, I should have caught that (I was even looking for that logic,
but still missed it). That's what I get for writing patches while jet-lagged :-p

-- Steve

