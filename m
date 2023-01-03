Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3142B65C38C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbjACQHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238151AbjACQH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:07:29 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257A11276A
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672762042; x=1704298042;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J5CMzr29omiM84inuu5NkFtk950zuT/xGASY9w81KSs=;
  b=Oa/B9eEIcHkvN1NI4MZ/cfUw1b77pOv3R5tNeNrJn9ELl988m31ESbdA
   kMY77JKEaoOQM63Lf3HZHyBGYlkXGj+kYvse+pM8Ygs4jHTE51G3kXYxh
   kXqE540GovEhi3rIHmptWYAAJjc4Dx3mYy51PyAuyVPgzb3x73mnluWFY
   mELRpA6LcdXsWQAbOFJAGRbUx66aKqL4xkXTzJoNfWcRH9WxQOLtJUcKg
   3HA4jQPHqb7qKvD+WYRSDmSSh7IEuQkcOvedhIxxCPWNWHrV3ihCsjPcJ
   osQGaxR616bJaBkJK+Ipj69BGRHp2BD/7+yJQcI9+sIp7WfKykjGHN2jI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="305196324"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="305196324"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 08:07:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="743546025"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="743546025"
Received: from nkpuppal-mobl2.amr.corp.intel.com (HELO [10.209.178.199]) ([10.209.178.199])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 08:07:20 -0800
Message-ID: <731b2d59-22f1-a456-bcfc-040a1adccce0@linux.intel.com>
Date:   Tue, 3 Jan 2023 09:08:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/5] ASoC: Intel: bytcht_cx2072x: Replace open coded
 acpi_dev_put()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20230102203037.16120-1-andriy.shevchenko@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230102203037.16120-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/2/23 14:30, Andy Shevchenko wrote:
> Instead of calling put_device(&adev->dev) where adev is a pointer
> to an ACPI device, use specific call, i.e. acpi_dev_put().
> 
> Also move it out of the conditional to make it more visible in case
> some other code will be added which may use that pointer. We need
> to keep a reference as long as we use the pointer.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Answering for the series: we should make the change across all Intel
machine drivers. I see at least four cases that were missed

bytcr_rt5640.c:         put_device(&adev->dev);
bytcr_rt5651.c:         put_device(&adev->dev);
bytcr_wm5102.c: put_device(&adev->dev);
sof_es8336.c:           put_device(&adev->dev);


> ---
>  sound/soc/intel/boards/bytcht_cx2072x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/bytcht_cx2072x.c b/sound/soc/intel/boards/bytcht_cx2072x.c
> index 41cec67157b6..9942a2de6f7a 100644
> --- a/sound/soc/intel/boards/bytcht_cx2072x.c
> +++ b/sound/soc/intel/boards/bytcht_cx2072x.c
> @@ -253,9 +253,9 @@ static int snd_byt_cht_cx2072x_probe(struct platform_device *pdev)
>  	if (adev) {
>  		snprintf(codec_name, sizeof(codec_name), "i2c-%s",
>  			 acpi_dev_name(adev));
> -		put_device(&adev->dev);
>  		byt_cht_cx2072x_dais[dai_index].codecs->name = codec_name;
>  	}
> +	acpi_dev_put(adev);
>  
>  	/* override platform name, if required */
>  	ret = snd_soc_fixup_dai_links_platform_name(&byt_cht_cx2072x_card,
