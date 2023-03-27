Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B376CA7B7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjC0Obv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjC0Obr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:31:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B54A422F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679927504; x=1711463504;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZzKtHhDArkoXCCLzATYG9vE13jPDCh6NMhFB6ze5+nY=;
  b=NC7O6XLNWeOUIFuOA6KT59cXdvwSuL70qCkF7W0/rhRSABha6xDNGS61
   mvRjs+Lw/E/vf3CUilL2k4cZLTBhgcf432NNHu7EcjnAuCbDCYvTQ8Lbh
   YdASbXR5MoBypRoQLv6gMLh5qi2vsEsKk/r5YCV/XA+8Kv1FD1U1yng/+
   sknPgpwKPWmW6WbivDZQkgcDrmYqHMJGzcf9X/pBw688iB4DORaExplqx
   7BoQliK7SrmObLCgsTIWIWyvPKoW1UNwrQb8Ee5glWCwOySDTdxV0+3+1
   BX1stAjFSIn/l/MvvMAa0/6YR2t3Y8OEuZrGC1hU1tFf+f25o+2n0VIFi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="320677860"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="320677860"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 07:30:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="676982848"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="676982848"
Received: from dchheda-mobl2.amr.corp.intel.com (HELO [10.212.176.72]) ([10.212.176.72])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 07:30:58 -0700
Message-ID: <18a04b79-bbba-2f58-8e9c-5446aa0eb34d@linux.intel.com>
Date:   Mon, 27 Mar 2023 09:20:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v8] ASoC: tas2781: Add tas2781 driver
Content-Language: en-US
To:     Shenghao Ding <13916275206@139.com>, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz
Cc:     kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com
References: <20230327105157.21752-1-13916275206@139.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230327105157.21752-1-13916275206@139.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code looks much better, and now that you've replaced all the -1
error codes with -EINVAL or -ENOMEM we can see clearly cases with memory
leaks in the error handling path.

