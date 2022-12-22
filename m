Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5890654577
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 18:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiLVRFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 12:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiLVRFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 12:05:44 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1BA1D7;
        Thu, 22 Dec 2022 09:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671728741; x=1703264741;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R1dcTJRKAkRkFO9IQGGLvWwZrnd6/GZc7oUvy1vjCwg=;
  b=Ftlz8GX2kis6zgWeub+7GGHMnqT8hdV0sJi6Go3WJ0iOonCdbttmYJsu
   8y58x8oltZaw8G9KDEtGWXHK++w1bnrrlPp0fhQzL8hqVfS2lRhN86+lb
   EQl8mypJIzNbixFM5bGoDsqcNLjzd+qNeyWgSePiWjea8ob5fDn8CnZJq
   dt+JgiR3k3A7QiFoo0HiGgORqeCksoTRqWyg2PkpJcmSoWhFu3S7Z2EnP
   pMXEXmGuOobkD0LVbFixs6IvdkE//3xk+xWwuPV5JG0JZiBD5HOgFSjPq
   rZ1a1lMSejzw4XBnOIaoE95oQGhlz+4gLHt9Kdc9BwF7u0Dk5kK58oXsN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="406410642"
X-IronPort-AV: E=Sophos;i="5.96,266,1665471600"; 
   d="scan'208";a="406410642"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 09:04:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="794175667"
X-IronPort-AV: E=Sophos;i="5.96,266,1665471600"; 
   d="scan'208";a="794175667"
Received: from rpurdy-mobl.amr.corp.intel.com (HELO [10.212.42.91]) ([10.212.42.91])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 09:03:58 -0800
Message-ID: <b30d2315-5f4d-e879-edbc-8550b08453f4@linux.intel.com>
Date:   Thu, 22 Dec 2022 09:41:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH V7 2/5] ASoC: codecs: Aw883xx function for ACF file parse
 and check
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
 <20221222123205.106353-3-wangweidong.a@awinic.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221222123205.106353-3-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int aw_check_sum(struct aw_bin *bin, int bin_num)
