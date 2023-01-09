Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6107661F0E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjAIHPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbjAIHPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:15:07 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DB71006B
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 23:15:05 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id bs20so7190587wrb.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 23:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=djYroUcP7LJj8Vfu0pfc16kXU2pouT3NI2vQqAjt8UI=;
        b=DpQGjS7qf86KkinejfalItV4JhAijE15LdUeORGx3G0QoIyi6QF2V9zEpbYoKBZlER
         oEDcENQGrZV1AQ/8EyWz3oL9oWfZu/ytzJ9oRb2zNnJI52QTqu7Q1Q22x+wSBfvTdTEl
         pW906imxH22HP8HVImsKWQhuq9XXl3u3+RHZJl3fzEX13/nr/Scw2OAdyJQg0FLLoLFN
         mEeTSGer75fQ58gc5EOFkjL/2Q1vd/B2F3fsjtKXSN6UCbZgznSJlbgUe79HwL+GncP0
         3IXOYvYaZS2GYPA4ohNQYFTT1iDOUAefOhbFP7eGuQ6qTWC4yqnlVNnSXN9irzS2kol8
         YOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djYroUcP7LJj8Vfu0pfc16kXU2pouT3NI2vQqAjt8UI=;
        b=dcJr5jx19MAjm65idL0hzMrDam6LMBwu5xrXyo8Huucw3KdksaqxJVoWxQTuzv9wFr
         iwn+BzkzRaPL0xdN+rv7n58Rs9IjBempbvVK49crpOt63j62Zckiy2oXJBKR3JV5KfbO
         Tv1YLHugE/yQWGJVSQSfIcWtggRrjlBAxTZunJwVNW2bkUjUGCoD14AzBVSmtcZKQ6Zf
         vpCaT84AuaqQIiNubq0T7AAH57A5WtSrsJka+9uID9xqb/3QPpA7H25c4q97F/t9NsNi
         rBM8KyO7tCSLOeuVOWvbR6/lB3drNAVVQHCJ3+1INJIued5C8zbnQnhaUbGuVwWD3vgN
         703Q==
X-Gm-Message-State: AFqh2kre3WQVDHhMr5lWqrfWEerrEHOJ6RjIZ2MPKgIgvSdtuI6Ca2Be
        EtMm4MeaMTnZ6oIKvI1UE5Rysnein4Q=
X-Google-Smtp-Source: AMrXdXtILkYsNlifUW/4HmfuMMvgCLwzy9sTLAQ7wc1VavGSmqqHInOsBs+CSk6DW2ePzJl/p8ff1w==
X-Received: by 2002:a05:6000:1042:b0:2bc:804e:4c78 with SMTP id c2-20020a056000104200b002bc804e4c78mr143774wrx.59.1673248504120;
        Sun, 08 Jan 2023 23:15:04 -0800 (PST)
Received: from localhost (host81-157-153-247.range81-157.btcentralplus.com. [81.157.153.247])
        by smtp.gmail.com with ESMTPSA id c10-20020a056000104a00b002238ea5750csm8986002wrx.72.2023.01.08.23.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 23:15:03 -0800 (PST)
Date:   Mon, 9 Jan 2023 07:12:53 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, urezki@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v2 3/7] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y7u+dQfq3ZbDcf/d@lucifer>
References: <20221217015435.73889-1-bhe@redhat.com>
 <20221217015435.73889-4-bhe@redhat.com>
 <Y52wsONH+u/h0nuj@lucifer>
 <Y7UyYDRnc663qzTs@MiWiFi-R3L-srv>
 <Y7XfoQgk3HHgK0+f@lucifer>
 <Y7uZeBj56VcnJhzJ@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7uZeBj56VcnJhzJ@fedora>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 12:35:04PM +0800, Baoquan He wrote:
> Sorry for late reply, just come back from vacation.

Hope you had a great time! :)

>
> Lei + mutt sounds like a good idea. I relied too much on mbsync in the
> past.
>

Yeah I'm finding it works well,
https://josefbacik.github.io/kernel/2021/10/18/lei-and-b4.html is a handy guide!

