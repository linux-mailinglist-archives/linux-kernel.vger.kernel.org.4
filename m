Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB010689DE5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 16:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjBCPRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 10:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbjBCPPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:15:03 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D678D403
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 07:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675437176; x=1706973176;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cL3cDZ3cU575R2Pn0PMxEk6zsutuTJdd2e6As3uhekg=;
  b=WI2ReoyHM4BTfNAnorWRo49Y41PQw8h1H2D/h9h0wzdP4DMot5KX5pIk
   tDybbObo2cB5V2ifwfg4udrYd+rxK3NwbfzsDw0gRQnE6jKMlScWVzG8X
   GOwvxBavjfBuW8vtYQmw/DtUMOSgvGEuM6OI3MVh1rNHp8NT7lsXFbTG4
   ytZ8nBjLWXt+aJu8eXxig38bpNj21ictTESkb/XE+XZPLVbZUnMBxnAL6
   oI+HyEa+YYdxZXWlhPVOj1r0HCRwI8pTLp+N/XC7HaT5uHWZN9gNGw3Hz
   XsUOZNrhU4VU+veVl4pZ2IePGKFCp/BY3N1mlnergpChtaiow92ZEoFB8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="330898236"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="330898236"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 07:11:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="729289964"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="729289964"
Received: from albuitra-desk.amr.corp.intel.com (HELO [10.209.172.145]) ([10.209.172.145])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 07:11:25 -0800
Message-ID: <84adef23-fecf-76ec-c597-5f8b4be214da@linux.intel.com>
Date:   Wed, 1 Feb 2023 17:21:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH] soundwire: export sdw_compute_slave_ports() function
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Basavaraj.Hiregoudar@amd.com, Sunilkumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com, Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230201165944.3169125-1-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230201165944.3169125-1-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/23 10:59, Vijendar Mukunda wrote:
> Export sdw_compute_slave_ports() function to use it in another
> soundwire manager module.
> Move sdw_transport_data structure to bus header file to export
> sdw_compute_slave_ports() function.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>


If a specific platform has a need to modify parts of the bit allocation
but can reuse parts of the code, that's fine. The 'generic bandwidth
allocation' was meant to be a reference, not a one-size-fits-all solution.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  drivers/soundwire/bus.h                          |  9 +++++++++
>  drivers/soundwire/generic_bandwidth_allocation.c | 12 +++---------
>  2 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> index 7631ef5e71fb..141b99ac58de 100644
> --- a/drivers/soundwire/bus.h
> +++ b/drivers/soundwire/bus.h
> @@ -144,6 +144,13 @@ struct sdw_master_runtime {
>  	struct list_head bus_node;
>  };
>  
> +struct sdw_transport_data {
> +	int hstart;
> +	int hstop;
> +	int block_offset;
> +	int sub_block_offset;
> +};
> +
>  struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
>  					    enum sdw_data_direction direction,
>  					    unsigned int port_num);
> @@ -213,5 +220,7 @@ int sdw_bwrite_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr, u8 val
>  
>  void sdw_clear_slave_status(struct sdw_bus *bus, u32 request);
>  int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size);
> +void sdw_compute_slave_ports(struct sdw_master_runtime *m_rt,
> +			     struct sdw_transport_data *t_data);
>  
>  #endif /* __SDW_BUS_H */
> diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
> index f7c66083a4dd..39543048baa7 100644
> --- a/drivers/soundwire/generic_bandwidth_allocation.c
> +++ b/drivers/soundwire/generic_bandwidth_allocation.c
> @@ -28,15 +28,8 @@ struct sdw_group {
>  	unsigned int *rates;
>  };
>  
> -struct sdw_transport_data {
> -	int hstart;
> -	int hstop;
> -	int block_offset;
> -	int sub_block_offset;
> -};
> -
> -static void sdw_compute_slave_ports(struct sdw_master_runtime *m_rt,
> -				    struct sdw_transport_data *t_data)
> +void sdw_compute_slave_ports(struct sdw_master_runtime *m_rt,
> +			     struct sdw_transport_data *t_data)
>  {
>  	struct sdw_slave_runtime *s_rt = NULL;
>  	struct sdw_port_runtime *p_rt;
> @@ -85,6 +78,7 @@ static void sdw_compute_slave_ports(struct sdw_master_runtime *m_rt,
>  		}
>  	}
>  }
> +EXPORT_SYMBOL(sdw_compute_slave_ports);
>  
>  static void sdw_compute_master_ports(struct sdw_master_runtime *m_rt,
>  				     struct sdw_group_params *params,
