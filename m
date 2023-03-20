Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28396C12DB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjCTNNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCTNNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:13:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F1522DE1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679317939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eRWuod9s//hIfJQGvOqq9tx2DfKSIyGg3ek1omM5PA0=;
        b=NoHO7+WfvWulGg9t/eFlBSTzAoQbK1nTsNSHsjuQLsDruUJZzsbo47biU7+3vylOD3ds3T
        hXj1joBpRZuaAmbS9C8KTjUMUFhAtt3268fWNTKVwSPxmrfKkJ9rhcCOHt+3sUdFttnOII
        eUeYvS2iq2OEtLEgmF2Fv1tHS6VbM14=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-M2VObNRIODOBGZRDq7nk-w-1; Mon, 20 Mar 2023 09:12:14 -0400
X-MC-Unique: M2VObNRIODOBGZRDq7nk-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3501596DC81;
        Mon, 20 Mar 2023 13:12:14 +0000 (UTC)
Received: from localhost (ovpn-13-195.pek2.redhat.com [10.72.13.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D21EC2027047;
        Mon, 20 Mar 2023 13:12:12 +0000 (UTC)
Date:   Mon, 20 Mar 2023 21:12:08 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, horms@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        will@kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZBhbqAOsHFj5cheI@MiWiFi-R3L-srv>
References: <20230306084124.300584-1-bhe@redhat.com>
 <ZBHbw3Vp4dxukGOD@arm.com>
 <ZBLlyGxGk33yrA+2@MiWiFi-R3L-srv>
 <ZBNTRBqqb74T3RMx@arm.com>
 <ZBSCeWtHvqc/iJZg@MiWiFi-R3L-srv>
 <ZBSr/kIIuxmC/INY@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBSr/kIIuxmC/INY@arm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/17/23 at 06:05pm, Catalin Marinas wrote:
> On Fri, Mar 17, 2023 at 11:09:13PM +0800, Baoquan He wrote:
> > On 03/16/23 at 05:35pm, Catalin Marinas wrote:
> > > On Thu, Mar 16, 2023 at 05:47:52PM +0800, Baoquan He wrote:
> > > > Now I am wondering if we should change CRASH_ADDR_LOW_MAX to 4G directly
> > > > since we decide to take 4G as the low memory limit when doing 'high'
> > > > reserving or falling back. This is just like what we have been doing in
> > > > x86_64. Not sure if I follow you correctly.
> > > 
> > > On RPi4, we do need the 'low' allocation to be below 1GB, otherwise
> > > ZONE_DMA will be empty. But we can leave the 'high' reservation above
> > > 4GB (if available). The downside is that we won't get anything between
> > > 1GB and 4GB unless explicitly specified with @offset.
> > 
> > Ah, I see. You want to have high reservation like below when RPi4.
> > 
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 307763f97549..9e558fadf483 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -95,6 +95,7 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
> >  
> >  #define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
> >  #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
> > +#define CRASH_HIGH_SEARCH_BASE		SZ_4G
> >  
> >  #define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
> >  
> > @@ -156,7 +157,7 @@ static void __init reserve_crashkernel(void)
> >  		else if (ret)
> >  			return;
> >  
> > -		search_base = CRASH_ADDR_LOW_MAX;
> > +		search_base = CRASH_HIGH_SEARCH_BASE;
> >  		crash_max = CRASH_ADDR_HIGH_MAX;
> >  		high = true;
> >  	} else if (ret || !crash_size) {
> > @@ -193,7 +194,7 @@ static void __init reserve_crashkernel(void)
> >  		 */
> >  		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
> >  			crash_max = CRASH_ADDR_HIGH_MAX;
> > -			search_base = CRASH_ADDR_LOW_MAX;
> > +			search_base = CRASH_HIGH_SEARCH_BASE;
> >  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> >  			goto retry;
> >  		}
> 
> This would probably do _if_ these are the semantics that we want (well,
> more discussion below).
> 
> > > I'm not entirely sure what you want to achieve: avoiding the 'high'
> > > reservation going across an arbitrary boundary (1GB or 4GB) that the
> > > user may not be aware of or just avoiding the 'high' reservation going
> > > across a 4G boundary? On RPi4, if the 'high' reservation above 4GB
> > > fails, should it fall back to below 1GB reservation or to somewhere
> > > between 1GB and 4GB, making sure it doesn't cross any of these two
> > > boundaries? For someone unfamiliar with the ZONE_DMA on RPi4, the latter
> > > would look like two 'low' allocations below 4GB.
> > 
> > Currently, with the existing code, the high and low memory is like below
> > on arm64:
> > RPi4:
> > 0~1G: low memory | 1G~top: high memory
> > 
> > Other normal system:
> > 0~4G: low memory | 4G~top: high memory
> 
> Yes, that's the current behaviour.
> 
> > Now you want RPi4 to have low and high crahskernel reservation like
> > this: 
> > 0~1G: low memory | 4G~top: high memory
> 
> I don't necessarily want this, I just want to clarify what we actually
> need to fix. Your initial reasoning for this patch was that the user
> gets confused by the high allocation going across the 4G boundary. But
> without knowing of the 1GB vs 4GB boundary on RPi4, one can still get
> confused by the high allocation across the 4GB boundary on RPi4.

Ah, I see your point. Yeah, the initial reasoning is our QE reported
several times that arm64 system could have two regions of low memory
allocation when crahskernel=,high. While later I spotted another two
issues. With the initial reasoning, we does need consider the hign and
low boundary at 1G on RPi4 which could cause confusion. Given RPi4
is not taken into our distros's account, I am shooting myself in the
foot. But yes, we should consider it if kdump feature is really cared
about on RPi4. Please see later reply.

> 
> > It's also fine. However, as far as I know, RPi4 usually only has 8G
> > memory.
> 
> That's the maximum. Lots of them just come with 4GB or less.
> 
> > And arm64 only has top down memblock allocation. Its high memory
> > above 4G will be fragmentary, the crahskernel high reservation will fail
> > if the value is big.
> > 
> > In fact, what I want to achieve is we set CRASH_ADDR_LOW_MAX to 4G
> > fixedly on arm64, just like what we do on x86_64. As for RPi4 platform,
> > we leave it to crashkernel=size@offset syntax. Two reasons for this:
> > 1) crashkernel is needed on enterprise platform, such as workstation or
> > server. While RPi4 is obviously not the target. I contacted several RPi4
> > players in Redhat and my friends, none of them ever played kdump
> > testing. If they really have to, crashkernel=size@offset is enough for
> > them to set.
> 
> I'd like crashkernel=size (without @offset) on RPi4 to still do the
> right thing: a low allocation at least as we had until recently (or
> high+low where high here is maybe above 1GB). IOW, no regression for
> this crashkernel=size case. We can then change the explicit
> crashkernel=x,high to mean only above 4GB irrespective of the platform
> and crashkernel=x,low to be below arm64_dma_phys_limit.

