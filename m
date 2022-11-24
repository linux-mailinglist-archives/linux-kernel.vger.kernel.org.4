Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE69637970
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiKXM5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKXM5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:57:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9AF6314F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669294561;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=im+KQDw98I7aQbweUIZ/s+siMDXWPzriAvUlGj+1GaQ=;
        b=LSd4GV4788pcgxWhKPbUnaRlB/u+KLdBhfZnBb0gGiy3iqL2yLMrnHzvt9TyRTG6hDVkO3
        lQzsKzFuCaPAOAStUT5JnLCQ0/nUEC+/FBzBW1esf2KcBw72f8EMRirH7Std/jhzNZpGxP
        g1KcqOjL9/rHSGLyQT2TgqOJ2xgDnBQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-KicfeEEVNyKSU146mt5iTw-1; Thu, 24 Nov 2022 07:55:57 -0500
X-MC-Unique: KicfeEEVNyKSU146mt5iTw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DC78101A52A;
        Thu, 24 Nov 2022 12:55:56 +0000 (UTC)
Received: from [10.64.54.95] (vpn2-54-95.bne.redhat.com [10.64.54.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42214C15BA5;
        Thu, 24 Nov 2022 12:55:41 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v2] mm: migrate: Fix THP's mapcount on isolation
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        william.kucharski@oracle.com, ziy@nvidia.com,
        kirill.shutemov@linux.intel.com, zhenyzha@redhat.com,
        apopple@nvidia.com, hughd@google.com, willy@infradead.org,
        shan.gavin@gmail.com
References: <20221124095523.31061-1-gshan@redhat.com>
 <3c584ce6-dc8c-e0e4-c78f-b59dfff1fc13@redhat.com>
 <22407f18-0406-6ede-ef1e-592f03d3699e@redhat.com>
 <31bda0ab-a185-340d-b96b-b1cfed7c3910@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <da854e1c-c876-b2f3-a2cb-56664da541bf@redhat.com>
Date:   Thu, 24 Nov 2022 20:55:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <31bda0ab-a185-340d-b96b-b1cfed7c3910@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------D09D3DE0D6C0E967E2ED20DE"
Content-Language: en-US
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D09D3DE0D6C0E967E2ED20DE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/22 6:43 PM, David Hildenbrand wrote:
> On 24.11.22 11:21, Gavin Shan wrote:
>> On 11/24/22 6:09 PM, David Hildenbrand wrote:
>>> On 24.11.22 10:55, Gavin Shan wrote:
>>>> The issue is reported when removing memory through virtio_mem device.
>>>> The transparent huge page, experienced copy-on-write fault, is wrongly
>>>> regarded as pinned. The transparent huge page is escaped from being
>>>> isolated in isolate_migratepages_block(). The transparent huge page
>>>> can't be migrated and the corresponding memory block can't be put
>>>> into offline state.
>>>>
>>>> Fix it by replacing page_mapcount() with total_mapcount(). With this,
>>>> the transparent huge page can be isolated and migrated, and the memory
>>>> block can be put into offline state. Besides, The page's refcount is
>>>> increased a bit earlier to avoid the page is released when the check
>>>> is executed.
>>>
>>> Did you look into handling pages that are in the swapcache case as well?
>>>
>>> See is_refcount_suitable() in mm/khugepaged.c.
>>>
>>> Should be easy to reproduce, let me know if you need inspiration.
>>>
>>
>> Nope, I didn't look into the case. Please elaborate the details so that
>> I can reproduce it firstly.
> 
> 
> A simple reproducer would be (on a system with ordinary swap (not zram))
> 
> 1) mmap a region (MAP_ANON|MAP_PRIVATE) that can hold a THP
> 
> 2) Enable THP for that region (MADV_HUGEPAGE)
> 
> 3) Populate a THP (e.g., write access)
> 
> 4) PTE-map the THP, for example, using MADV_FREE on the last subpage
> 
> 5) Trigger swapout of the THP, for example, using MADV_PAGEOUT
> 
> 6) Read-access to some subpages to fault them in from the swapcache
> 
> 
> Now you'd have a THP, which
> 
> 1) Is partially PTE-mapped into the page table
> 2) Is in the swapcache (each subpage should have one reference from the swapache)
> 
> 
> Now we could test, if alloc_contig_range() will still succeed (e.g., using virtio-mem).
> 

Thanks for the details. Step (4) and (5) can be actually combined. To swap part of
the THP (e.g. one sub-page) will force the THP to be split.

I followed your steps in the attached program, there is no issue to do memory hot-remove
through virtio-mem with or without this patch.

    # numactl -p 1 testsuite mm swap -k
    Any key to split THP
    Any key to swap sub-pages
    Any key to read the swapped sub-pages
        Page[000]: 0xffffffffffffffff
        Page[001]: 0xffffffffffffffff
          :
        Page[255]: 0xffffffffffffffff
    Any key to exit                                // hold here and the program doesn't exit

    (qemu) qom-set vm1 requested-size 0
    [  356.005396] virtio_mem virtio1: plugged size: 0x40000000
    [  356.005996] virtio_mem virtio1: requested size: 0x0
    [  356.350299] Fallback order for Node 0: 0 1
    [  356.350810] Fallback order for Node 1: 1 0
    [  356.351260] Built 2 zonelists, mobility grouping on.  Total pages: 491343
    [  356.351998] Policy zone: DMA

