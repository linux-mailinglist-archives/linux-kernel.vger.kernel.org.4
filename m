Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30835680627
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 07:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbjA3Gqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 01:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbjA3Gq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:46:29 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D87144A0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 22:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675061188; x=1706597188;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DBy9ACt6QqbTYSWYlb9yQn7TbaVQV5Up/Ns12kloQi4=;
  b=gJeDnGqMVRyFoEoJRcGzYu6gkjPPdwvaFvXQ012ETfS1g8QWHtbVirNi
   kvNAAENdtpesIwfI1xPP76pBIWzLhBMxu5qsb6bTyYPPKk8/gNaZt7jCU
   jDVFiuqPj5RTYscVtQ5nBBL0Gp+fNLwY3+teJLQ743slr+F1R9Gn4nga3
   H6J4b4JTMwAHfZ7rWh6Jj5TuCRRrkN2h8/dgDnCAXJegBI/pSYK5WaglU
   gYgd9z4WdEUzbNVLLaz858bm27TxWvLbyJ8QI3/UViyds93Jp8fPS5HGH
   bIz4dsw0Az3hMKzIn2o/gSEZ+sF9EPdxBCc6jzQGsjY6XkcInTfkDSJxd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="327501754"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="327501754"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 22:46:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="696299830"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="696299830"
Received: from akleen-mobl3.amr.corp.intel.com (HELO [10.212.149.210]) ([10.212.149.210])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 22:46:23 -0800
Message-ID: <09a56915-7ce2-b70c-33ec-3a8767269637@linux.intel.com>
Date:   Sun, 29 Jan 2023 22:46:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/4] swiotlb: Add a new cc-swiotlb implementation for
 Confidential VMs
Content-Language: en-US
To:     Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        konrad.wilk@oracle.com, linux-coco@lists.linux.dev
Cc:     robin.murphy@arm.com
References: <20230128083254.86012-1-GuoRui.Yu@linux.alibaba.com>
 <20230128083254.86012-3-GuoRui.Yu@linux.alibaba.com>
 <9b167caf-1b10-f97a-d96a-b7ead8e785e8@linux.intel.com>
 <2ec59355-c8d5-c794-16e8-7d646b43c455@linux.alibaba.com>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <2ec59355-c8d5-c794-16e8-7d646b43c455@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> I try to solve this problem by creating a new kernel thread, "kccd", 
> to populate the TLB buffer in the backgroud.
>
> Specifically,
> 1. A new kernel thread is created with the help of "arch_initcall", 
> and this kthread is responsible for memory allocation and setting 
> memory attributes (private or shared);
> 2. The "swiotlb_tbl_map_single" routine only use the spin_lock 
> protected TLB buffers pre-allocated by the kthread;
>   a) which actually includes ONE memory allocation brought by xarray 
> insertion "__xa_insert__".

That already seems dangerous with all the usual problems of memory 
allocations in IO paths. Normally code at least uses a mempool to avoid 
the worst dead lock potential.

> 3. After each allocation, the water level of TLB resources will be 
> checked. If the current TLB resources are found to be lower than the 
> preset value (half of the watermark), the kthread will be awakened to 
> fill them.
> 4. The TLB buffer allocation in the kthread is batched to 
> "(MAX_ORDER_NR_PAGES << PAGE_SHIFT)" to reduce the holding time of 
> spin_lock and number of calls to set_memory_decrypted().

Okay, but does this guarantee that it will never run out of memory?

It seems difficult to make such guarantees. What happens for example if 
the background thread gets starved by something higher priority?

Or if the allocators have such high bandwidth that they can overwhelm 
any reasonable background thread.

-Andi


