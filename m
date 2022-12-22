Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E250654578
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 18:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiLVRFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 12:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiLVRFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 12:05:45 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF563C4E;
        Thu, 22 Dec 2022 09:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671728743; x=1703264743;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xRzPPYpvZCh9imRdT6OgYxnUrsY6lkm1XcM6syklJx4=;
  b=cIxpDQ9K8fJi7ZAJjsTnodnVXctD1ZzKf+5ljDkgeHgzT5nAI1jTm2tB
   XvFaB7lqmRJeNfF47PwtNj+zj/Ts/e+BL2sKu9wQZEhUO0f4Sff+Ww1+p
   qymGVuDxs4d7Zxi8GOEQ/lyegi7TMvebtXsj0BQX5FemBfM6PYGXcdmYU
   EACASFaNJT2DydO2TrdlCIw02g6zmmd2KUNXQqZZyfvweiPcCxqVARYKB
   ikf46W6Wu6IAWtpjkfYlobJxRAAyeoGylr2qGaiSvfrYZaW+HIZP9cWGx
   1AjdRplrVIaBxDFv392tYfLIZYTKhO1+SOZcSdKPHjfH6LqfD/ECiira5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="406410669"
X-IronPort-AV: E=Sophos;i="5.96,266,1665471600"; 
   d="scan'208";a="406410669"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 09:04:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="794175713"
X-IronPort-AV: E=Sophos;i="5.96,266,1665471600"; 
   d="scan'208";a="794175713"
Received: from rpurdy-mobl.amr.corp.intel.com (HELO [10.212.42.91]) ([10.212.42.91])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 09:04:00 -0800
Message-ID: <4a0f5f9f-3d58-1a45-4d8c-f009f2af36e5@linux.intel.com>
Date:   Thu, 22 Dec 2022 09:50:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH V7 3/5] ASoC: codecs: Aw883xx common function for ALSA
 Audio Driver
Content-Language: en-US
To:     wangweidong.a@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com, ckeepax@opensource.cirrus.com,
        rf@opensource.cirrus.com, peter.ujfalusi@linux.intel.com,
        james.schulman@cirrus.com, flatmax@flatmax.com,
        ryan.lee.analog@gmail.com, jonathan.albrieux@gmail.com,
        tanureal@opensource.cirrus.com, povik+lin@cutebit.org,
        13691752556@139.com, cezary.rojewski@intel.com,
        stephan@gerhold.net, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     liweilei@awinic.com, zhaolei@awinic.com, yijiangtao@awinic.com,
        zhangjianming@awinic.com, duanyibo@awinic.com
