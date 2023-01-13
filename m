Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AA766A19D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjAMSM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjAMSL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:11:58 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18F9A41D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673633080; x=1705169080;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d9wuKiMfp5I239k32le0DRITdRjTXDAU6CNZ1DWyPYM=;
  b=CsrsbEeu0b9ON4zqgzu2QY2krAfY4GDjA4+vJTHfoeDNGRMT8Ool97QU
   BLVQMXBKvhQCxXsTWvHRHv75+Y+FtuoLuFcSK12cfXIMe4Ffa7PJvX5zc
   2KizD8MEcWQ3z1kiiWc5NEOBl7MgF5f3U/85IYOFjjOPrKQWL4XB4hrLO
   SLVltEq3IO0ARFN4ubHfQyvzvV4bZ8DzALGn6xnJXhT+mVft8/ANW4S82
   YkBhu5OS49qhG5apLKPx0mLEVVlyXoAuTD8gGo248CMNe33Fq2j99Gtqa
   1CP5IGYMMSnaLKT5EYLFco7q5VLPClUV0P7/FbcH/qFeSylIyUP3gH8uV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="325317889"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="325317889"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 10:03:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="747002880"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="747002880"
Received: from rerayess-mobl.amr.corp.intel.com (HELO [10.212.13.223]) ([10.212.13.223])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 10:03:41 -0800
Message-ID: <3c345192-8c92-ec92-bda7-299b852b8e4f@linux.intel.com>
Date:   Fri, 13 Jan 2023 12:03:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] regmap: sdw: Remove 8-bit value size restriction
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <20230112171840.2098463-1-ckeepax@opensource.cirrus.com>
 <20230112171840.2098463-3-ckeepax@opensource.cirrus.com>
 <756fcb2d-d571-18cb-985e-d907ab682275@linux.intel.com>
 <Y8BOCpXyOyF3igfG@sirena.org.uk>
 <3320e6b8-28c7-d028-3c4c-2b4b25a963fb@linux.intel.com>
 <Y8BkiF8sfqPifYTO@sirena.org.uk>
 <4a6ae9b4-2748-c751-aec6-05979de95cfe@linux.intel.com>
 <20230113110252.GK36097@ediswmail.ad.cirrus.com>
 <487b7647-8304-8e36-00f2-c9ba3aa50004@linux.intel.com>
 <Y8GQs6svuei0SnX6@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <Y8GQs6svuei0SnX6@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/23 11:11, Mark Brown wrote:
> On Fri, Jan 13, 2023 at 10:57:39AM -0600, Pierre-Louis Bossart wrote:
> 
>> The change from reg_write/read_reg to write/read seems ok, what I was
>> asking about was the gather_write.
> 
>> +	.write = regmap_sdw_write,
>> +	.gather_write = regmap_sdw_gather_write,
>> +	.read = regmap_sdw_read,
> 
>> what happens if you only have .write and .read? What does the
>> .gather_write help with if you only use only address?
> 
> Like I said before it means that the core doesn't have to put the
> register in a linear buffer with the values, meaning it can avoid
> copying already formatted data around or allocating memory.

Ah ok, I read sideways and missed the pointer arithmetic in the write
implementation

return sdw_nwrite_no_pm(slave, addr, val_size - sizeof(addr), val +
sizeof(addr));

Thanks for the clarification.
