Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22F762DEEA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240059AbiKQPA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240198AbiKQPAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:00:09 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D2E240AC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668697208; x=1700233208;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pym+nN5dyyoSuoPqt65bfQahyNJPS85MeiSSlQoBJ/8=;
  b=dR/HNK+bZ/fdYYqwWKswB9Gfj2Gg/jrRJ4dvSgoaznN8U/YGj/ilh1vK
   lNkq9kakDl9hToboTMl4m2QEU+fCpe5t0OKCWxmpfFd0KDDfDFgJwpiHT
   XVhxuKj5giJZjFfx//udnsDS9PpGqXolISg15zNbAQlUDZSQXyqeYr7zE
   d9dtS7933pGowbBmaWe+wIdi9QC7UPskpF/PX15YV6ijgsOmy12H/tZbd
   5lwGSoJiQWQ6WD2yS6QM4Vcy+4e+UcUXWbk0yx1c7R33c1vMmtwAHxt3/
   j5yHDg1ToU7QjSDUGsjkZLLhzcmozW5vmBNlTZdt/naEQYmYCqxvPScjy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="314018188"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="314018188"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 07:00:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="617636533"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="617636533"
Received: from kristi4x-mobl1.amr.corp.intel.com (HELO [10.213.177.122]) ([10.213.177.122])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 07:00:07 -0800
Message-ID: <d6fd57a0-4cb6-99df-d49c-eb18ff58b8a3@linux.intel.com>
Date:   Thu, 17 Nov 2022 08:44:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 3/4] soundwire: debugfs: Switch to sdw_read_no_pm
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20221117141727.3031503-1-ckeepax@opensource.cirrus.com>
 <20221117141727.3031503-4-ckeepax@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221117141727.3031503-4-ckeepax@opensource.cirrus.com>
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



On 11/17/22 08:17, Charles Keepax wrote:
> It is rather inefficient to be constantly playing with the runtime
> PM reference for each individual register, switch to holding a PM
> runtime reference across the whole register output.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
> 
> Changes since v1:
>  - Reworded commit message
> 
>  drivers/soundwire/debugfs.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
> index 49900cd207bc7..0718e9cda138a 100644
> --- a/drivers/soundwire/debugfs.c
> +++ b/drivers/soundwire/debugfs.c
> @@ -4,6 +4,7 @@
>  #include <linux/device.h>
>  #include <linux/debugfs.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/soundwire/sdw.h>
>  #include <linux/soundwire/sdw_registers.h>
> @@ -35,7 +36,7 @@ static ssize_t sdw_sprintf(struct sdw_slave *slave,
>  {
>  	int value;
>  
> -	value = sdw_read(slave, reg);
> +	value = sdw_read_no_pm(slave, reg);
>  
>  	if (value < 0)
>  		return scnprintf(buf + pos, RD_BUF - pos, "%3x\tXX\n", reg);
> @@ -55,6 +56,10 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
>  	if (!buf)
>  		return -ENOMEM;
>  
> +	ret = pm_runtime_resume_and_get(&slave->dev);
> +	if (ret < 0 && ret != -EACCES)
> +		return ret;
> +
>  	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
>  
>  	/* DP0 non-banked registers */
> @@ -112,6 +117,10 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
>  	}
>  
>  	seq_printf(s_file, "%s", buf);
> +
> +	pm_runtime_mark_last_busy(&slave->dev);
> +	pm_runtime_put(&slave->dev);
> +
>  	kfree(buf);
>  
>  	return 0;
