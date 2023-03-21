Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F666C3767
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjCUQwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjCUQwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:52:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C790828852;
        Tue, 21 Mar 2023 09:52:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68A2FB818D8;
        Tue, 21 Mar 2023 16:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71888C433D2;
        Tue, 21 Mar 2023 16:52:01 +0000 (UTC)
Date:   Tue, 21 Mar 2023 12:51:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20230321125159.5ddc2da7@gandalf.local.home>
In-Reply-To: <ZBnZWhcelEpKXHo8@google.com>
References: <20230317143310.1604700-1-vdonnefort@google.com>
        <20230317143310.1604700-2-vdonnefort@google.com>
        <20230320214516.01c18367@gandalf.local.home>
        <ZBnKe55cvTZybZLF@google.com>
        <20230321114047.3432afbe@gandalf.local.home>
        <ZBnZWhcelEpKXHo8@google.com>
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

On Tue, 21 Mar 2023 16:20:42 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> > > Do we want a specific field here? That could be deduced from nr_data_pages()
> > > quite easily?  
> > 
> > I rather not have too much implementation detail knowledge in user space.
> > It only removes a single entry, and it makes user space easier. In fact,  
> 
> Ack.
> 
> > I'm thinking we should not include "__u32 data_pages[]" but instead add a:
> > "__u32 data_start" where user space does:
> > 
> > 	__u32 *data_pages = (_u32 *)meta_page + meta_page->data_start;
> > 
> > That way we could extend the data provided by the meta_page in the future.  
> 
> That'd be nice. Couldn't we keep both to simplify the code for the kernel side?

I would not expose the data_pages[] to user space, because then they'll use
it, and that *will* become an API.

But we could expose it to the kernel side with;

include/uapi/linux/trace_mmap.h:

struct ring_buffer_meta_page {
#if __BITS_PER_LONG == 64
	__u64	entries;
	__u64	overrun;
#else
	__u32	entries;
	__u32	overrun;
#endif
	__u32	pages_touched;
	__u32	reader_page;
	__u32	nr_data_pages;	/* doesn't take into account the reader_page */
	__u32	data_page_head;	/* index of data_pages[] */
	__u32	meta_page_size;	/* size of the meta page */
	__u32	data_start;	/* offset to where data_pages are */
};

kernel/trace/ring_buffer.c:

struct ring_buffer_meta {
	struct ring_buffer_meta_page	meta;
	u32				data_pages[];
}

Then we can start each function with:

	struct ring_buffer_meta_page *meta = &cpu_buffer->meta_page.meta;
	u32 *data_pages = cpu_buffer->meta_page.data_pages;

-- Steve
