Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BDB6A9CC4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjCCRIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjCCRIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:08:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E5EE06C;
        Fri,  3 Mar 2023 09:08:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86F8DB8191E;
        Fri,  3 Mar 2023 17:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E90EC433EF;
        Fri,  3 Mar 2023 17:07:57 +0000 (UTC)
Date:   Fri, 3 Mar 2023 12:07:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 2/3] ring_buffer: Change some static functions to
 bool
Message-ID: <20230303120754.0933c432@gandalf.local.home>
In-Reply-To: <c63f96bb-2972-b96e-5105-d47c89f8571e@quicinc.com>
References: <20230303151706.57851-1-ubizjak@gmail.com>
        <20230303151706.57851-3-ubizjak@gmail.com>
        <c63f96bb-2972-b96e-5105-d47c89f8571e@quicinc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Mar 2023 22:04:01 +0530
Mukesh Ojha <quic_mojha@quicinc.com> wrote:

> >   static __always_inline void
> > @@ -5408,9 +5407,8 @@ bool ring_buffer_empty(struct trace_buffer *buffer)
> >   {
> >   	struct ring_buffer_per_cpu *cpu_buffer;
> >   	unsigned long flags;
> > -	bool dolock;
> > +	bool dolock, ret;
> >   	int cpu;
> > -	int ret;  
> 
> nit: would have been nice if you would not have changed existing stuff 
> i.e each variable on a separate line.

I agree. I prefer each variable on a separate line, as it makes fixing
"unused variable" warnings easier.

-- Steve


> 
> >   
> >   	/* yes this is racy, but if you don't like the race, lock the buffer */
> >   	for_each_buffer_cpu(buffer, cpu) {
> > @@ -5438,8 +5436,7 @@ bool ring_buffer_empty_cpu(struct trace_buffer *buffer, int cpu)
> >   {
> >   	struct ring_buffer_per_cpu *cpu_buffer;
> >   	unsigned long flags;
> > -	bool dolock;
> > -	int ret;
> > +	bool dolock, ret;  
> 
> same here

