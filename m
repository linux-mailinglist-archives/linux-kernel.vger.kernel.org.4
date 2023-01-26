Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF1467D8C3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjAZWtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjAZWtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:49:12 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865804B744
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:49:09 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id k13so3296913plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X/b7ZzS1i4s6CjWJN1zo056FU3g81hLKlf/seoytWcA=;
        b=JGCr00yc63rU7CFDVtrCbehOCytzkpxKmlPxfzZAp9HmetjrA4UkDDbbd7djSmQdIM
         7SYsiJ081AnHLh4PwNVWI/KxUxarcJbYTPvgwic3umNkcquo6wonR/WtChXTJwoShhkE
         CtBLGBhUNelmdlZ1TQYtvc5SCeZsEoHNHgn1Mq+fYfWRqvRK1zW9tiTt2S01VMFaS4ke
         YqXDzPoEEcGXv6uszmkti4EPkyz7OG1N4R1//vj4NrCxYF1utc2avUJZJNXEHL+Rqttt
         oFBzkZwItJT5rq5Nhlv4YCZtERSQkWztNZ92RRnz4rzEAah5aXRNtqtXhCRjyWqzFpI6
         /U1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/b7ZzS1i4s6CjWJN1zo056FU3g81hLKlf/seoytWcA=;
        b=usxD8qyi19hX29gSHKAICPznabV910UbIsE/pOMx7Vo4+nHKCtjkUPZ64qDSq/omEQ
         AeEid4G9rT8SMpquttiRWtuOV/9PD5FbQjfbbUXItAPj8juzAX2KHJrQfPTyRcPzl7UN
         Mal1diZn/a8m9eaB5nJyAD2Ji8KoDz3doeyamehpvctosNoaTb1D7b2/PCgPAAMsDluS
         dbtOpc/s+VmSdtxEd+/JWQUvluffQh4FxxD5Y/wuxhsbR0aZZkGScDCra9m0ReV6RSiJ
         58/CP6iUnF1XG8yHttCOFLOfWX/Pkg/7HLrPTuY6I7QrTw17sgcZuqYkJZ3GB9WUASg7
         GPlg==
X-Gm-Message-State: AO0yUKWaq1+lWDQgZfbeqc+U9eO21TAcpIjMyR1Ot3QsPeKLIq4oK583
        RrPaUONBW3fER5R8OV3rFyzVfg==
X-Google-Smtp-Source: AK7set9WMDdESrgaHivOh+QQAp6ucw5TMWWkPy8c7YGvWpjl/vYtSLhsyXtPnm6divUmRfPxlEvZOA==
X-Received: by 2002:a17:903:18f:b0:196:cea:487a with SMTP id z15-20020a170903018f00b001960cea487amr16072513plg.53.1674773348897;
        Thu, 26 Jan 2023 14:49:08 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:9115:ddbb:14fe:62e8])
        by smtp.gmail.com with ESMTPSA id bg6-20020a1709028e8600b00189a50d2a3esm1451007plb.241.2023.01.26.14.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:49:08 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:49:05 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Paul Olaru <paul.olaru@nxp.com>,
        Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH] remoteproc: imx_dsp_rproc: add custom memory copy
 implementation for i.MX DSP Cores
