Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0D15FACF8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJKGkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJKGkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:40:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E63C13E8F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 23:40:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EC98A67373; Tue, 11 Oct 2022 08:40:10 +0200 (CEST)
Date:   Tue, 11 Oct 2022 08:40:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: Issue seen since commit f5ff79fddf0e ("dma-mapping: remove
 CONFIG_DMA_REMAP")
Message-ID: <20221011064010.GA3646@lst.de>
References: <20221010185739.vgw27m7fpmftly3q@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010185739.vgw27m7fpmftly3q@cantor>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 11:57:39AM -0700, Jerry Snitselaar wrote:
> I still need to grab a system and try to see what it is doing on the
> subsequent shutdowns, because it seems to me that any time
> bnx2fc_free_session_resc() is called it will end up there, unless the
> allocs are not coming from vmalloc() in the later boots. Between the
> comments in dma_free_attrs(), and preempt.h, dma_free_coherent()
> shouldn't be called under a spin_lock_bh(), yes?

It shouldn't.  And you would have seen the same BUG_ON on many non-x86
architectures even beforethe commit..

> I think the comments
> in dma_free_attrs() might be out of date with commit f5ff79fddf0e
> ("dma-mapping: remove CONFIG_DMA_REMAP") in place since now it is more
> general that you can land in vunmap().

Yes, the comment has always been a bit too specific, and is even more
so now.

> Also, should that WARN_ON() in
> dma_free_attrs() trigger as well for the BH disabled case?

Probably.  And we should probably early return in that case to "just"
leak the memory instead of crashing the kernel when called from a buggy
driver.
