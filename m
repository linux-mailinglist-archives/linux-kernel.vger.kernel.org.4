Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203C56C32F8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjCUNet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjCUNes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:34:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9803E3E606
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 06:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679405682; x=1710941682;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=un1IUHGvRppkACDWf91A+AiESkO7PwrlxEMws/fNJLI=;
  b=RatlD2lHa7dFeQgjFVe5Efs9W327y4PT8gQEgUSCFt8i6vBE0DL79aAg
   rUVyynHJ/xodqKReR25HtHN1NwV0Dmr42PdMcFWdYor24MD764GPT7Ahb
   V4pz32qGEFgfyxJog9OPD0UM+6vbukxI2HfI78EQzbsAblyJ/fDyNHUGE
   /hTqC97sLWwTsMS9g7mXtDrMlnWNIJuokxpzeuT2nDcobQ9lt0eiq0JMU
   d0Nhf3FWY9hUBFoDAEiubgVBEsqbGj+hgAnQMXAq5zq2iklKAdXgwvTNv
   Wfyl4N+eU06I1eV++T/9gBX0i9PfxKnWgJxepg3OL7b9ntYjiK3ACS7xj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="338975375"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="338975375"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 06:34:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="745848373"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="745848373"
Received: from wbalakri-mobl.amr.corp.intel.com (HELO [10.209.120.92]) ([10.209.120.92])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 06:33:35 -0700
Message-ID: <9700e678-1c26-d614-d6fb-7c7d5d1ebe23@linux.intel.com>
Date:   Tue, 21 Mar 2023 08:21:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v5] ASoC: tas2781: Add tas2781 driver
Content-Language: en-US
To:     Shenghao Ding <13916275206@139.com>, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz
Cc:     kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com
References: <20230321113130.25853-1-13916275206@139.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230321113130.25853-1-13916275206@139.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You still have quite a few style/typo issues, an inconsistent use of -1
for errors.

Sleep times are very odd, e.g.

sleep_dur = (book << 8) + page;
msleep(sleep_dur);

or

usleep_range(delay_time*1000, delay_time*1000);

and the mutex uses are not clear.

Please go through all the comments, I had to repeat myself a number of
times...


> +// ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
> +//
> +// Copyright (C) 2022 - 2023 Texas Instruments Incorporated
> +// https://www.ti.com
> +//
> +// The TAS2781 driver implements a flexible and configurable algo coff setting

typo: coefficient?

