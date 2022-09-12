Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545E85B59C7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiILMAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiILL7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 07:59:55 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167D7183A0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 04:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662983995; x=1694519995;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wv1rqTq8BRjgtfh8asl4Ex9ddD+7awkmX+crc484eSo=;
  b=ZcryoVgsU7xTIIxvinDhFpoDEFyms6fzAwQnL9TX08JZnlYT+/U0vn46
   EvczKjFFjYX5aO/RFcwPfgvO8V8UoM0U8kzQTHN8w5byiB1BD3wH/MY9+
   QBuXkWj4mL/k9G2fEMxIcId99vGLRzpPF3a9YWhk2EvLB7rjEdVZ24H55
   UZKvUS7Dpn5067OWGQSQIUi/LHPzNBl2iZhPf63uWIVJgY5Gznwl3PoRI
   5JIC+t3JqTT/vvKnE4fU5Ens7e2qt9uj1GmhL7xBPe6AndfR3NjEZTmGK
   N+ygoJJAhvU47oxRG204M794kW2EJ2i/d8ZRAxcMOftp/5fnwRUF2fSnk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="324078478"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="324078478"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 04:59:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="705126318"
Received: from vtsymbal-mobl.ger.corp.intel.com (HELO [10.252.32.67]) ([10.252.32.67])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 04:59:49 -0700
Message-ID: <c83fb25e-ef59-63e1-4223-648dab9885ea@linux.intel.com>
Date:   Mon, 12 Sep 2022 12:53:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 5/7] soundwire: intel: Don't disable interrupt until
 children are removed
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com,
        sanyog.r.kale@intel.com, broonie@kernel.org
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20220907101402.4685-1-rf@opensource.cirrus.com>
 <20220907101402.4685-6-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220907101402.4685-6-rf@opensource.cirrus.com>
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



On 9/7/22 12:14, Richard Fitzgerald wrote:
> The cadence_master code needs the interrupt to complete message transfers.
> When the bus driver is being removed child drivers are removed, and their
> remove actions might need bus transactions.
> 
> Use the sdw_master_ops.remove callback to disable the interrupt handling
> only after the child drivers have been removed.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  drivers/soundwire/intel.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 01be62fa6c83..d5e723a9c80b 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1255,6 +1255,13 @@ static int intel_prop_read(struct sdw_bus *bus)
>  	return 0;
>  }
>  
> +static void intel_bus_remove(struct sdw_bus *bus)
> +{
> +	struct sdw_cdns *cdns = bus_to_cdns(bus);
> +
> +	sdw_cdns_enable_interrupt(cdns, false);

don't you need to check for any on-going transactions on the bus?

I wonder if there could be a corner case where there are no child
devices but still a device physically attached to the bus. I am not sure
if the 'no devices left' is a good-enough indication of no activity on
the bus.

> +}
> +
>  static struct sdw_master_ops sdw_intel_ops = {
>  	.read_prop = sdw_master_read_prop,
>  	.override_adr = sdw_dmi_override_adr,
> @@ -1264,6 +1271,7 @@ static struct sdw_master_ops sdw_intel_ops = {
>  	.set_bus_conf = cdns_bus_conf,
>  	.pre_bank_switch = intel_pre_bank_switch,
>  	.post_bank_switch = intel_post_bank_switch,
> +	.remove = intel_bus_remove,
>  };
>  
>  static int intel_init(struct sdw_intel *sdw)
> @@ -1502,7 +1510,6 @@ static void intel_link_remove(struct auxiliary_device *auxdev)
>  	 */
>  	if (!bus->prop.hw_disabled) {
>  		intel_debugfs_exit(sdw);
> -		sdw_cdns_enable_interrupt(cdns, false);
>  		snd_soc_unregister_component(dev);
>  	}
>  	sdw_bus_master_delete(bus);
