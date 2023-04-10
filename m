Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E7A6DCCE7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 23:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjDJVsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 17:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDJVsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 17:48:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A197198B;
        Mon, 10 Apr 2023 14:48:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A78C361889;
        Mon, 10 Apr 2023 21:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14185C433EF;
        Mon, 10 Apr 2023 21:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681163321;
        bh=NKTkZrzP5KsL7fLtTeMMwSEi1SSUYvQdhMEdquN4XTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PNRYhIuPANLPsJW+YtLqf5nNmlz4X36vVsZatRaqdIe+crJ6XiS4dKhJS6hdlpsgG
         bQdIveMDRE1NR0v/Qzi0HWT7/zow/e0YD5DXBcBDyonBTHB4LXitflFQV7HHFdvYsL
         kUbBym1uq8rFS56MLGueccs9ikB+TUKw1akoxxLe/Sp5R+himMBbXHmoL1pM8YVk58
         iS3pqcS4mittb4axXQVOZ0YZ9LZxRet4CQobk9UcCF1onodF4IUkjtqatCj6F1GfXb
         o4E6OpHeiyRI6xJ2MQ72IDxD6U4MJPIna1QB6h9YfoE628rCGqGAnK4k3Kn7y8fmRF
         YjL30b51RM2HQ==
Date:   Mon, 10 Apr 2023 14:52:23 -0700
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
Subject: Re: [PATCH v5 1/1] soc: qcom: mdt_loader: Enhance split binary
 detection
Message-ID: <20230410215223.3xcctjsq5qqbqvs2@ripper>
References: <20230410171432.19046-1-quic_gokukris@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410171432.19046-1-quic_gokukris@quicinc.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 10:14:32AM -0700, Gokul krishna Krishnakumar wrote:
> It may be that the offset of the first program header lies inside the mdt's
> filesize, in this case the loader would incorrectly assume that the bins
> were not split. The loading would then continue on to fail for split bins.
> This change updates the logic used by the mdt loader to understand whether
> the firmware images are split or not. It figures this out by checking if
> each programs header's segment lies within the file or not.
> 
> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>

Please read Documentation/process/submitting-patches.rst section about
Developer's Certificate of Origin 1.1, then apply that for each person
in the S-o-b chain from the top. Finally consider how Melody's name can
be the last one in this list, while the patch is coming from you.

> ---
> V5: Removes extra empty lines from V4.

That's nice, but what about the other changes I asked for?

Regards,
Bjorn

> 
> V4: Removes the unneceessary change in qcom_mdt_read_metadata(), the
> exisiting check holds good in case the hash segment is in the loaded image.
> 
> V3 is separated out from [1] and includes
> changes addressing comments from that patch set.
> 
> [1] https://lore.kernel.org/all/20230306231202.12223-5-quic_molvera@quicinc.com/
> ---
>  drivers/soc/qcom/mdt_loader.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> index 33dd8c315eb7..814646ce41e5 100644
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
> @@ -277,6 +298,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>  	if (!fw || !mem_region || !mem_phys || !mem_size)
>  		return -EINVAL;
>  
> +	is_split = qcom_mdt_bins_are_split(fw, fw_name);
>  	ehdr = (struct elf32_hdr *)fw->data;
>  	phdrs = (struct elf32_phdr *)(ehdr + 1);
>  
> @@ -330,8 +352,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>  
>  		ptr = mem_region + offset;
>  
> -		if (phdr->p_filesz && phdr->p_offset < fw->size &&
> -		    phdr->p_offset + phdr->p_filesz <= fw->size) {
> +		if (phdr->p_filesz && !is_split) {
>  			/* Firmware is large enough to be non-split */
>  			if (phdr->p_offset + phdr->p_filesz > fw->size) {
>  				dev_err(dev, "file %s segment %d would be truncated\n",
> -- 
> 2.39.2
> 