> +// for one, two, even multiple TAS2781 chips.
> +//
> +// Author: Shenghao Ding <shenghao-ding@ti.com>
> +// Author: Kevin Lu <kevin-lu@ti.com>
> +//
> +
> +#include <linux/crc8.h>
> +#include <linux/firmware.h>
> +#include <linux/fs.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +
> +#include "tas2781.h"
> +
> +#define ERROR_PRAM_CRCCHK			0x0000000
> +#define ERROR_YRAM_CRCCHK			0x0000001
> +#define	PPC_DRIVER_CRCCHK			0x00000200
> +
> +#define TAS2781_SA_COEFF_SWAP_REG		TASDEVICE_REG(0, 0x35, 0x2c)
> +#define TAS2781_YRAM_BOOK1			140
> +#define TAS2781_YRAM1_PAGE			42
> +#define TAS2781_YRAM1_START_REG			88
> +
> +#define TAS2781_YRAM2_START_PAGE		43
> +#define TAS2781_YRAM2_END_PAGE			49
> +#define TAS2781_YRAM2_START_REG			8
> +#define TAS2781_YRAM2_END_REG			127
> +
> +#define TAS2781_YRAM3_PAGE			50
> +#define TAS2781_YRAM3_START_REG			8
> +#define TAS2781_YRAM3_END_REG			27
> +
> +/*should not include B0_P53_R44-R47 */
> +#define TAS2781_YRAM_BOOK2			0
> +#define TAS2781_YRAM4_START_PAGE		50
> +#define TAS2781_YRAM4_END_PAGE			60
> +
> +#define TAS2781_YRAM5_PAGE			61
> +#define TAS2781_YRAM5_START_REG			8
> +#define TAS2781_YRAM5_END_REG			27
> +
> +#define TASDEVICE_MAXPROGRAM_NUM_KERNEL			5
> +#define TASDEVICE_MAXCONFIG_NUM_KERNEL_MULTIPLE_AMPS	64
> +#define TASDEVICE_MAXCONFIG_NUM_KERNEL			10
> +#define MAIN_ALL_DEVICES_1X				0x01
> +#define MAIN_DEVICE_A_1X				0x02
> +#define MAIN_DEVICE_B_1X				0x03
> +#define MAIN_DEVICE_C_1X				0x04
> +#define MAIN_DEVICE_D_1X				0x05
> +#define COEFF_DEVICE_A_1X				0x12
> +#define COEFF_DEVICE_B_1X				0x13
> +#define COEFF_DEVICE_C_1X				0x14
> +#define COEFF_DEVICE_D_1X				0x15
> +#define PRE_DEVICE_A_1X					0x22
> +#define PRE_DEVICE_B_1X					0x23
> +#define PRE_DEVICE_C_1X					0x24
> +#define PRE_DEVICE_D_1X					0x25
> +
> +struct tas_crc {
> +	unsigned char offset;
> +	unsigned char len;
> +};
> +
> +const char deviceNumber[TASDEVICE_DSP_TAS_MAX_DEVICE] = {
> +	1, 2, 1, 2, 1, 1, 0, 2, 4, 3, 1, 2, 3, 4
> +};
> +
> +static int fw_parse_block_data_kernel(struct tasdevice_fw *tas_fmw,
> +	struct tasdev_blk *block, const struct firmware *fmw, int offset)
> +{
> +	const unsigned char *data = fmw->data;
> +
> +	if (offset + 4 > fmw->size) {
> +		dev_err(tas_fmw->dev, "%s: File Size error\n", __func__);
> +		offset = -1;

-EINVAL instead of -1? same comment for all this patch.

> +		goto out;
> +	}
>
> +static int fw_parse_data_kernel(struct tasdevice_fw *tas_fmw,
> +	struct tasdevice_data *img_data, const struct firmware *fmw,
> +	int offset)
> +{
> +	const unsigned char *data = fmw->data;
> +	unsigned int nr_block;
> +
> +	if (offset + 4 > fmw->size) {
> +		dev_err(tas_fmw->dev, "%s: File Size error\n", __func__);
> +		offset = -1;
> +		goto out;
> +	}
> +	img_data->nr_blk = SMS_HTONL(data[offset],
> +		data[offset + 1], data[offset + 2], data[offset + 3]);
> +	offset  += 4;
> +
> +	img_data->dev_blks =
> +		kcalloc(img_data->nr_blk, sizeof(struct tasdev_blk),
> +			GFP_KERNEL);
> +	if (img_data->dev_blks == NULL) {
> +		dev_err(tas_fmw->dev, "%s: FW memory failed!\n", __func__);
> +		goto out;
> +	}
> +
> +	for (nr_block = 0; nr_block < img_data->nr_blk; nr_block++) {
> +		offset = fw_parse_block_data_kernel(tas_fmw,
> +			&(img_data->dev_blks[nr_block]), fmw, offset);

indentation looks very odd.

> +		if (offset < 0) {
> +			offset = -1;
> +			goto out;
> +		}
> +	}
> +out:
> +	return offset;
> +}
> +
> +static int fw_parse_program_data_kernel(
> +	struct tasdevice_priv *tas_dev, struct tasdevice_fw *tas_fmw,
> +	const struct firmware *fmw, int offset)
> +{
> +	struct tasdevice_prog *program;
> +	unsigned int  nr_program;

extra spaces?

> +

> +	if (fw_hdr->ndev != tas_dev->ndev) {
> +		dev_err(tas_dev->dev,
> +			"%s: ndev(%u) in dspbin dismatch ndev(%u) in DTS\n",
> +			__func__, fw_hdr->ndev, tas_dev->ndev);

mismatch?

> +		offset = -1;
> +		goto out;
> +	}
> +
> +	if (offset + 4 > fmw->size) {
> +		dev_err(tas_dev->dev, "%s: mnPrograms error\n", __func__);
> +		offset = -1;
> +		goto out;
> +	}
> +	tas_fmw->nr_programs = SMS_HTONL(buf[offset], buf[offset + 1],
> +		buf[offset + 2], buf[offset + 3]);
> +	offset  += 4;
> +
> +	if (tas_fmw->nr_programs == 0 || tas_fmw->nr_programs >
> +		TASDEVICE_MAXPROGRAM_NUM_KERNEL) {
> +		dev_err(tas_dev->dev, "%s: mnPrograms is invalid\n", __func__);
> +		offset = -1;
> +		goto out;
> +	}
> +
> +	if (offset + 4 * TASDEVICE_MAXPROGRAM_NUM_KERNEL > fmw->size) {
> +		dev_err(tas_dev->dev, "%s: mpPrograms error\n", __func__);
> +		offset = -1;
> +		goto out;
> +	}
> +
> +	tas_fmw->programs = kcalloc(tas_fmw->nr_programs,
> +		sizeof(struct tasdevice_prog), GFP_KERNEL);
> +	if (tas_fmw->programs == NULL) {

if (!tas_fmw->programs)

same comment for all other cases in this file.

> +		offset = -1;
> +		goto out;
> +	}
> +
> +	for (nr_program = 0; nr_program < tas_fmw->nr_programs; nr_program++) {
> +		program = &(tas_fmw->programs[nr_program]);
> +		program->prog_size = SMS_HTONL(buf[offset], buf[offset + 1],
> +			buf[offset + 2], buf[offset + 3]);
> +		offset  += 4;
> +	}
> +	offset  += (4 * (5 - nr_program));

this is odd, isn't nr_program == tas_fmw->nr_programs here? What's the
dependency on the previous loop?

> +
> +	if (offset + 4 > fmw->size) {
> +		dev_err(tas_dev->dev, "%s: Configurations error\n", __func__);
> +		offset = -1;
> +		goto out;
> +	}
> +	tas_fmw->nr_configurations = SMS_HTONL(buf[offset], buf[offset + 1],
> +		buf[offset + 2], buf[offset + 3]);
> +	offset  += 4;
> +	max_confs = (fw_hdr->ndev >= 4) ?
> +		TASDEVICE_MAXCONFIG_NUM_KERNEL_MULTIPLE_AMPS :
> +		TASDEVICE_MAXCONFIG_NUM_KERNEL;
> +	if (tas_fmw->nr_configurations == 0 ||
> +		tas_fmw->nr_configurations > max_confs) {
> +		dev_err(tas_dev->dev, "%s: Conf is invalid\n", __func__);
> +		offset = -1;
> +		goto out;
> +	}
> +
> +	if (offset + 4 * max_confs > fmw->size) {
> +		dev_err(tas_dev->dev, "%s: mpConfigurations err\n", __func__);
> +		offset = -1;
> +		goto out;
> +	}
> +
> +	tas_fmw->configs = kcalloc(tas_fmw->nr_configurations,
> +		sizeof(struct tasdevice_config), GFP_KERNEL);
> +	if (tas_fmw->configs == NULL) {
> +		offset = -1;
> +		goto out;
> +	}
> +
> +	for (nr_configs = 0; nr_configs < tas_fmw->nr_programs;
> +		nr_configs++) {
> +		config =
> +			&(tas_fmw->configs[nr_configs]);
> +		config->cfg_size = SMS_HTONL(buf[offset],
> +			buf[offset + 1], buf[offset + 2], buf[offset + 3]);
> +		offset  += 4;
> +	}
> +
> +	offset  += (4 * (max_confs - nr_configs));

same, it's very odd to use a loop iterator which is really a fixed value
here.

> +out:
> +	return offset;
> +}
> +
> +static int tasdevice_load_block_kernel(
> +	struct tasdevice_priv *tasdevice, struct tasdev_blk *block)
> +{
> +	unsigned char *data = block->data;
> +	unsigned int i, length;
> +	const unsigned int blk_size = block->blk_size;
> +	unsigned char dev_idx = 0;
> +	struct tasdevice_dspfw_hdr *fw_hdr = &(tasdevice->fmw->fw_hdr);
> +	struct tasdevice_fw_fixed_hdr *fw_fixed_hdr = &(fw_hdr->fixed_hdr);
> +
> +	if (fw_fixed_hdr->ppcver >= PPC3_VERSION) {
> +		switch (block->type) {
> +		case MAIN_ALL_DEVICES_1X:
> +			dev_idx = 0|0x80;
> +			break;
> +		case MAIN_DEVICE_A_1X:
> +			dev_idx = 1|0x80;
> +			break;
> +		case COEFF_DEVICE_A_1X:
> +		case PRE_DEVICE_A_1X:
> +			dev_idx = 1|0xC0;
> +			break;
> +		case MAIN_DEVICE_B_1X:
> +			dev_idx = 2|0x80;
> +			break;
> +		case COEFF_DEVICE_B_1X:
> +		case PRE_DEVICE_B_1X:
> +			dev_idx = 2|0xC0;
> +			break;
> +		case MAIN_DEVICE_C_1X:
> +			dev_idx = 3|0x80;
> +			break;
> +		case COEFF_DEVICE_C_1X:
> +		case PRE_DEVICE_C_1X:
> +			dev_idx = 3|0xC0;
> +			break;
> +		case MAIN_DEVICE_D_1X:
> +			dev_idx = 4|0x80;
> +			break;
> +		case COEFF_DEVICE_D_1X:
> +		case PRE_DEVICE_D_1X:
> +			dev_idx = 4|0xC0;
> +			break;
> +		default:
> +			dev_info(tasdevice->dev,
> +				"%s: load block: Other Type = 0x%02x\n",
> +				__func__, block->type);
> +			break;
> +		}
> +	} else {
> +		switch (block->type) {
> +		case MAIN_ALL_DEVICES:
> +			dev_idx = 0|0x80;
> +			break;
> +		case MAIN_DEVICE_A:
> +			dev_idx = 1|0x80;
> +			break;
> +		case COEFF_DEVICE_A:
> +		case PRE_DEVICE_A:
> +			dev_idx = 1|0xC0;
> +			break;
> +		case MAIN_DEVICE_B:
> +			dev_idx = 2|0x80;
> +			break;
> +		case COEFF_DEVICE_B:
> +		case PRE_DEVICE_B:
> +			dev_idx = 2|0xC0;
> +			break;
> +		case MAIN_DEVICE_C:
> +			dev_idx = 3|0x80;
> +			break;
> +		case COEFF_DEVICE_C:
> +		case PRE_DEVICE_C:
> +			dev_idx = 3|0xC0;
> +			break;
> +		case MAIN_DEVICE_D:
> +			dev_idx = 4|0x80;
> +			break;
> +		case COEFF_DEVICE_D:
> +		case PRE_DEVICE_D:
> +			dev_idx = 4|0xC0;

usually we have spaces around logical operators, e.g. 4 | 0xC0

But isn't 0xC4 simpler? This notation puts LSB first for no clear reason.


> +			break;
> +		default:
> +			dev_info(tasdevice->dev,
> +				"%s: load block: Other Type = 0x%02x\n",
> +				__func__, block->type);
> +			break;
> +		}
> +	}
> +
> +	for (i = 0, length = 0; i < block->nr_subblocks; i++) {
> +		int rc = tasdevice_process_block(tasdevice, data + length,
> +			dev_idx, blk_size - length);
> +		if (rc < 0) {
> +			dev_err(tasdevice->dev,
> +				"%s: ERROR:%u %u sublock write error\n",
> +				__func__, length, blk_size);
> +			break;
> +		}
> +		length  += (unsigned int)rc;
> +		if (blk_size < length) {
> +			dev_err(tasdevice->dev,
> +				"%s: ERROR:%u %u out of bounary\n",

typo: boundary

> +				__func__, length, blk_size);
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int fw_parse_variable_header_git(struct tasdevice_priv
> +	*tas_dev, const struct firmware *fmw, int offset)
> +{
> +	const unsigned char *buf = fmw->data;
> +	struct tasdevice_fw *tas_fmw = tas_dev->fmw;
> +	struct tasdevice_dspfw_hdr *fw_hdr = &(tas_fmw->fw_hdr);
> +	int len = strlen((char *)&buf[offset]);
> +
> +	len++;
> +
> +	if (offset + len > fmw->size) {
> +		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
> +		offset = -1;
> +		goto out;
> +	}
> +
> +	offset  += len;
> +
> +	if (offset + 4 > fmw->size) {
> +		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
> +		offset = -1;
> +		goto out;
> +	}
> +	fw_hdr->device_family = SMS_HTONL(buf[offset], buf[offset + 1],
> +		buf[offset + 2], buf[offset + 3]);
> +	if (fw_hdr->device_family != 0) {
> +		dev_err(tas_dev->dev, "ERROR:%s: not TAS device\n", __func__);

Why the ERROR here and not in other places?

> +		offset = -1;
> +		goto out;
> +	}
> +	offset  += 4;
> +	if (offset + 4 > fmw->size) {
> +		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
> +		offset = -1;
> +		goto out;
> +	}
> +	fw_hdr->device = SMS_HTONL(buf[offset], buf[offset + 1],
> +		buf[offset + 2], buf[offset + 3]);
> +	if (fw_hdr->device >= TASDEVICE_DSP_TAS_MAX_DEVICE ||
> +		fw_hdr->device == 6) {
> +		dev_err(tas_dev->dev, "Not support dev %d\n", fw_hdr->device);

Unsupported dev

> +		offset = -1;
> +		goto out;
> +	}
> +	offset  += 4;
> +	fw_hdr->ndev = deviceNumber[fw_hdr->device];
> +	if (fw_hdr->ndev != tas_dev->ndev) {
> +		dev_err(tas_dev->dev,
> +			"%s: ndev(%u) in dspbin dismatch ndev(%u) in DTS\n",

mistmatch - same in all the file.

> +			__func__, fw_hdr->ndev,
> +			tas_dev->ndev);
> +		offset = -1;
> +	}
> +
> +out:
> +	return offset;
> +}
> +
> +static int fw_parse_variable_hdr_cal(struct tasdevice_priv *tas_dev,
> +	struct tasdevice_fw *tas_fmw, const struct firmware *fmw, int offset)
> +{
> +	const unsigned char *buf = fmw->data;
> +	struct tasdevice_dspfw_hdr *fw_hdr = &(tas_fmw->fw_hdr);
> +	int len = strlen((char *)&buf[offset]);
> +
> +	len++;
> +
> +	if (offset + len > fmw->size) {
> +		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
> +		offset = -1;
> +		goto out;
> +	}
> +
> +	offset  += len;
> +
> +	if (offset + 4 > fmw->size) {
> +		dev_err(tas_dev->dev, "%s: mnDeviceFamily error\n", __func__);
> +		offset = -1;
> +		goto out;
> +	}
> +	fw_hdr->device_family = SMS_HTONL(buf[offset], buf[offset + 1],
> +		buf[offset + 2], buf[offset + 3]);
> +	if (fw_hdr->device_family != 0) {
> +		dev_err(tas_dev->dev, "ERROR:%s: not TAS device\n", __func__);

same ERROR

> +		offset = -1;
> +		goto out;
> +	}
> +	offset  += 4;
> +	if (offset + 4 > fmw->size) {
> +		dev_err(tas_dev->dev, "%s: mnDevice error\n", __func__);
> +		offset = -1;
> +		goto out;
> +	}
> +	fw_hdr->device = SMS_HTONL(buf[offset], buf[offset + 1],
> +		buf[offset + 2], buf[offset + 3]);
> +	if (fw_hdr->device >= TASDEVICE_DSP_TAS_MAX_DEVICE ||
> +		fw_hdr->device == 6) {
> +		dev_err(tas_dev->dev, "Not support dev %d\n", fw_hdr->device);

same, unsupported dev, fix this across the file.

> +		offset = -1;
> +		goto out;
> +	}
> +	offset  += 4;
> +	fw_hdr->ndev = deviceNumber[fw_hdr->device];
> +	if (fw_hdr->ndev != 1) {
> +		dev_err(tas_dev->dev,
> +			"%s: calbin must be 1, but currently ndev(%u)\n",
> +			__func__, fw_hdr->ndev);
> +		offset = -1;
> +	}
> +
> +out:
> +	return offset;
> +}

> +	block->data = kmemdup(&data[offset], n, GFP_KERNEL);
> +	if (block->data == NULL) {

if (!block->data)

> +		offset = -1;
> +		goto out;
> +	}
> +	offset  += n;
> +out:
> +	return offset;
> +}
> +
> +static int fw_parse_data(struct tasdevice_fw *tas_fmw,
> +	struct tasdevice_data *img_data, const struct firmware *fmw,
> +	int offset)
> +{
> +	const unsigned char *data = (unsigned char *)fmw->data;
> +	int n;

put this last for a nice reverse-xmas tree look.

> +	unsigned int nr_block;
> +
> +	if (offset + 64 > fmw->size) {
> +		dev_err(tas_fmw->dev, "%s: mpName error\n", __func__);
> +		n = -1;
> +		goto out;
> +	}
> +	memcpy(img_data->name, &data[offset], 64);
> +	offset  += 64;
> +
> +	n = strlen((char *)&data[offset]);
> +	n++;
> +	if (offset + n > fmw->size) {
> +		dev_err(tas_fmw->dev, "%s: mpDescription error\n", __func__);
> +		offset = -1;
> +		goto out;
> +	}
> +	offset  += n;
> +
> +	if (offset + 2 > fmw->size) {
> +		dev_err(tas_fmw->dev, "%s: mnBlocks error\n", __func__);
> +		offset = -1;
> +		goto out;
> +	}
> +	img_data->nr_blk = SMS_HTONS(data[offset], data[offset + 1]);
> +	offset  += 2;
> +
> +	img_data->dev_blks =
> +		kcalloc(img_data->nr_blk, sizeof(struct tasdev_blk),
> +			GFP_KERNEL);
> +	if (img_data->dev_blks == NULL) {

if (!img_data->dev_blks)

> +		dev_err(tas_fmw->dev, "%s: FW memory failed!\n", __func__);
> +		goto out;
> +	}
> +	for (nr_block = 0; nr_block < img_data->nr_blk; nr_block++) {
> +		offset = fw_parse_block_data(tas_fmw,
> +			&(img_data->dev_blks[nr_block]), fmw, offset);
> +		if (offset < 0) {
> +			offset = -1;
> +			goto out;
> +		}
> +	}
> +out:
> +	return offset;
> +}
> +
> +static int fw_parse_calibration_data(struct tasdevice_priv *tas_dev,
> +	struct tasdevice_fw *tas_fmw, const struct firmware *fmw, int offset)
> +{
> +	unsigned char *data = (unsigned char *)fmw->data;
> +	unsigned int n;
> +	unsigned int nr_calibration = 0;
> +	struct tasdevice_calibration *calibration;
> +
> +	if (offset + 2 > fmw->size) {
> +		dev_err(tas_dev->dev, "%s: mnCalibrations error\n", __func__);
> +		offset = -1;
> +		goto out;
> +	}
> +	tas_fmw->nr_calibrations = SMS_HTONS(data[offset], data[offset + 1]);
> +	offset  += 2;
> +
> +	if (tas_fmw->nr_calibrations != 1) {
> +		dev_err(tas_dev->dev,
> +			"%s: only support one calibraiton(%d)!\n",
> +			__func__, tas_fmw->nr_calibrations);
> +		goto out;
> +	}
> +
> +	tas_fmw->calibrations =
> +		kcalloc(tas_fmw->nr_calibrations,
> +			sizeof(struct tasdevice_calibration), GFP_KERNEL);
> +	if (tas_fmw->calibrations == NULL) {

if (!tas_fwm->calibrations)

> +		dev_err(tas_dev->dev, "pCalibrations mem failed!\n");

usually we don't have a log when the memory fails.

> +		offset = -1;

and we would have -ENOMEM here. That's another good reason to avoid the
blanket -1 which isn't really useful to debug the class of issues
encountered at run time.

>
> +static int fw_parse_program_data(struct tasdevice_priv *tas_dev,
> +	struct tasdevice_fw *tas_fmw, const struct firmware *fmw, int offset)
> +{
> +	struct tasdevice_prog *program;
> +	unsigned char *buf = (unsigned char *)fmw->data;
> +	int nr_program;
> +
> +	if (offset + 2 > fmw->size) {
> +		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
> +		offset = -1;
> +		goto out;
> +	}
> +	tas_fmw->nr_programs = SMS_HTONS(buf[offset], buf[offset + 1]);
> +	offset  += 2;
> +
> +	if (tas_fmw->nr_programs == 0) {
> +		/*Not error in calibration Data file, return directly*/

spaces in comments please

> +		dev_err(tas_dev->dev, "%s: Programs is null, maybe calbin\n",

not sure what that comment is supposed to mean.

> +			__func__);
> +		goto out;
> +	}
> +
> +	tas_fmw->programs =
> +		kcalloc(tas_fmw->nr_programs, sizeof(struct tasdevice_prog),
> +			GFP_KERNEL);
> +	if (tas_fmw->programs == NULL) {
if (!tas_fmw->program)

> +		offset = -1;

offset = -ENOMEM;

> +		goto out;
> +	}
> +	for (nr_program = 0; nr_program < tas_fmw->nr_programs; nr_program++) {
> +		int n = 0;
> +
> +		program = &(tas_fmw->programs[nr_program]);
> +		if (offset + 64 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: mpName error\n", __func__);
> +			offset = -1;
> +			goto out;
> +		}
> +		offset  += 64;
> +
> +		n = strlen((char *)&buf[offset]);
> +		n++;
> +		if (offset + n > fmw->size) {
> +			dev_err(tas_dev->dev, "Description err\n");
> +			offset = -1;
> +			goto out;
> +		}
> +
> +		offset  += n;
> +
> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: AppMode err\n", __func__);
> +			offset = -1;
> +			goto out;
> +		}
> +		offset++;
> +
> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_dev->dev, "PDMI2SMode err\n");
> +			offset = -1;
> +			goto out;
> +		}
> +		offset++;
> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: ISnsPD error\n", __func__);
> +			offset = -1;
> +			goto out;
> +		}
> +		offset++;
> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: VSnsPD error\n", __func__);
> +			offset = -1;
> +			goto out;
> +		}
> +		offset++;
> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: PowerLDG err\n", __func__);
> +			offset = -1;
> +			goto out;
> +		}
> +		offset++;
> +
> +		offset = fw_parse_data(tas_fmw, &(program->dev_data), fmw,
> +			offset);
> +		if (offset < 0)
> +			goto out;
> +	}
> +out:
> +	return offset;
> +}
> +
> +static int fw_parse_configuration_data(
> +	struct tasdevice_priv *tas_dev,
> +	struct tasdevice_fw *tas_fmw,
> +	const struct firmware *fmw, int offset)
> +{
> +	unsigned char *data = (unsigned char *)fmw->data;
> +	int n;

put this last.

> +	unsigned int n_configs;
> +	struct tasdevice_config *config;
> +
> +	if (offset + 2 > fmw->size) {
> +		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
> +		offset = -1;
> +		goto out;
> +	}
> +	tas_fmw->nr_configurations = SMS_HTONS(data[offset], data[offset + 1]);
> +	offset  += 2;
> +
> +	if (tas_fmw->nr_configurations == 0) {
> +		dev_err(tas_dev->dev, "%s: Conf is zero\n", __func__);
> +		//Do not "offset = -1;", because of calbin
> +		goto out;
> +	}
> +	tas_fmw->configs =
> +		kcalloc(tas_fmw->nr_configurations,
> +				sizeof(struct tasdevice_config), GFP_KERNEL);
> +
> +	for (n_configs = 0; n_configs < tas_fmw->nr_configurations;
> +		n_configs++) {
> +		config =
> +			&(tas_fmw->configs[n_configs]);
> +		if (offset + 64 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: File Size err\n", __func__);
> +			offset = -1;
> +			goto out;
> +		}
> +		memcpy(config->name, &data[offset], 64);
> +		offset  += 64;
> +
> +		n = strlen((char *)&data[offset]);
> +		n++;
> +		if (offset + n > fmw->size) {
> +			dev_err(tas_dev->dev, "Description err\n");
> +			offset = -1;
> +			goto out;
> +		}
> +
> +		offset  += n;
> +		if (offset + 2 > fmw->size) {
> +			dev_err(tas_dev->dev, "Device_orientation err\n");
> +			offset = -1;
> +			goto out;
> +		}
> +		offset  += 2;
> +
> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: Program err\n", __func__);
> +			offset = -1;
> +			goto out;
> +		}
> +		offset++;
> +
> +		if (offset + 4 > fmw->size) {
> +			dev_err(tas_dev->dev, "SampleRate err\n");
> +			offset = -1;
> +			goto out;
> +		}
> +		offset  += 4;
> +
> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: PLLSrc err\n", __func__);
> +			offset = -1;
> +			goto out;
> +		}
> +		offset++;
> +
> +		if (offset + 4 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: PLLRate err\n", __func__);
> +			offset = -1;
> +			goto out;
> +		}
> +		offset  += 4;
> +
> +		if (offset + 2 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: mnFsRate err\n", __func__);
> +			offset = -1;
> +			goto out;
> +		}
> +		offset  += 2;
> +
> +		offset = fw_parse_data(tas_fmw, &(config->dev_data),
> +			fmw, offset);
> +		if (offset < 0)
> +			goto out;
> +	}
> +out:
> +	return offset;
> +}

