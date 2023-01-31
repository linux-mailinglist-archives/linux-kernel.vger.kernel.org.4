Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13A568339A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjAaRSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjAaRRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:17:49 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47705564B4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675185440; x=1706721440;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9zBjP78++PUeYFI1Tn93XmBcUNX5nkcvT3SvfzZepBI=;
  b=JglOxe1aMMNuSmlCUtJcqrhWDwkh/W7M3mjMHEa7I5Lgj3PObF7prvYt
   GnF8iBAewv7cDJIhPKWPZwPZscKpdA6iFNUzDSJYPeANiaS1kqntvZEa7
   xuOzRypYhBWfpn/P7u5GT8FMHW/Elo+t1zB8VjriFkglgnrCTVwmuEydm
   aUd/lbWQXqD+ZCFFcwK2nNDkpaYh5qm+xyhojAHwt0/xq4upepvQttgYz
   xm8bHHR/BstHOy7y5et9ND6fnJFO+dZTtfu1bSCqfBPVMD8X8GQCP78Au
   4Mlgja5f3VLzRFLxDqjb/gPH8sw8Vh6hf7e4XI86TdNdZVw5HCEAhqnF2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="308241413"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="308241413"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 09:16:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="909985397"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="909985397"
Received: from akleen-mobl3.amr.corp.intel.com (HELO [10.241.232.75]) ([10.241.232.75])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 09:16:15 -0800
Message-ID: <ee5d8c26-a453-678c-be48-d586271573d6@linux.intel.com>
Date:   Tue, 31 Jan 2023 09:16:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/4] swiotlb: Add a new cc-swiotlb implementation for
 Confidential VMs
To:     Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        konrad.wilk@oracle.com, linux-coco@lists.linux.dev
Cc:     robin.murphy@arm.com
References: <20230128083254.86012-1-GuoRui.Yu@linux.alibaba.com>
 <20230128083254.86012-3-GuoRui.Yu@linux.alibaba.com>
 <9b167caf-1b10-f97a-d96a-b7ead8e785e8@linux.intel.com>
 <2ec59355-c8d5-c794-16e8-7d646b43c455@linux.alibaba.com>
 <09a56915-7ce2-b70c-33ec-3a8767269637@linux.intel.com>
 <ccc21265-07aa-cd82-f679-4fee9c51df47@linux.alibaba.com>
Content-Language: en-US
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <ccc21265-07aa-cd82-f679-4fee9c51df47@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 >No, this cannot guarantee we always have sufficient TLB caches, so we 
can also have a "No memory for cc-swiotlb buffer" warning.

It's not just a warning, it will be IO errors, right?

>
> But I want to emphasize that in this case, the current implementation 
> is no worse than the legacy implementation. Moreover, dynamic TLB 
> allocation is more suitable for situations where more disks/network 
> devices will be hotplugged, in which case you cannot pre-set a 
> reasonable value.

That's a reasonable stand point, but have to emphasize that is 
"probabilistic" in all the descriptions and comments.

I assume you did some stress testing (E.g. all cores submitting at full 
bandwidth) to validate that it works for you?

-Andi


