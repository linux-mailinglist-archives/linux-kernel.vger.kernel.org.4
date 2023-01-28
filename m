Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B22B67F7C7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 13:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjA1MLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 07:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjA1MLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 07:11:09 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FBF15C84
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 04:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674907865; x=1706443865;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dspaCVJ8KT211kM1MllVTsePB3smslSwogobefeUDHY=;
  b=fbiX3giEv6+1+otLfbJzlmwAlNabCWxXZStrbcMs67ltqbUQiSc2ZMcV
   Fm6Tmu9nfgLccTP6QMHuqBfiUC5V1HxubCSAU3EKKgAUlMez//yGpxWGj
   GdGXSiEdrs9VatkKBZB2l+Rm6bEGKgDZK999PbopJAQwM7blsklY63Yu8
   o87v2IJsGGLR0PPhIpNULueEL6f06GLiecmRvNKsInZSTDVTrvqZGIpaF
   IIFfq77YpJbQAbh8topp9XGy57UnxBV1PznUWLPdcfyDGOMQZtzSMxcnx
   qdUEHApSDigMnyt0XES4cjwLD8016kiEJ5n8BNeWxmZWPdtj7aXiCdGSg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="307628208"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="307628208"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 04:11:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="771896680"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="771896680"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.186.212]) ([10.252.186.212])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 04:11:01 -0800
Message-ID: <0c08daf4-ad2f-9047-db52-c87d4e8b07b6@linux.intel.com>
Date:   Sat, 28 Jan 2023 20:10:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, hch@lst.de, jgg@nvidia.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 7/8] iommu: Retire bus ops
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1674753627.git.robin.murphy@arm.com>
 <198e82a6b1a28605409c395da4ec1a67b0e1587b.1674753627.git.robin.murphy@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <198e82a6b1a28605409c395da4ec1a67b0e1587b.1674753627.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/27 2:26, Robin Murphy wrote:
> With the rest of the API internals converted, it's time to finally
> tackle probe_device and how we bootstrap the per-device ops association
> to begin with. This ends up being disappointingly straightforward, since
> fwspec users are already doing it in order to find their of_xlate
> callback, and it works out that we can easily do the equivalent for
> other drivers too. Then shuffle the remaining awareness of iommu_ops
> into the couple of core headers that still need it, and breathe a sigh
> of relief.
> 
> Ding dong the bus ops are gone!
> 
> CC: Rafael J. Wysocki<rafael.j.wysocki@intel.com>
> CC: Christoph Hellwig<hch@lst.de>
> Acked-by: Greg Kroah-Hartman<gregkh@linuxfoundation.org>
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
