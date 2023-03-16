Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5186BC394
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 03:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCPCJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 22:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCPCJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 22:09:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E8186A2;
        Wed, 15 Mar 2023 19:09:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C42A61EE0;
        Thu, 16 Mar 2023 02:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD346C433D2;
        Thu, 16 Mar 2023 02:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678932548;
        bh=ZjfTbIdfaWyIe0PfXqYJkSzMJKLlqeKY0T+ES29gjJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Byttp4ajzJ4F9qBZCQW+E70dAQJFxFH96d+XDFWIgPRNMkTXY1ULFn047hQ/dIf3A
         in5LPQAY5FgkTja9gfjB9sSsWcJ0h8gE79+57TGG6upsQZKLRD/6udTCZLdHDGpN9N
         0xHJx3DIAn+9CNXSUNxD3kqUt3BKGB8LO4NWrIBeTX8S+cWpfUkEwgo07cmnQmKYNf
         h8+k6lD9+dneXxxzME/JliY2TsRK1p5rdC5fMI0UR+2cfIVwuwmlpq0sPXerWXmEl9
         M2qhtVXiM231h0Dm/yK8YaCPspJjc/atVQ8ugSvB/z+QaFXeAq3bVB/T67q7cEiyX9
         N7lRM4lB2wyjg==
Date:   Wed, 15 Mar 2023 19:12:29 -0700
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
Subject: Re: [PATCH v2 4/7] soc: qcom: mdt_loader: Enhance split binary
 detection
Message-ID: <20230316021229.jpvaelcqb7vb7dwy@ripper>
References: <20230306231202.12223-1-quic_molvera@quicinc.com>
 <20230306231202.12223-5-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306231202.12223-5-quic_molvera@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 03:11:59PM -0800, Melody Olvera wrote:
> From: Gokul Krishna Krishnakumar <quic_gokukris@quicinc.com>
> 
> When booting with split binaries, it may be that the offset of the first
> program header lies inside the mdt's filesize, in this case the loader
> would incorrectly assume that the bins were not split. The loading would
> then continue on and fail for split bins.

Can you please be more explicit about the scenario you're having
problems with?

Is the problem that the first segment is represented in both the .mdt
and .b01, but different? Or is it that you find the hash in both .mdt
abd .b01, but only one of them is valid?

> This change updates the logic used
> by the mdt loader to understand whether the firmware images are split or not
> by checking if each programs header's segment lies within the file or not.
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

The existing code handles 3 cases:

> -	if (ehdr_size + hash_size == fw->size) {

1) File is split, but hash resides with the ELF header in the .mdt

> -		/* Firmware is split and hash is packed following the ELF header */
> -		hash_offset = phdrs[0].p_filesz;
> -		memcpy(data + ehdr_size, fw->data + hash_offset, hash_size);
> -	} else if (phdrs[hash_segment].p_offset + hash_size <= fw->size) {

2) The hash segment exists in a segment of its own, but in the loaded
   image.

> -		/* Hash is in its own segment, but within the loaded file */
> +
> +	if (qcom_mdt_bins_are_split(fw)) {
> +		ret = mdt_load_split_segment(data + ehdr_size, phdrs, hash_segment, fw_name, dev);
> +	} else {
>  		hash_offset = phdrs[hash_segment].p_offset;
>  		memcpy(data + ehdr_size, fw->data + hash_offset, hash_size);
> -	} else {

3) The image is split, and the hash segment resides in it's own file.


Afaict the updated logic maintains #2 and #3, but drops #1. Please
review the git history to see if you can determine which target this
case exists with - and ask for someone to specifically verify your
change there.

Perhaps all your change is doing is removing case #1, in which case this
should be clear in the commit message; and we need to validate that your
new assumptions holds.

> -		/* Hash is in its own segment, beyond the loaded file */
> -		ret = mdt_load_split_segment(data + ehdr_size, phdrs, hash_segment, fw_name, dev);

For some reason you reversed the condition and got this out of the else
(seems like an unnecessary change)...but in the process you lost the
error handling below.

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

If you just change the condition (phr->p_filesz && !issplit), then your
patch becomes easier to read.

Regards,
Bjorn

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
