Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4035B722868
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjFEOK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbjFEOJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:09:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDEA10C6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Vu7pvPUEVm7HRAtXf2lLjoJm/gl4Yt5K3qqaEN8mxeI=; b=rXxALuBjCrAlEuchwIa0lVewEx
        YfPSdtz1OhEzo0+XDkKoEm1yHmEQVOLmB/uiRaBBc57S19+ix3cz8wLcBmktvw/AHQ3z4IxkYGEX4
        iyB2brgbyRWgN6DXQhYxVWkix6HRjptokWDPFrgyrZ7cqlYZHNHF6qOWEKu6lVK/1ZKdbmBXGUaqf
        Spmgz3MuGcMlUuZTS7jcaKobVvtU4wlWpXN9pMgCqUU+PDIQIGU6RsL9G58ev+tNngo+nmUzvVbVW
        gVJ74ZRXvyxBvrTikU3VHLGSrtylCJt2wRdjtwie9tokKazCEmrvMw0ioOhA0k6mrHK6p1LrkUr3+
        nKc0fyyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6At5-00FjaD-0q;
        Mon, 05 Jun 2023 14:08:47 +0000
Date:   Mon, 5 Jun 2023 07:08:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, anshuman.khandual@arm.com,
        egyszeregy@freemail.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: move _PAGE_IOREMAP into pgtable-prot.h
Message-ID: <ZH3sb1o8Q4lPFrU0@infradead.org>
References: <20230602073445.150273-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230602073445.150273-1-wangkefeng.wang@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 03:34:45PM +0800, Kefeng Wang wrote:
> Szőke Kálmán Benjamin reported to me a build issue on an out-of-tree
> module(from Xilinx[1]), which directly include <asm-generic/io.h>,

Err.  Not one should do that, and we certainly should not cater to such
crap.

NAK.

> 
>   "undefined reference" error for _PAGE_IOREMAP
> 
> In general, the module shouldn't include the low-level header file,
> it should be fixed, but _PAGE_IOREMAP definination is kind of pgtable
> prot, let's move it into pgtable-prot.h to put togethor with other prot.
> 
> [1] https://github.com/Xilinx/XilinxVirtualCable/blob/master/zynqMP/src/driver/xvc_driver.c
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm64/include/asm/io.h           | 2 --
>  arch/arm64/include/asm/pgtable-prot.h | 1 +
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index 877495a0fd0c..0b0b12a95051 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -142,8 +142,6 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
>  bool ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot);
>  #define ioremap_allowed ioremap_allowed
>  
> -#define _PAGE_IOREMAP PROT_DEVICE_nGnRE
> -
>  #define ioremap_wc(addr, size)	\
>  	ioremap_prot((addr), (size), PROT_NORMAL_NC)
>  #define ioremap_np(addr, size)	\
> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> index 9b165117a454..f79afbad26a0 100644
> --- a/arch/arm64/include/asm/pgtable-prot.h
> +++ b/arch/arm64/include/asm/pgtable-prot.h
> @@ -64,6 +64,7 @@ extern bool arm64_use_ng_mappings;
>  #define PROT_SECT_NORMAL_EXEC	(PROT_SECT_DEFAULT | PMD_SECT_UXN | PMD_ATTRINDX(MT_NORMAL))
>  
>  #define _PAGE_DEFAULT		(_PROT_DEFAULT | PTE_ATTRINDX(MT_NORMAL))
> +#define _PAGE_IOREMAP		PROT_DEVICE_nGnRE
>  
>  #define PAGE_KERNEL		__pgprot(PROT_NORMAL)
>  #define PAGE_KERNEL_RO		__pgprot((PROT_NORMAL & ~PTE_WRITE) | PTE_RDONLY)
> -- 
> 2.35.3
> 
---end quoted text---
