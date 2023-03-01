Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B24A6A73C7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjCASt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCASt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:49:27 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358333C79D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 10:49:20 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id ay18so8599257pfb.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 10:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pMQQzFdkiDEMf5Lr2n3BwV5AYMp4CNjDkovaXSZyFms=;
        b=J+xPzgJ7jDGr5CYcone+e9DE54pljgW32Y0/LKSSIYaJh1zTeRnuMlBiXGFpiNbYHX
         A4AlmFGnl3Fj5xBNUb23i7gv7tfeqnvAFfcJHruoDSK3GS+NPpxlgnJ+kihgY8v5G91M
         H444svdx1CWVwCHJl5CrolZGaR3NnPt/IPRLJYtPuIqmVk67ngsGeGBTV05GFJcCJrYy
         bkMIIDjqfwRqK+XMONQ7/rTZ55dRbfWq4yzcbkx42MAcUo8+z8ycwxXWuq/E/0QBc4Ub
         f0IJMV0cPHWdGAUuz7afMU3fdqn9TtS6Gu+h0hqD3soTRYQ5JzxpU4ll4mjav8Q/UtgL
         vXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMQQzFdkiDEMf5Lr2n3BwV5AYMp4CNjDkovaXSZyFms=;
        b=xF2CboYib8Zef7jdTfX/LMZBr8QjfoUHm7JkoaZs7qOeXslnc7YNyyFn4n3wlUBwgL
         rPIQZaYwMErIiCTS/cdxFWN/Py07+SlHFp2R1ARTJmZKGeYuwkRO+X0XGj9ptJc5NRmX
         aoTVI1Agn8mB3v8zoxIz1W5VcEEPg2fmhe7Uj0pM6w0H6WPUS+Kd60fQxokFKDIWYXVi
         6snAHACJh48r9UBpwwhpaqpD5fago3wcTECKc6M+4u/gg0F8baLNm5bWHgx1fTt2ELTA
         yB2ByIZZXpYvpbF7HGmUSTI3abS05Bi9R4xt7btK9iuCuMUHwxh9sgTFltSARipt1jPr
         Kbvg==
X-Gm-Message-State: AO0yUKUcde9AoBjdfbOROD37HqHcX62dPY8lL3GFnbcjddo9f9uthVEy
        ZPGmb8hg/uzeJfXML6avMPl0bg==
X-Google-Smtp-Source: AK7set8HfL876T8Ip+u2v23IJ1Samt8XAvuDlN918IHZfQ9BN9sQpxRBZqwSGZG689I20mVeCEMMVg==
X-Received: by 2002:aa7:8ece:0:b0:5e5:6452:223f with SMTP id b14-20020aa78ece000000b005e56452223fmr6081525pfr.8.1677696559546;
        Wed, 01 Mar 2023 10:49:19 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:a1e5:28cc:d6dd:89d0])
        by smtp.gmail.com with ESMTPSA id m9-20020aa79009000000b005dd65169628sm8450771pfo.144.2023.03.01.10.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 10:49:19 -0800 (PST)
Date:   Wed, 1 Mar 2023 11:49:16 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v5] remoteproc: imx_dsp_rproc: add custom memory copy
 implementation for i.MX DSP Cores
Message-ID: <20230301184916.GA1326133@p14s>
References: <20230221170356.27923-1-iuliana.prodan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221170356.27923-1-iuliana.prodan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Iuliana,

On Tue, Feb 21, 2023 at 07:03:56PM +0200, Iuliana Prodan (OSS) wrote:
> From: Iuliana Prodan <iuliana.prodan@nxp.com>
> 
> The IRAM is part of the HiFi DSP.
> According to hardware specification only 32-bits write are allowed
> otherwise we get a Kernel panic.
> 
> Therefore add a custom memory copy and memset functions to deal with
> the above restriction.
> 
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> ---
> Changes since v4
> - use GENMASK;
> - s/ioread32/readl;
> - s/iowrite32/writel;
> - use for loop with writel instead of __iowrite32_copy;
> - update multi-line comment format.
> 