> +{
> +	unsigned int i = 0;

useless init

> +	unsigned int sum_data = 0;

this init is required

> +	unsigned int check_sum = 0;

useless init

> +	unsigned char *p_check_sum = NULL;

useless init

> +
> +	p_check_sum = &(bin->info.data[(bin->header_info[bin_num].valid_data_addr -
> +						bin->header_info[bin_num].header_len)]);
> +
> +	check_sum = le32_to_cpup((void *)p_check_sum);
> +
> +	for (i = 4; i < bin->header_info[bin_num].bin_data_len +
> +					bin->header_info[bin_num].header_len; i++) {
> +		sum_data += *(p_check_sum + i);
> +	}
> +	pr_debug("%s -- check_sum = %p, bin_num = %d, check_sum = 0x%x, sum_data = 0x%x",
> +					__func__, p_check_sum, bin_num, check_sum, sum_data);

can you avoid using pr_ functions please?

> +	if (sum_data != check_sum) {
> +		pr_err("%s. CheckSum Fail.bin_num=%d, CheckSum:0x%x, SumData:0x%x",
> +				__func__, bin_num, check_sum, sum_data);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aw_check_data_version(struct aw_bin *bin, int bin_num)
> +{
> +	if (bin->header_info[bin_num].bin_data_ver < DATA_VERSION_V1 ||
> +		bin->header_info[bin_num].bin_data_ver > DATA_VERSION_MAX) {
> +		pr_err("aw_bin_parse Unrecognized this bin data version\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aw_check_register_num_v1(struct aw_bin *bin, int bin_num)
> +{
> +	unsigned int check_register_num = 0;
> +	unsigned int parse_register_num = 0;
> +	unsigned char *p_check_sum = NULL;

useless inits

> +	struct bin_header_info temp_info;
> +
> +	temp_info = bin->header_info[bin_num];
> +	p_check_sum = &(bin->info.data[(temp_info.valid_data_addr)]);
> +
> +	parse_register_num = le32_to_cpup((void *)p_check_sum);
> +	check_register_num = (bin->header_info[bin_num].bin_data_len - 4) /
> +				(bin->header_info[bin_num].reg_byte_len +
> +				bin->header_info[bin_num].data_byte_len);
> +	pr_debug("%s bin_num = %d,parse_register_num = 0x%x,check_register_num = 0x%x\n",
> +				__func__, bin_num, parse_register_num, check_register_num);
> +	if (parse_register_num != check_register_num) {
> +		pr_err("%s bin_num = %d,parse_register_num = 0x%x,check_register_num = 0x%x\n",
> +				__func__, bin_num, parse_register_num, check_register_num);
> +
> +		return -EINVAL;
> +	}
> +
> +	bin->header_info[bin_num].reg_num = parse_register_num;
> +	bin->header_info[bin_num].valid_data_len = temp_info.bin_data_len - 4;
> +	bin->header_info[bin_num].valid_data_addr = temp_info.valid_data_addr + 4;
> +
> +	return 0;
> +}
> +
> +static int aw_check_dsp_reg_num_v1(struct aw_bin *bin, int bin_num)
> +{
> +	unsigned int check_dsp_reg_num = 0;
> +	unsigned int parse_dsp_reg_num = 0;
> +	unsigned char *p_check_sum = NULL;

useless inits

> +	struct bin_header_info temp_info;
> +
> +	temp_info = bin->header_info[bin_num];
> +	p_check_sum = &(bin->info.data[(temp_info.valid_data_addr)]);
> +
> +	parse_dsp_reg_num = le32_to_cpup((void *)(p_check_sum + 4));
> +	bin->header_info[bin_num].reg_data_byte_len =
> +			le32_to_cpup((void *)(p_check_sum + 8));
> +	check_dsp_reg_num = (bin->header_info[bin_num].bin_data_len - 12) /
> +				bin->header_info[bin_num].reg_data_byte_len;
> +	pr_debug("%s bin_num = %d, parse_dsp_reg_num = 0x%x, check_dsp_reg_num = 0x%x",
> +					__func__, bin_num, check_dsp_reg_num, check_dsp_reg_num);
> +	if (parse_dsp_reg_num != check_dsp_reg_num) {
> +		pr_err("aw_bin_parse check dsp reg num error\n");
> +		pr_err("%s bin_num = %d, parse_dsp_reg_num = 0x%x, check_dsp_reg_num = 0x%x",
> +					__func__, bin_num, check_dsp_reg_num, check_dsp_reg_num);
> +		return -EINVAL;
> +	}
> +
> +	bin->header_info[bin_num].download_addr = le32_to_cpup((void *)p_check_sum);
> +	bin->header_info[bin_num].reg_num = parse_dsp_reg_num;
> +	bin->header_info[bin_num].valid_data_len = temp_info.bin_data_len - 12;
> +	bin->header_info[bin_num].valid_data_addr = temp_info.valid_data_addr + 12;
> +
> +	return 0;
> +}
> +
> +static int aw_check_soc_app_num_v1(struct aw_bin *bin, int bin_num)
> +{
> +	unsigned int check_soc_app_num = 0;
> +	unsigned int parse_soc_app_num = 0;
> +	unsigned char *p_check_sum = NULL;
> +	struct bin_header_info temp_info;
> +
> +	temp_info = bin->header_info[bin_num];
> +	p_check_sum = &(bin->info.data[(temp_info.valid_data_addr)]);
> +
> +	bin->header_info[bin_num].app_version = le32_to_cpup((void *)p_check_sum);
> +	parse_soc_app_num = le32_to_cpup((void *)(p_check_sum + 8));
> +	check_soc_app_num = bin->header_info[bin_num].bin_data_len - 12;
> +	pr_debug("%s bin_num = %d, parse_soc_app_num=0x%x, check_soc_app_num = 0x%x\n",
> +					__func__, bin_num, parse_soc_app_num, check_soc_app_num);
> +	if (parse_soc_app_num != check_soc_app_num) {
> +		pr_err("%s failed bin_num = %d, parse_soc_app_num=0x%x, check_soc_app_num = 0x%x\n",
> +					__func__, bin_num, parse_soc_app_num, check_soc_app_num);
> +
> +		return -EINVAL;
> +	}
> +
> +	bin->header_info[bin_num].reg_num = parse_soc_app_num;
> +	bin->header_info[bin_num].download_addr = le32_to_cpup((void *)(p_check_sum + 4));
> +	bin->header_info[bin_num].valid_data_len = temp_info.bin_data_len - 12;
> +	bin->header_info[bin_num].valid_data_addr = temp_info.valid_data_addr + 12;
> +
> +	return 0;
> +}
> +
> +/*
> + * bin header 1_0_0
> + */
> +static void aw_get_single_bin_header_1_0_0(struct aw_bin *bin)
> +{
> +	int i = 0;

useless init

> +
> +	bin->header_info[bin->all_bin_parse_num].header_len = HEADER_LEN;
> +	bin->header_info[bin->all_bin_parse_num].check_sum =
> +				le32_to_cpup((void *)(bin->p_addr) + CHECK_SUM_OFFSET);
> +	bin->header_info[bin->all_bin_parse_num].header_ver =
> +				le32_to_cpup((void *)(bin->p_addr + HEADER_VER_OFFSET));
> +	bin->header_info[bin->all_bin_parse_num].bin_data_type =
> +				le32_to_cpup((void *)(bin->p_addr + BIN_DATA_TYPE_OFFSET));
> +	bin->header_info[bin->all_bin_parse_num].bin_data_ver =
> +				le32_to_cpup((void *)(bin->p_addr + BIN_DATA_VER_OFFSET));
> +	bin->header_info[bin->all_bin_parse_num].bin_data_len =
> +				le32_to_cpup((void *)(bin->p_addr + BIN_DATA_LEN_OFFSET));
> +	bin->header_info[bin->all_bin_parse_num].ui_ver =
> +				le32_to_cpup((void *)(bin->p_addr + UI_VER_OFFSET));
> +	bin->header_info[bin->all_bin_parse_num].reg_byte_len =
> +				le32_to_cpup((void *)(bin->p_addr + REG_BYTE_LEN_OFFSET));
> +	bin->header_info[bin->all_bin_parse_num].data_byte_len =
> +				le32_to_cpup((void *)(bin->p_addr + DATA_BYTE_LEN_OFFSET));
> +	bin->header_info[bin->all_bin_parse_num].device_addr =
> +				le32_to_cpup((void *)(bin->p_addr + DEVICE_ADDR_OFFSET));
> +	for (i = 0; i < 8; i++)
> +		bin->header_info[bin->all_bin_parse_num].chip_type[i] = *(bin->p_addr + 24 + i);
> +
> +	bin->header_info[bin->all_bin_parse_num].reg_num = 0x00000000;
> +	bin->header_info[bin->all_bin_parse_num].reg_data_byte_len = 0x00000000;
> +	bin->header_info[bin->all_bin_parse_num].download_addr = 0x00000000;
> +	bin->header_info[bin->all_bin_parse_num].app_version = 0x00000000;
> +	bin->header_info[bin->all_bin_parse_num].valid_data_len = 0x00000000;
> +	bin->all_bin_parse_num += 1;
> +}
> +
> +static int aw_parse_one_of_multi_bins_1_0_0(unsigned int bin_num, int bin_serial_num,
> +				      struct aw_bin *bin)
> +{
> +	int ret = 0;

useless init

> +	unsigned int bin_start_addr = 0;

useless init and could be declared at a lower scope

> +	unsigned int valid_data_len = 0;

useless init and could be declared at a lower scope

> +	struct bin_header_info aw_bin_header_info;
> +
> +	if (bin->info.len < sizeof(struct bin_header_info)) {
> +		pr_err("bin_header_info size[%d] overflow file size[%d]\n",
> +				(int)sizeof(struct bin_header_info), bin->info.len);
> +		return -EINVAL;
> +	}
> +
> +	aw_bin_header_info = bin->header_info[bin->all_bin_parse_num - 1];
> +	if (!bin_serial_num) {
> +		bin_start_addr = le32_to_cpup((void *)(bin->p_addr + START_ADDR_OFFSET));
> +		bin->p_addr += (HEADER_LEN + bin_start_addr);
> +		bin->header_info[bin->all_bin_parse_num].valid_data_addr =
> +			aw_bin_header_info.valid_data_addr + 4 + 8 * bin_num + 60;
> +	} else {
> +		valid_data_len = aw_bin_header_info.bin_data_len;
> +		bin->p_addr += (HDADER_LEN + valid_data_len);
> +		bin->header_info[bin->all_bin_parse_num].valid_data_addr =
> +		    aw_bin_header_info.valid_data_addr + aw_bin_header_info.bin_data_len + 60;
> +	}
> +
> +	ret = aw_parse_bin_header_1_0_0(bin);
> +
> +	return ret;

return aw_parse_bin_header_1_0_0(bin);

> +}
> +
> +/* Getaw_parse_bin_header_1_0_0(bin); the number of bins in multi bins, and set a for loop,
> + * loop processing each bin data
> + */
> +static int aw_get_multi_bin_header_1_0_0(struct aw_bin *bin)
> +{
> +	int i = 0;
> +	int ret = 0;
> +	unsigned int bin_num = 0;

useless inits

> +	bin_num = le32_to_cpup((void *)(bin->p_addr + 60));

what is 60? Use define please

> +	if (bin->multi_bin_parse_num == 1)
> +		bin->header_info[bin->all_bin_parse_num].valid_data_addr =
> +							VALID_DATA_ADDR_OFFSET;
> +
> +	aw_get_single_bin_header_1_0_0(bin);
> +
> +	for (i = 0; i < bin_num; i++) {
> +		pr_debug("aw_bin_parse enter multi bin for is %d\n", i);
> +		ret = aw_parse_one_of_multi_bins_1_0_0(bin_num, i, bin);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * If the bin framework header version is 1.0.0,
> + * Parse the bin file according to the data type.If it is a single bin data type,
> + * write the data directly into the structure array. If it is a multi-bin data type,
> + * first obtain the number of bins, and then recursively call the bin frame header
> + * to process.
> + */
> +static int aw_parse_bin_header_1_0_0(struct aw_bin *bin)
> +{
> +	int ret = 0;

useless init

> +	unsigned int bin_data_type;
> +
> +	if (bin->info.len < sizeof(struct bin_header_info)) {
> +		pr_err("bin_header_info size[%d] overflow file size[%d]\n",
> +				(int)sizeof(struct bin_header_info), bin->info.len);
> +		return -EINVAL;
> +	}
> +
> +	bin_data_type = le32_to_cpup((void *)(bin->p_addr + BIN_DATA_TYPE_OFFSET));
> +	pr_debug("aw_bin_parse bin_data_type 0x%x\n", bin_data_type);
> +	switch (bin_data_type) {
> +	case DATA_TYPE_REGISTER:
> +	case DATA_TYPE_DSP_REG:
> +	case DATA_TYPE_SOC_APP:
> +		/* Divided into two processing methods,
> +		 * one is single bin processing,
> +		 * and the other is single bin processing in multi bin
> +		 */
> +		bin->single_bin_parse_num += 1;
> +		pr_debug("%s bin->single_bin_parse_num is %d\n", __func__,
> +						bin->single_bin_parse_num);
> +		if (!bin->multi_bin_parse_num)
> +			bin->header_info[bin->all_bin_parse_num].valid_data_addr =
> +								VALID_DATA_ADDR_OFFSET;
> +		aw_get_single_bin_header_1_0_0(bin);
> +		break;
> +	case DATA_TYPE_MULTI_BINS:
> +		/* Get the number of times to enter multi bins */
> +		bin->multi_bin_parse_num += 1;
> +		pr_debug("%s bin->multi_bin_parse_num is %d\n", __func__,
> +						bin->multi_bin_parse_num);
> +	ret = aw_get_multi_bin_header_1_0_0(bin);

indentation is off

> +		if (ret < 0)
> +			return ret;
> +		break;
> +	default:
> +		pr_debug("%s There is no corresponding type\n", __func__);
> +		break;
> +	}
> +	return 0;
> +}
> +
> +/* get the bin's header version */
> +static int aw_check_bin_header_version(struct aw_bin *bin)
> +{
> +	int ret = 0;
> +	unsigned int header_version = 0;

useless inits

> +
> +	header_version = le32_to_cpup((void *)(bin->p_addr + 4));
> +	pr_debug("aw_bin_parse header_version 0x%x\n", header_version);
> +	/* Write data to the corresponding structure array
> +	 * according to different formats of the bin frame header version
> +	 */
> +	switch (header_version) {
> +	case HEADER_VERSION_1_0_0:
> +		ret = aw_parse_bin_header_1_0_0(bin);
> +		return ret;
> +	default:
> +		pr_err("aw_bin_parse Unrecognized this bin header version\n");
> +		return -EINVAL;
> +	}
> +}
> +
> +static int aw_parsing_bin_file(struct aw_bin *bin)
> +{
> +	int i = 0;
> +	int ret = 0;

useless inits

> +
> +	if (!bin) {
> +		pr_err("aw_bin_parse bin is NULL\n");
> +		return -EINVAL;
> +	}
> +	bin->p_addr = bin->info.data;
> +	bin->all_bin_parse_num = 0;
> +	bin->multi_bin_parse_num = 0;
> +	bin->single_bin_parse_num = 0;
> +
> +	/* filling bins header info */
> +	ret = aw_check_bin_header_version(bin);
> +	if (ret < 0) {
> +		pr_err("aw_bin_parse check bin header version error\n");
> +		return ret;
> +	}
> +
> +	/* check bin header info */
> +	for (i = 0; i < bin->all_bin_parse_num; i++) {
> +		/* check sum */
> +		ret = aw_check_sum(bin, i);
> +		if (ret < 0) {
> +			pr_err("aw_bin_parse check sum data error\n");
> +			return ret;
> +		}
> +		/* check bin data version */
> +		ret = aw_check_data_version(bin, i);
> +		if (ret < 0) {
> +			pr_err("aw_bin_parse check data version error\n");
> +			return ret;
> +		}
> +		/* check valid data */
> +		if (bin->header_info[i].bin_data_ver == DATA_VERSION_V1) {
> +			/* check register num */
> +			switch (bin->header_info[i].bin_data_type) {
> +			case DATA_TYPE_REGISTER:
> +				ret = aw_check_register_num_v1(bin, i);
> +				break;
> +			case DATA_TYPE_DSP_REG:
> +				ret = aw_check_dsp_reg_num_v1(bin, i);
> +				break;
> +			case DATA_TYPE_SOC_APP:
> +				ret = aw_check_soc_app_num_v1(bin, i);
> +				break;
> +			default:
> +				bin->header_info[i].valid_data_len =
> +						bin->header_info[i].bin_data_len;
> +				ret = 0;
> +				break;
> +			}
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}

> +static int aw_dev_prof_parse_multi_bin(unsigned char *data, unsigned int data_len,
> +		struct aw_prof_desc *prof_desc)
> +{
> +	struct aw_bin *aw_bin = NULL;

useless init

> +	int i;
> +	int ret;
> +
> +	aw_bin = kzalloc(data_len + sizeof(struct aw_bin), GFP_KERNEL);
> +	if (!aw_bin)
> +		return -ENOMEM;
> +
> +	aw_bin->info.len = data_len;
> +	memcpy(aw_bin->info.data, data, data_len);
> +
> +	ret = aw_parsing_bin_file(aw_bin);
> +	if (ret < 0) {
> +		pr_err("parse bin failed");
> +		goto parse_bin_failed;
> +	}
> +
> +	for (i = 0; i < aw_bin->all_bin_parse_num; i++) {
> +		switch (aw_bin->header_info[i].bin_data_type) {
> +		case DATA_TYPE_REGISTER:
> +			prof_desc->sec_desc[AW_DATA_TYPE_REG].len =
> +					aw_bin->header_info[i].valid_data_len;
> +			prof_desc->sec_desc[AW_DATA_TYPE_REG].data =
> +					data + aw_bin->header_info[i].valid_data_addr;
> +			break;
> +		case DATA_TYPE_DSP_REG:
> +			if (aw_bin->header_info[i].valid_data_len & 0x01) {
> +				ret = -EINVAL;
> +				goto parse_bin_failed;
> +			}
> +
> +			swab16_array(
> +					(u16 *)data + aw_bin->header_info[i].valid_data_addr,
> +					aw_bin->header_info[i].valid_data_len >> 1);

fix indentation

> +
> +			prof_desc->sec_desc[AW_DATA_TYPE_DSP_CFG].len =
> +					aw_bin->header_info[i].valid_data_len;
> +			prof_desc->sec_desc[AW_DATA_TYPE_DSP_CFG].data =
> +					data + aw_bin->header_info[i].valid_data_addr;
> +			break;
> +		case DATA_TYPE_DSP_FW:
> +			if (aw_bin->header_info[i].valid_data_len & 0x01) {
> +				ret = -EINVAL;
> +				goto parse_bin_failed;
> +			}
> +
> +			swab16_array(
> +					(u16 *)data + aw_bin->header_info[i].valid_data_addr,
> +					aw_bin->header_info[i].valid_data_len >> 1);

fix indentation

> +
> +			prof_desc->fw_ver = aw_bin->header_info[i].app_version;
> +			prof_desc->sec_desc[AW_DATA_TYPE_DSP_FW].len =
> +					aw_bin->header_info[i].valid_data_len;
> +			prof_desc->sec_desc[AW_DATA_TYPE_DSP_FW].data =
> +					data + aw_bin->header_info[i].valid_data_addr;
> +			break;
> +		default:
> +			pr_debug("bin_data_type not found");
> +			break;
> +		}
> +	}
> +	prof_desc->prof_st = AW_PROFILE_OK;
> +	ret =  0;
> +
> +parse_bin_failed:
> +	kfree(aw_bin);
> +	aw_bin = NULL;

assignment not needed

> +	return ret;
> +}
> +
> +static int aw_dev_parse_data_by_sec_type(struct aw_cfg_hdr *cfg_hdr,
> +			struct aw_cfg_dde *cfg_dde, struct aw_prof_desc *scene_prof_desc)
> +{
> +	switch (cfg_dde->data_type) {
> +	case ACF_SEC_TYPE_REG:
> +		return aw_dev_parse_raw_reg((u8 *)cfg_hdr + cfg_dde->data_offset,
> +				cfg_dde->data_size, scene_prof_desc);
> +	case ACF_SEC_TYPE_DSP_CFG:
> +		return aw_dev_parse_raw_dsp_cfg((u8 *)cfg_hdr + cfg_dde->data_offset,
> +				cfg_dde->data_size, scene_prof_desc);
> +	case ACF_SEC_TYPE_DSP_FW:
> +		return aw_dev_parse_raw_dsp_fw(
> +				(u8 *)cfg_hdr + cfg_dde->data_offset,
> +				cfg_dde->data_size, scene_prof_desc);
> +	case ACF_SEC_TYPE_MUTLBIN:
> +		return aw_dev_prof_parse_multi_bin(
> +				(u8 *)cfg_hdr + cfg_dde->data_offset,
> +				cfg_dde->data_size, scene_prof_desc);
> +	default:
> +		pr_err("%s cfg_dde->data_type = %d\n", __func__, cfg_dde->data_type);
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static int aw_dev_parse_dev_type(struct aw_device *aw_dev,
> +		struct aw_cfg_hdr *prof_hdr, struct aw_all_prof_info *all_prof_info)
> +{
> +	int i = 0;

useless init

> +	int ret;
> +	int sec_num = 0;

init required!

> +	struct aw_cfg_dde *cfg_dde =
> +		(struct aw_cfg_dde *)((char *)prof_hdr + prof_hdr->a_hdr_offset);
> +
> +	for (i = 0; i < prof_hdr->a_ddt_num; i++) {
> +		if ((aw_dev->i2c->adapter->nr == cfg_dde[i].dev_bus) &&
> +		    (aw_dev->i2c->addr == cfg_dde[i].dev_addr) &&
> +		    (cfg_dde[i].type == AW_DEV_TYPE_ID) &&
> +		    (cfg_dde[i].data_type != ACF_SEC_TYPE_MONITOR)) {
> +			if (cfg_dde[i].dev_profile >= AW_PROFILE_MAX) {
> +				dev_err(aw_dev->dev, "dev_profile [%d] overflow",
> +							cfg_dde[i].dev_profile);
> +				return -EINVAL;
> +			}
> +
> +			ret = aw_dev_parse_data_by_sec_type(prof_hdr, &cfg_dde[i],
> +					&all_prof_info->prof_desc[cfg_dde[i].dev_profile]);
> +			if (ret < 0) {
> +				dev_err(aw_dev->dev, "parse failed");
> +				return ret;
> +			}
> +			sec_num++;
> +		}
> +	}
> +
> +	if (sec_num == 0) {
> +		dev_dbg(aw_dev->dev, "get dev type num is %d, please use default", sec_num);
> +		return AW_DEV_TYPE_NONE;
> +	}
> +
> +	return AW_DEV_TYPE_OK;
> +}
> +
> +static int aw_dev_parse_dev_default_type(struct aw_device *aw_dev,
> +		struct aw_cfg_hdr *prof_hdr, struct aw_all_prof_info *all_prof_info)
> +{
> +	int i = 0;

useless init

> +	int ret;
> +	int sec_num = 0;
> +	struct aw_cfg_dde *cfg_dde =
> +		(struct aw_cfg_dde *)((char *)prof_hdr + prof_hdr->a_hdr_offset);
> +
> +	for (i = 0; i < prof_hdr->a_ddt_num; i++) {
> +		if ((aw_dev->channel == cfg_dde[i].dev_index) &&
> +			(cfg_dde[i].type == AW_DEV_DEFAULT_TYPE_ID) &&
> +			(cfg_dde[i].data_type != ACF_SEC_TYPE_MONITOR)) {
> +			if (cfg_dde[i].dev_profile >= AW_PROFILE_MAX) {
> +				dev_err(aw_dev->dev, "dev_profile [%d] overflow",
> +					cfg_dde[i].dev_profile);
> +				return -EINVAL;
> +			}
> +			ret = aw_dev_parse_data_by_sec_type(prof_hdr, &cfg_dde[i],
> +					&all_prof_info->prof_desc[cfg_dde[i].dev_profile]);
> +			if (ret < 0) {
> +				dev_err(aw_dev->dev, "parse failed");
> +				return ret;
> +			}
> +			sec_num++;
> +		}
> +	}
> +
> +	if (sec_num == 0) {
> +		dev_err(aw_dev->dev, "get dev default type failed, get num[%d]", sec_num);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aw_dev_cfg_get_vaild_prof(struct aw_device *aw_dev,

typo: valid

> +				struct aw_all_prof_info all_prof_info)
> +{
> +	int i;
> +	int num = 0;
> +	struct aw_sec_data_desc *sec_desc = NULL;
> +	struct aw_prof_desc *prof_desc = all_prof_info.prof_desc;
> +	struct aw_prof_info *prof_info = &aw_dev->prof_info;
> +
> +	for (i = 0; i < AW_PROFILE_MAX; i++) {
> +		if (prof_desc[i].prof_st == AW_PROFILE_OK) {
> +			sec_desc = prof_desc[i].sec_desc;
> +			if ((sec_desc[AW_DATA_TYPE_REG].data != NULL) &&
> +			    (sec_desc[AW_DATA_TYPE_REG].len != 0) &&
> +			    (sec_desc[AW_DATA_TYPE_DSP_CFG].data != NULL) &&
> +			    (sec_desc[AW_DATA_TYPE_DSP_CFG].len != 0) &&
> +			    (sec_desc[AW_DATA_TYPE_DSP_FW].data != NULL) &&
> +			    (sec_desc[AW_DATA_TYPE_DSP_FW].len != 0)) {
> +				prof_info->count++;
> +			}
> +		}
> +	}
> +
> +	dev_dbg(aw_dev->dev, "get valid profile:%d", aw_dev->prof_info.count);
> +
> +	if (!prof_info->count) {
> +		dev_err(aw_dev->dev, "no profile data");
> +		return -EPERM;
> +	}
> +
> +	prof_info->prof_desc = devm_kcalloc(aw_dev->dev,
> +					prof_info->count, sizeof(struct aw_prof_desc),
> +					GFP_KERNEL);
> +	if (!prof_info->prof_desc)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < AW_PROFILE_MAX; i++) {
> +		if (prof_desc[i].prof_st == AW_PROFILE_OK) {
> +			sec_desc = prof_desc[i].sec_desc;
> +			if ((sec_desc[AW_DATA_TYPE_REG].data != NULL) &&
> +			    (sec_desc[AW_DATA_TYPE_REG].len != 0) &&
> +			    (sec_desc[AW_DATA_TYPE_DSP_CFG].data != NULL) &&
> +			    (sec_desc[AW_DATA_TYPE_DSP_CFG].len != 0) &&
> +			    (sec_desc[AW_DATA_TYPE_DSP_FW].data != NULL) &&
> +			    (sec_desc[AW_DATA_TYPE_DSP_FW].len != 0)) {
> +				if (num >= prof_info->count) {
> +					dev_err(aw_dev->dev, "get scene num[%d] overflow count[%d]",
> +						num, prof_info->count);
> +					return -EINVAL;
> +				}
> +				prof_info->prof_desc[num] = prof_desc[i];
> +				prof_info->prof_desc[num].id = i;
> +				num++;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int aw_dev_load_cfg_by_hdr(struct aw_device *aw_dev,
> +		struct aw_cfg_hdr *prof_hdr)
> +{
> +	int ret;
> +	struct aw_all_prof_info *all_prof_info;
> +
> +	all_prof_info = devm_kzalloc(aw_dev->dev, sizeof(struct aw_all_prof_info), GFP_KERNEL);
> +	if (!all_prof_info)
> +		return -ENOMEM;
> +
> +	ret = aw_dev_parse_dev_type(aw_dev, prof_hdr, all_prof_info);
> +	if (ret < 0) {
> +		goto exit;
> +	} else if (ret == AW_DEV_TYPE_NONE) {
> +		dev_dbg(aw_dev->dev, "get dev type num is 0, parse default dev");
> +		ret = aw_dev_parse_dev_default_type(aw_dev, prof_hdr, all_prof_info);
> +		if (ret < 0)
> +			goto exit;
> +	}
> +
> +	ret = aw_dev_cfg_get_vaild_prof(aw_dev, *all_prof_info);

valid

> +	if (ret < 0)
> +		goto exit;
> +
> +	aw_dev->prof_info.prof_name_list = profile_name;
> +exit:
> +	devm_kfree(aw_dev->dev, all_prof_info);
> +	return ret;
> +}
> +
> +static int aw_dev_create_prof_name_list_v_1_0_0_0(struct aw_device *aw_dev)

these v_1_0_0_0 suffixes are an eyesore, do you really need this level
of detail or can you not have an indirection to deal with versions?

> +{
> +	struct aw_prof_info *prof_info = &aw_dev->prof_info;
> +	struct aw_prof_desc *prof_desc = prof_info->prof_desc;
> +	int i;
> +
> +	if (!prof_desc) {
> +		dev_err(aw_dev->dev, "prof_desc is NULL");
> +		return -EINVAL;
> +	}
> +
> +	prof_info->prof_name_list = devm_kzalloc(aw_dev->dev,
> +					prof_info->count * PROFILE_STR_MAX,
> +					GFP_KERNEL);
> +	if (!prof_info->prof_name_list)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < prof_info->count; i++) {
> +		prof_desc[i].id = i;
> +		prof_info->prof_name_list[i] = prof_desc[i].prf_str;
> +		dev_dbg(aw_dev->dev, "prof name is %s", prof_info->prof_name_list[i]);
> +	}
> +
> +	return 0;
> +}
> +
> +static int aw_get_dde_type_info(struct aw_device *aw_dev, struct aw_container *aw_cfg)
> +{
> +	int i;
> +	int dev_num = 0;
> +	int default_num = 0;
> +	struct aw_cfg_hdr *cfg_hdr = (struct aw_cfg_hdr *)aw_cfg->data;
> +	struct aw_cfg_dde_v_1_0_0_0 *cfg_dde =
> +		(struct aw_cfg_dde_v_1_0_0_0 *)(aw_cfg->data + cfg_hdr->a_hdr_offset);
> +
> +	for (i = 0; i < cfg_hdr->a_ddt_num; i++) {
> +		if (cfg_dde[i].type == AW_DEV_TYPE_ID)
> +			dev_num++;
> +
> +		if (cfg_dde[i].type == AW_DEV_DEFAULT_TYPE_ID)
> +			default_num++;
> +	}
> +
> +	if (dev_num != 0) {
> +		aw_dev->prof_info.prof_type = AW_DEV_TYPE_ID;
> +	} else if (default_num != 0) {
> +		aw_dev->prof_info.prof_type = AW_DEV_DEFAULT_TYPE_ID;
> +	} else {
> +		dev_err(aw_dev->dev, "can't find scene");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aw_get_dev_scene_count_v_1_0_0_0(struct aw_device *aw_dev, struct aw_container *aw_cfg,
> +						unsigned int *scene_num)
> +{
> +	int i;
> +	struct aw_cfg_hdr *cfg_hdr = (struct aw_cfg_hdr *)aw_cfg->data;
> +	struct aw_cfg_dde_v_1_0_0_0 *cfg_dde =
> +		(struct aw_cfg_dde_v_1_0_0_0 *)(aw_cfg->data + cfg_hdr->a_hdr_offset);
> +	for (i = 0; i < cfg_hdr->a_ddt_num; ++i) {
> +		if ((cfg_dde[i].data_type == ACF_SEC_TYPE_MUTLBIN) &&

MULTBIN as in MULTipleBin?

> +		    (aw_dev->chip_id == cfg_dde[i].chip_id) &&
> +		    ((aw_dev->i2c->adapter->nr == cfg_dde[i].dev_bus) &&
> +		     (aw_dev->i2c->addr == cfg_dde[i].dev_addr)))
> +			(*scene_num)++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aw_get_default_scene_count_v_1_0_0_0(struct aw_device *aw_dev,
> +						struct aw_container *aw_cfg,
> +						unsigned int *scene_num)
> +{
> +	int i;
> +	struct aw_cfg_hdr *cfg_hdr = (struct aw_cfg_hdr *)aw_cfg->data;
> +	struct aw_cfg_dde_v_1_0_0_0 *cfg_dde =
> +		(struct aw_cfg_dde_v_1_0_0_0 *)(aw_cfg->data + cfg_hdr->a_hdr_offset);
> +
> +	for (i = 0; i < cfg_hdr->a_ddt_num; ++i) {
> +		if ((cfg_dde[i].data_type == ACF_SEC_TYPE_MUTLBIN) &&
> +		    (aw_dev->chip_id == cfg_dde[i].chip_id) &&
> +		    (aw_dev->channel == cfg_dde[i].dev_index))
> +			(*scene_num)++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aw_dev_parse_scene_count_v_1_0_0_0(struct aw_device *aw_dev,
> +							struct aw_container *aw_cfg,
> +							unsigned int *count)
> +{
> +	int ret;
> +
> +	ret = aw_get_dde_type_info(aw_dev, aw_cfg);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (aw_dev->prof_info.prof_type) {
> +	case AW_DEV_TYPE_ID:
> +		ret = aw_get_dev_scene_count_v_1_0_0_0(aw_dev, aw_cfg, count);
> +		break;
> +	case AW_DEV_DEFAULT_TYPE_ID:
> +		ret = aw_get_default_scene_count_v_1_0_0_0(aw_dev, aw_cfg, count);
> +		break;
> +	default:
> +		dev_err(aw_dev->dev, "unsupported prof_type[%x]", aw_dev->prof_info.prof_type);
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	dev_dbg(aw_dev->dev, "scene count is %d", (*count));
> +	return ret;> +}
> +
> +static int aw_dev_parse_data_by_sec_type_v_1_0_0_0(struct aw_device *aw_dev,
> +							struct aw_cfg_hdr *prof_hdr,
> +							struct aw_cfg_dde_v_1_0_0_0 *cfg_dde,
> +							int *cur_scene_id)
> +{
> +	int ret;
> +	struct aw_prof_info *prof_info = &aw_dev->prof_info;
> +
> +	switch (cfg_dde->data_type) {
> +	case ACF_SEC_TYPE_MUTLBIN:
> +		ret = aw_dev_prof_parse_multi_bin((u8 *)prof_hdr + cfg_dde->data_offset,
> +					cfg_dde->data_size, &prof_info->prof_desc[*cur_scene_id]);
> +		if (ret < 0) {
> +			dev_err(aw_dev->dev, "parse multi bin failed");
> +			return ret;
> +		}
> +		prof_info->prof_desc[*cur_scene_id].prf_str = cfg_dde->dev_profile_str;
> +		prof_info->prof_desc[*cur_scene_id].id = cfg_dde->dev_profile;
> +		(*cur_scene_id)++;
> +		break;
> +	default:
> +		dev_err(aw_dev->dev, "unsupported SEC_TYPE [%d]", cfg_dde->data_type);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aw_dev_parse_dev_type_v_1_0_0_0(struct aw_device *aw_dev,
> +		struct aw_cfg_hdr *prof_hdr)
> +{
> +	int i = 0;
> +	int ret;
> +	int cur_scene_id = 0;
> +	struct aw_cfg_dde_v_1_0_0_0 *cfg_dde =
> +		(struct aw_cfg_dde_v_1_0_0_0 *)((char *)prof_hdr + prof_hdr->a_hdr_offset);
> +
> +	for (i = 0; i < prof_hdr->a_ddt_num; i++) {
> +		if ((aw_dev->i2c->adapter->nr == cfg_dde[i].dev_bus) &&
> +		    (aw_dev->i2c->addr == cfg_dde[i].dev_addr) &&
> +		    (aw_dev->chip_id == cfg_dde[i].chip_id)) {
> +			ret = aw_dev_parse_data_by_sec_type_v_1_0_0_0(aw_dev, prof_hdr,
> +							&cfg_dde[i], &cur_scene_id);
> +			if (ret < 0) {
> +				dev_err(aw_dev->dev, "parse failed");
> +				return ret;
> +			}
> +		}
> +	}
> +
> +	if (cur_scene_id == 0) {
> +		dev_err(aw_dev->dev, "get dev type failed, get num [%d]", cur_scene_id);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aw_dev_parse_default_type_v_1_0_0_0(struct aw_device *aw_dev,
> +		struct aw_cfg_hdr *prof_hdr)
> +{
> +	int i = 0;
> +	int ret;
> +	int cur_scene_id = 0;
> +	struct aw_cfg_dde_v_1_0_0_0 *cfg_dde =
> +		(struct aw_cfg_dde_v_1_0_0_0 *)((char *)prof_hdr + prof_hdr->a_hdr_offset);
> +
> +	for (i = 0; i < prof_hdr->a_ddt_num; i++) {
> +		if ((aw_dev->channel == cfg_dde[i].dev_index) &&
> +			(aw_dev->chip_id == cfg_dde[i].chip_id)) {
> +			ret = aw_dev_parse_data_by_sec_type_v_1_0_0_0(aw_dev, prof_hdr,
> +							&cfg_dde[i], &cur_scene_id);
> +			if (ret < 0) {
> +				dev_err(aw_dev->dev, "parse failed");
> +				return ret;
> +			}
> +		}
> +	}
> +
> +	if (cur_scene_id == 0) {
> +		dev_err(aw_dev->dev, "get dev default type failed, get num[%d]", cur_scene_id);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aw_dev_parse_by_hdr_v_1_0_0_0(struct aw_device *aw_dev,
> +		struct aw_cfg_hdr *cfg_hdr)
> +{
> +	int ret = 0;
> +
> +	switch (aw_dev->prof_info.prof_type) {
> +	case AW_DEV_TYPE_ID:
> +		ret = aw_dev_parse_dev_type_v_1_0_0_0(aw_dev, cfg_hdr);
> +		break;
> +	case AW_DEV_DEFAULT_TYPE_ID:
> +		ret = aw_dev_parse_default_type_v_1_0_0_0(aw_dev, cfg_hdr);
> +		break;
> +	default:
> +		dev_err(aw_dev->dev, "prof type matched failed, get num[%d]",
> +			aw_dev->prof_info.prof_type);
> +		ret =  -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int aw_dev_load_cfg_by_hdr_v_1_0_0_0(struct aw_device *aw_dev,
> +									struct aw_container *aw_cfg)
> +{
> +	struct aw_prof_info *prof_info = &aw_dev->prof_info;
> +	struct aw_cfg_hdr *cfg_hdr = (struct aw_cfg_hdr *)aw_cfg->data;
> +	int ret;
> +
> +	ret = aw_dev_parse_scene_count_v_1_0_0_0(aw_dev, aw_cfg, &prof_info->count);
> +	if (ret < 0) {
> +		dev_err(aw_dev->dev, "get scene count failed");
> +		return ret;
> +	}
> +
> +	prof_info->prof_desc = devm_kcalloc(aw_dev->dev,
> +					prof_info->count, sizeof(struct aw_prof_desc),
> +					GFP_KERNEL);
> +	if (!prof_info->prof_desc)
> +		return -ENOMEM;
> +
> +	ret = aw_dev_parse_by_hdr_v_1_0_0_0(aw_dev, cfg_hdr);
> +	if (ret < 0) {
> +		dev_err(aw_dev->dev, "parse hdr failed");
> +		return ret;
> +	}
> +
> +	ret = aw_dev_create_prof_name_list_v_1_0_0_0(aw_dev);
> +	if (ret < 0) {
> +		dev_err(aw_dev->dev, "create prof name list failed");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int aw883xx_dev_cfg_load(struct aw_device *aw_dev, struct aw_container *aw_cfg)
> +{
> +	struct aw_cfg_hdr *cfg_hdr = NULL;
> +	int ret;
> +
> +	cfg_hdr = (struct aw_cfg_hdr *)aw_cfg->data;
> +
> +	switch (cfg_hdr->a_hdr_version) {
> +	case AW_CFG_HDR_VER_0_0_0_1:
> +		ret = aw_dev_load_cfg_by_hdr(aw_dev, cfg_hdr);
> +		if (ret < 0) {
> +			dev_err(aw_dev->dev, "hdr_cersion[0x%x] parse failed",
> +						cfg_hdr->a_hdr_version);
> +			return ret;
> +		}
> +		break;
> +	case AW_CFG_HDR_VER_1_0_0_0:
> +		ret = aw_dev_load_cfg_by_hdr_v_1_0_0_0(aw_dev, aw_cfg);
> +		if (ret < 0) {
> +			dev_err(aw_dev->dev, "hdr_cersion[0x%x] parse failed",
> +						cfg_hdr->a_hdr_version);
> +			return ret;
> +		}
> +		break;
> +	default:
> +		dev_err(aw_dev->dev, "unsupported hdr_version [0x%x]", cfg_hdr->a_hdr_version);
> +		return -EINVAL;
> +	}
> +	aw_dev->fw_status = AW_DEV_FW_OK;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(aw883xx_dev_cfg_load);
> +
> +static int aw_dev_check_cfg_by_hdr(struct aw_container *aw_cfg)
> +{
> +	struct aw_cfg_hdr *cfg_hdr = NULL;
> +	struct aw_cfg_dde *cfg_dde = NULL;
> +	unsigned int end_data_offset = 0;
> +	unsigned int act_data = 0;
> +	unsigned int hdr_ddt_len = 0;
> +	u8 act_crc8 = 0;

fix the inits please

> +	int i;
> +
> +	cfg_hdr = (struct aw_cfg_hdr *)aw_cfg->data;
> +	/*check file type id is awinic acf file*/
> +	if (cfg_hdr->a_id != ACF_FILE_ID) {
> +		pr_err("not acf type file");
> +		return -EINVAL;
> +	}
> +
> +	hdr_ddt_len = cfg_hdr->a_hdr_offset + cfg_hdr->a_ddt_size;
> +	if (hdr_ddt_len > aw_cfg->len) {
> +		pr_err("hdrlen with ddt_len [%d] overflow file size[%d]",
> +		cfg_hdr->a_hdr_offset, aw_cfg->len);
> +		return -EINVAL;
> +	}
> +
> +	/*check data size*/
> +	cfg_dde = (struct aw_cfg_dde *)((char *)aw_cfg->data + cfg_hdr->a_hdr_offset);
> +	act_data += hdr_ddt_len;
> +	for (i = 0; i < cfg_hdr->a_ddt_num; i++)
> +		act_data += cfg_dde[i].data_size;
> +
> +	if (act_data != aw_cfg->len) {
> +		pr_err("act_data[%d] not equal to file size[%d]!",
> +			act_data, aw_cfg->len);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < cfg_hdr->a_ddt_num; i++) {
> +		/* data check */
> +		end_data_offset = cfg_dde[i].data_offset + cfg_dde[i].data_size;
> +		if (end_data_offset > aw_cfg->len) {
> +			pr_err("a_ddt_num[%d] end_data_offset[%d] overflow file size[%d]",
> +				i, end_data_offset, aw_cfg->len);
> +			return -EINVAL;
> +		}
> +
> +		/* crc check */
> +		act_crc8 = crc8(aw_crc8_table, aw_cfg->data + cfg_dde[i].data_offset,
> +							cfg_dde[i].data_size, 0);
> +		if (act_crc8 != cfg_dde[i].data_crc) {
> +			pr_err("a_ddt_num[%d] crc8 check failed, act_crc8:0x%x != data_crc 0x%x",
> +				i, (u32)act_crc8, cfg_dde[i].data_crc);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int aw_dev_check_acf_by_hdr_v_1_0_0_0(struct aw_container *aw_cfg)
> +{
> +	struct aw_cfg_hdr *cfg_hdr = NULL;
> +	struct aw_cfg_dde_v_1_0_0_0 *cfg_dde = NULL;
> +	unsigned int end_data_offset = 0;
> +	unsigned int act_data = 0;
> +	unsigned int hdr_ddt_len = 0;
> +	u8 act_crc8 = 0;
> +	int i;
> +
> +	cfg_hdr = (struct aw_cfg_hdr *)aw_cfg->data;
> +
> +	/*check file type id is awinic acf file*/
> +	if (cfg_hdr->a_id != ACF_FILE_ID) {
> +		pr_err("not acf type file");
> +		return -EINVAL;
> +	}
> +
> +	hdr_ddt_len = cfg_hdr->a_hdr_offset + cfg_hdr->a_ddt_size;
> +	if (hdr_ddt_len > aw_cfg->len) {
> +		pr_err("hdrlen with ddt_len [%d] overflow file size[%d]",
> +		cfg_hdr->a_hdr_offset, aw_cfg->len);
> +		return -EINVAL;
> +	}
> +
> +	/*check data size*/
> +	cfg_dde = (struct aw_cfg_dde_v_1_0_0_0 *)((char *)aw_cfg->data + cfg_hdr->a_hdr_offset);
> +	act_data += hdr_ddt_len;
> +	for (i = 0; i < cfg_hdr->a_ddt_num; i++)
> +		act_data += cfg_dde[i].data_size;
> +
> +	if (act_data != aw_cfg->len) {
> +		pr_err("act_data[%d] not equal to file size[%d]!",
> +			act_data, aw_cfg->len);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < cfg_hdr->a_ddt_num; i++) {
> +		/* data check */
> +		end_data_offset = cfg_dde[i].data_offset + cfg_dde[i].data_size;
> +		if (end_data_offset > aw_cfg->len) {
> +			pr_err("a_ddt_num[%d] end_data_offset[%d] overflow file size[%d]",
> +				i, end_data_offset, aw_cfg->len);
> +			return -EINVAL;
> +		}
> +
> +		/* crc check */
> +		act_crc8 = crc8(aw_crc8_table, aw_cfg->data + cfg_dde[i].data_offset,
> +									cfg_dde[i].data_size, 0);
> +		if (act_crc8 != cfg_dde[i].data_crc) {
> +			pr_err("a_ddt_num[%d] crc8 check failed, act_crc8:0x%x != data_crc 0x%x",
> +				i, (u32)act_crc8, cfg_dde[i].data_crc);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +
> +}
> +
> +int aw883xx_dev_load_acf_check(struct aw_container *aw_cfg)
> +{
> +	struct aw_cfg_hdr *cfg_hdr = NULL;
> +
> +	if (!aw_cfg) {
> +		pr_err("aw_prof is NULL");
> +		return -EINVAL;
> +	}
> +
> +	if (aw_cfg->len < sizeof(struct aw_cfg_hdr)) {
> +		pr_err("cfg hdr size[%d] overflow file size[%d]",
> +			aw_cfg->len, (int)sizeof(struct aw_cfg_hdr));
> +		return -EINVAL;
> +	}
> +
> +	crc8_populate_lsb(aw_crc8_table, AW_CRC8_POLYNOMIAL);
> +
> +	cfg_hdr = (struct aw_cfg_hdr *)aw_cfg->data;
> +	switch (cfg_hdr->a_hdr_version) {
> +	case AW_CFG_HDR_VER_0_0_0_1:
> +		return aw_dev_check_cfg_by_hdr(aw_cfg);
> +	case AW_CFG_HDR_VER_1_0_0_0:
> +		return aw_dev_check_acf_by_hdr_v_1_0_0_0(aw_cfg);
> +	default:
> +		pr_err("unsupported hdr_version [0x%x]", cfg_hdr->a_hdr_version);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(aw883xx_dev_load_acf_check);
> +
> +MODULE_DESCRIPTION("AW883XX ACF File Parsing Lib");
> +MODULE_LICENSE("GPL v2");

"GPL"

> diff --git a/sound/soc/codecs/aw883xx/aw883xx_bin_parse.h b/sound/soc/codecs/aw883xx/aw883xx_bin_parse.h
> new file mode 100644
> index 000000000000..e230221cdaf1
> --- /dev/null
> +++ b/sound/soc/codecs/aw883xx/aw883xx_bin_parse.h
> @@ -0,0 +1,123 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * aw883xx.c --  ALSA SoC AW883XX codec support
> + *
> + * Copyright (c) 2022 AWINIC Technology CO., LTD
> + *
> + * Author: Bruce zhao <zhaolei@awinic.com>
> + */
> +
> +#ifndef __AW883XX_BIN_PARSE_H__
> +#define __AW883XX_BIN_PARSE_H__
> +
> +#define BIN_NUM_MAX				(100)
> +#define HEADER_LEN				(60)
> +#define CHECK_SUM_OFFSET		(0)
> +#define HEADER_VER_OFFSET		(4)
> +#define	BIN_DATA_TYPE_OFFSET	(8)
> +#define	BIN_DATA_VER_OFFSET		(12)
> +#define	BIN_DATA_LEN_OFFSET		(16)
> +#define	UI_VER_OFFSET			(20)
> +#define CHIP_TYPE_OFFSET		(24)
> +#define	REG_BYTE_LEN_OFFSET		(32)
> +#define	DATA_BYTE_LEN_OFFSET	(36)
> +#define	DEVICE_ADDR_OFFSET		(40)
> +#define	VALID_DATA_ADDR_OFFSET	(60)
> +#define	START_ADDR_OFFSET		(64)
> +
> +#define AW_FW_CHECK_PART		(10)
> +#define HDADER_LEN				(60)

fix indentation please


> +
> +enum bin_header_version_enum {
> +	HEADER_VERSION_1_0_0 = 0x01000000,
> +};
> +
> +enum data_type_enum {
> +	DATA_TYPE_REGISTER   = 0x00000000,
> +	DATA_TYPE_DSP_REG    = 0x00000010,
> +	DATA_TYPE_DSP_CFG    = 0x00000011,
> +	DATA_TYPE_SOC_REG    = 0x00000020,
> +	DATA_TYPE_SOC_APP    = 0x00000021,
> +	DATA_TYPE_DSP_FW     = DATA_TYPE_SOC_APP,

why would you use two enums with the same value?

> +	DATA_TYPE_MULTI_BINS = 0x00002000,
> +};
> +
> +/**
> + * @DATA_VERSION_V1：default little edian
> + */
> +enum data_version_enum {
> +	DATA_VERSION_V1 = 0x00000001,
> +	DATA_VERSION_MAX,
> +};
> +
> +/**
> + * @header_len: Frame header length
> + * @check_sum: Frame header information-Checksum
> + * @header_ver: Frame header information-Frame header version
> + * @bin_data_type: Frame header information-Data type
> + * @bin_data_ver: Frame header information-Data version
> + * @bin_data_len: Frame header information-Data length
> + * @ui_ver: Frame header information-ui version
> + * @chip_type[8]: Frame header information-chip type
> + * @reg_byte_len: Frame header information-reg byte len
> + * @data_byte_len: Frame header information-data byte len
> + * @device_addr: Frame header information-device addr
> + * @valid_data_len: Length of valid data obtained after parsing
> + * @valid_data_addr: The offset address of the valid data obtained
> + *                   after parsing relative to info
> + * @reg_num: The number of registers obtained after parsing
> + * @reg_data_byte_len: The byte length of the register obtained after parsing
> + * @download_addr: The starting address or download address obtained
> + *                 after parsing
> + * @app_version: The software version number obtained after parsing
> + */
> +struct bin_header_info {
> +	unsigned int header_len;
> +	unsigned int check_sum;
> +	unsigned int header_ver;
> +	unsigned int bin_data_type;
> +	unsigned int bin_data_ver;
> +	unsigned int bin_data_len;
> +	unsigned int ui_ver;
> +	unsigned char chip_type[8];
> +	unsigned int reg_byte_len;
> +	unsigned int data_byte_len;
> +	unsigned int device_addr;
> +	unsigned int valid_data_len;
> +	unsigned int valid_data_addr;
> +
> +	unsigned int reg_num;
> +	unsigned int reg_data_byte_len;
> +	unsigned int download_addr;
> +	unsigned int app_version;
> +};
> +
> +/*
> + * @len: The size of the bin file obtained from the firmware
> + * @data[]: Store the bin file obtained from the firmware
> + */
> +struct bin_container {
> +	unsigned int len;
> +	unsigned char data[];
> +};
> +
> +/**

fix the kernel-doc, you are missing the structure definition for all
this file.

> + * @p_addr: Offset pointer (backward offset pointer to obtain frame header
> + *          information and important information)
> + * @all_bin_parse_num: The number of all bin files
> + * @multi_bin_parse_num: The number of single bin files
> + * @single_bin_parse_num: The number of multiple bin files
> + * @header_info[BIN_NUM_MAX]: Frame header information and other important data
> + *                            obtained after parsing
> + * @info: Obtained bin file data that needs to be parsed
> + */
> +struct aw_bin {
> +	unsigned char *p_addr;
> +	unsigned int all_bin_parse_num;
> +	unsigned int multi_bin_parse_num;
> +	unsigned int single_bin_parse_num;
> +	struct bin_header_info header_info[BIN_NUM_MAX];
> +	struct bin_container info;
> +};
> +
> +#endif
