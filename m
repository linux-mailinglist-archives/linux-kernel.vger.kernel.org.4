Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687986CD98E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjC2Mrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjC2Mrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:47:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D5540D9;
        Wed, 29 Mar 2023 05:47:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C893061C83;
        Wed, 29 Mar 2023 12:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7056EC433D2;
        Wed, 29 Mar 2023 12:47:42 +0000 (UTC)
Date:   Wed, 29 Mar 2023 08:47:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20230329084735.6c4a9229@rorschach.local.home>
In-Reply-To: <ZCQtpbyWrjliJkdg@google.com>
References: <20230322102244.3239740-1-vdonnefort@google.com>
        <20230322102244.3239740-2-vdonnefort@google.com>
        <20230328224411.0d69e272@gandalf.local.home>
        <ZCQCsD9+nNwBYIyH@google.com>
        <20230329070353.1e1b443b@gandalf.local.home>
        <ZCQtpbyWrjliJkdg@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 13:23:01 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> On Wed, Mar 29, 2023 at 07:03:53AM -0400, Steven Rostedt wrote:
> > On Wed, 29 Mar 2023 10:19:44 +0100
> > Vincent Donnefort <vdonnefort@google.com> wrote:
> >   
> > > > I've been playing with this a bit, and I'm thinking, do we need the
> > > > data_pages[] array on the meta page?
> > > > 
> > > > I noticed that I'm not even using it.
> > > > 
> > > > Currently, we need to do a ioctl every time we finish with the reader page,
> > > > and that updates the reader_page in the meta data to point to the next page
> > > > to read. When do we need to look at the data_start section?    
> > > 
> > > This is for non-consuming read, to get all the pages in order.  
> > 
> > Yeah, I was trying to see how a non consuming read would work, and was
> > having issues figuring that out without the tail page being updated.  
> 
> Would the userspace really need to know where is the tail page? It can just stop
> whenever it finds out a page doesn't have any events, and make sure it does not
> loop once back to the head?

I'm trying to come up with a possible algorithm that doesn't need
ioctls. It would need to know if the writer moved or not. Probably need
a counter that gets incremented every time the writer goes to a new page.

Having the tail page was just a convenient way to know where the end is.

> 
> >   
> > > 
> > > If we remove this section we would lose this ability ... but we'd also simplify
> > > the code by a good order of magnitude (don't need the update ioctl anymore, no
> > > need to keep those pages in order and everything can fit a 0-order meta-page).
> > > And the non-consuming read doesn't bring much to the user over the pipe version.
> > > 
> > > This will although impact our hypervisor tracing which will only be able to
> > > expose trace_pipe interfaces. But I don't think it is a problem, all userspace
> > > tools only relying on consuming read anyway.
> > > 
> > > So if you're happy dropping this support, let's get rid of it.  
> > 
> > I don't really want to get rid of it, but perhaps break it up where we
> > don't have it in the first release, but add it in a second one. That will
> > also make sure that we can expand the API if necessary (one reason I wanted
> > the "data_start" in the first place).
> > 
> > Let's drop it for now, but be able to add it later, an have the current
> > structure be:  
> 
> Ok, I will prepare a V3 accordingly.
> 
> > 
> > struct ring_buffer_meta_page_header {
> > #if __BITS_PER_LONG == 64
> > 	__u64	entries;
> > 	__u64	overrun;
> > #else
> > 	__u32	entries;
> > 	__u32	overrun;
> > #endif
> > 	__u32	pages_touched;
> > 	__u32	meta_page_size;
> > 	__u32	reader_page;	/* page ID for the reader page */
> > 	__u32	nr_data_pages;	/* doesn't take into account the reader_page */
> > };
> > 
> > BTW, shouldn't the nr_data_pages take into account the reader page? As it
> > is part of the array we traverse isn't it?  
> 
> It depends if the reader page has ever been swapped out. If yes, the reader
> would have to start from reader_page and then switch to the data_pages.
> Which sounds like a fiddly interface for the userspace.
> 
> So yeah, consuming-read only feels like a better start.
> 

I agree. I'd like to get something in that can be extended, but simple
enough that it's not too much of a barrier wrt getting the API correct.

-- Steve