This looks good now.  I will queue this on March 13th when 6.3-rc2 is out.

Thanks,
Mathieu

> Changes since v3
> - remove Reported-by
> 
> Changes since v2
> - fix warning "cast from pointer to integer of different size"
> reported by kernel test robot.
> 
> Changes since v1
> - added missing check for cases when the memory slot is bigger than the file size;
> - added a custom memset function
> - removed is_iomem flag since is not used here
> - updated custom memcpy function to avoid reading after end of source
> ---
>  drivers/remoteproc/imx_dsp_rproc.c | 187 ++++++++++++++++++++++++++++-
>  1 file changed, 186 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index 81d3a01e1444..dcbb957bc7ac 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -739,6 +739,191 @@ static void imx_dsp_rproc_kick(struct rproc *rproc, int vqid)
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
> +	const u32 *source = src;
> +	u32 affected_mask;
> +	u32 *dst = dest;
> +	int i, q, r;
> +	u32 tmp;
> +
> +	/* destination must be 32bit aligned */
> +	if (!IS_ALIGNED((uintptr_t)dest, 4))
> +		return -EINVAL;
> +
> +	q = size / 4;
> +	r = size % 4;
> +
> +	/* copy data in units of 32 bits at a time */
> +	for (i = 0; i < q; i++)
> +		writel(source[i], &dst[i]);
> +
> +	if (r) {
> +		affected_mask = GENMASK(8 * r, 0);
> +
> +		/*
> +		 * first read the 32bit data of dest, then change affected
> +		 * bytes, and write back to dest.
> +		 * For unaffected bytes, it should not be changed
> +		 */
> +		tmp = readl(dest + q * 4);
> +		tmp &= ~affected_mask;
> +
> +		/* avoid reading after end of source */
> +		for (i = 0; i < r; i++)
> +			tmp |= (src_byte[q * 4 + i] << (8 * i));
> +
> +		writel(tmp, dest + q * 4);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Custom memset implementation for i.MX DSP Cores
> + *
> + * The IRAM is part of the HiFi DSP.
> + * According to hw specs only 32-bits writes are allowed.
> + */
> +static int imx_dsp_rproc_memset(void *addr, u8 value, size_t size)
> +{
> +	u32 tmp_val = value;
> +	u32 *tmp_dst = addr;
> +	u32 affected_mask;
> +	int q, r;
> +	u32 tmp;
> +
> +	/* destination must be 32bit aligned */
> +	if (!IS_ALIGNED((uintptr_t)addr, 4))
> +		return -EINVAL;
> +
> +	tmp_val |= tmp_val << 8;
> +	tmp_val |= tmp_val << 16;
> +
> +	q = size / 4;
> +	r = size % 4;
> +
> +	while (q--)
> +		writel(tmp_val, tmp_dst++);
> +
> +	if (r) {
> +		affected_mask = GENMASK(8 * r, 0);
> +
> +		/*
> +		 * first read the 32bit data of addr, then change affected
> +		 * bytes, and write back to addr.
> +		 * For unaffected bytes, it should not be changed
> +		 */
> +		tmp = readl(tmp_dst);
> +		tmp &= ~affected_mask;
> +
> +		tmp |= (tmp_val & affected_mask);
> +		writel(tmp, tmp_dst);
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
> +		ptr = rproc_da_to_va(rproc, da, memsz, NULL);
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
> +
> +		/* zero out remaining memory for this segment */
> +		if (memsz > filesz) {
> +			ret = imx_dsp_rproc_memset(ptr + filesz, 0, memsz - filesz);
> +			if (ret) {
> +				dev_err(dev, "memset failed for da 0x%llx memsz 0x%llx\n",
> +					da, memsz);
> +				break;
> +			}
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  static int imx_dsp_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
>  {
>  	if (rproc_elf_load_rsc_table(rproc, fw))
> @@ -753,7 +938,7 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
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
