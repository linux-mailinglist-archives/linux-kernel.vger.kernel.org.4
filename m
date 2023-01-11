Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491816660AF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbjAKQhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbjAKQgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:36:18 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134F464DF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673454978; x=1704990978;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K+VKmwPyPd2Djkcizz3wC2h8rnKbiFkFV9EkJSM5gmk=;
  b=RvJ8om1Jp3oMmvtBLhTLHsIxC3YSSgcop8fE88WhW0nW2sO1q1gjG54m
   KiCZaOA/ya9w2hj0qXWC1jbUnl0Oq4ER5Kpop6MDep0KWzR4RLY+RCLow
   QytT+P/VRctM/j1p3Pvo0jnZfTrHXwnx2vK5Noh32GHUl95hioBH57M/6
   ux8Nif8f4nzl4fN54xH60QI53FERz2kPNQ4XV3nv3vEPQNfpzTUFxdJXS
   sLw3Jb5bNRZnJDsDXTyL+WhZjABR7uGE5PEUK3dQa99BaAWjgpcFeeyxG
   ON7yagOyDBp4rNnmBYwwBwud31fzltv/gVvA+VgDidBv/Sb0eswduKjLZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324704256"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="324704256"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 08:32:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607408791"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="607408791"
Received: from flobatol-mobl1.amr.corp.intel.com (HELO [10.212.110.208]) ([10.212.110.208])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 08:32:41 -0800
Message-ID: <612c78ea-335e-a196-247c-9e8f3442c3e5@linux.intel.com>
Date:   Wed, 11 Jan 2023 09:54:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 16/19] soundwire: amd: handle wake enable interrupt
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-17-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230111090222.2016499-17-Vijendar.Mukunda@amd.com>
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



On 1/11/23 03:02, Vijendar Mukunda wrote:
> Add wake enable interrupt support for both the soundwire controller

SoundWire.

> instances.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
> ---
>  drivers/soundwire/amd_master.c    | 9 +++++++++
>  drivers/soundwire/amd_master.h    | 1 +
>  include/linux/soundwire/sdw_amd.h | 1 +
>  3 files changed, 11 insertions(+)
> 
> diff --git a/drivers/soundwire/amd_master.c b/drivers/soundwire/amd_master.c
> index 290c59ab7760..2fd77a673c22 100644
> --- a/drivers/soundwire/amd_master.c
> +++ b/drivers/soundwire/amd_master.c
> @@ -1219,6 +1219,13 @@ static void amd_sdwc_update_slave_status_work(struct work_struct *work)
>  	u32 sw_status_change_mask_0to7_reg;
>  	u32 sw_status_change_mask_8to11_reg;
>  
> +	if (ctrl->wake_event) {
> +		pm_runtime_resume(ctrl->dev);
> +		acp_reg_writel(0x00, ctrl->mmio + ACP_SW_WAKE_EN);
> +		ctrl->wake_event = false;
> +		return;
> +	}

this is surprising.

A wake event typically happens when the bus is in clock-stop mode.
You cannot deal with wake events while dealing with the peripheral
status update, because you can only get that status when the manager is
up-and-running. There's a conceptual miss here, no?

If the wake comes from the PCI side, then it's the same comment: why
would the wake be handled while updating the peripheral status.

What am I missing?

