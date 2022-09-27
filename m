Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8506C5EBBAC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiI0Hhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiI0HhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:37:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6D976758;
        Tue, 27 Sep 2022 00:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664264238; x=1695800238;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pX+zNRfLn5le6aSKqq4PcNUTp9fg1Q7IQ0BbM+hchz8=;
  b=PA/LudmQEmVZG9CUtvXH8Ce5B9bVRfvGHPLflGMeo5+EHtRrxX6YPa7A
   f2HfPRb8Cc36n/3khT+OWBmYcrT4/UIpeRCIQ7gl848tlECsicokqX3ah
   /ZAwPP1HYERSy2JmlAGqiRVJ0wChHArRUpIizK8k4R5fh5OflBIzHVive
   ORr8OpSiKO9pubXymObvxQvZ27JqTA85zH4g/FFpH4lFyJHzKMmmB7HQ4
   Kr7hiN8oriPfNUPjv1TFAcLVlqtG+UXuYOnxGhpoJ1vs7qt1lb/9NtLMm
   BuRv+0uYo5tDiOPCbYcwFa4lPdeRC7HryBiwIdpif+G+I+1NHgw+5gQFF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="280968673"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="280968673"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 00:37:17 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="599083965"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="599083965"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.249.206]) ([10.99.249.206])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 00:37:15 -0700
Message-ID: <677f4f9d-9224-b2d9-1574-f64985fcedbc@linux.intel.com>
Date:   Tue, 27 Sep 2022 09:37:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH][next] ASoC: uapi: Replace zero-length arrays with
 __DECLARE_FLEX_ARRAY() helper
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <YzIzUjUuJKf0mkKg@work>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <YzIzUjUuJKf0mkKg@work>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/2022 1:18 AM, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new __DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/227
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   include/uapi/sound/asoc.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
> index 053949287ce8..dd8ad790fc15 100644
> --- a/include/uapi/sound/asoc.h
> +++ b/include/uapi/sound/asoc.h
> @@ -226,9 +226,9 @@ struct snd_soc_tplg_vendor_array {
>   	__le32 type;	/* SND_SOC_TPLG_TUPLE_TYPE_ */
>   	__le32 num_elems;	/* number of elements in array */
>   	union {
> -		struct snd_soc_tplg_vendor_uuid_elem uuid[0];
> -		struct snd_soc_tplg_vendor_value_elem value[0];
> -		struct snd_soc_tplg_vendor_string_elem string[0];
> +		__DECLARE_FLEX_ARRAY(struct snd_soc_tplg_vendor_uuid_elem, uuid);
> +		__DECLARE_FLEX_ARRAY(struct snd_soc_tplg_vendor_value_elem, value);
> +		__DECLARE_FLEX_ARRAY(struct snd_soc_tplg_vendor_string_elem, string);
>   	};
>   } __attribute__((packed));
>   

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
