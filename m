Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588A762D4E3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbiKQITp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiKQITm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:19:42 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5085212AB9;
        Thu, 17 Nov 2022 00:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668673181; x=1700209181;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ubReVEz2qZTNTbxKBF2gw5OuUWPlJ/d6WGYV6O8g2Wg=;
  b=jMJVdf6QSgE/KA2jnWIvhGSmVqNuiTnMsNWCYpdO617FZ5Q8rg/TpRZa
   tYxnusAFNS16V9v8oB1aeimR68pkT1D6nhfh3ySEYTH8zQifyZoW0lrnL
   vbs04uEP5rC4930fF6fjKGxH2rLcu4jlQTQvcT/b1Xwxcmq4XWVi6ZOHQ
   STk+yh3LzhoyUFxNxbcVBv4v9F5u8tiVqbHAcCaAcWQselHi5wpjwFr0v
   d6NRVgyNgoNu8pNTI9+6ocIAazN37YbHtn4BL2aSau0vUjaXX8h42yjvi
   LNqqI4T8rXURnJy1jXhpDgHhwnFi/GgRulGML++zFWF+m0HAwuULbPqdP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="377058015"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="377058015"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 00:19:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="670837458"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="670837458"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.99])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 00:19:39 -0800
Message-ID: <bf2c46b3-1117-55dd-ed89-7f4d3ff37b7e@intel.com>
Date:   Thu, 17 Nov 2022 10:19:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH] mmc: core: Do not require secure trim for discard
Content-Language: en-US
To:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
References: <8a17ed3e0eea4aaa82afd0af3b45bcaf@hyperstone.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <8a17ed3e0eea4aaa82afd0af3b45bcaf@hyperstone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/22 15:26, Christian Löhle wrote:
> Discard feature is independent of security features.
> The support check for all trims and discard falsely checked
> for secure trim/discard, but in the discard case this is not
> mandated by the spec.
> 

"Discard" was added after "Trim", so while MMC_TRIM_ARGS made
sense originally, that stopped with:

commit b3bf915308ca ("mmc: core: new discard feature support at eMMC v4.5")

So this could have that as a fixes tag.

Also MMC_TRIM_ARGS is a bit of a misleading name since it covers
one of the bits of MMC_DISCARD_ARG, so I suggest a second patch to
tidy things up.

Perhaps rename it and change the value to 8003 e.g.

#define MMC_TRIM_OR_DISCARD_ARGS	0x00008003

and make a wrapper for the Trim case:

static bool is_trim_arg(unsigned int arg)
{
	return (arg & MMC_TRIM_OR_DISCARD_ARGS) && arg != MMC_DISCARD_ARG;
}

> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/core/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 95fa8fb1d45f..507005211529 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1761,7 +1761,8 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
>  		return -EOPNOTSUPP;
>  
>  	if (mmc_card_mmc(card) && (arg & MMC_TRIM_ARGS) &&
> -	    !(card->ext_csd.sec_feature_support & EXT_CSD_SEC_GB_CL_EN))
> +	    !(card->ext_csd.sec_feature_support & EXT_CSD_SEC_GB_CL_EN) &&
> +	    arg != MMC_DISCARD_ARG)
>  		return -EOPNOTSUPP;
>  
>  	if (arg == MMC_SECURE_ERASE_ARG) {

