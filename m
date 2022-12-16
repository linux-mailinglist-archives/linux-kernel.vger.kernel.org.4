Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4161D64EB9F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 13:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiLPMxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 07:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLPMxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 07:53:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D463724979
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 04:53:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 112861042;
        Fri, 16 Dec 2022 04:53:43 -0800 (PST)
Received: from [10.57.88.234] (unknown [10.57.88.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44FBC3F5A1;
        Fri, 16 Dec 2022 04:53:01 -0800 (PST)
Message-ID: <f77a41bd-9df7-87c0-9b3c-e9e1a5deaa63@arm.com>
Date:   Fri, 16 Dec 2022 12:52:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [6.2][regression] after commit
 ffcb754584603adf7039d7972564fbf6febdc542 all sound devices disappeared (due
 BUG at mm/page_alloc.c:3592!)
Content-Language: en-GB
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        m.szyprowski@samsung.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        iommu@lists.linux.dev
References: <CABXGCsPnpu0TGHnvXM1we7q1t3tJAOYW2rA=AMvf7ZahcYvpRQ@mail.gmail.com>
 <20221216064645.GA24446@lst.de>
 <a76cb262-a24f-e113-5680-2025aa143ee6@arm.com> <20221216121519.GA5710@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221216121519.GA5710@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-16 12:15, Christoph Hellwig wrote:
> On Fri, Dec 16, 2022 at 11:40:57AM +0000, Robin Murphy wrote:
>> On 2022-12-16 06:46, Christoph Hellwig wrote:
>>> Ok, it seems like the sound noncontig alloc code that I already
>>> commented on as potentially bogus GFP_GOMP mapping trips this.  I think
>>> for now the right thing would be to revert the hunk in dma-iommu.c
>>> (see patch below).  The other thing to try would be to remove both
>>> uses GFP_COMP in sound/core/memalloc.c, which should have the same
>>> effect.
>>
>> Or we explicitly strip the flag in dma_alloc_noncontiguous() (and maybe
>> dma_alloc_pages() as well) for consistency with dma_alloc_attrs(). That
>> seems like it might be the most robust option.
> 
> In the long run warning there and returning an error seems like the
> right thing to do, yes. I'm just a little worried doing this right now
> after the merge window.

Fair point, I guess nobody else actually implements 
dma_alloc_noncontiguous(), and dma_alloc_pages() seems a bit of a grey 
area since it is more of an explicit page allocator. So yeah, just 
restoring iommu-dma (perhaps with a mild VM_WARN_ON?) seems like a 
sufficiently safe and sensible fix for the short term. You can have my 
pre-emptive ack for that.

Cheers,
Robin.
