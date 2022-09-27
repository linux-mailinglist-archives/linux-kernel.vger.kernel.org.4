Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67C85EC5B5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiI0OP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiI0OPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:15:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A3A0D33DA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:15:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5935C1063;
        Tue, 27 Sep 2022 07:15:23 -0700 (PDT)
Received: from [10.57.65.170] (unknown [10.57.65.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57AD93F73B;
        Tue, 27 Sep 2022 07:15:15 -0700 (PDT)
Message-ID: <fe2b1f48-e18a-b1d9-0c62-ddddf9e6515f@arm.com>
Date:   Tue, 27 Sep 2022 15:15:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] iommu/io-pgtable: Make IOMMU_IO_PGTABLE_DART invisible
Content-Language: en-GB
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
        Hector Martin <marcan@marcan.st>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <b0981cb5a97452af73b9dd0dd0eb03c5002f7af4.1664285626.git.geert+renesas@glider.be>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <b0981cb5a97452af73b9dd0dd0eb03c5002f7af4.1664285626.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-27 14:36, Geert Uytterhoeven wrote:
> There is no point in asking the user about both "Apple DART Formats" and
> "Apple DART IOMMU Support", as the former is useless without the latter,
> and the latter auto-selects the former.
> 
> Fixes: 745ef1092bcfcf3b ("iommu/io-pgtable: Move Apple DART support to its own file")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Should IOMMU_IO_PGTABLE_LPAE and IOMMU_IO_PGTABLE_ARMV7S be made
> invisible, too?
> Are there users that do not select them?

The aim was for formats to be independently selectable for COMPILE_TEST 
coverage. The Arm formats are manually selectable for the sake of their 
runtime self-tests, which are self-contained, but since DART format 
doesn't do anything by itself I'd agree there's no need to prompt when 
!COMPILE_TEST here.

Thanks,
Robin.

> ---
>   drivers/iommu/Kconfig | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index dc5f7a156ff5ec73..f1affca6022e0a54 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -68,16 +68,13 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
>   	  If unsure, say N here.
>   
>   config IOMMU_IO_PGTABLE_DART
> -	bool "Apple DART Formats"
> +	bool
>   	select IOMMU_IO_PGTABLE
> -	depends on ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
>   	help
>   	  Enable support for the Apple DART pagetable formats. These include
>   	  the t8020 and t6000/t8110 DART formats used in Apple M1/M2 family
>   	  SoCs.
>   
> -	  If unsure, say N here.
> -
>   endmenu
>   
>   config IOMMU_DEBUGFS
