Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93625683225
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjAaQD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjAaQDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:03:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D933B49548
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:03:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ACD46151C
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 16:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD990C4339B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 16:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675181025;
        bh=kUz3/3+6pALvgsc48sJBO2OS1e53UX0oL7m8fy1FZvI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OqHZTuyhf+5SNAwMhww2gUuy9twe03k1YFhSBGPtWDQ6btJYNi10+H+YXOZFnqJ0D
         rCOh967hyGgRNSD2QzalE2nA68bg1LD2It++UVehX4dK+mCok8cmsXIUF5/Xd+pMQ8
         Rx9e2/pK++NflZJBAAKY0mw6EIVI+/52go75Et98186TyholvXwf49xHjnhKnUpfDr
         KBW99GpC5TUxG8RJR9H/Ns2DyL11WdcNqbWgMPZlA57KJD/FVBasw8e1kC81M570Xh
         7pCSxgwfXPjHEZEi5ErKBxzLsduqFN7/SJpQPeOjQM+8eT0yfIfFM3OafMBsiT0cMw
         NrW2y0DVvo3yw==
Received: by mail-lf1-f54.google.com with SMTP id f34so24861129lfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:03:45 -0800 (PST)
X-Gm-Message-State: AO0yUKXMbXGK2K1gHsgZ9IvlbyUinVJE/Xvzuxm5gp8fKGczIDguvCJ1
        b8CensSms9OpQRtD3D/rWjNIjeMLBwRgOvl4gXU=
X-Google-Smtp-Source: AK7set9S5k7gtqRiiMlvlOsZKuor0mBWUgdkw9E7GdqWo81k7IJisxGOI7efBe4gqidKZqYzpQunKAfGu/1g1jUSdx4=
X-Received: by 2002:a19:c219:0:b0:4d7:2dc1:b7bc with SMTP id
 l25-20020a19c219000000b004d72dc1b7bcmr3332353lfc.100.1675181023886; Tue, 31
 Jan 2023 08:03:43 -0800 (PST)
MIME-Version: 1.0
References: <20221227092634.445212-1-liushixin2@huawei.com>
 <b93ec55c-f6f0-274a-e7d6-edb419b4be8a@huawei.com> <20230129134147.f19ca0641f1133f3e3bc185b@linux-foundation.org>
 <20230131150644.GA2605@willie-the-truck> <20230131150750.GB2605@willie-the-truck>
In-Reply-To: <20230131150750.GB2605@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 31 Jan 2023 17:03:32 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGaxehOcrQqFZNA+C3dTk_H8sBr_1wsN3_KN82nXVaG_g@mail.gmail.com>
Message-ID: <CAMj1kXGaxehOcrQqFZNA+C3dTk_H8sBr_1wsN3_KN82nXVaG_g@mail.gmail.com>
Subject: Re: [PATCH RFC] arm64/vmalloc: use module region only for
 module_alloc() if CONFIG_RANDOMIZE_BASE is set
To:     Will Deacon <will@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 at 16:07, Will Deacon <will@kernel.org> wrote:
>
> Now really adding Ard...
>
> On Tue, Jan 31, 2023 at 03:06:44PM +0000, Will Deacon wrote:
> > +Ard -- full thread here:
> >
> > https://lore.kernel.org/all/20221227092634.445212-1-liushixin2@huawei.com/
> >
> > On Sun, Jan 29, 2023 at 01:41:47PM -0800, Andrew Morton wrote:
> > > On Sun, 29 Jan 2023 10:44:31 +0800 Liu Shixin <liushixin2@huawei.com> wrote:
> > >
> > > > Hi,
> > > >
> > > >
> > > > This patch seems to have been lost in the corner. Recently I've meet this problem again
> > > >
> > > > on v6.1, so I would like to propose this patch again.
> > > >
> > > >
> > > > Thanks,
> > > >
> > > >
> > > > On 2022/12/27 17:26, Liu Shixin wrote:
> > > > > After I add a 10GB pmem device, I got the following error message when
> > > > > insert module:
> > > > >
> > > > >  insmod: vmalloc error: size 16384, vm_struct allocation failed,
> > > > >  mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
> > > > >
> > > > > If CONFIG_RANDOMIZE_BASE is set, the module region can be located in the
> > > > > vmalloc region entirely. Although module_alloc() can fall back to a 2GB
> > > > > window if ARM64_MODULE_PLTS is set, the module region is still easily
> > > > > exhausted because the module region is located at bottom of vmalloc region
> > > > > and the vmalloc region is allocated from bottom to top.
> > > > >
> > > > > Skip module region if not calling from module_alloc().
> > > > >
> > >
> > > I'll assume this is for the arm tree.
> > >
> > > Acked-by: Andrew Morton <akpm@linux-foundation.org>
> >
> > This looks like the same issue previously reported at:
> >
> > https://lore.kernel.org/all/e6a804de-a5f7-c551-ffba-e09d04e438fc@hisilicon.com/
> >
> > where Ard had a few suggestions but, afaict, they didn't help.
> >

Thanks for the cc.

So this is a bit clunky, and I wonder whether we wouldn't be better
off just splitting the vmalloc region into two separate regions: one
for the kernel and modules, and one for everything else. That way, we
lose one bit of entropy in the randomized placement, but the default
48-bit VA space is vast anway, and even on 39-bit VA configs (such as
Android), I seriously doubt that we come anywhere close to exhausting
the vmalloc space today.
