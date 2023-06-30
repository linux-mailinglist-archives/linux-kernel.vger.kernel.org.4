Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5463B7435D1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 09:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjF3Hdq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Jun 2023 03:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjF3Hdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:33:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5579711F;
        Fri, 30 Jun 2023 00:33:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4DDC616E9;
        Fri, 30 Jun 2023 07:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CB1C433CC;
        Fri, 30 Jun 2023 07:33:34 +0000 (UTC)
Date:   Fri, 30 Jun 2023 03:33:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Cc:     mhiramat@kernel.org, dan.carpenter@linaro.org,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/trace: Fix cleanup logic of enable_trace_eprobe
Message-ID: <20230630033330.20a503fa@rorschach.local.home>
In-Reply-To: <CAPpZLN6dCMzHyUhjSN3+9Um+-mS2TJiDPObUeO8NxyqpQS3k=g@mail.gmail.com>
References: <20230628121811.338655-1-tz.stoyanov@gmail.com>
        <20230628084428.7bb32d65@rorschach.local.home>
        <CAPpZLN6dCMzHyUhjSN3+9Um+-mS2TJiDPObUeO8NxyqpQS3k=g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 17:31:24 +0300
Tzvetomir Stoyanov <tz.stoyanov@gmail.com> wrote:

> On Wed, Jun 28, 2023 at 3:44 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Wed, 28 Jun 2023 15:18:11 +0300
> > "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com> wrote:
>> > > --- a/kernel/trace/trace_eprobe.c
> > > +++ b/kernel/trace/trace_eprobe.c
> > > @@ -702,8 +702,12 @@ static int enable_trace_eprobe(struct trace_event_call *call,
> > >
> > >       if (ret) {
> > >               /* Failed to enable one of them. Roll back all */
> > > -             if (enabled)
> > > -                     disable_eprobe(ep, file->tr);
> > > +             if (enabled) {  
> >
> > If one was enabled and the second one failed, that should only happen
> > if there's a bug in the kernel (unless the failure was due to a memory
> > problem).
> >
> > I wonder if we should add:
> >
> >                         int cnt = 0;
> >  
> > > +                     list_for_each_entry(pos, trace_probe_probe_list(tp), list) {  
> >
> >                                 /*
> >                                  * It's a bug if one failed for something other than memory
> >                                  * not being available but another eprobe succeeded.
> >                                  */
> >                                 WARN_ON_ONCE(cnt++ && ret != -ENOMEM);  
> 
> That makes sense, I can send v2 with it. What is the idea of this cnt
> counter, why not just:
>                                  WARN_ON_ONCE(ret != -ENOMEM);
> outside of the loop? If enabled is true and ret is not ENOMEM, the bug
> is already there.

Failing for something other than ENOMEM should not cause a warning by
itself. The idea is, if one fails for something other than ENOMEM, they
all should fail with the same error. That is, they all should succeed
or they all should fail.

Actually, the above isn't right. The counter should be in the original
loop, and if one or more succeeds to enable, but another fails due to
some other error, that needs to be looked at, hence the warning.

Does that make sense?

-- Steve

> >
> >  
> > > +                             ep = container_of(pos, struct trace_eprobe, tp);
> > > +                             disable_eprobe(ep, file->tr);
> > > +                     }
> > > +             }
> > >               if (file)
> > >                       trace_probe_remove_file(tp, file);
> > >               else  
> >  
> 
> 

