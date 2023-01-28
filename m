Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2F267F630
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 09:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjA1IVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 03:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjA1IVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 03:21:37 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C7E126C3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 00:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674894096; x=1706430096;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z/39axW8OVNf9pdo5HdE9iOLcsilAPmckDFMN9tvMvo=;
  b=U0Br6DU/bRdA2Dp+KZ3AmM3rQ5niz3KYRVXGtx4GqvDkH3RNSesgb5En
   BZxh9N3OAMFDZGBhbRhzlDB/ye9iBp7UgLM2Zg5AxZgxEEXcCxt2AMvHm
   zZNS/mGJYMsRgyoQvGTC7/+Ky2QzDmVVdAo6+fz5SNf83N1eH7l4SdrQj
   aCoYGIZmwSvGsiIHMF+0OiwhgTXt8az7jdafXzLPe0K9r7gTKzP+VB/zk
   W8fcR0T8kZ8URvuypNHg8EauMdB+wpl12yxkm3AxT532o+uDMy17mBW9P
   QbA/FLFYuKrL4hD03Gt1XHzGh3f9l1etkiLtQplCreMZvGEoe9/C7Sa3l
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="310896762"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="310896762"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 00:21:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="693979601"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="693979601"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.186.212]) ([10.252.186.212])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 00:21:32 -0800
Message-ID: <21f313e5-1c5f-c508-b8e7-c1d9193d4098@linux.intel.com>
Date:   Sat, 28 Jan 2023 16:21:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, hch@lst.de, jgg@nvidia.com
Subject: Re: [PATCH v2 5/8] iommu: Switch __iommu_domain_alloc() to device ops
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1674753627.git.robin.murphy@arm.com>
 <23b51c84247cb36e96c242d3aef8ef555b6d05cd.1674753627.git.robin.murphy@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <23b51c84247cb36e96c242d3aef8ef555b6d05cd.1674753627.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/27 2:26, Robin Murphy wrote:
> In all the places we allocate default domains, we have (or can easily
> get hold of) a device from which to resolve the right IOMMU ops; only
> the public iommu_domain_alloc() interface actually depends on bus ops.
> Reworking the public API is a big enough mission in its own right, but
> in the meantime we can still decouple it from bus ops internally to move
> forward.
> 
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