> +	/* Skip the unused prog_size */
> +	offset += (4 * (TASDEVICE_MAXPROGRAM_NUM_KERNEL -
> +		tas_fmw->nr_programs));
> +
> +	if (offset + 4 > fmw->size) {
> +		dev_err(tas_dev->dev, "%s: Configurations error\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	tas_fmw->nr_configurations = SMS_HTONL(buf[offset], buf[offset + 1],
> +		buf[offset + 2], buf[offset + 3]);
> +	offset += 4;
> +
> +	/* The max of conf for more than equal to 4 pcs of tas2781s is
> +	 * different from the one less than 4 pcs of tas2781s.
> +	 */

Consider rewording, this comment is just confusing. Not sure what 'pcs'
means here, and "more than equal' and 'one less than' should be replaced
by 'greater than' and 'lower than'.

> +static int fw_parse_data(struct tasdevice_fw *tas_fmw,
> +	struct tasdevice_data *img_data, const struct firmware *fmw,
> +	int offset)
> +{
> +	const unsigned char *data = (unsigned char *)fmw->data;
> +	struct tasdev_blk *blk;
> +	unsigned int i;
> +	int n;
> +
> +	if (offset + 64 > fmw->size) {
> +		dev_err(tas_fmw->dev, "%s: Name error\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	memcpy(img_data->name, &data[offset], 64);
> +	offset += 64;
> +
> +	n = strlen((char *)&data[offset]);
> +	n++;
> +	if (offset + n > fmw->size) {
> +		dev_err(tas_fmw->dev, "%s: Description error\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	offset += n;
> +
> +	if (offset + 2 > fmw->size) {
> +		dev_err(tas_fmw->dev, "%s: Blocks error\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	img_data->nr_blk = SMS_HTONS(data[offset], data[offset + 1]);
> +	offset += 2;
> +
> +	img_data->dev_blks = kcalloc(img_data->nr_blk,
> +		sizeof(struct tasdev_blk), GFP_KERNEL);
> +	if (!img_data->dev_blks) {
> +		offset = -ENOMEM;
> +		goto out;
> +	}
> +	for (i = 0; i < img_data->nr_blk; i++) {
> +		blk = &(img_data->dev_blks[i]);
> +		offset = fw_parse_block_data(tas_fmw, blk, fmw, offset);
> +		if (offset < 0) {
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +	}
> +
> +out:
> +	return offset;

memory leak on img_data->dev_blks, you need to free memory in the error
handling path.

> +}
> +
> +static int fw_parse_calibration_data(struct tasdevice_priv *tas_dev,
> +	struct tasdevice_fw *tas_fmw, const struct firmware *fmw, int offset)
> +{
> +	struct tasdevice_calibration *calibration;
> +	unsigned char *data = (unsigned char *)fmw->data;
> +	unsigned int i, n;
> +
> +	if (offset + 2 > fmw->size) {
> +		dev_err(tas_dev->dev, "%s: Calibrations error\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	tas_fmw->nr_calibrations = SMS_HTONS(data[offset], data[offset + 1]);
> +	offset += 2;
> +
> +	if (tas_fmw->nr_calibrations != 1) {
> +		dev_err(tas_dev->dev,
> +			"%s: only support one calibraiton(%d)!\n",
> +			__func__, tas_fmw->nr_calibrations);
> +		goto out;
> +	}
> +
> +	tas_fmw->calibrations = kcalloc(tas_fmw->nr_calibrations,
> +		sizeof(struct tasdevice_calibration), GFP_KERNEL);
> +	if (!tas_fmw->calibrations) {
> +		offset = -ENOMEM;
> +		goto out;
> +	}
> +	for (i = 0; i < tas_fmw->nr_calibrations; i++) {
> +		if (offset + 64 > fmw->size) {
> +			dev_err(tas_dev->dev, "Calibrations error\n");
> +			offset = -EINVAL;

memory leak on tas_fmw->calibrations, you need to change the error
handling path.

> +			goto out;
> +		}
> +		calibration = &(tas_fmw->calibrations[i]);
> +		offset += 64;
> +
> +		n = strlen((char *)&data[offset]);
> +		n++;
> +		if (offset + n > fmw->size) {
> +			dev_err(tas_dev->dev, "Description err\n");
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		offset += n;
> +
> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: Prog err, offset = %d\n",
> +				__func__, offset);
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		offset++;
> +
> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: Conf err, offset = %d\n",
> +				__func__, offset);
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		offset++;
> +
> +		offset = fw_parse_data(tas_fmw, &(calibration->dev_data), fmw,
> +			offset);
> +		if (offset < 0)
> +			goto out;
> +	}
> +
> +out:
> +	return offset;
> +}
> +
> +static int fw_parse_program_data(struct tasdevice_priv *tas_dev,
> +	struct tasdevice_fw *tas_fmw, const struct firmware *fmw, int offset)
> +{
> +	unsigned char *buf = (unsigned char *)fmw->data;
> +	struct tasdevice_prog *program;
> +	int i;
> +
> +	if (offset + 2 > fmw->size) {
> +		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	tas_fmw->nr_programs = SMS_HTONS(buf[offset], buf[offset + 1]);
> +	offset += 2;
> +
> +	if (tas_fmw->nr_programs == 0) {
> +		/*Not error in calibration Data file, return directly*/
> +		dev_info(tas_dev->dev, "%s: No Programs data, maybe calbin\n",
> +			__func__);
> +		goto out;
> +	}
> +
> +	tas_fmw->programs =
> +		kcalloc(tas_fmw->nr_programs, sizeof(struct tasdevice_prog),
> +			GFP_KERNEL);
> +	if (!tas_fmw->programs) {
> +		offset = -ENOMEM;
> +		goto out;
> +	}
> +	for (i = 0; i < tas_fmw->nr_programs; i++) {
> +		int n = 0;
> +
> +		program = &(tas_fmw->programs[i]);
> +		if (offset + 64 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: mpName error\n", __func__);
> +			offset = -EINVAL;
> +			goto out;

and memory leak here as well.

Stopping the review here, please revisit the error handling. you
probably need two labels when memory is allocated, and a kfree() for one
of the two.
