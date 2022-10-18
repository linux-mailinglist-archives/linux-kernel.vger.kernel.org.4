Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C042602F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiJRPW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiJRPWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:22:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE9DBC634
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:22:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA762615A0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7B3C433C1;
        Tue, 18 Oct 2022 15:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666106568;
        bh=Yszl7aGpE4S6HYPQUKgoORqxXlr+xPYc8zuCsRSb5VE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ct+VK/S7ACOkbkY0sDTmXxQhCUtmeNHTHu+enUpasyGjXK3DIcEMZdNsgxdv/TsM1
         gh/TZ5lnUT6Eet7r0boCqKwJDutV3vUtgapaTxTHvdYH2rVKWN/PiP27hb92BLST1o
         mWK0DVECMKNXkimehdGxujiZyiPCunrtI26WnmTh4Ux4lymP6+67inSO3+uIfSTMQq
         W0erWLVR3T5Uvtb3L5QjBf7ZSFshhEN8zPLvBYhvDiua7fNCCDqRx5VsHVlYT4shym
         sRmKg2eullaJ1zgr4WeZZjvcucVgQQ2S/PHXiZCoaoVD0MPwIZgV+JsSYkuVbWoBLw
         SLjjJbf+IYZpQ==
Date:   Wed, 19 Oct 2022 00:22:43 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Song Chen <chensong_2000@189.cn>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, xiehuan09@gmail.com,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] trace/kprobe: remove duplicated call of
 ring_buffer_event_data
Message-Id: <20221019002243.8729040161290e17c6581e84@kernel.org>
In-Reply-To: <20221018095932.7b955e96@gandalf.local.home>
References: <1666077186-6042-1-git-send-email-chensong_2000@189.cn>
        <20221018095932.7b955e96@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 18 Oct 2022 09:59:32 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> [ Added Masami who's the new co-maintainer, and this is his code ]
> 
> On Tue, 18 Oct 2022 15:13:06 +0800
> Song Chen <chensong_2000@189.cn> wrote:
> 
> > Function __kprobe_trace_func calls ring_buffer_event_data to get
> > a ring buffer, however, it has been done in above call
> > trace_event_buffer_reserve.
> > 
> > So remove one of them.
> > 
> 
> May as well add:
> 
> Fixes: 5e6cd84e2f8bd ("tracing/kprobes: Do not open code event reserve logic")
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Oops, and we have another line in __kretprobe_trace_func() too.

Song, can you update this patch to fix the __kretprobe_trace_func() too?

Thank you,

> 
> -- Steve
> 
> 
> > Signed-off-by: Song Chen <chensong_2000@189.cn>
> > ---
> >  kernel/trace/trace_kprobe.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 23f7f0ec4f4c..dfd5809a4a65 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -1394,7 +1394,6 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
> >  		return;
> >  
> >  	fbuffer.regs = regs;
> > -	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
> >  	entry->ip = (unsigned long)tk->rp.kp.addr;
> >  	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
> >  
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
