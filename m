Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AD5734CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjFSHsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjFSHsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:48:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD109E54;
        Mon, 19 Jun 2023 00:48:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3836861541;
        Mon, 19 Jun 2023 07:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D75C433C8;
        Mon, 19 Jun 2023 07:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687160888;
        bh=+a/ZmnYkb2AqJDdYRdqv7LE893dBIQUn+SESlwMdA9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dxRKosA64xqAOaG0oGVnfzu8t36uWhDRhUHHvQcfSFFa0m/RWsyanMWADslj3ldLB
         e0rTVaWx6PxfaO/yj8G1bxvlRe1E17c9WJP7i77YRl6LCh2YymtBd8DVKh4RuzaPLS
         Gt+qL6BWBVE8NThOt2UZ14SGrT+0O0arYWYNYaHs=
Date:   Mon, 19 Jun 2023 09:48:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     mawupeng <mawupeng1@huawei.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        richard.weiyang@linux.alibaba.com, mst@redhat.com,
        jasowang@redhat.com, pankaj.gupta.linux@gmail.com,
        mhocko@kernel.org, osalvador@suse.de
Subject: Re: [PATCH stable 5.10] mm/memory_hotplug: extend
 offline_and_remove_memory() to handle more than one memory block
Message-ID: <2023061956-unlinked-fossil-ec6a@gregkh>
References: <cd9688dc-a716-3031-489e-a867df0d1ea2@huawei.com>
 <20230619065121.1720912-1-mawupeng1@huawei.com>
 <2023061926-monoxide-pastor-fa3b@gregkh>
 <a7d39606-cc85-42c3-c882-fa217954bf00@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7d39606-cc85-42c3-c882-fa217954bf00@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 03:22:20PM +0800, mawupeng wrote:
> 
> 
> On 2023/6/19 15:16, Greg KH wrote:
> > On Mon, Jun 19, 2023 at 02:51:21PM +0800, Wupeng Ma wrote:
> >> From: David Hildenbrand <david@redhat.com>
> >>
> >> commit 8dc4bb58a146655eb057247d7c9d19e73928715b upstream.
> >>
> >> virtio-mem soon wants to use offline_and_remove_memory() memory that
> >> exceeds a single Linux memory block (memory_block_size_bytes()). Let's
> >> remove that restriction.
> >>
> >> Let's remember the old state and try to restore that if anything goes
> >> wrong. While re-onlining can, in general, fail, it's highly unlikely to
> >> happen (usually only when a notifier fails to allocate memory, and these
> >> are rather rare).
> >>
> >> This will be used by virtio-mem to offline+remove memory ranges that are
> >> bigger than a single memory block - for example, with a device block
> >> size of 1 GiB (e.g., gigantic pages in the hypervisor) and a Linux memory
> >> block size of 128MB.
> >>
> >> While we could compress the state into 2 bit, using 8 bit is much
> >> easier.
> >>
> >> This handling is similar, but different to acpi_scan_try_to_offline():
> >>
> >> a) We don't try to offline twice. I am not sure if this CONFIG_MEMCG
> >> optimization is still relevant - it should only apply to ZONE_NORMAL
> >> (where we have no guarantees). If relevant, we can always add it.
> >>
> >> b) acpi_scan_try_to_offline() simply onlines all memory in case
> >> something goes wrong. It doesn't restore previous online type. Let's do
> >> that, so we won't overwrite what e.g., user space configured.
> >>
> >> Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> >> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >> Cc: Jason Wang <jasowang@redhat.com>
> >> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> >> Cc: Michal Hocko <mhocko@kernel.org>
> >> Cc: Oscar Salvador <osalvador@suse.de>
> >> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> Link: https://lore.kernel.org/r/20201112133815.13332-28-david@redhat.com
> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> Acked-by: Andrew Morton <akpm@linux-foundation.org>
> >> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> >> ---
> >>  mm/memory_hotplug.c | 105 +++++++++++++++++++++++++++++++++++++-------
> >>  1 file changed, 89 insertions(+), 16 deletions(-)
> >>
> > 
> > Why is this needed in 5.10.y?  Looks like a new feature to me, what
> > problem does it solve there?
> > 
> > thanks,
> > 
> > greg k-h
> 
> It do introduce a new feature. But at the same time, it fix a memleak introduced
> in Commit 08b3acd7a68f ("mm/memory_hotplug: Introduce offline_and_remove_memory()"
> 
> Our test find a memleak in init_memory_block, it is clear that mem is never
> been released due to wrong refcount. Commit 08b3acd7a68f ("mm/memory_hotplug:
> Introduce offline_and_remove_memory()") failed to dec refcount after
> find_memory_block which fail to dec refcount to zero in remove memory
> causing the leak.
> 
> Commit 8dc4bb58a146 ("mm/memory_hotplug: extend offline_and_remove_memory()
> to handle more than one memory block") introduce walk_memory_blocks to
> replace find_memory_block which dec refcount by calling put_device after
> find_memory_block_by_id. In the way, the memleak is fixed.
> 
> Here is the simplified calltrace:
> 
>   kmem_cache_alloc_trace+0x664/0xed0
>   init_memory_block+0x8c/0x170
>   create_memory_block_devices+0xa4/0x150
>   add_memory_resource+0x188/0x530
>   __add_memory+0x78/0x104
>   add_memory+0x6c/0xb0

Ok, thanks for the information, now queued up.

greg k-h
