Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85D05EE0C5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbiI1PpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbiI1PpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:45:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0FB7C1F5;
        Wed, 28 Sep 2022 08:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664379908; x=1695915908;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L+jkqIsexqlzrYFOaFhwPJa/Gp1nFns+DyV2+D9NJWI=;
  b=JOWulIuBsr+J0ADIGh2uwt9gyC1Ia35lVwj6a9pOXfRYX0q7cV0zdoFb
   xmBgp5H4DRpeMrMmp/3+aFqCQv+tG83HrqZcoRdg5F7okr5nuJbSWD7d1
   5STNRuN1ovj8xyo0rs1yNWCwPBGiOMPiIXwi4Ruz0dLI8Qo/cmvdY5QyZ
   7AOe71HM2wDN2yUIIjgPbo2XnO+2xBOoYfxMtywAyesoilDcQJx5f28Ul
   RT3pZ1AoSviOKK9IfsotnI0hnUMYpvfl8hWqTX+oy+K0ZSBWqf+wYocf+
   P3jOOocKbwJ/fnPsoR/JNa8pSmfgyu8zkqqqPAGXTJsEBIbcrm+SDIcIz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="284769708"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="284769708"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 08:45:07 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="684454239"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="684454239"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.108.153]) ([10.212.108.153])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 08:45:05 -0700
Message-ID: <c53c4b89-45a9-a5e0-c162-43dc0a6e8ed6@intel.com>
Date:   Wed, 28 Sep 2022 08:45:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.0
Subject: Re: [PATCH v2] cxl: Replace HDM decoder granularity magic numbers
Content-Language: en-US
To:     Adam Manzanares <a.manzanares@samsung.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20220829220315uscas1p125d01bdd52a7aa6fd07c26bef7ead825@uscas1p1.samsung.com>
 <20220829220249.243888-1-a.manzanares@samsung.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220829220249.243888-1-a.manzanares@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/29/2022 3:03 PM, Adam Manzanares wrote:
> When reviewing the CFMWS parsing code that deals with the HDM decoders,
> I noticed a couple of magic numbers. This commit replaces these magic numbers
> with constants defined by the CXL 3.0 specification.
>
> v2:
>   - Change references to CXL 3.0 specification (David)
>   - CXL_DECODER_MAX_GRANULARITY_ORDER -> CXL_DECODER_MAX_ENCODED_IG (Dan)
>
> Signed-off-by: Adam Manzanares <a.manzanares@samsung.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>   drivers/cxl/cxl.h | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f680450f0b16..3ab81ad9d2e5 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -61,6 +61,10 @@
>   #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
>   #define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
>   
> +/* HDM decoder control register constants CXL 3.0 8.2.5.19.7 */
> +#define CXL_DECODER_MIN_GRANULARITY 256
> +#define CXL_DECODER_MAX_ENCODED_IG 6
> +
>   static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>   {
>   	int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
> @@ -71,9 +75,9 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>   /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
>   static inline int cxl_to_granularity(u16 ig, unsigned int *val)
>   {
> -	if (ig > 6)
> +	if (ig > CXL_DECODER_MAX_ENCODED_IG)
>   		return -EINVAL;
> -	*val = 256 << ig;
> +	*val = CXL_DECODER_MIN_GRANULARITY << ig;
>   	return 0;
>   }
>   
> @@ -96,7 +100,7 @@ static inline int cxl_to_ways(u8 eniw, unsigned int *val)
>   
>   static inline int granularity_to_cxl(int g, u16 *ig)
>   {
> -	if (g > SZ_16K || g < 256 || !is_power_of_2(g))
> +	if (g > SZ_16K || g < CXL_DECODER_MIN_GRANULARITY || !is_power_of_2(g))
>   		return -EINVAL;
>   	*ig = ilog2(g) - 8;
>   	return 0;
> @@ -248,7 +252,6 @@ enum cxl_decoder_type {
>    */
>   #define CXL_DECODER_MAX_INTERLEAVE 16
>   
> -#define CXL_DECODER_MIN_GRANULARITY 256
>   
>   /**
>    * struct cxl_decoder - Common CXL HDM Decoder Attributes
