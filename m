Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271B1734BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjFSGUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjFSGUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:20:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8FEB1;
        Sun, 18 Jun 2023 23:20:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D019610A6;
        Mon, 19 Jun 2023 06:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1099BC433C8;
        Mon, 19 Jun 2023 06:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687155647;
        bh=RyhHvsArpvvLmzXBr8ZG4BEMJyn2f/6MIZNEdgiReLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RIz+gKiuBkUDhFOF+rHvjkUuRJWcTLFL6hb/qWGm3P1WcGcZo2lsKb31qMXSo8UHX
         XLlj2jIyynRfN/AMByM1FbRumqhWRnHLGC+GAHGkBDhYNeTS4mOm8M0oD5K7ygWzSi
         BcxZ68M2FSXO7oW6n/V+aqGkOQFU0W4UzNKTm89A=
Date:   Mon, 19 Jun 2023 08:20:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     mawupeng <mawupeng1@huawei.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        richard.weiyang@linux.alibaba.com, mst@redhat.com,
        jasowang@redhat.com, pankaj.gupta.linux@gmail.com,
        mhocko@kernel.org, osalvador@suse.de
Subject: Re: [PATCH stable 5.10 1/1] mm/memory_hotplug: extend
 offline_and_remove_memory() to handle more than one memory block
Message-ID: <2023061927-parsnip-gauging-86e9@gregkh>
References: <20230614061900.3296725-1-mawupeng1@huawei.com>
 <20230614061900.3296725-2-mawupeng1@huawei.com>
 <2023061440-showing-happiest-937e@gregkh>
 <cd9688dc-a716-3031-489e-a867df0d1ea2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd9688dc-a716-3031-489e-a867df0d1ea2@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 02:45:58PM +0800, mawupeng wrote:
> 
> 
> On 2023/6/14 14:35, Greg KH wrote:
> > On Wed, Jun 14, 2023 at 02:19:00PM +0800, Wupeng Ma wrote:
> >> From: David Hildenbrand <david@redhat.com>
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
> >> ---
> >>  mm/memory_hotplug.c | 105 +++++++++++++++++++++++++++++++++++++-------
> >>  1 file changed, 89 insertions(+), 16 deletions(-)
> > 
> > As you forwarded this patch on, you too need to sign-off on it.
> 
> Thanks for reminding me.
> 
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> 
> > 
> > Also, what is the git id of the commit in Linus's tree?
> 
> Sorry, here is the commit in Linus's tree.
> 
> commit 8dc4bb58a146655eb057247d7c9d19e73928715b upstream.

Please resend the change with both of these things fixed up, so I don't
have to manually do it :)

thanks,

greg k-h
