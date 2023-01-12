Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93B9667E98
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjALTES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240250AbjALTDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:03:43 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512EA642E
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673549069; x=1705085069;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AexL3P28r9vc3bJFkrnWOMI0QcFDFJKxP5z/sh/eWnw=;
  b=iNvsDt3jaibEX425BpjOrLmoKsb7GB+vCR4jtBBpNaV/mkFMjUn4qvHu
   F48zf71vEvRly1VH/cRfOCvNaBwBzPCyhqI4mIJ/pE88/qrpYh5zxtPSw
   YWHNle3RAQT1zaH1Cv4ZjjDUTcTMhCn2AQCssASYOLmFiMeYvtg0ycdvN
   BRMz1hGLQnkD/qKheWZQPe9rMRE68xI9E7CwrMOwGiR2RkbLjW/JmvxU+
   YZtic2Sto1K5VbWDhoW78Qf+q24uTs8RbeNkvuyeq0eF+gxJwZcn8ZeYK
   F6oiNwkmxv+yAI63rFnXTt6laeUgSuka2WVjXJlwO+ZIVRHzgWXDAg4JB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="304173576"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="304173576"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 10:43:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="903318868"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="903318868"
Received: from jbetan3x-mobl1.amr.corp.intel.com (HELO [10.209.143.163]) ([10.209.143.163])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 10:43:47 -0800
Message-ID: <3320e6b8-28c7-d028-3c4c-2b4b25a963fb@linux.intel.com>
Date:   Thu, 12 Jan 2023 12:43:46 -0600
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <Y8BOCpXyOyF3igfG@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/23 12:14, Mark Brown wrote:
> On Thu, Jan 12, 2023 at 11:38:38AM -0600, Pierre-Louis Bossart wrote:
> 
>>> +static int regmap_sdw_gather_write(void *context,
>>> +				   const void *reg_buf, size_t reg_size,
>>> +				   const void *val_buf, size_t val_size)
>>>  {
>>>  	struct device *dev = context;
>>>  	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>>> -	int read;
>>> +	u32 addr = le32_to_cpu(*(const __le32 *)reg_buf);
> 
>> what's the difference between regmap_sdw_write() and
>> regmap_sdw_gather_write()? Seems to me that it's the same functionality
>> of writing at consecutive addresses. It's not a true 'gather' in the
>> sense that only the first address is used?
> 
> The regmap gather_write() operation allows the bus to take two buffers,
> one for the register and one for the value, rather than requiring the
> core combine everything into a single buffer (mainly useful for large
> transfers like firmware downloads).

Right, but that's not supported in SoundWire. sdw_nwrite() will only
work with consecutive addresses - and the auto-increment is handled in
software, not hardware.

What's suggested here is to use the first element of reg_buf, which begs
the question how different this is from a regular write. If there was a
discontinuity in reg_buf then this wouldn't work at all.