> +// Return Code:
> +// 1 -- the registers are in the inpage yram
> +// 0 -- the registers are NOT in the inpage yram

C comments please


> +// Return Code:
> +// 1 -- the registers are in the inblock yram
> +// 0 -- the registers are NOT in the inblock yram

C comments

> +static int check_inblock_yram(struct tas_crc *cd, unsigned char book,

this is a boolean - true/false would be easier to review

> +	unsigned char page, unsigned char reg, unsigned char len)
> +{
> +	int ret;
> +
> +	if (book == TAS2781_YRAM_BOOK1) {
> +		if (page < TAS2781_YRAM2_START_PAGE)
> +			ret = 0;
> +		else if (page <= TAS2781_YRAM2_END_PAGE) {
> +			if (reg > TAS2781_YRAM2_END_REG)
> +				ret = 0;
> +			else if (reg >= TAS2781_YRAM2_START_REG) {
> +				cd->offset = reg;
> +				cd->len = len;
> +				ret = 1;
> +			} else {
> +				if ((reg + (len-1)) <
> +					TAS2781_YRAM2_START_REG)
> +					ret = 0;
> +				else {
> +					cd->offset =
> +					TAS2781_YRAM2_START_REG;
> +					cd->len =
> +					reg + len - TAS2781_YRAM2_START_REG;
> +					ret = 1;
> +				}
> +			}
> +		} else
> +			ret = 0;
> +	} else if (book ==
> +		TAS2781_YRAM_BOOK2) {
> +		if (page < TAS2781_YRAM4_START_PAGE)
> +			ret = 0;
> +		else if (page <= TAS2781_YRAM4_END_PAGE) {
> +			if (reg > TAS2781_YRAM2_END_REG)
> +				ret = 0;
> +			else if (reg >= TAS2781_YRAM2_START_REG) {
> +				cd->offset = reg;
> +				cd->len = len;
> +				ret = 1;
> +			} else {
> +				if ((reg + (len-1))
> +					< TAS2781_YRAM2_START_REG)
> +					ret = 0;
> +				else {
> +					cd->offset =
> +					TAS2781_YRAM2_START_REG;
> +					cd->len =
> +					reg + len - TAS2781_YRAM2_START_REG;
> +					ret = 1;
> +				}
> +			}
> +		} else
> +			ret = 0;
> +	} else
> +		ret = 0;

You could initialize as false and only deal with the cases that are true...

> +
> +	return ret;
> +}
> +
> +static int check_yram(struct tas_crc *cd, unsigned char book,
> +	unsigned char page, unsigned char reg, unsigned char len)
> +{
> +	int ret;
> +
> +	ret = check_inpage_yram(cd, book, page, reg, len);
> +	if (ret == 0)
> +		ret = check_inblock_yram(cd, book,
> +				page, reg, len);
> +
> +	return ret;
> +}
> +
> +static int do_singlereg_checksum(struct tasdevice_priv *tasdevice,
> +	enum channel chl, unsigned char book, unsigned char page,
> +	unsigned char reg, unsigned char val)
> +{
> +	int ret;

put this last

> +	struct tas_crc crc_data;
> +	unsigned int nData1;
> +
> +	if ((book == TASDEVICE_BOOK_ID(TAS2781_SA_COEFF_SWAP_REG))
> +		&& (page == TASDEVICE_PAGE_ID(TAS2781_SA_COEFF_SWAP_REG))
> +		&& (reg >= TASDEVICE_PAGE_REG(TAS2781_SA_COEFF_SWAP_REG))
> +		&& (reg <= (TASDEVICE_PAGE_REG(
> +		TAS2781_SA_COEFF_SWAP_REG) + 4))) {
> +		/*DSP swap command, pass */
> +		ret = 0;
> +		goto end;
> +	}
> +
> +	ret = check_yram(&crc_data, book, page, reg, 1);
> +	if (ret == 1) {
> +		ret = tasdevice_dev_read(tasdevice, chl,
> +			TASDEVICE_REG(book, page, reg), &nData1);
> +		if (ret < 0)
> +			goto end;
> +
> +		if (nData1 != val) {
> +			dev_err(tasdevice->dev,
> +				"B[0x%x]P[0x%x]R[0x%x] W[0x%x], R[0x%x]\n",
> +				book, page, reg,
> +				val, nData1);
> +			ret = -EAGAIN;
> +			tasdevice->tasdevice[chl].err_code |=
> +				ERROR_YRAM_CRCCHK;
> +			ret = -EAGAIN;
> +			goto end;
> +		}
> +
> +		ret = crc8(tasdevice->crc8_lkp_tbl, &val, 1, 0);
> +	}
> +
> +end:
> +	return ret;
> +}
> +
> +static int do_multireg_checksum(struct tasdevice_priv *tasdevice,
> +	enum channel chn, unsigned char book, unsigned char page,
> +	unsigned char reg, unsigned int len)
> +{
> +	int ret, i;

move this last

> +	unsigned char crc_chksum = 0;
> +	unsigned char nBuf1[128];
> +	struct tas_crc crc_data;
> +
> +	if ((reg + len-1) > 127) {

spaces

Also this looks like a prime candidate for off-by-one errors.

> +		ret = -EINVAL;
> +		dev_err(tasdevice->dev, "firmware error\n");
> +		goto end;
> +	}
> +
> +	if ((book == TASDEVICE_BOOK_ID(TAS2781_SA_COEFF_SWAP_REG))
> +		&& (page == TASDEVICE_PAGE_ID(TAS2781_SA_COEFF_SWAP_REG))
> +		&& (reg == TASDEVICE_PAGE_REG(TAS2781_SA_COEFF_SWAP_REG))
> +		&& (len == 4)) {
> +		/*DSP swap command, pass */
> +		ret = 0;
> +		goto end;
> +	}
>
> +static int tasdevice_load_block(struct tasdevice_priv *tas_dev,
> +	struct tasdev_blk *block)
> +{
> +	int ret = 0;

put this last

> +	unsigned int nr_cmds;
> +	unsigned char book;
> +	unsigned char page;
> +	unsigned char offset;
> +	unsigned char val;
> +	unsigned int len;
> +	unsigned int sleep_dur;
> +	unsigned char crc_chksum = 0;
> +	unsigned int nr_value;
> +	int nr_retry = 6;
> +	unsigned char *data = block->data;
> +	int chn = 0, chnend = 0;
> +
> +	switch (block->type) {
> +	case MAIN_ALL_DEVICES:
> +		chn = 0;
> +		chnend = tas_dev->ndev;
> +		break;
> +	case MAIN_DEVICE_A:
> +	case COEFF_DEVICE_A:
> +	case PRE_DEVICE_A:
> +		chn = 0;
> +		chnend = 1;
> +		break;
> +	case MAIN_DEVICE_B:
> +	case COEFF_DEVICE_B:
> +	case PRE_DEVICE_B:
> +		chn = 1;
> +		chnend = 2;
> +		break;
> +	case MAIN_DEVICE_C:
> +	case COEFF_DEVICE_C:
> +	case PRE_DEVICE_C:
> +		chn = 2;
> +		chnend = 3;
> +		break;
> +	case MAIN_DEVICE_D:
> +	case COEFF_DEVICE_D:
> +	case PRE_DEVICE_D:
> +		chn = 3;
> +		chnend = 4;
> +		break;
> +	default:
> +		dev_dbg(tas_dev->dev, "load blk: Other Type = 0x%02x\n",
> +			block->type);
> +		break;
> +	}
> +
> +	for (; chn < chnend; chn++) {
> +		if (tas_dev->tasdevice[chn].is_loading == false)
> +			continue;
> +start:
> +		if (block->is_pchksum_present) {
> +			ret = tasdevice_dev_write(tas_dev, chn,
> +				TASDEVICE_I2CChecksum, 0);
> +			if (ret < 0)
> +				goto end;
> +		}
> +
> +		if (block->is_ychksum_present)
> +			crc_chksum = 0;
> +
> +		nr_cmds = 0;
> +
> +		while (nr_cmds < block->nr_cmds) {
> +			data = block->data + nr_cmds * 4;
> +
> +			book = data[0];
> +			page = data[1];
> +			offset = data[2];
> +			val = data[3];
> +
> +			nr_cmds++;
> +
> +			if (offset <= 0x7F) {
> +				ret = tasdevice_dev_write(tas_dev, chn,
> +					TASDEVICE_REG(book, page, offset),
> +					val);
> +				if (ret < 0)
> +					goto end;
> +				if (block->is_ychksum_present) {
> +					ret = do_singlereg_checksum(tas_dev,
> +						chn, book, page, offset,
> +						val);
> +					if (ret < 0)
> +						goto check;
> +					crc_chksum  += (unsigned char)ret;
> +				}
> +				continue;
> +			}
> +			if (offset == 0x81) {
> +				sleep_dur = (book << 8) + page;
> +				msleep(sleep_dur);

this is very odd, a sleep time that depends on a page?

A comment would be useful at the very least...

> +				continue;
> +			}
> +			if (offset == 0x85) {
> +				data  += 4;
> +				len = (book << 8) + page;
> +				book = data[0];
> +				page = data[1];
> +				offset = data[2];
> +				if (len > 1) {
> +					ret = tasdevice_dev_bulk_write(
> +						tas_dev, chn,
> +						TASDEVICE_REG(book, page,
> +						offset), data + 3, len);
> +					if (ret < 0)
> +						goto end;
> +					if (!block->is_ychksum_present)
> +						goto next;
> +					ret = do_multireg_checksum(
> +						tas_dev, chn, book,
> +						page, offset,
> +						len);
> +					if (ret < 0)
> +						goto check;
> +					crc_chksum +=
> +						(unsigned char)ret;
> +				} else {
> +					ret = tasdevice_dev_write(tas_dev,
> +						chn,
> +						TASDEVICE_REG(book, page,
> +						offset),
> +						data[3]);
> +					if (ret < 0)
> +						goto end;
> +					if (!block->is_ychksum_present)
> +						goto next;
> +					ret = do_singlereg_checksum(
> +						tas_dev, chn, book,
> +						page, offset,
> +						data[3]);
> +					if (ret < 0)
> +						goto check;
> +					crc_chksum +=
> +						(unsigned char)ret;
> +				}
> +next:
> +				nr_cmds++;
> +				if (len >= 2)
> +					nr_cmds += ((len - 2) / 4) + 1;
> +			}
> +		}
> +		if (block->is_pchksum_present) {
> +			ret = tasdevice_dev_read(tas_dev, chn,
> +				TASDEVICE_I2CChecksum, &nr_value);
> +			if (ret < 0) {
> +				dev_err(tas_dev->dev, "%s: Chn %d\n", __func__,
> +					chn);
> +				goto check;
> +			}
> +			if ((nr_value & 0xff) != block->pchksum) {
> +				dev_err(tas_dev->dev, "Blk PChkSum Chn %d ",
> +					chn);
> +				dev_err(tas_dev->dev,
> +					"FW = 0x%x, Reg = 0x%x\n",
> +					block->pchksum,
> +					(nr_value & 0xff));
> +				ret = -EAGAIN;
> +				tas_dev->tasdevice[chn].err_code |=
> +					ERROR_PRAM_CRCCHK;
> +				goto check;
> +			}
> +			ret = 0;
> +			tas_dev->tasdevice[chn].err_code &=
> +				~ERROR_PRAM_CRCCHK;
> +		}
> +
> +		if (block->is_ychksum_present) {
> +			//TBD, open it when FW ready
> +			dev_err(tas_dev->dev,
> +				"Block YChkSum: FW = 0x%x, YCRC = 0x%x\n",
> +				block->ychksum, crc_chksum);
> +
> +			tas_dev->tasdevice[chn].err_code &=
> +				~ERROR_YRAM_CRCCHK;
> +			ret = 0;
> +		}
> +check:
> +		if (ret == -EAGAIN) {
> +			nr_retry--;
> +			if (nr_retry > 0)
> +				goto start;
> +			else {
> +				if ((block->type == MAIN_ALL_DEVICES)
> +					|| (block->type == MAIN_DEVICE_A)
> +					|| (block->type == MAIN_DEVICE_B)
> +					|| (block->type == MAIN_DEVICE_C)
> +					|| (block->type == MAIN_DEVICE_D))
> +					tas_dev->tasdevice[chn].cur_prog = -1;
> +				else
> +					tas_dev->tasdevice[chn].cur_conf = -1;
> +				nr_retry = 6;
> +			}
> +		}
> +	}
> +end:
> +	if (ret < 0)
> +		dev_err(tas_dev->dev, "Block (%d) load error\n", block->type);
> +
> +	return ret;
> +}
> +
> +
> +static int tasdevice_load_data(struct tasdevice_priv *tas_dev,
> +	struct tasdevice_data *dev_data)
> +{
> +	int ret = 0;
> +	unsigned int nr_block;
> +	struct tasdev_blk *block;

invert the declarations

struct tasdev_blk *block;
unsigned int nr_block;
int ret = 0;

is what it typical in kernel code.

Same comment for the rest of the code.

> +
> +	for (nr_block = 0; nr_block < dev_data->nr_blk; nr_block++) {
> +		block = &(dev_data->dev_blks[nr_block]);
> +		ret = tas_dev->tasdevice_load_block(tas_dev, block);
> +		if (ret < 0)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int tasdevice_load_calibrated_data(
> +	struct tasdevice_priv *tas_dev, struct tasdevice_data *dev_data)
> +{
> +	int ret = 0;
> +	unsigned int nr_block;
> +	struct tasdev_blk *block;
> +
> +	for (nr_block = 0; nr_block < dev_data->nr_blk; nr_block++) {
> +		block = &(dev_data->dev_blks[nr_block]);
> +		ret = tasdevice_load_block(tas_dev, block);
> +		if (ret < 0)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +int tas2781_load_calibration(void *context,
> +			char *file_name, enum channel i)
> +{
> +	int ret, offset = 0;
> +	struct firmware fmw;
> +	const struct firmware *fw_entry;
> +	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *)context;
> +	struct tasdevice *tasdev = &(tas_dev->tasdevice[i]);
> +	struct tasdevice_fw *tas_fmw;
> +
> +	ret = request_firmware(&fw_entry, file_name, tas_dev->dev);
> +	if (!ret) {
> +		if (!fw_entry->size) {
> +			dev_err(tas_dev->dev,
> +				"%s: file read error: size = %lu\n",
> +				__func__, (unsigned long)fw_entry->size);
> +			goto out;
> +		}
> +		fmw.size = fw_entry->size;
> +		fmw.data = fw_entry->data;
> +	} else {
> +		dev_info(tas_dev->dev,
> +			"%s: Request firmware %s failed\n",
> +			__func__, file_name);
> +		goto out;
> +	}
> +
> +	tas_fmw = tasdev->cali_data_fmw = kcalloc(1,
> +		sizeof(struct tasdevice_fw), GFP_KERNEL);
> +	if (tasdev->cali_data_fmw == NULL) {
> +		dev_err(tas_dev->dev, "%s: FW memory failed!\n", __func__);
> +		ret = -1;
> +		goto out;
> +	}
> +	tas_fmw->dev = tas_dev->dev;
> +	offset = fw_parse_header(tas_dev, tas_fmw, &fmw, offset);
> +	if (offset == -1) {
> +		dev_err(tas_dev->dev, "%s: fw_parse_header EXIT!\n", __func__);
> +		goto out;
> +	}
> +	offset = fw_parse_variable_hdr_cal(tas_dev, tas_fmw, &fmw, offset);
> +	if (offset == -1) {
> +		dev_err(tas_dev->dev,
> +			"%s: fw_parse_variable_header_cal EXIT!\n", __func__);
> +		goto out;
> +	}
> +	offset = fw_parse_program_data(tas_dev, tas_fmw, &fmw, offset);
> +	if (offset == -1) {
> +		dev_err(tas_dev->dev, "fw_parse_program_data EXIT!\n");
> +		goto out;
> +	}
> +	offset = fw_parse_configuration_data(tas_dev, tas_fmw, &fmw,
> +		offset);
> +	if (offset == -1) {
> +		dev_err(tas_dev->dev, "fw_parse_configuration_data EXIT!\n");
> +		goto out;
> +	}
> +	offset = fw_parse_calibration_data(tas_dev,
> +		tas_fmw, &fmw, offset);
> +	if (offset == -1) {
> +		dev_err(tas_dev->dev, "fw_parse_calibration_data EXIT!\n");
> +		goto out;
> +	}
> +	tasdev->is_calibrated_data_loaded = true;
> +out:
> +	if (fw_entry) {
> +		release_firmware(fw_entry);
> +		fw_entry = NULL;
> +	}
> +	return ret;
> +}
> +
> +int tasdevice_dspfw_ready(const struct firmware *fmw, void *context)
> +{
> +	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) context;
> +	struct tasdevice_fw *tas_fmw;
> +	struct tasdevice_fw_fixed_hdr *fw_fixed_hdr;
> +	int offset = 0, ret = 0;
> +
> +	if (!fmw || !fmw->data) {
> +		dev_err(tas_dev->dev, "%s: Failed to read firmware %s\n",
> +			__func__, tas_dev->coef_binaryname);
> +		ret = -1;
> +		goto out;
> +	}
> +
> +	tas_dev->fmw = kcalloc(1,
> +		sizeof(struct tasdevice_fw), GFP_KERNEL);
> +	if (tas_dev->fmw == NULL) {
> +		ret = -1;
> +		goto out;
> +	}
> +	tas_fmw = tas_dev->fmw;
> +	tas_fmw->dev = tas_dev->dev;
> +	offset = fw_parse_header(tas_dev, tas_fmw, fmw, offset);
> +
> +	if (offset == -1)
> +		goto out;
> +	fw_fixed_hdr = &(tas_fmw->fw_hdr.fixed_hdr);
> +	switch (fw_fixed_hdr->drv_ver) {
> +	case 0x301:
> +	case 0x302:
> +	case 0x502:
> +		tas_dev->fw_parse_variable_header =
> +			fw_parse_variable_header_kernel;
> +		tas_dev->fw_parse_program_data =
> +			fw_parse_program_data_kernel;
> +		tas_dev->fw_parse_configuration_data =
> +			fw_parse_configuration_data_kernel;
> +		tas_dev->tasdevice_load_block =
> +			tasdevice_load_block_kernel;
> +		break;
> +	case 0x202:
> +	case 0x400:
> +		tas_dev->fw_parse_variable_header =
> +			fw_parse_variable_header_git;
> +		tas_dev->fw_parse_program_data =
> +			fw_parse_program_data;
> +		tas_dev->fw_parse_configuration_data =
> +			fw_parse_configuration_data;
> +		tas_dev->tasdevice_load_block =
> +			tasdevice_load_block;
> +		break;
> +	default:
> +	if (fw_fixed_hdr->drv_ver == 0x100) {
> +		if (fw_fixed_hdr->ppcver >= PPC3_VERSION) {
> +			tas_dev->fw_parse_variable_header =
> +				fw_parse_variable_header_kernel;
> +			tas_dev->fw_parse_program_data =
> +				fw_parse_program_data_kernel;
> +			tas_dev->fw_parse_configuration_data =
> +				fw_parse_configuration_data_kernel;
> +			tas_dev->tasdevice_load_block =
> +				tasdevice_load_block_kernel;
> +			tas_dev->fw_parse_calibration_data = NULL;
> +		} else {
> +			switch (fw_fixed_hdr->ppcver) {
> +			case 0x00:
> +				tas_dev->fw_parse_variable_header =
> +					fw_parse_variable_header_git;
> +				tas_dev->fw_parse_program_data =
> +					fw_parse_program_data;
> +				tas_dev->fw_parse_configuration_data =
> +					fw_parse_configuration_data;
> +				tas_dev->fw_parse_calibration_data =
> +					fw_parse_calibration_data;
> +				tas_dev->tasdevice_load_block =
> +					tasdevice_load_block;
> +				break;
> +			default:
> +				dev_err(tas_dev->dev,
> +					"%s: PPCVersion must be 0x0 or 0x%02x",
> +					__func__, PPC3_VERSION);
> +				dev_err(tas_dev->dev, " Current:0x%02x\n",
> +					fw_fixed_hdr->ppcver);
> +				offset = -1;
> +				break;
> +			}
> +		}
> +	} else {
> +		dev_err(tas_dev->dev,
> +			"DriverVersion must be 0x0, 0x230 or above 0x230 ");
> +		dev_err(tas_dev->dev, "current is 0x%02x\n",
> +			fw_fixed_hdr->drv_ver);
> +		offset = -1;
> +	}
> +		break;
> +	}
> +
> +	offset = tas_dev->fw_parse_variable_header(tas_dev, fmw, offset);
> +	if (offset == -1)
> +		goto out;
> +
> +	offset = tas_dev->fw_parse_program_data(tas_dev, tas_fmw, fmw,
> +		offset);
> +	if (offset < 0) {
> +		ret = -1;
> +		goto out;
> +	}
> +	offset = tas_dev->fw_parse_configuration_data(tas_dev,
> +		tas_fmw, fmw, offset);
> +	if (offset < 0)
> +		ret = -1;
> +
> +out:
> +	return ret;
> +}
> +
> +void tasdevice_calbin_remove(void *context)
> +{
> +	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) context;
> +	struct tasdevice *tasdev;
> +	int i;
> +
> +	if (tas_dev) {
> +		for (i = 0; i < tas_dev->ndev; i++) {
> +			tasdev = &(tas_dev->tasdevice[i]);
> +			if (tasdev->cali_data_fmw) {
> +				tas2781_clear_calfirmware(
> +					tasdev->cali_data_fmw);
> +				tasdev->cali_data_fmw = NULL;
> +			}
> +		}
> +	}
> +}
> +
> +static void tasdev_dsp_prog_blk_remove(struct tasdevice_prog *prog)
> +{
> +	struct tasdevice_data *im;
> +	unsigned int nr_blk;
> +	struct tasdev_blk *blk;
> +
> +	if (prog) {
> +		im = &(prog->dev_data);
> +
> +		if (!im->dev_blks)
> +			return;
> +
> +		for (nr_blk = 0; nr_blk < im->nr_blk; nr_blk++) {
> +			blk = &(im->dev_blks[nr_blk]);
> +			kfree(blk->data);
> +		}
> +		kfree(im->dev_blks);
> +	}
> +}
> +
> +static void tasdev_dsp_prog_remove(struct tasdevice_prog *prog,
> +	unsigned short nr)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr; i++)
> +		tasdev_dsp_prog_blk_remove(&prog[i]);
> +	kfree(prog);
> +}
> +
> +static void tasdev_dsp_cfg_blk_remove(struct tasdevice_config *cfg)
> +{
> +	struct tasdevice_data *im;
> +	unsigned int nr_blk;
> +	struct tasdev_blk *blk;
> +
> +	if (cfg) {
> +		im = &(cfg->dev_data);
> +
> +		if (!im->dev_blks)
> +			return;
> +
> +		for (nr_blk = 0; nr_blk < im->nr_blk; nr_blk++) {
> +			blk = &(im->dev_blks[nr_blk]);
> +			kfree(blk->data);
> +		}
> +		kfree(im->dev_blks);
> +	}
> +}
> +
> +static void tasdev_dsp_cfg_remove(struct tasdevice_config *config,
> +	unsigned short nr)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr; i++)
> +		tasdev_dsp_cfg_blk_remove(&config[i]);
> +	kfree(config);
> +}
> +
> +void tasdevice_dsp_remove(void *context)
> +{
> +	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) context;
> +
> +	if (tas_dev->fmw) {
> +		struct tasdevice_fw *tas_fmw = tas_dev->fmw;
> +
> +		if (tas_fmw->programs)
> +			tasdev_dsp_prog_remove(tas_fmw->programs,
> +				tas_fmw->nr_programs);
> +		if (tas_fmw->configs)
> +			tasdev_dsp_cfg_remove(tas_fmw->configs,
> +				tas_fmw->nr_configurations);
> +		kfree(tas_fmw);
> +		tas_dev->fmw = NULL;
> +	}
> +}
> +
> +static int tas2781_set_calibration(void *context, enum channel i,
> +	int n_calibration)
> +{
> +	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) context;
> +	int ret = 0;

