Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BB76801BD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 22:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbjA2Vly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 16:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjA2Vlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 16:41:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F06144BB
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 13:41:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 693FEB80DBE
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 21:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93234C433D2;
        Sun, 29 Jan 2023 21:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1675028508;
        bh=hqXHTO4VkNQRccP0ht1WlUlKvTkgK5Dy4nZapxrAJPw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XIojVudBxrOJhjBRRvRiy+4k16/u4kp1zbQwV9TS/l210sipQl1kb+pKGFKMiqcwl
         nn6Uzusfp1gjNyW518MN8oXHnXMQWooV3x57CK0cSuaZLDD7RzynjNZ/iPqbaLHUcs
         MQnptE2bVS1qXGchZq62tR8LUM+dkbUTAybnrL8o=
Date:   Sun, 29 Jan 2023 13:41:47 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH RFC] arm64/vmalloc: use module region only for
 module_alloc() if CONFIG_RANDOMIZE_BASE is set
Message-Id: <20230129134147.f19ca0641f1133f3e3bc185b@linux-foundation.org>
In-Reply-To: <b93ec55c-f6f0-274a-e7d6-edb419b4be8a@huawei.com>
References: <20221227092634.445212-1-liushixin2@huawei.com>
        <b93ec55c-f6f0-274a-e7d6-edb419b4be8a@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jan 2023 10:44:31 +0800 Liu Shixin <liushixin2@huawei.com> wrote:

> Hi,
> 
> 
> This patch seems to have been lost in the corner. Recently I've meet this problem again
> 
> on v6.1, so I would like to propose this patch again.
> 
> 
> Thanks,
> 
> 
> On 2022/12/27 17:26, Liu Shixin wrote:
> > After I add a 10GB pmem device, I got the following error message when
> > insert module:
> >
> >  insmod: vmalloc error: size 16384, vm_struct allocation failed,
> >  mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
> >
> > If CONFIG_RANDOMIZE_BASE is set, the module region can be located in the
> > vmalloc region entirely. Although module_alloc() can fall back to a 2GB
> > window if ARM64_MODULE_PLTS is set, the module region is still easily
> > exhausted because the module region is located at bottom of vmalloc region
> > and the vmalloc region is allocated from bottom to top.
> >
> > Skip module region if not calling from module_alloc().
> >

I'll assume this is for the arm tree.

Acked-by: Andrew Morton <akpm@linux-foundation.org>
