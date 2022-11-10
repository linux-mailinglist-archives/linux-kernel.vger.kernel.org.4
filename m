Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CB2623FB8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiKJKZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiKJKZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:25:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEF61402B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668075843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=czPIFT3o5TugDKi+RX7yE7CkBCTDZutrGeVsIeUfGZ0=;
        b=SD+Uz8jWfHzBppoPYnhPuJM/2+Bhem3LVnndYY7aDLUizTqWyN/bMlvTCthOldIbF3phM4
        86yXtFlC9Y437Qjn4fQrlnFJ0oc4ACPs9n42vVAugZqMyBvaXjxmVz/zh7NzEeLpEDVBOo
        jZzjzNtHT/3xEa5jSE545W/nx4dsGE4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-TpJWhQ4jOuqxEJmzFQ7N0Q-1; Thu, 10 Nov 2022 05:24:00 -0500
X-MC-Unique: TpJWhQ4jOuqxEJmzFQ7N0Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2708F800B30;
        Thu, 10 Nov 2022 10:24:00 +0000 (UTC)
Received: from localhost (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 671DD112131B;
        Thu, 10 Nov 2022 10:23:58 +0000 (UTC)
Date:   Thu, 10 Nov 2022 18:23:55 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org
Subject: Re: [PATCH RFC 3/3] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y2zROzfhdR5UU+lv@MiWiFi-R3L-srv>
References: <20221109033535.269229-1-bhe@redhat.com>
 <20221109033535.269229-4-bhe@redhat.com>
 <87v8nnfwud.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8nnfwud.fsf@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/22 at 04:59pm, Stephen Brennan wrote:
......  
> > @@ -3569,12 +3609,14 @@ long vread(char *buf, char *addr, unsigned long count)
> >  		if (!count)
> >  			break;
> >  
> > -		if (!va->vm)
> > +		if (!(va->flags & VMAP_RAM) && !va->vm)
> >  			continue;
> >  
> >  		vm = va->vm;
> > -		vaddr = (char *) vm->addr;
> > -		if (addr >= vaddr + get_vm_area_size(vm))
> > +		vaddr = (char *) va->va_start;
> > +		size = vm ? get_vm_area_size(vm) : va_size(va);
> 
> Hi Baoquan,
> 
> Thanks for working on this. I tested your patches out by using drgn to
> debug /proc/kcore. I have a kernel module[1] to do a vm_map_ram() call
> and print the virtual address to the kernel log so I can try to read
> that memory address in drgn. When I did this test, I got a panic on the
> above line of code.
......
> Since flags is in a union, it shadows "vm" and causes the condition to
> be true, and then get_vm_area_size() tries to follow the pointer defined
> by flags. I'm not sure if the fix is to have flags be a separate field
> inside vmap_area, or to have more careful handling in the vread path.

Sorry, my bad. Thanks for testing this and catching the error, Stephen.

About the fix, both way are fine to me. I made a draft fix based on the
current patchset. To me, adding flags in a separate field makes code
easier, but cost extra memory. I will see what other people say about
this, firstly if the solution is acceptable, then reusing the union
field or adding anohter flags.

Could you try below code to see if it works?

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5a8d5659bfb0..78cae59170d8 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1890,6 +1890,7 @@ struct vmap_area *find_vmap_area(unsigned long addr)
 
 #define VMAP_RAM	0x1
 #define VMAP_BLOCK	0x2
+#define VMAP_FLAGS_MASK	0x3
 
 struct vmap_block_queue {
 	spinlock_t lock;
@@ -3588,7 +3589,7 @@ long vread(char *buf, char *addr, unsigned long count)
 	struct vm_struct *vm;
 	char *vaddr, *buf_start = buf;
 	unsigned long buflen = count;
-	unsigned long n, size;
+	unsigned long n, size, flags;
 
 	addr = kasan_reset_tag(addr);
 
@@ -3609,12 +3610,14 @@ long vread(char *buf, char *addr, unsigned long count)
 		if (!count)
 			break;
 
-		if (!(va->flags & VMAP_RAM) && !va->vm)
+		if (!va->vm)
 			continue;
 
+		flags = va->flags & VMAP_FLAGS_MASK;
 		vm = va->vm;
+
 		vaddr = (char *) va->va_start;
-		size = vm ? get_vm_area_size(vm) : va_size(va);
+		size = flags ? va_size(va) : get_vm_area_size(vm);
 
 		if (addr >= vaddr + size)
 			continue;
@@ -3630,9 +3633,9 @@ long vread(char *buf, char *addr, unsigned long count)
 		if (n > count)
 			n = count;
 
-		if ((va->flags & (VMAP_RAM|VMAP_BLOCK)) == (VMAP_RAM|VMAP_BLOCK))
+		if ((flags & (VMAP_RAM|VMAP_BLOCK)) == (VMAP_RAM|VMAP_BLOCK))
 			vb_vread(buf, addr, n);
-		else if ((va->flags & VMAP_RAM) || !(vm->flags & VM_IOREMAP))
+		else if ((flags & VMAP_RAM) || !(vm->flags & VM_IOREMAP))
 			aligned_vread(buf, addr, n);
 		else /* IOREMAP area is treated as memory hole */
 			memset(buf, 0, n);