move this last

> +	struct tasdevice *tasdevice = &(tas_dev->tasdevice[i]);
> +	struct tasdevice_fw *cal_fmw = tasdevice->cali_data_fmw;
> +
> +	if ((!tas_dev->fmw->programs) || (!tas_dev->fmw->configs)) {
> +		dev_err(tas_dev->dev, "%s, Firmware not loaded\n\r", __func__);
> +		ret = 0;
> +		goto out;
> +	}
> +
> +	if (n_calibration == 0xFF || (n_calibration == 0x100
> +		&& tasdevice->is_calibrated_data_loaded == false)) {
> +		if (cal_fmw) {
> +			tasdevice->is_calibrated_data_loaded = false;
> +			tas2781_clear_calfirmware(cal_fmw);
> +			cal_fmw = NULL;
> +		}
> +
> +		scnprintf(tas_dev->cal_binaryname[i], 64, "%s_cal_0x%02x.bin",
> +			tas_dev->dev_name, tas_dev->tasdevice[i].dev_addr);
> +		ret = tas2781_load_calibration(tas_dev,
> +			tas_dev->cal_binaryname[i], i);
> +		if (ret != 0) {
> +			dev_err(tas_dev->dev,
> +				"%s: load %s error, no-side effect\n",
> +				__func__, tas_dev->cal_binaryname[i]);
> +			ret = 0;
> +		}
> +	}
> +	tasdevice->is_loading = true;
> +	tasdevice->is_loaderr = false;
> +
> +	if (cal_fmw) {
> +		struct tasdevice_calibration *calibration =
> +			cal_fmw->calibrations;
> +
> +		if (calibration)
> +			tasdevice_load_calibrated_data(tas_dev,
> +				&(calibration->dev_data));
> +	} else
> +		dev_err(tas_dev->dev, "%s: No calibrated data for dev %d\n",
> +			__func__, i);
> +
> +out:
> +	return ret;
> +}
> +
> +int tasdevice_select_tuningprm_cfg(void *context, int prm_no,
> +	int cfg_no, int rca_conf_no)
> +{
> +	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) context;
> +	struct tasdevice_rca *rca = &(tas_dev->rcabin);
> +	struct tasdevice_config_info **cfg_info = rca->cfg_info;
> +	struct tasdevice_fw *tas_fmw = tas_dev->fmw;
> +	struct tasdevice_config *conf;
> +	struct tasdevice_prog *program;
> +	int i;

