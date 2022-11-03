Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A42C61873C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiKCSPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiKCSOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:14:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A546352;
        Thu,  3 Nov 2022 11:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667499294; x=1699035294;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ue0QTPXG2gQ3H5WYfpdjU3OegguiiLtgstYnj9DUpMk=;
  b=Q5CS9KiMWLdk+W0jDyHD4pLh1ZHlUOfagUR4e98pnRw6ZXA8v1dSlui6
   nlowMBmlsCah41PVGDK8TX2EZu/HPCWCnBQ4K7K/v7pcuDwd8chNcCxA5
   6DEs6EWptNAEUZabE0hqoVDUWz+RMFmY+WfK7ScW+i7Rso3zzw9/ZqinT
   WtOI9Zvd8mWZ1jvlXILnu5s6KoT52XcpuCdYqd1dEfYBdrDjaG4CwP/9q
   sI3QENRhrkIs0nmo3CCMWq/NURdNBZqkZ7nxSIbDexvYc39hlE5qvIr+1
   oU3LbGEG32S4RKIrZWLIrzv/nQyDXWFlowKJBRQWeGDHvRhzeJ2/CNfYI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="290154427"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="290154427"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 11:14:54 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="964033685"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="964033685"
Received: from cmelone-mobl.amr.corp.intel.com (HELO [10.212.66.233]) ([10.212.66.233])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 11:14:53 -0700
Message-ID: <cdb6baf9-dd36-39d1-937b-06be09da8242@linux.intel.com>
Date:   Thu, 3 Nov 2022 10:24:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH] ASoC: Intel: cirrus-common: Make const array uid_strings
 static
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221103120624.72583-1-colin.i.king@gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221103120624.72583-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/22 8:06 AM, Colin Ian King wrote:
> Don't populate the read-only const array uid_strings on the stack but
> instead make it static. Also makes the object code a little smaller.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/intel/boards/sof_cirrus_common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/sof_cirrus_common.c b/sound/soc/intel/boards/sof_cirrus_common.c
> index 6e39eda77385..851c516c8f5b 100644
> --- a/sound/soc/intel/boards/sof_cirrus_common.c
> +++ b/sound/soc/intel/boards/sof_cirrus_common.c
> @@ -155,7 +155,7 @@ static const char * const cs35l41_name_prefixes[] = { "WL", "WR", "TL", "TR" };
>    */
>   static int cs35l41_compute_codec_conf(void)
>   {
> -	const char * const uid_strings[] = { "0", "1", "2", "3" };
> +	static const char * const uid_strings[] = { "0", "1", "2", "3" };
>   	unsigned int uid, sz = 0;
>   	struct acpi_device *adev;
>   	struct device *physdev;

