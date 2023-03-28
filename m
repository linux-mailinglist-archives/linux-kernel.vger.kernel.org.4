Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CD46CBC2B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjC1KMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjC1KMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:12:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D313A61A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679998313; x=1711534313;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8CDsWAyvwLbajFmNrgYdd3DXC7kLoSn+eSVeKLFRIQc=;
  b=UBM4K4BPOTE2ZwjPYkGkhU/ZpOGSRxsZVALK3t6LkceZcK2PGpCYYsRG
   K0ECpLGFImGjeJFtmVB56sDkR+6I3UWVmT0h3+LXcJaZn5jmTU1Qtq5wK
   TsKXq6tAaBqbyD+mkGcjO2dMRUT7QQ+fqkWkNAfVHnIHTp3oCrFFmobk6
   P7f3hTXrwG8+OrFWx0Lvx6maWBBuPjSCUtASODlojVab+Tn21DEBB+shl
   R93sunj1Nzy6GvHYYKzFiZbOfQz2b2CyCsB4oAlttdH7MkCWu7287bJBN
   CNcgB8RSAtAONcuJuTRoQZMAs2t+JZYUsnWncdDHtMUeNYIKgz0dIdKuu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="324421802"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="324421802"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 03:11:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="753083829"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="753083829"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 03:11:28 -0700
Message-ID: <34017b95-5bb3-79a0-e819-17ee113fa6c8@linux.intel.com>
Date:   Tue, 28 Mar 2023 12:11:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v9] ASoC: tas2781: Add tas2781 driver
Content-Language: en-US
To:     Shenghao Ding <13916275206@139.com>, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com
Cc:     kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com
References: <20230328094940.1796-1-13916275206@139.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20230328094940.1796-1-13916275206@139.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/2023 11:49 AM, Shenghao Ding wrote:
> Create tas2781 driver.
> 
> Signed-off-by: Shenghao Ding <13916275206@139.com>
> 
> ---
> Changes in v9:
>   - rewording some commets
>   - Add comments on fimware parsing error handling -- all the memory resources
>      will be released in the end of tasdevice_rca_ready (fw_parse_data,
>      fw_parse_program_data & fw_parse_configuration_data).
>   - Add comments on fw_parse_calibration_data -- DSP can still work with default
>      calibrated data, memory resource related to calibrated data will be released
>      in the tasdevice_codec_remove.
> 	modified:   sound/soc/codecs/Kconfig
> 	modified:   sound/soc/codecs/Makefile
> 	new file:   sound/soc/codecs/tas2781-dsp.c
> 	new file:   sound/soc/codecs/tas2781-dsp.h
> 	new file:   sound/soc/codecs/tas2781-i2c.c
> 	new file:   sound/soc/codecs/tas2781.h
> ---

...

