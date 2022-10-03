Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F195F358F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 20:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiJCSY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 14:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiJCSYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 14:24:18 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE88DDF83;
        Mon,  3 Oct 2022 11:24:15 -0700 (PDT)
Message-ID: <cce74aec-61b1-d5eb-1b62-746e45ebfe69@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664821453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vWgkp1Uhseyx7z8GnHpVT62F43ADCuiKPEXkLOgZNbI=;
        b=YRgrt7JRLHcpvwYwlIH4rVoSJiv1DhfNg2g89dUUxTKGbycBChtZGpUNjYqErnK8NfQNvR
        veoeXGNsCx0ez+BLZkSuaj2fSlxnriYeiuQL+mKbjg4FnI2/7tdvqWSUZR3N2hVhkJ+qhf
        cgnsekMDz2NBGYZ0DvH00GlzEtO9E8c=
Date:   Mon, 3 Oct 2022 12:24:08 -0600
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] block: sed-opal: Cache-line-align the cmd/resp
 buffers
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>,
        Rafael Antognolli <Rafael.Antognolli@intel.com>,
        Scott Bauer <scott.bauer@intel.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
 <20220929224648.8997-4-Sergey.Semin@baikalelectronics.ru>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20220929224648.8997-4-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 9/29/2022 4:46 PM, Serge Semin wrote:
> In accordance with [1] the DMA-able memory buffers must be
> cacheline-aligned otherwise the cache writing-back and invalidation
> performed during the mapping may cause the adjacent data being lost. It's
> specifically required for the DMA-noncoherent platforms. Seeing the
> opal_dev.{cmd,resp} buffers are used for DMAs in the NVME and SCSI/SD
> drivers in framework of the nvme_sec_submit() and sd_sec_submit() methods
> respectively we must make sure the passed buffers are cacheline-aligned to
> prevent the denoted problem.
> 
> [1] Documentation/core-api/dma-api.rst
> 
> Fixes: 455a7b238cd6 ("block: Add Sed-opal library")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>   block/sed-opal.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 9700197000f2..222acbd1f03a 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -73,6 +73,7 @@ struct parsed_resp {
>   	struct opal_resp_tok toks[MAX_TOKS];
>   };
>   
> +/* Presumably DMA-able buffers must be cache-aligned */
>   struct opal_dev {
>   	bool supported;
>   	bool mbr_enabled;
> @@ -88,8 +89,8 @@ struct opal_dev {
>   	u64 lowest_lba;
>   
>   	size_t pos;
> -	u8 cmd[IO_BUFFER_LENGTH];
> -	u8 resp[IO_BUFFER_LENGTH];
> +	u8 cmd[IO_BUFFER_LENGTH] ____cacheline_aligned;
> +	u8 resp[IO_BUFFER_LENGTH] ____cacheline_aligned;
I'm with Christoph on this one.
When I see ____cacheline_aligned, I assume its for performance reasons, 
not to work around a DMA limitation. Can we instead kmalloc (which 
provides alignment) these buffers to make it more clear? May want to add 
that same comment pointing out some architectures require these dma 
targets to be cache aligned.


>   
>   	struct parsed_resp parsed;
>   	size_t prev_d_len;
