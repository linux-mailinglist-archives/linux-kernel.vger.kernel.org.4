Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7585B8515
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiINJfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiINJfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:35:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3D8AE4A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 02:32:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F67161AC6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81BCC433C1;
        Wed, 14 Sep 2022 09:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663147929;
        bh=JxlkMJhrFSFFd6GtkvF2gyR+Kxu6WhW64tS/6rm9TXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P4VT86VowfQcbzvjW0VcEym36mb1+PciD6o1k2Ls4HXI16wpqJUhc88Y9UO21msye
         iK2VrEdALff3PJtBFLmKtHOT21Rv+nhUeksgnAh5WK4MUB6zpAa5LIIpZ8wJfIxzYv
         s87uj3ntbf0XzWLqV0srU0WXMN7HxEQlvfNmkdzaGwXdrs5kUej1MrPlcGuWjJvW+B
         SwZ9yXZSbP8xhbJ+MahdrMxL7/gzksicAScx6D0kVcSDIwEWDTRXkOq5OzgUj6kyOb
         Y1NEyatobrXNErnt13KtwctAj/yJNvJYoXFJyKvXnBxWLhMH4Cm+44cUDa0/9x+kop
         eGqJPEhGG6tkg==
Date:   Wed, 14 Sep 2022 10:32:00 +0100
From:   Mike Rapoport <rppt@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Ash Logan <ash@heyquark.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "j.ne@posteo.net" <j.ne@posteo.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: Fragmented physical memory on powerpc/32
Message-ID: <YyGfkDKgeW7/nNlr@kernel.org>
References: <20220609222420.ponpoodiqmaqtwht@pali>
 <20220808184034.lskqrk6z3gb5q76r@pali>
 <219cda7b-da4b-7a5a-9809-0878e0fc02ba@csgroup.eu>
 <20220908153511.57ceunyusziqfcav@pali>
 <20220908201701.sd3zqn5hfixmjvhh@pali>
 <9fbc5338-5e10-032a-8f55-e080bd93f74b@csgroup.eu>
 <Yx9GpV1XT8r2a++R@kernel.org>
 <20220912211623.djb7fckgknyfmof7@pali>
 <1c95875c-29f8-68b7-e480-fed8614f3037@csgroup.eu>
 <4f540391-37dc-8e22-be0a-74543082504d@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f540391-37dc-8e22-be0a-74543082504d@csgroup.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 02:36:13PM +0200, Christophe Leroy wrote:
> 
> 
> Le 13/09/2022 à 08:11, Christophe Leroy a écrit :
> > 
> > 
> > Le 12/09/2022 à 23:16, Pali Rohár a écrit :
> > > > 
> > > > My guess would be that something went wrong in the linear map
> > > > setup, but it
> > > > won't hurt running with "memblock=debug" added to the kernel
> > > > command line
> > > > to see if there is anything suspicious there.
> > > 
> > > Here is boot log on serial console with memblock=debug command line:
> > > 
> > ...
> > > 
> > > Do you need something more for debug?
> > 
> > Can you send me the 'vmlinux' used to generate the above Oops so that I
> > can see exactly where we are in function mem_init().
> > 
> > And could you also try without CONFIG_HIGHMEM just in case.
> > 
> 
> I looked at the vmlinux you sent me, the problem is in the loop for highmem
> in mem_init(). It crashes in the call to free_highmem_page()
> 
> #ifdef CONFIG_HIGHMEM
> 	{
> 		unsigned long pfn, highmem_mapnr;
> 
> 		highmem_mapnr = lowmem_end_addr >> PAGE_SHIFT;
> 		for (pfn = highmem_mapnr; pfn < max_mapnr; ++pfn) {
> 			phys_addr_t paddr = (phys_addr_t)pfn << PAGE_SHIFT;
> 			struct page *page = pfn_to_page(pfn);
> 			if (!memblock_is_reserved(paddr))
> 				free_highmem_page(page);
> 		}
> 	}
> #endif /* CONFIG_HIGHMEM */
> 
> 
> As far as I can see in the memblock debug lines, the holes don't seem to be
> marked as reserved by memblock. So it is above valid ? Other architectures
> seem to do differently.
> 
> Can you try by replacing !memblock_is_reserved(paddr) by
> memblock_is_memory(paddr) ?

The holes should not be marked as reserved, we just need to loop over the
memory ranges rather than over pfns. Then the holes will be taken into
account.

I believe arm and xtensa got this right:

(from arch/arm/mm/init.c)

static void __init free_highpages(void)
{
#ifdef CONFIG_HIGHMEM
	unsigned long max_low = max_low_pfn;
	phys_addr_t range_start, range_end;
	u64 i;

	/* set highmem page free */
	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
				&range_start, &range_end, NULL) {
		unsigned long start = PFN_UP(range_start);
		unsigned long end = PFN_DOWN(range_end);

		/* Ignore complete lowmem entries */
		if (end <= max_low)
			continue;

		/* Truncate partial highmem entries */
		if (start < max_low)
			start = max_low;

		for (; start < end; start++)
			free_highmem_page(pfn_to_page(start));
	}
#endif
}

 
> Thanks
> Christophe
> 

-- 
Sincerely yours,
Mike.
