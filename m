Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59876BCB58
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjCPJsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCPJsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:48:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344B61E29E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678960081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cCBizHQpU3IM0ItpwDXysJM/nTAknTviGe9axTR6EEQ=;
        b=MA/B56p49zp79Ly/2G71cpcOyuDo+TOeP84unpDs7X5wLSN/drTA8cBsPj352KVtHCfm1N
        xP1OymWA8Mp1PmaZcyWMFucv19NktFCqX5mEA/O4WB8hSgKzatxOvp6aBNVJVatur7t0jb
        v2dzqaPaZesiEaMsMZlru5pwNXMKgcM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-NhSEsylHOHSsp0jMJ4qYNA-1; Thu, 16 Mar 2023 05:47:57 -0400
X-MC-Unique: NhSEsylHOHSsp0jMJ4qYNA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CC90185A7B8;
        Thu, 16 Mar 2023 09:47:57 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 31E171121315;
        Thu, 16 Mar 2023 09:47:55 +0000 (UTC)
Date:   Thu, 16 Mar 2023 17:47:52 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, horms@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        will@kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZBLlyGxGk33yrA+2@MiWiFi-R3L-srv>
References: <20230306084124.300584-1-bhe@redhat.com>
 <ZBHbw3Vp4dxukGOD@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBHbw3Vp4dxukGOD@arm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 03/15/23 at 02:52pm, Catalin Marinas wrote:
> On Mon, Mar 06, 2023 at 04:41:24PM +0800, Baoquan He wrote:
> > On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> > suitable memory region top down. If the 'xM' of crashkernel high memory
> > is reserved from high memory successfully, it will try to reserve
> > crashkernel low memory later accoringly. Otherwise, it will try to search
> > low memory area for the 'xM' suitable region. Please see the details in
> > Documentation/admin-guide/kernel-parameters.txt.
> > 
> > While we observed an unexpected case where a reserved region crosses the
> > high and low meomry boundary. E.g on a system with 4G as low memory end,
> > user added the kernel parameters like: 'crashkernel=512M,high', it could
> > finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
> > The crashkernel high region crossing low and high memory boudary will bring
> > issues:
> [...]
> > Note: On arm64, the high and low memory boudary could be 1G if it's RPi4
> > system, or 4G if other normal systems.

Thanks for looking into this.

> I'm mostly ok with the reworking but I'm not sure about the non-fixed
> low memory boundary. As I mentioned on v2, the user doesn't (need to)
> know about the ZONE_DMA limit on a specific platform, that's supposed to
> be fairly transparent. So on RPi4, specifying 'high' still allows
> allocation below 4G which some users may treat as 'low'. The
> kernel-parameters.txt doc also only talks about the 4G limit.

With my understanding and the current arm64 code, the boundary of 'high'
and 'low' is truly different on different platform. E.g on RPi4, its
device does need memory below 1G to initialize, otherwise it will fail
kernel bootup. I ever asked people to help test this on RPi4, with
crashkernel reservation all above 1G, kdump kernel can't boot up.

And now, the upper boundary of low memory has been decided by macro
CRASH_ADDR_LOW_MAX. It says how big the low memory end is. That menas
on RPi4, it's 1G, on other normal systems, it's 4G.

#define CRASH_ADDR_LOW_MAX              arm64_dma_phys_limit

As for kernel-parameters.txt, the 'crashkernel=size[KMG],high' part need
be rephrased to reflect the fact on arm64.

So I made this patch based on the facts and undertanding. However, I
like the idea that taking 4G as the fixed boudary of low and high memory
on arm64. Please see the reply at bottom.

> 
> > +		/*
> > +		 * For crashkernel=size[KMG], if the first attempt was for
> > +		 * low memory, fall back to high memory, the minimum required
> > +		 * low memory will be reserved later.
> > +		 */
> > +		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
> >  			crash_max = CRASH_ADDR_HIGH_MAX;
> > +			search_base = CRASH_ADDR_LOW_MAX;
> >  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> >  			goto retry;
> >  		}
> 
> So I'm more tempted to set the search_base to 4G here rather than
> CRASH_ADDR_LOW_MAX. The crashkernel=x,high option on a RPi4 with all
> memory below 4G will fall back to low allocation. But RPi4 is the odd
> one out, so I think we can live with this.

I totally agree with you that we should take 4G as the fixed boundary of
low and high memory because kdump is aimed at workstation and server
platform. We can leave RPi4 to use crashkernel=size[KMG][@offset[KMG]]
to specify a region if people have to use.

[PATCH 0/2] arm64, kdump: enforce to take 4G as the crashkernel low memory end
https://lore.kernel.org/all/20220828005545.94389-1-bhe@redhat.com/T/#u

Now I am wondering if we should change CRASH_ADDR_LOW_MAX to 4G directly
since we decide to take 4G as the low memory limit when doing 'high'
reserving or falling back. This is just like what we have been doing in
x86_64. Not sure if I follow you correctly.

===========================x86_64 low memory end for reference=======
On x86_64, we fixedly have DMA zone at 0~16M, and DMA32 zone at
16M~4G, still we have boundary of low memory and high memory at 4G.
However, it's not decided in the first place. Initially, we disregarded
devices which only address 24bit range, namely 16M, set the
CRASH_ADDR_LOW_MAX as 896M because that is compatible with the 32bit
kernel which could be running on the x86_64 bare metal machine. Later,
we realized 32bit x86 support for kdump is not needed any more because
of the rare deployment in server. It was done in below commit. 

commit 9ca5c8e632ce8f144ec6d00da2dc5e16b41d593c
Author: Dave Young <dyoung@redhat.com>
Date:   Sun Apr 21 11:50:59 2019 +0800

    x86/kdump: Have crashkernel=X reserve under 4G by default

arch/x86/kernel/setup.c:
-------------------------
#ifdef CONFIG_X86_32
# define CRASH_ADDR_LOW_MAX     SZ_512M
# define CRASH_ADDR_HIGH_MAX    SZ_512M
#else
# define CRASH_ADDR_LOW_MAX     SZ_4G
# define CRASH_ADDR_HIGH_MAX    SZ_64T
#endif

