Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30E7714902
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjE2MDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2MDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:03:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CFBC7;
        Mon, 29 May 2023 05:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685361829; x=1716897829;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JC6wS1E/TUOOIhq2nrfMiSXO3UBC6enXa7DxWwVAz2A=;
  b=fN8ad6VXfQlX3oNAWeeoMDvVBNOxeHY5MATcitDZwmRVoEnMJWaj8z9L
   1OfQEPhfBeKnIheiD2aO97ERTrDy2+ZBD77oxHs8scv6etd6v/uvfYCzk
   jUnpVI1gOGjgObfuVNc//1uHY4aFDZ/6cCI1ZZ3hUObIwyLvxBX8Y+mTG
   93y9JqUsLbR/fedmze8k+wJWot5aohGOrS1ubjI6Lf48YYSdTYHWf80iY
   OY+VvCkjQpLKrgPYw8nc5qSOTujknDhC+/Y+6vMz8BmDN50aVZbkEhcEd
   mZhTSjrPUQi71nI++/jRf7ydJtjR7V1f4CObepiOLitSRQKJyIeqdQbfF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="339278184"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="339278184"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 05:03:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="706042704"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="706042704"
Received: from btaubert-mobl1.ger.corp.intel.com ([10.252.55.237])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 05:03:46 -0700
Date:   Mon, 29 May 2023 15:03:43 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] platform/x86: think-lmi: Correct NVME password
 handling
In-Reply-To: <20230526171658.3886-3-mpearson-lenovo@squebb.ca>
Message-ID: <a52f69f-2dc4-fe76-9f89-e1c143d2bb27@linux.intel.com>
References: <mpearson-lenovo@squebb.ca> <20230526171658.3886-1-mpearson-lenovo@squebb.ca> <20230526171658.3886-3-mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2023, Mark Pearson wrote:

> NVME passwords identifier have been standardised across the Lenovo
> systems and now use udrp and adrp (user and admin level) instead of
> unvp and mnvp.
> 
> This should apparently be backwards compatible.
> 
> Also cleaned up so the index is set to a default of 1 rather than 0
> as this just makes more sense (there is no device 0).

These two sound entirely separate changes. If that's the case, please 
make own patch from the send change.

Hmm, index_store() still allows 0, is that also related here? Please check 
also ABI documentation as index default seems to be mentioned there as 
well.

-- 
 i.

> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
> Changes in v2 & v3: None. Version bumped in series
> 
>  drivers/platform/x86/think-lmi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index c7e98fbe7c3d..1c02958035ad 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -456,9 +456,9 @@ static ssize_t new_password_store(struct kobject *kobj,
>  				sprintf(pwd_type, "mhdp%d", setting->index);
>  		} else if (setting == tlmi_priv.pwd_nvme) {
>  			if (setting->level == TLMI_LEVEL_USER)
> -				sprintf(pwd_type, "unvp%d", setting->index);
> +				sprintf(pwd_type, "udrp%d", setting->index);
>  			else
> -				sprintf(pwd_type, "mnvp%d", setting->index);
> +				sprintf(pwd_type, "adrp%d", setting->index);
>  		} else {
>  			sprintf(pwd_type, "%s", setting->pwd_type);
>  		}
> @@ -1524,6 +1524,10 @@ static int tlmi_analyze(void)
>  		if (!tlmi_priv.pwd_nvme)
>  			goto fail_clear_attr;
>  
> +		/* Set default hdd/nvme index to 1 as there is no device 0 */
> +		tlmi_priv.pwd_hdd->index = 1;
> +		tlmi_priv.pwd_nvme->index = 1;
> +
>  		if (tlmi_priv.pwdcfg.core.password_state & TLMI_HDD_PWD) {
>  			/* Check if PWD is configured and set index to first drive found */
>  			if (tlmi_priv.pwdcfg.ext.hdd_user_password ||
> 