Thanks,
Gavin

--------------D09D3DE0D6C0E967E2ED20DE
Content-Type: text/x-csrc; charset=UTF-8;
 name="swap.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="swap.c"

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <errno.h>

#include "inc/testsuite.h"

struct swap_struct {
	int		page_size;

	int		fd;
	int		flags;
	void		*buf;
	unsigned long 	len;

	int		key_break;
};

#define SWAP_DEFAULT_SIZE	0x200000	/* 2MB */
#define SWAP_PAGE_TO_SPLIT	511
#define SWAP_PAGE_TO_SWAP	1
#define SWAP_PAGE_TO_SWAP_NUM	256

#ifndef MADV_PAGEOUT
#define MADV_PAGEOUT		21
#endif


static void usage(void)
{
	fprintf(stdout, "testsuite mm swap -l <size> -k\n");
	fprintf(stdout, "\n");
	fprintf(stdout, "-l: Length of memory to be mapped\n");
	fprintf(stdout, "-w: Length of memory to be copied-on-write\n");
	fprintf(stdout, "-k: Stop at various stages\n");
	fprintf(stdout, "\n");
}

static int swap_init_data(struct swap_struct *m)
{
	m->page_size	= getpagesize();

	m->fd		= -1;
	m->flags	= (MAP_PRIVATE | MAP_ANONYMOUS);
	m->len		= SWAP_DEFAULT_SIZE;
	m->key_break	= 0;

	return 0;
}

static int swap_handler(int argc, char **argv)
{
	struct swap_struct m;
	unsigned long *pval;
	int i, opt, ret;

	ret = swap_init_data(&m);
	if (ret)
		return ret;

	while ((opt = getopt(argc, argv, "l:w:kh")) != -1) {
		switch (opt) {
		case 'l':
			m.len = util_memory_parse_size(optarg);
			if (m.len <= SWAP_DEFAULT_SIZE) {
				fprintf(stderr, "%s: length 0x%lx less than 0x%x\n",
					__func__, m.len, SWAP_DEFAULT_SIZE);
				return -1;
			}

			break;
		case 'k':
			m.key_break = 1;
			break;
		case 'h':
			usage();
			return 0;
		}
	}

	/*
	 * Setup the area. The area should be backed up with huge pages
	 * if it suits. Write to the area to ensure the area is populted
	 * completely.
	 */
	m.buf = mmap(NULL, m.len, PROT_READ | PROT_WRITE, m.flags, m.fd, 0);
	if (m.buf == (void *)-1) {
		fprintf(stderr, "Unable do mmap()\n");
		goto out;
	}

        memset(m.buf, 0xff, m.len);

	/* Force to split the huge page */
	util_misc_key_press(m.key_break, "  ", "Any key to split THP");
	ret = madvise(m.buf + SWAP_PAGE_TO_SPLIT * m.page_size,
		      m.page_size, MADV_FREE);
	if (ret) {
		fprintf(stderr, "Error %d to split THP\n", ret); 
		goto out;
	}

	/* Swap one sub-page */
	util_misc_key_press(m.key_break, "  ", "Any key to swap sub-pages");
	ret = madvise(m.buf + SWAP_PAGE_TO_SWAP * m.page_size,
		      SWAP_PAGE_TO_SWAP_NUM * m.page_size,
		      MADV_PAGEOUT);
	if (ret) {
		fprintf(stderr, "Error %d to swap one sub-page\n", ret);
		goto out;
	}

	/* Read the swapped sub-page */
	util_misc_key_press(m.key_break, "  ", "Any key to read the swapped sub-pages");
	for (i = 0; i < SWAP_PAGE_TO_SWAP_NUM; i++) {
		pval = (unsigned long *)(m.buf + (SWAP_PAGE_TO_SWAP + i) * m.page_size);
		fprintf(stdout, "  Page[%03d]: 0x%016lx\n", i, *pval);
	}

	/* Exit */
	util_misc_key_press(m.key_break, "  ", "Any key to exit");

out:
	if (m.buf != (void *)-1)
		munmap(m.buf, m.len);
	if (m.fd > 0)
		close(m.fd);

	return 0;
}

static struct command swap_command = {
	.name		= "swap",
	.handler	= swap_handler,
	.children	= LIST_HEAD_INIT(swap_command.children),
	.link		= LIST_HEAD_INIT(swap_command.link),
};

int mm_swap_init(void)
{
	return command_add(&mm_command, &swap_command);
}


--------------D09D3DE0D6C0E967E2ED20DE--

