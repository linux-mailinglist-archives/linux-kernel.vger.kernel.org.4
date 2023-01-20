Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064CA674B94
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjATFCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjATFB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:01:58 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56943CE215
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674190168; x=1705726168;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RaIhrk8EZ9LTPDYkzu87WS+yeMpipgyZuC05/+fP5JM=;
  b=A4TNQlfcwxGl9bA8JwWHabW3unc1WdNidgDvrpSabXOof38Lt5leu0Jc
   3Dzu/9v3oR12yUI2J7vRjl0tB1cobwOeUEFyfOed72ni4NYtoYnmStDi4
   AwEaGyMbWmo48F8QGe1mvWGmQJCEDXLHPLgv24ewZIhtR/2SfQ8MVXMQw
   KAAQmWf8b6Jt1wPobIYzMCKLWN0gYngp3GWihnNV5hi8PFtkq69fZX+S7
   3MUmm3wZvda0Nngl6teSi9B4ATt6TL2kTXeYiDDQiOsOMuyM28/CeGBRH
   FPFphvcdizq+I+jJtQtpVEvW10klQSx1PC770AyzpnoG4lbrR+Ww0a0yu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="309048686"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="309048686"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 16:27:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="662345168"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="662345168"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.184.51]) ([10.252.184.51])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 16:27:11 -0800
Message-ID: <d798bc7b-a87a-26b2-17e0-48e9c7715abc@linux.intel.com>
Date:   Fri, 20 Jan 2023 08:27:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, hch@lst.de, jgg@nvidia.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6/8] iommu: Retire bus ops
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1673978700.git.robin.murphy@arm.com>
 <a2db51f8f417bbe0032e2c4231579f8c4ce9a089.1673978700.git.robin.murphy@arm.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <a2db51f8f417bbe0032e2c4231579f8c4ce9a089.1673978700.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/20 3:18, Robin Murphy wrote:
> +	/*
> +	 * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
> +	 * instances with non-NULL fwnodes, and client devices should have been
> +	 * identified with a fwspec by this point. For Intel/AMD/s390/PAMU we
> +	 * can assume a single active driver with global ops, and so grab those
> +	 * from any registered instance, cheekily co-opting the same mechanism.
> +	 */
> +	fwspec = dev_iommu_fwspec_get(dev);
> +	if (fwspec && fwspec->ops)
> +		ops = fwspec->ops;
> +	else
> +		ops = iommu_ops_from_fwnode(NULL);

I'm imagining if Intel/AMD/s390 drivers need to give up global ops.
Is there any way to allow them to make such conversion? I am just
thinking about whether this is a hard limitation for these drivers.

Best regards,
baolu
