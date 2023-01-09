Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FC76625DC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 13:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjAIMvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 07:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjAIMvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 07:51:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205C7B49
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 04:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673268578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LwhDO9hieIsVo3qlSVGIThrVfpxjel+wqnVT2UQVflA=;
        b=LcCRh6FREiDYfVyvHVG9rL35uAzGu35xxTVvp9FF3AzsuZy7FP9rlgOpuipJItqjb7PpVJ
        4gC2mFVsHB1/d5KV303uPCjuxKEcQtUAo7QUy1cWAEbynHOlyoViB5uEV8t6qHX4RYHywq
        6KR//2XqHgeypSWXL8aM7/KguttydLU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-8ESDBqPiPE2lYi__J1m1ng-1; Mon, 09 Jan 2023 07:49:33 -0500
X-MC-Unique: 8ESDBqPiPE2lYi__J1m1ng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8F7E1C07541;
        Mon,  9 Jan 2023 12:49:32 +0000 (UTC)
Received: from localhost (ovpn-12-124.pek2.redhat.com [10.72.12.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA6022166B26;
        Mon,  9 Jan 2023 12:49:31 +0000 (UTC)
Date:   Mon, 9 Jan 2023 20:49:28 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, urezki@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v2 3/7] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y7wNWNr/0oxEhjZw@fedora>
References: <20221217015435.73889-1-bhe@redhat.com>
 <20221217015435.73889-4-bhe@redhat.com>
 <Y52wsONH+u/h0nuj@lucifer>
 <Y7UyYDRnc663qzTs@MiWiFi-R3L-srv>
 <Y7XfoQgk3HHgK0+f@lucifer>
 <Y7uZeBj56VcnJhzJ@fedora>
 <Y7u+dQfq3ZbDcf/d@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7u+dQfq3ZbDcf/d@lucifer>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/23 at 07:12am, Lorenzo Stoakes wrote:
> On Mon, Jan 09, 2023 at 12:35:04PM +0800, Baoquan He wrote:
> > Sorry for late reply, just come back from vacation.
> 
> Hope you had a great time! :)

Thanks.

> 
> >
> > Lei + mutt sounds like a good idea. I relied too much on mbsync in the
> > past.
> >
> 
> Yeah I'm finding it works well,
> https://josefbacik.github.io/kernel/2021/10/18/lei-and-b4.html is a handy guide!

Very helpful, will try.

> 
> [snip]
> > > Maybe let me rephrase:-
> > >
> > > - We want to read `count` bytes from `addr` into `buf`
> > > - We iterate over _used_ blocks, placing the start/end of each block in `rs`, `re`
> > >   respectively.
> > > - If we hit a block whose start address is above the one in which we are interested then:-
> > >   - Place a zero byte in the buffer
> > >   - Increment `addr` by 1 byte
> > >   - Decrement the `count` by 1 byte
> > >   - Carry on
> > >
> > > I am seriously confused as to why we do this? Surely we should be checking
> > > whether the range [addr, addr + count) overlaps this block at all, and only then
> > > copying the relevant region?
> >
> > I guessed this could be your concern, but not very sure. That
> > code block is copied from vread(), and my considerations are:
> > 1) We could starting read from any position of kcore file. /proc/kcore
> > is a elf file logically, it's allowed to read from anywhere, right? We
> > don't have to read the entire file always. So the vmap_block reading is
> > not necessarily page aligned. It's very similar with the empty area
> > filling in vread().
> > 2) memset() is doing the byte by byte reading. We can
> > change code as below. While we don't save the effort very much, and we
> > need introduce an extra local variable to store the value of
> > (start - end).
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index b054081aa66b..dce4a843a9e8 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3576,6 +3576,15 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
> > +		if (addr < start) {
> > +			int num = min(count, (start - add));
> > +			memset(buf, 0, count);
> > +			count -= num;
> > +			if (count == 0)
> > +				break;
> > +			buf -= num;
> > +			addr -= num;
> > +		}
> >  		/*it could start reading from the middle of used region*/
> >  		offset = offset_in_page(addr);
> >  		n = ((re - rs + 1) << PAGE_SHIFT) - offset;
> >
> 
> The difference with vread() is that uses a while loop rather than an if clause
> so operates over the whole region byte-by-byte, your original would only do this
> for 1 byte so now things make a lot more sense!

Oops, that 'if clause' is a code bug, I finally got your point until
now, my dumb head.

> 
> This approach makes sense though I'd put the count == 0 check first and nit
> 'add' should be 'addr'.
> 
> I am happy with either this or a while loop instead of an if which it seems is
> what the original issue was!

OK, I will think again which one is more appropriate.

> 
> > void *memset(void *s, int c, size_t count)
> > {
> >         char *xs = s;
> >
> >         while (count--)
> >                 *xs++ = c;
> >         return s;
> > }
> >
> > >
> > > It's the fact that blocks are at base page granularity but then this condition
> > > is at byte granularity that is confusing to me (again it's _very_ possible I am
> > > just being dumb here and missing something, just really want to understand this
> > > better :)
> >
> > I like this kind of reviewing with careful checking and deep thinking.
> > For above code block, I think it's a very great point. From my point of
> > view, I like the memset version better, it's easier to understand. If we
> > all agree, we can change it to take memset way. When I made patches,
> > several issues related to patches were hovering in my mind at the same
> > time, I did not consider this one so deeply.
> >
> 
> Thanks :) I have a particular interest in vmalloc so am happy to dive in with
> reviews here!
> 
> > >
> > > > > > -		vm = va->vm;
> > > > > > -		vaddr = (char *) vm->addr;
> > > > > > -		if (addr >= vaddr + get_vm_area_size(vm))
> > > > > > +		vaddr = (char *) va->va_start;
> > > > > > +		size = flags ? va_size(va) : get_vm_area_size(vm);
> > > > >
> > > > > For example here, I feel that this ternary should be reversed and based on
> > > > > whether vm is null, unles we expect vm to ever be non-null _and_ flags to be
> > > > > set?
> > > >
> > > > Now only vm_map_ram area sets flags, all other types has vm not null.
> > > > Since those temporary state, e.g vm==NULL, flags==0 case has been
> > > > filtered out. Is below you suggested?
> > > >
> > > > 		size = (!vm&&flags)? va_size(va) : get_vm_area_size(vm);
> > > > 		or
> > > > 		size = (vm&&!flags)? get_vm_area_size(vm):va_size(va);
> > > >
> > >
> > > Sorry I didn't phrase this very well, my point is that the key thing you're
> > > relying on here is whether vm exists in order to use it so I simply meant:-
> > >
> > > size = vm ? get_vm_area_size(vm) : va_size(va);
> > >
> > > This just makes it really explicit that you need vm to be non-NULL, and you've
> > > already done the flags check before so this should suffice.
> >
> > Sounds reasonable, I will copy above line you pasted. Thanks a lot.

Thanks again for careful reviewing and great suggestions and findings.

