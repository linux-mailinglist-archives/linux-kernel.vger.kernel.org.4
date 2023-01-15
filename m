Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023C866B167
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 15:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjAOOJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 09:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjAOOJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 09:09:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33583CDCE
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 06:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673791746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uYsStTjUz3WGDaAYUWg24ZE611xTjkecNGKieBDCjA8=;
        b=XUH/7gibccB4H7CIQoU9JzTPwDBUcU+NS9cUI9p9yTLQ45arO75CHjkUw6pS6JY0Z+7OLB
        KfrhuZgOy6GX9asv9JI40ZCFy7etNwRUQLnc5Re64L2DxDPO1geL1rfa7sCrxNKK7oUjqq
        abFGeAjmLYrS8BkOhZVKcOJ2IFx7+Ik=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-Ziwo1vRyNbeAEKupitVnJw-1; Sun, 15 Jan 2023 09:09:00 -0500
X-MC-Unique: Ziwo1vRyNbeAEKupitVnJw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08B351C07543;
        Sun, 15 Jan 2023 14:09:00 +0000 (UTC)
Received: from localhost (ovpn-12-229.pek2.redhat.com [10.72.12.229])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 16FD640C6EC4;
        Sun, 15 Jan 2023 14:08:58 +0000 (UTC)
Date:   Sun, 15 Jan 2023 22:08:55 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     oe-kbuild@lists.linux.dev, linux-mm@kvack.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        urezki@gmail.com, lstoakes@gmail.com, stephen.s.brennan@oracle.com,
        willy@infradead.org, akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v3 3/7] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y8QI977QBDbuuGW5@fedora>
References: <20230113031921.64716-4-bhe@redhat.com>
 <202301132345.KVjvHMFq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301132345.KVjvHMFq-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 01/14/23 at 10:57am, Dan Carpenter wrote:
> Hi Baoquan,
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/mm-vmalloc-c-add-used_map-into-vmap_block-to-track-space-of-vmap_block/20230113-112149
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20230113031921.64716-4-bhe%40redhat.com
> patch subject: [PATCH v3 3/7] mm/vmalloc.c: allow vread() to read out vm_map_ram areas
> config: i386-randconfig-m021
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> 
> smatch warnings:
> mm/vmalloc.c:3682 vread() error: we previously assumed 'vm' could be null (see line 3664)

Thanks for checking this. I went through the code flow again, personally
think that the issue and risk pointed out could not exist. Please see
the comment at below.

