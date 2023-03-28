Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530326CBF08
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjC1MaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjC1MaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:30:03 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637D77A9E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:30:02 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bi9so15565616lfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680006600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c8/IhKCi1jZsslOM0zG5uB2r2011J/tfE7DWqxzpB1k=;
        b=XHSVVhsxOzhyUqKVjibXCEn9EPxvyOwt8Y0TKj+mJQ+BEHOBX0b4i2z+f+qqVyWv/a
         74cF60BHgHIpCHOAtUqszuyWURwDD1UbcKb8dhXsjvRBgWTbhgkipiZ563yfHx4qyFq3
         mTg7SOrV4c1lGvbfS5cD2Ha8/7FwchgcQtUlCH35xiX1ZC81U5ZBAItmyJnB36OuaKh7
         8AsIrb1mQsinT7WXQHphEBdNB64OMdTdTcnCNCL0xqtbp+WgeimRsIAAG+YUy1sQxvQR
         6jL02ScpqyavnrC/SiHqUx84r/uwF1TQvksCVAI2PVxs95hiUmqEKBOtKJAKmA+GLwyg
         R3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680006600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8/IhKCi1jZsslOM0zG5uB2r2011J/tfE7DWqxzpB1k=;
        b=I2Q3NE+mCjhhdNWDSD/EDpE3NGu3PapWr0WGcKnVQw8R85108uxdRr84n7X5Fo/wCe
         Pse0v8iVWm5xSDPg4p3T2AnCUk6kdmTtb366YI9ZGipcCGmkNgheUr0BX2LZhpd4aNjH
         ZfGljFazfUy/t+SOYIQbuJay054MWgC479b47VDH//zje4aCMpV/t1LvXYvySAoZOCcX
         2IKc6haI2ffgvGsyfS5b2DK0RoyLZlpgIcgsTIRRmgS62Ec0VvIQH4/N7NoyGvorgjQ8
         0OzByWxgmXVxLjGnEJGq/yMmWMSC6HXJ7k1QAso7hzrpCzxXhcyhWC1f+zKpdIvGE4DW
         IW9A==
X-Gm-Message-State: AAQBX9dOeBllC5PcGznX7n+z1QHMLvRmyw/pRIbM201l+OtCg4dyBrHi
        +VgmFrZ/IvuHMOTAG6BpTfU=
X-Google-Smtp-Source: AKy350bQ7ZmSVvio4rXBl3FqF0A1OeqFhkPn672Q/2Xd21rem00GNnzzY1ltgW4Kcw5IHBlKj1qXgg==
X-Received: by 2002:a05:6512:4dd:b0:4d8:56d8:92ee with SMTP id w29-20020a05651204dd00b004d856d892eemr4798743lfq.35.1680006600508;
        Tue, 28 Mar 2023 05:30:00 -0700 (PDT)
Received: from pc636 (host-90-233-209-50.mobileonline.telia.com. [90.233.209.50])
        by smtp.gmail.com with ESMTPSA id s18-20020a2e9c12000000b00295765966d9sm5042273lji.86.2023.03.28.05.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 05:29:59 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 28 Mar 2023 14:29:57 +0200
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 2/2] lib/test_vmalloc.c: Add
 vm_map_ram()/vm_unmap_ram() test case
Message-ID: <ZCLdxSyfBpB+zARG@pc636>
References: <20230327170126.406044-1-urezki@gmail.com>
 <20230327170126.406044-2-urezki@gmail.com>
 <68791932-5e23-4afd-9b36-6cc9a310fdd5@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68791932-5e23-4afd-9b36-6cc9a310fdd5@lucifer.local>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Mar 27, 2023 at 07:01:26PM +0200, Uladzislau Rezki (Sony) wrote:
> > Add vm_map_ram()/vm_unmap_ram() test case to our stress test-suite.
> >
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  lib/test_vmalloc.c | 41 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
> > index cd2bdba6d3ed..6633eda4cd4d 100644
> > --- a/lib/test_vmalloc.c
> > +++ b/lib/test_vmalloc.c
> > @@ -53,6 +53,7 @@ __param(int, run_test_mask, INT_MAX,
> >  		"\t\tid: 128,  name: pcpu_alloc_test\n"
> >  		"\t\tid: 256,  name: kvfree_rcu_1_arg_vmalloc_test\n"
> >  		"\t\tid: 512,  name: kvfree_rcu_2_arg_vmalloc_test\n"
> > +		"\t\tid: 1024, name: vm_map_ram_test\n"
> >  		/* Add a new test case description here. */
> >  );
> >
> > @@ -358,6 +359,45 @@ kvfree_rcu_2_arg_vmalloc_test(void)
> >  	return 0;
> >  }
> >
> > +static int
> > +vm_map_ram_test(void)
> > +{
> > +	unsigned int map_nr_pages;
> > +	unsigned char *v_ptr;
> > +	unsigned char *p_ptr;
> > +	struct page **pages;
> > +	struct page *page;
> > +	int i;
> > +
> > +	map_nr_pages = nr_pages > 0 ? nr_pages:1;
> > +	pages = kmalloc(map_nr_pages * sizeof(*page), GFP_KERNEL);
> > +	if (!pages)
> > +		return -1;
> > +
> > +	for (i = 0; i < map_nr_pages; i++) {
> > +		page = alloc_pages(GFP_KERNEL, 1);
> 
> Pedantry, but given I literally patched this pedantically the other day,
> this could be alloc_page(GFP_KERNEL) :)
> 
> > +		if (!page)
> > +			return -1;
> 
> We're leaking memory here right? Should jump to cleanup below.
> 
> > +
> > +		pages[i] = page;
> > +	}
> 
> 
> You should be able to replace this with something like:-
> 
> unsigned long nr_allocated;
> 
> ...
> 
> nr_allocated = alloc_pages_bulk_array(GFP_KERNEL, map_nr_pages, pages);
> if (nr_allocated != map_nr_pages)
> 	goto cleanup;
> 
> > +
> > +	/* Run the test loop. */
> > +	for (i = 0; i < test_loop_count; i++) {
> > +		v_ptr = vm_map_ram(pages, map_nr_pages, -1);
> 
> NIT: The -1 would be clearer as NUMA_NO_NODE
> 
> > +		*v_ptr = 'a';
> > +		vm_unmap_ram(v_ptr, map_nr_pages);
> > +	}
> > +
> 
> Reference to the above you'd add the cleanup label here:-
> 
> cleanup:
> 
> > +	for (i = 0; i < map_nr_pages; i++) {
> > +		p_ptr = page_address(pages[i]);
> > +		free_pages((unsigned long)p_ptr, 1);
> 
> Nit, can be free_page((unsigned long)p_ptr);
> 
Thank you. Will fix all comments, especially switching to the
alloc_page() new API :)

--
Uladzislau Rezki
