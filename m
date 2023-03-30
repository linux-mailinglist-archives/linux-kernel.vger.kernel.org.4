Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EAB6D013C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjC3KbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjC3KbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:31:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D273EC4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:31:15 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so12802898wmq.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680172274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oCSLCronvrWqAes79LDile7lDfgU2BaSyNu7ahhmt4c=;
        b=jSvObG5da5v2p1XpYHcorjOkhqfpzf0kPpN7Q4trfd2n2tRMe9vBDpI9yGb4bmWMos
         yBfacMc0nGb5HOPLQ+zuYKzIz/3FRWe1OJMNlcTpRPrku3fPuuUAbvTHICCi2LZZGvAO
         HsIoyr1Of8fT3/1DJyk4QlkKDBM3568GA4MmhMj7fjWUnrDXENXVAxxZEw6g0l6iMU9F
         wjTG/T9+X+nnz6vZMwmxcE1k/0tQUu5Ev6MWZ7XZvkrktoGDE6Z/BfplFC2HfFL6WCQ2
         Bra9EHq5EdPMLW5Cnddu7Lye66LxX6daeBv7hm/YccvQShJR0Wtpq7sZDyZEw9vv0axX
         z4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680172274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCSLCronvrWqAes79LDile7lDfgU2BaSyNu7ahhmt4c=;
        b=75USJpHaYviO15X0b65HNNGY0nvKNITf5jsdqRs1BHR4x6d5o8n5UQ7oZnnIXc7wiz
         49IBSi6BuhDSzItI742sOg11qqojQfYLSIxKIjyRFdmCcqnLnQIoZSF2Irqjd3PZ7Qz1
         MgXAOLgdBb3IASXFNP/gSiXF/qnT2BOD1vWv9aaTI5IYIZ0hql47WG1KF25PwsZh+FC7
         5Nz8/PGbqdXYvbCjJ5//gK1rGR58hvPpQ+BZHYUusPJa1/xTfujPumpVXi2M1T2SYODb
         c1MYbDHUl+KelyeJ2WdvufJKMuKfdayWBwVtDlGEcX679N4MWQXtsRTsuV0Lj5Y6j4Mz
         pNoQ==
X-Gm-Message-State: AAQBX9fHK4y1EVLNVU2WsbCNx0mEYUnuiJJxC0seGehAYEqx+oG6r5/9
        vnqUJgzEIU8NIuAqRs8ZsRdQavZBSfF71t9Ub2jCXw==
X-Google-Smtp-Source: AKy350YanmM4k/wNl9S03NJjrNoF8Ay+Z30J/Bb1EaoBgQ3rpopW0XJh649xqhqiIoN3BmX2xWxt2A==
X-Received: by 2002:a1c:7215:0:b0:3ef:d8c6:4bc0 with SMTP id n21-20020a1c7215000000b003efd8c64bc0mr4336810wmc.40.1680172274120;
        Thu, 30 Mar 2023 03:31:14 -0700 (PDT)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id iv19-20020a05600c549300b003ef69873cf1sm5805650wmb.40.2023.03.30.03.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 03:31:13 -0700 (PDT)
Date:   Thu, 30 Mar 2023 11:30:51 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZCVk26InuXhy+Lmg@google.com>
References: <20230328224411.0d69e272@gandalf.local.home>
 <ZCQCsD9+nNwBYIyH@google.com>
 <20230329070353.1e1b443b@gandalf.local.home>
 <20230329085106.046a8991@rorschach.local.home>
 <ZCQ2jW5Jl/cWCG7s@google.com>
 <20230329091107.408d63a8@rorschach.local.home>
 <ZCQ9m5K34Qa9ZkUd@google.com>
 <20230329093602.2b3243f0@rorschach.local.home>
 <ZCRDXaTVfNwxdRJZ@google.com>
 <20230329113234.3285209c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329113234.3285209c@gandalf.local.home>
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 11:32:34AM -0400, Steven Rostedt wrote:
> On Wed, 29 Mar 2023 14:55:41 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > > Yes, in fact it shouldn't need to call the ioctl until after it read it.
> > > 
> > > Maybe, we should have the ioctl take a parameter of how much was read?
> > > To prevent races?  
> > 
> > Races would only be with other consuming readers. In that case we'd probably
> > have many other problems anyway as I suppose nothing would prevent another one
> > of swapping the page while our userspace reader is still processing it?
> 
> I'm not worried about user space readers. I'm worried about writers, as
> the ioctl will update the reader_page->read = reader_page->commit. The time
> that the reader last read and stopped and then called the ioctl, a writer
> could fill the page, then the ioctl may even swap the page. By passing in
> the read amount, the ioctl will know if it needs to keep the same page or
> not.

