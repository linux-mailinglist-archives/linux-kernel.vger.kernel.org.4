Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48972627A10
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbiKNKIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbiKNKIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:08:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E68CE0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668420423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YOB5ovzwG41qBNYEX8G5z12o/BuLOtHt6/b8j0c3Fwg=;
        b=TfF5I/J5bZb/NFFnvxb7NrSKyu2iFvuKvr/Wa8A3NOA9LzQrv1dB+gB8TH4F28Eo7hiK7r
        chD+nkuNyLqZhNxctfejC/9bHL3BlxZbhMJl16f65ylmB1L8VYiUWkRM0O/6Rgvtn4t2J4
        simanrGpZSD7pV5eSO82hD0LDDnTFeI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-310-Aw8vjTctObut8IMzRN_KUg-1; Mon, 14 Nov 2022 05:06:54 -0500
X-MC-Unique: Aw8vjTctObut8IMzRN_KUg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B74EE101A54E;
        Mon, 14 Nov 2022 10:06:53 +0000 (UTC)
Received: from localhost (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E57E71731B;
        Mon, 14 Nov 2022 10:06:52 +0000 (UTC)
Date:   Mon, 14 Nov 2022 18:06:49 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org
Subject: Re: [PATCH RFC 3/3] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y3ITOevjhUpDKEiS@MiWiFi-R3L-srv>
References: <20221109033535.269229-1-bhe@redhat.com>
 <20221109033535.269229-4-bhe@redhat.com>
 <87v8nnfwud.fsf@oracle.com>
 <Y2zROzfhdR5UU+lv@MiWiFi-R3L-srv>
 <87mt8yfxy6.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt8yfxy6.fsf@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/22 at 10:48am, Stephen Brennan wrote:
> Baoquan He <bhe@redhat.com> writes:
> 
> > On 11/09/22 at 04:59pm, Stephen Brennan wrote:
> > ......  
> >> > @@ -3569,12 +3609,14 @@ long vread(char *buf, char *addr, unsigned long count)
> >> >  		if (!count)
> >> >  			break;
> >> >  
> >> > -		if (!va->vm)
> >> > +		if (!(va->flags & VMAP_RAM) && !va->vm)
> >> >  			continue;
> >> >  
> >> >  		vm = va->vm;
> >> > -		vaddr = (char *) vm->addr;
> >> > -		if (addr >= vaddr + get_vm_area_size(vm))
> >> > +		vaddr = (char *) va->va_start;
> >> > +		size = vm ? get_vm_area_size(vm) : va_size(va);
> >> 
> >> Hi Baoquan,
> >> 
> >> Thanks for working on this. I tested your patches out by using drgn to
> >> debug /proc/kcore. I have a kernel module[1] to do a vm_map_ram() call
> >> and print the virtual address to the kernel log so I can try to read
> >> that memory address in drgn. When I did this test, I got a panic on the
> >> above line of code.
> > ......
> >> Since flags is in a union, it shadows "vm" and causes the condition to
> >> be true, and then get_vm_area_size() tries to follow the pointer defined
> >> by flags. I'm not sure if the fix is to have flags be a separate field
> >> inside vmap_area, or to have more careful handling in the vread path.
> >
> > Sorry, my bad. Thanks for testing this and catching the error, Stephen.
> >
> > About the fix, both way are fine to me. I made a draft fix based on the
> > current patchset. To me, adding flags in a separate field makes code
> > easier, but cost extra memory. I will see what other people say about
> > this, firstly if the solution is acceptable, then reusing the union
> > field or adding anohter flags.
> >
> > Could you try below code to see if it works?
> 
> I tried the patch below and it worked for me: reading from vm_map_ram()
> regions in drgn was fine, gave me the correct values, and I also tested
> reads which overlapped the beginning and end of the region.

Thanks a lot for the testing.

> 
> That said (and I don't know the vmalloc code well at all), I wonder
> whether you can be confident that the lower 2 bits of the va->vm pointer
> are always clear? It looks like it comes from kmalloc, and so it should
> be aligned, but can slab red zones mess up that alignment?

Hmm, it should be OK. I am also worried about the other places of va->vm
checking. I will check code again to see if there's risk in the case you
mentioned. I may change to add another ->flags field into vmap_area in
v2 post.

> 
> I also tested out this patch on top of yours, to be a bit more cautious.
> I think we can be confident that the remaining bits are zero when used
> as flags, and non-zero when used as a pointer, so you can test them to
> avoid any overlap. But it's probably too cautious.
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 78cae59170d8..911974f32b23 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3613,7 +3613,7 @@ long vread(char *buf, char *addr, unsigned long count)
>                 if (!va->vm)
>                         continue;
> 
> -               flags = va->flags & VMAP_FLAGS_MASK;
> +               flags = (va->flags & ~VMAP_FLAGS_MASK) ? 0 : (va->flags & VMAP_FLAGS_MASK);
>                 vm = va->vm;
> 
>                 vaddr = (char *) va->va_start;
> 

