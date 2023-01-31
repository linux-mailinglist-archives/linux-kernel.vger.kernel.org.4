Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7377468310A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjAaPOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjAaPN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:13:58 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3C611159
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:11:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6D0E6CE1ED3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 15:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A15C4339C;
        Tue, 31 Jan 2023 15:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675177610;
        bh=R35cnbiI7703GH9oQ1vqbYJjiahLzQi/FCcJNYTNJeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LIf+cf55yjz7LoJvlBEDfzMq0+pGRy/Qn63QvKHnM1ps8mFpq/0rZrzUW45gumAye
         55QGiGsgYXnfh6HisPqmM2q/gttobg/d+KCN8qJDuXUAyTHrNsaT97VDxdzzvsq98M
         5fAijsqYMUm5UazzmOxx17EfD6bb8xdmb6T0OrJ1gHugJ6Z8tTMlWX++FTE7MPoWsa
         GTCWfOr8Sw65YE57EvsqsdxM0zC5bg7RMSAc7iCeo+QzhtbuGmYYzvbYHQM4qAFCmD
         dIGvfWypxj5mvDUDVQPRJf5E8OKK/PU7BQB42MLNyCCVUCQMth80ScJNFJeKpzK5Ek
         eycfE2riHfCBw==
Date:   Tue, 31 Jan 2023 15:06:45 +0000
From:   Will Deacon <will@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH RFC] arm64/vmalloc: use module region only for
 module_alloc() if CONFIG_RANDOMIZE_BASE is set
Message-ID: <20230131150644.GA2605@willie-the-truck>
References: <20221227092634.445212-1-liushixin2@huawei.com>
 <b93ec55c-f6f0-274a-e7d6-edb419b4be8a@huawei.com>
 <20230129134147.f19ca0641f1133f3e3bc185b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129134147.f19ca0641f1133f3e3bc185b@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Ard -- full thread here:

https://lore.kernel.org/all/20221227092634.445212-1-liushixin2@huawei.com/

On Sun, Jan 29, 2023 at 01:41:47PM -0800, Andrew Morton wrote:
> On Sun, 29 Jan 2023 10:44:31 +0800 Liu Shixin <liushixin2@huawei.com> wrote:
> 
> > Hi,
> > 
> > 
> > This patch seems to have been lost in the corner. Recently I've meet this problem again
> > 
> > on v6.1, so I would like to propose this patch again.
> > 
> > 
> > Thanks,
> > 
> > 
> > On 2022/12/27 17:26, Liu Shixin wrote:
> > > After I add a 10GB pmem device, I got the following error message when
> > > insert module:
> > >
> > >  insmod: vmalloc error: size 16384, vm_struct allocation failed,
> > >  mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
> > >
> > > If CONFIG_RANDOMIZE_BASE is set, the module region can be located in the
> > > vmalloc region entirely. Although module_alloc() can fall back to a 2GB
> > > window if ARM64_MODULE_PLTS is set, the module region is still easily
> > > exhausted because the module region is located at bottom of vmalloc region
> > > and the vmalloc region is allocated from bottom to top.
> > >
> > > Skip module region if not calling from module_alloc().
> > >
> 
> I'll assume this is for the arm tree.
> 
> Acked-by: Andrew Morton <akpm@linux-foundation.org>

This looks like the same issue previously reported at:

https://lore.kernel.org/all/e6a804de-a5f7-c551-ffba-e09d04e438fc@hisilicon.com/

where Ard had a few suggestions but, afaict, they didn't help.

Will
