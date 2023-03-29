Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658FC6CD821
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjC2LEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjC2LE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:04:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E328346B3;
        Wed, 29 Mar 2023 04:04:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3D1AB822A2;
        Wed, 29 Mar 2023 11:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0C7C4339B;
        Wed, 29 Mar 2023 11:03:55 +0000 (UTC)
Date:   Wed, 29 Mar 2023 07:03:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20230329070353.1e1b443b@gandalf.local.home>
In-Reply-To: <ZCQCsD9+nNwBYIyH@google.com>
References: <20230322102244.3239740-1-vdonnefort@google.com>
        <20230322102244.3239740-2-vdonnefort@google.com>
        <20230328224411.0d69e272@gandalf.local.home>
        <ZCQCsD9+nNwBYIyH@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 10:19:44 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> > I've been playing with this a bit, and I'm thinking, do we need the
> > data_pages[] array on the meta page?
> > 
> > I noticed that I'm not even using it.
> > 
> > Currently, we need to do a ioctl every time we finish with the reader page,
> > and that updates the reader_page in the meta data to point to the next page
> > to read. When do we need to look at the data_start section?  
> 
> This is for non-consuming read, to get all the pages in order.

Yeah, I was trying to see how a non consuming read would work, and was
having issues figuring that out without the tail page being updated.

> 
> If we remove this section we would lose this ability ... but we'd also simplify
> the code by a good order of magnitude (don't need the update ioctl anymore, no
> need to keep those pages in order and everything can fit a 0-order meta-page).
> And the non-consuming read doesn't bring much to the user over the pipe version.
> 
> This will although impact our hypervisor tracing which will only be able to
> expose trace_pipe interfaces. But I don't think it is a problem, all userspace
> tools only relying on consuming read anyway.
> 
> So if you're happy dropping this support, let's get rid of it.

I don't really want to get rid of it, but perhaps break it up where we
don't have it in the first release, but add it in a second one. That will
also make sure that we can expand the API if necessary (one reason I wanted
the "data_start" in the first place).

Let's drop it for now, but be able to add it later, an have the current
structure be:

struct ring_buffer_meta_page_header {
#if __BITS_PER_LONG == 64
	__u64	entries;
	__u64	overrun;
#else
	__u32	entries;
	__u32	overrun;
#endif
	__u32	pages_touched;
	__u32	meta_page_size;
	__u32	reader_page;	/* page ID for the reader page */
	__u32	nr_data_pages;	/* doesn't take into account the reader_page */
};

BTW, shouldn't the nr_data_pages take into account the reader page? As it
is part of the array we traverse isn't it?

-- Steve
