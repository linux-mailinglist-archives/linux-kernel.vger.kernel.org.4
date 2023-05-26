Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B894F711B08
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 02:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbjEZAJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 20:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjEZAJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 20:09:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9F59C
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 17:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685059721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FeebMAbW/EDnlt2w9SPLduRDA/kIrZ2NE56FX/nkNSU=;
        b=cPYBR3hW2YuYk01qxqNNozwflXqtzwLx/dKR9iJFrHrGxeiJLaMtwbsPs+xe2yXftkCz5a
        wlbjC3ZQ9zqiBvblWEz/vigodjKJvEA2+FR1MXGVrKjR2K+9UebpRCnZvD+HkkhFlOBIgQ
        HfmeAuhxki3KBGWglEMaNy9Flz4f2CI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-a6WU9cGBPTaDp5KwnjD3Hg-1; Thu, 25 May 2023 20:08:37 -0400
X-MC-Unique: a6WU9cGBPTaDp5KwnjD3Hg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06401811E7C;
        Fri, 26 May 2023 00:08:37 +0000 (UTC)
Received: from localhost (ovpn-12-35.pek2.redhat.com [10.72.12.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B1821121314;
        Fri, 26 May 2023 00:08:35 +0000 (UTC)
Date:   Fri, 26 May 2023 08:08:33 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] lib/test_vmalloc.c: avoid garbage in page array
Message-ID: <ZG/4gVO9XPXccR5+@MiWiFi-R3L-srv>
References: <20230524082424.10022-1-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524082424.10022-1-lstoakes@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24/23 at 09:24am, Lorenzo Stoakes wrote:
> It turns out that alloc_pages_bulk_array() does not treat the page_array
> parameter as an output parameter, but rather reads the array and skips any
> entries that have already been allocated.

I read __alloc_pages_bulk() carefully, it does store the allocated page
pointers into page_array[] and pass out, not just reads the array and
skips entry alreay allocated.

For the issue this patch is trying to fix, you mean __alloc_pages_bulk()
doesn't initialize page_array intentionally if it doesn't successfully
allocate desired number of pages. we may need add one sentence to notice
user that page_array need be initialized explicitly.

By the way, could you please tell in which line the test was referencing
uninitialized data and causing the PFN to not be valid and trigger the
WANR_ON? Please forgive my dumb head.
> 
> This is somewhat unexpected and breaks this test, as we allocate the pages
> array uninitialised on the assumption it will be overwritten.
> 
> As a result, the test was referencing uninitialised data and causing the
> PFN to not be valid and thus a WARN_ON() followed by a null pointer deref
> and panic.
> 
> In addition, this is an array of pointers not of struct page objects, so we
> need only allocate an array with elements of pointer size.
> 
> We solve both problems by simply using kcalloc() and referencing
> sizeof(struct page *) rather than sizeof(struct page).
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  lib/test_vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
> index 9dd9745d365f..3718d9886407 100644
> --- a/lib/test_vmalloc.c
> +++ b/lib/test_vmalloc.c
> @@ -369,7 +369,7 @@ vm_map_ram_test(void)
>  	int i;
>  
>  	map_nr_pages = nr_pages > 0 ? nr_pages:1;
> -	pages = kmalloc(map_nr_pages * sizeof(struct page), GFP_KERNEL);
> +	pages = kcalloc(map_nr_pages, sizeof(struct page *), GFP_KERNEL);
>  	if (!pages)
>  		return -1;
>  
> -- 
> 2.40.1
> 

