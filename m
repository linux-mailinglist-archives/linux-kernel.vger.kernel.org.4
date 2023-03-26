Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC4D6C97EC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 23:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCZVEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 17:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjCZVEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 17:04:45 -0400
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA0A49D3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 14:04:39 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id gXXUpBVqKwFKBgXXUpPh48; Sun, 26 Mar 2023 23:04:37 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 26 Mar 2023 23:04:37 +0200
X-ME-IP: 86.243.2.178
Message-ID: <d9a79adc-0bbb-0851-ef4c-2dc0d65471ca@wanadoo.fr>
Date:   Sun, 26 Mar 2023 23:04:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7] ASoC: tas2781: Add tas2781 driver
To:     Shenghao Ding <13916275206@139.com>, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com
Cc:     kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com
References: <20230326143419.11711-1-13916275206@139.com>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230326143419.11711-1-13916275206@139.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26/03/2023 à 16:34, Shenghao Ding a écrit :
> Create tas2781 driver.
> 
> Signed-off-by: Shenghao Ding <13916275206@139.com>
> 

Hi,

their are still some comments with some missing spaces after /* or before */

Some of "./scripts/checkpatch.pl -f --strict" suggestions make sense.
("Unnecessary parentheses around...", "Avoid CamelCase", " No space is 
necessary after a cast")
Maybe some other ones as well, but do not blindly apply all the 
suggestions :)


Below mostly some style comments that should, IMHO, ease others review.
Up to you to take them or not.

CJ


> ---

> diff --git a/sound/soc/codecs/tas2781-dsp.c b/sound/soc/codecs/tas2781-dsp.c
> new file mode 100644
> index 000000000000..6a0e9fb5e20f
> --- /dev/null
> +++ b/sound/soc/codecs/tas2781-dsp.c

[...]

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
> +	block->type = SMS_HTONL(data[offset],
> +			data[offset + 1], data[offset + 2],
> +			data[offset + 3]);

1 LoC can be saved here. It would also be more consistent with same 
pattern below.

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
> +	block->data = kzalloc(block->blk_size, GFP_KERNEL);

kmemedup()? (not sure it worth it...)

> +	if (!block->data) {
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	memcpy(block->data, &data[offset], block->blk_size);
> +	offset += block->blk_size;
> +
> +out:
> +	return offset;
> +}
> +

[...]

> +static int fw_parse_program_data_kernel(
> +	struct tasdevice_priv *tas_dev, struct tasdevice_fw *tas_fmw,
> +	const struct firmware *fmw, int offset)
> +{
> +	struct tasdevice_prog *program;
> +	unsigned int nr_program;

Just i? (to have a less verbose loop below)

> +
> +	for (nr_program = 0; nr_program < tas_fmw->nr_programs; nr_program++) {
> +		program = &(tas_fmw->programs[nr_program]);
> +		if (offset + 64 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: mpName error\n", __func__);
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		offset += 64;
> +
> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: AppMode error\n", __func__);
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		offset++;
> +
> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_dev->dev, "PDMI2SMode err\n");
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		offset++;
> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: ISnsPD error\n", __func__);
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		offset++;
> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: VSnsPD error\n", __func__);
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		offset++;
> +		//skip 3-byte reserved

Use /* */, as everywhere else ?

> +		offset += 3;
> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: PowerLDG err\n", __func__);
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		offset++;
> +
> +		offset = fw_parse_data_kernel(tas_fmw, &(program->dev_data),
> +			fmw, offset);

Indentation

> +		if (offset < 0)
> +			goto out;
> +	}
> +
> +out:
> +	return offset;
> +}

[...]

