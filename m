Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022E96D13D1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 02:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjCaAAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 20:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjCaAAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:00:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33475B776
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680220774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AlObGl0RbS1uWVjSk5ffKE9VzX/UYtHp5qT3tL6QyYc=;
        b=UtVYbnmI6rHIEiY/LLGtWRAShlq1ikIzWqbowQ+DmJUMu/lSatD3OyiswVAdgxn+UVXCVq
        9wc18APqxq0RQaTU+a2QBKsTgJWAMV9ylMNJd2v9a6iki7DZcxipAsbz9mZ0ggkhw1eADr
        0Clxv1N7cDFLEAJ06Jj2UdXnqUti3ok=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-QnEG9cVDO7achDnPtWdxjQ-1; Thu, 30 Mar 2023 19:59:31 -0400
X-MC-Unique: QnEG9cVDO7achDnPtWdxjQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78F40185A78B;
        Thu, 30 Mar 2023 23:59:30 +0000 (UTC)
Received: from localhost (ovpn-12-64.pek2.redhat.com [10.72.12.64])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 22A5F404DC50;
        Thu, 30 Mar 2023 23:59:28 +0000 (UTC)
Date:   Fri, 31 Mar 2023 07:59:25 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 2/2] lib/test_vmalloc.c: Add
 vm_map_ram()/vm_unmap_ram() test case
Message-ID: <ZCYiXRRONRQMQKXv@MiWiFi-R3L-srv>
References: <20230330190639.431589-1-urezki@gmail.com>
 <20230330190639.431589-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330190639.431589-2-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/30/23 at 09:06pm, Uladzislau Rezki (Sony) wrote:
> Add vm_map_ram()/vm_unmap_ram() test case to our stress test-suite.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  lib/test_vmalloc.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
> index cd2bdba6d3ed..1622f3f9ec23 100644
> --- a/lib/test_vmalloc.c
> +++ b/lib/test_vmalloc.c
> @@ -53,6 +53,7 @@ __param(int, run_test_mask, INT_MAX,
>  		"\t\tid: 128,  name: pcpu_alloc_test\n"
>  		"\t\tid: 256,  name: kvfree_rcu_1_arg_vmalloc_test\n"
>  		"\t\tid: 512,  name: kvfree_rcu_2_arg_vmalloc_test\n"
> +		"\t\tid: 1024, name: vm_map_ram_test\n"
>  		/* Add a new test case description here. */
>  );
>  
> @@ -358,6 +359,41 @@ kvfree_rcu_2_arg_vmalloc_test(void)
>  	return 0;
>  }
>  
> +static int
> +vm_map_ram_test(void)
> +{
> +	unsigned long nr_allocated;
> +	unsigned int map_nr_pages;
> +	unsigned char *v_ptr;
> +	struct page **pages;
> +	int i;
> +
> +	map_nr_pages = nr_pages > 0 ? nr_pages:1;
> +	pages = kmalloc(map_nr_pages * sizeof(struct page), GFP_KERNEL);
> +	if (!pages)
> +		return -1;
> +
> +	nr_allocated = alloc_pages_bulk_array(GFP_KERNEL, map_nr_pages, pages);
> +	if (nr_allocated != map_nr_pages)
> +        goto cleanup;
> +
> +	/* Run the test loop. */
> +	for (i = 0; i < test_loop_count; i++) {
> +		v_ptr = vm_map_ram(pages, map_nr_pages, NUMA_NO_NODE);
> +		*v_ptr = 'a';
> +		vm_unmap_ram(v_ptr, map_nr_pages);
> +	}
> +
> +cleanup:
> +	for (i = 0; i < nr_allocated; i++)
> +		__free_page(pages[i]);
> +
> +	kfree(pages);
> +
> +	/* 0 indicates success. */
> +	return nr_allocated != map_nr_pages;
> +}
> +
>  struct test_case_desc {
>  	const char *test_name;
>  	int (*test_func)(void);
> @@ -374,6 +410,7 @@ static struct test_case_desc test_case_array[] = {
>  	{ "pcpu_alloc_test", pcpu_alloc_test },
>  	{ "kvfree_rcu_1_arg_vmalloc_test", kvfree_rcu_1_arg_vmalloc_test },
>  	{ "kvfree_rcu_2_arg_vmalloc_test", kvfree_rcu_2_arg_vmalloc_test },
> +	{ "vm_map_ram_test", vm_map_ram_test },
>  	/* Add a new test case here. */
>  };

Reviewed-by: Baoquan He <bhe@redhat.com>

