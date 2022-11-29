Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579ED63C032
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiK2MhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbiK2Mg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:36:59 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B912C5DBAF;
        Tue, 29 Nov 2022 04:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669725418; x=1701261418;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=2Ot6kpQYnmX13LuLXGQO8dgigBK9nXEKIxDZ7nwCo+o=;
  b=WLJIWurnoIkB1hg94welQ5zQB8T8vFqGWa33tjNuVBPsw5uz+FBS9NxY
   rs1+SjiV1iAAf0AJBI5bFSj3E124/JXwS2oFA/zKCS3HcfmA3JWpRfWW3
   8+LvPYDHg6rJiqamstJgI/17z6IAudJPM6uXcBhUb8t0TINqzZQRE8yy4
   I6pvkKZIOvt9MGhFw4AolsgsGjH1la/tSvWJQfj0Se/M0M4QWb7uFFBlZ
   TjAC+qpYr0EYSmG8PnW+Qpb45qubMdkFkSBpgwMSj+inWOD7InPLLjZVl
   wR5+aBVLzw9sAq1acRtoruAPoNl/9FGY+xhvfFlxkHnlq+0eitWj6ZrAZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="298446192"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="298446192"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 04:36:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="676411105"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="676411105"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.34.177])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 04:36:56 -0800
Message-ID: <8f2329cf-d482-7147-bd72-b8832e9bf123@intel.com>
Date:   Tue, 29 Nov 2022 14:36:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCHv2] mmc: block: remove non-data R1B ioctl workaround
Content-Language: en-US
To:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <57d4aceb25254e448bd3e575bd99b0c2@hyperstone.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <57d4aceb25254e448bd3e575bd99b0c2@hyperstone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/22 19:46, Christian Löhle wrote:
> The workaround of pretending R1B non-data transfers are
> data transfers in order for the busy timeout to be respected
> by the host controller driver is removed. It wasn't useful
> in a long time.
> 
> Initially the workaround ensured that R1B commands did not
> time out by setting the data timeout to be the command timeout
> in commit cb87ea28ed9e ("mmc: core: Add mmc CMD+ACMD passthrough ioctl").
> This was moved inside of an if clause with idata->buf_bytes being set
> in commit 4d6144de8ba2 ("mmc: core: check for zero length ioctl data").
> Since the workaround is now inside of the idata->buf_bytes clause
> and intended to fix R1B non-data transfers that do not have buf_bytes
> set we can also remove the workaround altogether.
> Since there are no data transfer invoking R1B commands this was dead
> code.
> 
> Fixes: cb87ea28ed9e ("mmc: core: Add mmc CMD+ACMD passthrough ioctl")
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Doesn't Fixes: 4d6144de8ba2 make more sense?

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> -v2: clarified commit message, no code change
>  drivers/mmc/core/block.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index db6d8a099910..20da7ed43e6d 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -514,19 +514,6 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>  		if (idata->ic.data_timeout_ns)
>  			data.timeout_ns = idata->ic.data_timeout_ns;
>  
> -		if ((cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
> -			/*
> -			 * Pretend this is a data transfer and rely on the
> -			 * host driver to compute timeout.  When all host
> -			 * drivers support cmd.cmd_timeout for R1B, this
> -			 * can be changed to:
> -			 *
> -			 *     mrq.data = NULL;
> -			 *     cmd.cmd_timeout = idata->ic.cmd_timeout_ms;
> -			 */
> -			data.timeout_ns = idata->ic.cmd_timeout_ms * 1000000;
> -		}
> -
>  		mrq.data = &data;
>  	}
>  

