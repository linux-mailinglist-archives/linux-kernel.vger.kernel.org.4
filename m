Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DED6D0EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjC3TgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjC3TgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:36:08 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4FACDF6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:36:05 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j36-20020a05600c1c2400b003f04057c152so381720wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680204964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yjsyc1U/glH8MVNEKMozuzln3931VnrKfsax5D9QTMY=;
        b=UoV0qj6HTl4ymIm/xfu/pgW9DRIDmogqu+9W6be7Vl9ThOaapU8Ho7c7cBymRGFlX2
         +vFnNuj2xIp8/iGAok4d1AvRZF380xuDHv0polBWOW874MtkvNCASUBXLfhK38ZASWA0
         9Xw40Np9wfyFrvdoATfjNfQaCZN6IGzcoCPc88YSjmIxQnvfjNIJnhdJSojDlIOiDGHd
         8fp5pNTnRVegh9x/ENYo6EPOZ2YSL96GddDDaHbf3ZHcNVpl6+N05kuuGRRVVq/LHLC1
         eG72qZP7TFC8XOtNhGcM1+AyDkn1flEskYCCAgf5X4TxEWrKwagVxA6S6ncEEvrZiB3w
         Vm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680204964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjsyc1U/glH8MVNEKMozuzln3931VnrKfsax5D9QTMY=;
        b=T89fx9n4Ym/CFIwx9eej0A3gSKQWIsA31bISRdQGEubkd0FxV9/yTparWm08wpOYfC
         bsM1C5gSNESGtR+EO/BmYBnhgf879EgQUbHHS6gxuJ7TjWGdnbvdV5kvlv3NcyA8OixM
         yldKgrn62Y8/rUGeI3K5fpMgfY9S0EMRO109hnFlw38X+5NjPbx6dck/yI43UGGzK7o6
         kHNAvT69q3vaEYZgClG9znKvdhgwuwH5trbsREJGD7NdCfNECwrG0g5PaC0YXVMmQlqM
         tU4Y2kTtYhhw/N7eqZ333JUIwo+IOXFCIzdVJz3YfNlusZ+t63RCJo++m8/SOvDBzgEi
         7OHg==
X-Gm-Message-State: AO0yUKUfxiM7wpYVewYPHz0TUn4qxJCFamnZpYwno8/skKbljDb1L/4Q
        6I+MaDfBY5ppwtqcQt02u/E=
X-Google-Smtp-Source: AK7set+4PFx8cRO0C4wS+M8g73FWRWqW+wMdudO+G0U5womMPBMtiR2QwhTPdjknkiRzzKSSGbhRDA==
X-Received: by 2002:a7b:cc98:0:b0:3eb:3945:d405 with SMTP id p24-20020a7bcc98000000b003eb3945d405mr18199969wma.38.1680204964086;
        Thu, 30 Mar 2023 12:36:04 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c4fc900b003ef6bc71cccsm7626096wmq.27.2023.03.30.12.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 12:36:03 -0700 (PDT)
Date:   Thu, 30 Mar 2023 20:36:02 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 2/2] lib/test_vmalloc.c: Add
 vm_map_ram()/vm_unmap_ram() test case
Message-ID: <d900e7aa-5590-4644-bebb-3e1735d1ef90@lucifer.local>
References: <20230330190639.431589-1-urezki@gmail.com>
 <20230330190639.431589-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330190639.431589-2-urezki@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 09:06:39PM +0200, Uladzislau Rezki (Sony) wrote:
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

Nitty, but there's a whitespace error here, need to convert to tabs :)

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
>
> --
> 2.30.2
>

Other than the nit,

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
