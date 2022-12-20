Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160CB652222
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbiLTONB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLTOM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:12:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C42231;
        Tue, 20 Dec 2022 06:12:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C81FB812A5;
        Tue, 20 Dec 2022 14:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07F0C433EF;
        Tue, 20 Dec 2022 14:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671545573;
        bh=zpb4/DC6yR8oR8UbNZ2CKOlxz5qdj/ekCbzAf38hhxs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K9NLs7vyQ76EhtsBq75mqCv1ltCQ+YWEyAO1eSTEj7w3L4Ebym4QtJFVnSgMFNit5
         v6AYRxYtgSpphxEVK4gOJctqgTQwHSE+3Fmasd1I3gtl0nscLXVYteNwSYZp0f3Bzx
         FuaItYqN7Co8Of//d1ogjOmKc8VFCc4jXjZ3lhtAwmzuYWXKEcz3i7NXhJMdkfg8pW
         fz8VqoL1ouK8IzD879kp2VuNmjN3IKbF/lwKpKpvjoyDUa95T3aduMeiiW5UTKKUpP
         vrYg+8WLit4riOPxK4cm9OnNN8zktJEQAOM3Tn+1qQxJ9QF+kLyQI7ic6KOPJF4cIo
         oKnlq3ktiFCxg==
Message-ID: <9c722249-e0b8-c999-a296-d2062db8bf5d@kernel.org>
Date:   Tue, 20 Dec 2022 15:12:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 6/7] spi: cadence: Add Marvell IP modification changes
Content-Language: en-US
To:     Witold Sadowski <wsadowski@marvell.com>, broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jpawar@cadence.com,
        pthombar@cadence.com, konrad@cadence.com, wbartczak@marvell.com,
        wzmuda@marvell.com
References: <20221219144254.20883-1-wsadowski@marvell.com>
 <20221219144254.20883-7-wsadowski@marvell.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221219144254.20883-7-wsadowski@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2022 15:42, Witold Sadowski wrote:
> Add support for Marvell IP modification - clock divider,
> and PHY config, and IRQ clearing.
> Clock divider block is build into Cadence XSPI controller
> and is connected directly to 800MHz clock.
> As PHY config is not set directly in IP block, driver can
> load custom PHY configuration values.
> To correctly clear interrupt in Marvell implementation
> MSI-X must be cleared too.
> 
> Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
> Reviewed-by: Chandrakala Chavva <cchavva@marvell.com>
> Tested-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> ---
>  drivers/spi/Kconfig            |  12 +++
>  drivers/spi/spi-cadence-xspi.c | 172 ++++++++++++++++++++++++++++++++-
>  2 files changed, 183 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 3b1c0878bb85..42af5943d00a 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -251,6 +251,18 @@ config SPI_CADENCE_XSPI
>  	  device with a Cadence XSPI controller and want to access the
>  	  Flash as an MTD device.
>  
> +config SPI_CADENCE_MRVL_XSPI
> +	tristate "Marvell mods for XSPI controller"
> +	depends on SPI_CADENCE_XSPI
> +
> +	help
> +	  Enable support for Marvell XSPI modifications
> +
> +	  During implementation of Cadence XSPI core Marvell
> +	  has added some additional features like clock divider,
> +	  PHY config support or non-memory SPI capabilities.
> +	  Enable that option if you want to enable these features.
> +
>  config SPI_CLPS711X
>  	tristate "CLPS711X host SPI controller"
>  	depends on ARCH_CLPS711X || COMPILE_TEST
> diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
> index 719c2f3b4771..c73faf6b0546 100644
> --- a/drivers/spi/spi-cadence-xspi.c
> +++ b/drivers/spi/spi-cadence-xspi.c
> @@ -193,6 +193,46 @@
>  #define CDNS_XSPI_POLL_TIMEOUT_US	1000
>  #define CDNS_XSPI_POLL_DELAY_US	10
>  
> +#if IS_ENABLED(CONFIG_SPI_CADENCE_MRVL_XSPI)
> +/* clock config register */
> +#define CDNS_XSPI_CLK_CTRL_AUX_REG	0x2020
> +#define CDNS_XSPI_CLK_ENABLE		BIT(0)
> +#define CDNS_XSPI_CLK_DIV		GENMASK(4, 1)
> +
> +/* Clock macros */
> +#define CDNS_XSPI_CLOCK_IO_HZ 800000000
> +#define CDNS_XSPI_CLOCK_DIVIDED(div) ((CDNS_XSPI_CLOCK_IO_HZ) / (div))
> +
> +/*PHY default values*/

Keep consistent style.

