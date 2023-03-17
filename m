Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928C56BEC90
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjCQPLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjCQPL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:11:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1071719108
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679065765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1sm8PXGp513LsUWdH4xt3YWumdRryFErjBgqmIG+/uE=;
        b=SfV86BHVDW+inVnJ3tV8OWziChbajgQBEUJlGsJEe7Mmh3hgF7En3gzHpsNM/EBeWfrk0/
        4BTJlVTVBNwUj2FkthlZDdmzYpXdWq4s4Y3h4Mmswaz35XBMYclIHVibb5esAq2w1TQ2TE
        4N1ND5zNonDG6Maeo4q1YVwD7p2GNSk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-wFO7-Y5ZPomQw8x5sV4Edg-1; Fri, 17 Mar 2023 11:09:21 -0400
X-MC-Unique: wFO7-Y5ZPomQw8x5sV4Edg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0844029DD995;
        Fri, 17 Mar 2023 15:09:21 +0000 (UTC)
Received: from localhost (ovpn-12-37.pek2.redhat.com [10.72.12.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A3A040C83B6;
        Fri, 17 Mar 2023 15:09:19 +0000 (UTC)
Date:   Fri, 17 Mar 2023 23:09:13 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, horms@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        will@kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZBSCeWtHvqc/iJZg@MiWiFi-R3L-srv>
References: <20230306084124.300584-1-bhe@redhat.com>
 <ZBHbw3Vp4dxukGOD@arm.com>
 <ZBLlyGxGk33yrA+2@MiWiFi-R3L-srv>
 <ZBNTRBqqb74T3RMx@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBNTRBqqb74T3RMx@arm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/16/23 at 05:35pm, Catalin Marinas wrote:
> On Thu, Mar 16, 2023 at 05:47:52PM +0800, Baoquan He wrote:
> > On 03/15/23 at 02:52pm, Catalin Marinas wrote:
> > > On Mon, Mar 06, 2023 at 04:41:24PM +0800, Baoquan He wrote:
> > > > +		/*
> > > > +		 * For crashkernel=size[KMG], if the first attempt was for
> > > > +		 * low memory, fall back to high memory, the minimum required
> > > > +		 * low memory will be reserved later.
> > > > +		 */
> > > > +		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
> > > >  			crash_max = CRASH_ADDR_HIGH_MAX;
> > > > +			search_base = CRASH_ADDR_LOW_MAX;
> > > >  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> > > >  			goto retry;
> > > >  		}
> > > 
> > > So I'm more tempted to set the search_base to 4G here rather than
> > > CRASH_ADDR_LOW_MAX. The crashkernel=x,high option on a RPi4 with all
> > > memory below 4G will fall back to low allocation. But RPi4 is the odd
> > > one out, so I think we can live with this.
> > 
> > I totally agree with you that we should take 4G as the fixed boundary of
> > low and high memory because kdump is aimed at workstation and server
> > platform. We can leave RPi4 to use crashkernel=size[KMG][@offset[KMG]]
> > to specify a region if people have to use.
> > 
> > [PATCH 0/2] arm64, kdump: enforce to take 4G as the crashkernel low memory end
> > https://lore.kernel.org/all/20220828005545.94389-1-bhe@redhat.com/T/#u
> > 
> > Now I am wondering if we should change CRASH_ADDR_LOW_MAX to 4G directly
> > since we decide to take 4G as the low memory limit when doing 'high'
> > reserving or falling back. This is just like what we have been doing in
> > x86_64. Not sure if I follow you correctly.
> 
> On RPi4, we do need the 'low' allocation to be below 1GB, otherwise
> ZONE_DMA will be empty. But we can leave the 'high' reservation above
> 4GB (if available). The downside is that we won't get anything between
> 1GB and 4GB unless explicitly specified with @offset.

Ah, I see. You want to have high reservation like below when RPi4.

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 307763f97549..9e558fadf483 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -95,6 +95,7 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
 
 #define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
 #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
+#define CRASH_HIGH_SEARCH_BASE		SZ_4G
 
 #define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
 
@@ -156,7 +157,7 @@ static void __init reserve_crashkernel(void)
 		else if (ret)
 			return;
 
-		search_base = CRASH_ADDR_LOW_MAX;
+		search_base = CRASH_HIGH_SEARCH_BASE;
 		crash_max = CRASH_ADDR_HIGH_MAX;
 		high = true;
 	} else if (ret || !crash_size) {
@@ -193,7 +194,7 @@ static void __init reserve_crashkernel(void)
 		 */
 		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
 			crash_max = CRASH_ADDR_HIGH_MAX;
-			search_base = CRASH_ADDR_LOW_MAX;
+			search_base = CRASH_HIGH_SEARCH_BASE;
 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
 			goto retry;
 		}

> 
> I'm not entirely sure what you want to achieve: avoiding the 'high'
> reservation going across an arbitrary boundary (1GB or 4GB) that the
> user may not be aware of or just avoiding the 'high' reservation going
> across a 4G boundary? On RPi4, if the 'high' reservation above 4GB
> fails, should it fall back to below 1GB reservation or to somewhere
> between 1GB and 4GB, making sure it doesn't cross any of these two
> boundaries? For someone unfamiliar with the ZONE_DMA on RPi4, the latter
> would look like two 'low' allocations below 4GB.

Currently, with the existing code, the high and low memory is like below
on arm64:
RPi4:
0~1G: low memory | 1G~top: high memory

Other normal system:
0~4G: low memory | 4G~top: high memory

Now you want RPi4 to have low and high crahskernel reservation like
this: 
0~1G: low memory | 4G~top: high memory
It's also fine. However, as far as I know, RPi4 usually only has 8G
memory. And arm64 only has top down memblock allocation. Its high memory
above 4G will be fragmentary, the crahskernel high reservation will fail
if the value is big.

In fact, what I want to achieve is we set CRASH_ADDR_LOW_MAX to 4G
fixedly on arm64, just like what we do on x86_64. As for RPi4 platform,
we leave it to crashkernel=size@offset syntax. Two reasons for this:
1) crashkernel is needed on enterprise platform, such as workstation or
server. While RPi4 is obviously not the target. I contacted several RPi4
players in Redhat and my friends, none of them ever played kdump
testing. If they really have to, crashkernel=size@offset is enough for
them to set.
2) with the fixed CRASH_ADDR_LOW_MAX as 4G, we can easily fix the
problem of base page mapping for the whole linear mapping if crsahkernel=
is set in kernel parameter shown in [1] at bottom. 

Arm64 enterprise OS deployment is now very important in our
Fedora/Centos stream/RHEL. I am wondering how wide and important kdump
feature is needed and deployed on RPi4 platform and what is the user case.

If CRASH_ADDR_LOW_MAX is set to 4G fixedly, and document that RPi4 need
crashkernel=size@offset specially if kdump deployment is really needed.
problems we discussed here and the spotted base page mapping issue can
be solved easily and elegantly. That woule be deeply appreciated.

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 307763f97549..3b03958b668e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -93,8 +93,9 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
 /* Current arm64 boot protocol requires 2MB alignment */
 #define CRASH_ALIGN                    SZ_2M
 
-#define CRASH_ADDR_LOW_MAX             arm64_dma_phys_limit
+#define CRASH_ADDR_LOW_MAX             SZ_4G
 #define CRASH_ADDR_HIGH_MAX            (PHYS_MASK + 1)


[1]
[PATCH 0/2] arm64, kdump: enforce to take 4G as the crashkernel low memory end
https://lore.kernel.org/all/20220828005545.94389-1-bhe@redhat.com/T/#u