> 
> vim +/vm +3682 mm/vmalloc.c
> 
> ^1da177e4c3f415 Linus Torvalds          2005-04-16  3630  long vread(char *buf, char *addr, unsigned long count)
> ^1da177e4c3f415 Linus Torvalds          2005-04-16  3631  {
> e81ce85f960c2e2 Joonsoo Kim             2013-04-29  3632  	struct vmap_area *va;
> e81ce85f960c2e2 Joonsoo Kim             2013-04-29  3633  	struct vm_struct *vm;
> ^1da177e4c3f415 Linus Torvalds          2005-04-16  3634  	char *vaddr, *buf_start = buf;
> d0107eb07320b5d KAMEZAWA Hiroyuki       2009-09-21  3635  	unsigned long buflen = count;
> 129dbdf298d7383 Baoquan He              2023-01-13  3636  	unsigned long n, size, flags;
> ^1da177e4c3f415 Linus Torvalds          2005-04-16  3637  
> 4aff1dc4fb3a5a3 Andrey Konovalov        2022-03-24  3638  	addr = kasan_reset_tag(addr);
> 4aff1dc4fb3a5a3 Andrey Konovalov        2022-03-24  3639  
> ^1da177e4c3f415 Linus Torvalds          2005-04-16  3640  	/* Don't allow overflow */
> ^1da177e4c3f415 Linus Torvalds          2005-04-16  3641  	if ((unsigned long) addr + count < count)
> ^1da177e4c3f415 Linus Torvalds          2005-04-16  3642  		count = -(unsigned long) addr;
> ^1da177e4c3f415 Linus Torvalds          2005-04-16  3643  
> e81ce85f960c2e2 Joonsoo Kim             2013-04-29  3644  	spin_lock(&vmap_area_lock);
> f181234a5a21fd0 Chen Wandun             2021-09-02  3645  	va = find_vmap_area_exceed_addr((unsigned long)addr);
> f608788cd2d6cae Serapheim Dimitropoulos 2021-04-29  3646  	if (!va)
> f608788cd2d6cae Serapheim Dimitropoulos 2021-04-29  3647  		goto finished;
> f181234a5a21fd0 Chen Wandun             2021-09-02  3648  
> f181234a5a21fd0 Chen Wandun             2021-09-02  3649  	/* no intersects with alive vmap_area */
> f181234a5a21fd0 Chen Wandun             2021-09-02  3650  	if ((unsigned long)addr + count <= va->va_start)
> f181234a5a21fd0 Chen Wandun             2021-09-02  3651  		goto finished;
> f181234a5a21fd0 Chen Wandun             2021-09-02  3652  
> f608788cd2d6cae Serapheim Dimitropoulos 2021-04-29  3653  	list_for_each_entry_from(va, &vmap_area_list, list) {
> e81ce85f960c2e2 Joonsoo Kim             2013-04-29  3654  		if (!count)
> e81ce85f960c2e2 Joonsoo Kim             2013-04-29  3655  			break;
> e81ce85f960c2e2 Joonsoo Kim             2013-04-29  3656  
> 129dbdf298d7383 Baoquan He              2023-01-13  3657  		vm = va->vm;
> 129dbdf298d7383 Baoquan He              2023-01-13  3658  		flags = va->flags & VMAP_FLAGS_MASK;
> 129dbdf298d7383 Baoquan He              2023-01-13  3659  
> 129dbdf298d7383 Baoquan He              2023-01-13  3660  		if (!vm && !flags)
>                                                                             ^^^
> vm can be NULL if a flag in VMAP_FLAGS_MASK is set.
> 
> e81ce85f960c2e2 Joonsoo Kim             2013-04-29  3661  			continue;

Right, after the 'continue;' line, only two cases could happen when it
comes here. (vm != null) or (vm->flags & VMAP_RAM) is true.

> e81ce85f960c2e2 Joonsoo Kim             2013-04-29  3662  
> 129dbdf298d7383 Baoquan He              2023-01-13  3663  		vaddr = (char *) va->va_start;
> 129dbdf298d7383 Baoquan He              2023-01-13 @3664  		size = vm ? get_vm_area_size(vm) : va_size(va);
>                                                                                ^^
> 
> 129dbdf298d7383 Baoquan He              2023-01-13  3665  
> 129dbdf298d7383 Baoquan He              2023-01-13  3666  		if (addr >= vaddr + size)
> ^1da177e4c3f415 Linus Torvalds          2005-04-16  3667  			continue;
> ^1da177e4c3f415 Linus Torvalds          2005-04-16  3668  		while (addr < vaddr) {
> ^1da177e4c3f415 Linus Torvalds          2005-04-16  3669  			if (count == 0)
> ^1da177e4c3f415 Linus Torvalds          2005-04-16  3670  				goto finished;
> ^1da177e4c3f415 Linus Torvalds          2005-04-16  3671  			*buf = '\0';
> ^1da177e4c3f415 Linus Torvalds          2005-04-16  3672  			buf++;
> ^1da177e4c3f415 Linus Torvalds          2005-04-16  3673  			addr++;
> ^1da177e4c3f415 Linus Torvalds          2005-04-16  3674  			count--;
> ^1da177e4c3f415 Linus Torvalds          2005-04-16  3675  		}
> 129dbdf298d7383 Baoquan He              2023-01-13  3676  		n = vaddr + size - addr;
> d0107eb07320b5d KAMEZAWA Hiroyuki       2009-09-21  3677  		if (n > count)
> d0107eb07320b5d KAMEZAWA Hiroyuki       2009-09-21  3678  			n = count;
> 129dbdf298d7383 Baoquan He              2023-01-13  3679  
> 129dbdf298d7383 Baoquan He              2023-01-13  3680  		if (flags & VMAP_RAM)
> 
> assume VMAP_RAM is not set

OK, then vm is not null.
> 
> 129dbdf298d7383 Baoquan He              2023-01-13  3681  			vmap_ram_vread(buf, addr, n, flags);
> 129dbdf298d7383 Baoquan He              2023-01-13 @3682  		else if (!(vm->flags & VM_IOREMAP))
>                                                                                    ^^^^^^^^^
> Unchecked dereference.  Should this be "flags" instead of "vm->flags"?

Thus, here, in 'else if', vm is not null. And in this 'else if', we are
intending to check vm->flags. I don't see issue or risk here. Please
help check if I miss anything.

Thanks
Baoquan

> 
> d0107eb07320b5d KAMEZAWA Hiroyuki       2009-09-21  3683  			aligned_vread(buf, addr, n);
> d0107eb07320b5d KAMEZAWA Hiroyuki       2009-09-21  3684  		else /* IOREMAP area is treated as memory hole */
> d0107eb07320b5d KAMEZAWA Hiroyuki       2009-09-21  3685  			memset(buf, 0, n);
> d0107eb07320b5d KAMEZAWA Hiroyuki       2009-09-21  3686  		buf += n;
> d0107eb07320b5d KAMEZAWA Hiroyuki       2009-09-21  3687  		addr += n;
> d0107eb07320b5d KAMEZAWA Hiroyuki       2009-09-21  3688  		count -= n;
> ^1da177e4c3f415 Linus Torvalds          2005-04-16  3689  	}
> ^1da177e4c3f415 Linus Torvalds          2005-04-16  3690  finished:
> e81ce85f960c2e2 Joonsoo Kim             2013-04-29  3691  	spin_unlock(&vmap_area_lock);
> d0107eb07320b5d KAMEZAWA Hiroyuki       2009-09-21  3692  
> d0107eb07320b5d KAMEZAWA Hiroyuki       2009-09-21  3693  	if (buf == buf_start)
> d0107eb07320b5d KAMEZAWA Hiroyuki       2009-09-21  3694  		return 0;
> d0107eb07320b5d KAMEZAWA Hiroyuki       2009-09-21  3695  	/* zero-fill memory holes */
> d0107eb07320b5d KAMEZAWA Hiroyuki       2009-09-21  3696  	if (buf != buf_start + buflen)
> d0107eb07320b5d KAMEZAWA Hiroyuki       2009-09-21  3697  		memset(buf, 0, buflen - (buf - buf_start));
> d0107eb07320b5d KAMEZAWA Hiroyuki       2009-09-21  3698  
> d0107eb07320b5d KAMEZAWA Hiroyuki       2009-09-21  3699  	return buflen;
> ^1da177e4c3f415 Linus Torvalds          2005-04-16  3700  }
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
> 

