Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00AA696BD3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjBNRgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjBNRgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:36:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1977691;
        Tue, 14 Feb 2023 09:35:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D2CEB81E4A;
        Tue, 14 Feb 2023 17:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D7CC433D2;
        Tue, 14 Feb 2023 17:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676396130;
        bh=K1W1HGSXCSxK2eoAED25PPugOTUwn8WQ87nD6VmP/yQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZaaQrlK0npdqyxSvU7pyWMYMj2dzeRI8TeeCawqLypJpfl0AfXq7afSZPRBcxcsIx
         2TFMnH/m1dl9mlrhApUP4yOkSOefS+sDsboFcaqB+m3pSRUsE9J7VET4R0IbIvByNs
         a6nF5DpIXJOmR+E1ifdI5bdAbN7uhmJxMkEZ5Pn911QfV6egwmZ79ZWFotR+YSrPlA
         9WZE9Czgiu7fl+n+MFHIQerIbDERz1SAvr6yCtx7gjswT0fbl2kpD5cnAzUW0dVi3v
         3Mhxc2O/X+y4HITU4Sfu/GYxpzXBzr4ltQGUnT6Gp8qBbKl5mEFy7ao4AJzaRF8gJl
         dyRq6EfkXYDCA==
Date:   Tue, 14 Feb 2023 09:37:33 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Gokul Krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: Re: [PATCH 6/9] soc: qcom: mdt_loader: Enhance split binary detection
Message-ID: <20230214173733.ykgry7td33sbr3o5@ripper>
References: <20230213185218.166520-1-quic_molvera@quicinc.com>
 <20230213185218.166520-7-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213185218.166520-7-quic_molvera@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 10:52:15AM -0800, Melody Olvera wrote:
> From: Gokul Krishna Krishnakumar <quic_gokukris@quicinc.com>
> 
> When booting with split binaries, it is possible that the
> mdt loader misdetects if a binary is split and only loads
> one of the segments, so enhance the detection of the split
> binaries to ensure the entirety of the firmware is loaded.

Please describe in detail what it is that is being "misdetected", and
why, so other users can correlate their experience to the changes in the
git log and that reviewers doesn't have to guess what problem is being
corrected.

Thanks,
Bjorn

> 
> Signed-off-by: Gokul Krishna Krishnakumar <quic_gokukris@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  drivers/soc/qcom/mdt_loader.c | 64 +++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> index 33dd8c315eb7..3aadce299c02 100644
> --- a/drivers/soc/qcom/mdt_loader.c
> +++ b/drivers/soc/qcom/mdt_loader.c
> @@ -31,6 +31,26 @@ static bool mdt_phdr_valid(const struct elf32_phdr *phdr)
>  	return true;
>  }
>  
> +static bool qcom_mdt_bins_are_split(const struct firmware *fw)
> +{
> +	const struct elf32_phdr *phdrs;
> +	const struct elf32_hdr *ehdr;
> +	uint64_t seg_start, seg_end;
> +	int i;
> +
> +	ehdr = (struct elf32_hdr *)fw->data;
> +	phdrs = (struct elf32_phdr *)(ehdr + 1);
> +
> +	for (i = 0; i < ehdr->e_phnum; i++) {
> +		seg_start = phdrs[i].p_offset;
> +		seg_end = phdrs[i].p_offset + phdrs[i].p_filesz;
> +		if (seg_start > fw->size || seg_end > fw->size)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static ssize_t mdt_load_split_segment(void *ptr, const struct elf32_phdr *phdrs,
>  				      unsigned int segment, const char *fw_name,
>  				      struct device *dev)
> @@ -167,23 +187,13 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
>  	/* Copy ELF header */
>  	memcpy(data, fw->data, ehdr_size);
>  
> -	if (ehdr_size + hash_size == fw->size) {
> -		/* Firmware is split and hash is packed following the ELF header */
> -		hash_offset = phdrs[0].p_filesz;
> -		memcpy(data + ehdr_size, fw->data + hash_offset, hash_size);
> -	} else if (phdrs[hash_segment].p_offset + hash_size <= fw->size) {
> -		/* Hash is in its own segment, but within the loaded file */
> +
> +	if (qcom_mdt_bins_are_split(fw)) {
> +		ret = mdt_load_split_segment(data + ehdr_size, phdrs, hash_segment, fw_name, dev);
> +	} else {
>  		hash_offset = phdrs[hash_segment].p_offset;
>  		memcpy(data + ehdr_size, fw->data + hash_offset, hash_size);
> -	} else {
> -		/* Hash is in its own segment, beyond the loaded file */
> -		ret = mdt_load_split_segment(data + ehdr_size, phdrs, hash_segment, fw_name, dev);
> -		if (ret) {
> -			kfree(data);
> -			return ERR_PTR(ret);
> -		}
>  	}
> -
>  	*data_len = ehdr_size + hash_size;
>  
>  	return data;
> @@ -270,6 +280,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>  	phys_addr_t min_addr = PHYS_ADDR_MAX;
>  	ssize_t offset;
>  	bool relocate = false;
> +	bool is_split;
>  	void *ptr;
>  	int ret = 0;
>  	int i;
> @@ -277,6 +288,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>  	if (!fw || !mem_region || !mem_phys || !mem_size)
>  		return -EINVAL;
>  
> +	is_split = qcom_mdt_bins_are_split(fw);
>  	ehdr = (struct elf32_hdr *)fw->data;
>  	phdrs = (struct elf32_phdr *)(ehdr + 1);
>  
> @@ -330,22 +342,16 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>  
>  		ptr = mem_region + offset;
>  
> -		if (phdr->p_filesz && phdr->p_offset < fw->size &&
> -		    phdr->p_offset + phdr->p_filesz <= fw->size) {
> -			/* Firmware is large enough to be non-split */
> -			if (phdr->p_offset + phdr->p_filesz > fw->size) {
> -				dev_err(dev, "file %s segment %d would be truncated\n",
> -					fw_name, i);
> -				ret = -EINVAL;
> -				break;
> +		if (phdr->p_filesz) {
> +			if (!is_split) {
> +				/* Firmware is large enough to be non-split */
> +				memcpy(ptr, fw->data + phdr->p_offset, phdr->p_filesz);
> +			} else {
> +				/* Firmware not large enough, load split-out segments */
> +				ret = mdt_load_split_segment(ptr, phdrs, i, fw_name, dev);
> +				if (ret)
> +					break;
>  			}
> -
> -			memcpy(ptr, fw->data + phdr->p_offset, phdr->p_filesz);
> -		} else if (phdr->p_filesz) {
> -			/* Firmware not large enough, load split-out segments */
> -			ret = mdt_load_split_segment(ptr, phdrs, i, fw_name, dev);
> -			if (ret)
> -				break;
>  		}
>  
>  		if (phdr->p_memsz > phdr->p_filesz)
> -- 
> 2.25.1
> 
