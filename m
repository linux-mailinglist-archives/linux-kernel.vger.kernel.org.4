Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78345B89B3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiINOCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiINOBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:01:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B134F7B29A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663164038; x=1694700038;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t+vOnRYtTomPQlSR9thGxJNK0sEIELERgU5vaK6Jg1U=;
  b=jmBlAeOzsNDyDrAOZHMNKlysxTkXF4JIxGQYi/gTb3HVe/OHkOozsWYM
   erSccGV1ul6IKI2lXbDXdQyDNO5Yi52TmMSEz0QpXyAzkT9IhkBvCUmRP
   6vZBhy2alIeAyOaLeO6RDWoMZEdJvxqbtPoVk7tIrkrYBfpGbYDwz0nU6
   416EnMhHBPblLxUrHJje3RkPPtn9zn30uoT3v9OKGnGZl+Pp8Eokuz3yV
   HEqQT/79j2+78HrlcJpy6jdZQp82V89BNE5ffQuAr1uoMSlt8D5dntoRz
   bwwgREumCqgRuT6Fxa8B/cigJ08POAaXvEJJYGxU+ln/IpqoUH6eo0u+D
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="278164168"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="278164168"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 07:00:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="705968788"
Received: from blaesing-mobl.ger.corp.intel.com (HELO [10.249.45.209]) ([10.249.45.209])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 07:00:36 -0700
Message-ID: <1b506127-f992-b554-e984-589dc46aa110@linux.intel.com>
Date:   Wed, 14 Sep 2022 15:48:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 4/5] soundwire: cadence: Fix lost ATTACHED interrupts
 when enumerating
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220914120949.747951-1-rf@opensource.cirrus.com>
 <20220914120949.747951-5-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220914120949.747951-5-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 245191d22ccd..2f131604d884 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -954,9 +954,22 @@ static void cdns_update_slave_status_work(struct work_struct *work)
>  	u32 device0_status;
>  	int retry_count = 0;
>  
> +	/*
> +	 * Clear main interrupt first so we don't lose any assertions
> +	 * the happen during this function.

typo: that happen?

The flow looks good to me otherwise, so

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> +	 */
> +	cdns_writel(cdns, CDNS_MCP_INTSTAT, CDNS_MCP_INT_SLAVE_MASK);
> +
>  	slave0 = cdns_readl(cdns, CDNS_MCP_SLAVE_INTSTAT0);
>  	slave1 = cdns_readl(cdns, CDNS_MCP_SLAVE_INTSTAT1);
>  
> +	/*
> +	 * Clear the bits before handling so we don't lose any
> +	 * bits that re-assert.
> +	 */
> +	cdns_writel(cdns, CDNS_MCP_SLAVE_INTSTAT0, slave0);
> +	cdns_writel(cdns, CDNS_MCP_SLAVE_INTSTAT1, slave1);
> +
>  	/* combine the two status */
>  	slave_intstat = ((u64)slave1 << 32) | slave0;
>  
> @@ -964,8 +977,6 @@ static void cdns_update_slave_status_work(struct work_struct *work)
>  
>  update_status:
>  	cdns_update_slave_status(cdns, slave_intstat);
> -	cdns_writel(cdns, CDNS_MCP_SLAVE_INTSTAT0, slave0);
> -	cdns_writel(cdns, CDNS_MCP_SLAVE_INTSTAT1, slave1);
>  
>  	/*
>  	 * When there is more than one peripheral per link, it's
> @@ -982,6 +993,11 @@ static void cdns_update_slave_status_work(struct work_struct *work)
>  	 * attention with PING commands. There is no need to check for
>  	 * ALERTS since they are not allowed until a non-zero
>  	 * device_number is assigned.
> +	 *
> +	 * Do not clear the INTSTAT0/1. While looping to enumerate devices on
> +	 * #0 there could be status changes on other devices - these must
> +	 * be kept in the INTSTAT so they can be handled when all #0 devices
> +	 * have been handled.
>  	 */
>  
>  	device0_status = cdns_readl(cdns, CDNS_MCP_SLAVE_STAT);
> @@ -1001,8 +1017,7 @@ static void cdns_update_slave_status_work(struct work_struct *work)
>  		}
>  	}
>  
> -	/* clear and unmask Slave interrupt now */
> -	cdns_writel(cdns, CDNS_MCP_INTSTAT, CDNS_MCP_INT_SLAVE_MASK);
> +	/* unmask Slave interrupt now */
>  	cdns_updatel(cdns, CDNS_MCP_INTMASK,
>  		     CDNS_MCP_INT_SLAVE_MASK, CDNS_MCP_INT_SLAVE_MASK);
>  
