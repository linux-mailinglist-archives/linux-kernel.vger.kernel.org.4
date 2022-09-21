Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28835BF3EA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 04:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiIUCtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 22:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiIUCtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 22:49:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5635763D5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 19:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663728578; x=1695264578;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SpwZqyP/NsakNUiAYbXlk6VtCsQb6pxkSE0VYT9lA+E=;
  b=VrcUwlUiGrzHbCohTfT4Ofj1MJHRT4xPHfVZsGykxaOQ1IjvyBV/MRAk
   bh8Bhzj22cZHYDe1COIqq1dmC1QYCk4aFVdmK9F80UZ1mB2zAfEhnIQTx
   fzAe8Ra1r0oMrSpRkSmIcdNzejY2nZC6CwJDG8G+AKGXKQLM39j+Y1TP5
   uh+iTxdEvMHEa1RlDfHxXhiTNr5CkH+74gfidjDOT5RGkZqbVtrREjpRv
   VF0vfXF+DDE0jme4BdN5x06HmnDf9Zda1s7OWyWatLoDn1gPxFVQr8lux
   tld6Hc/gD1aVlqMRDyGF88dhqOUHt9htxK+fB0IN2UJ5JO3n8NngIw/aV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="279606658"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="279606658"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 19:49:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="794500836"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga005.jf.intel.com with ESMTP; 20 Sep 2022 19:49:35 -0700
Message-ID: <4dc8f9a4-c2cb-261e-21e7-37b2d29c7332@linux.intel.com>
Date:   Wed, 21 Sep 2022 10:43:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        George Hilliard <thirtythreeforty@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Revert "iommu/vt-d: Fix possible recursive locking in
 intel_iommu_init()"
Content-Language: en-US
To:     iommu@lists.linux.dev
References: <20220920081701.3453504-1-baolu.lu@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220920081701.3453504-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/22 4:17 PM, Lu Baolu wrote:
> This reverts commit 9cd4f1434479f1ac25c440c421fbf52069079914.
> 
> Some issues were reported on the original commit. Some thunderbolt devices
> don't work anymore due to the following DMA fault.
> 
> DMAR: DRHD: handling fault status reg 2
> DMAR: [INTR-REMAP] Request device [09:00.0] fault index 0x8080
>        [fault reason 0x25]
>        Blocked a compatibility format interrupt request
> 
> Bring it back for now to avoid functional regression.
> 
> Fixes: 9cd4f1434479f ("iommu/vt-d: Fix possible recursive locking in intel_iommu_init()")
> Link:https://lore.kernel.org/linux-iommu/485A6EA5-6D58-42EA-B298-8571E97422DE@getmailspring.com/
> Link:https://bugzilla.kernel.org/show_bug.cgi?id=216497
> Cc: Mika Westerberg<mika.westerberg@linux.intel.com>
> Reported-and-tested-by: George Hilliard<thirtythreeforty@gmail.com>
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>

Queued for v6.0.

https://lore.kernel.org/linux-iommu/20220921024054.3570256-1-baolu.lu@linux.intel.com

Best regards,
baolu