Message-ID: <20230126224905.GA4020499@p14s>
References: <20230125110100.14647-1-iuliana.prodan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125110100.14647-1-iuliana.prodan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 01:01:00PM +0200, Iuliana Prodan (OSS) wrote:
> From: Iuliana Prodan <iuliana.prodan@nxp.com>
> 
> The IRAM is part of the HiFi DSP.
> According to hardware specification only 32-bits write are allowed
> otherwise we get a Kernel panic.
> 
> Therefore add a custom memory copy function to deal with the
> above restriction.
> 
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> ---
>  drivers/remoteproc/imx_dsp_rproc.c | 122 ++++++++++++++++++++++++++++-
>  1 file changed, 121 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index 95da1cbefacf..a9991d085494 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -715,6 +715,126 @@ static void imx_dsp_rproc_kick(struct rproc *rproc, int vqid)
>  		dev_err(dev, "%s: failed (%d, err:%d)\n", __func__, vqid, err);
>  }
>  
> +/*
> + * Custom memory copy implementation for i.MX DSP Cores
> + *
> + * The IRAM is part of the HiFi DSP.
> + * According to hw specs only 32-bits writes are allowed.
> + */
> +static int imx_dsp_rproc_memcpy(void *dest, const void *src, size_t size)
> +{
> +	const u8 *src_byte = src;
> +	u32 affected_mask;
> +	u32 tmp;
> +	int q, r;
> +
> +	q = size / 4;
> +	r = size % 4;
> +
> +	/* __iowrite32_copy use 32bit size values so divide by 4 */
> +	__iowrite32_copy(dest, src, q);

The current driver for imx_dsp_rproc does not provide a rproc_da_to_va()
operation, meaning that @is_iomem in rproc_elf_load_segments() can't be true,
forcing a memcpy() operation to be used.  And yet above an _iowrite32_copy() is
used...  

In the conversation that came out of[1], Daniel Baluta mentions that
read/writes should be done in multiples of 32/64 bit but here a blanket 32 bit
enforcement is done.

> +
> +	if (r) {
> +		affected_mask = (1 << (8 * r)) - 1;
> +
> +		/* first read the 32bit data of dest, then change affected
> +		 * bytes, and write back to dest.
> +		 * For unaffected bytes, it should not be changed
> +		 */
> +		tmp = ioread32(dest + q * 4);
> +		tmp &= ~affected_mask;
> +
> +		tmp |= *(u32 *)(src_byte + q * 4) & affected_mask;
> +		iowrite32(tmp, dest + q * 4);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * imx_dsp_rproc_elf_load_segments() - load firmware segments to memory
> + * @rproc: remote processor which will be booted using these fw segments
> + * @fw: the ELF firmware image
> + *
> + * This function loads the firmware segments to memory, where the remote
> + * processor expects them.
> + *
> + * Return: 0 on success and an appropriate error code otherwise
> + */
> +static int imx_dsp_rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
> +{
> +	struct device *dev = &rproc->dev;
> +	const void *ehdr, *phdr;
> +	int i, ret = 0;
> +	u16 phnum;
> +	const u8 *elf_data = fw->data;
> +	u8 class = fw_elf_get_class(fw);
> +	u32 elf_phdr_get_size = elf_size_of_phdr(class);
> +
> +	ehdr = elf_data;
> +	phnum = elf_hdr_get_e_phnum(class, ehdr);
> +	phdr = elf_data + elf_hdr_get_e_phoff(class, ehdr);
> +
> +	/* go through the available ELF segments */
> +	for (i = 0; i < phnum; i++, phdr += elf_phdr_get_size) {
> +		u64 da = elf_phdr_get_p_paddr(class, phdr);
> +		u64 memsz = elf_phdr_get_p_memsz(class, phdr);
> +		u64 filesz = elf_phdr_get_p_filesz(class, phdr);
> +		u64 offset = elf_phdr_get_p_offset(class, phdr);
> +		u32 type = elf_phdr_get_p_type(class, phdr);
> +		bool is_iomem = false;
> +		void *ptr;
> +
> +		if (type != PT_LOAD || !memsz)
> +			continue;
> +
> +		dev_dbg(dev, "phdr: type %d da 0x%llx memsz 0x%llx filesz 0x%llx\n",
> +			type, da, memsz, filesz);
> +
> +		if (filesz > memsz) {
> +			dev_err(dev, "bad phdr filesz 0x%llx memsz 0x%llx\n",
> +				filesz, memsz);
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		if (offset + filesz > fw->size) {
> +			dev_err(dev, "truncated fw: need 0x%llx avail 0x%zx\n",
> +				offset + filesz, fw->size);
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		if (!rproc_u64_fit_in_size_t(memsz)) {
> +			dev_err(dev, "size (%llx) does not fit in size_t type\n",
> +				memsz);
> +			ret = -EOVERFLOW;
> +			break;
> +		}
> +
> +		/* grab the kernel address for this device address */
> +		ptr = rproc_da_to_va(rproc, da, memsz, &is_iomem);
> +		if (!ptr) {
> +			dev_err(dev, "bad phdr da 0x%llx mem 0x%llx\n", da,
> +				memsz);
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		/* put the segment where the remote processor expects it */
> +		if (filesz) {
> +			ret = imx_dsp_rproc_memcpy(ptr, elf_data + offset, filesz);
> +			if (ret) {
> +				dev_err(dev, "memory copy failed for da 0x%llx memsz 0x%llx\n",
> +					da, memsz);
> +				break;
> +			}
> +		}

This patchset from last year[1] goes to great length to avoid using a driver
specific function and now you are trying to bring that back...  So how was it
working before and why are things broken now?  Moreover, function
rproc_elf_load_segments() deals with situations where the memory slot is bigger
than the file size[2], which is omitted here.

Thanks,
Mathieu

[1]. https://lore.kernel.org/linux-arm-kernel/20220323064944.1351923-1-peng.fan@oss.nxp.com/
[2]. https://elixir.bootlin.com/linux/v6.2-rc5/source/drivers/remoteproc/remoteproc_elf_loader.c#L221 

> +	}
> +
> +	return ret;
> +}
> +
>  static int imx_dsp_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
>  {
>  	if (rproc_elf_load_rsc_table(rproc, fw))
> @@ -729,7 +849,7 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
>  	.start		= imx_dsp_rproc_start,
>  	.stop		= imx_dsp_rproc_stop,
>  	.kick		= imx_dsp_rproc_kick,
> -	.load		= rproc_elf_load_segments,
> +	.load		= imx_dsp_rproc_elf_load_segments,
>  	.parse_fw	= imx_dsp_rproc_parse_fw,
>  	.sanity_check	= rproc_elf_sanity_check,
>  	.get_boot_addr	= rproc_elf_get_boot_addr,
> -- 
> 2.17.1
> 
