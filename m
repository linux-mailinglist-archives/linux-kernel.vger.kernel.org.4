Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E381168736E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 03:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjBBC41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 21:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBBC40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 21:56:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D5E728CB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 18:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675306541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XLBXtd6NgriQ7A5ZWXztbyUCM7WFy5RfjYy2td4k7fE=;
        b=XnODxoEbSkTC53xuu8T0RMoGgqSoX7L7uMkcNNQeyJodeVPT45zHYEASao+MbmJbZKnBXR
        l7HCS8rObBP+w6E96FCNkpw/sPCOKLxB36sPDcXQFc9xV+9wQYfZF3Jcma3rtynK9BKoor
        DGqaSa+kYL242S7oshrTziCHBUZct3I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-efmawRduNwu8WBWqSoSN_g-1; Wed, 01 Feb 2023 21:55:36 -0500
X-MC-Unique: efmawRduNwu8WBWqSoSN_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFBA6101A521;
        Thu,  2 Feb 2023 02:55:35 +0000 (UTC)
Received: from localhost (ovpn-12-116.pek2.redhat.com [10.72.12.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 983BE43FBA;
        Thu,  2 Feb 2023 02:55:34 +0000 (UTC)
Date:   Thu, 2 Feb 2023 10:55:30 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH 1/2] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <Y9smIopkS8C+TG/5@MiWiFi-R3L-srv>
References: <20230117034921.185150-1-bhe@redhat.com>
 <20230117034921.185150-2-bhe@redhat.com>
 <Y9AXKgJvUuilsWUX@arm.com>
 <Y9n/PTEv7oOObuLi@MiWiFi-R3L-srv>
 <Y9qca12Y/oCxcaFW@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9qca12Y/oCxcaFW@arm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/23 at 05:07pm, Catalin Marinas wrote:
> On Wed, Feb 01, 2023 at 01:57:17PM +0800, Baoquan He wrote:
> > On 01/24/23 at 05:36pm, Catalin Marinas wrote:
> > > On Tue, Jan 17, 2023 at 11:49:20AM +0800, Baoquan He wrote:
> > > > On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> > > > suitable memory region up down. If the 'xM' of crashkernel high memory
> > > > is reserved from high memory successfully, it will try to reserve
> > > > crashkernel low memory later accoringly. Otherwise, it will try to search
> > > > low memory area for the 'xM' suitable region.
> > > > 
> > > > While we observed an unexpected case where a reserved region crosses the
> > > > high and low meomry boundary. E.g on a system with 4G as low memory end,
> > > > user added the kernel parameters like: 'crashkernel=512M,high', it could
> > > > finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
> > > > This looks very strange because we have two low memory regions
> > > > [4G-126M, 4G] and [1G, 1G+128M]. Much explanation need be given to tell
> > > > why that happened.
> > > > 
> > > > Here, for crashkernel=xM,high, search the high memory for the suitable
> > > > region above the high and low memory boundary. If failed, try reserving
> > > > the suitable region below the boundary. Like this, the crashkernel high
> > > > region will only exist in high memory, and crashkernel low region only
> > > > exists in low memory. The reservation behaviour for crashkernel=,high is
> > > > clearer and simpler.
> > > 
> > > Well, I guess it depends on how you look at the 'high' option: is it
> > > permitting to go into high addresses or forcing high addresses only?
> > > IIUC the x86 implementation has a similar behaviour to the arm64 one, it
> > > allows allocation across boundary.
> > 
> > Hmm, x86 has no chance to allocate a memory region across 4G boundary
> > because it reserves many small regions to map firmware, pci bus, etc
> > near 4G. E.g one x86 system has /proc/iomem as below. I haven't seen a
> > x86 system which doesn't look like this.
> > 
> > [root@ ~]# cat /proc/iomem 
> [...]
> > fffc0000-ffffffff : Reserved
> > 100000000-13fffffff : System RAM
> 
> Ah, that's why we don't see this problem on x86.
> 
> Alright, for consistency I'm fine with having the same logic on arm64. I
> guess we don't need the additional check on whether the 'high'
> allocation reserved at least 128MB in the 'low' range. If it succeeded
> and the start is below 4GB, it's guaranteed that it got the full
> allocation in the 'low' range. I haven't checked whether your patch
> cleaned this up already, if not please do in the next version.

Yes, that checking has been cleaned away in this patch.

> 
> And as already asked, please fold the comments with the same patch, it's
> easier to read.

Sure, will do. Thanks a lot for reviewing.

