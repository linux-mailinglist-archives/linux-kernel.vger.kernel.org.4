Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DF7652689
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiLTSr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbiLTSqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:46:49 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C7C2BD1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:46:40 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id n1so13353288ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j9wQjMhTPfA51Xzi4rhcgp0eEQkDkG0Es94rv3RfqG8=;
        b=AgLFddmKipaGcp9ZSzKmco925TMpUpCJfwlE60D5oEogokYyztcul/PLny/Cv8ebCi
         xXS3GYbwK6Iw8+vHQZmRPcSO01ACqhH7iHx+EKwjyqcrMoIcFRXi7aly9jS28P8gvAny
         gPS0e2QIwKjZOV+1Rm08EAKsss1j0dioRmhCMusspySKRRg3aKsUcN6+HhjGb/+IpWVR
         LzlPgzW0VSpACA/V2iTcBUIUaQ4EVDMRdWLRT0LSLYVVT8WjN9K/9Vq6fCkLe6kqLAfA
         bTbl46ofcnuIt8I5wqA6ODxsusIDZI0xnWNNqrQk4uXkreeAlGunoadLeKZo9BAVxqit
         StYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9wQjMhTPfA51Xzi4rhcgp0eEQkDkG0Es94rv3RfqG8=;
        b=IF3mv56B70UOSadKeHnvoHIdm4dNtrtaa6HbOq6SJkPjd8omBzKcS2JlHBrNCJN7uP
         1sowshqVwctZvTNSdIDmYd9xb5zHrMIcbKG99g/0ZiEIEwcE4ygwKHzG5ZL/1LfI0N35
         bwv6XSKhmPWCugI4iqnncWBfZ7yRVLnOCPGtKjs9Uj/H3X//36QUCKYW0SCouLIQKkl/
         9tj5TF/Qc7eirN6jmfMz2KPmSPb4kowNcaCl4bR6wEBHCTWFVHk6bCTznwNg05Zobz+O
         2mXU64KM0lEJqsQIEg6aJYCfNbocRCVxbI1HW0VERi83y0GtF7tgGoZX4Gs8n90VZoli
         JtVw==
X-Gm-Message-State: ANoB5plN6Tq5A+B3CKxWg4xZL0ZvkjeNBzApHZq2KbW8Nutlyp/4NwYI
        SjkHnuwVFPhw7/0d4g+6unM=
X-Google-Smtp-Source: AA0mqf7iFWtfPjL5WRmxy0Hgv3y/2Lm+9KRUsvsOyNxddWr8mFHVmH80woIXRa1Yb+l0VJKa+9MkGA==
X-Received: by 2002:a05:651c:238a:b0:27b:4c80:d07b with SMTP id bk10-20020a05651c238a00b0027b4c80d07bmr12275528ljb.52.1671561998471;
        Tue, 20 Dec 2022 10:46:38 -0800 (PST)
Received: from pc636 (host-90-233-218-120.mobileonline.telia.com. [90.233.218.120])
        by smtp.gmail.com with ESMTPSA id e14-20020a05651c038e00b00277025ddc9esm1104057ljp.54.2022.12.20.10.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 10:46:38 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 20 Dec 2022 19:46:36 +0100
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/2] mm: vmalloc: Avoid a double lookup of freed VA in a
 tree
Message-ID: <Y6IDDDyxsOYWsL2R@pc636>
References: <20221220182704.181657-1-urezki@gmail.com>
 <Y6ICwLwk3tPdZIqS@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6ICwLwk3tPdZIqS@pc636>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 07:45:20PM +0100, Uladzislau Rezki wrote:
> On Tue, Dec 20, 2022 at 07:27:03PM +0100, Uladzislau Rezki (Sony) wrote:
> > When a VA is freed over a main path, for example by invoking
> > the vfree() function, a tree is accessed two times what is odd:
> > 
> > vfree():
> >   __vunmap()
> >     __find_vmap_area()
> >   vm_remove_mappings()
> >     remove_vm_area()
> >       __find_vmap_area()
> > 
> > __find_vmap_area() are called two times. Fix it by introducing
> > a find_unlink_vmap_area() helper that finds and un-links a VA
> > from a tree.
> > 
> > Performance test results on a single CPU:
> > 
> > - fix_size_alloc_test       loops: 1000000 avg: 476847   usec
> > - full_fit_alloc_test       loops: 1000000 avg: 806746   usec
> > - long_busy_list_alloc_test loops: 1000000 avg: 13552093 usec
> > - random_size_alloc_test    loops: 1000000 avg: 7441322  usec
> > - fix_align_alloc_test      loops: 1000000 avg: 1411132  usec
> > All test took worker0=87650866284 cycles
> > 
> > - fix_size_alloc_test       loops: 1000000 avg: 490713   usec
> > - full_fit_alloc_test       loops: 1000000 avg: 579162   usec
> > - long_busy_list_alloc_test loops: 1000000 avg: 10485448 usec
> > - random_size_alloc_test    loops: 1000000 avg: 5824449  usec
> > - fix_align_alloc_test      loops: 1000000 avg: 984735   usec
> > All test took worker0=67952362802 cycles
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 40 ++++++++++++++++++++++++++++------------
> >  1 file changed, 28 insertions(+), 12 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 9e30f0b39203..0fc38c36e0df 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1825,9 +1825,14 @@ static void free_vmap_area_noflush(struct vmap_area *va)
> >  	unsigned long va_start = va->va_start;
> >  	unsigned long nr_lazy;
> >  
> > -	spin_lock(&vmap_area_lock);
> > -	unlink_va(va, &vmap_area_root);
> > -	spin_unlock(&vmap_area_lock);
> > +	/*
> > +	 * A free_vmap_block() is left. It is NOT a main free path.
> > +	 */
> > +	if (!list_empty(&va->list)) {
> > +		spin_lock(&vmap_area_lock);
> > +		unlink_va(va, &vmap_area_root);
> > +		spin_unlock(&vmap_area_lock);
> > +	}
> >  
> >  	nr_lazy = atomic_long_add_return((va->va_end - va->va_start) >>
> >  				PAGE_SHIFT, &vmap_lazy_nr);
> > @@ -1871,6 +1876,19 @@ struct vmap_area *find_vmap_area(unsigned long addr)
> >  	return va;
> >  }
> >  
> > +static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
> > +{
> > +	struct vmap_area *va;
> > +
> > +	spin_lock(&vmap_area_lock);
> > +	va = __find_vmap_area(addr, &vmap_area_root);
> > +	if (va)
> > +		unlink_va(va, &vmap_area_root);
> > +	spin_unlock(&vmap_area_lock);
> > +
> > +	return va;
> > +}
> > +
> >  /*** Per cpu kva allocator ***/
> >  
> >  /*
> > @@ -2236,7 +2254,7 @@ void vm_unmap_ram(const void *mem, unsigned int count)
> >  		return;
> >  	}
> >  
> > -	va = find_vmap_area(addr);
> > +	va = find_unlink_vmap_area(addr);
> >  	BUG_ON(!va);
> >  	debug_check_no_locks_freed((void *)va->va_start,
> >  				    (va->va_end - va->va_start));
> > @@ -2607,21 +2625,16 @@ struct vm_struct *remove_vm_area(const void *addr)
> >  
> >  	might_sleep();
> >  
> > -	spin_lock(&vmap_area_lock);
> > -	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
> > -	if (va && va->vm) {
> > +	va = find_unlink_vmap_area((unsigned long) addr);
> > +	if (va) {
> >  		struct vm_struct *vm = va->vm;
> >  
> > -		va->vm = NULL;
> > -		spin_unlock(&vmap_area_lock);
> > -
> >  		kasan_free_module_shadow(vm);
> >  		free_unmap_vmap_area(va);
> >  
> >  		return vm;
> >  	}
> >  
> > -	spin_unlock(&vmap_area_lock);
> >  	return NULL;
> >  }
> >  
> > @@ -2690,6 +2703,7 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
> >  static void __vunmap(const void *addr, int deallocate_pages)
> >  {
> >  	struct vm_struct *area;
> > +	struct vmap_area *va;
> >  
> >  	if (!addr)
> >  		return;
> > @@ -2698,7 +2712,9 @@ static void __vunmap(const void *addr, int deallocate_pages)
> >  			addr))
> >  		return;
> >  
> > -	area = find_vm_area(addr);
> > +	va = find_unlink_vmap_area((unsigned long)addr);
> > +	area = va->vm;
> > +
> >  	if (unlikely(!area)) {
> >  		WARN(1, KERN_ERR "Trying to vfree() nonexistent vm area (%p)\n",
> >  				addr);
> > -- 
> > 2.30.2
> > 
Will send a v2.
 
--
Uladzislau Rezki
