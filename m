Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F113465F528
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 21:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjAEUYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 15:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbjAEUX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 15:23:59 -0500
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F308663395;
        Thu,  5 Jan 2023 12:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=AwykE9t8HX+ccqioZoqmMDcWX+0113uDvxTCtog81Go=; b=UguTRvNXENnlhVuV+CHKQ3KBf7
        pqRNf6pmcyqhWx4Zy8Rc+0zeh8EJETQMs67dpbSR6dnOji4xjs/Q6gszpnSAgv9i0n7v/pRgFHtQt
        K1PyJ98q3eyNuDBriKer+LOhx2/Ff+ijOiv2rawPei1j8B+LATZ7ZGhsg5nn2xN72pL7i66ARYzbj
        3GAyhGPS0ByzsF0OxReHVMr0WXj1OeGqiyb49FSaxN+Yu/FXvq3kFXeRv3REr2II/uTm2Z0FvyUsX
        Nxbj5mCw3z7bY+v5M9TGaY0iHcr0lfolMmFbPG5XB9Ba3umN8wR/JeNjZZXWqT18CEjCupbL1md93
        Jnm9cfVA==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1pDWmI-0085pV-7d; Thu, 05 Jan 2023 13:23:55 -0700
Message-ID: <81470f28-2bcf-b3cc-4824-6e45343dbd77@deltatee.com>
Date:   Thu, 5 Jan 2023 13:23:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-CA
To:     Jason Gunthorpe <jgg@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, axboe@kernel.dk, hch@lst.de,
        alex.williamson@redhat.com, leonro@nvidia.com, maorg@nvidia.com
References: <20230105112339.107969-1-yishaih@nvidia.com>
 <Y7ctsw8ffhSsBZ4v@nvidia.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <Y7ctsw8ffhSsBZ4v@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: jgg@nvidia.com, yishaih@nvidia.com, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org, axboe@kernel.dk, hch@lst.de, alex.williamson@redhat.com, leonro@nvidia.com, maorg@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH] lib/scatterlist: Fix to merge contiguous pages into the
 last SG properly
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-01-05 13:06, Jason Gunthorpe wrote:
> On Thu, Jan 05, 2023 at 01:23:39PM +0200, Yishai Hadas wrote:
>> When sg_alloc_append_table_from_pages() calls to pages_are_mergeable()
>> in its 'sgt_append->prv' flow to check whether it can merge contiguous
>> pages into the last SG, it passes the page arguments in the wrong order.
>>
>> The first parameter should be the next candidate page to be merged to
>> the last page and not the opposite.
>>
>> The current code leads to a corrupted SG which resulted in OOPs and
>> unexpected errors when non-contiguous pages are merged wrongly.
>>
>> Fix to pass the page parameters in the right order.
>>
>> Fixes: 1567b49d1a40 ("lib/scatterlist: add check when merging zone device pages")
>> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
>> ---
>>  lib/scatterlist.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> rdma is pretty much the only user of this API and this bug is causing
> bad data corruption, so I'm going to take it to the rdma tree and send
> it tomorrow.
> 
> Which raises the question why the original patch was done at all,
> nothing ever inputs pgmap pages into this function?

It was done solely because you had suggested it was necessary.

https://lore.kernel.org/all/20210929224653.GZ964074@nvidia.com/

Though when the patch was correct when I originally wrote it and it
looks like I merged it poorly somewhere along the line (roughly v5 of
the series) when the paddr stuff was added. Sorry about that.
The paddr stuff was messy and really hard to understand.

Anyway, Yishai's first patch looks correct to me, but I guess we need to
fix it further. For what it's worth:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan
