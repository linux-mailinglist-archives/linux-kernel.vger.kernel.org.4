Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642726FEB20
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjEKFXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbjEKFXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:23:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28084EFF;
        Wed, 10 May 2023 22:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683782578; x=1715318578;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=YQILfujNddGsJDn6gNgiGkyToy216wtJuXCwsYZYlRU=;
  b=Y2M0D5j7A0dhgFXUFe6H4aeCFDPPC4kFK0EwSDk0G1sU7yyFLim8h09J
   vNe/mRY8ZrT7kGi3pFfnIKjdm6LI1R45uvMp8i8MuFWcldA++BJH2LYT4
   N0JLqL4VMyz9GGaIYU3eotKQmYsj5rZjMMiOEzYmRJPINmZ3rfbY46GGC
   m8Y4SIvs7VZw4SRTwaoxO+D1TPjRj0dSmWzDsN8De/dd43RL8m6pfj0Cm
   bujzfGRzNI1Cm/zRlUfsB1FeWeul1Cgyg81fPj9upQ7Vq42dwWDDucsSk
   fwqKXULIqkEAFxdoCSv9yhMuFK9cU6INfVkYH+HyQHKNgRlYJqRF67rIm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="353487834"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="353487834"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 22:22:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="873819393"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="873819393"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.218.125])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 22:22:30 -0700
Message-ID: <08bc0186-4684-2321-65d8-4c2ae622acea@intel.com>
Date:   Thu, 11 May 2023 08:22:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v1] ufs: poll HCS.UCRDY before issuing a UIC command
To:     Kiwoong Kim <kwmad.kim@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com, sc.suh@samsung.com,
        hy50.seo@samsung.com, sh425.lee@samsung.com,
        kwangwon.min@samsung.com
References: <CGME20230509083312epcas2p375f77d18a9026f7d263750baf9c9a5bb@epcas2p3.samsung.com>
 <1683620674-160173-1-git-send-email-kwmad.kim@samsung.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1683620674-160173-1-git-send-email-kwmad.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/05/23 11:24, Kiwoong Kim wrote:
> With auto hibern8 enabled, UIC could be working
> for a while to process a hibern8 operation and HCI
> reports UIC not ready for a short term through HCS.UCRDY.
> And UFS driver can't recognize the operation.
> UFSHCI spec specifies UCRDY like this:
> whether the host controller is ready to process UIC COMMAND
> 
> The 'ready' could be seen as many different meanings. If the meaning
> includes not processing any request from HCI, processing a hibern8
> operation can be 'not ready'. In this situation, the driver needs to
> wait until the operations is completed.
> 
> Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
> ---
>  drivers/ufs/core/ufshcd.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 96ce6af..fc79539 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -2368,7 +2368,18 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
>   */
>  static inline bool ufshcd_ready_for_uic_cmd(struct ufs_hba *hba)
>  {
> -	return ufshcd_readl(hba, REG_CONTROLLER_STATUS) & UIC_COMMAND_READY;
> +	ktime_t timeout = ktime_add_ms(ktime_get(), UIC_CMD_TIMEOUT);
> +	u32 val = 0;
> +
> +	do {
> +		val = ufshcd_readl(hba, REG_CONTROLLER_STATUS) &
> +			UIC_COMMAND_READY;
> +		if (val)
> +			break;
> +		usleep_range(500, 1000);

Pedantically, the sleep probably needs to be less than the
auto-hibernate idle timer period?

> +	} while (ktime_before(ktime_get(), timeout));

read_poll_timeout() would be a better choice for I/O polling

> +
> +	return val ? true : false;
>  }
>  
>  /**

