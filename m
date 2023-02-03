Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DC1689E01
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 16:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjBCPRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 10:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbjBCPPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:15:37 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F489F9EF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 07:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675437205; x=1706973205;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MT/1DWmiNdOv0jG/vTHIL9cjtaEEbp2aoOQTv2f9NTg=;
  b=lxx/LZErUWVsOy8t/puBdmf2soPD64kkEYxGuc94VI4TLsMM5qHM+tlp
   rQUVoV16wy/DNvxG+PcAhdY3/ovGHkZO+XjkC1y5z8H4DjK9W80eO6r0C
   IpwKwhIt53RH6cpD3XY7u6GBasO9zppq9ASE25pQ7PSO2b+tswIOUQDDo
   S6BiZAUaf/72KeyP2W+RhBBuFNg+sFs9CRCHv7ogI5K5KgeRon/e4wORb
   lr3jBWkGEqAkNWg7RI8TA9Sy2G2BcL8ne3FeGrTzvpbUrOACCsDVI4XDY
   SHNUFY+I3L8M/hemHalr7qsx1zcsZ0Vrb43dzk4RykW7Gw1Jln1Nit0Ab
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="330898277"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="330898277"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 07:11:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="729290046"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="729290046"
Received: from albuitra-desk.amr.corp.intel.com (HELO [10.209.172.145]) ([10.209.172.145])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 07:11:42 -0800
Message-ID: <0b49c924-5994-c1cd-a174-4a2e2cfaf0d2@linux.intel.com>
Date:   Fri, 3 Feb 2023 08:35:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] soundwire: bus: Prevent infinite loop in
 sdw_ch_mask_to_ch()
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20230202154212.1098736-1-rf@opensource.cirrus.com>
 <20230202154212.1098736-2-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230202154212.1098736-2-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/23 09:42, Richard Fitzgerald wrote:
> Define the ch_mask argument of sdw_ch_mask_to_ch() as an unsigned
> so that the shift right is guaranteed to eventually make the
> value of ch_mask==0.
> 
> Previously ch_mask was defined as a signed int, but a right
> shift of a signed value preserves the sign bit. So if the sign
> bit was 1, ch_mask would never become 0 and the for loop would
> be infinite.
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  drivers/soundwire/bus.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> index 7631ef5e71fb..28bedc919b78 100644
> --- a/drivers/soundwire/bus.h
> +++ b/drivers/soundwire/bus.h
> @@ -160,7 +160,7 @@ int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
>  		 u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf);
>  
>  /* Retrieve and return channel count from channel mask */
> -static inline int sdw_ch_mask_to_ch(int ch_mask)
> +static inline int sdw_ch_mask_to_ch(unsigned int ch_mask)
>  {
>  	int c = 0;
>  

This patch1 is fine, but you remove this function in patch2, so is this
patch needed at all?

-/* Retrieve and return channel count from channel mask */
-static inline int sdw_ch_mask_to_ch(unsigned int ch_mask)
-{
-	int c = 0;
-
-	for (c = 0; ch_mask; ch_mask >>= 1)
-		c += ch_mask & 1;
-
-	return c;
-}
-
