Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53784734D04
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjFSIFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjFSIFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:05:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057CBD3;
        Mon, 19 Jun 2023 01:04:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9596461574;
        Mon, 19 Jun 2023 08:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471BBC433C0;
        Mon, 19 Jun 2023 08:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687161882;
        bh=Jkv3EGzDEoQxhxTQKy7Jh7KLg0vAnB0lxbXiokDwKsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oFbvYOPv+cOU5MZ/vephP2zLkQnuJcgb/785+006D4R7v9jvYTpkJMWKrt/Stfanz
         74abWgx0R2eoRXXICOUzZpKQvxnwrCi01m2Kik8jxH4RH2q0QeiYKCP90rSpTl6nOr
         7lk//ALTYrwr58n+B8p2mVAfInm83HL92Uz1pYyA=
Date:   Mon, 19 Jun 2023 10:04:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     mawupeng <mawupeng1@huawei.com>
Cc:     david@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        richard.weiyang@linux.alibaba.com, mst@redhat.com,
        jasowang@redhat.com, pankaj.gupta.linux@gmail.com,
        mhocko@kernel.org, osalvador@suse.de
Subject: Re: [PATCH stable 5.10] mm/memory_hotplug: extend
 offline_and_remove_memory() to handle more than one memory block
Message-ID: <2023061936-mantra-pancreas-67d4@gregkh>
References: <cd9688dc-a716-3031-489e-a867df0d1ea2@huawei.com>
 <20230619065121.1720912-1-mawupeng1@huawei.com>
 <2023061926-monoxide-pastor-fa3b@gregkh>
 <a7d39606-cc85-42c3-c882-fa217954bf00@huawei.com>
 <cc1c2973-493a-6e21-048e-148ed55e653b@redhat.com>
 <a54be73e-840b-2091-b240-1417499f5738@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a54be73e-840b-2091-b240-1417499f5738@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 03:53:40PM +0800, mawupeng wrote:
> 
> 
> On 2023/6/19 15:41, David Hildenbrand wrote:
> > On 19.06.23 09:22, mawupeng wrote:
> >>
> >>
> >> On 2023/6/19 15:16, Greg KH wrote:
> >>> On Mon, Jun 19, 2023 at 02:51:21PM +0800, Wupeng Ma wrote:
> >>>> From: David Hildenbrand <david@redhat.com>
> >>>>
> >>>> commit 8dc4bb58a146655eb057247d7c9d19e73928715b upstream.
> >>>>
> >>>> virtio-mem soon wants to use offline_and_remove_memory() memory that
> >>>> exceeds a single Linux memory block (memory_block_size_bytes()). Let's
> >>>> remove that restriction.
> >>>>
> >>>> Let's remember the old state and try to restore that if anything goes
> >>>> wrong. While re-onlining can, in general, fail, it's highly unlikely to
> >>>> happen (usually only when a notifier fails to allocate memory, and these
> >>>> are rather rare).
> >>>>
> >>>> This will be used by virtio-mem to offline+remove memory ranges that are
> >>>> bigger than a single memory block - for example, with a device block
> >>>> size of 1 GiB (e.g., gigantic pages in the hypervisor) and a Linux memory
> >>>> block size of 128MB.
> >>>>
> >>>> While we could compress the state into 2 bit, using 8 bit is much
> >>>> easier.
> >>>>
> >>>> This handling is similar, but different to acpi_scan_try_to_offline():
> >>>>
> >>>> a) We don't try to offline twice. I am not sure if this CONFIG_MEMCG
> >>>> optimization is still relevant - it should only apply to ZONE_NORMAL
> >>>> (where we have no guarantees). If relevant, we can always add it.
> >>>>
> >>>> b) acpi_scan_try_to_offline() simply onlines all memory in case
> >>>> something goes wrong. It doesn't restore previous online type. Let's do
> >>>> that, so we won't overwrite what e.g., user space configured.
> >>>>
> >>>> Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> >>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >>>> Cc: Jason Wang <jasowang@redhat.com>
> >>>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> >>>> Cc: Michal Hocko <mhocko@kernel.org>
> >>>> Cc: Oscar Salvador <osalvador@suse.de>
> >>>> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> >>>> Cc: Andrew Morton <akpm@linux-foundation.org>
> >>>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>>> Link: https://lore.kernel.org/r/20201112133815.13332-28-david@redhat.com
> >>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >>>> Acked-by: Andrew Morton <akpm@linux-foundation.org>
> >>>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> >>>> ---
> >>>>   mm/memory_hotplug.c | 105 +++++++++++++++++++++++++++++++++++++-------
> >>>>   1 file changed, 89 insertions(+), 16 deletions(-)
> >>>>
> >>>
> >>> Why is this needed in 5.10.y?  Looks like a new feature to me, what
> >>> problem does it solve there?
> >>>
> >>> thanks,
> >>>
> >>> greg k-h
> >>
> >> It do introduce a new feature. But at the same time, it fix a memleak introduced
> >> in Commit 08b3acd7a68f ("mm/memory_hotplug: Introduce offline_and_remove_memory()"
> >>
> >> Our test find a memleak in init_memory_block, it is clear that mem is never
> >> been released due to wrong refcount. Commit 08b3acd7a68f ("mm/memory_hotplug:
> >> Introduce offline_and_remove_memory()") failed to dec refcount after
> >> find_memory_block which fail to dec refcount to zero in remove memory
> >> causing the leak.
> >>
> >> Commit 8dc4bb58a146 ("mm/memory_hotplug: extend offline_and_remove_memory()
> >> to handle more than one memory block") introduce walk_memory_blocks to
> >> replace find_memory_block which dec refcount by calling put_device after
> >> find_memory_block_by_id. In the way, the memleak is fixed.
> >>
> >> Here is the simplified calltrace:
> >>
> >>    kmem_cache_alloc_trace+0x664/0xed0
> >>    init_memory_block+0x8c/0x170
> >>    create_memory_block_devices+0xa4/0x150
> >>    add_memory_resource+0x188/0x530
> >>    __add_memory+0x78/0x104
> >>    add_memory+0x6c/0xb0
> >>
> > 
> > Makes sense to me. Of course, we could think about a simplified stable fix that only drops the ref.
> 
> Since the new patch does not introduce any kabi change, maybe we can merge this one？

stable kernels never care about "kabi", that is a made up thing that
some distros work to enforce only.  It has nothing to do with the
community.

And I will always prefer to take the real commit that is in Linus's tree
over any "custom" patch, as 90%+ of the time, custom changes are almost
always wrong.

thanks,

greg k-h
