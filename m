Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F80C6BD734
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCPRfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjCPRfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:35:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEA2DCF63
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:35:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21DE2B822BD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 17:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BFAC433D2;
        Thu, 16 Mar 2023 17:35:03 +0000 (UTC)
Date:   Thu, 16 Mar 2023 17:35:00 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, horms@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        will@kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZBNTRBqqb74T3RMx@arm.com>
References: <20230306084124.300584-1-bhe@redhat.com>
 <ZBHbw3Vp4dxukGOD@arm.com>
 <ZBLlyGxGk33yrA+2@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBLlyGxGk33yrA+2@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 05:47:52PM +0800, Baoquan He wrote:
> On 03/15/23 at 02:52pm, Catalin Marinas wrote:
> > On Mon, Mar 06, 2023 at 04:41:24PM +0800, Baoquan He wrote:
> > > +		/*
> > > +		 * For crashkernel=size[KMG], if the first attempt was for
> > > +		 * low memory, fall back to high memory, the minimum required
> > > +		 * low memory will be reserved later.
> > > +		 */
> > > +		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
> > >  			crash_max = CRASH_ADDR_HIGH_MAX;
> > > +			search_base = CRASH_ADDR_LOW_MAX;
> > >  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> > >  			goto retry;
> > >  		}
> > 
> > So I'm more tempted to set the search_base to 4G here rather than
> > CRASH_ADDR_LOW_MAX. The crashkernel=x,high option on a RPi4 with all
> > memory below 4G will fall back to low allocation. But RPi4 is the odd
> > one out, so I think we can live with this.
> 
> I totally agree with you that we should take 4G as the fixed boundary of
> low and high memory because kdump is aimed at workstation and server
> platform. We can leave RPi4 to use crashkernel=size[KMG][@offset[KMG]]
> to specify a region if people have to use.
> 
> [PATCH 0/2] arm64, kdump: enforce to take 4G as the crashkernel low memory end
> https://lore.kernel.org/all/20220828005545.94389-1-bhe@redhat.com/T/#u
> 
> Now I am wondering if we should change CRASH_ADDR_LOW_MAX to 4G directly
> since we decide to take 4G as the low memory limit when doing 'high'
> reserving or falling back. This is just like what we have been doing in
> x86_64. Not sure if I follow you correctly.

On RPi4, we do need the 'low' allocation to be below 1GB, otherwise
ZONE_DMA will be empty. But we can leave the 'high' reservation above
4GB (if available). The downside is that we won't get anything between
1GB and 4GB unless explicitly specified with @offset.

I'm not entirely sure what you want to achieve: avoiding the 'high'
reservation going across an arbitrary boundary (1GB or 4GB) that the
user may not be aware of or just avoiding the 'high' reservation going
across a 4G boundary? On RPi4, if the 'high' reservation above 4GB
fails, should it fall back to below 1GB reservation or to somewhere
between 1GB and 4GB, making sure it doesn't cross any of these two
boundaries? For someone unfamiliar with the ZONE_DMA on RPi4, the latter
would look like two 'low' allocations below 4GB.

-- 
Catalin
