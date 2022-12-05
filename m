Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD69C642705
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiLEK7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiLEK7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:59:25 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE65DF9B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 02:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670237965; x=1701773965;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0r3wxVCGy6G0BMnzzdGpVeQGjb8W76c+24ugWD44qhI=;
  b=b01Qp1d4oKB33m9a1CsN4yJhCqrR+VbxZPRi5rnU/9p0c1lnbZzV0Myj
   Zs4Q4rt7VhclQwN0J6W5KjrttZeZIwuf29D6LYKmJ3dqCvIOlDKwat+p6
   z/q3cz1TPaLwKaNyDXhQ66G6kgat+k8m9T1g+2upN3Uko//HmVyoyhBgw
   08OX6ioNKu7vvubbPg0wedNfL4WMtqPbzHxk6rzRWzl2DFLfAITh8+2V7
   5DdJjzrxHN5ZsFaeLFYIrJrzY/0RWfx+EKtX/ayWBTUb6zljuf13oCWzA
   LpXTX0XGRWBc52ZiALqE03BWMWxfUpVWiC+yL0q2CNlkOu/XXkzzwjz2u
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="303938620"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="303938620"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 02:59:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="596158262"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="596158262"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.227]) ([10.254.213.227])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 02:59:21 -0800
Message-ID: <b64c5b16-79bd-182d-354b-73a74430a8cc@linux.intel.com>
Date:   Mon, 5 Dec 2022 18:59:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Cc:     baolu.lu@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Yuzhang Luo <yuzhang.luo@intel.com>
Subject: Re: [PATCH v3] iommu/vt-d: Add a fix for devices need extra dtlb
 flush
To:     Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20221130062449.1360063-1-jacob.jun.pan@linux.intel.com>
 <Y43LUVS1heMxGBC7@8bytes.org>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y43LUVS1heMxGBC7@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/5 18:43, Joerg Roedel wrote:
> On Tue, Nov 29, 2022 at 10:24:49PM -0800, Jacob Pan wrote:
>>   drivers/iommu/intel/iommu.c | 67 +++++++++++++++++++++++++++++++++++--
>>   drivers/iommu/intel/iommu.h |  3 ++
>>   drivers/iommu/intel/svm.c   |  5 ++-
>>   3 files changed, 72 insertions(+), 3 deletions(-)
> I removed this commit from my fixes branch. Please re-submit with the
> fix included and I will queue it for 6.2 once Lu Baolu acked it.

But this patch has already been merged in v6.1-rc7.

https://lore.kernel.org/linux-iommu/Y4oF8e7quzjm2kzD@8bytes.org/

Is this still feasible?

Best regards,
baolu
