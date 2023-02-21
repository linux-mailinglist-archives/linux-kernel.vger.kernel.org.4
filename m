Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D4D69E557
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbjBUQ7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjBUQ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:59:00 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7030FCA10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676998738; x=1708534738;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6moRbn9LHrkq8wHU5QRl+XdeMGFzTjj1yLlLgdMDgOQ=;
  b=g70iThUs2WjCRzfyuuiAGpDdVzIrY3iyoeOIdNy4E2OKe6IuSzyPYTz+
   PHKu05l5UIt/KtV52QkITX+XRyOUxw9n4PSXC/W/n1kgxcUclEHTti7iC
   urb1gSosVsf8OtRDi6pr9SsaoYDCpz1XPa9tqoFbB5KkpAVu9ujccJzjU
   KJHRF3UzZaOoFHYvhOH9VbhrkLagbBuTP4OfOubPxMkC5qBphBpFS/UH9
   U3HMzylLsW0meCkeKC5Kku6+37iTc7yePjvB5BWN9VFPWFG1xAqsv7NJf
   6zWTKTCTCVsKKUOFIarS3VMBrzOZjjNdqCcRT4JTchGTc6tmpLsR96aG1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="334884702"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="334884702"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 08:58:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="814569123"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="814569123"
Received: from taevough-mobl.amr.corp.intel.com (HELO [10.209.174.213]) ([10.209.174.213])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 08:58:41 -0800
Message-ID: <8a002459-37aa-47c2-4e7d-50adac6015f6@linux.intel.com>
Date:   Tue, 21 Feb 2023 11:13:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V3 7/8] soundwire: amd: handle SoundWire wake enable
 interrupt
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, amadeuszx.slawinski@linux.intel.com,
        Mario.Limonciello@amd.com, Sunil-kumar.Dommati@amd.com,
        Basavaraj.Hiregoudar@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230220100418.76754-1-Vijendar.Mukunda@amd.com>
 <20230220100418.76754-8-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230220100418.76754-8-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/23 05:04, Vijendar Mukunda wrote:
> Add wake enable interrupt support for both the SoundWire manager
> instances.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
> ---
>  drivers/soundwire/amd_manager.c | 10 ++++++++++
>  drivers/soundwire/amd_manager.h |  1 +
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> index 3322adeca0d8..a7182aa78652 100644
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
> @@ -932,6 +932,13 @@ static void amd_sdw_update_slave_status(u32 status_change_0to7, u32 status_chang
>  	}
>  }
>  
> +static void amd_sdw_process_wake_event(struct amd_sdw_manager *amd_manager)
> +{
> +	pm_request_resume(amd_manager->dev);

is this needed?

In the Intel case, the wakes do not necessarily come as in-band wakes,
but they can also be notified by the PCI subsystem, so we do have to use
pm_request_resume.

In the AMD case, what happens if you don't do this? Doesn't the
interrupt trigger a pm_runtime_resume already?

> +	acp_reg_writel(0x00, amd_manager->acp_mmio + ACP_SW_WAKE_EN(amd_manager->instance));
> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_8TO11);
> +}
\
