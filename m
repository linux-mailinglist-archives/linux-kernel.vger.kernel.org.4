Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130E36B1B0B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 06:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCIF67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 00:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCIF6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 00:58:52 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17A0637F0;
        Wed,  8 Mar 2023 21:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678341531; x=1709877531;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ka36+aBjWro1R1NjP+oqzaZACgg+/ZgCvacxGDr861U=;
  b=E4iNjqb+wL86c/7/ZUe+czd5oPoxIj6YtVWoBCDMB5Q5nbiH5ucDRpBH
   B0vh4/v3oIo6EqeoeOFJVk9X9dTh26ZuM8omggw62cAMSucoHqXNiBEXM
   YRIPGNQSJXQQJcKSPMLN/0K2JyqtrnddMgMaUtgqLlx6vAsfxkJ568hWG
   Jbw94EIrd/qgyH+Eoteepis6ZK/Tgtct18eB7XBfacdt1eb5YNSCKImXl
   /dnOBru5bxxBsk3asZQF+1cuHH3tRWsvv5DtmOCA6BMukzh4/3E6sh9GO
   m3v6pvIUHM+QvREYNWUqEVenNdECSx1tb1brPbju4v+Hw4B0uXOyjU0Q5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="337886316"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="337886316"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 21:58:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="670605428"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="670605428"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.219.30])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 21:58:47 -0800
Message-ID: <16dd4f27-aee6-97ee-ed20-87c0523c247d@intel.com>
Date:   Thu, 9 Mar 2023 07:58:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [RFC PATCH v2 1/3] ufs: mcq: Add supporting functions for mcq
 abort
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        beanhuo@micron.com, avri.altman@wdc.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1678338926.git.quic_nguyenb@quicinc.com>
 <68b786f390dbd93218a482d18c513bc332e82da3.1678338926.git.quic_nguyenb@quicinc.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <68b786f390dbd93218a482d18c513bc332e82da3.1678338926.git.quic_nguyenb@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/03/23 07:28, Bao D. Nguyen wrote:
> Add supporting functions to handle ufs abort in mcq mode.
> 
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> ---
>  drivers/ufs/core/ufs-mcq.c     | 181 +++++++++++++++++++++++++++++++++++++++++
>  drivers/ufs/core/ufshcd-priv.h |  14 ++++
>  drivers/ufs/core/ufshcd.c      |   3 +-
>  include/ufs/ufshcd.h           |   1 +
>  include/ufs/ufshci.h           |  16 ++++
>  5 files changed, 214 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index 31df052..4c33c1a 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -12,6 +12,9 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include "ufshcd-priv.h"
> +#include <linux/delay.h>
> +#include <scsi/scsi_cmnd.h>
> +#include <linux/bitfield.h>
>  
>  #define MAX_QUEUE_SUP GENMASK(7, 0)
>  #define UFS_MCQ_MIN_RW_QUEUES 2
> @@ -27,6 +30,9 @@
>  #define MCQ_ENTRY_SIZE_IN_DWORD	8
>  #define CQE_UCD_BA GENMASK_ULL(63, 7)
>  
> +/* Max mcq register polling time in millisecond unit */
> +#define MCQ_POLL_MS 500
> +
>  static int rw_queue_count_set(const char *val, const struct kernel_param *kp)
>  {
>  	return param_set_uint_minmax(val, kp, UFS_MCQ_MIN_RW_QUEUES,
> @@ -429,3 +435,178 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
>  	host->host_tagset = 1;
>  	return 0;
>  }
> +
> +static int ufshcd_mcq_poll_register(void __iomem *reg, u32 mask,
> +			u32 val, unsigned long timeout_ms)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
> +	int err = 0;
> +
> +	/* ignore bits that we don't intend to wait on */
> +	val = val & mask;
> +
> +	while ((readl(reg) & mask) != val) {
> +		usleep_range(10, 50);
> +		if (time_after(jiffies, timeout)) {
> +			err = -ETIMEDOUT;
> +			break;
> +		}
> +	}

Should be able to use a macro from include/linux/iopoll.h
here

> +
> +	return err;
> +}


