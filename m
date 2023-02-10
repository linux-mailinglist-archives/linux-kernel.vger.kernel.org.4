Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F86691F98
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 14:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjBJNLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 08:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjBJNLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 08:11:33 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D260A49402;
        Fri, 10 Feb 2023 05:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676034692; x=1707570692;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ors6grSxgwuBhPM/3ThJCElFazXKgPN4WnWqYGXUpkI=;
  b=oDKxlhDtdn3snceHMwHrFmQhMjZV43wW8cQoTYgbMZPiPuhCJ7xiepDC
   aVSBNeNnhK9QuqPecpcKAMG+4rSqn5r9rFYxcnHcKreiR/FCUAQKH3jWG
   yGtSJhnPr6m/1daRra/czP/vJhI1RLR87SF+QrWFOMPv252WotKlnyGi0
   wL7cyy0qIoxRkxDcEoT8XPYDEhfngR/tNn/QweF1PRAoFfsKtpR21n0kn
   tW+RQvL4+rdjlD8ZqKgD3PCJwhteT0SfLd13yCBFAa1rjpkpQomYRppWQ
   0lEsCOc2wJJQ9jnjW4eGCgGV4T3RiFQu3fYf/QZ/3uQualhGYvL+KoJuS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="329047475"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="329047475"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 05:11:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="661409495"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="661409495"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 05:10:59 -0800
Message-ID: <54d4ffb1-1488-1a4f-58b2-8b3471389729@linux.intel.com>
Date:   Fri, 10 Feb 2023 14:10:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] ASoC: Intel: Skylake: Replace 1-element array with
 flex-array
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     Sasa Ostrouska <casaxa@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20230210051447.never.204-kees@kernel.org>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20230210051447.never.204-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/2023 6:14 AM, Kees Cook wrote:
> The kernel is globally removing the ambiguous 0-length and 1-element
> arrays in favor of flexible arrays, so that we can gain both compile-time
> and run-time array bounds checking[1]. In this instance, struct
> skl_cpr_cfg contains struct skl_cpr_gtw_cfg, which defined "config_data"
> as a 1-element array.
> 
> Normally when switching from a 1-element array to a flex-array, any
> related size calculations must be adjusted too. However, it seems the
> original code was over-allocating space, since 1 extra u32 would be
> included by the sizeof():
> 
>                  param_size = sizeof(struct skl_cpr_cfg);
>                  param_size += mconfig->formats_config[SKL_PARAM_INIT].caps_size;
> 
> But the copy uses caps_size bytes, and cap_size / 4 (i.e. sizeof(u32))
> for the length tracking:
> 
>          memcpy(cpr_mconfig->gtw_cfg.config_data,
>                          mconfig->formats_config[SKL_PARAM_INIT].caps,
>                          mconfig->formats_config[SKL_PARAM_INIT].caps_size);
> 
>          cpr_mconfig->gtw_cfg.config_length =
>                          (mconfig->formats_config[SKL_PARAM_INIT].caps_size) / 4;
> 
> Therefore, no size calculations need adjusting. Change the struct
> skl_cpr_gtw_cfg config_data member to be a true flexible array, which
> also fixes the over-allocation, and silences this memcpy run-time false
> positive:
> 
>    memcpy: detected field-spanning write (size 100) of single field "cpr_mconfig->gtw_cfg.config_data" at sound/soc/intel/skylake/skl-messages.c:554 (size 4)
> 
> [1] For lots of details, see both:
>      https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
>      https://people.kernel.org/kees/bounded-flexible-arrays-in-c
> 
> Reported-by: Sasa Ostrouska <casaxa@gmail.com>
> Link: https://lore.kernel.org/all/CALFERdwvq5day_sbDfiUsMSZCQu9HG8-SBpOZDNPeMdZGog6XA@mail.gmail.com/
> Cc: Cezary Rojewski <cezary.rojewski@intel.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: "Amadeusz Sławiński" <amadeuszx.slawinski@linux.intel.com>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   sound/soc/intel/skylake/skl-topology.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
> index 6db0fd7bad49..ad94f8020c27 100644
> --- a/sound/soc/intel/skylake/skl-topology.h
> +++ b/sound/soc/intel/skylake/skl-topology.h
> @@ -115,7 +115,7 @@ struct skl_cpr_gtw_cfg {
>   	u32 dma_buffer_size;
>   	u32 config_length;
>   	/* not mandatory; required only for DMIC/I2S */
> -	u32 config_data[1];
> +	u32 config_data[];
>   } __packed;
>   
>   struct skl_dma_control {

This fails in our validation. Maybe we can use the union workaround, to 
leave the size as is?

Following seems to work in manual test:
diff --git a/sound/soc/intel/skylake/skl-topology.h 
b/sound/soc/intel/skylake/skl-topology.h
index 6db0fd7bad49..ffbd2e60fede 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -115,7 +115,10 @@ struct skl_cpr_gtw_cfg {
         u32 dma_buffer_size;
         u32 config_length;
         /* not mandatory; required only for DMIC/I2S */
-       u32 config_data[1];
+       union {
+               u32 x;
+               u32 config_data[0];
+       };
  } __packed;

  struct skl_dma_control {

I can also run it through validation to make sure if it is acceptable.

