Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A4467272F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjARSiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjARSiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:38:16 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC9A65BC
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674067094; x=1705603094;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OlBzbupfhV2bmyY8s2x6GJLsiZW8YnpaxbAPUhUsLXU=;
  b=c1EGxFdVOgGSMK3didkAMgvz72SuQbg2mkj2KVo+43SrQECj6imRd+tZ
   goD4LOwqWOo7eRIsJfdJ3c/Y/gXQC7vhlJ7uHOq2EQnqL6wXK/qGOA6A+
   IfH8e3kKv3i6v1hOms5443wqGfbmRLKZP87YC2QTCvZmAHkN+9xuGURLP
   aVC5lV3e7Skrn1+s2D6qPXzZEWNihnowtPmgqS5zE3t2Dxz5RqhkWaEgi
   pBowXh5MjWiEwnh9JcvRJvSnTHbP5CsWKTZrvP30R22qu2GYAoOf6OGoA
   xtj935gR67VVRvLq2fREETe9poj1OyPMazyrFpp9s6+WCZ4Rx+g80NY8L
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="327138509"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="327138509"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:37:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="783777243"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="783777243"
Received: from jaibarra-mobl.amr.corp.intel.com (HELO [10.209.131.1]) ([10.209.131.1])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:37:54 -0800
Message-ID: <72ba99a9-3d21-b3be-4a23-6570078aaae9@linux.intel.com>
Date:   Wed, 18 Jan 2023 10:37:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/8] soundwire: stream: Add specific prep/deprep
 commands to port_prep callback
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20230118160452.2385494-1-sbinding@opensource.cirrus.com>
 <20230118160452.2385494-2-sbinding@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230118160452.2385494-2-sbinding@opensource.cirrus.com>
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



On 1/18/23 10:04, Stefan Binding wrote:
> Currently, port_prep callback only has commands for PRE_PREP, PREP,
> and POST_PREP, which doesn't directly say whether this is for a
> prepare or deprepare call. Extend the command list enum to say
> whether the call is for prepare or deprepare aswell.
> 
> Also remove SDW_OPS_PORT_PREP from sdw_port_prep_ops as this is unused,
> and update this enum to be simpler and more consistent with enum
> sdw_clk_stop_type.

yes, I don't know why this PORT_PREP was added, clearly the prepare part
is something that would be done with standard registers without the need
to inform the codec driver. The codec driver only need the pre- and
post- notifications.

Good cleanup!


> Note: Currently, the only users of SDW_OPS_PORT_POST_PREP are codec
> drivers sound/soc/codecs/wsa881x.c and sound/soc/codecs/wsa883x.c, both
> of which seem to assume that POST_PREP only occurs after a prepare,
> even though it would also have occurred after a deprepare. Since it
> doesn't make sense to mark the port prepared after a deprepare, changing
> the enum to separate PORT_DEPREP from PORT_PREP should make the check
> for PORT_PREP in those drivers be more logical.
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  drivers/soundwire/stream.c    | 4 ++--
>  include/linux/soundwire/sdw.h | 8 +++++---
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index df3b36670df4c..1652fb5737d9d 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -469,7 +469,7 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
>  	}
>  
>  	/* Inform slave about the impending port prepare */
> -	sdw_do_port_prep(s_rt, prep_ch, SDW_OPS_PORT_PRE_PREP);
> +	sdw_do_port_prep(s_rt, prep_ch, prep ? SDW_OPS_PORT_PRE_PREP : SDW_OPS_PORT_PRE_DEPREP);
>  
>  	/* Prepare Slave port implementing CP_SM */
>  	if (!dpn_prop->simple_ch_prep_sm) {
> @@ -501,7 +501,7 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
>  	}
>  
>  	/* Inform slaves about ports prepared */
> -	sdw_do_port_prep(s_rt, prep_ch, SDW_OPS_PORT_POST_PREP);
> +	sdw_do_port_prep(s_rt, prep_ch, prep ? SDW_OPS_PORT_POST_PREP : SDW_OPS_PORT_POST_DEPREP);
>  
>  	/* Disable interrupt after Port de-prepare */
>  	if (!prep && intr)
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index 3cd2a761911ff..547fc1b30a51a 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -569,13 +569,15 @@ struct sdw_prepare_ch {
>   * enum sdw_port_prep_ops: Prepare operations for Data Port
>   *
>   * @SDW_OPS_PORT_PRE_PREP: Pre prepare operation for the Port
> - * @SDW_OPS_PORT_PREP: Prepare operation for the Port
> + * @SDW_OPS_PORT_PRE_DEPREP: Pre deprepare operation for the Port
>   * @SDW_OPS_PORT_POST_PREP: Post prepare operation for the Port
> + * @SDW_OPS_PORT_POST_DEPREP: Post deprepare operation for the Port
>   */
>  enum sdw_port_prep_ops {
>  	SDW_OPS_PORT_PRE_PREP = 0,
> -	SDW_OPS_PORT_PREP = 1,
> -	SDW_OPS_PORT_POST_PREP = 2,
> +	SDW_OPS_PORT_PRE_DEPREP,
> +	SDW_OPS_PORT_POST_PREP,
> +	SDW_OPS_PORT_POST_DEPREP,
>  };
>  
>  /**
