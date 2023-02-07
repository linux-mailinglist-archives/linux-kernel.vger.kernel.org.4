Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B2B68D576
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjBGLaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjBGL3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:29:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FD08A7E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 03:29:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDD9FB81603
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 11:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB1AC433D2;
        Tue,  7 Feb 2023 11:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675769386;
        bh=FMKebmT8UkF+9euLxcusDfgEaDtWb+MoAtShKQqplxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uRRMzvP1LqaHei6sgdqbIC2FNnrmrBBKopXsrRjigzqrmS63Khj5x5xdmLhy6U69A
         Uj6GfKKuk37+gGevENxVtEyBQiZIzDZS5ykNL2nwPWqd5/q62bOzSCdrnWWxfpTvVB
         u8t7bthW6USzVcOc5wK9wY8x6NEwkk1oYpTW8XLQuHSPML7gmLnF+DGobv9ha3g+t/
         U24U1Q7WqV/UvVVNjgLm0MR53knQ0N/vtxblz1/LvAcNr78UGIXrUD+AZghJNA/WyN
         SNdvfm9wa8Oj3c3A2iD2KR77mXoBg5hvp9fljE3cHpZ3QZTNQvLMVd4RatsnKyhLmV
         qAys7FUELAzYQ==
Date:   Tue, 7 Feb 2023 11:29:41 +0000
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH RFC] arm64/vmalloc: use module region only for
 module_alloc() if CONFIG_RANDOMIZE_BASE is set
Message-ID: <20230207112940.GA12147@willie-the-truck>
References: <20221227092634.445212-1-liushixin2@huawei.com>
 <b93ec55c-f6f0-274a-e7d6-edb419b4be8a@huawei.com>
 <20230129134147.f19ca0641f1133f3e3bc185b@linux-foundation.org>
 <20230131150644.GA2605@willie-the-truck>
 <20230131150750.GB2605@willie-the-truck>
 <CAMj1kXGaxehOcrQqFZNA+C3dTk_H8sBr_1wsN3_KN82nXVaG_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGaxehOcrQqFZNA+C3dTk_H8sBr_1wsN3_KN82nXVaG_g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 05:03:32PM +0100, Ard Biesheuvel wrote:
> On Tue, 31 Jan 2023 at 16:07, Will Deacon <will@kernel.org> wrote:
> > On Tue, Jan 31, 2023 at 03:06:44PM +0000, Will Deacon wrote:
> > > On Sun, Jan 29, 2023 at 01:41:47PM -0800, Andrew Morton wrote:
> > > > On Sun, 29 Jan 2023 10:44:31 +0800 Liu Shixin <liushixin2@huawei.com> wrote:
> > > > > On 2022/12/27 17:26, Liu Shixin wrote:
> > > > > > After I add a 10GB pmem device, I got the following error message when
> > > > > > insert module:
> > > > > >
> > > > > >  insmod: vmalloc error: size 16384, vm_struct allocation failed,
> > > > > >  mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
> > > > > >
> > > > > > If CONFIG_RANDOMIZE_BASE is set, the module region can be located in the
> > > > > > vmalloc region entirely. Although module_alloc() can fall back to a 2GB
> > > > > > window if ARM64_MODULE_PLTS is set, the module region is still easily
> > > > > > exhausted because the module region is located at bottom of vmalloc region
> > > > > > and the vmalloc region is allocated from bottom to top.
> > > > > >
> > > > > > Skip module region if not calling from module_alloc().
> > > > > >
> > > >
> > > > I'll assume this is for the arm tree.
> > > >
> > > > Acked-by: Andrew Morton <akpm@linux-foundation.org>
> > >
> > > This looks like the same issue previously reported at:
> > >
> > > https://lore.kernel.org/all/e6a804de-a5f7-c551-ffba-e09d04e438fc@hisilicon.com/
> > >
> > > where Ard had a few suggestions but, afaict, they didn't help.
> > >
> 
> Thanks for the cc.
> 
> So this is a bit clunky, and I wonder whether we wouldn't be better
> off just splitting the vmalloc region into two separate regions: one
> for the kernel and modules, and one for everything else. That way, we
> lose one bit of entropy in the randomized placement, but the default
> 48-bit VA space is vast anway, and even on 39-bit VA configs (such as
> Android), I seriously doubt that we come anywhere close to exhausting
> the vmalloc space today.

That sounds like a good idea to me.

Liu Shixin -- do you think you could have a go at implementing Ard's
suggestion instead?

Cheers,

Will
