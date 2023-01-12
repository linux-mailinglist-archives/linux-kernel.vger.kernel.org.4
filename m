Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9907D667D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240247AbjALSLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240287AbjALSKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:10:49 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D6E7F47D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673545119; x=1705081119;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/XVhOXIzxC2c6cc0HV8x6SQi3STZ8h9Gysr+/y46yVU=;
  b=g3AKDzAz0xahjF6aVR0+IiMyudcI5OybkR5G3Y+WQ5bapEhAoVl+2S1d
   6glcuiE+EFTbNAU+As93hhNzgBjwtc4cPnGzaaL9onsTgG58Swf1Zs7Uv
   LRL0V9sMNhH8w66cZ+psYk401bHPLHqx2khAc7O3/BWarUrJyPkwfn1OL
   teZlWGthkXyMYPHy4HGrNl/AbqWXs+8IViVX0gBweRut4LoF+CG+dSBjP
   CQ/RwyAaPAiS5yUwWwueviPC5dnO/vu78MPiWmXYtErSAHB3OQR5wV7ma
   yo/zIX1AECdItT+bd3/S/tqpjz8KLoUIzx5lMJyBcY8Uxs3QkVKP4UdOO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="386113742"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="386113742"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 09:38:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="781832914"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="781832914"
Received: from jbetan3x-mobl1.amr.corp.intel.com (HELO [10.209.143.163]) ([10.209.143.163])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 09:38:38 -0800
Message-ID: <756fcb2d-d571-18cb-985e-d907ab682275@linux.intel.com>
Date:   Thu, 12 Jan 2023 11:38:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] regmap: sdw: Remove 8-bit value size restriction
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <20230112171840.2098463-1-ckeepax@opensource.cirrus.com>
 <20230112171840.2098463-3-ckeepax@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230112171840.2098463-3-ckeepax@opensource.cirrus.com>
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



> -static int regmap_sdw_write(void *context, unsigned int reg, unsigned int val)
> +static int regmap_sdw_write(void *context, const void *val_buf, size_t val_size)
>  {
>  	struct device *dev = context;
>  	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> +	/* First word of buffer contains the destination address */
> +	u32 addr = le32_to_cpu(*(const __le32 *)val_buf);
> +	const u8 *val = val_buf;
>  
> -	return sdw_write_no_pm(slave, reg, val);
> +	return sdw_nwrite_no_pm(slave, addr, val_size - sizeof(addr), val + sizeof(addr));
>  }
>  
> -static int regmap_sdw_read(void *context, unsigned int reg, unsigned int *val)
> +static int regmap_sdw_gather_write(void *context,
> +				   const void *reg_buf, size_t reg_size,
> +				   const void *val_buf, size_t val_size)
>  {
>  	struct device *dev = context;
>  	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> -	int read;
> +	u32 addr = le32_to_cpu(*(const __le32 *)reg_buf);

what's the difference between regmap_sdw_write() and
regmap_sdw_gather_write()? Seems to me that it's the same functionality
of writing at consecutive addresses. It's not a true 'gather' in the
sense that only the first address is used?

>  
> -	read = sdw_read_no_pm(slave, reg);
> -	if (read < 0)
> -		return read;
> +	return sdw_nwrite_no_pm(slave, addr, val_size, val_buf);
> +}
>  
> -	*val = read;
> -	return 0;
