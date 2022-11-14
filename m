Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F676284DA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237043AbiKNQRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237378AbiKNQQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:16:43 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE3925E9C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668442602; x=1699978602;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=4xdTAPskJ9KY571YA+uOu9WW5TOZgcfRAB7ZQZa82Ac=;
  b=cqHzzSICXJ16iX+KbDozDh/dt3DPTaGqrPDDIe7O4aoThGEJS/ZZlvEg
   9ZpmsNZUOyEYj3Trleat25i9MJCZA9PtTjJkgCWjfJ5/VBR+rDkLJ2ix0
   FN0Kawa+WTQ7jOlEMR3mZMqWRzA4w2V4tyC62f6DhVuILLCvwBKbDih2G
   NKfCgwcuCGIJTA5RyPexdI8EviOijGc4xjHIciBvW5vcUHXHdePZ+m4DV
   JmL9mBBVLtpqKWcecfA1dKb8Q8/dPiN5XcIHLoBKF1IIMsY4Tbj4HoNEz
   liUk0ojhChMGnVeTzZpifHFl3c3D+KDQ5aOxVoEfIbfODvj5vl+vNHvWP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="295373437"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="295373437"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 08:16:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="638542600"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="638542600"
Received: from scewbso01.amr.corp.intel.com (HELO [10.212.76.77]) ([10.212.76.77])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 08:16:41 -0800
Message-ID: <bbc432e7-c52f-7e35-03d1-401cb68501cb@linux.intel.com>
Date:   Mon, 14 Nov 2022 10:14:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 3/4] soundwire: debugfs: Switch to sdw_read_no_pm
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20221114102956.914468-1-ckeepax@opensource.cirrus.com>
 <20221114102956.914468-4-ckeepax@opensource.cirrus.com>
Content-Language: en-US
In-Reply-To: <20221114102956.914468-4-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/22 04:29, Charles Keepax wrote:
> It is rather inefficient to be constantly enabling/disabling the PM
> runtime as we print out each individual register, switch to holding a PM
> runtime reference across the whole register output.

the change is good, but technically the pm_runtime resume happens for
the first read and suspend with a delay if use_autosuspend() is enabled,
so presumably we'll see the same number of resume/suspend with the
existing code and the suggested change.

Maybe update the commit message to mention that we constantly change
reference counts, as you did in the next patch?

> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
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
