Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C9C5B59D1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiILMBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiILMA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:00:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3019D3054C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 05:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662984043; x=1694520043;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rDhJSOi7sOke4HfRxRqQumXvciKcjrJViJAbL3llhLY=;
  b=akz4u1C+VRuzAOzSPsIT76rZiEDsg3EttyVXRtu7R+xFBf056cQCM9xf
   Sugh2I0SITxOVVfK3syf5RGhVJ9yB/23k56WgfXjkkTgRY+8LqNlTxGOM
   bmw+rzy0mJt2ZzuFZjNEU9ngstcRZJc3EEjGEMVZRvcgHqw2jI7ZVo0H6
   vcddl50sJZWe9Yq7o/XHWCB0R0Gs4dWBd2XyO13xqIQixxh53ljFTDGqy
   CKs9tWWWcjD+rkLoQ3WeOTc8nOoCoR1gJ+BLHg+y7TvXVnQrEiqRI3pPs
   ahBrdR4LPmrDCKTbvqUN26SF+a+oTpndPlE65RiNQXMzJWCfrwhMC4eFY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="384142761"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="384142761"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 05:00:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="705126691"
Received: from vtsymbal-mobl.ger.corp.intel.com (HELO [10.252.32.67]) ([10.252.32.67])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 05:00:34 -0700
Message-ID: <1395a163-2e0e-2471-3932-0517a7f6797d@linux.intel.com>
Date:   Mon, 12 Sep 2022 13:57:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] soundwire: bus: conditionally recheck UNATTACHED status
Content-Language: en-US
To:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org
Cc:     vinod.koul@linaro.org, bard.liao@intel.com,
        linux-kernel@vger.kernel.org,
        Richard Fitzgerald <rf@opensource.cirrus.com>
References: <20220830074224.2924179-1-yung-chuan.liao@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220830074224.2924179-1-yung-chuan.liao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[top posting]
I reverted this patch in the SOF tree to use Richard Fitzgerald's
series, see

https://github.com/thesofproject/linux/pull/3836

I don't think we want this patch upstream, do we?


On 8/30/22 09:42, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> In configurations with two amplifiers on the same link, the Intel CI
> reports occasional enumeration/initialization timeouts during
> suspend-resume stress tests, where one of the two amplifiers becomes
> UNATTACHED immediately after being enumerated. This problem was
> reported both with Maxim and Realtek codecs, which pointed initially
> to a problem with status handling on the Intel side.
> 
> The Cadence IP integrated on Intel platforms throws an interrupt when
> the status changes, and the information is kept with sticky bits until
> cleared. We initially added more checks to make sure the edge
> detection did not miss any transition, but that did not improve the
> results significantly.
> 
> With the recent addition of the read_ping_status() callback, we were
> able to show that the status in sticky bits is shown as UNATTACHED
> even though the PING frames show the problematic device as
> ATTACHED. That completely breaks the entire logic where we assumed
> that a peripheral would always re-attach as device0. The resume
> timeouts make sense in that in those cases, the
> enumeration/initialization never happens a second time.
> 
> One possible explanation is that this problem typically happens when a
> bus clash is reported, so it could very well be that the detection is
> fooled by a transient electrical issue or conflict between two
> peripherals.
> 
> This patch conditionally double-checks the status reported in the
> sticky bits with the actual PING frame status. If the peripheral
> reports as attached in PING frames, the early detection based on
> sticky bits is discarded.
> 
> Note that this patch only corrects issues of false positives on the
> manager side.
> 
> If the peripheral lost and regain sync, then it would report as
> attached on Device0. A peripheral that would not reset its dev_num
> would not be compliant with the MIPI specification.
> 
> BugLink: https://github.com/thesofproject/linux/issues/3638
> BugLink: https://github.com/thesofproject/linux/issues/3325
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
> Hi Vinod,
> 
> You will need the "ASoC/soundwire: log actual PING status on resume issues"
> series which is applied at ASoC tree before appling this patch.
> 
> ---
>  drivers/soundwire/bus.c       | 19 +++++++++++++++++++
>  drivers/soundwire/intel.c     |  1 +
>  include/linux/soundwire/sdw.h |  3 +++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 2772973eebb1..d0d486f07673 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -1767,6 +1767,25 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
>  		    slave->status != SDW_SLAVE_UNATTACHED) {
>  			dev_warn(&slave->dev, "Slave %d state check1: UNATTACHED, status was %d\n",
>  				 i, slave->status);
> +
> +			if (bus->recheck_unattached && bus->ops->read_ping_status) {
> +				u32 ping_status;
> +
> +				mutex_lock(&bus->msg_lock);
> +
> +				ping_status = bus->ops->read_ping_status(bus);
> +
> +				mutex_unlock(&bus->msg_lock);
> +
> +				ping_status >>= (i * 2);
> +				ping_status &= 0x3;
> +
> +				if (ping_status != 0) {
> +					dev_warn(&slave->dev, "Slave %d state in PING frame is %d, ignoring earlier detection\n",
> +						 i, ping_status);
> +					continue;
> +				}
> +			}
>  			sdw_modify_slave_status(slave, SDW_SLAVE_UNATTACHED);
>  		}
>  	}
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 25ec9c272239..0c6e674dbf85 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1311,6 +1311,7 @@ static int intel_link_probe(struct auxiliary_device *auxdev,
>  
>  	bus->link_id = auxdev->id;
>  	bus->dev_num_ida_min = INTEL_DEV_NUM_IDA_MIN;
> +	bus->recheck_unattached = true;
>  
>  	sdw_cdns_probe(cdns);
>  
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index a2b31d25ea27..51ac71984260 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -892,6 +892,8 @@ struct sdw_master_ops {
>   * @dev_num_ida_min: if set, defines the minimum values for the IDA
>   * used to allocate system-unique device numbers. This value needs to be
>   * identical across all SoundWire bus in the system.
> + * @recheck_unattached: if set, double-check UNATTACHED status changes
> + * by reading PING frame status.
>   */
>  struct sdw_bus {
>  	struct device *dev;
> @@ -917,6 +919,7 @@ struct sdw_bus {
>  	bool multi_link;
>  	int hw_sync_min_links;
>  	int dev_num_ida_min;
> +	bool recheck_unattached;
>  };
>  
>  int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
