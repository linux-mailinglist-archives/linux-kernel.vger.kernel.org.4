Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180256DF7EB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjDLODO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjDLODM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:03:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C07FF2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681308190; x=1712844190;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n/9nWg9ADNDZxhAMoIa6mw8OZXc7bxhlG+mD8jYD9jY=;
  b=TQI6/omJ7JdfsbOIcslMNJDCUiypnMlaOjvu547LLSunpVmsdMONHaWq
   4nPkw781up7hZyck9JhWJDA/17DFN0mUQouDHCT6rMoWya4QiFAoZ95PR
   GPJazL/XSzpiYsBgB/feH+Ch9ukPvQKXTibmMc5nY2SpPSkN8O9IfHjyr
   PVs9BlWzp/UDrcv8ePQ9BTJdfJoekmMW7r/xBLsix27Mo1TfyVt+MkRGg
   FvCYkEyNMcj3rkQOml6ZHvfdBkL1a0HviNDyeTCtzEMs360oR+vpAD6/I
   Q4HYB7NGGRdtzeVnah0N//FdR4MB7YiPuwdWkxDwNUDa7wHNr5HR18kbP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="342660767"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="342660767"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 07:02:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="691540396"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="691540396"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.58]) ([10.254.215.58])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 07:02:45 -0700
Message-ID: <b90f0222-3faa-b909-c82a-d4fbf8a1a1ae@linux.intel.com>
Date:   Wed, 12 Apr 2023 22:02:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Cc:     baolu.lu@linux.intel.com, Vinod Koul <vkoul@kernel.org>,
        Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/17] iommu/vt-d: Fix operand size in bitwise operation
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        Joerg Roedel <joro@8bytes.org>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
 <20230411064815.31456-12-baolu.lu@linux.intel.com>
 <ec1536af68e6478a9b10a0d884cc988d@AcuMS.aculab.com>
 <6d9ed10d-12ee-792f-fc34-60a8e432c5d2@linux.intel.com>
 <b6ab9a30960d41c9b42e5880b89277e3@AcuMS.aculab.com>
 <cbf041c7-119b-e23a-185d-288194629324@linux.intel.com>
 <d996281ed80647e0ae38cea00285f710@AcuMS.aculab.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <d996281ed80647e0ae38cea00285f710@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/12 21:27, David Laight wrote:
> From: Baolu Lu
>> Sent: 12 April 2023 14:11
> ...
>> The addresses the following issue reported by klocwork tool:
>>
>>    - operands of different size in bitwise operations
> Then fix the stupid tool to not be that pedantic.

Good idea. But before the users/customers stop complaining, let's have a
cleanup like this. :-)

Best regards,
baolu