move last

> +	int status;
> +	int prog_status;
> +
> +	if (!tas_fmw) {
> +		dev_err(tas_dev->dev, "%s: Firmware is NULL\n", __func__);
> +		goto out;
> +	}
> +
> +	if (cfg_no >= tas_fmw->nr_configurations) {
> +		dev_err(tas_dev->dev,
> +			"%s: cfg(%d) is not in range of conf %u\n",
> +			__func__, cfg_no, tas_fmw->nr_configurations);
> +		goto out;
> +	}
> +
> +	if (prm_no >= tas_fmw->nr_programs) {
> +		dev_err(tas_dev->dev,
> +			"%s: prm(%d) is not in range of Programs %u\n",
> +			__func__,  prm_no, tas_fmw->nr_programs);
> +		goto out;
> +	}
> +
> +	if (rca_conf_no > rca->ncfgs || rca_conf_no <= 0 ||
> +		cfg_info == NULL) {
> +		dev_err(tas_dev->dev,
> +			"conf_no:%d should be in range from 0 to %u\n",
> +			rca_conf_no, rca->ncfgs-1);
> +		goto out;
> +	}
> +
> +	conf = &(tas_fmw->configs[cfg_no]);
> +	for (i = 0, prog_status = 0; i < tas_dev->ndev; i++) {
> +		if (cfg_info[rca_conf_no]->active_dev & (1 << i)) {
> +			if (tas_dev->tasdevice[i].cur_prog != prm_no) {
> +				tas_dev->tasdevice[i].cur_conf = -1;
> +				tas_dev->tasdevice[i].is_loading = true;
> +				prog_status++;
> +			}
> +		} else
> +			tas_dev->tasdevice[i].is_loading = false;
> +		tas_dev->tasdevice[i].is_loaderr = false;
> +	}
> +
> +	if (prog_status) {
> +		program = &(tas_fmw->programs[prm_no]);
> +		tasdevice_load_data(tas_dev, &(program->dev_data));
> +		for (i = 0; i < tas_dev->ndev; i++) {
> +			if (tas_dev->tasdevice[i].is_loaderr == true)
> +				continue;
> +			else if (tas_dev->tasdevice[i].is_loaderr == false
> +				&& tas_dev->tasdevice[i].is_loading == true) {
> +				struct tasdevice_fw *cal_fmw =
> +					tas_dev->tasdevice[i].cali_data_fmw;
> +
> +				if (cal_fmw) {
> +					struct tasdevice_calibration
> +						*calibration =
> +							cal_fmw->calibrations;
> +
> +					if (calibration)
> +						tasdevice_load_calibrated_data(
> +						tas_dev,
> +						&(calibration->dev_data));
> +				}
> +				tas_dev->tasdevice[i].cur_prog = prm_no;
> +			}
> +		}
> +	}
> +
> +	if (tas_dev->is_glb_calibrated_data_loaded == false) {
> +		for (i = 0; i < tas_dev->ndev; i++)
> +			tas2781_set_calibration(tas_dev, i, 0x100);
> +		tas_dev->is_glb_calibrated_data_loaded = true;
> +		/* Unwise to reload calibrationdata everytime,
> +		 * this code will work once even if calibrated
> +		 * data still failed to be got
> +		 */
> +	}
> +
> +	for (i = 0, status = 0; i < tas_dev->ndev; i++) {
> +		if (tas_dev->tasdevice[i].cur_conf != cfg_no
> +			&& (cfg_info[rca_conf_no]->active_dev & (1 << i))
> +			&& (tas_dev->tasdevice[i].is_loaderr == false)) {
> +			status++;
> +			tas_dev->tasdevice[i].is_loading = true;
> +		} else
> +			tas_dev->tasdevice[i].is_loading = false;
> +	}
> +
> +	if (status) {
> +		status = 0;
> +		tasdevice_load_data(tas_dev, &(conf->dev_data));
> +		for (i = 0; i < tas_dev->ndev; i++) {
> +			if (tas_dev->tasdevice[i].is_loaderr == true) {
> +				status |= 1 << (i + 4);
> +				continue;
> +			} else if (tas_dev->tasdevice[i].is_loaderr == false
> +				&& tas_dev->tasdevice[i].is_loading == true)
> +				tas_dev->tasdevice[i].cur_conf = cfg_no;
> +		}
> +	} else
> +		dev_err(tas_dev->dev,
> +			"%s: No device is in active in conf %d\n",
> +			__func__, rca_conf_no);
> +
> +	status |= cfg_info[rca_conf_no]->active_dev;
> +out:
> +	return prog_status;

> +			usleep_range(delay_time*1000, delay_time*1000);

A range is an interval between different values...

