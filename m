Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19516C8066
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjCXOyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjCXOyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:54:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD372D5F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679669609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uVxo6T8zn6ArXhplZHuhgmR3CWjjWZDjou2/HtzSxk0=;
        b=D6J/IgjRlNAbbAafTuTJscdB7tA8Yct9QpGC2JDUDVG3UU0b7HrNccAfPNsfcWL0zlSZeL
        CFDUB/1jPUN9dwebQfu2OuXUvoQ5Lnax/y11qhcs6X8BM2+luQrNqow4rLIYQJ7SEEr09O
        y9HQcrw6IwC3bYTNIiAsnhTmPp96lak=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-vzeQFkzOOqWYN1Ei5YpV6g-1; Fri, 24 Mar 2023 10:53:23 -0400
X-MC-Unique: vzeQFkzOOqWYN1Ei5YpV6g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 339AA85A5B1;
        Fri, 24 Mar 2023 14:53:22 +0000 (UTC)
Received: from localhost (ovpn-12-55.pek2.redhat.com [10.72.12.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D540540C83AC;
        Fri, 24 Mar 2023 14:53:16 +0000 (UTC)
Date:   Fri, 24 Mar 2023 22:53:12 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, horms@kernel.org,
        John.p.donnelly@oracle.com, will@kernel.org,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZB25WN02AHOS8RTT@MiWiFi-R3L-srv>
References: <20230306084124.300584-1-bhe@redhat.com>
 <ZBHbw3Vp4dxukGOD@arm.com>
 <ZBLlyGxGk33yrA+2@MiWiFi-R3L-srv>
 <ZBNTRBqqb74T3RMx@arm.com>
 <ZBSCeWtHvqc/iJZg@MiWiFi-R3L-srv>
 <ZBSr/kIIuxmC/INY@arm.com>
 <ZBhbqAOsHFj5cheI@MiWiFi-R3L-srv>
 <ZByLga6FS5o8Syug@arm.com>
 <4d4ecdd6-9716-570d-5595-e47bfbb58cdf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d4ecdd6-9716-570d-5595-e47bfbb58cdf@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leizhen,

On 03/24/23 at 10:47am, Leizhen (ThunderTown) wrote:
...... 
> >>>> 2) with the fixed CRASH_ADDR_LOW_MAX as 4G, we can easily fix the
> >>>> problem of base page mapping for the whole linear mapping if crsahkernel=
> >>>> is set in kernel parameter shown in [1] at bottom. 
> >>>
> >>> That's a different problem ;). I should re-read that thread, forgot most
> >>> of the details but I recall one of the counter arguments was that there
> >>> isn't a strong case to unmap the crashkernel reservation. Now, if we
> >>> place crashdump kernel image goes in the 'high' reservation, can we not
> >>> leave the 'low' reservation mapped? We don't really care about it as it
> >>> wouldn't have any meaningful code/data to be preserved. If the 'high'
> >>> one goes above 4G always, we don't depend on the arm64_dma_phys_limit.
> >>
> >> Yes, this looks ideal. While it only works when crashkernel=,high case and
> >> it succeeds to reserve a memory region for the specified size of crashkernel
> >> high memory. At below, we have 4 cases of crashkernel= syntax:
> >>
> >> crashkernel=size
> >> 1)first attempt:  low memory under arm64_dma_phys_limit
> >> 2)fallback:       finding memory above 4G
> > 
> > (2) should be 'finding memory above arm64_dma_phys_limit' to keep the
> > current behaviour for RPi4.
> > 
> >> crashkernel=size,high
> >> 3)first attempt:  finding memory above 4G
> >> 4)fallback:       low memory under arm64_dma_phys_limit
> > 
> > Yes.
> > 
> >> case 3) works with your suggestion. However, 1), 2), 4) all need to
> >> defer to bootmem_init(). With these cases and different handling,
> >> reserve_crashkernel() could be too complicated.
> > 
> > Ah, because of the fallback below arm64_dma_phys_limit as in (4), we
> > still can't move the full crashkernel reservation early. Well, we could
> > do it in two steps: (a) early attempt at crashkernel reservation above
> > 4G if 'high' was specified and we avoid mapping it if successful and (b)
> > do the late crashkernel reservation below arm64_dma_phys_limit and skip
> > unmapping as being too late. This way most server-like platforms would
> > get a reservation above 4G, unmapped.
> > 
> >> I am wondering if we can cancel the protection of crashkernel memory
> >> region on arm64 for now. In earlier discussion, people questioned if the
> >> protection is necessary on arm64. After comparison, I would rather take
> >> away the protection method of crashkernel region since they try to
> >> protect in a chance in one million , while the base page mapping for the
> >> whole linear mapping is mitigating arm64 high end server always.
> > 
> > This works for me. We can add the protection later for addresses above
> > 4GB only as mentioned above.
> 
> Recently, I've also been rethinking the performance issues when kdump is
> enabled. I have a new idea. For crashkernel=X, we can temporarily search
> for free memory from the low address to the high address. As below:
> 
> save_bottom_up = memblock_bottom_up();
> if (!high)
> 	memblock_set_bottom_up(true);
> crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN, crash_base, crash_max);
> memblock_set_bottom_up(save_bottom_up);
> 
> The final code change should be small, and I'll try it today.

I have sent a patchset to remove the crashkernel region protection code
as per Catalin's confirmation. I personally like the code conciseness w/o
protection because kinds of crahskernel reservation has been complex,
the situation on arm64 will makes it worse if we try to keep the
protection and fix the performance issue. While I am glad to see any
attempt to achieve the two goals if it's satisfactory.

