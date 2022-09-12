Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47C25B5963
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 13:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiILLh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 07:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiILLhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 07:37:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86F4931229;
        Mon, 12 Sep 2022 04:37:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA6F5113E;
        Mon, 12 Sep 2022 04:37:59 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A6583F71A;
        Mon, 12 Sep 2022 04:37:52 -0700 (PDT)
Message-ID: <fc02df92-2092-d7c2-fed5-f9db26846c07@arm.com>
Date:   Mon, 12 Sep 2022 12:37:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: linux-next: build failure after merge of the coresight tree
Content-Language: en-GB
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220912154219.162eb9d3@canb.auug.org.au>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220912154219.162eb9d3@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-12 06:42, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the coresight tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/hwtracing/ptt/hisi_ptt.c:13:10: fatal error: linux/dma-iommu.h: No such file or directory
>     13 | #include <linux/dma-iommu.h>
>        |          ^~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>    ff0de066b463 ("hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device")
> 
> interacting with commit
> 
>    f2042ed21da7 ("iommu/dma: Make header private")
> 
> from the iommu tree.
> 
> Since the public interfaces in dna-iommu.h were moved to iommu.h, I have
> applied the following merge fix patch:

In fact it's not even using those interfaces anyway, so never had any 
reason to include dma-iommu.h in the first place, and Mathieu can make 
this fix in the Coresight tree as-is. FWIW,

Acked-by: Robin Murphy <robin.murphy@arm.com>

> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 12 Sep 2022 15:35:37 +1000
> Subject: [PATCH] hwtracing: hihi_ptt: fix up for "iommu/dma: Make header private"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>   drivers/hwtracing/ptt/hisi_ptt.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index 666a0f14b6c4..5d5526aa60c4 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -10,7 +10,6 @@
>   #include <linux/bitops.h>
>   #include <linux/cpuhotplug.h>
>   #include <linux/delay.h>
> -#include <linux/dma-iommu.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/interrupt.h>
>   #include <linux/io.h>
