Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB2F674B47
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjATEue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjATEtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:49:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B434CE886;
        Thu, 19 Jan 2023 20:43:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E86F1B81A58;
        Fri, 20 Jan 2023 03:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38030C433D2;
        Fri, 20 Jan 2023 03:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674186484;
        bh=vF+13EJkM+VvfWqJtIzQTln5eOgraOwRw64dpc0BZ38=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tj+2gXJ3+H95TbD1lRYYmL+eDE5A8BTKid48k20z6UEJqF3N9s9zob7nK73mQRvP/
         elP4CO4NGMB45kgQ+N73Wu0scotHWMXavh8jFMq4OhvnygxDGH3JZ1YdPLMsCW/S1J
         EKV38wphwPA7Qy2MfR13eF/08bmnN5tOY0i7sBk5Q+MLbtt73oSTrXytQhl4ERcJG5
         XxOmXFasPHqLpah2CttYUyiWx9nAwe6oURkt6nBX7SY9SID9EN0HuthiakYYJ/DQGb
         yIZoQdPsKjnHMpGIKNlWY0EzIxmsU6o4rrgbonp/4Bq876udSxL7HXkiesM2B6dWcL
         FzwyAV+qScUDQ==
Date:   Fri, 20 Jan 2023 12:48:01 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH 1/9] fprobe: Pass entry_data to handlers
Message-Id: <20230120124801.558a5ce3b5513749997c7d99@kernel.org>
In-Reply-To: <20230117204309.1cd8f20f@gandalf.local.home>
References: <166792255429.919356.14116090269057513181.stgit@devnote3>
        <166792256330.919356.14776044963704066797.stgit@devnote3>
        <20230117204309.1cd8f20f@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2023 20:43:09 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed,  9 Nov 2022 00:49:23 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index e8143e368074..fa25d09c9d57 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -17,14 +17,16 @@
> >  struct fprobe_rethook_node {
> >  	struct rethook_node node;
> >  	unsigned long entry_ip;
> > +	char data[];
> >  };
> >  
> >  static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
> >  			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
> >  {
> >  	struct fprobe_rethook_node *fpr;
> > -	struct rethook_node *rh;
> > +	struct rethook_node *rh = NULL;
> >  	struct fprobe *fp;
> > +	void *entry_data = NULL;
> >  	int bit;
> >  
> >  	fp = container_of(ops, struct fprobe, ops);
> > @@ -37,9 +39,6 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
> >  		return;
> >  	}
> >  
> > -	if (fp->entry_handler)
> > -		fp->entry_handler(fp, ip, ftrace_get_regs(fregs));
> > -
> >  	if (fp->exit_handler) {
> >  		rh = rethook_try_get(fp->rethook);
> >  		if (!rh) {
> > @@ -48,9 +47,16 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
> >  		}
> >  		fpr = container_of(rh, struct fprobe_rethook_node, node);
> >  		fpr->entry_ip = ip;
> > -		rethook_hook(rh, ftrace_get_regs(fregs), true);
> > +		if (fp->entry_data_size)
> > +			entry_data = fpr->data;
> >  	}
> >  
> > +	if (fp->entry_handler)
> > +		fp->entry_handler(fp, ip, ftrace_get_regs(fregs), entry_data);
> > +
> > +	if (rh)
> > +		rethook_hook(rh, ftrace_get_regs(fregs), true);
> > +
> >  out:
> >  	ftrace_test_recursion_unlock(bit);
> >  }
> > @@ -81,7 +87,8 @@ static void fprobe_exit_handler(struct rethook_node *rh, void *data,
> >  
> >  	fpr = container_of(rh, struct fprobe_rethook_node, node);
> >  
> > -	fp->exit_handler(fp, fpr->entry_ip, regs);
> > +	fp->exit_handler(fp, fpr->entry_ip, regs,
> > +			 fp->entry_data_size ? (void *)fpr->data : NULL);
> >  }
> >  NOKPROBE_SYMBOL(fprobe_exit_handler);
> >  
> > @@ -146,7 +153,7 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
> >  	for (i = 0; i < size; i++) {
> >  		struct fprobe_rethook_node *node;
> >  
> > -		node = kzalloc(sizeof(*node), GFP_KERNEL);
> > +		node = kzalloc(sizeof(*node) + fp->entry_data_size, GFP_KERNEL);
> 
> 		node = kzalloc(struct_size(node, data, fp->entry_data_size), GFP_KERNEL);
> 
> Should use struct_size() for any tail structure allocations.

OK, I'll use that.

Thank you!

> 
> -- Steve
> 
> 
> >  		if (!node) {
> >  			rethook_free(fp->rethook);
> >  			fp->rethook = NULL;
> > diff --git a/lib/test_fprobe.c b/lib/test_fprobe.c
> > index e0381b3ec410..34fa5a5bbda1 100644


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
