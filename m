Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AEB63F93D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 21:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiLAUig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 15:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiLAUi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 15:38:26 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAD9A13C3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 12:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669927105; x=1701463105;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zELu1XGPksGPNPCJ7usRTQUQut5ZdnmhS1HI4ZrCSWM=;
  b=GZBTmZpnnYE6kSCVLi6vGQgdoGlzeU88XtC9qC6hbSGxyY4z1/75nH/h
   1ApQtOJ+KU2deqGbHzMsdWlUmPttpDp6mHiV0voYYEu5EtJjM+Do7mFPT
   e5kGFy/mo+LLwbz99xgSAwFSLKIbbauUNFuyUWpg48Dy0Qf+bw7EgLUST
   lKEbxSWbSe/RYLF8J261NyQORgGGi35Eu+etacKM2l89rg4eVvP2UTn1F
   9WEuL/vFUJ6ANJ37nnbtRKfJewPy6LXNm8jqkY4fXqikQMpQkdj4tDn8S
   CALEQbbNOtK5mV2yJggb2uQmS1qJ5QbkGQ+yDsYj6MIAcE8Rr7nK4bhxW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="314498372"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="314498372"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 12:38:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="644781654"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="644781654"
Received: from twcarol-mobl.amr.corp.intel.com (HELO [10.212.10.40]) ([10.212.10.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 12:38:03 -0800
Message-ID: <ad92df90-3a5f-91ee-59d5-23116b03264a@linux.intel.com>
Date:   Thu, 1 Dec 2022 11:49:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 1/3] soundwire: cadence: Don't overflow the command FIFOs
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, sanyog.r.kale@intel.com,
        yung-chuan.liao@linux.intel.com
References: <20221201134845.4055907-1-rf@opensource.cirrus.com>
 <20221201134845.4055907-2-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221201134845.4055907-2-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/1/22 07:48, Richard Fitzgerald wrote:
> The command FIFOs are 8 entries long, so change CDNS_MCP_CMD_LEN to 8.
> 
> CDNS_MCP_CMD_LEN was originally 32, which would lead to cdns_xfer_msg()
> writing up to 32 commands into the FIFO, so any message longer than 8
> commands would fail.

The change is correct for all instances of SoundWire on Intel platforms.
That said, maybe we should capture that the Cadence IP can handle
4/8/16/32 entries - this is a hardware configuration option.

We should also mention that so far we have not sent multiple commands so
far so the code is only broken when grouping commands.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Fixes: 2f52a5177caa ("soundwire: cdns: Add cadence library")
> ---
>  drivers/soundwire/cadence_master.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index a1de363eba3f..27699f341f2c 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -127,7 +127,8 @@ MODULE_PARM_DESC(cdns_mcp_int_mask, "Cadence MCP IntMask");
>  
>  #define CDNS_MCP_CMD_BASE			0x80
>  #define CDNS_MCP_RESP_BASE			0x80
> -#define CDNS_MCP_CMD_LEN			0x20
> +/* FIFO can hold 8 commands */
> +#define CDNS_MCP_CMD_LEN			8
>  #define CDNS_MCP_CMD_WORD_LEN			0x4
>  
>  #define CDNS_MCP_CMD_SSP_TAG			BIT(31)
