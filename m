Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A08E6A8F97
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 04:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCCDCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 22:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCCDCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 22:02:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F442559FE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 19:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677812488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B79nsr/L+yxY5ZiHIGPfHGlquDm1c+TbNdmntyfdbOk=;
        b=YymS7dHCHNkHaQaZGgoir+EBtPa0YK6V+qO/NCY1g6YnfKvkYqTSsrcW69Qc6zlpNLa4YE
        gV2hKGAxj6psqUz97ouYZXzJI2NvcaztQLkwZk34+cGhc0WbexTCGDV76rO3VpIn2Gdwdm
        78acoBSPhVc7BgdJ8JOEXoaXmrZ5ZJI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-kfVt7ZOyPxuBPOeHxtUHfg-1; Thu, 02 Mar 2023 22:01:25 -0500
X-MC-Unique: kfVt7ZOyPxuBPOeHxtUHfg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6E8F280BF64;
        Fri,  3 Mar 2023 03:01:24 +0000 (UTC)
Received: from localhost (ovpn-13-150.pek2.redhat.com [10.72.13.150])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B93040C6EC4;
        Fri,  3 Mar 2023 03:01:22 +0000 (UTC)
Date:   Fri, 3 Mar 2023 11:01:19 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        horms@kernel.org, John.p.donnelly@oracle.com, will@kernel.org,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZAFi/+J7WITdcUWb@MiWiFi-R3L-srv>
References: <20230223124532.128744-1-bhe@redhat.com>
 <7971ddbe-aefb-271e-647c-59d81c5840a7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7971ddbe-aefb-271e-647c-59d81c5840a7@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/23 at 11:32am, Leizhen (ThunderTown) wrote:
......
> > @@ -166,31 +169,51 @@ static void __init reserve_crashkernel(void)
> >  	/* User specifies base address explicitly. */
> >  	if (crash_base) {
> >  		fixed_base = true;
> > +		search_base = crash_base;
> >  		crash_max = crash_base + crash_size;
> >  	}
> >  
> >  retry:
> >  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> > -					       crash_base, crash_max);
> > +					       search_base, crash_max);
> >  	if (!crash_base) {
> >  		/*
> > -		 * If the first attempt was for low memory, fall back to
> > -		 * high memory, the minimum required low memory will be
> > -		 * reserved later.
> > +		 * For crashkernel=size[KMG]@offset[KMG], print out failure
> > +		 * message if can't reserve the specified region.
> >  		 */
> > -		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
> > +		if (fixed_base) {
> > +			pr_info("crashkernel reservation failed - memory is in use.\n");
> 
> How about changing pr_info to pr_warn?
> 
> > +			return;
> > +		}
> > +
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
> >  
> > +		/*
> > +		 * For crashkernel=size[KMG],high, if the first attempt was
> > +		 * for high memory, fall back to low memory.
> > +		 */
> > +		if (high && crash_max == CRASH_ADDR_HIGH_MAX) {
> 
> Adding unlikely to indicate that it is rare would be better.
> 
> if (unlikely(high && crash_max == CRASH_ADDR_HIGH_MAX))

Rethink about this and checked code in kernel, seems likely|unlikely are
mostly used in highly frequent execution branch optimize code path, while 
crashkernel resevatoin is one time execution during boot, we may not
need to bother to add unlikely. What do you think?


> 
> > +			crash_max = CRASH_ADDR_LOW_MAX;
> > +			search_base = 0;
> > +			goto retry;
> > +		}
> >  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> >  			crash_size);
> >  		return;
> >  	}
> >  
> > -	if ((crash_base > CRASH_ADDR_LOW_MAX - crash_low_size) &&
> > -	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
> > +	if ((crash_base >= CRASH_ADDR_LOW_MAX) && crash_low_size &&
> > +	     reserve_crashkernel_low(crash_low_size)) {
> >  		memblock_phys_free(crash_base, crash_size);
> >  		return;
> >  	}
> > 
> 
> -- 
> Regards,
>   Zhen Lei
> 