References: <20221222123205.106353-1-wangweidong.a@awinic.com>
 <20221222123205.106353-4-wangweidong.a@awinic.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221222123205.106353-4-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int aw_dev_dsp_write_32bit(struct aw_device *aw_dev,
> +		unsigned short dsp_addr, unsigned int dsp_data)
> +{
> +	int ret;
> +	u16 temp_data = 0;

useless init

> +
> +	ret = regmap_write(aw_dev->regmap, AW_PID_2049_DSPMADD_REG, dsp_addr);
> +	if (ret < 0) {
> +		dev_err(aw_dev->dev, "%s write addr error, ret=%d", __func__, ret);
> +		return ret;
> +	}
> +
> +	temp_data = dsp_data & AW_DSP_16_DATA_MASK;
> +	ret = regmap_write(aw_dev->regmap, AW_PID_2049_DSPMDAT_REG, (u16)temp_data);
> +	if (ret < 0) {
> +		dev_err(aw_dev->dev, "%s write datal error, ret=%d", __func__, ret);
> +		return ret;
> +	}
> +
> +	temp_data = dsp_data >> 16;
> +	ret = regmap_write(aw_dev->regmap, AW_PID_2049_DSPMDAT_REG, (u16)temp_data);
> +	if (ret < 0) {
> +		dev_err(aw_dev->dev, "%s write datah error, ret=%d", __func__, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aw_dev_dsp_write(struct aw_device *aw_dev,
> +		unsigned short dsp_addr, unsigned int dsp_data, unsigned char data_type)
> +{
> +	int ret = 0;
> +	u32 reg_value;
> +
> +	mutex_lock(&aw_dev->dsp_lock);
> +	switch (data_type) {
> +	case AW_DSP_16_DATA:
> +		ret = aw_dev_dsp_write_16bit(aw_dev, dsp_addr, dsp_data);
> +		if (ret < 0)
> +			dev_err(aw_dev->dev, "write dsp_addr[0x%x] 16-bit dsp_data[0x%x] failed",
> +					(u32)dsp_addr, dsp_data);
> +		break;
> +	case AW_DSP_32_DATA:
> +		ret = aw_dev_dsp_write_32bit(aw_dev, dsp_addr, dsp_data);
> +		if (ret < 0)
> +			dev_err(aw_dev->dev, "write dsp_addr[0x%x] 32-bit dsp_data[0x%x] failed",
> +					(u32)dsp_addr, dsp_data);
> +		break;
> +	default:
> +		dev_err(aw_dev->dev, "data type[%d] unsupported", data_type);
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	/* clear dsp chip select state*/
> +	regmap_read(aw_dev->regmap, AW_PID_2049_ID_REG, &reg_value);
> +	mutex_unlock(&aw_dev->dsp_lock);
> +	return ret;
> +}
> +
> +static int aw_dev_dsp_read_16bit(struct aw_device *aw_dev,
> +		unsigned short dsp_addr, unsigned int *dsp_data)
> +{
> +	int ret;
> +	unsigned int temp_data = 0;
> +
> +	ret = regmap_write(aw_dev->regmap, AW_PID_2049_DSPMADD_REG, dsp_addr);
> +	if (ret < 0) {
> +		dev_err(aw_dev->dev, "%s write error, ret=%d", __func__, ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_read(aw_dev->regmap, AW_PID_2049_DSPMDAT_REG, &temp_data);
> +	if (ret < 0) {
> +		dev_err(aw_dev->dev, "%s read error, ret=%d", __func__, ret);
> +		return ret;
> +	}
> +
> +	*dsp_data = temp_data;
> +
> +	return 0;
> +}
> +
> +static int aw_dev_dsp_read_32bit(struct aw_device *aw_dev,
> +		unsigned short dsp_addr, unsigned int *dsp_data)
> +{
> +	int ret;
> +	unsigned int temp_data = 0;
> +
> +	ret = regmap_write(aw_dev->regmap, AW_PID_2049_DSPMADD_REG, dsp_addr);
> +	if (ret < 0) {
> +		dev_err(aw_dev->dev, "%s write error, ret=%d", __func__, ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_read(aw_dev->regmap, AW_PID_2049_DSPMDAT_REG, &temp_data);
> +	if (ret < 0) {
> +		dev_err(aw_dev->dev, "%s read error, ret=%d", __func__, ret);
> +		return ret;
> +	}
> +
> +	*dsp_data = temp_data;
> +
> +	ret = regmap_read(aw_dev->regmap, AW_PID_2049_DSPMDAT_REG, &temp_data);
> +	if (ret < 0) {
> +		dev_err(aw_dev->dev, "%s read error, ret=%d", __func__, ret);
> +		return ret;
> +	}
> +
> +	*dsp_data |= (temp_data << 16);
> +
> +	return 0;
> +}
> +
> +static int aw_dev_dsp_read(struct aw_device *aw_dev,
> +		unsigned short dsp_addr, unsigned int *dsp_data, unsigned char data_type)
> +{
> +	int ret = 0;
> +	u32 reg_value;
> +
> +	mutex_lock(&aw_dev->dsp_lock);
> +	switch (data_type) {
> +	case AW_DSP_16_DATA:
> +		ret = aw_dev_dsp_read_16bit(aw_dev, dsp_addr, dsp_data);
> +		if (ret < 0)
> +			dev_err(aw_dev->dev, "read dsp_addr[0x%x] 16-bit dsp_data[0x%x] failed",
> +					(u32)dsp_addr, *dsp_data);
> +		break;
> +	case AW_DSP_32_DATA:
> +		ret = aw_dev_dsp_read_32bit(aw_dev, dsp_addr, dsp_data);
> +		if (ret < 0)
> +			dev_err(aw_dev->dev, "read dsp_addr[0x%x] 32r-bit dsp_data[0x%x] failed",
> +					(u32)dsp_addr, *dsp_data);
> +		break;
> +	default:
> +		dev_err(aw_dev->dev, "data type[%d] unsupported", data_type);
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	/* clear dsp chip select state*/
> +	regmap_read(aw_dev->regmap, AW_PID_2049_ID_REG, &reg_value);
> +	mutex_unlock(&aw_dev->dsp_lock);
> +	return ret;
> +}
> +
> +
> +static int aw_dev_read_chipid(struct aw_device *aw_dev, u16 *chip_id)
> +{
> +	int ret = 0;

useless init

> +	int reg_val = 0;
> +
> +	ret = regmap_read(aw_dev->regmap, AW_CHIP_ID_REG, &reg_val);
> +	if (ret < 0)
> +		return -EIO;
> +
> +	dev_info(aw_dev->dev, "chip id = %x\n", reg_val);
> +	*chip_id = reg_val;
> +
> +	return 0;
> +}
> +
> +static void aw_dev_set_cfg_f0_fs(struct aw_device *aw_dev, unsigned int *f0_fs)
> +{
> +	unsigned int rate_data = 0;
> +	u32 fs = 0;
> +
> +	regmap_read(aw_dev->regmap, AW_PID_2049_I2SCTRL_REG, &rate_data);

usually you test the regmap results and here you don't, is it intentional?

> +
> +	switch (rate_data & (~AW_PID_2049_I2SSR_MASK)) {
> +	case AW_PID_2049_I2SSR_8_KHZ_VALUE:
> +		fs = 8000;
> +		break;
> +	case AW_PID_2049_I2SSR_16_KHZ_VALUE:
> +		fs = 16000;
> +		break;
> +	case AW_PID_2049_I2SSR_32_KHZ_VALUE:
> +		fs = 32000;
> +		break;
> +	case AW_PID_2049_I2SSR_44_KHZ_VALUE:
> +		fs = 44000;

did you mean 44100?

> +		break;
> +	case AW_PID_2049_I2SSR_48_KHZ_VALUE:
> +		fs = 48000;
> +		break;
> +	case AW_PID_2049_I2SSR_96_KHZ_VALUE:
> +		fs = 96000;
> +		break;
> +	case AW_PID_2049_I2SSR_192KHZ_VALUE:
> +		fs = 192000;
> +		break;
> +	default:
> +		fs = 48000;
> +		dev_err(aw_dev->dev,
> +			"rate can not support, use default 48kHz");
> +		break;
> +	}
> +
> +	dev_dbg(aw_dev->dev, "i2s fs:%d Hz", fs);
> +	*f0_fs = fs / 8;
> +
> +	aw_dev_dsp_write(aw_dev, AW_PID_2049_DSP_REG_CFGF0_FS, *f0_fs, AW_DSP_32_DATA);
> +}
> +
> +/*[9 : 6]: -6DB ; [5 : 0]: -0.125DB  real_value = value * 8 : 0.125db --> 1*/
> +static unsigned int reg_val_to_db(unsigned int value)
> +{
> +	return (((value >> AW_PID_2049_VOL_6DB_START) * AW_PID_2049_VOLUME_STEP_DB) +
> +			((value & 0x3f) % AW_PID_2049_VOLUME_STEP_DB));
> +}
> +
> +/*[9 : 6]: -6DB ; [5 : 0]: -0.125DB reg_value = value / step << 6 + value % step ; step = 6 * 8*/
> +static unsigned short db_to_reg_val(unsigned short value)
> +{
> +	return (((value / AW_PID_2049_VOLUME_STEP_DB) << AW_PID_2049_VOL_6DB_START) +
> +			(value % AW_PID_2049_VOLUME_STEP_DB));
> +}
> +
> +static int aw_dev_dsp_fw_check(struct aw_device *aw_dev)
> +{
> +	struct aw_prof_desc *set_prof_desc = NULL;
> +	struct aw_sec_data_desc *dsp_fw_desc = NULL;
> +	u16 base_addr = AW_PID_2049_DSP_FW_ADDR;
> +	u16 addr = base_addr;
> +	int ret, i;
> +	u32 dsp_val;
> +	u16 bin_val;
> +
> +	ret = aw883xx_dev_get_prof_data(aw_dev, aw_dev->prof_cur, &set_prof_desc);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*update reg*/
> +	dsp_fw_desc = &set_prof_desc->sec_desc[AW_DATA_TYPE_DSP_FW];
> +
> +	for (i = 0; i < AW_FW_CHECK_PART; i++) {
> +		ret = aw_dev_dsp_read(aw_dev, addr, &dsp_val, AW_DSP_16_DATA);
> +		if (ret  < 0) {
> +			dev_err(aw_dev->dev, "dsp read failed");
> +			return ret;
> +		}
> +
> +		bin_val = be16_to_cpup((void *)&dsp_fw_desc->data[2 * (addr - base_addr)]);
> +
> +		if (dsp_val != bin_val) {
> +			dev_err(aw_dev->dev, "fw check failed, addr[0x%x], read[0x%x] != bindata[0x%x]",
> +					addr, dsp_val, bin_val);
> +			return -EINVAL;
> +		}
> +
> +		addr += (dsp_fw_desc->len / 2) / AW_FW_CHECK_PART;
> +		if ((addr - base_addr) > dsp_fw_desc->len) {
> +			dev_err(aw_dev->dev, "fw check failed, addr[0x%x] too large", addr);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int aw_dev_set_volume(struct aw_device *aw_dev, unsigned int value)
> +{
> +	struct aw_volume_desc *vol_desc = &aw_dev->volume_desc;
> +	unsigned int reg_value = 0;
> +	u16 real_value = 0;
> +	u16 volume = 0;
> +
> +	volume = min((value + vol_desc->init_volume), (unsigned int)AW_PID_2049_MUTE_VOL);
> +	real_value = db_to_reg_val(volume);
> +
> +	/* cal real value */
> +	regmap_read(aw_dev->regmap, AW_PID_2049_SYSCTRL2_REG, &reg_value);
> +
> +	dev_dbg(aw_dev->dev, "value 0x%x , reg:0x%x", value, real_value);
> +
> +	/*[15 : 6] volume*/
> +	real_value = (real_value << AW_PID_2049_VOL_START_BIT) | (reg_value & AW_PID_2049_VOL_MASK);
> +
> +	/* write value */
> +	regmap_write(aw_dev->regmap, AW_PID_2049_SYSCTRL2_REG, real_value);
> +
> +	return 0;
> +}
> +
> +void aw883xx_dev_set_volume(struct aw_device *aw_dev, unsigned short set_vol)
> +{
> +	int ret = 0;
> +
> +	ret = aw_dev_set_volume(aw_dev, set_vol);
> +	if (ret < 0)
> +		dev_dbg(aw_dev->dev, "set volume failed");
> +}
> +EXPORT_SYMBOL_GPL(aw883xx_dev_set_volume);
> +
> +static void aw_dev_fade_in(struct aw_device *aw_dev)
> +{
> +	int i = 0;

useless init

> +	struct aw_volume_desc *desc = &aw_dev->volume_desc;
> +	int fade_step = aw_dev->fade_step;
> +	u16 fade_in_vol = desc->ctl_volume;
> +
> +	if (!aw_dev->fade_en)
> +		return;
> +
> +	if (fade_step == 0 || aw_dev->fade_in_time == 0) {
> +		aw_dev_set_volume(aw_dev, fade_in_vol);
> +		return;
> +	}
> +	/*volume up*/
> +	for (i = AW_PID_2049_MUTE_VOL; i >= fade_in_vol; i -= fade_step) {
> +		aw_dev_set_volume(aw_dev, i);
> +		usleep_range(aw_dev->fade_in_time, aw_dev->fade_in_time + 10);
> +	}
> +	if (i != fade_in_vol)
> +		aw_dev_set_volume(aw_dev, fade_in_vol);
> +}
> +
> +static void aw_dev_fade_out(struct aw_device *aw_dev)
> +{
> +	int i = 0;

useless init

> +	struct aw_volume_desc *desc = &aw_dev->volume_desc;
> +	int fade_step = aw_dev->fade_step;
> +
> +	if (!aw_dev->fade_en)
> +		return;
> +
> +	if (fade_step == 0 || aw_dev->fade_out_time == 0) {
> +		aw_dev_set_volume(aw_dev, AW_PID_2049_MUTE_VOL);
> +		return;
> +	}
> +
> +	for (i = desc->ctl_volume; i <= AW_PID_2049_MUTE_VOL; i += fade_step) {
> +		aw_dev_set_volume(aw_dev, i);
> +		usleep_range(aw_dev->fade_out_time, aw_dev->fade_out_time + 10);
> +	}
> +	if (i != AW_PID_2049_MUTE_VOL) {
> +		aw_dev_set_volume(aw_dev, AW_PID_2049_MUTE_VOL);
> +		usleep_range(aw_dev->fade_out_time, aw_dev->fade_out_time + 10);
> +	}
> +}
> +
> +static int aw_dev_modify_dsp_cfg(struct aw_device *aw_dev,
> +			unsigned int addr, unsigned int dsp_data, unsigned char data_type)
> +{
> +	u32 addr_offset = 0;

useless init

> +	u16 data1 = 0;
> +	u32 data2 = 0;

useless init and could be moved to lower scopes

> +	struct aw_sec_data_desc *crc_dsp_cfg = &aw_dev->crc_dsp_cfg;
> +
> +	dev_dbg(aw_dev->dev, "addr:0x%x, dsp_data:0x%x", addr, dsp_data);
> +
> +	addr_offset = (addr - AW_PID_2049_DSP_CFG_ADDR) * 2;
> +	if (addr_offset > crc_dsp_cfg->len) {
> +		dev_err(aw_dev->dev, "addr_offset[%d] > crc_dsp_cfg->len[%d]",
> +				addr_offset, crc_dsp_cfg->len);
> +		return -EINVAL;
> +	}
> +	switch (data_type) {
> +	case AW_DSP_16_DATA:
> +		data1 = cpu_to_le16((u16)dsp_data);
> +		memcpy(crc_dsp_cfg->data + addr_offset, (u8 *)&data1, 2);
> +		break;
> +	case AW_DSP_32_DATA:
> +		data2 = cpu_to_le32(dsp_data);
> +		memcpy(crc_dsp_cfg->data + addr_offset, (u8 *)&data2, 4);
> +		break;
> +	default:
> +		dev_err(aw_dev->dev, "data type[%d] unsupported", data_type);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aw_dev_dsp_set_cali_re(struct aw_device *aw_dev)
> +{
> +	u32 cali_re = 0;
> +	int ret = 0;

useless inits

> +
> +	cali_re = AW_SHOW_RE_TO_DSP_RE((aw_dev->cali_desc.cali_re +
> +		aw_dev->cali_desc.ra), AW_PID_2049_DSP_RE_SHIFT);
> +
> +	/* set cali re to device */
> +	ret = aw_dev_dsp_write(aw_dev,
> +			AW_PID_2049_DSP_REG_CFG_ADPZ_RE, cali_re, AW_DSP_32_DATA);
> +	if (ret < 0) {
> +		dev_err(aw_dev->dev, "set cali re error");
> +		return ret;
> +	}
> +
> +	ret = aw_dev_modify_dsp_cfg(aw_dev, AW_PID_2049_DSP_REG_CFG_ADPZ_RE,
> +				cali_re, AW_DSP_32_DATA);
> +	if (ret < 0)
> +		dev_err(aw_dev->dev, "modify dsp cfg failed");
> +
> +	return ret;
> +
> +}

this file needs style fixes, stopping the review here.

