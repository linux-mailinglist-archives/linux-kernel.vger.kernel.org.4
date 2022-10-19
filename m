Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1966049FB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiJSOz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiJSOzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:55:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49B71162E3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:46:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35EE7B824AE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16657C433C1;
        Wed, 19 Oct 2022 14:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666190780;
        bh=mgw3IMG2PKgQm9jhWu4QYVXFg+kED/rKgn3k+p088JU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O2tsg6Zy2HNcxH2PsIi60rgJQweL4LPM4yAbCrJYHAXQXggcIiQtLaZSpc9eXsWNu
         f7vN7GmRlEk9jDjfnHEB92dKey116XfzQiK3DR36taq/9GdVEPulLrJnyw8OcQh5cW
         kzCY/yDGTBNBGGkt1fRH3CFs94m6gwsk9DMYJ3+JZHnFswx5nY7zGylB9VQ7mDTxPw
         wZwsPbInSz5vavOD3iEA95xXcTPcD5DbFdG2x/OEkK8Y255bfHlLDVFm9BJ8pSlbK2
         +SAj3Tmb2JeZILYUM8iawk4a8gvuqss1e0jxrh1loSqkia0W3DTZ98XnjJluq5MeGD
         sSuz3IAtQjmiA==
Date:   Wed, 19 Oct 2022 23:46:15 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Song Chen <chensong_2000@189.cn>, mingo@redhat.com,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        xiehuan09@gmail.com
Subject: Re: [PATCH v2] trace/kprobe: remove duplicated calls of
 ring_buffer_event_data
Message-Id: <20221019234615.061b981d888b374220e39324@kernel.org>
In-Reply-To: <20221019093022.7ef5a0de@gandalf.local.home>
References: <1666145478-4706-1-git-send-email-chensong_2000@189.cn>
        <20221019093022.7ef5a0de@gandalf.local.home>
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

On Wed, 19 Oct 2022 09:30:22 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 19 Oct 2022 10:11:18 +0800
> Song Chen <chensong_2000@189.cn> wrote:
> 
> > Function __kprobe_trace_func calls ring_buffer_event_data to
> > get a ring buffer, however, it has been done in above call
> > trace_event_buffer_reserve. So does __kretprobe_trace_func.
> > 
> > This patch removes those duplicated calls.
> > 
> > Signed-off-by: Song Chen <chensong_2000@189.cn>
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Masami, want to take this one?

yes, this looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> -- Steve
> 
> > ---
> >  kernel/trace/trace_kprobe.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 23f7f0ec4f4c..f905829b856b 100644
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
> > @@ -1435,7 +1434,6 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
> >  		return;
> >  
> >  	fbuffer.regs = regs;
> > -	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
> >  	entry->func = (unsigned long)tk->rp.kp.addr;
> >  	entry->ret_ip = get_kretprobe_retaddr(ri);
> >  	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