[snip]
> > Maybe let me rephrase:-
> >
> > - We want to read `count` bytes from `addr` into `buf`
> > - We iterate over _used_ blocks, placing the start/end of each block in `rs`, `re`
> >   respectively.
> > - If we hit a block whose start address is above the one in which we are interested then:-
> >   - Place a zero byte in the buffer
> >   - Increment `addr` by 1 byte
> >   - Decrement the `count` by 1 byte
> >   - Carry on
> >
> > I am seriously confused as to why we do this? Surely we should be checking
> > whether the range [addr, addr + count) overlaps this block at all, and only then
> > copying the relevant region?
>
> I guessed this could be your concern, but not very sure. That
> code block is copied from vread(), and my considerations are:
> 1) We could starting read from any position of kcore file. /proc/kcore
> is a elf file logically, it's allowed to read from anywhere, right? We
> don't have to read the entire file always. So the vmap_block reading is
> not necessarily page aligned. It's very similar with the empty area
> filling in vread().
> 2) memset() is doing the byte by byte reading. We can
> change code as below. While we don't save the effort very much, and we
> need introduce an extra local variable to store the value of
> (start - end).
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index b054081aa66b..dce4a843a9e8 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3576,6 +3576,15 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
> +		if (addr < start) {
> +			int num = min(count, (start - add));
> +			memset(buf, 0, count);
> +			count -= num;
> +			if (count == 0)
> +				break;
> +			buf -= num;
> +			addr -= num;
> +		}
>  		/*it could start reading from the middle of used region*/
>  		offset = offset_in_page(addr);
>  		n = ((re - rs + 1) << PAGE_SHIFT) - offset;
>

The difference with vread() is that uses a while loop rather than an if clause
so operates over the whole region byte-by-byte, your original would only do this
for 1 byte so now things make a lot more sense!

This approach makes sense though I'd put the count == 0 check first and nit
'add' should be 'addr'.

I am happy with either this or a while loop instead of an if which it seems is
what the original issue was!

> void *memset(void *s, int c, size_t count)
> {
>         char *xs = s;
>
>         while (count--)
>                 *xs++ = c;
>         return s;
> }
>
> >
> > It's the fact that blocks are at base page granularity but then this condition
> > is at byte granularity that is confusing to me (again it's _very_ possible I am
> > just being dumb here and missing something, just really want to understand this
> > better :)
>
> I like this kind of reviewing with careful checking and deep thinking.
> For above code block, I think it's a very great point. From my point of
> view, I like the memset version better, it's easier to understand. If we
> all agree, we can change it to take memset way. When I made patches,
> several issues related to patches were hovering in my mind at the same
> time, I did not consider this one so deeply.
>

Thanks :) I have a particular interest in vmalloc so am happy to dive in with
reviews here!

> >
> > > > > -		vm = va->vm;
> > > > > -		vaddr = (char *) vm->addr;
> > > > > -		if (addr >= vaddr + get_vm_area_size(vm))
> > > > > +		vaddr = (char *) va->va_start;
> > > > > +		size = flags ? va_size(va) : get_vm_area_size(vm);
> > > >
> > > > For example here, I feel that this ternary should be reversed and based on
> > > > whether vm is null, unles we expect vm to ever be non-null _and_ flags to be
> > > > set?
> > >
> > > Now only vm_map_ram area sets flags, all other types has vm not null.
> > > Since those temporary state, e.g vm==NULL, flags==0 case has been
> > > filtered out. Is below you suggested?
> > >
> > > 		size = (!vm&&flags)? va_size(va) : get_vm_area_size(vm);
> > > 		or
> > > 		size = (vm&&!flags)? get_vm_area_size(vm):va_size(va);
> > >
> >
> > Sorry I didn't phrase this very well, my point is that the key thing you're
> > relying on here is whether vm exists in order to use it so I simply meant:-
> >
> > size = vm ? get_vm_area_size(vm) : va_size(va);
> >
> > This just makes it really explicit that you need vm to be non-NULL, and you've
> > already done the flags check before so this should suffice.
>
> Sounds reasonable, I will copy above line you pasted. Thanks a lot.
>

Cheers!
