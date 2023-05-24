Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E92970F97D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbjEXO6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjEXO6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:58:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B496C1B4
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:57:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09C3F1042;
        Wed, 24 May 2023 07:57:49 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 139293F762;
        Wed, 24 May 2023 07:57:02 -0700 (PDT)
Message-ID: <b940e9f5-5770-73a4-d139-06af82fb482f@arm.com>
Date:   Wed, 24 May 2023 15:56:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4] iommu: Optimise PCI SAC address trick
Content-Language: en-GB
To:     Joerg Roedel <joro@8bytes.org>
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        John Garry <john.g.garry@oracle.com>
References: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
 <ZDk83vpIarQ9jWa7@8bytes.org> <cef7bb32-a302-2220-68a6-726b45f91769@arm.com>
 <ZGzkf68s_0H-jFS7@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZGzkf68s_0H-jFS7@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2023 5:06 pm, Joerg Roedel wrote:
> On Fri, Apr 14, 2023 at 06:45:57PM +0100, Robin Murphy wrote:
>> Sounds good - I'm considerably more confident in this approach, but although
>> it should not be able to break any scenario which wasn't already broken, it
>> could potentially still make such a breakage more noticeable. Thus in all
>> honesty I'd feel happiest giving it a full cycle of -next coverage as well.
> 
> I had some second thoughts on this, wouldn't it be better to change the
> allocator to allocate from lowest addresses first? Then we can just
> remove the SAC trick and rely on dma-masks only.
> 
> Thoughts?

Yes, in the long term I definitely would like to have a more flexible 
allocator - this is more of a stop-gap measure that's an easy win with 
what we have now.

Top-down allocation is nice in that it makes for easily recognisable DMA 
addresses, and does do a great job of flushing out bugs, but having the 
option of bottom-up allocation would definitely be useful in various 
cases - realistically it's pretty much a prerequisite for converting 
arch/arm to use iommu-dma. However, given all the other scalability 
issues that keep coming to light, I think that's going to be the tipping 
point for ripping up the existing code and giving it a major overhaul, 
which I would love to be able to get stuck in to, but don't have the 
capacity for at the moment.

Thanks,
Robin.
