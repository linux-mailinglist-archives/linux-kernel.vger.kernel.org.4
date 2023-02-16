Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1253D69962D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjBPNqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjBPNpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:45:54 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6EC497E8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676555133; x=1708091133;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0l+RPbcf2hm7NN6r12F9dZZzVVPHF2aVireRQ7ilgwE=;
  b=GDbv7BOcvbh4roOGrcSZY52N2IQff1gwggS44vEKReorK1FtJVmS+4sg
   LNv4zQdfL7cVhlvV668mZUZk+Tezhw3qaaQ3CtfS7e6EP/lguH6/4737K
   1e8A+eIeHqB3g862BWQiiqh9rKZ3MsxzMZEc+oy4foKTOxp4+XYXjSbkT
   FC1phQPM4FZMXgqVz0h2yQObIm8UV3EuVr/Yt9j1QrZ9g2UE7p+NiVuCm
   WgAMh+jenYM47EA5lThM9iBbpVfUzBzjj796+HSY5QtrAa+P9yviudh9b
   qj0PHdcI4fMHVxkZ9HGBweDkKBPeZc0TAe/VJKS9tlzGCvL9lVDgSlS/H
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="311347518"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="311347518"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 05:45:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="915667201"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="915667201"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.211.109]) ([10.254.211.109])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 05:45:19 -0800
Message-ID: <88e0b71e-5674-8b03-e038-9ab75503c817@linux.intel.com>
Date:   Thu, 16 Feb 2023 21:45:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc:     baolu.lu@linux.intel.com,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] [PULL REQUEST] iommu/vt-d: Fixes for v6.2-rc8
To:     Joerg Roedel <joro@8bytes.org>
References: <20230216130816.151824-1-baolu.lu@linux.intel.com>
 <Y+4yuaciYYnptpKI@8bytes.org>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y+4yuaciYYnptpKI@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/16 21:42, Joerg Roedel wrote:
> Hi Baolu,
> 
> On Thu, Feb 16, 2023 at 09:08:12PM +0800, Lu Baolu wrote:
>> Below iommu/vt-d fixes are queued for your fixes branch.
>>
>> - Two performance optimizations
>> - Fix PASID directory pointer coherency
>> - Fix missed rollbacks in error path
>>
>> Please consider it for the iommu/fixes branch.
> So nothing of this seems really critical (e.g. fixes a regression that a
> number of people are encountering). Especially the performance
> optimizations do not qualify as fixes at this stage of the cycle. I will
> queue them in the VT-d branch so that they go upstream in the next merge
> window, unless you convince me otherwise.

Yes. Nothing really critical. It's fine to put them in the vt-d branch.

Best regards,
baolu
