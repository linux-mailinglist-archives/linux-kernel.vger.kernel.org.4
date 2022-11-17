Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D850F62DEE9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239730AbiKQPAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240065AbiKQPAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:00:09 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008C276153
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668697207; x=1700233207;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SCUs7E0Hmpx45Jes1TPeWxVvcw4uUY3HMsnLGxpo4aw=;
  b=gpt/Djc83B04f0UQAPLn9aAFz7WNihcEpmdrQp0fepsT0cBrf9kNn1mk
   5gQFW7B4SR8qJ3GQ4DLLKNDV0Zgbl/uo4/Cm57tmOgGxEGQ5Dhe+sS1mO
   jm+tnOdVTx5RWScL+Q9QXQuhJZ2Zaru2UWJt7VEZsuYAhMKxFrIrp4u3J
   ZNy6MDa/OA/3zDvv0qWQO2LMLS6dg4zzV19bngsFAWgHFkua8rznjHs6n
   45G4x6um64ApF80/sIewKW7zfKG4D5RLao46WX9ePShexIXtgu14uxPH3
   2CMrZvfKhFIyH/IdbTcwzWPnUkkzTr0gK7yDiB3ZRgOP4uRki74Rosgmo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="314018177"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="314018177"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 07:00:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="617636506"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="617636506"
Received: from kristi4x-mobl1.amr.corp.intel.com (HELO [10.213.177.122]) ([10.213.177.122])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 07:00:05 -0800
Message-ID: <0cff6870-8de1-1c93-208b-9b57c328486e@linux.intel.com>
Date:   Thu, 17 Nov 2022 08:35:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/4] soundwire: bus: export sdw_nwrite_no_pm and
 sdw_nread_no_pm functions
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20221117141727.3031503-1-ckeepax@opensource.cirrus.com>
 <20221117141727.3031503-2-ckeepax@opensource.cirrus.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221117141727.3031503-2-ckeepax@opensource.cirrus.com>
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
> From: Simon Trimmer <simont@opensource.cirrus.com>
> 
> The commit 167790abb90f ("soundwire: export sdw_write/read_no_pm
> functions") exposed the single byte no_pm versions of the IO functions
> that can be used without touching PM, export the multi byte no_pm
> versions for the same reason.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
> 
> No change since v1.
> 
>  drivers/soundwire/bus.c       | 8 ++++----
>  include/linux/soundwire/sdw.h | 2 ++
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 76515c33e639e..ef4878258afad 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -414,8 +414,7 @@ int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
>   * all clients need to use the pm versions
>   */
>  
> -static int
> -sdw_nread_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
> +int sdw_nread_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
>  {
>  	struct sdw_msg msg;
>  	int ret;
> @@ -430,9 +429,9 @@ sdw_nread_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
>  		ret = 0;
>  	return ret;
>  }
> +EXPORT_SYMBOL(sdw_nread_no_pm);
>  
> -static int
> -sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val)
> +int sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val)
>  {
>  	struct sdw_msg msg;
>  	int ret;
> @@ -447,6 +446,7 @@ sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val)
>  		ret = 0;
>  	return ret;
>  }
> +EXPORT_SYMBOL(sdw_nwrite_no_pm);
>  
>  int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value)
>  {
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index 9e4537f409c29..902ed46f76c80 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -1047,7 +1047,9 @@ int sdw_write(struct sdw_slave *slave, u32 addr, u8 value);
>  int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value);
>  int sdw_read_no_pm(struct sdw_slave *slave, u32 addr);
>  int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val);
> +int sdw_nread_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val);
>  int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val);
> +int sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val);
>  int sdw_update(struct sdw_slave *slave, u32 addr, u8 mask, u8 val);
>  int sdw_update_no_pm(struct sdw_slave *slave, u32 addr, u8 mask, u8 val);
>  
