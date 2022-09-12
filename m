Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2855B59C4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 13:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiILL7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 07:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiILL7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 07:59:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C7F95A5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 04:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662983987; x=1694519987;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GWWaF9Ele3nDBBodDuXQSkJfAumMGqKhY0d2QLPHBeE=;
  b=SRYg68WFmq0jjRbb6w9HkVFoGXL+gI/G4syOIER830vyQ1WCzPAQvfY1
   lkIAE4hvtuHbh5tdPFkBxhVKYiyFfnD06QJNO6wO7r+Y4GGEVS5IRqxiS
   JSx/I0sRrL1U4cT6emTLCkb+yDxkFqyoAW0I+krfYH3mhGBQIyojaLGPo
   hRXB342dE+qDj/YDXmVZ6mvUUXoYWOqcRGrxRhNxIlLmlir6RGwyEBpz5
   R2fvVFq4REcKg1LJgqrJbrS9FVn9pSpJImbzT4pR/kLABF6A+M2AEG4fc
   oMNqYZiKXOb16Bm86zDrQgpX6mTZRF2ZEyL82iKETtMIAacDrJ9BaA8Z2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="324078444"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="324078444"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 04:59:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="705126286"
Received: from vtsymbal-mobl.ger.corp.intel.com (HELO [10.252.32.67]) ([10.252.32.67])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 04:59:41 -0700
Message-ID: <f67f29bc-64af-52dc-a63f-3b74523c06b0@linux.intel.com>
Date:   Mon, 12 Sep 2022 12:43:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 1/7] soundwire: bus: Do not forcibly disable child
 pm_runtime
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com,
        sanyog.r.kale@intel.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <20220907101402.4685-1-rf@opensource.cirrus.com>
 <20220907101402.4685-2-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220907101402.4685-2-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/22 12:13, Richard Fitzgerald wrote:
> Do not call pm_runtime_disable() of a child driver in
> sdw_delete_slave(). We really should never be trying to disable
> another driver's pm_runtime - it is up to the child driver to
> disable it or the core driver framework cleanup. The driver core
> will runtime-resume a driver before calling its remove() so we
> shouldn't break that.
> 
> The patch that introduced this is
> commit dff70572e9a3 ("soundwire: bus: disable pm_runtime in sdw_slave_delete")
> which says:
> 
> "prevent any race condition with the resume being executed after the
> bus and slave devices are removed"
> 
> The actual problem is that the bus driver is shutting itself down before
> the child drivers have been removed, which is the wrong way around (see
> for example I2C and SPI drivers). If this is fixed, the bus driver will
> still be operational when the driver framework runtime_resumes the child
> drivers to remove them. Then the bus driver will remove() and can shut
> down safely.

The description of the fix looks good, but "if this is fixed" is very
confusing to me.

Don't you have a dependency issue here?

There should be first a patch to fix the bus issue and then remove this
pm_runtime_disable second.


> 
> Also note that the child drivers are not necessarily idle when the bus
> driver is removed, so disabling their pm_runtime and stopping the bus
> might break more than only their remove().
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  drivers/soundwire/bus.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 0bcc2d161eb9..99429892221b 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -151,8 +151,6 @@ static int sdw_delete_slave(struct device *dev, void *data)
>  	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>  	struct sdw_bus *bus = slave->bus;
>  
> -	pm_runtime_disable(dev);
> -
>  	sdw_slave_debugfs_exit(slave);
>  
>  	mutex_lock(&bus->bus_lock);
