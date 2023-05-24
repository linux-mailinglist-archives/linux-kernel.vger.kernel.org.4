Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449D370FA4F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbjEXPfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbjEXPem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:34:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C1119C
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:34:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1964D63B86
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01583C43443;
        Wed, 24 May 2023 15:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684942444;
        bh=4QHC/7RI05eUKQuxt6iIEos2VGTGOenDuE0rDWP+VkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QpERaxuDyehcZp34bqas11QKRDScHrvuDKvxWWCqCmr17nIpk/cueE23t4irG3Gj9
         jbIb1YF2N4dUHPzSmDMvOw6tSVq7pCV9BmRY1ZLR88jRqsyt3MfTwgkkfyQTCE+gEN
         U7Le1buCQ8SegwzW++ObXTO2fcbMBfmWZbvfd2tky5unxwkXACCI+v//RuC0EPM++d
         zn/Mb5jYq2dv2zN1fWx+zsNBzsE1IYIJTei1cedtlWGZ6fF7Yh7Vj6Jkk77/IfiuK8
         W0phk87kHtb0GORlPVc7xwL+6eXpkOxKvnE32oJ/jXiMsdGXLx10Be9judm2WRLs6/
         /yfb90kE2jTVA==
Date:   Wed, 24 May 2023 18:33:44 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        20230519105321.333-1-ssawgyw@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tsahu@linux.ibm.com,
        ssawgyw@gmail.com
Subject: Re: [PATCH] memblock: update numa node of memblk reserved type
Message-ID: <20230524153344.GM4967@kernel.org>
References: <20230523115708.195597-1-wangkefeng.wang@huawei.com>
 <03cdccc3-8b8a-d972-bbad-d60966e59ca9@arm.com>
 <4eb83d16-58ed-9f09-4308-f0f786580257@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eb83d16-58ed-9f09-4308-f0f786580257@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 02:47:26PM +0800, Kefeng Wang wrote:
> 
> On 2023/5/24 12:59, Anshuman Khandual wrote:
> > 
> > On 5/23/23 17:27, Kefeng Wang wrote:
> > > The numa node of memblk reserved type is wrong, it could update
> > > according to the numa node information from memblk memory type,
> > > let's fix it.
> > 
> > Indeed it's wrong at present and can be verified from sysfs file
> > (/sys/kernel/debug/memblock/reserved) accessed in user space.
> 
> Yes, both memblock_dump() and sysfs show wrong value.
> > 
> > > 
> > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > > ---
> > >   mm/memblock.c | 25 +++++++++++++++++++++++++
> > >   1 file changed, 25 insertions(+)
> > > 
> > > diff --git a/mm/memblock.c b/mm/memblock.c
> > > index a50447d970ef..45a0781cda31 100644
> > > --- a/mm/memblock.c
> > > +++ b/mm/memblock.c
> > > @@ -1922,6 +1922,28 @@ phys_addr_t __init_memblock memblock_get_current_limit(void)
> > >   	return memblock.current_limit;
> > >   }
> > > +static void __init_memblock memblock_reserved_update_node(void)
> > > +{
> > > +	struct memblock_region *rgn;
> > > +	phys_addr_t base, end, size;
> > > +	int ret;
> > > +
> > > +	if (!IS_ENABLED(CONFIG_NUMA))
> > > +		return;
> > > +
> > > +	for_each_mem_region(rgn) {
> > > +		base = rgn->base;
> > > +		size = rgn->size;
> > > +		end = base + size - 1;
> > > +
> > > +		ret = memblock_set_node(base, size, &memblock.reserved,
> > > +					memblock_get_region_node(rgn));
> > > +		if (ret)
> > > +			pr_err("memblock: Failed to update reserved [%pa-%pa] node",
> > > +			       &base, &end);
> > > +	}
> > > +}
> > > +
> > >   static void __init_memblock memblock_dump(struct memblock_type *type)
> > >   {
> > >   	phys_addr_t base, end, size;
> > > @@ -1955,6 +1977,7 @@ static void __init_memblock __memblock_dump_all(void)
> > >   		&memblock.memory.total_size,
> > >   		&memblock.reserved.total_size);
> > > +	memblock_reserved_update_node();
> > 
> > __memblock_dump_all() gets called only when memblock_debug is enabled.
> > This helper should be called directly inside memblock_dump_all() right
> > at the beginning, regardless of memblock_debug.
> 
> This is my first though, but I found there are still many memblock_alloc and
> memblock_reserve after memblock_dump_all(), so I update it twice,
> 
> 1) __memblock_dump_all()
> 2) memblock_debug_show()
> 
> and without the above two interface, no one care about the reserved node
> info, so I put memblock_reserved_update_node into __memblock_dump_all().
 
We don't care about the reserved node info and __memblock_dump_all()
actually does not print node info for reserved regions unless somebody
explicitly sets the node id on a reserved memory.

So instead of updating reserved memory node info I'd rather avoid printing
it in debugfs.
 
> > >   #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> > > @@ -2196,6 +2219,8 @@ static int memblock_debug_show(struct seq_file *m, void *private)
> > >   	unsigned int count = ARRAY_SIZE(flagname);
> > >   	phys_addr_t end;
> > > +	memblock_reserved_update_node();
> > > +
> > 
> 
> > This is redundant, should be dropped. Reserved memblock ranges need not
> > be scanned, each time the sysfs file is accessed from user space.
> 
> Yes, it's better to move it into memblock_init_debugfs(),
> which only called once.
> 
> 
> 

-- 
Sincerely yours,
Mike.
