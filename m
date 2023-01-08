Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFE1661546
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 13:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbjAHM6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 07:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAHM6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 07:58:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA55DEF7;
        Sun,  8 Jan 2023 04:58:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A5E0B80976;
        Sun,  8 Jan 2023 12:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD94C433EF;
        Sun,  8 Jan 2023 12:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673182679;
        bh=TxvREl6UDYmnCeKmIm1J8t4vc0IFfK/snhTTrx3rGQY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V/nkC+C0lUnI/amaOQ28+jUx+I3BND94oxh4UPQ8py0HazQ/K/8fmSSHAHMztjwkI
         gTC0BkeJZR+z4BOjhA59pq9GHSTdwt9bSIeab/9Jfh46mSEEWHemGZ/c3sR06VUnLh
         bHBcmmPbth21RZ+lZI7Kbn1HDHlesu3/qyOcuLbUkUVYH9rsOGEDgMxAhMHL71jibe
         QLmzOXUTu9wFy1hKOXd82TSAV7mBrd5L606wluM6knLwmNHFe+CKR9frYOomM50yQN
         MqFOdo9UBWd1iQhsB8mUdiNhw5bZsCddgSEkjKE3Q40VDASLZM2JiD8cljWfvYoiHr
         ZS5mAlJZjYyQA==
Date:   Sun, 8 Jan 2023 13:11:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: stm32-dfsdm: add id registers support
Message-ID: <20230108131126.39e15757@jic23-huawei>
In-Reply-To: <20230105125331.328275-1-olivier.moysan@foss.st.com>
References: <20230105125331.328275-1-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2023 13:53:30 +0100
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> Add support of identification registers to STM32 DFSDM
> to allow hardware capabilities discovery and configuration check.
> The number of filters and channels, are read from registers,
> when they are available.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
One minor thing inline. I'll tweak it whilst applying.


Applied with that tweak to the togreg branch of iio.git and pushed out
as testing for 0-day etc to look at it.

Thanks,

Jonathan

> ---
> Changes in v2:
> - Add and update comments
> - Remove useless masks



> diff --git a/drivers/iio/adc/stm32-dfsdm.h b/drivers/iio/adc/stm32-dfsdm.h
> index 4afc1f528b78..b64cfb42c549 100644
> --- a/drivers/iio/adc/stm32-dfsdm.h
> +++ b/drivers/iio/adc/stm32-dfsdm.h
> @@ -13,25 +13,29 @@

...

>  /*
> @@ -231,6 +235,28 @@
>  #define DFSDM_AWCFR_AWHTF_MASK	GENMASK(15, 8)
>  #define DFSDM_AWCFR_AWHTF(v)	FIELD_PREP(DFSDM_AWCFR_AWHTF_MASK, v)
>  
> +/*
> + * Identification register definitions
> + */
> +#define DFSDM_HWCFGR		0x7F0
> +#define DFSDM_VERR		0x7F4
> +#define DFSDM_IPIDR		0x7F8
> +#define DFSDM_SIDR		0x7FC
> +
> +/* HWCFGR: Hardware configuration register */
> +#define DFSDM_HWCFGR_NBT_SHIFT	0

The _SHIFT macros don't add anything useful over using
the _MASK ones directly.  So drop them.

> +#define DFSDM_HWCFGR_NBT_MASK	GENMASK(7, 0)
> +#define DFSDM_HWCFGR_NBF_SHIFT	8
> +#define DFSDM_HWCFGR_NBF_MASK	GENMASK(15, 8)
> +
> +/* VERR: Version register */
> +#define DFSDM_VERR_MINREV_SHIFT	0
> +#define DFSDM_VERR_MINREV_MASK	GENMASK(3, 0)
> +#define DFSDM_VERR_MAJREV_SHIFT	4
> +#define DFSDM_VERR_MAJREV_MASK	GENMASK(7, 4)
> +
> +#define STM32MP15_IPIDR_NUMBER	0x00110031
> +
>  /* DFSDM filter order  */
>  enum stm32_dfsdm_sinc_order {
>  	DFSDM_FASTSINC_ORDER, /* FastSinc filter type */

