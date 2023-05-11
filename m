Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767FA6FF97D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238914AbjEKS02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238411AbjEKS00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:26:26 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09BE10C6;
        Thu, 11 May 2023 11:26:22 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id D310E5FD0C;
        Thu, 11 May 2023 21:26:20 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1683829580;
        bh=5nTAfm/pvw11kHJn8DB2F1CXjcxkc985Z7SnZU2jNZw=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=AgMOHm0+2/cEkhAS9xFjJ3Watg2imQsL3Nimrvhnksp0qHif0wmln6Iavj/w451dv
         jJNEdbOuhpuDfNa1h+S4SjZEazN2+v+NFJ+AB+7+0xl8zyBEhant2cu0l7G0SMO1Pz
         vNK9qbrNjnn+oRsju0bDj8J2hOgubkP1FMvLzTcLJuwEjHEywCroEAJzEg3J9DXWSp
         v24jfo6DMf/y+vvEs+nl2mF89lgsaEMMSyAF8tEeczWIpU4bTDuec6vWoFCxsFCvV+
         x3qIK3d163DzMdNrKTjKYSMegDJvg7NyXV7WlBnGXRqZwZgFgGcc1OK2fCpXDn26fd
         /AJM8X2VaQt7g==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu, 11 May 2023 21:26:16 +0300 (MSK)
Message-ID: <c873b5a9-17ad-767c-5b20-35a49ab2bd40@sberdevices.ru>
Date:   Thu, 11 May 2023 21:21:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RESEND PATCH v3] mtd: rawnand: macronix: OTP access for
 MX30LFxG18AC
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Boris Brezillon <boris.brezillon@collabora.com>
References: <20230511152120.3297853-1-AVKrasnov@sberdevices.ru>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230511152120.3297853-1-AVKrasnov@sberdevices.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/11 10:21:00 #21259776
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Mason Yang <masonccyang@mxic.com.tw> and Boris Brezillon <boris.brezillon@collabora.com>