Since crashkernel=,high and crashkernel=size fallback was added in arm64
recently, with my understanding, you are suggesting:

on arm64:
RPi4:
crashkernel=size
0~1G: low memory (no regression introduced)

crashkernel=size,high
0~1G: low memory | 4G~top: high memory

Other normal system:
crashkernel=size|crashkernel=size,high
0~4G: low memory | 4G~top: high memory

Please correct me if I misunderstood, I can make change according to
your suggestion.

> 
> > 2) with the fixed CRASH_ADDR_LOW_MAX as 4G, we can easily fix the
> > problem of base page mapping for the whole linear mapping if crsahkernel=
> > is set in kernel parameter shown in [1] at bottom. 
> 
> That's a different problem ;). I should re-read that thread, forgot most
> of the details but I recall one of the counter arguments was that there
> isn't a strong case to unmap the crashkernel reservation. Now, if we
> place crashdump kernel image goes in the 'high' reservation, can we not
> leave the 'low' reservation mapped? We don't really care about it as it
> wouldn't have any meaningful code/data to be preserved. If the 'high'
> one goes above 4G always, we don't depend on the arm64_dma_phys_limit.

Yes, this looks ideal. While it only works when crashkernel=,high case and
it succeeds to reserve a memory region for the specified size of crashkernel
high memory. At below, we have 4 cases of crashkernel= syntax:

crashkernel=size
1)first attempt:  low memory under arm64_dma_phys_limit
2)fallback:       finding memory above 4G

crashkernel=size,high
3)first attempt:  finding memory above 4G
4)fallback:       low memory under arm64_dma_phys_limit

case 3) works with your suggestion. However, 1), 2), 4) all need to
defer to bootmem_init(). With these cases and different handling,
reserve_crashkernel() could be too complicated.

I am wondering if we can cancel the protection of crashkernel memory
region on arm64 for now. In earlier discussion, people questioned if the
protection is necessary on arm64. After comparison, I would rather take
away the protection method of crashkernel region since they try to
protect in a chance in one million , while the base page mapping for the
whole linear mapping is mitigating arm64 high end server always.

> 
> > Arm64 enterprise OS deployment is now very important in our
> > Fedora/Centos stream/RHEL. I am wondering how wide and important kdump
> > feature is needed and deployed on RPi4 platform and what is the user case.
> 
> I doubt it's important beyond testing but I'd very much like not to
> cause a regression and require the @offset argument for RPi4.

OK, understood. Pity we don't have information to judge if it's a RPi4
system or not, with a Kconfig option, some cpu register or hardware
information. 

