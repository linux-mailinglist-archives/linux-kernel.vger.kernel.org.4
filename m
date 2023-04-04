Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043D96D6CE6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbjDDTDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbjDDTCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:02:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0575559DD;
        Tue,  4 Apr 2023 12:02:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C488634A7;
        Tue,  4 Apr 2023 19:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEE4C433EF;
        Tue,  4 Apr 2023 19:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680634936;
        bh=v6YyIlEU+FHwG8OPdW5hOLpVAMY1w2LcfZBn3Y6jhzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q01Llgh8cZB5nu8HwYWF8yNzB75BhBu5E3E1GUBYcGkZz+bWMMa/CziwYAHTpRAaS
         IOBdGR9PQYAG+r7sQlPGBflhu+OAh1YL3JGaBRMFQf+s46997XvBUfpek7gtxgo8N2
         bPxFCi50sLHgsb9tDzQgYbd4kzaZ2SSTUQ+Xo/Uw4RXWiU5Oud9vWsgXiGJ5AOMqqq
         10nJGi7fIDpfAZzbk+kfPiS+4INHZg+NsEE/eou9X81ulT9ozh5lF7yCPhuXNOvxLo
         GMI07DpLz9rz1FBZ9+YNgLreMD8BbtDPuugYNJyfGilAgX56xsC1wOtmDCZMwwHhh9
         MkzB9Y52ONm0A==
Date:   Tue, 4 Apr 2023 12:05:10 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: Re: [PATCH v4 1/1] soc: qcom: mdt_loader: Enhance split binary
 detection
Message-ID: <20230404190510.dvsmkroyvu6437rb@ripper>
References: <20230404175417.31185-1-quic_gokukris@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404175417.31185-1-quic_gokukris@quicinc.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 10:54:17AM -0700, Gokul krishna Krishnakumar wrote:
> It may be that the offset of the first program header lies inside the mdt's
> filesize, in this case the loader would incorrectly assume that the bins
> were not split. The loading would then continue on to fail for split bins.

What does "continue on to fail for split bins" actually mean? In what
way does it fail?

> This change updates the logic used by the mdt loader to understand whether
> the firmware images are split or not. It figures this out by checking if
> each programs header's segment lies within the file or not.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>

The first S-o-b should be that of the author (unless Co-developed-by)
and in [1] you're the author and Melody provide her S-o-b to certify
the origin of her contribution.

> ---
> V4 addresses the comments from V3.

That's nice, but not very helpful. Please spell out what you changed.

> 
> V3 is separated out from [1] and includes
> changes addressing comments from that patch set.
> 
> [1] https://lore.kernel.org/all/20230306231202.12223-5-quic_molvera@quicinc.com/
> ---
>  drivers/soc/qcom/mdt_loader.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> index 33dd8c315eb7..9270992728d4 100644
> --- a/drivers/soc/qcom/mdt_loader.c
> +++ b/drivers/soc/qcom/mdt_loader.c
> @@ -258,6 +258,26 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
>  }
>  EXPORT_SYMBOL_GPL(qcom_mdt_pas_init);
>  
> +static bool qcom_mdt_bins_are_split(const struct firmware *fw, const char* fw_name)
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
>  static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>  			   const char *fw_name, int pas_id, void *mem_region,
>  			   phys_addr_t mem_phys, size_t mem_size,
> @@ -270,6 +290,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>  	phys_addr_t min_addr = PHYS_ADDR_MAX;
>  	ssize_t offset;
>  	bool relocate = false;
> +	bool is_split;
>  	void *ptr;
>  	int ret = 0;
>  	int i;
> @@ -277,6 +298,8 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>  	if (!fw || !mem_region || !mem_phys || !mem_size)
>  		return -EINVAL;
>  
> +

Double empty lines here?

> +	is_split = qcom_mdt_bins_are_split(fw, fw_name);
>  	ehdr = (struct elf32_hdr *)fw->data;
>  	phdrs = (struct elf32_phdr *)(ehdr + 1);
>  
> @@ -330,8 +353,8 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>  
>  		ptr = mem_region + offset;
>  
> -		if (phdr->p_filesz && phdr->p_offset < fw->size &&
> -		    phdr->p_offset + phdr->p_filesz <= fw->size) {
> +
> +		if (phdr->p_filesz && !is_split) {

This looks much better now, thanks.

Regards,
Bjorn

>  			/* Firmware is large enough to be non-split */
>  			if (phdr->p_offset + phdr->p_filesz > fw->size) {
>  				dev_err(dev, "file %s segment %d would be truncated\n",
> -- 
> 2.39.2
> 