> +
> +static int fw_parse_block_data_kernel(struct tasdevice_fw *tas_fmw,
> +	struct tasdev_blk *block, const struct firmware *fmw, int offset)
> +{
> +	const unsigned char *data = fmw->data;
> +
> +	if (offset + 4 > fmw->size) {
> +		dev_err(tas_fmw->dev, "%s: File Size error\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	block->type = SMS_HTONL(data[offset], data[offset + 1],
> +		data[offset + 2], data[offset + 3]);
> +	offset += 4;
> +
> +	if (offset + 1 > fmw->size) {
> +		dev_err(tas_fmw->dev, "%s: PChkSumPresent error\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	block->is_pchksum_present = data[offset];
> +	offset++;
> +
> +	if (offset + 1 > fmw->size) {
> +		dev_err(tas_fmw->dev, "%s: mnPChkSum error\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	block->pchksum = data[offset];
> +	offset++;
> +
> +	if (offset + 1 > fmw->size) {
> +		dev_err(tas_fmw->dev, "%s: YChkSumPresent error\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	block->is_ychksum_present = data[offset];
> +	offset++;
> +
> +	if (offset + 1 > fmw->size) {
> +		dev_err(tas_fmw->dev, "%s: mnYChkSum error\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	block->ychksum = data[offset];
> +	offset++;
> +
> +	if (offset + 4 > fmw->size) {
> +		dev_err(tas_fmw->dev, "%s: blk_size error\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	block->blk_size = SMS_HTONL(data[offset], data[offset + 1],
> +		data[offset + 2], data[offset + 3]);
> +	offset += 4;
> +
> +	if (offset + 4 > fmw->size) {
> +		dev_err(tas_fmw->dev, "%s: nSublocks error\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	block->nr_subblocks = SMS_HTONL(data[offset], data[offset + 1],
> +		data[offset + 2], data[offset + 3]);
> +	offset += 4;
> +
> +	if (offset + block->blk_size > fmw->size) {
> +		dev_err(tas_fmw->dev, "%s: nSublocks error\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	block->data = kmemdup(&data[offset], block->blk_size, GFP_KERNEL);
> +	if (!block->data) {
> +		offset = -ENOMEM;
> +		goto out;
> +	}
> +	offset += block->blk_size;
> +
> +out:
> +	return offset;
> +}
> +


I have a question regarding those
if (offset + x > fmw->size) {
	do error
}
offset += x;

Can you instead of doing check before every assignment, just check once 
if you have enough data to parse, before parsing whole piece of data 
instead?

For above function it would be something like:

static int fw_parse_block_data_kernel(struct tasdevice_fw *tas_fmw,
	struct tasdev_blk *block, const struct firmware *fmw, int offset)
{
	const unsigned char *data = fmw->data;

	if (offset + 16 + block->blk_size > fmw->size) {
		dev_err(tas_fmw->dev, "%s: File Size error\n", __func__);
		offset = -EINVAL;
		goto out;
	}
	block->type = SMS_HTONL(data[offset], data[offset + 1],
		data[offset + 2], data[offset + 3]);
	block->is_pchksum_present = data[offset + 4];
	block->pchksum = data[offset + 5];
	block->is_ychksum_present = data[offset + 6];
	block->ychksum = data[offset + 7];
	block->blk_size = SMS_HTONL(data[offset + 8], data[offset + 9],
		data[offset + 10], data[offset + 11]);
	block->nr_subblocks = SMS_HTONL(data[offset + 12], data[offset + 13],
		data[offset + 14], data[offset + 15]);
	offset += 16;

	block->data = kmemdup(&data[offset], block->blk_size, GFP_KERNEL);
	if (!block->data) {
		offset = -ENOMEM;
		goto out;
	}
	offset += block->blk_size;

out:
	return offset;
}

Additionally if you defined 'struct tasdev_blk' to reflect data which 
you copy here it can probably be simplified further to simple memcpy, 
instead of doing field by field assignments, which would reduce amount 
of code significantly and make it easier to read.


Above applies to all similar parsing in the patch.


> +static int fw_parse_data_kernel(struct tasdevice_fw *tas_fmw,
> +	struct tasdevice_data *img_data, const struct firmware *fmw,
> +	int offset)
> +{
> +	const unsigned char *data = fmw->data;
> +	struct tasdev_blk *blk;
> +	unsigned int i;
> +

...

> +
> +#define SMS_HTONS(a, b)		((((a)&0x00FF)<<8) | ((b)&0x00FF))
> +#define SMS_HTONL(a, b, c, d)	((((a)&0x000000FF)<<24) | \
> +	(((b)&0x000000FF)<<16) | (((c)&0x000000FF)<<8) | \
> +	((d)&0x000000FF))
> +

Kernel has htons and htonl (in 
source/include/linux/byteorder/generic.h), but I assume that this means 
that your FW may use different endianness than host cpu (big endian?), 
so I would suggest using be16_to_cpu and be32_to_cpu macros instead, as 
this should be more understandable in this case.


