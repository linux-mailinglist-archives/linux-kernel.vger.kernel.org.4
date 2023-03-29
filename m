Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6076CECF8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjC2PdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjC2PdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:33:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1614215;
        Wed, 29 Mar 2023 08:32:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 193CDB8236F;
        Wed, 29 Mar 2023 15:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CE3C433EF;
        Wed, 29 Mar 2023 15:32:36 +0000 (UTC)
Date:   Wed, 29 Mar 2023 11:32:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20230329113234.3285209c@gandalf.local.home>
In-Reply-To: <ZCRDXaTVfNwxdRJZ@google.com>
References: <20230322102244.3239740-1-vdonnefort@google.com>
        <20230322102244.3239740-2-vdonnefort@google.com>
        <20230328224411.0d69e272@gandalf.local.home>
        <ZCQCsD9+nNwBYIyH@google.com>
        <20230329070353.1e1b443b@gandalf.local.home>
        <20230329085106.046a8991@rorschach.local.home>
        <ZCQ2jW5Jl/cWCG7s@google.com>
        <20230329091107.408d63a8@rorschach.local.home>
        <ZCQ9m5K34Qa9ZkUd@google.com>
        <20230329093602.2b3243f0@rorschach.local.home>
        <ZCRDXaTVfNwxdRJZ@google.com>
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

On Wed, 29 Mar 2023 14:55:41 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> > Yes, in fact it shouldn't need to call the ioctl until after it read it.
> > 
> > Maybe, we should have the ioctl take a parameter of how much was read?
> > To prevent races?  
> 
> Races would only be with other consuming readers. In that case we'd probably
> have many other problems anyway as I suppose nothing would prevent another one
> of swapping the page while our userspace reader is still processing it?

I'm not worried about user space readers. I'm worried about writers, as
the ioctl will update the reader_page->read = reader_page->commit. The time
that the reader last read and stopped and then called the ioctl, a writer
could fill the page, then the ioctl may even swap the page. By passing in
the read amount, the ioctl will know if it needs to keep the same page or
not.

> 
> I don't know if this is worth splitting the ABI between the meta-page and the
> ioctl parameters for this?
> 
> Or maybe we should say the meta-page contains things modified by the writer and
> parameters modified by the reader are passed by the get_reader_page ioctl i.e.
> the reader page ID and cpu_buffer->reader_page->read? (for the hyp tracing, we
> have up to 4 registers for the HVC which would replace in our case the ioctl)

I don't think we need the reader_page id, as that should never move without
reader involvement. If there's more than one reader, that's up to the
readers to keep track of each other, not the kernel.

Which BTW, the more I look at doing this without ioctls, I think we may
need to update things slightly different.

I would keep the current approach, but for clarification of terminology, we
have:

meta_data - the data that holds information that is shared between user and
	kernel space.

data_pages - this is a separate mapping that holds the mapped ring buffer
	pages. In user space, this is one contiguous array and also holds
	the reader page.

data_index - This is an array of what the writer sees. It maps the index
	into data_pages[] of where to find the mapped pages. It does not
	contain the reader page. We currently map this with the meta_data,
	but that's not a requirement (although we may continue to do so).

I'm thinking that we make the data_index[] elements into a structure:

struct trace_map_data_index {
	int		idx;	/* index into data_pages[] */
	int		cnt;	/* counter updated by writer */
};

The cnt is initialized to zero when initially mapped.

Instead of having the bpage->id = index into data_pages[], have it equal
the index into data_index[].

The cpu_buffer->reader_page->id = -1;

meta_data->reader_page = index into data_pages[] of reader page

The swapping of the header page would look something like this:

static inline void
rb_meta_page_head_swap(struct ring_buffer_per_cpu *cpu_buffer)
{
	struct ring_buffer_meta_page *meta = cpu_buffer->meta_page;
	int head_page;

	if (!READ_ONCE(cpu_buffer->mapped))
		return;

	head_page = meta->data_pages[meta->hdr.data_page_head];
	meta->data_pages[meta->hdr.data_page_head] = meta->hdr.reader_page;
	meta->hdr.reader_page = head_page;
	meta->data_pages[head_page]->id = -1;
}

As hdr.data_page_head would be an index into data_index[] and not
data_pages[].

The fact that bpage->id points to the data_index[] and not the data_pages[]
means that the writer can easily get to that index, and modify the count.
That way, in rb_tail_page_update() (between cmpxchgs) we can do something
like:

	if (cpu_buffer->mapped) {
		meta = cpu_buffer->meta_page;
		meta->data_index[next_page->id].cnt++;
	}

And this will allow the reader to know if the current page it is on just
got overwritten by the writer, by doing:

	prev_id = meta->data_index[this_page].cnt;
	smp_rmb();
	read event (copy it, whatever)
	smp_rmb();
	if (prev_id != meta->data_index[this_page].cnt)
		/* read data may be corrupted, abort it */


Does this make sense?

-- Steve
