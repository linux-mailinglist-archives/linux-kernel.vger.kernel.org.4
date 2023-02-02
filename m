Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CCB687E67
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjBBNTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBBNTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:19:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB346EAF2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 05:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675343913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e1n69l0Tsv3jdN8ixpLREkwCQQl25Z7S/pkWfXRxnkY=;
        b=Jy2j5FeSOVMCAzU29rcAxdtY18zdZYfmtct09BGAoaJOZPblg0gyN5d4xLZnVU5XfMj6rs
        l9TAqlZaU9Uhz+GTXlaHi485LX/wM4mCcQHrDcr89XyrCxbQ1zRo0/aYNPyGnUInLPxq3h
        EEeEdXwfZWRumJRP7CEIb0Nubn6FzlY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-A9u7YseVPj-x9ReRJpOfzA-1; Thu, 02 Feb 2023 08:18:27 -0500
X-MC-Unique: A9u7YseVPj-x9ReRJpOfzA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 335AD85C6F4;
        Thu,  2 Feb 2023 13:18:27 +0000 (UTC)
Received: from localhost (ovpn-12-127.pek2.redhat.com [10.72.12.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 84B1DC15BA0;
        Thu,  2 Feb 2023 13:18:26 +0000 (UTC)
Date:   Thu, 2 Feb 2023 21:18:23 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, stephen.s.brennan@oracle.com,
        urezki@gmail.com, willy@infradead.org, hch@infradead.org,
        error27@gmail.com
Subject: Re: [PATCH v4 3/7] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y9u3+vQqE5e/EXeO@MiWiFi-R3L-srv>
References: <20230201091339.61761-1-bhe@redhat.com>
 <20230201091339.61761-4-bhe@redhat.com>
 <Y9rImPGSF/EQ1Xey@lucifer>
 <Y9sr56DqC+JCXt7z@MiWiFi-R3L-srv>
 <Y9tjnP2r7RqbFd7a@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9tjnP2r7RqbFd7a@lucifer>
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

On 02/02/23 at 07:17am, Lorenzo Stoakes wrote:
> On Thu, Feb 02, 2023 at 11:20:07AM +0800, Baoquan He wrote:
> 
> [snip]
> 
> > > > +	for_each_set_bitrange(rs, re, vb->used_map, VMAP_BBMAP_BITS) {
> > > > +		if (!count)
> > > > +			break;
> > > > +		start = vmap_block_vaddr(vb->va->va_start, rs);
> > > > +		while (addr < start) {
> > > > +			if (count == 0)
> > > > +				break;
> > >
> > > Bit pedantic, but you're using the `if (!count)` form of checking whether it's
> > > zero above, but here you explicitly check it, would be good to keep both consistent.
> >
> > Yeah, sounds good. Will change.
> >
> > >
> > > Given you're checking here, perhaps you could simply drop the previous check?
> >
> > Well, maybe no. The previous "if (!count)" is checking if count is 0
> > after the 'count -=n;' line at the end of the for_each loop. While this
> > "if (count == 0)" is checking if count is 0 after 'count--;' at the end
> > of while loop. Not sure if I got your point.
> 
> You're right, sorry each break is for a different loop :) and I guess the inner
> check is feeding the outer one so we're all good.

Oh, the inner check and break only terminates the while loop, but it
should jump to the 'spin_unlock(&vb->lock);' line too as the outer
break does. I will fix this.

