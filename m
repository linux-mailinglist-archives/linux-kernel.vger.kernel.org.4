Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDE362836C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbiKNPCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237087AbiKNPCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:02:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C9E1EAD7;
        Mon, 14 Nov 2022 07:02:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7C01B81038;
        Mon, 14 Nov 2022 15:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D907C433C1;
        Mon, 14 Nov 2022 15:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668438156;
        bh=7CAEYSQMfjcDUPQC16wFpV9kd4a6q+ilf+y2gMaEQDc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bt2nmWiimKzSqf9W+Tt6BWa8hKEt0IDkvXjO493SDSPt5E5s7Avdqfc7daAU7CE93
         bseK3u6+OdTrPzr9XuuUYwMGlT2wrwtmku7b/BWEbZMwdSrbXyIOeuPZRRmDOT81A9
         Zw1bjauOGz5ba7poUVGdv7RsDagIKQ94MKuxUpbijQnHYVImSMD/8FKQn4SmBS7kWV
         WX3T+BvBlu9rK1FY9zYx9/eLSXquc8Sp53V+Kjy/HIaWND9z7t1WvkKWWY4cKpIums
         KstexYEro5AlBSaJEepww7EqOVHIFqncUCM0mi56V6lvCVw+yPLEsynBhJ8X3QCb81
         BECIfb54ThBVA==
Date:   Tue, 15 Nov 2022 00:02:33 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [PATCH] tracing/eprobe: Fix eprobe filter to make a filter
 correctly
Message-Id: <20221115000233.cbf65c1bd38bfbe060002acf@kernel.org>
In-Reply-To: <Y3JPoPYSL5CadDUR@macondo>
References: <166823166395.1385292.8931770640212414483.stgit@devnote3>
        <Y3JPoPYSL5CadDUR@macondo>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022 11:24:32 -0300
Rafael Mendonca <rafaelmendsr@gmail.com> wrote:

> On Sat, Nov 12, 2022 at 02:41:04PM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since the eprobe filter was defined based on the eprobe's trace event
> > itself, it doesn't work correctly. Use the original trace event of
> > the eprobe when making the filter so that the filter works correctly.
> > 
> > Without this fix:
> > 
> >  # echo 'e syscalls/sys_enter_openat \
> > 	flags_rename=$flags:u32 if flags < 1000' >> dynamic_events
> >  # echo 1 > events/eprobes/sys_enter_openat/enable
> > [  114.551550] event trace: Could not enable event sys_enter_openat
> > -bash: echo: write error: Invalid argument
> > 
> > With this fix:
> >  # echo 'e syscalls/sys_enter_openat \
> > 	flags_rename=$flags:u32 if flags < 1000' >> dynamic_events
> >  # echo 1 > events/eprobes/sys_enter_openat/enable
> >  # tail trace
> > cat-241     [000] ...1.   266.498449: sys_enter_openat: (syscalls.sys_enter_openat) flags_rename=0
> > cat-242     [000] ...1.   266.977640: sys_enter_openat: (syscalls.sys_enter_openat) flags_rename=0
> > 
> > Fixes: 752be5c5c910 ("tracing/eprobe: Add eprobe filter support")
> > Reported-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_eprobe.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Hi Masami,
> 
> Tested this on top of v6.1-rc5 and the event filtering seems to be
> working fine now. Tested with multiple events and conditions. Thanks.
> 
> Tested-by: Rafael Mendonca <rafaelmendsr@gmail.com>

Thanks a lot!

> 
> > 
> > diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> > index fe4833a7b7b3..1c3096ab2fe7 100644
> > --- a/kernel/trace/trace_eprobe.c
> > +++ b/kernel/trace/trace_eprobe.c
> > @@ -643,7 +643,7 @@ new_eprobe_trigger(struct trace_eprobe *ep, struct trace_event_file *file)
> >  	INIT_LIST_HEAD(&trigger->list);
> >  
> >  	if (ep->filter_str) {
> > -		ret = create_event_filter(file->tr, file->event_call,
> > +		ret = create_event_filter(file->tr, ep->event,
> >  					ep->filter_str, false, &filter);
> >  		if (ret)
> >  			goto error;
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