> +#define REGS_DLL_PHY_CTRL		0x00000707
> +#define CTB_RFILE_PHY_CTRL		0x00004000
> +#define RFILE_PHY_TSEL			0x00000000
> +#define RFILE_PHY_DQ_TIMING		0x00000101
> +#define RFILE_PHY_DQS_TIMING		0x00700404
> +#define RFILE_PHY_GATE_LPBK_CTRL	0x00200030
> +#define RFILE_PHY_DLL_MASTER_CTRL	0x00800000
> +#define RFILE_PHY_DLL_SLAVE_CTRL	0x0000ff01
> +
> +/*PHY config rtegisters*/
> +#define CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL		0x1034
> +#define CDNS_XSPI_PHY_CTB_RFILE_PHY_CTRL			0x0080
> +#define CDNS_XSPI_PHY_CTB_RFILE_PHY_TSEL			0x0084
> +#define CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DQ_TIMING		0x0000
> +#define CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DQS_TIMING		0x0004
> +#define CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_GATE_LPBK_CTRL	0x0008
> +#define CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DLL_MASTER_CTRL	0x000c
> +#define CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DLL_SLAVE_CTRL	0x0010
> +#define CDNS_XSPI_DATASLICE_RFILE_PHY_DLL_OBS_REG_0		0x001c
> +
> +#define CDNS_XSPI_DLL_RST_N BIT(24)
> +#define CDNS_XSPI_DLL_LOCK  BIT(0)
> +
> +/* MSI-X clear interrupt register */
> +#define CDNS_XSPI_SPIX_INTR_AUX				0x2000
> +#define CDNS_MSIX_CLEAR_IRQ					0x01
> +
> +#endif
> +
>  enum cdns_xspi_stig_instr_type {
>  	CDNS_XSPI_STIG_INSTR_TYPE_0,
>  	CDNS_XSPI_STIG_INSTR_TYPE_1,
> @@ -238,6 +278,106 @@ struct cdns_xspi_dev {
>  	enum cdns_xspi_sdma_size read_size;
>  };
>  
> +#if IS_ENABLED(CONFIG_SPI_CADENCE_MRVL_XSPI)

Why this is under #if? Different devices have always built-in support
and behavior is determined by binding method (e.g. match data).

> +
> +#define MRVL_DEFAULT_CLK 25000000
> +
> +const int cdns_xspi_clk_div_list[] = {
> +	4,	//0x0 = Divide by 4.   SPI clock is 200 MHz.
> +	6,	//0x1 = Divide by 6.   SPI clock is 133.33 MHz.
> +	8,	//0x2 = Divide by 8.   SPI clock is 100 MHz.
> +	10,	//0x3 = Divide by 10.  SPI clock is 80 MHz.
> +	12,	//0x4 = Divide by 12.  SPI clock is 66.666 MHz.
> +	16,	//0x5 = Divide by 16.  SPI clock is 50 MHz.
> +	18,	//0x6 = Divide by 18.  SPI clock is 44.44 MHz.
> +	20,	//0x7 = Divide by 20.  SPI clock is 40 MHz.
> +	24,	//0x8 = Divide by 24.  SPI clock is 33.33 MHz.
> +	32,	//0x9 = Divide by 32.  SPI clock is 25 MHz.
> +	40,	//0xA = Divide by 40.  SPI clock is 20 MHz.
> +	50,	//0xB = Divide by 50.  SPI clock is 16 MHz.
> +	64,	//0xC = Divide by 64.  SPI clock is 12.5 MHz.
> +	128,	//0xD = Divide by 128. SPI clock is 6.25 MHz.
> +	-1	//End of list

Why? This is a static list so size is known.

> +};
> +
> +static bool cdns_xspi_reset_dll(struct cdns_xspi_dev *cdns_xspi)
> +{
> +	u32 dll_cntrl = readl(cdns_xspi->iobase + CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
> +	u32 dll_lock;
> +
> +	/*Reset DLL*/
> +	dll_cntrl |= CDNS_XSPI_DLL_RST_N;
> +	writel(dll_cntrl, cdns_xspi->iobase + CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
> +
> +	/*Wait for DLL lock*/

All these comments miss spaces around.

> +	return readl_relaxed_poll_timeout(cdns_xspi->iobase +
> +		CDNS_XSPI_INTR_STATUS_REG,
> +		dll_lock, ((dll_lock & CDNS_XSPI_DLL_LOCK) == 1), 10, 10000);
> +}
> +
> +//Static confiuration of PHY

Keep consistent style.

> +static bool cdns_xspi_configure_phy(struct cdns_xspi_dev *cdns_xspi)
> +{
> +	writel(REGS_DLL_PHY_CTRL,
> +		cdns_xspi->iobase + CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);

Don't you need a phy driver?

> +	writel(CTB_RFILE_PHY_CTRL,
> +		cdns_xspi->auxbase + CDNS_XSPI_PHY_CTB_RFILE_PHY_CTRL);
> +	writel(RFILE_PHY_TSEL,
> +		cdns_xspi->auxbase + CDNS_XSPI_PHY_CTB_RFILE_PHY_TSEL);
> +	writel(RFILE_PHY_DQ_TIMING,
> +		cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DQ_TIMING);
> +	writel(RFILE_PHY_DQS_TIMING,
> +		cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DQS_TIMING);
> +	writel(RFILE_PHY_GATE_LPBK_CTRL,
> +		cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_GATE_LPBK_CTRL);
> +	writel(RFILE_PHY_DLL_MASTER_CTRL,
> +		cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DLL_MASTER_CTRL);
> +	writel(RFILE_PHY_DLL_SLAVE_CTRL,
> +		cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DLL_SLAVE_CTRL);
> +
> +	return cdns_xspi_reset_dll(cdns_xspi);
> +}
> +
> +// Find max avalible clock

Run spell-check.


Best regards,
Krzysztof

