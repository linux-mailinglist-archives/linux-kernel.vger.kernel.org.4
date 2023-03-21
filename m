Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073D36C35F6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjCUPlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjCUPlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:41:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164FC19118;
        Tue, 21 Mar 2023 08:40:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8DABB818A9;
        Tue, 21 Mar 2023 15:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3DEC433EF;
        Tue, 21 Mar 2023 15:40:49 +0000 (UTC)
Date:   Tue, 21 Mar 2023 11:40:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20230321114047.3432afbe@gandalf.local.home>
In-Reply-To: <ZBnKe55cvTZybZLF@google.com>
References: <20230317143310.1604700-1-vdonnefort@google.com>
        <20230317143310.1604700-2-vdonnefort@google.com>
        <20230320214516.01c18367@gandalf.local.home>
        <ZBnKe55cvTZybZLF@google.com>
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

On Tue, 21 Mar 2023 15:17:15 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> On Mon, Mar 20, 2023 at 09:45:16PM -0400, Steven Rostedt wrote:
> > On Fri, 17 Mar 2023 14:33:09 +0000
> > Vincent Donnefort <vdonnefort@google.com> wrote:
> >   
> > > Also, the meta-page being... a single page, this limits at the moment the
> > > number of pages in the ring-buffer that can be mapped: ~3MB on a 4K pages
> > > system.  
> > 
> > I hate this limitation, so I fixed it ;-)  
> 
> Thanks a lot for having a look. Do you mind if I fold this in my patch for a V2?

Hold off, I found some bugs that I'm fixing ;-)

> 
> > 
> > I added a meta_page_size field to the meta page, and user space can do:
> > 
> > 	meta = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
> > 	if (meta == MAP_FAILED)
> > 		pdie("mmap");
> > 
> > 	map = meta;
> > 	meta_len = map->meta_page_size;
> > 
> > 	if (meta_len > page_size) {
> > 		munmap(meta, page_size);
> > 		meta = mmap(NULL, meta_len, PROT_READ, MAP_SHARED, fd, 0);
> > 		if (meta == MAP_FAILED)
> > 			pdie("mmap");
> > 		map = meta;
> > 	}
> > 
> > This appears to work (but I'm still testing it).
> > 
> > -- Steve
> > 
> > diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
> > index 24bcec754a35..12f3f7ee33d9 100644
> > --- a/include/uapi/linux/trace_mmap.h
> > +++ b/include/uapi/linux/trace_mmap.h
> > @@ -18,6 +18,7 @@ struct ring_buffer_meta_page {
> >  	__u32	reader_page;
> >  	__u32	nr_data_pages;	/* doesn't take into account the reader_page */
> >  	__u32	data_page_head;	/* index of data_pages[] */
> > +	__u32	meta_page_size;	/* size of the meta page */  
> 
> Do we want a specific field here? That could be deduced from nr_data_pages()
> quite easily?

I rather not have too much implementation detail knowledge in user space.
It only removes a single entry, and it makes user space easier. In fact,
I'm thinking we should not include "__u32 data_pages[]" but instead add a:
"__u32 data_start" where user space does:

	__u32 *data_pages = (_u32 *)meta_page + meta_page->data_start;

That way we could extend the data provided by the meta_page in the future.

-- Steve


> 
> 
> >  	__u32	data_pages[];
> >  };
> >  
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 10a17e78cfe6..77c92e4a7adc 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -526,6 +526,7 @@ struct ring_buffer_per_cpu {
> >  	u64				read_stamp;
> >  
> >  	int				mapped;
> > +	int				meta_order;
> >  	struct mutex			mapping_lock;
> >  	unsigned long			*page_ids;	/* ID to addr */
> >  	struct ring_buffer_meta_page	*meta_page;
> > @@ -5898,7 +5899,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
> >  EXPORT_SYMBOL_GPL(ring_buffer_read_page);
> >  
> >  #define META_PAGE_MAX_PAGES \
> > -	((PAGE_SIZE - (offsetof(struct ring_buffer_meta_page, data_page_head))) >> 2)
> > +	((PAGE_SIZE - (offsetof(struct ring_buffer_meta_page, data_pages))) >> 2)
> >  
> 
> [...]

