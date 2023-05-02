Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D576F3E5B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 09:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjEBHVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 03:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEBHVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 03:21:36 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB25199C;
        Tue,  2 May 2023 00:21:33 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34271LSn022463;
        Tue, 2 May 2023 09:21:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=selector1; bh=FiYDlr+9QsFpn+Fq0qo39xI9ntpX84DQgkMW6PranEc=;
 b=PTbSQwiUBZZ6vrJCZG3ikRUMl8IPfhYwXgsgmYqHUwPW5wpXlKg9jvfzguhWCK0bP1oJ
 pcfkNGZJGkrEVVpj4mPoyplHGAqwCplEuBVpGgaBL3agdcfRmT15/Uqvi7sB5SLfwe8Z
 k0rx+hKorb9ZrqzcCUXgqPh+JgXzbp5ey1TJJaLCQYMSR8c9qZb+eJEvgsWKVu5hvrc1
 VmiFMYjtzpGyl3apVKV+VlPTRjBqNDNnA4/gTutn3OJDJtEkdRD3jpgusBIcbx62vpBA
 3K4ZYLyVdCaYz/jRGW9ylL0A6p4PP22kIbUh5E5VGh2JNznhKLvs+g/J70jgD7rRZrqL gA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3q8tk3p7em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 09:21:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AB3A910002A;
        Tue,  2 May 2023 09:21:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6355B2115FC;
        Tue,  2 May 2023 09:21:12 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 2 May
 2023 09:21:12 +0200
Date:   Tue, 2 May 2023 09:20:58 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Valentin Caron <valentin.caron@foss.st.com>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] spi: stm32: add support for stm32h7 SPI slave
 underrun detection
Message-ID: <20230502072058.GA1167229@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Valentin Caron <valentin.caron@foss.st.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230428121524.2125832-1-valentin.caron@foss.st.com>
 <20230428121524.2125832-8-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230428121524.2125832-8-valentin.caron@foss.st.com>
X-Disclaimer: ce message est personnel / this message is private
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_04,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

thanks.

