Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D289696273
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjBNL0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjBNL0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:26:13 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98194E381
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676373970; x=1707909970;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I4OsreHvErywjGFLpFA5RnxHZeaT7fEvihXK6cVLf40=;
  b=E8dAWmMn4FkHLLb8Sy1FN9LSGaKroRNxRezkURKJHfUHb6iMt8csFGw8
   NvGN70niknk9r2KLrNUii5lfFpfMrpJ4YDM0rd7arLy+gfoTC70xJ6SX2
   4JKX1BrI8sHpnXI5mpiV4f3Rd1FFaa0HGlrhEL+hIW3sIqaQh1rBCQj9u
   tKiN/s5F5lu5k2awkGGvgXEd+S2/m/AHSrnx63PphibKgOkLcTa4rIskH
   WIOgTeMituusUNUU9Lpkvs8cLL4NZuboKk07mShW9LQgZvzla96Z1kZgI
   Gy1hQz8KkbfY2Lpa+WVm5zdY0jcw8sBYWbq7F4Z08TzH9ubgoeO7zEtYU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="395753462"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="395753462"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 03:26:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="778290040"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="778290040"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.29.229]) ([10.255.29.229])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 03:26:06 -0800
Message-ID: <28b41700-d9f8-c065-7599-6c4b32fdfe4d@linux.intel.com>
Date:   Tue, 14 Feb 2023 19:26:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc:     baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 1/3] iommu/vt-d: Remove virtual command interface
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20230214064414.1038058-1-jacob.jun.pan@linux.intel.com>
 <20230214064414.1038058-2-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230214064414.1038058-2-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/14 14:44, Jacob Pan wrote:
> Virtual command interface was introduced to allow using host PASIDs
> inside VMs. It is unused and abandoned due to architectural change.
> 
> With this patch, we can safely remove this feature and the related helpers.
> 
> Link:https://lore.kernel.org/r/20230210230206.3160144-2-jacob.jun.pan@linux.intel.com
> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
