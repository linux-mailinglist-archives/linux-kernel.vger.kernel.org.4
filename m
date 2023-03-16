Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F796BD053
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCPM7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjCPM7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:59:12 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7E172024;
        Thu, 16 Mar 2023 05:58:54 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GCPAKF025396;
        Thu, 16 Mar 2023 13:57:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=selector1;
 bh=O4MdXESRMuHAJnY5G9urN+vgVaPGITnoAbij57Bawls=;
 b=2C/7vQ64dcEtkrQRaFGoGdlrdDs4aSmUvsbiiefM5bYo9zD3oGRGMiDqNFWbMCqxM8yD
 jR6YVg4RRWCxWD4Lj4hgJ4XVNYFIFIdqWlYgRZQgW5XvnOBPQN1AJC2SPDa7dplFsZZh
 zpYZ5MTq2sPUKBoP78Yo2SVL5jLEnqdxKXqRZHGOvlwyH4Z8lS48JL1eaavr42JyrgaE
 bxZuUXltVZaXQhxQuxwUlP2K9Q5SC83eFi08DkEnoA2kdfKA+rrLZsjkagS4pmPWgaLN
 R6d3QHU/HWVLJ1mUc2TVaM2/MlicQZOCX1aSgVJuPpbvLLm2Skibv2xYmbiG03T7MqcJ 1A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pbpwqvg2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 13:57:39 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B2A66100038;
        Thu, 16 Mar 2023 13:57:36 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AB22D2171F4;
        Thu, 16 Mar 2023 13:57:36 +0100 (CET)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 16 Mar
 2023 13:57:36 +0100
Date:   Thu, 16 Mar 2023 13:57:29 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>
CC:     Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <kernel@pengutronix.de>, <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] spi: stm32: split large transfers based on word
 size instead of bytes
Message-ID: <20230316125729.GA3495627@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        kernel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230310092053.1006459-1-l.goehrs@pengutronix.de>
 <20230310092053.1006459-2-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230310092053.1006459-2-l.goehrs@pengutronix.de>
X-Disclaimer: ce message est personnel / this message is private
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_08,2023-03-16_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonard,

thanks for your patch.  I agree with this patch and tested it ok
as well on my side.

On Fri, Mar 10, 2023 at 10:20:53AM +0100, Leonard Göhrs wrote:
> The TSIZE register in CR2, to which the number of words to transfer
> is written, is only 16 Bit. This limits transfers to 65535 SPI
> _words_ at a time. The existing code uses spi_split_transfers_maxsize
> to limit transfers to 65535 _bytes_ at a time.
> 
> This breaks large transfers with bits_per_word > 8, as they are
> split inside of a word boundary by the odd size limit.
> 
> Split transfers based on the number of words instead.
> This has the added benefit of not artificially limiting the maximum
> length of bpw > 8 transfers to half or a quarter of the actual limit.
> 
> The combination of very large transfers and bits_per_word = 16 is triggered
> e.g. by MIPI DBI displays when updating large parts of the screen.
> 
> Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
> ---
>  drivers/spi/spi-stm32.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
> index def09cf0dc14..d2e16f16fae6 100644
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c
> @@ -984,9 +984,9 @@ static int stm32_spi_prepare_msg(struct spi_master *master,
>  	if (spi->cfg->set_number_of_data) {
>  		int ret;
>  
> -		ret = spi_split_transfers_maxsize(master, msg,
> -						  STM32H7_SPI_TSIZE_MAX,
> -						  GFP_KERNEL | GFP_DMA);
> +		ret = spi_split_transfers_maxwords(master, msg,
> +						   STM32H7_SPI_TSIZE_MAX,
> +						   GFP_KERNEL | GFP_DMA);
>  		if (ret)
>  			return ret;
>  	}

Acked-by: Alain Volmat <alain.volmat@foss.st.com>
> -- 
> 2.30.2
> 