How about?

userspace:

  prev_read = meta->read;
  ioctl(TRACE_MMAP_IOCTL_GET_READER_PAGE)

kernel:
    ring_buffer_get_reader_page()
      rb_get_reader_page(cpu_buffer);
      cpu_buffer->reader_page->read = rb_page_size(reader);
      meta->read = cpu_buffer->reader_page->read;

userspace:
   /* if new page prev_read = 0 */
   /* read between prev_read and meta->read */

If the writer does anything in-between, wouldn't rb_get_reader_page() handle it
nicely by returning the same reader as more would be there to read?

It is similar to rb_advance_reader() except we'd be moving several events at
once?

> 
> > 
> > I don't know if this is worth splitting the ABI between the meta-page and the
> > ioctl parameters for this?
> > 
> > Or maybe we should say the meta-page contains things modified by the writer and
> > parameters modified by the reader are passed by the get_reader_page ioctl i.e.
> > the reader page ID and cpu_buffer->reader_page->read? (for the hyp tracing, we
> > have up to 4 registers for the HVC which would replace in our case the ioctl)
> 
> I don't think we need the reader_page id, as that should never move without
> reader involvement. If there's more than one reader, that's up to the
> readers to keep track of each other, not the kernel.
> 
> Which BTW, the more I look at doing this without ioctls, I think we may
> need to update things slightly different.
> 
> I would keep the current approach, but for clarification of terminology, we
> have:
> 
> meta_data - the data that holds information that is shared between user and
> 	kernel space.
> 
> data_pages - this is a separate mapping that holds the mapped ring buffer
> 	pages. In user space, this is one contiguous array and also holds
> 	the reader page.
> 
> data_index - This is an array of what the writer sees. It maps the index
> 	into data_pages[] of where to find the mapped pages. It does not
> 	contain the reader page. We currently map this with the meta_data,
> 	but that's not a requirement (although we may continue to do so).
> 
> I'm thinking that we make the data_index[] elements into a structure:
> 
> struct trace_map_data_index {
> 	int		idx;	/* index into data_pages[] */
> 	int		cnt;	/* counter updated by writer */
> };
> 
> The cnt is initialized to zero when initially mapped.
> 
> Instead of having the bpage->id = index into data_pages[], have it equal
> the index into data_index[].
> 
> The cpu_buffer->reader_page->id = -1;
> 
> meta_data->reader_page = index into data_pages[] of reader page
> 
> The swapping of the header page would look something like this:
> 
> static inline void
> rb_meta_page_head_swap(struct ring_buffer_per_cpu *cpu_buffer)
> {
> 	struct ring_buffer_meta_page *meta = cpu_buffer->meta_page;
> 	int head_page;
> 
> 	if (!READ_ONCE(cpu_buffer->mapped))
> 		return;
> 
> 	head_page = meta->data_pages[meta->hdr.data_page_head];
> 	meta->data_pages[meta->hdr.data_page_head] = meta->hdr.reader_page;
> 	meta->hdr.reader_page = head_page;
> 	meta->data_pages[head_page]->id = -1;
> }
> 
> As hdr.data_page_head would be an index into data_index[] and not
> data_pages[].
> 
> The fact that bpage->id points to the data_index[] and not the data_pages[]
> means that the writer can easily get to that index, and modify the count.
> That way, in rb_tail_page_update() (between cmpxchgs) we can do something
> like:
> 
> 	if (cpu_buffer->mapped) {
> 		meta = cpu_buffer->meta_page;
> 		meta->data_index[next_page->id].cnt++;
> 	}
> 
> And this will allow the reader to know if the current page it is on just
> got overwritten by the writer, by doing:
> 
> 	prev_id = meta->data_index[this_page].cnt;
> 	smp_rmb();
> 	read event (copy it, whatever)
> 	smp_rmb();
> 	if (prev_id != meta->data_index[this_page].cnt)
> 		/* read data may be corrupted, abort it */

Couldn't the reader just check for the page commit field? rb_iter_head_event()
does something like this to check if the writer is on its page.

> 
> 
> Does this make sense?
> 
> -- Steve
