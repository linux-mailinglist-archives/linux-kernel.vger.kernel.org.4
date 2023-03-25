Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454A16C8BD0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 07:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjCYGiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 02:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCYGiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 02:38:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B2F35AA;
        Fri, 24 Mar 2023 23:38:20 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pk8V53f06zKvCx;
        Sat, 25 Mar 2023 14:35:57 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 25 Mar 2023 14:38:16 +0800
Message-ID: <02dd2437-32fa-31aa-4ff3-b33a058f2363@huawei.com>
Date:   Sat, 25 Mar 2023 14:38:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 05/14] ia64: don't allow users to override
 ARCH_FORCE_MAX_ORDER
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Zi Yan <ziy@nvidia.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-csky@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-mm@kvack.org>, <linux-sh@vger.kernel.org>,
        <linux-xtensa@linux-xtensa.org>, <linuxppc-dev@lists.ozlabs.org>,
        <sparclinux@vger.kernel.org>
References: <20230325060828.2662773-1-rppt@kernel.org>
 <20230325060828.2662773-6-rppt@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230325060828.2662773-6-rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/25 14:08, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> It is enough to keep default values for base and huge pages without
> letting users to override ARCH_FORCE_MAX_ORDER.
> 
> Drop the prompt to make the option unvisible in *config.
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>   arch/ia64/Kconfig | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index 0d2f41fa56ee..b61437cae162 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -202,8 +202,7 @@ config IA64_CYCLONE
>   	  If you're unsure, answer N.
>   
>   config ARCH_FORCE_MAX_ORDER
> -	int "MAX_ORDER (10 - 16)"  if !HUGETLB_PAGE
> -	range 10 16  if !HUGETLB_PAGE
> +	int
>   	default "16" if HUGETLB_PAGE
>   	default "10"
>   

It seems that we could drop the following part?

diff --git a/arch/ia64/include/asm/sparsemem.h 
b/arch/ia64/include/asm/sparsemem.h
index a58f8b466d96..18187551b183 100644
--- a/arch/ia64/include/asm/sparsemem.h
+++ b/arch/ia64/include/asm/sparsemem.h
@@ -11,11 +11,6 @@

  #define SECTION_SIZE_BITS      (30)
  #define MAX_PHYSMEM_BITS       (50)
-#ifdef CONFIG_ARCH_FORCE_MAX_ORDER
-#if (CONFIG_ARCH_FORCE_MAX_ORDER + PAGE_SHIFT > SECTION_SIZE_BITS)
-#undef SECTION_SIZE_BITS
-#define SECTION_SIZE_BITS (CONFIG_ARCH_FORCE_MAX_ORDER + PAGE_SHIFT)
-#endif
  #endif

