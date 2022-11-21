Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6291631B77
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiKUIcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiKUIci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:32:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C135F19294
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669019504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lS+1v4t3MHKdnVMtm8dzAIaMzgKu70EAh1YPkpsaRUY=;
        b=J/2jTz4XFPmvwHy0pDQeJKKCjwD0Yn80drxGxGGGn7JCvSr6pUpiF6sz3rcfKdKxFLSy82
        wBRnM3deBeSVznUzaSX6LeDuHZzdK34jxXTaeZUScL2CCCZxoMc/bAhy98f5ITkIDy8pNM
        LURpsZUVHBmS2AHgmAYTgKSlWlNfDAA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-5tZ5hloXMymn1Pe7RqWmjg-1; Mon, 21 Nov 2022 03:31:40 -0500
X-MC-Unique: 5tZ5hloXMymn1Pe7RqWmjg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F6B887B2A0;
        Mon, 21 Nov 2022 08:31:39 +0000 (UTC)
Received: from localhost (ovpn-13-22.pek2.redhat.com [10.72.13.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF436492CA2;
        Mon, 21 Nov 2022 08:31:37 +0000 (UTC)
Date:   Mon, 21 Nov 2022 16:31:32 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH v4 2/2] arm64: kdump: Support crashkernel=X fall back to
 reserve region above DMA zones
Message-ID: <Y3s3ZCYj+ZbI3whB@MiWiFi-R3L-srv>
References: <20221116121044.1690-1-thunder.leizhen@huawei.com>
 <20221116121044.1690-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116121044.1690-3-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/22 at 08:10pm, Zhen Lei wrote:
> For crashkernel=X without '@offset', select a region within DMA zones
> first, and fall back to reserve region above DMA zones. This allows
> users to use the same configuration on multiple platforms.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  2 +-
>  arch/arm64/mm/init.c                            | 17 ++++++++++++++++-
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a7b7147447b8bf8..ef6d922ed26b9dc 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -842,7 +842,7 @@
>  			memory region [offset, offset + size] for that kernel
>  			image. If '@offset' is omitted, then a suitable offset
>  			is selected automatically.
> -			[KNL, X86-64] Select a region under 4G first, and
> +			[KNL, X86-64, ARM64] Select a region under 4G first, and
>  			fall back to reserve region above 4G when '@offset'
>  			hasn't been specified.
>  			See Documentation/admin-guide/kdump/kdump.rst for further details.
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index ba7227179822d10..58a0bb2c17f18cf 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -132,6 +132,7 @@ static void __init reserve_crashkernel(void)
>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>  	char *cmdline = boot_command_line;
>  	int ret;
> +	bool fixed_base = false;
>  
>  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>  		return;
> @@ -163,12 +164,26 @@ static void __init reserve_crashkernel(void)
>  	crash_size = PAGE_ALIGN(crash_size);
>  
>  	/* User specifies base address explicitly. */
> -	if (crash_base)
> +	if (crash_base) {
> +		fixed_base = true;
>  		crash_max = crash_base + crash_size;
> +	}
>  
> +retry:
>  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>  					       crash_base, crash_max);

This pachset looks good to me. While we observed a unexpected case,
where a reserved region cross the high and low meomry region. I noticed
Catalin has pointed that out. Even with the suggested code, we could
have the kernel parameters like: crashkernel=512M,high
crashkernel=128M,low, we finally have [4G-126M, 4G+386M], [1G, 1G+128M]
regions in running kernel. This looks strange.

I am wondering if we can specify explicit search_base in
memblock_phys_alloc_range() to avoid above case. Like this,
crashkernel,high region will only exist in high memory, crashkernel,low
region only exists in low memory region. I made a draft patch based on
this patchset to present what the code looks like.

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 58a0bb2c17f1..fd9d35e17a62 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -127,7 +127,7 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
  */
 static void __init reserve_crashkernel(void)
 {
-	unsigned long long crash_base, crash_size;
+	unsigned long long crash_base, crash_size, search_base;
 	unsigned long long crash_low_size = 0;
 	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
 	char *cmdline = boot_command_line;
@@ -155,6 +155,7 @@ static void __init reserve_crashkernel(void)
 		else if (ret)
 			return;
 
+		search_base = CRASH_ADDR_LOW_MAX;
 		crash_max = CRASH_ADDR_HIGH_MAX;
 	} else if (ret || !crash_size) {
 		/* The specified value is invalid */
@@ -166,12 +167,13 @@ static void __init reserve_crashkernel(void)
 	/* User specifies base address explicitly. */
 	if (crash_base) {
 		fixed_base = true;
+		search_base = crash_base;
 		crash_max = crash_base + crash_size;
 	}
 
 retry:
 	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
-					       crash_base, crash_max);
+					       search_base, crash_max);
 	if (!crash_base) {
 		/*
 		 * If the first attempt was for low memory, fall back to
@@ -180,6 +182,7 @@ static void __init reserve_crashkernel(void)
 		 */
 		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
 			crash_max = CRASH_ADDR_HIGH_MAX;
+			search_base = CRASH_ADDR_LOW_MAX;
 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
 			goto retry;
 		}
@@ -189,7 +192,7 @@ static void __init reserve_crashkernel(void)
 		return;
 	}
 
-	if ((crash_base > CRASH_ADDR_LOW_MAX - crash_low_size) &&
+	if ((crash_base > CRASH_ADDR_LOW_MAX) &&
 	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
 		memblock_phys_free(crash_base, crash_size);
 		return;

