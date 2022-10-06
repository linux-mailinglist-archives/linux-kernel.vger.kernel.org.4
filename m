Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0395F6138
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 08:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJFGxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 02:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJFGxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 02:53:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2F589800
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 23:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665039208; x=1696575208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TWTzXIepdJAhGXlLlYIHyFJRwqOy33J1R/GJHz29r8M=;
  b=wnX7oWxR02Bt6RlSWjORLEs2fhhFZHtt8gLMtSl4GexaqmSso2eHqS91
   T7TN974AJmSTwKyZq2314nKEh6t33gCTGpNiODy78kQxEaMWBH6wzC9Y7
   dmZYdh3n5+Psqx//2ZVChhebIfIW1naaz/d6UXQr+rXKHGPTMkCaBX1CB
   8lBWpLkuNmBegEU1/HcxxDWPvzcFrO96KG6nBBGbRjtq67PVEe1K+W+N/
   6HZO4gaGiUgkbjJeURf9uitfS6bYuyiMhi6IVQ8Tb6k4TxpR6irQFbEnz
   kxb7Zy8eDRVeMgWXhqiMInrOBY/zMFDPKK9zaZcc/qUoMKX6oqWXEptDB
   w==;
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="180642588"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Oct 2022 23:53:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 5 Oct 2022 23:53:26 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 5 Oct 2022 23:53:25 -0700
Date:   Thu, 6 Oct 2022 07:53:03 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     <jszhang@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: enable THP_SWAP for RV64
Message-ID: <Yz57T4eob3pXAVSP@wendy>
References: <20220821170559.840-1-jszhang@kernel.org>
 <mhng-a75e502f-0324-44ae-92c5-e93864fbf1cc@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <mhng-a75e502f-0324-44ae-92c5-e93864fbf1cc@palmer-ri-x1c9>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 07:35:53PM -0700, Palmer Dabbelt wrote:
> On Sun, 21 Aug 2022 10:05:59 PDT (-0700), jszhang@kernel.org wrote:
> > I have a Sipeed Lichee RV dock board which only has 512MB DDR, so
> > memory optimizations such as swap on zram are helpful. As is seen
> > in commit d0637c505f8a ("arm64: enable THP_SWAP for arm64") and
> > commit bd4c82c22c367e ("mm, THP, swap: delay splitting THP after
> > swapped out"), THP_SWAP can improve the swap throughput significantly.
> > 
> > Enable THP_SWAP for RV64, testing the micro-benchmark which is
> > introduced by commit d0637c505f8a ("arm64: enable THP_SWAP for arm64")
> > shows below numbers on the Lichee RV dock board:
> > 
> > thp swp throughput w/o patch: 66908 bytes/ms (mean of 10 tests)
> > thp swp throughput w/ patch: 322638 bytes/ms (mean of 10 tests)
> > 
> > Improved by 382%!
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index ed66c31e4655..19088c750c7f 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -45,6 +45,7 @@ config RISCV
> >  	select ARCH_WANT_FRAME_POINTERS
> >  	select ARCH_WANT_GENERAL_HUGETLB
> >  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
> > +	select ARCH_WANTS_THP_SWAP if TRANSPARENT_HUGEPAGE
> >  	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
> >  	select BUILDTIME_TABLE_SORT if MMU
> >  	select CLONE_BACKWARDS
> 
> Thanks, this is on for-next.

FYI, this is v1 of a patchset that went to v3.
v3 only changed the commit message, but v2 had a functional change.

v3 is here:
https://lore.kernel.org/all/20220829145742.3139-1-jszhang@kernel.org/

Thanks,
Conor.

