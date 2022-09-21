Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D9C5BFEDE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 15:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiIUNUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 09:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiIUNUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 09:20:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 168D093514;
        Wed, 21 Sep 2022 06:20:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ADA9143D;
        Wed, 21 Sep 2022 06:20:57 -0700 (PDT)
Received: from [10.1.32.30] (010265703453.arm.com [10.1.32.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1985A3F73B;
        Wed, 21 Sep 2022 06:20:46 -0700 (PDT)
Message-ID: <11708ed1-b74a-5d45-0ce3-e2649dac1e8a@arm.com>
Date:   Wed, 21 Sep 2022 14:20:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v5 0/5] iommu: M1 Pro/Max DART support
Content-Language: en-GB
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>, Will Deacon <will@kernel.org>,
        devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Janne Grunau <j@jannau.net>
References: <20220916094152.87137-1-j@jannau.net>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220916094152.87137-1-j@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-16 10:41, Janne Grunau wrote:
> Hej,
> 
> this is the next attempt adding support for the DART found in Apple's
> M1 Pro/Max/Ultra. This adds a separate io-pgtable implementation for
> DART. As already mentioned in v2 the pte format is not fully compatible
> with io-pgtable-arm. Especially the 2nd least significant bit is used
> and is not available to tag tables/pages.
> io-pgtable-dart.c is copied from io-pgtable-arm.c and support for
> unused features is removed. Support for 4k IO pages is left for A7 to
> A11 SoCs as there's work underway to run Linux on them.
> 
> The incompatibilities between both Apple DART pte seems manageable in
> their own io-pgtable implementation. A short list of the known
> differences:
> 
>   - the physical addresses are shifted left by 4 bits and and have 2 more
>     bits inside the PTE entries
>   - the read/write protection flags are at a different position
>   - the subpage protection feature is now mandatory. For Linux we can
>     just configure it to always allow access to the entire page.
>   - BIT(1) tags "uncached" mappings (used for the display controller)
> 
> There is second type of DART (t8110) present on M1 Pro/Max SoCs which
> uses the same PTE format as t6000.

FWIW I think there's minimal risk in queueing this up as a late addition 
for 6.1, lest it get forgotten again. I've not been following it since 
I've been busy with other things and I largely trust that DART patches 
are well-tested, but from a quick skim it all earns a solid "yeah, why 
not" from me :)

Cheers,
Robin.

> Changes in v5:
> - collected Sven's ack
> - minor fixes in "iommu/io-pgtable: Move Apple DART support to its own
>    file"
> 
> Changes in v4:
> - split dart and io-pgtable-dart build to allow building dart as module
> - add missing "SELECT IOMMU_IO_PGTABLE"
> - made map/unmap_pages/iova_to_phys inon-recursive
> - replace pgd concatenation with multiple table handling
> - simplified config and page size checks
> - collected Robin's Ack
> 
> Changes in v3:
> - move APPLE_DART to its own io-pgtable implementation, copied from
>    io-pgtable-arm and simplified
> 
> Changes in v2:
> - added Rob's Acked-by:
> - add APPLE_DART2 io-pgtable format
> 
> Janne Grunau (1):
>    iommu/io-pgtable: Move Apple DART support to its own file
> 
> Sven Peter (4):
>    dt-bindings: iommu: dart: add t6000 compatible
>    iommu/io-pgtable: Add DART subpage protection support
>    iommu/io-pgtable-dart: Add DART PTE support for t6000
>    iommu: dart: Support t6000 variant
> 
>   .../devicetree/bindings/iommu/apple,dart.yaml |   4 +-
>   MAINTAINERS                                   |   1 +
>   drivers/iommu/Kconfig                         |  13 +-
>   drivers/iommu/Makefile                        |   1 +
>   drivers/iommu/apple-dart.c                    |  24 +-
>   drivers/iommu/io-pgtable-arm.c                |  63 ---
>   drivers/iommu/io-pgtable-dart.c               | 470 ++++++++++++++++++
>   drivers/iommu/io-pgtable.c                    |   3 +
>   include/linux/io-pgtable.h                    |   1 +
>   9 files changed, 512 insertions(+), 68 deletions(-)
>   create mode 100644 drivers/iommu/io-pgtable-dart.c
> 