> +static int fw_parse_variable_header_kernel(
> +	struct tasdevice_priv *tas_dev, const struct firmware *fmw, int offset)
> +{
> +	struct tasdevice_fw *tas_fmw = tas_dev->fmw;
> +	struct tasdevice_dspfw_hdr *fw_hdr = &(tas_fmw->fw_hdr);
> +	struct tasdevice_prog *program;
> +	struct tasdevice_config *config;
> +	const unsigned char *buf = fmw->data;
> +	unsigned int nr_program, nr_configs;

Just i for both of them?

> +	unsigned short max_confs;
> +
> +	if (offset + 2 > fmw->size) {
> +		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	fw_hdr->device_family = SMS_HTONS(buf[offset], buf[offset + 1]);
> +	if (fw_hdr->device_family != 0) {
> +		dev_err(tas_dev->dev, "%s:not TAS device\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	offset += 2;
> +	if (offset + 2 > fmw->size) {
> +		dev_err(tas_dev->dev, "%s: Device error\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	fw_hdr->device = SMS_HTONS(buf[offset], buf[offset + 1]);
> +	if (fw_hdr->device >= TASDEVICE_DSP_TAS_MAX_DEVICE ||
> +		fw_hdr->device == 6) {
> +		dev_err(tas_dev->dev, "Unsupported dev %d\n", fw_hdr->device);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	offset += 2;
> +	fw_hdr->ndev = deviceNumber[fw_hdr->device];
> +
> +	if (fw_hdr->ndev != tas_dev->ndev) {
> +		dev_err(tas_dev->dev,
> +			"%s: ndev(%u) in dspbin mismatch ndev(%u) in DTS\n",
> +			__func__, fw_hdr->ndev, tas_dev->ndev);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (offset + 4 > fmw->size) {
> +		dev_err(tas_dev->dev, "%s: mnPrograms error\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	tas_fmw->nr_programs = SMS_HTONL(buf[offset], buf[offset + 1],
> +		buf[offset + 2], buf[offset + 3]);
> +	offset += 4;
> +
> +	if (tas_fmw->nr_programs == 0 || tas_fmw->nr_programs >
> +		TASDEVICE_MAXPROGRAM_NUM_KERNEL) {
> +		dev_err(tas_dev->dev, "%s: mnPrograms is invalid\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (offset + 4 * TASDEVICE_MAXPROGRAM_NUM_KERNEL > fmw->size) {
> +		dev_err(tas_dev->dev, "%s: mpPrograms error\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +
> +	tas_fmw->programs = kcalloc(tas_fmw->nr_programs,
> +		sizeof(struct tasdevice_prog), GFP_KERNEL);
> +	if (!tas_fmw->programs) {
> +		offset = -ENOMEM;
> +		goto out;
> +	}
> +
> +	for (nr_program = 0; nr_program < tas_fmw->nr_programs; nr_program++) {
> +		program = &(tas_fmw->programs[nr_program]);
> +		program->prog_size = SMS_HTONL(buf[offset], buf[offset + 1],
> +			buf[offset + 2], buf[offset + 3]);
> +		offset += 4;
> +	}
> +
> +	/* Skip the unused prog_size
> +	 * nr_program == tas_fmw->nr_programs, nr_program is shorter than
> +	 * tas_fmw->nr_programs, avoid more than 80 chars
> +	 */
> +	offset += (4 * (TASDEVICE_MAXPROGRAM_NUM_KERNEL - nr_program));
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
> +	/* The max of conf for more than equal to 4 pcs of devices is different
> +	 * from the one less than 4 pcs of tas2781s.
> +	 */
> +	max_confs = (fw_hdr->ndev >= 4) ?
> +		TASDEVICE_MAXCONFIG_NUM_KERNEL_MULTIPLE_AMPS :
> +		TASDEVICE_MAXCONFIG_NUM_KERNEL;
> +	if (tas_fmw->nr_configurations == 0 ||
> +		tas_fmw->nr_configurations > max_confs) {
> +		dev_err(tas_dev->dev, "%s: Conf is invalid\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (offset + 4 * max_confs > fmw->size) {
> +		dev_err(tas_dev->dev, "%s: mpConfigurations err\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +
> +	tas_fmw->configs = kcalloc(tas_fmw->nr_configurations,
> +		sizeof(struct tasdevice_config), GFP_KERNEL);
> +	if (!tas_fmw->configs) {
> +		offset = -ENOMEM;
> +		goto out;
> +	}
> +
> +	for (nr_configs = 0; nr_configs < tas_fmw->nr_programs;
> +		nr_configs++) {
> +		config =
> +			&(tas_fmw->configs[nr_configs]);

Keep on one line.

> +		config->cfg_size = SMS_HTONL(buf[offset],
> +			buf[offset + 1], buf[offset + 2], buf[offset + 3]);
> +		offset += 4;
> +	}
> +
> +	/* Skip the unused configs */
> +	offset += 4 * (max_confs - nr_configs);

If nr_configs is canged to i, use tas_fmw->nr_programs here instead?

> +
> +out:
> +	return offset;
> +}
> +

[...]

> +static inline void tas2781_clear_calfirmware(struct tasdevice_fw
> +	*tas_fmw)

Keep on one line.

> +{
> +	unsigned int blks;
> +	int i;
> +
> +	if (tas_fmw->calibrations) {
> +		struct tasdevice_calibration *calibration;
> +
> +		for (i = 0; i < tas_fmw->nr_calibrations; i++) {
> +			calibration = &(tas_fmw->calibrations[i]);
> +			if (calibration) {
> +				struct tasdevice_data *im =
> +					&(calibration->dev_data);
> +
> +				if (im->dev_blks) {
> +					struct tasdev_blk *block;
> +
> +					for (blks = 0; blks < im->nr_blk;
> +						blks++) {
> +						block = &(im->dev_blks[blks]);
> +						kfree(block->data);
> +					}
> +					kfree(im->dev_blks);
> +				}
> +			}
> +		}
> +		kfree(tas_fmw->calibrations);
> +	}
> +	kfree(tas_fmw);
> +}
> +
> +static int fw_parse_block_data(struct tasdevice_fw *tas_fmw,
> +	struct tasdev_blk *block, const struct firmware *fmw, int offset)
> +{
> +	unsigned char *data = (unsigned char *)fmw->data;
> +	int n;
> +
> +	if (offset + 4 > fmw->size) {
> +		dev_err(tas_fmw->dev, "%s: Type error\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	block->type = SMS_HTONL(data[offset], data[offset + 1],
> +		data[offset + 2], data[offset + 3]);
> +	offset += 4;
> +
> +	if (tas_fmw->fw_hdr.fixed_hdr.drv_ver >=
> +		PPC_DRIVER_CRCCHK) {

Keep on one line.

> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_fmw->dev, "PChkSumPresent error\n");
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		block->is_pchksum_present = data[offset];
> +		offset++;
> +
> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_fmw->dev, "%s: PChkSum error\n", __func__);
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		block->pchksum = data[offset];
> +		offset++;
> +
> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_fmw->dev, "YChkSumPresent error\n");
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		block->is_ychksum_present = data[offset];
> +		offset++;
> +
> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_fmw->dev, "%s: YChkSum error\n", __func__);
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		block->ychksum = data[offset];
> +		offset++;
> +	} else {
> +		block->is_pchksum_present = 0;
> +		block->is_ychksum_present = 0;
> +	}
> +	if (offset + 4 > fmw->size) {
> +		dev_err(tas_fmw->dev, "%s: Commands error\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	block->nr_cmds = SMS_HTONL(data[offset], data[offset + 1],
> +		data[offset + 2], data[offset + 3]);
> +	offset += 4;
> +
> +	n = block->nr_cmds * 4;
> +	if (offset + n > fmw->size) {
> +		dev_err(tas_fmw->dev,
> +			"%s: File Size(%lu) error offset = %d n = %d\n",
> +			__func__, (unsigned long)fmw->size, offset, n);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	block->data = kmemdup(&data[offset], n, GFP_KERNEL);
> +	if (!block->data) {
> +		offset = -ENOMEM;
> +		goto out;
> +	}
> +	offset += n;
> +
> +out:
> +	return offset;
> +}
> +

[...]

> +static int fw_parse_calibration_data(struct tasdevice_priv *tas_dev,
> +	struct tasdevice_fw *tas_fmw, const struct firmware *fmw, int offset)
> +{
> +	struct tasdevice_calibration *calibration;
> +	unsigned char *data = (unsigned char *)fmw->data;
> +	unsigned int nr_calibration = 0;

Just i?
No need to init.

> +	unsigned int n;
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
> +	tas_fmw->calibrations =
> +		kcalloc(tas_fmw->nr_calibrations,
> +			sizeof(struct tasdevice_calibration), GFP_KERNEL);
> +	if (!tas_fmw->calibrations) {
> +		offset = -ENOMEM;
> +		goto out;
> +	}
> +	for (nr_calibration = 0; nr_calibration < tas_fmw->nr_calibrations;
> +		nr_calibration++) {
> +		if (offset + 64 > fmw->size) {
> +			dev_err(tas_dev->dev, "Calibrations error\n");
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		calibration = &(tas_fmw->calibrations[nr_calibration]);
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
> +	int nr_program;

Just i?

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
> +	for (nr_program = 0; nr_program < tas_fmw->nr_programs; nr_program++) {
> +		int n = 0;
> +
> +		program = &(tas_fmw->programs[nr_program]);
> +		if (offset + 64 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: mpName error\n", __func__);
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		offset += 64;
> +
> +		n = strlen((char *)&buf[offset]);
> +		n++;
> +		if (offset + n > fmw->size) {
> +			dev_err(tas_dev->dev, "Description err\n");
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +
> +		offset += n;
> +
> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: AppMode err\n", __func__);
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		offset++;
> +
> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_dev->dev, "PDMI2SMode err\n");
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		offset++;
> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: ISnsPD error\n", __func__);
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		offset++;
> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: VSnsPD error\n", __func__);
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		offset++;
> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: PowerLDG err\n", __func__);
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		offset++;
> +
> +		offset = fw_parse_data(tas_fmw, &(program->dev_data), fmw,
> +			offset);
> +		if (offset < 0)
> +			goto out;
> +	}
> +
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
> +	struct tasdevice_config *config;
> +	unsigned int n_configs;

Just i?

> +	int n;
> +
> +	if (offset + 2 > fmw->size) {
> +		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	tas_fmw->nr_configurations = SMS_HTONS(data[offset], data[offset + 1]);
> +	offset += 2;
> +
> +	if (tas_fmw->nr_configurations == 0) {
> +		dev_err(tas_dev->dev, "%s: Conf is zero\n", __func__);
> +		/*Not error for calibration Data file, return directly*/
> +		goto out;
> +	}
> +	tas_fmw->configs =
> +		kcalloc(tas_fmw->nr_configurations,
> +			sizeof(struct tasdevice_config), GFP_KERNEL);
> +	if (!tas_fmw->configs) {
> +		offset = -ENOMEM;
> +		goto out;
> +	}
> +	for (n_configs = 0; n_configs < tas_fmw->nr_configurations;
> +		n_configs++) {
> +		config =
> +			&(tas_fmw->configs[n_configs]);

Keep on the same line.

> +		if (offset + 64 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: File Size err\n", __func__);
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		memcpy(config->name, &data[offset], 64);
> +		offset += 64;
> +
> +		n = strlen((char *)&data[offset]);
> +		n++;
> +		if (offset + n > fmw->size) {
> +			dev_err(tas_dev->dev, "Description err\n");
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +
> +		offset += n;
> +		if (offset + 2 > fmw->size) {
> +			dev_err(tas_dev->dev, "Device_orientation err\n");
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		offset += 2;
> +
> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: Program err\n", __func__);
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		offset++;
> +
> +		if (offset + 4 > fmw->size) {
> +			dev_err(tas_dev->dev, "SampleRate err\n");
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		offset += 4;
> +
> +		if (offset + 1 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: PLLSrc err\n", __func__);
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		offset++;
> +
> +		if (offset + 4 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: PLLRate err\n", __func__);
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		offset += 4;
> +
> +		if (offset + 2 > fmw->size) {
> +			dev_err(tas_dev->dev, "%s: mnFsRate err\n", __func__);
> +			offset = -EINVAL;
> +			goto out;
> +		}
> +		offset += 2;
> +
> +		offset = fw_parse_data(tas_fmw, &(config->dev_data),
> +			fmw, offset);
> +		if (offset < 0)
> +			goto out;
> +	}
> +
> +out:
> +	return offset;
> +}
> +

[...]

> +static bool check_inpage_yram_bk1(struct tas_crc *cd,
> +	unsigned char page, unsigned char reg, unsigned char len)
> +{
> +	bool in = false;
> +
> +	if (page == TAS2781_YRAM1_PAGE) {
> +		if (reg >= TAS2781_YRAM1_START_REG) {
> +			cd->offset = reg;
> +			cd->len = len;
> +			in = true;
> +		} else if (reg + len > TAS2781_YRAM1_START_REG) {
> +			cd->offset = TAS2781_YRAM1_START_REG;
> +			cd->len = len - (TAS2781_YRAM1_START_REG - reg);
> +			in = true;
> +		}
> +	} else if (page == TAS2781_YRAM3_PAGE) {
> +		if (reg <= TAS2781_YRAM3_END_REG &&
> +			reg >= TAS2781_YRAM3_START_REG) {
> +			if ((reg + len) > TAS2781_YRAM3_END_REG)
> +				cd->len = TAS2781_YRAM3_END_REG - reg + 1;
> +			else
> +				cd->len = len;
> +			in = true;
> +			cd->offset = reg;
> +		} else if (reg < TAS2781_YRAM3_START_REG) {
> +			if (reg + len - 1 >= TAS2781_YRAM3_START_REG) {
> +				cd->offset = TAS2781_YRAM3_START_REG;
> +				cd->len =
> +				len - (TAS2781_YRAM3_START_REG - reg);

Indentation

> +				in = true;
> +			}
> +		}
> +	}
> +
> +	return in;
> +}
> +
> +static bool check_inpage_yram_bk2(struct tas_crc *cd,
> +	unsigned char page, unsigned char reg, unsigned char len)
> +{
> +	bool in = false;
> +
> +	if (page == TAS2781_YRAM5_PAGE) {
> +		if (reg <= TAS2781_YRAM5_END_REG &&
> +			reg >= TAS2781_YRAM5_START_REG) {
> +			if (reg + len > TAS2781_YRAM5_END_REG)
> +				cd->len = TAS2781_YRAM5_END_REG - reg + 1;
> +			else
> +				cd->len = len;
> +			cd->offset = reg;
> +			in = true;
> +		} else if (reg < TAS2781_YRAM5_START_REG) {
> +			if (reg + len - 1 >= TAS2781_YRAM5_START_REG) {
> +				cd->offset = TAS2781_YRAM5_START_REG;
> +				cd->len = len - TAS2781_YRAM5_START_REG + reg;
> +				in = true;
> +			}
> +		}
> +	}
> +
> +	return in;
> +}

check_inpage_yram_bk1() and check_inpage_yram_bk2() look very close. 
Does it make sence to have only 1 fct and have the PAGE, START_REG and 
END_REG given as parameters?

[...]

> +static bool check_inblock_yram_bk1(struct tas_crc *cd,
> +	unsigned char page, unsigned char reg, unsigned char len)
> +{
> +	bool in = false;
> +
> +	if (page >= TAS2781_YRAM2_START_PAGE &&
> +		page <= TAS2781_YRAM2_END_PAGE) {
> +		if (reg <= TAS2781_YRAM2_END_REG &&
> +			reg >= TAS2781_YRAM2_START_REG) {
> +			cd->offset = reg;
> +			cd->len = len;
> +			in = true;
> +		} else if (reg < TAS2781_YRAM2_START_REG) {
> +			if (reg + len - 1 >= TAS2781_YRAM2_START_REG) {
> +				cd->offset = TAS2781_YRAM2_START_REG;
> +				cd->len = reg + len - TAS2781_YRAM2_START_REG;
> +				in = true;
> +			}
> +		}
> +	}
> +
> +	return in;
> +}
> +
> +static bool check_inblock_yram_bk2(struct tas_crc *cd,
> +	unsigned char page, unsigned char reg, unsigned char len)
> +{
> +	bool in = false;
> +
> +	if (page >= TAS2781_YRAM4_START_PAGE &&
> +		page <= TAS2781_YRAM4_END_PAGE) {
> +		if (reg <= TAS2781_YRAM2_END_REG &&
> +			reg >= TAS2781_YRAM2_START_REG) {
> +			cd->offset = reg;
> +			cd->len = len;
> +			in = true;
> +		} else if (reg < TAS2781_YRAM2_START_REG) {
> +			if (reg + len - 1 >= TAS2781_YRAM2_START_REG) {
> +				cd->offset = TAS2781_YRAM2_START_REG;
> +				cd->len = reg + len - TAS2781_YRAM2_START_REG;
> +				in = true;
> +			}
> +		}
> +	}
> +
> +	return in;
> +}

check_inblock_yram_bk1() and check_inblock_yram_bk2() look very close. 
Does it make sence to have only 1 fct and have the PAGE, START_REG and 
END_REG given as parameters?

[...]

> +static int do_singlereg_checksum(struct tasdevice_priv *tasdevice,
> +	enum channel chl, unsigned char book, unsigned char page,
> +	unsigned char reg, unsigned char val)
> +{
> +	struct tas_crc crc_data;
> +	unsigned int nData1;
> +	int ret = 0;
> +	bool in;
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
> +	in = check_yram(&crc_data, book, page, reg, 1);
> +	if (!in)
> +		goto end;
> +	ret = tasdevice_dev_read(tasdevice, chl,
> +		TASDEVICE_REG(book, page, reg), &nData1);
> +	if (ret < 0)
> +		goto end;
> +
> +	if (nData1 != val) {
> +		dev_err(tasdevice->dev,
> +			"B[0x%x]P[0x%x]R[0x%x] W[0x%x], R[0x%x]\n",
> +			book, page, reg,
> +			val, nData1);
> +		tasdevice->tasdevice[chl].err_code |=
> +			ERROR_YRAM_CRCCHK;
> +		ret = -EAGAIN;
> +		goto end;
> +	}
> +
> +	ret = crc8(tasdevice->crc8_lkp_tbl, &val, 1, 0);
> +
> +end:
> +	return ret;
> +}

Just based on name: Could'nt do_singlereg_checksum() be simplified and 
call do_multireg_checksum()?

> +
> +static int do_multireg_checksum(struct tasdevice_priv *tasdevice,
> +	enum channel chn, unsigned char book, unsigned char page,
> +	unsigned char reg, unsigned int len)
> +{
> +	struct tas_crc crc_data;
> +	unsigned char crc_chksum = 0;
> +	unsigned char nBuf1[128];
> +	int ret = 0;
> +	int i;
> +	bool in;
> +
> +	if ((reg + len - 1) > 127) {
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
> +
> +	in = check_yram(&crc_data, book, page, reg, len);
> +	if (!in)
> +		goto end;
> +
> +	if (len == 1) {
> +		dev_err(tasdevice->dev, "firmware error\n");
> +		ret = -EINVAL;
> +		goto end;
> +	}
> +
> +	ret = tasdevice_dev_bulk_read(tasdevice, chn,
> +		TASDEVICE_REG(book, page, crc_data.offset),
> +		nBuf1, crc_data.len);
> +	if (ret < 0)
> +		goto end;
> +
> +	for (i = 0; i < crc_data.len; i++) {
> +		if ((book == TASDEVICE_BOOK_ID(TAS2781_SA_COEFF_SWAP_REG))
> +			&& (page == TASDEVICE_PAGE_ID(
> +			TAS2781_SA_COEFF_SWAP_REG))
> +			&& ((i + crc_data.offset)
> +			>= TASDEVICE_PAGE_REG(TAS2781_SA_COEFF_SWAP_REG))
> +			&& ((i + crc_data.offset)
> +			<= (TASDEVICE_PAGE_REG(TAS2781_SA_COEFF_SWAP_REG)
> +			+ 4)))
> +			/*DSP swap command, bypass */
> +			continue;
> +		else
> +			crc_chksum += crc8(tasdevice->crc8_lkp_tbl, &nBuf1[i],
> +				1, 0);
> +	}
> +
> +	ret = crc_chksum;
> +
> +end:
> +	return ret;
> +}

[...]

> +static int tasdev_multibytes_wr(struct tasdevice_priv *tas_dev,
> +	struct tasdev_blk *block, int chn, unsigned char book,
> +	unsigned char page, unsigned char reg, unsigned char *data,
> +	unsigned int len, unsigned int *nr_cmds,
> +	unsigned char *crc_chksum)
> +{
> +	int ret;
> +
> +	if (len > 1) {
> +		ret = tasdevice_dev_bulk_write(tas_dev, chn,
> +			TASDEVICE_REG(book, page, reg), data + 3, len);
> +		if (ret < 0)
> +			goto end;
> +		if (block->is_ychksum_present)
> +			ret = tasdev_multibyte_chksum(tas_dev, block, chn,
> +				book, page, reg, len, crc_chksum);
> +	} else {
> +		ret = tasdevice_dev_write(tas_dev,
> +			chn,
> +			TASDEVICE_REG(book, page,
> +			reg),

Keep on the same line.

> +			data[3]);
> +		if (ret < 0)
> +			goto end;
> +		if (block->is_ychksum_present)
> +			ret = tasdev_byte_chksum(tas_dev, block, chn, book,
> +				page, reg, data[3], crc_chksum);
> +	}
> +
> +	if (!block->is_ychksum_present || ret >= 0) {
> +		*nr_cmds += 1;
> +		if (len >= 2)
> +			*nr_cmds += ((len - 2) / 4) + 1;
> +	}
> +
> +end:
> +	return ret;
> +}
> +
> +static int tasdev_block_chksum(struct tasdevice_priv *tas_dev,
> +	struct tasdev_blk *block, int chn)
> +{
> +	unsigned int nr_value;
> +	int ret;
> +
> +	ret = tasdevice_dev_read(tas_dev, chn, TASDEVICE_I2CChecksum,
> +		&nr_value);
> +	if (ret < 0) {
> +		dev_err(tas_dev->dev, "%s: Chn %d\n", __func__, chn);
> +		if ((block->type == MAIN_ALL_DEVICES)
> +			|| (block->type == MAIN_DEVICE_A)
> +			|| (block->type == MAIN_DEVICE_B)
> +			|| (block->type == MAIN_DEVICE_C)
> +			|| (block->type == MAIN_DEVICE_D))
> +			tas_dev->tasdevice[chn].cur_prog = -1;
> +		else
> +			tas_dev->tasdevice[chn].cur_conf = -1;

This sequence is used several times. Does it make sense to turn it into 
a dedicated function to avoid code duplication?

> +		goto end;
> +	}
> +
> +	if ((nr_value & 0xff) != block->pchksum) {
> +		dev_err(tas_dev->dev, "%s: Blk PChkSum Chn %d ", __func__,
> +			chn);
> +		dev_err(tas_dev->dev, "PChkSum = 0x%x, Reg = 0x%x\n",
> +			block->pchksum, (nr_value & 0xff));
> +		tas_dev->tasdevice[chn].err_code |= ERROR_PRAM_CRCCHK;
> +		ret = -EAGAIN;
> +		block->nr_retry--;
> +
> +		if (block->nr_retry <= 0) {
> +			if ((block->type == MAIN_ALL_DEVICES)
> +				|| (block->type == MAIN_DEVICE_A)
> +				|| (block->type == MAIN_DEVICE_B)
> +				|| (block->type == MAIN_DEVICE_C)
> +				|| (block->type == MAIN_DEVICE_D))
> +				tas_dev->tasdevice[chn].cur_prog = -1;
> +			else
> +				tas_dev->tasdevice[chn].cur_conf = -1;
> +		}
> +	} else
> +		tas_dev->tasdevice[chn].err_code &= ~ERROR_PRAM_CRCCHK;
> +
> +end:
> +	return ret;
> +}
> +

[...]


> +static int tasdevice_load_data(struct tasdevice_priv *tas_dev,
> +	struct tasdevice_data *dev_data)
> +{
> +	struct tasdev_blk *block;
> +	unsigned int nr_block;

Just i?

> +	int ret = 0;
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
> +	struct tasdev_blk *block;
> +	unsigned int nr_block;

Just i?

> +	int ret = 0;
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
> +	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *)context;
> +	struct tasdevice *tasdev = &(tas_dev->tasdevice[i]);
> +	const struct firmware *fw_entry;
> +	struct tasdevice_fw *tas_fmw;
> +	struct firmware fmw;
> +	int ret, offset = 0;
> +
> +	ret = request_firmware(&fw_entry, file_name, tas_dev->dev);
> +	if (ret) {
> +		dev_info(tas_dev->dev,
> +			"%s: Request firmware %s failed\n",
> +			__func__, file_name);
> +		goto out;
> +	}
> +
> +	if (!fw_entry->size) {
> +		dev_err(tas_dev->dev,
> +			"%s: file read error: size = %lu\n",
> +			__func__, (unsigned long)fw_entry->size);
> +		goto out;
> +	}
> +	fmw.size = fw_entry->size;
> +	fmw.data = fw_entry->data;
> +
> +	tas_fmw = tasdev->cali_data_fmw = kzalloc(sizeof(struct tasdevice_fw),
> +		GFP_KERNEL);
> +	if (!tasdev->cali_data_fmw) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	tas_fmw->dev = tas_dev->dev;
> +	offset = fw_parse_header(tas_dev, tas_fmw, &fmw, offset);
> +	if (offset == -EINVAL) {
> +		dev_err(tas_dev->dev, "%s: fw_parse_header EXIT!\n", __func__);
> +		ret = offset;
> +		goto out;
> +	}
> +	offset = fw_parse_variable_hdr_cal(tas_dev, tas_fmw, &fmw, offset);
> +	if (offset == -EINVAL) {
> +		dev_err(tas_dev->dev,
> +			"%s: fw_parse_variable_header_cal EXIT!\n", __func__);
> +		ret = offset;
> +		goto out;
> +	}
> +	offset = fw_parse_program_data(tas_dev, tas_fmw, &fmw, offset);
> +	if (offset < 0) {
> +		dev_err(tas_dev->dev, "fw_parse_program_data EXIT!\n");
> +		ret = offset;
> +		goto out;
> +	}
> +	offset = fw_parse_configuration_data(tas_dev, tas_fmw, &fmw,
> +		offset);

Keep these 2 lines on the line.

> +	if (offset < 0) {
> +		dev_err(tas_dev->dev, "fw_parse_configuration_data EXIT!\n");
> +		ret = offset;
> +		goto out;
> +	}
> +	offset = fw_parse_calibration_data(tas_dev,
> +		tas_fmw, &fmw, offset);

Keep these 2 lines on the line.

> +	if (offset < 0) {
> +		dev_err(tas_dev->dev, "fw_parse_calibration_data EXIT!\n");
> +		ret = offset;
> +		goto out;
> +	}
> +	tasdev->is_calibrated_data_loaded = true;
> +
> +out:
> +	if (fw_entry) {
> +		release_firmware(fw_entry);
> +		fw_entry = NULL;
> +	}
> +	return ret;
> +}
> +

[...]

> +int tasdevice_select_tuningprm_cfg(void *context, int prm_no,
> +	int cfg_no, int rca_conf_no)
> +{
> +	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) context;
> +	struct tasdevice_rca *rca = &(tas_dev->rcabin);
> +	struct tasdevice_config_info **cfg_info = rca->cfg_info;
> +	struct tasdevice_fw *tas_fmw = tas_dev->fmw;
> +	struct tasdevice_prog *program;
> +	struct tasdevice_config *conf;
> +	int prog_status = 0;
> +	int status, i;
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
> +			__func__, prm_no, tas_fmw->nr_programs);
> +		goto out;
> +	}
> +
> +	if (rca_conf_no > rca->ncfgs || rca_conf_no <= 0 ||
> +		!cfg_info) {
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

Indentation

> +				}
> +				tas_dev->tasdevice[i].cur_prog = prm_no;
> +			}
> +		}
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
> +
> +out:
> +	return prog_status;
> +}

[...]

> diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
> new file mode 100644
> index 000000000000..9ed10cd0b7bc
> --- /dev/null
> +++ b/sound/soc/codecs/tas2781-i2c.c

[...]

> +static const struct i2c_device_id tasdevice_id[] = {
> +	{ "tas2781", TAS2781	 },

Unneeded tab before }

> +	{}
> +};
> +

[...]

> +int tasdevice_process_block(void *context,
> +	unsigned char *data, unsigned char dev_idx, int sublocksize)
> +{
> +	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *)context;
> +	unsigned char subblk_typ = data[1];
> +	bool is_err = false;
> +	int blktyp = dev_idx & 0xC0;
> +	int idx = dev_idx & 0x3F;
> +	int subblk_offset;
> +	int chn, chnend;
> +	int rc;
> +
> +	if (idx) {
> +		chn = idx - 1;
> +		chnend = idx;
> +	} else {
> +		if (tas_dev->set_global_mode) {
> +			chn = tas_dev->ndev;
> +			chnend = tas_dev->ndev + 1;
> +		} else {
> +			chn = 0;
> +			chnend = tas_dev->ndev;
> +		}
> +	}
> +
> +	for (; chn < chnend; chn++) {
> +		if (!tas_dev->set_global_mode &&
> +			tas_dev->tasdevice[chn].is_loading == false)
> +			continue;
> +
> +		is_err = false;
> +		subblk_offset = 2;
> +		switch (subblk_typ) {
> +		case TASDEVICE_CMD_SING_W: {
> +			int i = 0;

Ne need to init

> +			unsigned short len = SMS_HTONS(data[2], data[3]);
> +
> +			subblk_offset += 2;
> +			if (subblk_offset + 4 * len > sublocksize) {
> +				dev_err(tas_dev->dev,
> +					"process_block: Out of boundary\n");
> +				is_err = true;
> +				break;
> +			}
> +
> +			for (i = 0; i < len; i++) {
> +				rc = tasdevice_dev_write(tas_dev, chn,
> +					TASDEVICE_REG(data[subblk_offset],
> +						data[subblk_offset + 1],
> +						data[subblk_offset + 2]),
> +					data[subblk_offset + 3]);
> +				if (rc < 0) {
> +					is_err = true;
> +					dev_err(tas_dev->dev,
> +					"process_block: single write error\n");
> +				}
> +				subblk_offset += 4;
> +			}
> +		}
> +			break;
> +		case TASDEVICE_CMD_BURST: {
> +			unsigned short len =
> +				SMS_HTONS(data[2], data[3]);

Keep on one line

> +
> +			subblk_offset += 2;
> +			if (subblk_offset + 4 + len > sublocksize) {
> +				dev_err(tas_dev->dev,
> +					"%s: BST Out of boundary\n",
> +					__func__);
> +				is_err = true;
> +				break;
> +			}
> +			if (len % 4) {
> +				dev_err(tas_dev->dev,
> +					"%s:Bst-len(%u)not div by 4\n",
> +					__func__, len);
> +				break;
> +			}
> +
> +			rc = tasdevice_dev_bulk_write(tas_dev, chn,
> +				TASDEVICE_REG(data[subblk_offset],
> +					data[subblk_offset + 1],
> +					data[subblk_offset + 2]),
> +					&(data[subblk_offset + 4]),
> +					len);
> +			if (rc < 0) {
> +				is_err = true;
> +				dev_err(tas_dev->dev,
> +					"%s: bulk_write error = %d\n",
> +					__func__, rc);
> +			}
> +			subblk_offset += (len + 4);
> +		}
> +			break;
> +		case TASDEVICE_CMD_DELAY: {
> +			unsigned int sleep_time = 0;
> +
> +			if (subblk_offset + 2 > sublocksize) {
> +				dev_err(tas_dev->dev,
> +					"%s: deley Out of boundary\n",

Delay ?

> +					__func__);
> +				is_err = true;
> +				break;
> +			}
> +			sleep_time = SMS_HTONS(data[2], data[3]) * 1000;
> +			usleep_range(sleep_time, sleep_time + 50);
> +			subblk_offset += 2;
> +		}
> +			break;
> +		case TASDEVICE_CMD_FIELD_W:
> +			if (subblk_offset + 6 > sublocksize) {
> +				dev_err(tas_dev->dev,
> +					"%s: bit write Out of boundary\n",
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
> +			subblk_offset += 6;
> +			break;
> +		default:
> +			break;
> +		};

No need for ;

> +		if (is_err == true && blktyp != 0) {
> +			if (blktyp == 0x80) {
> +				tas_dev->tasdevice[chn].cur_prog = -1;
> +				tas_dev->tasdevice[chn].cur_conf = -1;
> +			} else
> +				tas_dev->tasdevice[chn].cur_conf = -1;
> +		}
> +	}
> +
> +	return subblk_offset;
> +}
> +
> +static void tasdevice_select_cfg_blk(void *pContext, int conf_no,
> +	unsigned char block_type)
> +{
> +	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) pContext;
> +	struct tasdevice_rca *rca = &(tas_dev->rcabin);
> +	struct tasdevice_config_info **cfg_info = rca->cfg_info;
> +	struct tasdev_blk_data **blk_data;
> +	int j, k, chn, chnend;
> +
> +	if (conf_no >= rca->ncfgs || conf_no < 0 || !cfg_info) {
> +		dev_err(tas_dev->dev,
> +			"conf_no should be not more than %u\n",
> +			rca->ncfgs);
> +		goto out;
> +	}
> +	blk_data =  cfg_info[conf_no]->blk_data;
> +
> +	for (j = 0; j < (int)cfg_info[conf_no]->real_nblocks; j++) {
> +		unsigned int length = 0, rc = 0;
> +
> +		if (block_type > 5 || block_type < 2) {
> +			dev_err(tas_dev->dev,
> +				"block_type should be in range from 2 to 5\n");
> +			goto out;
> +		}
> +		if (block_type != blk_data[j]->block_type)
> +			continue;
> +
> +		for (k = 0; k < (int)blk_data[j]->n_subblks; k++) {
> +			if (cfg_info[conf_no]->blk_data[j]->dev_idx) {
> +				chn = blk_data[j]->dev_idx - 1;
> +				chnend = blk_data[j]->dev_idx;
> +			} else {
> +				chn = 0;
> +				chnend = tas_dev->ndev;
> +			}
> +			for (; chn < chnend; chn++)
> +				tas_dev->tasdevice[chn].is_loading = true;
> +
> +			rc = tasdevice_process_block(tas_dev,
> +				blk_data[j]->regdata + length,
> +				blk_data[j]->dev_idx,
> +				blk_data[j]->block_size - length);
> +			length += rc;
> +			if (blk_data[j]->block_size < length) {
> +				dev_err(tas_dev->dev,
> +					"%s: %u %u out of boundary\n",
> +					__func__, length,
> +					blk_data[j]->block_size);
> +				break;
> +			}
> +		}
> +		if (length != blk_data[j]->block_size)
> +			dev_err(tas_dev->dev, "%s: %u %u size is not same\n",
> +				__func__, length, blk_data[j]->block_size);
> +	}
> +
> +out:
> +	return;

Useless

> +}
> +
> +static struct tasdevice_config_info *tasdevice_add_config(
> +	void *context, unsigned char *config_data,
> +	unsigned int config_size, int *status)
> +{
> +	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *)context;
> +	struct tasdevice_config_info *cfg_info;
> +	int config_offset = 0;
> +	int i;
> +
> +	cfg_info = kzalloc(sizeof(struct tasdevice_config_info), GFP_KERNEL);

Does it make sense to use a flexible array for blk_data?
This would safe an allocation below and slighly simplify code.

Or maybe even allocating all "blk_data[i]" all at once and avoid 
indirection? (I have no idea how big it can be...)


> +	if (!cfg_info) {
> +		*status = -ENOMEM;
> +		goto out;
> +	}
> +
> +	if (tas_dev->rcabin.fw_hdr.binary_version_num >= 0x105) {
> +		if (config_offset + 64 > (int)config_size) {
> +			*status = -EINVAL;
> +			dev_err(tas_dev->dev, "add config: Out of boundary\n");
> +			goto out;
> +		}
> +		config_offset += 64;
> +	}
> +
> +	if (config_offset + 4 > (int)config_size) {

The int cast is not consitent with the below (see "...here").
The cast should ne consistent, or maybe "config_offset" should be 
unsigned int as well?

> +		*status = -EINVAL;
> +		dev_err(tas_dev->dev, "add config: Out of boundary\n");
> +		goto out;
> +	}
> +	cfg_info->nblocks =
> +		SMS_HTONL(config_data[config_offset],
> +		config_data[config_offset + 1],
> +	config_data[config_offset + 2], config_data[config_offset + 3]);
> +	config_offset += 4;
> +
> +	cfg_info->blk_data = kcalloc(cfg_info->nblocks,
> +		sizeof(struct tasdev_blk_data *), GFP_KERNEL);
> +	if (!cfg_info->blk_data) {
> +		*status = -ENOMEM;
> +		goto out;
> +	}
> +	cfg_info->real_nblocks = 0;
> +	for (i = 0; i < (int)cfg_info->nblocks; i++) {
> +		if (config_offset + 12 > config_size) {

...here

> +			*status = -EINVAL;
> +			dev_err(tas_dev->dev,
> +				"%s: Out of boundary: i = %d nblocks = %u!\n",
> +				__func__, i, cfg_info->nblocks);
> +			break;
> +		}
> +		cfg_info->blk_data[i] = kzalloc(
> +			sizeof(struct tasdev_blk_data), GFP_KERNEL);

If "cfg_info->blk_data[i]" was kept in a var with a smaller name, the 
code below would be more readable, IMHO.

> +		if (!cfg_info->blk_data[i]) {
> +			*status = -ENOMEM;
> +			break;
> +		}
> +
> +		cfg_info->blk_data[i]->dev_idx = config_data[config_offset];
> +		config_offset++;
> +
> +		cfg_info->blk_data[i]->block_type = config_data[config_offset];
> +		config_offset++;
> +
> +		if (cfg_info->blk_data[i]->block_type ==
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
> +		config_offset += 2;
> +		cfg_info->blk_data[i]->block_size =
> +			SMS_HTONL(config_data[config_offset],
> +			config_data[config_offset + 1],
> +			config_data[config_offset + 2],
> +		config_data[config_offset + 3]);
> +		config_offset += 4;
> +
> +		cfg_info->blk_data[i]->n_subblks =
> +			SMS_HTONL(config_data[config_offset],
> +			config_data[config_offset + 1],
> +			config_data[config_offset + 2],
> +		config_data[config_offset + 3]);
> +
> +		config_offset += 4;
> +		cfg_info->blk_data[i]->regdata = kzalloc(
> +			cfg_info->blk_data[i]->block_size, GFP_KERNEL);
> +		if (!cfg_info->blk_data[i]->regdata) {
> +			*status = -ENOMEM;
> +			goto out;
> +		}
> +
> +		if (config_offset + cfg_info->blk_data[i]->block_size
> +			> config_size) {
> +			*status = -EINVAL;
> +			dev_err(tas_dev->dev,
> +				"%s: Out of boundary: i = %d blks = %u!\n",
> +				__func__, i, cfg_info->nblocks);
> +			break;
> +		}
> +		memcpy(cfg_info->blk_data[i]->regdata,
> +			&config_data[config_offset],
> +		cfg_info->blk_data[i]->block_size);

Indentation

> +		config_offset += cfg_info->blk_data[i]->block_size;
> +		cfg_info->real_nblocks += 1;
> +	}
> +
> +out:
> +	return cfg_info;
> +}
> +
> +/**
> + * tas2781_digital_getvol - get the volum control
> + * @kcontrol: control pointer
> + * @ucontrol: User data
> + * Customer Kcontrol for tas2781 is primarily for regmap booking, paging
> + * depends on internal regmap mechanism.
> + * tas2781 contains book and page two-level register map, especially
> + * book switching will set the register BXXP00R7F, after switching to the
> + * correct book, then leverage the mechanism for paging to access the register.
> + */
> +static int tas2781_digital_getvol(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
> +	struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(codec);
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	unsigned int invert = mc->invert;
> +	int max = mc->max;
> +	int ret = 0;

No need to init

> +	int val;
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

Does it makes sense to have a "val = tas2781_clamp(val, max, invert)" to 
avoid code duplication here and in the functions below?

> +	ucontrol->value.integer.value[0] = val;
> +
> +out:
> +	return ret;
> +}
> +

[...]

> +static int tas2781_amp_getvol(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
> +	struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(codec);
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	unsigned int invert = mc->invert;
> +	unsigned char mask = 0;
> +	int max = mc->max;
> +	int ret = 0;
> +	int val;
> +
> +	/* Read the primary device */
> +	ret = tasdevice_dev_read(tas_dev, 0, mc->reg, &val);
> +	if (ret) {
> +		dev_err(tas_dev->dev, "%s, get AMP vol error\n", __func__);
> +		goto out;
> +	}
> +
> +	mask = (1 << fls(mc->max)) - 1;

Use just "max"?

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
> +	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
> +	struct tasdevice_priv *tas_dev =
> +		snd_soc_component_get_drvdata(codec);
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	unsigned int invert = mc->invert;
> +	unsigned char mask;
> +	int max = mc->max;
> +	int err_cnt = 0;
> +	int val, i, ret;
> +
> +	mask = (1 << fls(mc->max)) - 1;

Use just "max"?

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
> +	/* All the devices set error, return 0 */
> +	return (err_cnt == tas_dev->ndev) ? 0 : 1;
> +}
> +

[...]

> +static int tasdevice_create_controls(struct tasdevice_priv *tas_dev)
> +{
> +	struct snd_kcontrol_new *tasdevice_profile_controls;

Use a shorter name to keep the code below less verbose?

> +	int nr_controls = 1;
> +	int mix_index = 0;
> +	int ret;
> +	char *name;
> +
> +	tasdevice_profile_controls = devm_kzalloc(tas_dev->dev,

devm_kcalloc?

> +			nr_controls * sizeof(tasdevice_profile_controls[0]),
> +			GFP_KERNEL);
> +	if (!tasdevice_profile_controls) {
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
> +out:
> +	return ret;
> +}

[...]

> +static int tasdevice_dsp_create_control(
> +	struct tasdevice_priv *tas_dev)
> +{
> +	struct snd_kcontrol_new *tasdevice_dsp_controls;

Use a shorter name to keep the code below less verbose?

> +	char *program_name, *configuration_name;
> +	int nr_controls = 2;
> +	int mix_index = 0;
> +	int ret;
> +
> +	/* Alloc kcontrol via devm_lzalloc, which don't manually
> +	 * free the kcontrol
> +	 */
> +	tasdevice_dsp_controls = devm_kzalloc(tas_dev->dev,

devm_kcalloc?

> +		nr_controls * sizeof(tasdevice_dsp_controls[0]), GFP_KERNEL);
> +	if (!tasdevice_dsp_controls) {
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
> +out:
> +	return ret;
> +}
> +

[...]

> +static void tasdevice_tuning_switch(
> +	struct tasdevice_priv *tas_dev, int state)
> +{
> +	struct tasdevice_fw *tas_fmw = tas_dev->fmw;
> +	int profile_cfg_id = 0;
> +
> +	if (tas_dev->fw_state == TASDEVICE_DSP_FW_FAIL) {
> +		dev_err(tas_dev->dev, "DSP bin file not loaded\n");
> +		return;
> +	}
> +
> +	if (state == 0) {
> +		if (tas_dev->cur_prog >= tas_fmw->nr_programs)
> +			/*bypass all in rca is profile id 0*/
> +			profile_cfg_id = RCA_CONFIGID_BYPASS_ALL;
> +		else {
> +			/*dsp mode or tuning mode*/
> +			profile_cfg_id =
> +				tas_dev->rcabin.profile_cfg_id;

Keep these 2 lines on the line.

> +
> +			tasdevice_select_tuningprm_cfg(tas_dev,
> +				tas_dev->cur_prog,
> +				tas_dev->cur_conf,
> +				profile_cfg_id);
> +			if (tas_dev->set_global_mode)
> +				tas_dev->set_global_mode(tas_dev);
> +		}
> +
> +		tasdevice_select_cfg_blk(tas_dev, profile_cfg_id,
> +			TASDEVICE_BIN_BLK_PRE_POWER_UP);
> +	} else
> +		tasdevice_select_cfg_blk(tas_dev,
> +			tas_dev->rcabin.profile_cfg_id,
> +			TASDEVICE_BIN_BLK_PRE_SHUTDOWN);
> +}

[...]

> +static void tas2781_reset(struct tasdevice_priv *tas_dev)
> +{
> +	int ret, i;
> +
> +	if (tas_dev->reset) {
> +		gpiod_set_value_cansleep(tas_dev->reset, 0);
> +		usleep_range(500, 1000);
> +		gpiod_set_value_cansleep(tas_dev->reset, 1);
> +	} else {
> +

Uneeded blank line

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

[...]

> +int tasdevice_dev_update_bits(
> +	struct tasdevice_priv *tas_dev, enum channel chn,
> +	unsigned int reg, unsigned int mask, unsigned int value)
> +{
> +	int ret = 0;
> +
> +	if (chn < tas_dev->ndev) {

This looks like a write. Should it be <= to match other write function 
with broadcast mode? (just a guess)

> +		ret = tasdevice_change_chn_book(tas_dev, chn,
> +			TASDEVICE_BOOK_ID(reg));
> +		if (ret < 0)
> +			goto out;
> +
> +		ret = regmap_update_bits(tas_dev->regmap,
> +			TASDEVICE_PGRG(reg), mask, value);
> +		if (ret < 0)
> +			dev_err(tas_dev->dev, "%s, E=%d\n", __func__, ret);
> +	} else {
> +		dev_err(tas_dev->dev, "%s, no such channel(%d)\n",
> +			__func__, chn);
> +		ret = -EINVAL;
> +	}
> +
> +out:
> +	return ret;
> +}

[...]

