Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD1967509B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjATJUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjATJUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:20:05 -0500
Received: from zeeaster.vergenet.net (zeeaster.vergenet.net [206.189.110.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F16420E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:20:02 -0800 (PST)
Received: from momiji.horms.nl (86-93-216-223.fixed.kpn.net [86.93.216.223])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by zeeaster.vergenet.net (Postfix) with ESMTPSA id EBCFE20095;
        Fri, 20 Jan 2023 09:02:53 +0000 (UTC)
Received: by momiji.horms.nl (Postfix, from userid 7100)
        id 0E8C794030F; Fri, 20 Jan 2023 10:02:53 +0100 (CET)
Date:   Fri, 20 Jan 2023 10:02:52 +0100
From:   Simon Horman <horms@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, thunder.leizhen@huawei.com,
        John.p.donnelly@oracle.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH 2/2] arm64/kdump: add code comments for crashkernel
 reservation cases
Message-ID: <Y8pYvBvDonUya1mx@vergenet.net>
References: <20230117034921.185150-1-bhe@redhat.com>
 <20230117034921.185150-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117034921.185150-3-bhe@redhat.com>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.7 at zeeaster
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 11:49:21AM +0800, Baoquan He wrote:
> This will help understand codes on crashkernel reservations on arm64.

FWIIW, I think you can fold this into the first patch.

And, although I have no good idea at this moment, I do wonder
if the logic can be simplified - I for one really needed the
comments to understand the retry logic.

> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/arm64/mm/init.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 26a05af2bfa8..f88ad17cb20d 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -177,6 +177,10 @@ static void __init reserve_crashkernel(void)
>  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>  					       search_base, crash_max);
>  	if (!crash_base) {
> +		/*
> +		 * For crashkernel=size[KMG]@offset[KMG], print out failure
> +		 * message if can't reserve the specified region.
> +		 */
>  		if (fixed_base) {
>  			pr_warn("cannot reserve crashkernel region [0x%llx-0x%llx]\n",
>  				search_base, crash_max);
> @@ -188,6 +192,11 @@ static void __init reserve_crashkernel(void)
>  		 * high memory, the minimum required low memory will be
>  		 * reserved later.
>  		 */
> +		/*
> +		 * For crashkernel=size[KMG], if the first attempt was for
> +		 * low memory, fall back to high memory, the minimum required
> +		 * low memory will be reserved later.
> +		 */

I think this duplicates the preceding comment.
Perhaps just replace the earlier comment with this one.

>  		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
>  			crash_max = CRASH_ADDR_HIGH_MAX;
>  			search_base = CRASH_ADDR_LOW_MAX;
> @@ -195,6 +204,10 @@ static void __init reserve_crashkernel(void)
>  			goto retry;
>  		}
>  
> +		/*
> +		 * For crashkernel=size[KMG],high, if the first attempt was for
> +		 * high memory, fall back to low memory.
> +		 */
>  		if (high && (crash_max == CRASH_ADDR_HIGH_MAX)) {
>  			crash_max = CRASH_ADDR_LOW_MAX;
>  			search_base = 0;
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 