> +			subblk_offset  += 2;
> +		}
> +			break;
> +		case TASDEVICE_CMD_FIELD_W:
> +			if (subblk_offset + 6 > sublocksize) {
> +				dev_err(tas_dev->dev,
> +					"%s: bit write Out of bounary\n",
> +					__func__);
> +				is_err = true;
> +				break;
> +			}
> +			rc = tasdevice_dev_update_bits(tas_dev, chn,
> +				TASDEVICE_REG(data[subblk_offset + 2],
> +					data[subblk_offset + 3],
> +					data[subblk_offset + 4]),
> +					data[subblk_offset + 1],
> +					data[subblk_offset + 5]);
> +			if (rc < 0) {
> +				is_err = true;
> +				dev_err(tas_dev->dev,
> +					"%s: update_bits error = %d\n",
> +					__func__, rc);
> +			}
> +			subblk_offset  += 6;
> +			break;
> +		default:
> +			break;
> +		};
> +		if (is_err == true && blktyp != 0) {
> +			if (blktyp == 0x80) {
> +				tas_dev->tasdevice[chn].cur_prog = -1;
> +				tas_dev->tasdevice[chn].cur_conf = -1;
> +			} else
> +				tas_dev->tasdevice[chn].cur_conf = -1;
> +		}
> +	}
> +	return subblk_offset;
> +}
> +
> +static void tasdevice_select_cfg_blk(void *pContext, int conf_no,
> +	unsigned char block_type)
> +{
> +	struct tasdevice_priv *tas_dev =
> +		(struct tasdevice_priv *) pContext;
> +	struct tasdevice_rca *rca = &(tas_dev->rcabin);
> +	struct tasdevice_config_info **cfg_info = rca->cfg_info;
> +	int j, k, chn, chnend;
> +
> +	if (conf_no >= rca->ncfgs || conf_no < 0 || NULL == cfg_info) {
> +		dev_err(tas_dev->dev,
> +			"conf_no should be not more than %u\n",
> +			rca->ncfgs);
> +		goto out;
> +	}
> +
> +	for (j = 0; j < (int)cfg_info[conf_no]->real_nblocks; j++) {
> +		unsigned int length = 0, rc = 0;
> +
> +		if (block_type > 5 || block_type < 2) {
> +			dev_err(tas_dev->dev,
> +			"ERROR!!!block_type should be in range from 2 to 5\n");
> +			goto out;
> +		}
> +		if (block_type != cfg_info[conf_no]->blk_data[j]->block_type)
> +			continue;
> +
> +		for (k = 0; k < (int)cfg_info[conf_no]->blk_data[j]->n_subblks;
> +			k++) {
> +			if (cfg_info[conf_no]->blk_data[j]->dev_idx) {
> +				chn =
> +				cfg_info[conf_no]->blk_data[j]->dev_idx
> +				- 1;
> +				chnend =
> +				cfg_info[conf_no]->blk_data[j]->dev_idx;
> +			} else {
> +				chn = 0;
> +				chnend = tas_dev->ndev;
> +			}
> +			for (; chn < chnend; chn++)
> +				tas_dev->tasdevice[chn].is_loading = true;
> +
> +			rc = tasdevice_process_block(tas_dev,
> +				cfg_info[conf_no]->blk_data[j]->regdata +
> +					length,
> +				cfg_info[conf_no]->blk_data[j]->dev_idx,
> +				cfg_info[conf_no]->blk_data[j]->block_size -
> +					length);
> +			length  += rc;
> +			if (cfg_info[conf_no]->blk_data[j]->block_size <
> +				length) {
> +				dev_err(tas_dev->dev,
> +					"%s: ERROR:%u %u out of bounary\n",
> +					__func__, length,
> +					cfg_info[conf_no]->blk_data[j]
> +					->block_size);
> +				break;
> +			}
> +		}
> +		if (length != cfg_info[conf_no]->blk_data[j]->block_size)
> +			dev_err(tas_dev->dev,
> +				"%s: %u %u size is not same\n",
> +				__func__, length,
> +				cfg_info[conf_no]->blk_data[j]->block_size);
> +
> +	}
> +
> +out:
> +	return;
> +}
> +
> +static struct tasdevice_config_info *tasdevice_add_config(
> +	void *context, unsigned char *config_data,
> +	unsigned int config_size)
> +{
> +	struct tasdevice_priv *tas_dev =
> +		(struct tasdevice_priv *)context;
> +	struct tasdevice_config_info *cfg_info = NULL;

useless init

> +	int config_offset = 0, i;
> +
> +	cfg_info = kzalloc(
> +		sizeof(struct tasdevice_config_info), GFP_KERNEL);
> +	if (!cfg_info)
> +		goto out;
> +
> +	if (tas_dev->rcabin.fw_hdr.binary_version_num >= 0x105) {
> +		if (config_offset + 64 > (int)config_size) {
> +			dev_err(tas_dev->dev, "add config: Out of bounary\n");
> +			goto out;
> +		}
> +		config_offset  += 64;
> +	}
> +
> +	if (config_offset + 4 > (int)config_size) {
> +		dev_err(tas_dev->dev, "add config: Out of bounary\n");
> +		goto out;
> +	}
> +	cfg_info->nblocks =
> +		SMS_HTONL(config_data[config_offset],
> +		config_data[config_offset + 1],
> +	config_data[config_offset + 2], config_data[config_offset + 3]);
> +	config_offset  +=  4;
> +
> +	cfg_info->blk_data = kcalloc(
> +		cfg_info->nblocks, sizeof(struct tasdev_blk_data *),
> +		GFP_KERNEL);
> +	if (!cfg_info->blk_data)
> +		goto out;
> +
> +	cfg_info->real_nblocks = 0;
> +	for (i = 0; i < (int)cfg_info->nblocks; i++) {
> +		if (config_offset + 12 > config_size) {
> +			dev_err(tas_dev->dev,
> +			"add config: Out of bounary: i = %d nblocks = %u!\n",
> +			i, cfg_info->nblocks);
> +			break;
> +		}
> +		cfg_info->blk_data[i] = kzalloc(
> +			sizeof(struct tasdev_blk_data), GFP_KERNEL);
> +		if (!cfg_info->blk_data[i])
> +			break;
> +
> +		cfg_info->blk_data[i]->dev_idx = config_data[config_offset];
> +		config_offset++;
> +
> +		cfg_info->blk_data[i]->block_type = config_data[config_offset];
> +		config_offset++;
> +
> +		if (cfg_info->blk_data[i]->block_type  ==
> +			TASDEVICE_BIN_BLK_PRE_POWER_UP) {
> +			if (cfg_info->blk_data[i]->dev_idx == 0)
> +				cfg_info->active_dev = 1;
> +			else
> +				cfg_info->active_dev =
> +					1 <<
> +					(cfg_info->blk_data[i]->dev_idx - 1);
> +
> +		}
> +		cfg_info->blk_data[i]->yram_checksum =
> +			SMS_HTONS(config_data[config_offset],
> +			config_data[config_offset + 1]);
> +		config_offset  += 2;
> +		cfg_info->blk_data[i]->block_size =
> +			SMS_HTONL(config_data[config_offset],
> +			config_data[config_offset + 1],
> +			config_data[config_offset + 2],
> +		config_data[config_offset + 3]);
> +		config_offset  += 4;
> +
> +		cfg_info->blk_data[i]->n_subblks =
> +			SMS_HTONL(config_data[config_offset],
> +			config_data[config_offset + 1],
> +			config_data[config_offset + 2],
> +		config_data[config_offset + 3]);
> +
> +		config_offset  += 4;
> +		cfg_info->blk_data[i]->regdata = kzalloc(
> +			cfg_info->blk_data[i]->block_size, GFP_KERNEL);
> +		if (cfg_info->blk_data[i]->regdata == NULL)
> +			goto out;
> +
> +		if (config_offset + cfg_info->blk_data[i]->block_size
> +			> config_size) {
> +			dev_err(tas_dev->dev,
> +			"%s: block_size Out of bounary: i = %d blks = %u!\n",
> +			__func__, i, cfg_info->nblocks);
> +			break;
> +		}
> +		memcpy(cfg_info->blk_data[i]->regdata,
> +			&config_data[config_offset],
> +		cfg_info->blk_data[i]->block_size);
> +		config_offset  += cfg_info->blk_data[i]->block_size;
> +		cfg_info->real_nblocks  += 1;
> +	}
> +out:
> +	return cfg_info;
> +}
> +
> +/* tas2781 contain book and page two-level regmap, especially book switching
> + * will set the register BXXP00R7F, after switching to the correct book,
> + * then leverage the mechanism for paging to access the register. Custom
> + * control is primarily for regmap booking, paging depends on internal
> + * regmap mechanism
> + */
> +static int tas2781_digital_getvol(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec
> +		= snd_soc_kcontrol_component(kcontrol);
> +	struct tasdevice_priv *tas_dev =
> +		snd_soc_component_get_drvdata(codec);
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	int val;

put this last

> +	unsigned int invert = mc->invert;
> +	int max = mc->max;
> +	int ret = 0;
> +
> +	/* Read the primary device as the whole */
> +	ret = tasdevice_dev_read(tas_dev, 0, mc->reg, &val);
> +	if (ret) {
> +		dev_err(tas_dev->dev, "%s, get digital vol error\n", __func__);
> +		goto out;
> +	}
> +
> +	if (val > max)
> +		val = max;
> +	if (invert)
> +		val = max - val;
> +	if (val < 0)
> +		val = 0;
> +	ucontrol->value.integer.value[0] = val;
> +
> +out:
> +	return ret;
> +}
> +
> +static int tas2781_digital_putvol(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec
> +		= snd_soc_kcontrol_component(kcontrol);
> +	struct tasdevice_priv *tas_dev =
> +		snd_soc_component_get_drvdata(codec);
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	int val, i;
> +	unsigned int invert = mc->invert;
> +	int max = mc->max;
> +	int err_cnt = 0;
> +	int ret = 1;
> +
> +	val = ucontrol->value.integer.value[0];
> +	if (val > max)
> +		val = max;
> +	if (invert)
> +		val = max - val;
> +	if (val < 0)
> +		val = 0;
> +
> +	if (!tas_dev->set_global_mode) {
> +		ret = tasdevice_dev_write(tas_dev, tas_dev->ndev,
> +			mc->reg, (unsigned int)val);
> +		if (ret)
> +			dev_err(tas_dev->dev, "%s, error in global mode\n",
> +				__func__);
> +	}
> +
> +	if (tas_dev->set_global_mode == NULL || ret == 1) {
> +		for (i = 0; i < tas_dev->ndev; i++) {
> +			ret = tasdevice_dev_write(tas_dev, i, mc->reg,
> +				(unsigned int)val);
> +			if (ret) {
> +				err_cnt++;
> +				dev_err(tas_dev->dev,
> +					"set digital vol err in dev %d\n", i);
> +			}
> +		}
> +	}
> +	/* All the devices set error, return 0*/
> +	return (err_cnt == tas_dev->ndev) ? 0 : 1;
> +}
> +
> +static int tas2781_amp_getvol(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec
> +		= snd_soc_kcontrol_component(kcontrol);
> +	struct tasdevice_priv *tas_dev =
> +		snd_soc_component_get_drvdata(codec);
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	int val;
> +	unsigned char mask = 0;
> +	int max = mc->max;
> +	int ret = 0;
> +	unsigned int invert = mc->invert;
> +
> +	/* Read the primary device */
> +	ret = tasdevice_dev_read(tas_dev, 0, mc->reg, &val);
> +	if (ret) {
> +		dev_err(tas_dev->dev, "%s, get AMP vol error\n", __func__);
> +		goto out;
> +	}
> +
> +	mask = (1 << fls(mc->max)) - 1;
> +	mask <<= mc->shift;
> +	val = (val & mask) >> mc->shift;
> +	if (val > max)
> +		val = max;
> +	if (invert)
> +		val = max - val;
> +	if (val < 0)
> +		val = 0;
> +	ucontrol->value.integer.value[0] = val;
> +
> +out:
> +	return ret;
> +}
> +
> +static int tas2781_amp_putvol(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec
> +		= snd_soc_kcontrol_component(kcontrol);
> +	struct tasdevice_priv *tas_dev =
> +		snd_soc_component_get_drvdata(codec);
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	int val;
> +	int i, ret;
> +	unsigned char mask;
> +	int max = mc->max;
> +	unsigned int invert = mc->invert;
> +	int err_cnt = 0;
> +
> +	mask = (1 << fls(mc->max)) - 1;
> +	mask <<= mc->shift;
> +	val = ucontrol->value.integer.value[0];
> +	if (val > max)
> +		val = max;
> +	if (invert)
> +		val = max - val;
> +	if (val < 0)
> +		val = 0;
> +	for (i = 0; i < tas_dev->ndev; i++) {
> +		ret = tasdevice_dev_update_bits(tas_dev, i,
> +			mc->reg, mask, (unsigned int)(val << mc->shift));
> +		if (ret) {
> +			err_cnt++;
> +			dev_err(tas_dev->dev, "set AMP vol error in dev %d\n",
> +				i);
> +		}
> +	}
> +
> +	/* All the devices set error, return 0*/
> +	return (err_cnt == tas_dev->ndev) ? 0 : 1;
> +}
> +
> +static const DECLARE_TLV_DB_SCALE(dvc_tlv, -10000, 100, 0);
> +static const DECLARE_TLV_DB_SCALE(amp_vol_tlv, 1100, 50, 0);
> +
> +static const struct snd_kcontrol_new tas2781_snd_controls[] = {
> +	SOC_SINGLE_RANGE_EXT_TLV("Amp Gain Volume", TAS2781_AMP_LEVEL,
> +		1, 0, 20, 0, tas2781_amp_getvol,
> +		tas2781_amp_putvol, amp_vol_tlv),
> +	SOC_SINGLE_RANGE_EXT_TLV("Digital Volume", TAS2781_DVC_LVL,
> +		0, 0, 200, 1, tas2781_digital_getvol,
> +		tas2781_digital_putvol, dvc_tlv),
> +};
> +
> +static int tasdevice_set_profile_id(struct snd_kcontrol *kcontrol,
> +		struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec
> +		= snd_soc_kcontrol_component(kcontrol);
> +	struct tasdevice_priv *tas_dev =
> +		snd_soc_component_get_drvdata(codec);
> +
> +	tas_dev->rcabin.profile_cfg_id =
> +		ucontrol->value.integer.value[0];
> +
> +	return 1;
> +}
> +
> +static int tasdevice_info_programs(struct snd_kcontrol *kcontrol,
> +			struct snd_ctl_elem_info *uinfo)
> +{
> +	struct snd_soc_component *codec
> +		= snd_soc_kcontrol_component(kcontrol);
> +	struct tasdevice_priv *tas_dev =
> +		snd_soc_component_get_drvdata(codec);
> +	struct tasdevice_fw *tas_fw = tas_dev->fmw;
> +
> +	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
> +
> +	uinfo->count = 1;
> +	uinfo->value.integer.min = 0;
> +	uinfo->value.integer.max = (int)tas_fw->nr_programs;
> +
> +	return 0;
> +}
> +
> +static int tasdevice_info_configurations(
> +	struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
> +{
> +	struct snd_soc_component *codec
> +		= snd_soc_kcontrol_component(kcontrol);
> +	struct tasdevice_priv *tas_dev =
> +		snd_soc_component_get_drvdata(codec);
> +	struct tasdevice_fw *tas_fw = tas_dev->fmw;
> +
> +	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
> +
> +	uinfo->count = 1;
> +	uinfo->value.integer.min = 0;
> +	uinfo->value.integer.max = (int)tas_fw->nr_configurations - 1;
> +
> +
> +	return 0;
> +}
> +
> +static int tasdevice_info_profile(struct snd_kcontrol *kcontrol,
> +			struct snd_ctl_elem_info *uinfo)
> +{
> +	struct snd_soc_component *codec
> +		= snd_soc_kcontrol_component(kcontrol);
> +	struct tasdevice_priv *tas_dev =
> +		snd_soc_component_get_drvdata(codec);
> +
> +	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
> +
> +	uinfo->count = 1;
> +	uinfo->value.integer.min = 1;
> +	uinfo->value.integer.max = max(0, tas_dev->rcabin.ncfgs);
> +
> +	return 0;
> +}
> +
> +static int tasdevice_get_profile_id(struct snd_kcontrol *kcontrol,
> +			  struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec
> +		= snd_soc_kcontrol_component(kcontrol);
> +	struct tasdevice_priv *tas_dev
> +		= snd_soc_component_get_drvdata(codec);
> +
> +	ucontrol->value.integer.value[0] =
> +		tas_dev->rcabin.profile_cfg_id;
> +
> +	return 0;
> +}
> +
> +static int tasdevice_create_controls(struct tasdevice_priv *tas_dev)
> +{
> +	int  nr_controls = 1, ret = 0, mix_index = 0;
> +	char *name = NULL;
> +	struct snd_kcontrol_new *tasdevice_profile_controls = NULL;

inits again

> +
> +	tasdevice_profile_controls = devm_kzalloc(tas_dev->dev,
> +			nr_controls * sizeof(tasdevice_profile_controls[0]),
> +			GFP_KERNEL);
> +	if (tasdevice_profile_controls == NULL) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* Create a mixer item for selecting the active profile */
> +	name = devm_kzalloc(tas_dev->dev,
> +		SNDRV_CTL_ELEM_ID_NAME_MAXLEN, GFP_KERNEL);
> +	if (!name) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "TASDEVICE Profile id");
> +	tasdevice_profile_controls[mix_index].name = name;
> +	tasdevice_profile_controls[mix_index].iface =
> +		SNDRV_CTL_ELEM_IFACE_MIXER;
> +	tasdevice_profile_controls[mix_index].info =
> +		tasdevice_info_profile;
> +	tasdevice_profile_controls[mix_index].get =
> +		tasdevice_get_profile_id;
> +	tasdevice_profile_controls[mix_index].put =
> +		tasdevice_set_profile_id;
> +	mix_index++;
> +
> +	ret = snd_soc_add_component_controls(tas_dev->codec,
> +		tasdevice_profile_controls,
> +		nr_controls < mix_index ? nr_controls : mix_index);
> +
> +	tas_dev->tas_ctrl.nr_controls =
> +		nr_controls < mix_index ? nr_controls : mix_index;
> +out:
> +	return ret;
> +}
>
> +static int tasdevice_dsp_create_control(
> +	struct tasdevice_priv *tas_dev)
> +{
> +	int  nr_controls = 2, ret = 0, mix_index = 0;
> +	char *program_name = NULL;
> +	char *configuration_name = NULL;
> +	struct snd_kcontrol_new *tasdevice_dsp_controls = NULL;

inits again

> +
> +	tasdevice_dsp_controls = devm_kzalloc(tas_dev->dev,
> +			nr_controls * sizeof(tasdevice_dsp_controls[0]),
> +			GFP_KERNEL);
> +	if (tasdevice_dsp_controls == NULL) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* Create a mixer item for selecting the active profile */
> +	program_name = devm_kzalloc(tas_dev->dev,
> +		SNDRV_CTL_ELEM_ID_NAME_MAXLEN, GFP_KERNEL);
> +	configuration_name = devm_kzalloc(tas_dev->dev,
> +		SNDRV_CTL_ELEM_ID_NAME_MAXLEN, GFP_KERNEL);
> +	if (!program_name || !configuration_name) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	scnprintf(program_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "Program");
> +	tasdevice_dsp_controls[mix_index].name = program_name;
> +	tasdevice_dsp_controls[mix_index].iface =
> +		SNDRV_CTL_ELEM_IFACE_MIXER;
> +	tasdevice_dsp_controls[mix_index].info =
> +		tasdevice_info_programs;
> +	tasdevice_dsp_controls[mix_index].get =
> +		tasdevice_program_get;
> +	tasdevice_dsp_controls[mix_index].put =
> +		tasdevice_program_put;
> +	mix_index++;
> +
> +	scnprintf(configuration_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
> +		"Configuration");
> +	tasdevice_dsp_controls[mix_index].name = configuration_name;
> +	tasdevice_dsp_controls[mix_index].iface =
> +		SNDRV_CTL_ELEM_IFACE_MIXER;
> +	tasdevice_dsp_controls[mix_index].info =
> +		tasdevice_info_configurations;
> +	tasdevice_dsp_controls[mix_index].get =
> +		tasdevice_configuration_get;
> +	tasdevice_dsp_controls[mix_index].put =
> +		tasdevice_configuration_put;
> +	mix_index++;
> +
> +	ret = snd_soc_add_component_controls(tas_dev->codec,
> +		tasdevice_dsp_controls,
> +		nr_controls < mix_index ? nr_controls : mix_index);
> +
> +	tas_dev->tas_ctrl.nr_controls += nr_controls;
> +out:
> +	return ret;
> +}
> +
> +static void tasdevice_rca_ready(const struct firmware *fmw,
> +	void *context)
> +{
> +	struct tasdevice_priv *tas_dev =
> +		(struct tasdevice_priv *) context;
> +	struct tasdevice_rca *rca;
> +	struct tasdevice_rca_hdr *fw_hdr;
> +	struct tasdevice_config_info **cfg_info = NULL;
> +	const struct firmware *fw_entry;
> +	unsigned char *buf;
> +	int offset = 0;
> +	int i, ret;
> +	unsigned int total_config_sz = 0;
> +
> +	mutex_lock(&tas_dev->codec_lock);
> +	rca = &(tas_dev->rcabin);
> +	fw_hdr = &(rca->fw_hdr);
> +	if (!fmw || !fmw->data) {
> +		dev_err(tas_dev->dev,
> +		"Failed to read %s, no side - effect on driver running\n",
> +		tas_dev->rca_binaryname);
> +		ret = -1;
> +		goto out;
> +	}
> +	buf = (unsigned char *)fmw->data;
> +
> +	fw_hdr->img_sz = SMS_HTONL(buf[offset], buf[offset + 1],
> +		buf[offset + 2], buf[offset + 3]);
> +	offset  += 4;
> +	if (fw_hdr->img_sz != fmw->size) {
> +		dev_err(tas_dev->dev,
> +			"File size not match, %d %u", (int)fmw->size,
> +			fw_hdr->img_sz);
> +		ret = -1;
> +		goto out;
> +	}
> +
> +	fw_hdr->checksum = SMS_HTONL(buf[offset], buf[offset + 1],
> +					buf[offset + 2], buf[offset + 3]);
> +	offset  += 4;
> +	fw_hdr->binary_version_num = SMS_HTONL(buf[offset],
> +		buf[offset + 1], buf[offset + 2], buf[offset + 3]);
> +	if (fw_hdr->binary_version_num < 0x103) {
> +		dev_err(tas_dev->dev,
> +			"File version 0x%04x is too low",
> +			fw_hdr->binary_version_num);
> +		ret = -1;
> +		goto out;
> +	}
> +	offset  += 4;
> +	fw_hdr->drv_fw_version = SMS_HTONL(buf[offset], buf[offset + 1],
> +					buf[offset + 2], buf[offset + 3]);
> +	offset  += 8;
> +	fw_hdr->plat_type = buf[offset];
> +	offset  += 1;
> +	fw_hdr->dev_family = buf[offset];
> +	offset  += 1;
> +	fw_hdr->reserve = buf[offset];
> +	offset  += 1;
> +	fw_hdr->ndev = buf[offset];
> +	offset  += 1;
> +	if (fw_hdr->ndev != tas_dev->ndev) {
> +		dev_err(tas_dev->dev,
> +			"ndev(%u) fro rcabin and ndev(%u) fro DTS NOT match\n",
> +			fw_hdr->ndev, tas_dev->ndev);
> +		ret = -1;
> +		goto out;
> +	}
> +	if (offset + TASDEVICE_DEVICE_SUM > fw_hdr->img_sz) {
> +		dev_err(tas_dev->dev, "rca_ready: Out of bounary!\n");
> +		ret = -1;
> +		goto out;
> +	}
> +
> +	for (i = 0; i < TASDEVICE_DEVICE_SUM; i++, offset++)
> +		fw_hdr->devs[i] = buf[offset];
> +
> +	fw_hdr->nconfig = SMS_HTONL(buf[offset], buf[offset + 1],
> +				buf[offset + 2], buf[offset + 3]);
> +	offset  += 4;
> +
> +	for (i = 0; i < TASDEVICE_CONFIG_SUM; i++) {
> +		fw_hdr->config_size[i] = SMS_HTONL(buf[offset],
> +			buf[offset + 1], buf[offset + 2], buf[offset + 3]);
> +		offset  += 4;
> +		total_config_sz  += fw_hdr->config_size[i];
> +	}
> +
> +	if (fw_hdr->img_sz - total_config_sz != (unsigned int)offset) {
> +		dev_err(tas_dev->dev, "Bin file error!\n");
> +		ret = -1;
> +		goto out;
> +	}
> +	cfg_info = kcalloc(fw_hdr->nconfig,
> +		sizeof(struct tasdevice_config_info *),
> +		GFP_KERNEL);
> +
> +	if (!cfg_info) {
> +		ret = -1;
> +		goto out;
> +	}
> +	rca->cfg_info = cfg_info;
> +	rca->ncfgs = 0;
> +	for (i = 0; i < (int)fw_hdr->nconfig; i++) {
> +		cfg_info[i] = tasdevice_add_config(context, &buf[offset],
> +				fw_hdr->config_size[i]);
> +		if (!cfg_info[i]) {
> +			ret = -1;
> +			break;
> +		}
> +		offset  += (int)fw_hdr->config_size[i];
> +		rca->ncfgs  += 1;
> +	}
> +	tasdevice_create_controls(tas_dev);
> +
> +	tasdevice_dsp_remove(tas_dev);
> +	tasdevice_calbin_remove(tas_dev);
> +	tas_dev->fw_state = TASDEVICE_DSP_FW_PENDING;
> +	scnprintf(tas_dev->coef_binaryname, 64, "%s_coef.bin",
> +		tas_dev->dev_name);
> +	ret = request_firmware(&fw_entry, tas_dev->coef_binaryname,
> +		tas_dev->dev);
> +	if (!ret) {
> +		ret = tasdevice_dspfw_ready(fw_entry, tas_dev);
> +		release_firmware(fw_entry);
> +		fw_entry = NULL;
> +	} else {
> +		tas_dev->fw_state = TASDEVICE_DSP_FW_FAIL;
> +		dev_err(tas_dev->dev, "%s: load %s error\n", __func__,
> +			tas_dev->coef_binaryname);
> +		goto out;
> +	}
> +	tasdevice_dsp_create_control(tas_dev);
> +
> +	tas_dev->fw_state = TASDEVICE_DSP_FW_ALL_OK;
> +	tas_dev->is_glb_calibrated_data_loaded = true;
> +	for (i = 0; i < tas_dev->ndev; i++) {
> +		scnprintf(tas_dev->cal_binaryname[i], 64, "%s_cal_0x%02x.bin",
> +			tas_dev->dev_name, tas_dev->tasdevice[i].dev_addr);
> +		ret = tas2781_load_calibration(tas_dev,
> +			tas_dev->cal_binaryname[i], i);
> +		if (ret != 0) {
> +			dev_err(tas_dev->dev,
> +				"%s: load %s error, no-side effect\n",
> +				__func__, tas_dev->cal_binaryname[i]);
> +			ret = 0;
> +			tas_dev->is_glb_calibrated_data_loaded = false;
> +		}
> +	}
> +
> +out:
> +	mutex_unlock(&tas_dev->codec_lock);
> +	if (fmw)
> +		release_firmware(fmw);
> +}
> +
> +static void tasdevice_config_info_remove(void *context)
> +{
> +	struct tasdevice_priv *tas_dev =
> +		(struct tasdevice_priv *) context;
> +	struct tasdevice_rca *rca = &(tas_dev->rcabin);
> +	struct tasdevice_config_info **cfg_info = rca->cfg_info;
> +	int i, j;
> +
> +	if (cfg_info) {
> +		for (i = 0; i < rca->ncfgs; i++) {
> +			if (cfg_info[i]) {
> +				for (j = 0; j < (int)cfg_info[i]->real_nblocks;
> +					j++) {
> +					kfree(
> +					cfg_info[i]->blk_data[j]->regdata);
> +					kfree(cfg_info[i]->blk_data[j]);
> +				}
> +				kfree(cfg_info[i]->blk_data);
> +				kfree(cfg_info[i]);
> +			}
> +		}
> +		kfree(cfg_info);
> +	}
> +}
> +
> +static void tasdevice_tuning_switch(
> +	struct tasdevice_priv *tas_dev, int state)
> +{
> +	struct tasdevice_fw *tas_fmw = tas_dev->fmw;
> +	int profile_cfg_id = 0;
> +
> +	if (state == 0) {
> +		if (tas_fmw) {
> +			if (tas_dev->cur_prog >= tas_fmw->nr_programs)
> +				/*bypass all in rca is profile id 0*/
> +				profile_cfg_id = RCA_CONFIGID_BYPASS_ALL;
> +			else {
> +				/*dsp mode or tuning mode*/
> +				profile_cfg_id =
> +					tas_dev->rcabin.profile_cfg_id;
> +
> +				tasdevice_select_tuningprm_cfg(tas_dev,
> +					tas_dev->cur_prog,
> +					tas_dev->cur_conf,
> +					profile_cfg_id);
> +				if (tas_dev->set_global_mode != NULL)
> +					tas_dev->set_global_mode(tas_dev);
> +			}
> +		}  else
> +			profile_cfg_id = RCA_CONFIGID_BYPASS_ALL;
> +
> +		tasdevice_select_cfg_blk(tas_dev, profile_cfg_id,
> +			TASDEVICE_BIN_BLK_PRE_POWER_UP);
> +	} else
> +		tasdevice_select_cfg_blk(tas_dev,
> +			tas_dev->rcabin.profile_cfg_id,
> +			TASDEVICE_BIN_BLK_PRE_SHUTDOWN);
> +}
> +
> +static int tasdevice_dapm_event(struct snd_soc_dapm_widget *w,
> +			struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_component *codec = snd_soc_dapm_to_component(w->dapm);
> +	struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(codec);
> +	int state = 1;
> +
> +	/* Codec Lock Hold */
> +	mutex_lock(&tas_dev->codec_lock);
> +	if (event == SND_SOC_DAPM_PRE_PMD)
> +		state = 0;
> +	tasdevice_tuning_switch(tas_dev, state);
> +	/* Codec Lock Release*/
> +	mutex_unlock(&tas_dev->codec_lock);
> +
> +	return 0;
> +}
> +
> +static const struct snd_soc_dapm_widget tasdevice_dapm_widgets[] = {
> +	SND_SOC_DAPM_AIF_IN("ASI", "ASI Playback", 0, SND_SOC_NOPM, 0, 0),
> +	SND_SOC_DAPM_AIF_OUT_E("ASI OUT", "ASI Capture", 0, SND_SOC_NOPM,
> +		0, 0, tasdevice_dapm_event,
> +		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
> +	SND_SOC_DAPM_SPK("SPK", tasdevice_dapm_event),
> +	SND_SOC_DAPM_OUTPUT("OUT"),
> +	SND_SOC_DAPM_INPUT("DMIC")
> +};
> +
> +static const struct snd_soc_dapm_route tasdevice_audio_map[] = {
> +	{"SPK", NULL, "ASI"},
> +	{"OUT", NULL, "SPK"},
> +	{"ASI OUT", NULL, "DMIC"}
> +};
> +
> +static int tasdevice_startup(struct snd_pcm_substream *substream,
> +						struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *codec = dai->component;
> +	struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(codec);
> +	int ret = 0;
> +
> +	if (tas_dev->fw_state != TASDEVICE_DSP_FW_ALL_OK) {
> +		dev_err(tas_dev->dev, "DSP bin file not loaded\n");
> +		ret = -EINVAL;
> +	}
> +	return ret;
> +}
> +
> +static int tasdevice_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
> +{
> +	struct tasdevice_priv *tas_dev = snd_soc_dai_get_drvdata(dai);
> +	unsigned int fsrate;
> +	unsigned int slot_width;
> +	int bclk_rate;
> +	int rc = 0;
> +
> +	fsrate = params_rate(params);
> +	switch (fsrate) {
> +	case 48000:
> +		break;
> +	case 44100:
> +		break;
> +	default:
> +		dev_err(tas_dev->dev, "%s: incorrect sample rate = %u\n",
> +			__func__, fsrate);
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	slot_width = params_width(params);
> +	switch (slot_width) {
> +	case 16:
> +		break;
> +	case 20:
> +		break;
> +	case 24:
> +		break;
> +	case 32:
> +		break;
> +	default:
> +		dev_err(tas_dev->dev, "%s: incorrect slot width = %u\n",
> +			__func__, slot_width);
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	bclk_rate = snd_soc_params_to_bclk(params);
> +	if (bclk_rate < 0) {
> +		dev_err(tas_dev->dev, "%s: incorrect bclk rate = %d\n",
> +			__func__, bclk_rate);
> +		rc = bclk_rate;
> +		goto out;
> +	}
> +out:
> +	return rc;
> +}
> +
> +static int tasdevice_set_dai_sysclk(struct snd_soc_dai *codec_dai,
> +	int clk_id, unsigned int freq, int dir)
> +{
> +	struct tasdevice_priv *tas_dev = snd_soc_dai_get_drvdata(codec_dai);
> +
> +	tas_dev->sysclk = freq;
> +
> +	return 0;
> +}
> +
> +static const struct snd_soc_dai_ops tasdevice_dai_ops = {
> +	.startup = tasdevice_startup,
> +	.hw_params = tasdevice_hw_params,
> +	.set_sysclk = tasdevice_set_dai_sysclk,
> +};
> +
> +static struct snd_soc_dai_driver tasdevice_dai_driver[] = {
> +	{
> +		.name = "tas2781_codec",
> +		.id = 0,
> +		.playback = {
> +			.stream_name	= "Playback",
> +			.channels_min   = 1,
> +			.channels_max   = 4,
> +			.rates	 = TASDEVICE_RATES,
> +			.formats	= TASDEVICE_FORMATS,
> +		},
> +		.capture = {
> +			.stream_name	= "Capture",
> +			.channels_min   = 1,
> +			.channels_max   = 4,
> +			.rates	 = TASDEVICE_RATES,
> +			.formats	= TASDEVICE_FORMATS,
> +		},
> +		.ops = &tasdevice_dai_ops,
> +		.symmetric_rate = 1,
> +	},
> +};
> +
> +static void tas2781_reset(struct tasdevice_priv *tas_dev)
> +{
> +	int ret = 0;
> +	int i = 0;
> +
> +	if (tas_dev->reset) {
> +		gpiod_set_value_cansleep(tas_dev->reset, 0);
> +		usleep_range(500, 1000);
> +		gpiod_set_value_cansleep(tas_dev->reset, 1);
> +	} else {
> +
> +		for (i = 0; i < tas_dev->ndev; i++) {
> +			ret = tasdevice_dev_write(tas_dev, i,
> +				TAS2871_REG_SWRESET,
> +				TAS2871_REG_SWRESET_RESET);
> +			if (ret < 0)
> +				dev_err(tas_dev->dev,
> +					"dev %d swreset fail, %d\n",
> +					i, ret);
> +		}
> +	}
> +	usleep_range(1000, 1050);
> +}
> +
> +static int tasdevice_codec_probe(
> +	struct snd_soc_component *codec)
> +{
> +	struct tasdevice_priv *tas_dev =
> +		snd_soc_component_get_drvdata(codec);
> +	int ret;
> +
> +	/* Codec Lock Hold */
> +	mutex_lock(&tas_dev->codec_lock);

why would you need a mutex here? Nothing has yet happened?

> +
> +	crc8_populate_msb(tas_dev->crc8_lkp_tbl, TASDEVICE_CRC8_POLYNOMIAL);
> +	tas_dev->codec = codec;
> +	scnprintf(tas_dev->rca_binaryname, 64, "%s_rca.bin",
> +		tas_dev->dev_name);
> +	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
> +		tas_dev->rca_binaryname, tas_dev->dev, GFP_KERNEL, tas_dev,
> +		tasdevice_rca_ready);
> +	if (ret)
> +		dev_err(tas_dev->dev, "request_firmware_nowait err:0x%08x\n",
> +			ret);
> +
> +	tas2781_reset(tas_dev);
> +	if (tas_dev->set_global_mode != NULL)
> +		tas_dev->set_global_mode(tas_dev);
> +
> +	/* Codec Lock Release*/
> +	mutex_unlock(&tas_dev->codec_lock);
> +
> +	return ret;
> +}
> +
> +static void tasdevice_deinit(void *context)
> +{
> +	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) context;
> +
> +	tasdevice_config_info_remove(tas_dev);
> +	tasdevice_dsp_remove(tas_dev);
> +	tasdevice_calbin_remove(tas_dev);
> +	tas_dev->fw_state = TASDEVICE_DSP_FW_PENDING;
> +}
> +
> +static void tasdevice_codec_remove(
> +	struct snd_soc_component *codec)
> +{
> +	struct tasdevice_priv *tas_dev =
> +		snd_soc_component_get_drvdata(codec);
> +	/* Codec Lock Hold */
> +	mutex_lock(&tas_dev->codec_lock);
> +	tasdevice_deinit(tas_dev);
> +	/* Codec Lock Release*/
> +	mutex_unlock(&tas_dev->codec_lock);

The use of this mutex sounds really odd.

You want to cancel all deferred work, but there's no possible race
condition between probe and remove, is there?



