Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812356FB221
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbjEHOCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbjEHOCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:02:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30E436561
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683554556; x=1715090556;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oZ3i7hfghLI6aro0Y/k8Mn55x2L6O1ripjY3vQcbkhU=;
  b=RLx6++vtTPTSme2pHrGxLekB+0rRS0U1B7e2kAo3UpGxsS3AslOlPkS3
   Zg77eCVLFkelbJcrTLKcpinOeZ5pRA5BwkXmYDVxWfoWxkdSLEq7HLg+9
   YSQAd1zvnOfncbHO+ni1itr2Hg20x28aBjin/2t5mynsMg0kZfrpAj1t1
   tded3SmTXEHm/KXY5I5z0WZLNhJyV8dgXm3cR4OWEA3SNZIhuCo4jAZjS
   P5o3zv5SJQZ3DgUz5K7nheUqsIjTbPicUuEF8EVVFZwKL3+5M6PG1uF6a
   rChumgr8vmPazgbXcxG+xTOMeq+pOUHacYVijw7XL0di/FikaEs4lpvfy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="330013706"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="330013706"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 07:01:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="788104121"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="788104121"
Received: from jarava-mobl1.amr.corp.intel.com (HELO [10.255.228.217]) ([10.255.228.217])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 07:01:14 -0700
Message-ID: <cfb75ee6-f290-4f59-df3b-9acea986357f@linux.intel.com>
Date:   Mon, 8 May 2023 08:59:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH] soundwire: intel: Make DEV_NUM_IDA_MIN a module param
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20230508103901.7840-1-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230508103901.7840-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/8/23 05:39, Richard Fitzgerald wrote:
> Add a module param so that globally-unique peripheral ID
> allocation is only enabled if wanted.
> 
> The globally-unique IDs were introduced by
> commit c60561014257
> ("soundwire: bus: allow device number to be unique at system level")
> 
> and
> commit 1f2dcf3a154a ("soundwire: intel: set dev_num_ida_min")
> 
> Assigning globally-unique IDs limits the total number of
> peripherals in a system, and the above two commits limit to a
> maximum of 8 peripherals. We now have hardware with more than
> 8 peripherals in total, so this limit is a problem. As the
> original commit says that it is only for debug it can be made
> optional.
I think it's a misunderstanding, the introduction of these IDs was
related to hardware programming sequences, not just debug.

I'll talk to Richard on this, please do not apply this patch for now.

> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  drivers/soundwire/intel_auxdevice.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
> index b21e86084f7b..9ebbf652e47a 100644
> --- a/drivers/soundwire/intel_auxdevice.c
> +++ b/drivers/soundwire/intel_auxdevice.c
> @@ -23,8 +23,13 @@
>  #include "intel.h"
>  #include "intel_auxdevice.h"
>  
> -/* IDA min selected to avoid conflicts with HDaudio/iDISP SDI values */
> -#define INTEL_DEV_NUM_IDA_MIN           4
> +/*
> + * sdw_dev_num_min: Set to non-zero to enable globally-unique peripheral IDs.
> + * The value is the minimum ID that will be allocated.
> + */
> +static int intel_dev_num_ida_min;
> +module_param_named(sdw_dev_num_min, intel_dev_num_ida_min, int, 0444);
> +MODULE_PARM_DESC(sdw_dev_num_min, "SoundWire Intel Master min globally-unique ID (0 to disable)");
>  
>  #define INTEL_MASTER_SUSPEND_DELAY_MS	3000
>  
> @@ -148,7 +153,7 @@ static int intel_link_probe(struct auxiliary_device *auxdev,
>  	cdns->msg_count = 0;
>  
>  	bus->link_id = auxdev->id;
> -	bus->dev_num_ida_min = INTEL_DEV_NUM_IDA_MIN;
> +	bus->dev_num_ida_min = intel_dev_num_ida_min;
>  	bus->clk_stop_timeout = 1;
>  
>  	sdw_cdns_probe(cdns);