On Fri, Apr 28, 2023 at 02:15:24PM +0200, Valentin Caron wrote:
> If stm32h7 SPI controller is in slave role and TX FIFO is abnormally empty
> during transaction, controller is able to automatically send either a
> pattern, the last transmitted data, or the last received data.
> 
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
> ---
>  drivers/spi/spi-stm32.c | 112 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
> 
> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
> index 2db6f93654d7..0063c2f69265 100644
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c
> @@ -18,6 +18,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  #include <linux/spi/spi.h>
> +#include <dt-bindings/spi/spi-stm32.h>
>  
>  #define DRIVER_NAME "spi_stm32"
>  
> @@ -84,6 +85,7 @@
>  #define STM32H7_SPI_IFCR		0x18
>  #define STM32H7_SPI_TXDR		0x20
>  #define STM32H7_SPI_RXDR		0x30
> +#define STM32H7_SPI_UDRDR		0x4C
>  #define STM32H7_SPI_I2SCFGR		0x50
>  
>  /* STM32H7_SPI_CR1 bit fields */
> @@ -101,6 +103,14 @@
>  /* STM32H7_SPI_CFG1 bit fields */
>  #define STM32H7_SPI_CFG1_DSIZE		GENMASK(4, 0)
>  #define STM32H7_SPI_CFG1_FTHLV		GENMASK(8, 5)
> +#define STM32H7_SPI_CFG1_UDRDET		GENMASK(12, 11)
> +#define STM32H7_SPI_CFG1_UDRDET_BEGIN	0
> +#define STM32H7_SPI_CFG1_UDRDET_LAST	1
> +#define STM32H7_SPI_CFG1_UDRDET_SS	2
> +#define STM32H7_SPI_CFG1_UDRCFG		GENMASK(10, 9)
> +#define STM32H7_SPI_CFG1_UDRCFG_PTRN	0
> +#define STM32H7_SPI_CFG1_UDRCFG_LAST_R	1
> +#define STM32H7_SPI_CFG1_UDRCFG_LAST_T	2
>  #define STM32H7_SPI_CFG1_RXDMAEN	BIT(14)
>  #define STM32H7_SPI_CFG1_TXDMAEN	BIT(15)
>  #define STM32H7_SPI_CFG1_MBR		GENMASK(30, 28)
> @@ -126,6 +136,7 @@
>  #define STM32H7_SPI_IER_DXPIE		BIT(2)
>  #define STM32H7_SPI_IER_EOTIE		BIT(3)
>  #define STM32H7_SPI_IER_TXTFIE		BIT(4)
> +#define STM32H7_SPI_IER_UDRIE		BIT(5)
>  #define STM32H7_SPI_IER_OVRIE		BIT(6)
>  #define STM32H7_SPI_IER_MODFIE		BIT(9)
>  #define STM32H7_SPI_IER_ALL		GENMASK(10, 0)
> @@ -134,6 +145,7 @@
>  #define STM32H7_SPI_SR_RXP		BIT(0)
>  #define STM32H7_SPI_SR_TXP		BIT(1)
>  #define STM32H7_SPI_SR_EOT		BIT(3)
> +#define STM32H7_SPI_SR_UDR		BIT(5)
>  #define STM32H7_SPI_SR_OVR		BIT(6)
>  #define STM32H7_SPI_SR_MODF		BIT(9)
>  #define STM32H7_SPI_SR_SUSP		BIT(11)
> @@ -239,6 +251,8 @@ struct stm32_spi;
>   * @baud_rate_div_max: maximum baud rate divisor
>   * @has_fifo: boolean to know if fifo is used for driver
>   * @flags: compatible specific SPI controller flags used at registration time
> + * @set_slave_udr: routine to configure registers to desired slave underrun
> + * behavior (if driver has this functionality)
>   */
>  struct stm32_spi_cfg {
>  	const struct stm32_spi_regspec *regs;
> @@ -260,6 +274,7 @@ struct stm32_spi_cfg {
>  	unsigned int baud_rate_div_max;
>  	bool has_fifo;
>  	u16 flags;
> +	void (*set_slave_udr)(struct stm32_spi *spi);
>  };
>  
>  /**
> @@ -288,6 +303,8 @@ struct stm32_spi_cfg {
>   * @dma_rx: dma channel for RX transfer
>   * @phys_addr: SPI registers physical base address
>   * @slave_mode: the controller is configured as SPI slave
> + * @slave_udr_mode: slave underrun behavior
> + * @slave_udr_pattern: slave underrun pattern parameter
>   */
>  struct stm32_spi {
>  	struct device *dev;
> @@ -317,6 +334,8 @@ struct stm32_spi {
>  	dma_addr_t phys_addr;
>  
>  	bool slave_mode;
> +	u32 slave_udr_mode;
> +	u32 slave_udr_pattern;
>  };
>  
>  static const struct stm32_spi_regspec stm32f4_spi_regspec = {
> @@ -921,6 +940,14 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
>  		end = true;
>  	}
>  
> +	if (sr & STM32H7_SPI_SR_UDR) {
> +		static DEFINE_RATELIMIT_STATE(rs,
> +					      DEFAULT_RATELIMIT_INTERVAL * 10,
> +					      1);
> +		if (__ratelimit(&rs))
> +			dev_dbg_ratelimited(spi->dev, "Underrun detected\n");
> +	}
> +
>  	if (sr & STM32H7_SPI_SR_EOT) {
>  		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
>  			stm32h7_spi_read_rxfifo(spi);
> @@ -1178,6 +1205,9 @@ static int stm32h7_spi_transfer_one_irq(struct stm32_spi *spi)
>  	if (spi->tx_buf)
>  		stm32h7_spi_write_txfifo(spi);
>  
> +	if (STM32_SPI_SLAVE_MODE(spi) && spi->slave_udr_mode != SPI_NO_ACTION)
> +		ier |= STM32H7_SPI_IER_UDRIE;
> +
>  	if (STM32_SPI_MASTER_MODE(spi))
>  		stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
>  
> @@ -1222,6 +1252,9 @@ static void stm32h7_spi_transfer_one_dma_start(struct stm32_spi *spi)
>  	if (spi->cur_comm == SPI_SIMPLEX_TX || spi->cur_comm == SPI_3WIRE_TX)
>  		ier |= STM32H7_SPI_IER_EOTIE | STM32H7_SPI_IER_TXTFIE;
>  
> +	if (STM32_SPI_SLAVE_MODE(spi) && spi->slave_udr_mode != SPI_NO_ACTION)
> +		ier |= STM32H7_SPI_IER_UDRIE;
> +
>  	stm32_spi_set_bits(spi, STM32H7_SPI_IER, ier);
>  
>  	stm32_spi_enable(spi);
> @@ -1530,6 +1563,53 @@ static int stm32h7_spi_number_of_data(struct stm32_spi *spi, u32 nb_words)
>  	return 0;
>  }
>  
> +/**
> + * stm32h7_spi_set_slave_udr - configure slave underrun detection and reaction
> + * @spi: pointer to the spi controller data structure
> + */
> +static void stm32h7_spi_set_slave_udr(struct stm32_spi *spi)
> +{
> +	u32 max_udr_ptrn, udr_ptrn, cfg1_setb = 0;
> +
> +	if (spi->slave_udr_mode == SPI_NO_ACTION)
> +		return;
> +
> +	switch (spi->slave_udr_mode) {
> +	case SPI_SEND_PATTERN:
> +		max_udr_ptrn = (1 << spi->cur_bpw) - 1;
> +		if (spi->slave_udr_pattern > max_udr_ptrn) {
> +			udr_ptrn = spi->slave_udr_pattern & max_udr_ptrn;
> +			dev_warn(spi->dev,
> +				 "force slave underrun pattern to data width (> 0x%x, set 0x%x)\n",
> +				 max_udr_ptrn, udr_ptrn);
> +		} else {
> +			udr_ptrn = spi->slave_udr_pattern;
> +			dev_dbg(spi->dev, "spi slave underrun: send pattern (0x%x)\n",
> +				spi->slave_udr_pattern);
> +		}
> +		writel_relaxed(udr_ptrn, spi->base + STM32H7_SPI_UDRDR);
> +		cfg1_setb |= FIELD_PREP(STM32H7_SPI_CFG1_UDRCFG, STM32H7_SPI_CFG1_UDRCFG_PTRN);
> +		break;
> +	case SPI_REPEAT_LAST_RECEIVED_DATA:
> +		cfg1_setb |= FIELD_PREP(STM32H7_SPI_CFG1_UDRCFG, STM32H7_SPI_CFG1_UDRCFG_LAST_R);
> +		dev_dbg(spi->dev, "spi slave underrun: repeat received data\n");
> +		break;
> +	case SPI_REPEAT_LAST_TRANSMITTED_DATA:
> +		cfg1_setb |= FIELD_PREP(STM32H7_SPI_CFG1_UDRCFG, STM32H7_SPI_CFG1_UDRCFG_LAST_T);
> +		dev_dbg(spi->dev, "spi slave underrun: repeat transmitted data\n");
> +		break;
> +	default:
> +		dev_warn(spi->dev, "slave underrun detection disabled\n");
> +		spi->slave_udr_mode = SPI_NO_ACTION;
> +	}
> +
> +	if (spi->slave_udr_mode != SPI_NO_ACTION) {
> +		cfg1_setb |= FIELD_PREP(STM32H7_SPI_CFG1_UDRDET, STM32H7_SPI_CFG1_UDRDET_LAST);
> +
> +		stm32_spi_set_bits(spi,  STM32H7_SPI_CFG1, cfg1_setb);
> +	}
> +}
> +
>  /**
>   * stm32_spi_transfer_one_setup - common setup to transfer a single
>   *				  spi_transfer either using DMA or
> @@ -1591,6 +1671,9 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
>  			goto out;
>  	}
>  
> +	if (STM32_SPI_SLAVE_MODE(spi) && spi->cfg->set_slave_udr)
> +		spi->cfg->set_slave_udr(spi);
> +
>  	dev_dbg(spi->dev, "transfer communication mode set to %d\n",
>  		spi->cur_comm);
>  	dev_dbg(spi->dev,
> @@ -1774,6 +1857,7 @@ static const struct stm32_spi_cfg stm32h7_spi_cfg = {
>  	.baud_rate_div_min = STM32H7_SPI_MBR_DIV_MIN,
>  	.baud_rate_div_max = STM32H7_SPI_MBR_DIV_MAX,
>  	.has_fifo = true,
> +	.set_slave_udr = stm32h7_spi_set_slave_udr,
>  };
>  
>  static const struct of_device_id stm32_spi_of_match[] = {
> @@ -1789,6 +1873,31 @@ static int stm32h7_spi_slave_abort(struct spi_controller *ctrl)
>  	return 0;
>  }
>  
> +static void stm32h7_spi_parse_slave_config(struct stm32_spi *spi, struct device_node *np)
> +{
> +	u32 udr_configs[2] = { 0, 0 };
> +	int count, ret;
> +
> +	count = of_property_count_elems_of_size(np, "st,spi-slave-underrun", sizeof(u32));
> +	if (count <= 0) {
> +		if (count != -EINVAL)
> +			dev_err(spi->dev, "Invalid st,spi-slave-underrun property\n");
> +		return;
> +	}
> +
> +	ret = of_property_read_u32_array(np, "st,spi-slave-underrun", udr_configs, count);
> +	if (ret)
> +		return;
> +
> +	spi->slave_udr_mode = udr_configs[0];
> +	if (spi->slave_udr_mode == SPI_SEND_PATTERN) {
> +		if (count > 1)
> +			spi->slave_udr_pattern = udr_configs[1];
> +		else
> +			dev_warn(spi->dev, "Missing pattern in st,spi-slave-underrun property\n");
> +	}
> +}
> +
>  static int stm32_spi_probe(struct platform_device *pdev)
>  {
>  	struct spi_controller *ctrl;
> @@ -1842,6 +1951,9 @@ static int stm32_spi_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	if (STM32_SPI_SLAVE_MODE(spi))
> +		stm32h7_spi_parse_slave_config(spi, np);
> +
>  	spi->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(spi->clk)) {
>  		ret = PTR_ERR(spi->clk);
> -- 
> 2.25.1
> 

Acked-by: Alain Volmat <alain.volmat@foss.st.com>

Regards,
Alain
