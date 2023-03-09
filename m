Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00646B1910
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 03:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjCICJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 21:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCICJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 21:09:09 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14EC93E04
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 18:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678327746; x=1709863746;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h7L7WFI4DwTz9+2kCVoTF5JK2hgOIRTigia0Dllu/WQ=;
  b=OO26IqqrsUS2/DHor8H/ePcts6tLnja2gPlG0kLk1FE82gl9kcEqg+ZQ
   NDHoxFjJmpBUO/kVvte/747gJlXnrXkJZ9kTOFZSNmaKTFE0VpmPKj27z
   6qRCM10Gqh0N1nYF7fz2aqUkN+Q4DVppcoLrlM5tCwwloGE2gpyU/zBrT
   G4JJWNyEWXnmpIH1c416dMESsg9G5SWkTk5ITTqd5+z9GcdrsbSoinAYN
   4nBihrc2vRelkKgl5lts6HC0CFYZ8cxNXMnyIkGUPmOkdkim1OwV+r3WB
   Z6hMMSLNKzSsYudspkrVwTmzKh4vbk3LyEZfnfoIlpVSHvqYkMfTGWhqI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="335036049"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="335036049"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 18:09:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="746132715"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="746132715"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga004.fm.intel.com with ESMTP; 08 Mar 2023 18:09:03 -0800
Message-ID: <c1c8cc6f-6553-e60d-838e-dfaf06e3e412@linux.intel.com>
Date:   Thu, 9 Mar 2023 10:08:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] iommu: sprd: release dma buffer to avoid memory leak
Content-Language: en-US
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20230308034158.509458-1-chunyan.zhang@unisoc.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230308034158.509458-1-chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 11:41 AM, Chunyan Zhang wrote:
> Release page table DMA buffer when the IOMMU domain is not used:
> 
> - Domain freed.
> 
> - IOMMU is attaching to a new domain.
>    Since one sprd IOMMU servers only one client device, if the IOMMU has
>    been attached to other domain, it has to be detached first, that's
>    saying the DMA buffer should be released, otherwise that would
>    cause memory leak issue.
> 
> Signed-off-by: Chunyan Zhang<chunyan.zhang@unisoc.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
