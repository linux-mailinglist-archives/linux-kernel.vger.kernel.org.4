Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8BD5F331B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 18:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJCQMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 12:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiJCQMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 12:12:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B97431ED4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 09:12:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40DF0B80F01
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 16:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD044C433D6;
        Mon,  3 Oct 2022 16:12:27 +0000 (UTC)
Date:   Mon, 3 Oct 2022 12:12:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     akpm@linux-foundation.org
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        Zhou jie <zhoujie@nfschina.com>, vbabka@suse.cz,
        mhiramat@kernel.org, edumazet@google.com, rdunlap@infradead.org,
        christophe.leroy@csgroup.eu, rppt@kernel.org,
        mark-pk.tsai@mediatek.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init:Remove unnecessary (void*) conversions
Message-ID: <20221003121228.66a0e7ec@gandalf.local.home>
In-Reply-To: <20220930131142.xbrkwxop6vixnvht@halaneylaptop>
References: <20220928014539.11046-1-zhoujie@nfschina.com>
        <20220930131142.xbrkwxop6vixnvht@halaneylaptop>
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

On Fri, 30 Sep 2022 08:11:42 -0500
Andrew Halaney <ahalaney@redhat.com> wrote:

> Hi,
> 
> nit: $subject should have a space after init:, i.e "init: Remove".
> 
> On Wed, Sep 28, 2022 at 09:45:39AM +0800, Zhou jie wrote:
> > The void pointer object can be directly assigned to different structure
> > objects, it does not need to be cast.
> > 
> > Signed-off-by: Zhou jie <zhoujie@nfschina.com>  
> 
> With the subject fixed up you can add:
> 
>     Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

Looks fine to me too.

Andrew Morton, care to take this?

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> 
> > ---
> >  init/main.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/init/main.c b/init/main.c
> > index 98182c3c2c4b..5494caa24738 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -1239,7 +1239,7 @@ __setup("initcall_blacklist=", initcall_blacklist);
> >  static __init_or_module void
> >  trace_initcall_start_cb(void *data, initcall_t fn)
> >  {
> > -	ktime_t *calltime = (ktime_t *)data;
> > +	ktime_t *calltime = data;
> >  
> >  	printk(KERN_DEBUG "calling  %pS @ %i\n", fn, task_pid_nr(current));
> >  	*calltime = ktime_get();
> > @@ -1248,7 +1248,7 @@ trace_initcall_start_cb(void *data, initcall_t fn)
> >  static __init_or_module void
> >  trace_initcall_finish_cb(void *data, initcall_t fn, int ret)
> >  {
> > -	ktime_t rettime, *calltime = (ktime_t *)data;
> > +	ktime_t rettime, *calltime = data;
> >  
> >  	rettime = ktime_get();
> >  	printk(KERN_DEBUG "initcall %pS returned %d after %lld usecs\n",
> > -- 
> > 2.18.2
> >   

