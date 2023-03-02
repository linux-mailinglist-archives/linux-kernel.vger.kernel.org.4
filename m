Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457CF6A7A38
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjCBD5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCBD5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:57:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC87D3B201
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 19:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677729393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Grs0Xm2F8lTmefjOhyT/L35DEvt2ZshN4421DWTG63E=;
        b=GDb4NMv42tkqEBGiSdz2EHQL5sd8WIkeffh4f3UCPTo+aUC7cc/ug6UvmPq7ebNwdzPQga
        cjgZXwHq5g4LXV/xYkTorsYjLyJMIWrIblS9jglohX2f+NXjphmVRTw9GtYrT5z+7cdyOa
        GPIVe29IZ1FiwouZuxbQ1xDECISOlM8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-F4SkhlxXMiSukBC0RPf_lw-1; Wed, 01 Mar 2023 22:56:29 -0500
X-MC-Unique: F4SkhlxXMiSukBC0RPf_lw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAAC01C189A0;
        Thu,  2 Mar 2023 03:56:28 +0000 (UTC)
Received: from localhost (ovpn-12-47.pek2.redhat.com [10.72.12.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF13E2166B26;
        Thu,  2 Mar 2023 03:56:27 +0000 (UTC)
Date:   Thu, 2 Mar 2023 11:56:24 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        horms@kernel.org, John.p.donnelly@oracle.com, will@kernel.org,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZAAeaLYKRkX9buVA@MiWiFi-R3L-srv>
References: <20230223124532.128744-1-bhe@redhat.com>
 <7971ddbe-aefb-271e-647c-59d81c5840a7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7971ddbe-aefb-271e-647c-59d81c5840a7@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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
> 
> 
> On 2023/2/23 20:45, Baoquan He wrote:
...... 
> There are two minor review comments, see below. Otherwise:

Makes sense, all accepted. Will update and repost.

Thanks for careful reviewing.

> 
> Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> > v2->v3:
> >  - Rephrase patch log to clarify the current crashkernel high
> >    reservation could cross the high and low memory boundary, but not 
> >    4G boundary only, because RPi4 of arm64 has high and low memory
> >    boudary as 1G. The v3 patch log could mislead people that the RPi4
> >    also use 4G as high,low memory boundary.
> > v1->v2:
> >  - Fold patch 2 of v1 into patch 1 for better reviewing.
> >  - Update patch log to add more details.
> >  arch/arm64/mm/init.c | 43 +++++++++++++++++++++++++++++++++----------
> >  1 file changed, 33 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 58a0bb2c17f1..b8cb780df0cb 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -127,12 +127,13 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
> >   */
> >  static void __init reserve_crashkernel(void)
> >  {
> > -	unsigned long long crash_base, crash_size;
> > -	unsigned long long crash_low_size = 0;
> > +	unsigned long long crash_base, crash_size, search_base;
> >  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> > +	unsigned long long crash_low_size = 0;
> >  	char *cmdline = boot_command_line;
> > -	int ret;
> >  	bool fixed_base = false;
> > +	bool high = false;
> > +	int ret;
> >  
> >  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
> >  		return;
> > @@ -155,7 +156,9 @@ static void __init reserve_crashkernel(void)
> >  		else if (ret)
> >  			return;
> >  
> > +		search_base = CRASH_ADDR_LOW_MAX;
> >  		crash_max = CRASH_ADDR_HIGH_MAX;
> > +		high = true;
> >  	} else if (ret || !crash_size) {
> >  		/* The specified value is invalid */
> >  		return;
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

