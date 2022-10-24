Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E1E60B0F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbiJXQMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiJXQHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:07:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD949A9D9;
        Mon, 24 Oct 2022 07:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD6A3B81132;
        Mon, 24 Oct 2022 14:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E9FC433D7;
        Mon, 24 Oct 2022 14:58:02 +0000 (UTC)
Date:   Mon, 24 Oct 2022 10:58:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] ring-buffer: Include dropped pages in counting dirty
 patches
Message-ID: <20221024105812.4ae304b0@gandalf.local.home>
In-Reply-To: <20221024221328.91994cb956fcb7effcbdb97d@kernel.org>
References: <20221021123013.55fb6055@gandalf.local.home>
        <20221024221328.91994cb956fcb7effcbdb97d@kernel.org>
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

On Mon, 24 Oct 2022 22:13:28 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > @@ -2020,6 +2029,7 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
> >  			 */
> >  			local_add(page_entries, &cpu_buffer->overrun);
> >  			local_sub(BUF_PAGE_SIZE, &cpu_buffer->entries_bytes);
> > +			local_inc(&cpu_buffer->pages_lost);  
> 
> Maybe we can make this part a static helper function so that we don't
> repeat it below?

Makes sense. I'll send a v2.

-- Steve

> 
> >  		}
> >  
> >  		/*
> > @@ -2504,6 +2514,7 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
> >  		 */
> >  		local_add(entries, &cpu_buffer->overrun);
> >  		local_sub(BUF_PAGE_SIZE, &cpu_buffer->entries_bytes);
> > +		local_inc(&cpu_buffer->pages_lost);  

