Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467BC6C6EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjCWRZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjCWRZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:25:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D80128D3A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:25:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F8E3626DD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 17:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4A4C433A8;
        Thu, 23 Mar 2023 17:25:24 +0000 (UTC)
Date:   Thu, 23 Mar 2023 17:25:21 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, horms@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        will@kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZByLga6FS5o8Syug@arm.com>
References: <20230306084124.300584-1-bhe@redhat.com>
 <ZBHbw3Vp4dxukGOD@arm.com>
 <ZBLlyGxGk33yrA+2@MiWiFi-R3L-srv>
 <ZBNTRBqqb74T3RMx@arm.com>
 <ZBSCeWtHvqc/iJZg@MiWiFi-R3L-srv>
 <ZBSr/kIIuxmC/INY@arm.com>
 <ZBhbqAOsHFj5cheI@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBhbqAOsHFj5cheI@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 09:12:08PM +0800, Baoquan He wrote:
> On 03/17/23 at 06:05pm, Catalin Marinas wrote:
> > On Fri, Mar 17, 2023 at 11:09:13PM +0800, Baoquan He wrote:
> > > In fact, what I want to achieve is we set CRASH_ADDR_LOW_MAX to 4G
> > > fixedly on arm64, just like what we do on x86_64. As for RPi4 platform,
> > > we leave it to crashkernel=size@offset syntax. Two reasons for this:
> > > 1) crashkernel is needed on enterprise platform, such as workstation or
> > > server. While RPi4 is obviously not the target. I contacted several RPi4
> > > players in Redhat and my friends, none of them ever played kdump
> > > testing. If they really have to, crashkernel=size@offset is enough for
> > > them to set.
> > 
> > I'd like crashkernel=size (without @offset) on RPi4 to still do the
> > right thing: a low allocation at least as we had until recently (or
> > high+low where high here is maybe above 1GB). IOW, no regression for
> > this crashkernel=size case. We can then change the explicit
> > crashkernel=x,high to mean only above 4GB irrespective of the platform
> > and crashkernel=x,low to be below arm64_dma_phys_limit.
> 
> Since crashkernel=,high and crashkernel=size fallback was added in arm64
> recently, with my understanding, you are suggesting:
> 
> on arm64:
> RPi4:
> crashkernel=size
> 0~1G: low memory (no regression introduced)

And, if not enough low memory, fall back to memory above 1GB (for RPi4;
it would be above 4GB for any other system).

> crashkernel=size,high
> 0~1G: low memory | 4G~top: high memory

Yes.

> Other normal system:
> crashkernel=size|crashkernel=size,high
> 0~4G: low memory | 4G~top: high memory

Yes.

IOW, specifying 'high' only forces the high allocation above 4GB instead
of arm64_dma_phys_limit, irrespective of the platform. If no 'high'
specified search_base remains CRASH_ADDR_LOW_MAX (1GB on RPi4, 4GB for
the rest).

> > > 2) with the fixed CRASH_ADDR_LOW_MAX as 4G, we can easily fix the
> > > problem of base page mapping for the whole linear mapping if crsahkernel=
> > > is set in kernel parameter shown in [1] at bottom. 
> > 
> > That's a different problem ;). I should re-read that thread, forgot most
> > of the details but I recall one of the counter arguments was that there
> > isn't a strong case to unmap the crashkernel reservation. Now, if we
> > place crashdump kernel image goes in the 'high' reservation, can we not
> > leave the 'low' reservation mapped? We don't really care about it as it
> > wouldn't have any meaningful code/data to be preserved. If the 'high'
> > one goes above 4G always, we don't depend on the arm64_dma_phys_limit.
> 
> Yes, this looks ideal. While it only works when crashkernel=,high case and
> it succeeds to reserve a memory region for the specified size of crashkernel
> high memory. At below, we have 4 cases of crashkernel= syntax:
> 
> crashkernel=size
> 1)first attempt:  low memory under arm64_dma_phys_limit
> 2)fallback:       finding memory above 4G

(2) should be 'finding memory above arm64_dma_phys_limit' to keep the
current behaviour for RPi4.

> crashkernel=size,high
> 3)first attempt:  finding memory above 4G
> 4)fallback:       low memory under arm64_dma_phys_limit

Yes.

> case 3) works with your suggestion. However, 1), 2), 4) all need to
> defer to bootmem_init(). With these cases and different handling,
> reserve_crashkernel() could be too complicated.

Ah, because of the fallback below arm64_dma_phys_limit as in (4), we
still can't move the full crashkernel reservation early. Well, we could
do it in two steps: (a) early attempt at crashkernel reservation above
4G if 'high' was specified and we avoid mapping it if successful and (b)
do the late crashkernel reservation below arm64_dma_phys_limit and skip
unmapping as being too late. This way most server-like platforms would
get a reservation above 4G, unmapped.

> I am wondering if we can cancel the protection of crashkernel memory
> region on arm64 for now. In earlier discussion, people questioned if the
> protection is necessary on arm64. After comparison, I would rather take
> away the protection method of crashkernel region since they try to
> protect in a chance in one million , while the base page mapping for the
> whole linear mapping is mitigating arm64 high end server always.

This works for me. We can add the protection later for addresses above
4GB only as mentioned above.

-- 
Catalin
