Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1A5661DF3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 05:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbjAIEkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 23:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjAIEjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 23:39:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6528C11C31
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 20:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673238914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jXE9ysY8TsetXrz3k2aufGjgtf+9wArYiR9yknjHmIQ=;
        b=Fw/Y/D+/u5Hq2im+mKMUq8LNcYxw3zd9nK6FQeEZRaf5URrge9cniL9OYa8pjVUN9D/xek
        p5WnwK+L5WwxL+5ggE6M5Zq+nA4YtU1zPp9mwiV7E8/V2JVe5p9R6CiwGOyWFkd7Hj+fWS
        ge+4pxTAum04GatMGpQXYeWdXdCyJbs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-ptf8tDYKMt-R_rDe_j81JA-1; Sun, 08 Jan 2023 23:35:10 -0500
X-MC-Unique: ptf8tDYKMt-R_rDe_j81JA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 461151C05140;
        Mon,  9 Jan 2023 04:35:10 +0000 (UTC)
Received: from localhost (ovpn-12-124.pek2.redhat.com [10.72.12.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D34FD492B00;
        Mon,  9 Jan 2023 04:35:08 +0000 (UTC)
Date:   Mon, 9 Jan 2023 12:35:04 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, urezki@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v2 3/7] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y7uZeBj56VcnJhzJ@fedora>
References: <20221217015435.73889-1-bhe@redhat.com>
 <20221217015435.73889-4-bhe@redhat.com>
 <Y52wsONH+u/h0nuj@lucifer>
 <Y7UyYDRnc663qzTs@MiWiFi-R3L-srv>
 <Y7XfoQgk3HHgK0+f@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7XfoQgk3HHgK0+f@lucifer>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/23 at 08:20pm, Lorenzo Stoakes wrote:
> On Wed, Jan 04, 2023 at 04:01:36PM +0800, Baoquan He wrote:
> > On 12/17/22 at 12:06pm, Lorenzo Stoakes wrote:
> > > On Sat, Dec 17, 2022 at 09:54:31AM +0800, Baoquan He wrote:
> > > > Currently, vread can read out vmalloc areas which is associated with
> > > > a vm_struct. While this doesn't work for areas created by vm_map_ram()
> > > > interface because it doesn't have an associated vm_struct. Then in vread(),
> > > > these areas will be skipped.
> > > >
> > > > Here, add a new function vb_vread() to read out areas managed by
> > > > vmap_block specifically. Then recognize vm_map_ram areas via vmap->flags
> > > > and handle them respectively.
> > > >
> > > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > > ---
> > > >  mm/vmalloc.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++------
> > > >  1 file changed, 59 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index 190f29bbaaa7..6612914459cf 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -3515,6 +3515,51 @@ static int aligned_vread(char *buf, char *addr, unsigned long count)
> > > >  	return copied;
> > > >  }
> > > >
> > > > +static void vb_vread(char *buf, char *addr, int count)
> > > > +{
> > > > +	char *start;
> > > > +	struct vmap_block *vb;
> > > > +	unsigned long offset;
> > > > +	unsigned int rs, re, n;
> > > > +
> > > > +	vb = xa_load(&vmap_blocks, addr_to_vb_idx((unsigned long)addr));
> > > > +
> > > > +	spin_lock(&vb->lock);
> > > > +	if (bitmap_empty(vb->used_map, VMAP_BBMAP_BITS)) {
> > > > +		spin_unlock(&vb->lock);
> > > > +		memset(buf, 0, count);
> > > > +		return;
> > > > +	}
> > > > +	for_each_set_bitrange(rs, re, vb->used_map, VMAP_BBMAP_BITS) {
> > > > +		if (!count)
> > > > +			break;
> > > > +		start = vmap_block_vaddr(vb->va->va_start, rs);
> > > > +		if (addr < start) {
> > > > +			if (count == 0)
> > > > +				break;
> > > > +			*buf = '\0';
> > > > +			buf++;
> > > > +			addr++;
> > > > +			count--;
> > > > +		}
> >
> > Very sorry, Lorenzo, I just noticed this mail. It's very weird. Earlier,
> > Uladzislau's reply to patch 2/7 got to be seen in my mutt mail client 10
> > days later. I am not sure it's my mail client's problem, or a mail server
> > delivery issue.
> >
> 
> Odd, maybe try lei with mutt I find that works well :)

Sorry for late reply, just come back from vacation.

Lei + mutt sounds like a good idea. I relied too much on mbsync in the
past.

> 
> > >
> > > I may be missing something here, but is this not essentially 'if the address is
> > > below a used region, write a single null byte into the buffer and continue,
> > > assuming we are now in a used area?'
> >
> > Not sure if I got you. for_each_set_bitrange only iterates the used
> > regions. So in the for loop, what we do is fill zero into the buffer
> > below the used region, then read out the used region. You said
> > 'continue', I don't understand what it means.
> >
> > Assume we have 3 used regions in one vmap block, see below diagram.
> >      |_______|______________|________|_____________|_____|_____________|______|
> >      |hole 0 |used region 0 |hole 1  |used region 1|hole2|used region2 |hole 3 |
> >
> > hole 0,1,2 will be set zero when we iterate to the used region above
> > them. And the last hole 3 is set at the end of this function. Please
> > help point it out if I got it wrong.
> 
> Maybe let me rephrase:-
> 
> - We want to read `count` bytes from `addr` into `buf`
> - We iterate over _used_ blocks, placing the start/end of each block in `rs`, `re`
>   respectively.
> - If we hit a block whose start address is above the one in which we are interested then:-
>   - Place a zero byte in the buffer
>   - Increment `addr` by 1 byte
>   - Decrement the `count` by 1 byte
>   - Carry on
> 
> I am seriously confused as to why we do this? Surely we should be checking
> whether the range [addr, addr + count) overlaps this block at all, and only then
> copying the relevant region?

I guessed this could be your concern, but not very sure. That
code block is copied from vread(), and my considerations are:
1) We could starting read from any position of kcore file. /proc/kcore
is a elf file logically, it's allowed to read from anywhere, right? We
don't have to read the entire file always. So the vmap_block reading is
not necessarily page aligned. It's very similar with the empty area
filling in vread().
2) memset() is doing the byte by byte reading. We can 
change code as below. While we don't save the effort very much, and we
need introduce an extra local variable to store the value of
(start - end).

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b054081aa66b..dce4a843a9e8 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3576,6 +3576,15 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
+		if (addr < start) {
+			int num = min(count, (start - add));
+			memset(buf, 0, count);
+			count -= num;
+			if (count == 0)
+				break;
+			buf -= num;
+			addr -= num;
+		}
 		/*it could start reading from the middle of used region*/
 		offset = offset_in_page(addr);
 		n = ((re - rs + 1) << PAGE_SHIFT) - offset;

