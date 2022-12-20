Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18390652043
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiLTMPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiLTMPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:15:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70927186CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671538478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yj0H0OPjYYhukChGoShtr+NfxDhWzTB9QJrl0G0MvS0=;
        b=OegDTwTceAiQ751lx8FWp1D4L0XhTo+CZOwaA/Ch+DmY3lFjdFBAO7BP18fOzZn+I0UjEw
        o9GRNm3gBlYYnBi6I2vNAHqg8nMO2BrlG99qUe/Y9eoM2hhO4G42HW2zJSmhqW5VaqHSoM
        NJEpCvSUe7jwko8RDSSPk/5qi7jzmqQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-bUmU_UJjMBy7kaG3QYQxjw-1; Tue, 20 Dec 2022 07:14:33 -0500
X-MC-Unique: bUmU_UJjMBy7kaG3QYQxjw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0ADB299E741;
        Tue, 20 Dec 2022 12:14:32 +0000 (UTC)
Received: from localhost (ovpn-12-53.pek2.redhat.com [10.72.12.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B0632C158BB;
        Tue, 20 Dec 2022 12:14:23 +0000 (UTC)
Date:   Tue, 20 Dec 2022 20:14:15 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, urezki@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v2 2/7] mm/vmalloc.c: add flags to mark vm_map_ram area
Message-ID: <Y6GnF51yd+d1qINF@MiWiFi-R3L-srv>
References: <20221217015435.73889-1-bhe@redhat.com>
 <20221217015435.73889-3-bhe@redhat.com>
 <Y52rllbXHMwbpJ8K@lucifer>
 <Y6AaPKT7mdVxdHRl@MiWiFi-R3L-srv>
 <Y6AqRauq6wEYK0n5@lucifer>
 <Y6BYD24wzAogqRyT@MiWiFi-R3L-srv>
 <Y6Bgt7k1H7Ez4EEb@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6Bgt7k1H7Ez4EEb@lucifer>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/22 at 01:01pm, Lorenzo Stoakes wrote:
> On Mon, Dec 19, 2022 at 08:24:47PM +0800, Baoquan He wrote:
> > In fact, I should not do the checking, but do the clearing anyway. If I
> > change it as below, does it look better to you?
> >
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 5e578563784a..369b848d097a 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2253,8 +2253,7 @@ void vm_unmap_ram(const void *mem, unsigned int count)
> >  	spin_lock(&vmap_area_lock);
> >  	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
> >  	BUG_ON(!va);
> > -	if (va)
> > -		va->flags &= ~VMAP_RAM;
> > +	va->flags &= ~VMAP_RAM;
> >  	spin_unlock(&vmap_area_lock);
> >  	debug_check_no_locks_freed((void *)va->va_start,
> >  				    (va->va_end - va->va_start));
> 
> This is better as it avoids the slightly contradictory situation of checking for
> a condition we've asserted is not the case, but I would still far prefer keeping
> this as-is and placing the unlock before the BUG_ON().
> 
> This avoids explicitly and knowingly holding a lock over a BUG_ON() and is
> simple to implement, e.g.:-
> 
>   	spin_lock(&vmap_area_lock);
>   	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
>  	if (va)
>  		va->flags &= ~VMAP_RAM;
>   	spin_unlock(&vmap_area_lock);
>   	BUG_ON(!va);

OK, I will change like this.

> 
> > > You are at this point clearing the VMAP_RAM flag though, so if it is unimportant
> > > what the flags are after this call, why are you clearing this one?
> >
> > With my understanding, We had better do the clearing. Currently, from
> > the code, not doing the clearing won't cause issue. If possible, I would
> > like to clear it as below draft code.
> >
> 
> Sure, it seems appropriate to clear it, I'm just unsure as to why you aren't
> just clearing both flags? Perhaps just set va->flags = 0?

Hmm, for the two kinds of vm_map_ram areas, their code paths are
different. for unmapping vmap_block vm_map_ram, it goes through
vb_free(). I can only do the clearing in free_vmap_block().

  -->vm_unmap_ram()
     -->vb_free()
        -->free_vmap_block()

For non vmap_block vm_map_ram area, I can do the clearing in
vm_unmap_ram().
  -->vm_unmap_ram()
     -->__find_vmap_area()
     -->free_unmap_vmap_area()

As said earlier, clearing va->flags when unmap vm_map_ram area, or
clearing va->vm in remove_vm_area(), these have better be done.
However, not clearing them won't cause issue currently. Because the
old vmap_area is inserted into free_vmap_area_root, when we allocate a
new vmap_area through alloc_vmap_area(), we will get q new vmap_area
from vmap_area_cachep, the old va->flags or va->vm won't be carried into
the new vmap_area. Clearing them is a good to have, just in case.

Rethinking about this, I may need to do the clearing when freeing
vmap_block. Otherwise, people will be confused why the clearing is not
done.

@@ -1815,6 +1815,7 @@ static void free_vmap_area_noflush(struct vmap_area *va)

        spin_lock(&vmap_area_lock);
        unlink_va(va, &vmap_area_root);
+       va->flags = 0;
        spin_unlock(&vmap_area_lock);

        nr_lazy = atomic_long_add_return((va->va_end - va->va_start) >>

> 
> > >
> > > It is just a little confusing, I wonder whether the VMAP_BLOCK flag is necessary
> > > at all, is it possible to just treat a non-VMAP_BLOCK VMAP_RAM area as if it
> > > were simply a fully occupied block? Do we gain much by the distinction?
> >
> > Yeah, VMAP_BLOCK flag is necessary. vmap_block contains used region,
> > or dirty/free regions. While the non-vmap_blcok vm_map_ram area is
> > similar with the non vm_map_ram area. When reading out vm_map_ram
> > regions, vmap_block regions need be treated differently.
> 
> OK looking through again closely I see you're absolutely right, I wondered
> whether you could somehow make a non-VMAP_BLOCK vread() operation be equivalent
> to a block one (only across the whole mapping), but I don't think you can.

Right, it's much easier to do the same handling on non-VMAP_BLOCK vm_map_ram
as the normal vmap area.

