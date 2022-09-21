Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E4D5BF8A9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiIUILJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIUILH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:11:07 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A67086FE9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:11:02 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id n15so1599399wrq.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Iu59F2yjjnSxMinTkBcnO/aIj/eLxi+uzNZPz+D0Xj4=;
        b=RbXM4TpkTQIyax8avgskln7vu4hEsr7VxKKCVOj0Ojj0ikVV6iSt4j5ELBkRoRfawu
         xfrrN58oWHDOB8wsYtP4wqffMeO2VtWcqd6WARFtiewC1SD+a7eyjs5sBr4vZAIVmg+k
         aV2VHeN9uHRpdzelhXWPSPyQWS2nYvbcYRT8i4tCLQ/Nf0gIa+POscwR4e/l/xL4Tn2d
         zsA9Nn4tfsfrCmvt3vzPby4BdeBQObUkc/+jYKPSdqgRVV1DdzFq+tqxOIghEZZ8AxUO
         NF/cQ/oM/PTkNORzbChT/NGqjaCLXseIBOtTcmA7n90it+8D3VG52JIMIJG+zjm27/vj
         YM6w==
X-Gm-Message-State: ACrzQf3fzrAO8Ok7r4MdNsWnwXPjMGUfHHAk+ZVqsxjnxyyAHRDPSa4P
        UInXJS424pkwfpV2+ST6l4E=
X-Google-Smtp-Source: AMsMyM7QiaZiVKEESkFqK79/DIVCfrBFdt0Oww5MRhd+O/TFHWAGAGnuMbY6OC9J0k2l9jgEt+4E5A==
X-Received: by 2002:adf:dc4c:0:b0:22a:42eb:1e34 with SMTP id m12-20020adfdc4c000000b0022a42eb1e34mr16706381wrj.258.1663747860533;
        Wed, 21 Sep 2022 01:11:00 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b003b482fbd93bsm1980372wmq.24.2022.09.21.01.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 01:11:00 -0700 (PDT)
Message-ID: <871c0e19-9272-e92b-28dc-a50ae705bba8@grimberg.me>
Date:   Wed, 21 Sep 2022 11:10:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme-pci: Set min align mask before calculating
 max_hw_sectors
Content-Language: en-US
To:     Rishabh Bhatnagar <risbhat@amazon.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, axboe@fb.com, kbusch@kernel.org, mbacco@amazon.com
References: <20220920191932.22797-1-risbhat@amazon.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220920191932.22797-1-risbhat@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> If swiotlb is force enabled dma_max_mapping_size ends up calling
> swiotlb_max_mapping_size which takes into account the min align
> mask for the device.
> Set the min align mask for nvme driver before calling
> dma_max_mapping_size while calculating max hw sectors.

Does this fix a specific bug? if so it needs a fixes tag so it can
go to stable backports as well.

> 
> Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>
> ---
>   drivers/nvme/host/pci.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 98864b853eef..30e71e41a0a2 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2834,6 +2834,8 @@ static void nvme_reset_work(struct work_struct *work)
>   		nvme_start_admin_queue(&dev->ctrl);
>   	}
>   
> +	dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);
> +
>   	/*
>   	 * Limit the max command size to prevent iod->sg allocations going
>   	 * over a single page.
> @@ -2846,7 +2848,6 @@ static void nvme_reset_work(struct work_struct *work)
>   	 * Don't limit the IOMMU merged segment size.
>   	 */
>   	dma_set_max_seg_size(dev->dev, 0xffffffff);
> -	dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);
>   
>   	mutex_unlock(&dev->shutdown_lock);
>   