On 11.05.2023 18:21, Arseniy Krasnov wrote:
> This adds support for OTP area access on MX30LFxG18AC chip series.
> 
> Changelog:
>   v1 -> v2:
>   * Add slab.h include due to kernel test robot error.
>   v2 -> v3:
>   * Use 'uint64_t' as input argument for 'do_div()' instead
>     of 'unsigned long' due to kernel test robot error.
> 
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  drivers/mtd/nand/raw/nand_macronix.c | 213 +++++++++++++++++++++++++++
>  1 file changed, 213 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
> index 1472f925f386..2301f990678e 100644
> --- a/drivers/mtd/nand/raw/nand_macronix.c
> +++ b/drivers/mtd/nand/raw/nand_macronix.c
> @@ -6,6 +6,7 @@
>   * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
>   */
>  
> +#include <linux/slab.h>
>  #include "linux/delay.h"
>  #include "internals.h"
>  
> @@ -31,6 +32,20 @@
>  
>  #define MXIC_CMD_POWER_DOWN 0xB9
>  
> +#define ONFI_FEATURE_ADDR_30LFXG18AC_OTP	0x90
> +#define MACRONIX_30LFXG18AC_OTP_START_PAGE	0
> +#define MACRONIX_30LFXG18AC_OTP_PAGES		30
> +#define MACRONIX_30LFXG18AC_OTP_PAGE_SIZE	2112
> +#define MACRONIX_30LFXG18AC_OTP_START_BYTE	\
> +	(MACRONIX_30LFXG18AC_OTP_START_PAGE *	\
> +	 MACRONIX_30LFXG18AC_OTP_PAGE_SIZE)
> +#define MACRONIX_30LFXG18AC_OTP_SIZE_BYTES	\
> +	(MACRONIX_30LFXG18AC_OTP_PAGES *	\
> +	 MACRONIX_30LFXG18AC_OTP_PAGE_SIZE)
> +
> +#define MACRONIX_30LFXG18AC_OTP_EN		BIT(0)
> +#define MACRONIX_30LFXG18AC_OTP_LOCKED		BIT(1)
> +
>  struct nand_onfi_vendor_macronix {
>  	u8 reserved;
>  	u8 reliability_func;
> @@ -316,6 +331,203 @@ static void macronix_nand_deep_power_down_support(struct nand_chip *chip)
>  	chip->ops.resume = mxic_nand_resume;
>  }
>  
> +static int macronix_30lfxg18ac_get_otp_info(struct mtd_info *mtd, size_t len,
> +					    size_t *retlen,
> +					    struct otp_info *buf)
> +{
> +	if (len < sizeof(*buf))
> +		return -EINVAL;
> +
> +	/* Don't know how to check that OTP is locked. */
> +	buf->locked = 0;
> +	buf->start = MACRONIX_30LFXG18AC_OTP_START_BYTE;
> +	buf->length = MACRONIX_30LFXG18AC_OTP_SIZE_BYTES;
> +
> +	*retlen = sizeof(*buf);
> +
> +	return 0;
> +}
> +
> +static int macronix_30lfxg18ac_otp_enable(struct nand_chip *nand)
> +{
> +	uint8_t feature_buf[ONFI_SUBFEATURE_PARAM_LEN] = { 0 };
> +
> +	feature_buf[0] = MACRONIX_30LFXG18AC_OTP_EN;
> +	return nand_set_features(nand, ONFI_FEATURE_ADDR_30LFXG18AC_OTP,
> +				 feature_buf);
> +}
> +
> +static int macronix_30lfxg18ac_otp_disable(struct nand_chip *nand)
> +{
> +	uint8_t feature_buf[ONFI_SUBFEATURE_PARAM_LEN] = { 0 };
> +
> +	return nand_set_features(nand, ONFI_FEATURE_ADDR_30LFXG18AC_OTP,
> +				 feature_buf);
> +}
> +
> +static int __macronix_30lfxg18ac_rw_otp(struct mtd_info *mtd,
> +					loff_t offs_in_flash,
> +					size_t len, size_t *retlen,
> +					u_char *buf, bool write)
> +{
> +	struct nand_chip *nand;
> +	size_t bytes_handled;
> +	off_t offs_in_page;
> +	uint64_t page;
> +	void *dma_buf;
> +	int ret;
> +
> +	/* 'nand_prog/read_page_op()' may use 'buf' as DMA buffer,
> +	 * so allocate properly aligned memory for it. This is
> +	 * needed because cross page accesses may lead to unaligned
> +	 * buffer address for DMA.
> +	 */
> +	dma_buf = kmalloc(MACRONIX_30LFXG18AC_OTP_PAGE_SIZE, GFP_KERNEL);
> +	if (!dma_buf)
> +		return -ENOMEM;
> +
> +	nand = mtd_to_nand(mtd);
> +	nand_select_target(nand, 0);
> +
> +	ret = macronix_30lfxg18ac_otp_enable(nand);
> +	if (ret)
> +		goto out_otp;
> +
> +	page = offs_in_flash;
> +	/* 'page' will be result of division. */
> +	offs_in_page = do_div(page, MACRONIX_30LFXG18AC_OTP_PAGE_SIZE);
> +	bytes_handled = 0;
> +
> +	while (bytes_handled < len &&
> +	       page < MACRONIX_30LFXG18AC_OTP_PAGES) {
> +		size_t bytes_to_handle;
> +
> +		bytes_to_handle = min_t(size_t, len - bytes_handled,
> +					MACRONIX_30LFXG18AC_OTP_PAGE_SIZE -
> +					offs_in_page);
> +
> +		if (write) {
> +			memcpy(dma_buf, &buf[bytes_handled], bytes_to_handle);
> +			ret = nand_prog_page_op(nand, page, offs_in_page,
> +						dma_buf, bytes_to_handle);
> +		} else {
> +			ret = nand_read_page_op(nand, page, offs_in_page,
> +						dma_buf, bytes_to_handle);
> +			if (!ret)
> +				memcpy(&buf[bytes_handled], dma_buf,
> +				       bytes_to_handle);
> +		}
> +		if (ret)
> +			goto out_otp;
> +
> +		bytes_handled += bytes_to_handle;
> +		offs_in_page = 0;
> +		page++;
> +	}
> +
> +	*retlen = bytes_handled;
> +
> +out_otp:
> +	if (ret)
> +		dev_err(&mtd->dev, "failed to perform OTP IO: %i\n", ret);
> +
> +	ret = macronix_30lfxg18ac_otp_disable(nand);
> +	WARN(ret, "failed to leave OTP mode after %s\n",
> +	     write ? "write" : "read");
> +	nand_deselect_target(nand);
> +	kfree(dma_buf);
> +
> +	return ret;
> +}
> +
> +static int macronix_30lfxg18ac_write_otp(struct mtd_info *mtd, loff_t to,
> +					 size_t len, size_t *rlen,
> +					 const u_char *buf)
> +{
> +	return __macronix_30lfxg18ac_rw_otp(mtd, to, len, rlen, (u_char *)buf,
> +					    true);
> +}
> +
> +static int macronix_30lfxg18ac_read_otp(struct mtd_info *mtd, loff_t from,
> +					size_t len, size_t *rlen,
> +					u_char *buf)
> +{
> +	return __macronix_30lfxg18ac_rw_otp(mtd, from, len, rlen, buf, false);
> +}
> +
> +static int macronix_30lfxg18ac_lock_otp(struct mtd_info *mtd, loff_t from,
> +					size_t len)
> +{
> +	uint8_t feature_buf[ONFI_SUBFEATURE_PARAM_LEN] = { 0 };
> +	struct nand_chip *nand;
> +	int ret;
> +
> +	if (from != MACRONIX_30LFXG18AC_OTP_START_BYTE ||
> +	    len != MACRONIX_30LFXG18AC_OTP_SIZE_BYTES)
> +		return -EINVAL;
> +
> +	dev_dbg(&mtd->dev, "locking OTP\n");
> +
> +	nand = mtd_to_nand(mtd);
> +	nand_select_target(nand, 0);
> +
> +	feature_buf[0] = MACRONIX_30LFXG18AC_OTP_EN |
> +			 MACRONIX_30LFXG18AC_OTP_LOCKED;
> +	ret = nand_set_features(nand, ONFI_FEATURE_ADDR_30LFXG18AC_OTP,
> +				feature_buf);
> +	if (ret) {
> +		dev_err(&mtd->dev,
> +			"failed to lock OTP (set features): %i\n", ret);
> +		nand_deselect_target(nand);
> +		return ret;
> +	}
> +
> +	/* Do dummy page prog with zero address. */
> +	feature_buf[0] = 0;
> +	ret = nand_prog_page_op(nand, 0, 0, feature_buf, 1);
> +	if (ret)
> +		dev_err(&mtd->dev,
> +			"failed to lock OTP (page prog): %i\n", ret);
> +
> +	ret = macronix_30lfxg18ac_otp_disable(nand);
> +	WARN(ret, "failed to leave OTP mode after lock\n");
> +
> +	nand_deselect_target(nand);
> +
> +	return ret;
> +}
> +
> +static void macronix_nand_setup_otp(struct nand_chip *chip)
> +{
> +	static const char * const supported_otp_models[] = {
> +		"MX30LF1G18AC",
> +		"MX30LF2G18AC",
> +		"MX30LF4G18AC",
> +	};
> +	struct mtd_info *mtd;
> +
> +	if (!chip->parameters.supports_set_get_features)
> +		return;
> +
> +	if (match_string(supported_otp_models,
> +			 ARRAY_SIZE(supported_otp_models),
> +			 chip->parameters.model) < 0)
> +		return;
> +
> +	bitmap_set(chip->parameters.get_feature_list,
> +		   ONFI_FEATURE_ADDR_30LFXG18AC_OTP, 1);
> +	bitmap_set(chip->parameters.set_feature_list,
> +		   ONFI_FEATURE_ADDR_30LFXG18AC_OTP, 1);
> +
> +	mtd = nand_to_mtd(chip);
> +	mtd->_get_fact_prot_info = macronix_30lfxg18ac_get_otp_info;
> +	mtd->_read_fact_prot_reg = macronix_30lfxg18ac_read_otp;
> +	mtd->_get_user_prot_info = macronix_30lfxg18ac_get_otp_info;
> +	mtd->_read_user_prot_reg = macronix_30lfxg18ac_read_otp;
> +	mtd->_write_user_prot_reg = macronix_30lfxg18ac_write_otp;
> +	mtd->_lock_user_prot_reg = macronix_30lfxg18ac_lock_otp;
> +}
> +
>  static int macronix_nand_init(struct nand_chip *chip)
>  {
>  	if (nand_is_slc(chip))
> @@ -325,6 +537,7 @@ static int macronix_nand_init(struct nand_chip *chip)
>  	macronix_nand_onfi_init(chip);
>  	macronix_nand_block_protection_support(chip);
>  	macronix_nand_deep_power_down_support(chip);
> +	macronix_nand_setup_otp(chip);
>  
>  	return 0;
>  }
