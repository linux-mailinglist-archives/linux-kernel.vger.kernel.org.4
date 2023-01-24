Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88752678E8F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 03:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjAXCul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 21:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjAXCui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:50:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9309272AB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 18:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674528589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tDEShTc+qxEMTNcIsETbduQ+QSQW/4E7thNs06NrHuI=;
        b=ChvetQtXooMZAqZOR7TB7BCw6BLHMS3w39hK5P5sh9D1an4/EmmqiqF0bFe+DYVltdUscq
        Uo1X7DyHqfHbWPJg8vbuaXpfRiVduFFZOrxC+Y5Ni55JZ3x2pnbHO6YmEhcMkVSsikkD4H
        06YUvT7EeDvplCwWXjiE+m+NRbjXhhk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-ajSWj7FDNyGCHfrOcokx7g-1; Mon, 23 Jan 2023 21:49:48 -0500
X-MC-Unique: ajSWj7FDNyGCHfrOcokx7g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE1E385C069;
        Tue, 24 Jan 2023 02:49:47 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 607FC4069768;
        Tue, 24 Jan 2023 02:49:45 +0000 (UTC)
Date:   Tue, 24 Jan 2023 10:49:42 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Simon Horman <horms@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, thunder.leizhen@huawei.com,
        John.p.donnelly@oracle.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH 2/2] arm64/kdump: add code comments for crashkernel
 reservation cases
Message-ID: <Y89HRnIzq034pJH8@fedora>
References: <20230117034921.185150-1-bhe@redhat.com>
 <20230117034921.185150-3-bhe@redhat.com>
 <Y8pYvBvDonUya1mx@vergenet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8pYvBvDonUya1mx@vergenet.net>
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

On 01/20/23 at 10:02am, Simon Horman wrote:
> On Tue, Jan 17, 2023 at 11:49:21AM +0800, Baoquan He wrote:
> > This will help understand codes on crashkernel reservations on arm64.
> 
> FWIIW, I think you can fold this into the first patch.

Sure, will do.

I folded this into patch 1 at the very beginning. Then felt the added
code comments add lines of change and make the code change not so
straightforward. I admit it's from personal feeling. 

> 
> And, although I have no good idea at this moment, I do wonder
> if the logic can be simplified - I for one really needed the
> comments to understand the retry logic.

Got it. I will consider if I can improve the logic readability. Thanks.

> 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/arm64/mm/init.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 26a05af2bfa8..f88ad17cb20d 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -177,6 +177,10 @@ static void __init reserve_crashkernel(void)
> >  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> >  					       search_base, crash_max);
> >  	if (!crash_base) {
> > +		/*
> > +		 * For crashkernel=size[KMG]@offset[KMG], print out failure
> > +		 * message if can't reserve the specified region.
> > +		 */
> >  		if (fixed_base) {
> >  			pr_warn("cannot reserve crashkernel region [0x%llx-0x%llx]\n",
> >  				search_base, crash_max);
> > @@ -188,6 +192,11 @@ static void __init reserve_crashkernel(void)
> >  		 * high memory, the minimum required low memory will be
> >  		 * reserved later.
> >  		 */
> > +		/*
> > +		 * For crashkernel=size[KMG], if the first attempt was for
> > +		 * low memory, fall back to high memory, the minimum required
> > +		 * low memory will be reserved later.
> > +		 */
> 
> I think this duplicates the preceding comment.
> Perhaps just replace the earlier comment with this one.
> 
> >  		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
> >  			crash_max = CRASH_ADDR_HIGH_MAX;
> >  			search_base = CRASH_ADDR_LOW_MAX;
> > @@ -195,6 +204,10 @@ static void __init reserve_crashkernel(void)
> >  			goto retry;
> >  		}
> >  
> > +		/*
> > +		 * For crashkernel=size[KMG],high, if the first attempt was for
> > +		 * high memory, fall back to low memory.
> > +		 */
> >  		if (high && (crash_max == CRASH_ADDR_HIGH_MAX)) {
> >  			crash_max = CRASH_ADDR_LOW_MAX;
> >  			search_base = 0;
> > -- 
> > 2.34.1
> > 
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> > 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