void *memset(void *s, int c, size_t count)
{
        char *xs = s;
 
        while (count--)
                *xs++ = c;
        return s;
}

> 
> It's the fact that blocks are at base page granularity but then this condition
> is at byte granularity that is confusing to me (again it's _very_ possible I am
> just being dumb here and missing something, just really want to understand this
> better :)

I like this kind of reviewing with careful checking and deep thinking.
For above code block, I think it's a very great point. From my point of
view, I like the memset version better, it's easier to understand. If we
all agree, we can change it to take memset way. When I made patches,
several issues related to patches were hovering in my mind at the same
time, I did not consider this one so deeply.

> 
> > > > -		vm = va->vm;
> > > > -		vaddr = (char *) vm->addr;
> > > > -		if (addr >= vaddr + get_vm_area_size(vm))
> > > > +		vaddr = (char *) va->va_start;
> > > > +		size = flags ? va_size(va) : get_vm_area_size(vm);
> > >
> > > For example here, I feel that this ternary should be reversed and based on
> > > whether vm is null, unles we expect vm to ever be non-null _and_ flags to be
> > > set?
> >
> > Now only vm_map_ram area sets flags, all other types has vm not null.
> > Since those temporary state, e.g vm==NULL, flags==0 case has been
> > filtered out. Is below you suggested?
> >
> > 		size = (!vm&&flags)? va_size(va) : get_vm_area_size(vm);
> > 		or
> > 		size = (vm&&!flags)? get_vm_area_size(vm):va_size(va);
> >
> 
> Sorry I didn't phrase this very well, my point is that the key thing you're
> relying on here is whether vm exists in order to use it so I simply meant:-
> 
> size = vm ? get_vm_area_size(vm) : va_size(va);
> 
> This just makes it really explicit that you need vm to be non-NULL, and you've
> already done the flags check before so this should suffice.

Sounds reasonable, I will copy above line you pasted. Thanks a lot.

