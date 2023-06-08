Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A23728340
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbjFHPJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbjFHPJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:09:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BDF2D61
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686236972; x=1717772972;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hKQWNsfMCaxOhcLznocENZflEOSMlleDFC62geegNPg=;
  b=AmQyPIhDvmmdhTce5fneCqEEIjvbzPYqoY7wBjOUevqHYhvIipKbyLdF
   eKURp+bksE72+tHnhRnQIJD6fiFDADqnu+Cy/cm25XE9pnrv5IX+5Snys
   AsLyB+T+hKTblt5A8ETuT0IZbfIvWzSds1G4oKO+YX3Q7x1X5dZGruK3z
   8C0jRhhwxCF9+vGMfYpgmA0GlfwbTFMyEu8kNkQANYj+DdYp/xj+b5IIE
   vCdDrnOZZzxR/KM72aT1lkoDP0YOW87OiL3CT3i+LL2YXX4owVIFRF0g6
   gXQjZD6smqiYxI2eHRcFP+A+B06JHG2CXb8vXhYw84U+13i0t/lYdmC74
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="443700539"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="443700539"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 08:09:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="799842564"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="799842564"
Received: from svuppala-mobl.amr.corp.intel.com (HELO [10.212.207.249]) ([10.212.207.249])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 08:09:31 -0700
Message-ID: <9d2a7b72-b145-ba97-987a-4611fc3db3ad@linux.intel.com>
Date:   Thu, 8 Jun 2023 08:25:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] soundwire: add enum to control device number
 allocation
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bard.liao@intel.com
References: <20230531033736.792464-1-yung-chuan.liao@linux.intel.com>
 <20230531033736.792464-2-yung-chuan.liao@linux.intel.com>
 <ZIF9Hd5Hv/CKQeUW@matsya>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ZIF9Hd5Hv/CKQeUW@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +/**
>> + * enum sdw_dev_num_alloc - Device Number allocation strategies
>> + * @SDW_DEV_NUM_ALLOC_DEFAULT: unconstrained first-come-first-serve allocation,
>> + * using range [1, 11]
>> + * @SDW_DEV_NUM_ALLOC_IDA: IDA-based allocation, using range [ida_min, 11]
>> + */
>> +enum sdw_dev_num_alloc {
>> +	SDW_DEV_NUM_ALLOC_DEFAULT = 0,
>> +	SDW_DEV_NUM_ALLOC_IDA,
> 
> Let default be IDA as 0, am sure we are not setting this field in qcom
> or amd controller, lets retain the defaults please

Not following, QCOM or AMD are NOT using the IDA-based version, so the
default is zero.
