Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C29A66794F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbjALPb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240325AbjALPaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:30:02 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C0AE021
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673536994; x=1705072994;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h/jmBfUIardPjEK19fEEdz739eyHPFiYa2jLT9jegNc=;
  b=cQNVGvkPR46ieh2hoITrJIFQDlzTrDZyb2CWFXhgsdR/NBhiecx8YQJI
   +D4vkj2iodd4Ovp+9SmQCBYeVRdxAMp8WzASmSA2UjtsEe6fGYhqx1OZu
   2/KQbFslt8wwyHxj+JAWuv6kAKkbuPzAJG0/t8MBkQH4vtxxAuu8mFzM1
   Naaslro1YXEA5NFQoQg6yDkVOUTW6SPpyZt7RXVgzzwNinvcOuuPssPO3
   aP5nC8DWPQzK+gKp2DxJt0C+mwS8NLm2nwFKM+vGVj9SU2iBAieIZDZGJ
   tQln9/x7gB/2l7Nof6Z5lWRbV2ImAh6+5jVa14GxI9gg5wLQUF3uGSO2R
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="388212597"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="388212597"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 06:57:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="607816951"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="607816951"
Received: from jbetan3x-mobl1.amr.corp.intel.com (HELO [10.209.143.163]) ([10.209.143.163])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 06:57:16 -0800
Message-ID: <dae0ce3e-8538-f0ed-d065-464c6c2b8c6e@linux.intel.com>
Date:   Thu, 12 Jan 2023 08:56:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/5] ASoC: Intel: Balance ACPI device refcount
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20230112112852.67714-1-andriy.shevchenko@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230112112852.67714-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/23 05:28, Andy Shevchenko wrote:
> While looking for the open coded put_device(&adev->dev) cases, where
> adev stands for ACPI device, I noticed that in a few ASoC Intel driver,
> among others, the refcount is not balanced properly in some cases.
> 
> This series fixes that issue and converts to use acpi_dev_put().

Thanks Andy!

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> 
> Changelog v2:
> - split Intel drivers out from others (Pierre)
> - sent with cover letter (Mark)
> 
> Andy Shevchenko (5):
>   ASoC: Intel: bytcht_es8316: Drop reference count of ACPI device after
>     use
>   ASoC: Intel: bytcr_rt5651: Drop reference count of ACPI device after
>     use
>   ASoC: Intel: bytcr_rt5640: Drop reference count of ACPI device after
>     use
>   ASoC: Intel: bytcr_wm5102: Drop reference count of ACPI device after
>     use
>   ASoC: Intel: sof_es8336: Drop reference count of ACPI device after use
> 
>  sound/soc/intel/boards/bytcht_es8316.c | 20 ++++++++++++--------
>  sound/soc/intel/boards/bytcr_rt5640.c  | 12 ++++++------
>  sound/soc/intel/boards/bytcr_rt5651.c  |  2 +-
>  sound/soc/intel/boards/bytcr_wm5102.c  |  2 +-
>  sound/soc/intel/boards/sof_es8336.c    | 14 ++++++++------
>  5 files changed, 28 insertions(+), 22 deletions(-)
> 
