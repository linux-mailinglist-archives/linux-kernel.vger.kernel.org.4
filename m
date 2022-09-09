Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF405B3699
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiIILnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiIILnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:43:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC02B102D6B;
        Fri,  9 Sep 2022 04:43:30 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MPDcx4YM7z688y7;
        Fri,  9 Sep 2022 19:42:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 13:43:28 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 9 Sep
 2022 12:43:27 +0100
Date:   Fri, 9 Sep 2022 12:43:26 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>, <x86@kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>, <bp@alien8.de>, <dave.jiang@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <a.manzanares@samsung.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] memregion: Add arch_flush_memregion() interface
Message-ID: <20220909124326.00002c85@huawei.com>
In-Reply-To: <631a7932c6eb5_166f2945d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220829212918.4039240-1-dave@stgolabs.net>
        <20220907153016.f7cd4f42a337fedae8319f28@linux-foundation.org>
        <631940536d040_2736529437@dwillia2-xfh.jf.intel.com.notmuch>
        <20220908141319.00000f01@huawei.com>
        <631a7206afc2_166f29413@dwillia2-xfh.jf.intel.com.notmuch>
        <20220908160035.f030e3e533a996eadc04dbd5@linux-foundation.org>
        <631a7932c6eb5_166f2945d@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2022 16:22:26 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Andrew Morton wrote:
> > On Thu, 8 Sep 2022 15:51:50 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> > > Jonathan Cameron wrote:  
> > > > On Wed, 7 Sep 2022 18:07:31 -0700
> > > > Dan Williams <dan.j.williams@intel.com> wrote:
> > > >   
> > > > > Andrew Morton wrote:  
> > > > > > I really dislike the term "flush".  Sometimes it means writeback,
> > > > > > sometimes it means invalidate.  Perhaps at other times it means
> > > > > > both.
> > > > > > 
> > > > > > Can we please be very clear in comments and changelogs about exactly
> > > > > > what this "flush" does.   With bonus points for being more specific in the 
> > > > > > function naming?
> > > > > >     
> > > > > 
> > > > > That's a good point, "flush" has been cargo-culted along in Linux's
> > > > > cache management APIs to mean write-back-and-invalidate. In this case I
> > > > > think this API is purely about invalidate. It just so happens that x86
> > > > > has not historically had a global invalidate instruction readily
> > > > > available which leads to the overuse of wbinvd.
> > > > > 
> > > > > It would be nice to make clear that this API is purely about
> > > > > invalidating any data cached for a physical address impacted by address
> > > > > space management event (secure erase / new region provision). Write-back
> > > > > is an unnecessary side-effect.
> > > > > 
> > > > > So how about:
> > > > > 
> > > > > s/arch_flush_memregion/cpu_cache_invalidate_memregion/?  
> > > > 
> > > > Want to indicate it 'might' write back perhaps?
> > > > So could be invalidate or clean and invalidate (using arm ARM terms just to add
> > > > to the confusion ;)
> > > > 
> > > > Feels like there will be potential race conditions where that matters as we might
> > > > force stale data to be written back.
> > > > 
> > > > Perhaps a comment is enough for that. Anyone have the "famous last words" feeling?  
> > > 
> > > Is "invalidate" not clear that write-back is optional? Maybe not.  
> > 
> > Yes, I'd say that "invalidate" means "dirty stuff may of may not have
> > been written back".  Ditto for invalidate_inode_pages2().
> >   
> > > Also, I realized that we tried to include the address range to allow for
> > > the possibility of flushing by virtual address range, but that
> > > overcomplicates the use. I.e. if someone issue secure erase and the
> > > region association is not established does that mean that mean that the
> > > cache invalidation is not needed? It could be the case that someone
> > > disables a device, does the secure erase, and then reattaches to the
> > > same region. The cache invalidation is needed, but at the time of the
> > > secure erase the HPA was unknown.
> > > 
> > > All this to say that I feel the bikeshedding will need to continue until
> > > morale improves.
> > > 
> > > I notice that the DMA API uses 'sync' to indicate, "make this memory
> > > consistent/coherent for the CPU or the device", so how about an API like
> > > 
> > >     memregion_sync_for_cpu(int res_desc)
> > > 
> > > ...where the @res_desc would be IORES_DESC_CXL for all CXL and
> > > IORES_DESC_PERSISTENT_MEMORY for the current nvdimm use case.  
> > 
> > "sync" is another of my pet peeves ;) In filesystem land, at least. 
> > Does it mean "start writeback and return" or does it mean "start
> > writeback, wait for its completion then return".    
> 
> Ok, no "sync" :).
> 
> /**
>  * cpu_cache_invalidate_memregion - drop any CPU cached data for
>  *     memregions described by @res_des
>  * @res_desc: one of the IORES_DESC_* types
>  *
>  * Perform cache maintenance after a memory event / operation that
>  * changes the contents of physical memory in a cache-incoherent manner.
>  * For example, memory-device secure erase, or provisioning new CXL
>  * regions. This routine may or may not write back any dirty contents
>  * while performing the invalidation.
>  *
>  * Returns 0 on success or negative error code on a failure to perform
>  * the cache maintenance.
>  */
> int cpu_cache_invalidate_memregion(int res_desc)

lgtm

> 
> ??

