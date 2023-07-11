Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E23974EEF2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjGKMcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjGKMcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:32:18 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A80170E;
        Tue, 11 Jul 2023 05:31:50 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b6f943383eso89454491fa.2;
        Tue, 11 Jul 2023 05:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689078626; x=1691670626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PF44NEqyxP0uEPvVdBdUhZoOyhnmXaRRtdBTolupizs=;
        b=SBnTfmlUAjKWCRn3fyds5WJnq/rFhCyNY0inIr58sbmQdnr0ekqm/rRHOpDPaGy/KO
         B5+bnED3EocI70B/1Liqfviz84UQamIYXCfhBLJdAwpngn8GsImdPLHw3RB6cx2k3qLl
         nSGU6gtvVw3/VsXZCkMPykBjpKDuKmimIVto3O71KEXoVSR8sXs9wWBC1yWjR9VJRV7y
         Wiz8QKW407Y9wEjIJVzHwlxfi2RJhdAg86N/DwGw/jxMsF0gA+NEhyREeEq19FirWzm/
         TqVILtBOKMHlbGVQP5ypx9ZxmExDySMPGPYIR/gAUwwQJjSdRAbKTqb1KbxEGl8qDyoh
         Eb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689078626; x=1691670626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PF44NEqyxP0uEPvVdBdUhZoOyhnmXaRRtdBTolupizs=;
        b=Wx/jnBmhVE1jQ5jrjbbacZ8TLn5VsJx0GuztMGkwsPMDY0xnjAeu2JNICuubWKiCF0
         8ITWeSCUoalCCG+YtJ3RKl/kcmVY2hcps7SfG5KHwLnlCol2TH29YM5C6RZabft68uyf
         gm4aC2WfOgglcyRqMlrbjHYAmBt9S78Umm+JOHHlhCsZU+hjZEEJlaCHtaYkr7VRUU3e
         A/83Sxsy/IrZlvPci9BcZrBOWQmwbzGsxjdZ3lEq4RZ2nCWvl7DlfTK01HMJ9WxskJ5v
         zDsfSvkt3GXMF7yW2agAvBe5MNWI+8nrWHmqEFz1emIcVoCsfExzY+zIVNcTQ5YnAbRn
         M56Q==
X-Gm-Message-State: ABy/qLblTUsS/QBgwrVsGf6swtsAz/wUo3UVCAOsYgzt7kRE4yr4K4z9
        RatHO7kuN5rQvy4h3FTfy6ecnNAhI1vMYg==
X-Google-Smtp-Source: APBJJlEGAsotaRV20l259BaTNO1He84gEShKxa1gOSyhZTOSrSYKw2njibp5AmXp10CkNfmdPINRWg==
X-Received: by 2002:a2e:8eca:0:b0:2b6:dc50:19ac with SMTP id e10-20020a2e8eca000000b002b6dc5019acmr13901724ljl.31.1689078625694;
        Tue, 11 Jul 2023 05:30:25 -0700 (PDT)
Received: from mobilestation ([85.249.18.12])
        by smtp.gmail.com with ESMTPSA id j17-20020a2e6e11000000b002b6ee75648fsm441355ljc.12.2023.07.11.05.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:30:24 -0700 (PDT)
Date:   Tue, 11 Jul 2023 15:30:19 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Amit Kumar Mahapatra via Alsa-devel 
        <alsa-devel@alsa-project.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v2 13/15] spi: Rename SPI_MASTER_GPIO_SS to
 SPI_CONTROLLER_GPIO_SS
Message-ID: <tvm772o6uqndgyjvycv27qouqq76crpre5tyqcnanaautqjjwn@pydiwhjzhbgd>
References: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
 <20230710154932.68377-14-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710154932.68377-14-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 06:49:30PM +0300, Andy Shevchenko wrote:
> Rename SPI_MASTER_GPIO_SS to SPI_CONTROLLER_GPIO_SS and
> convert the users to SPI_CONTROLLER_GPIO_SS to follow

* I'm not an expert in English, but imo the next would look a
* bit more readable:
* convert s/the users to SPI_CONTROLLER_GPIO_SS/the code to using SPI_CONTROLLER_GPIO_SS

> the new naming shema.

s/shema/schema

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
[...]

>  drivers/spi/spi-dw-core.c  | 2 +-

[...]

> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index a8ba41ad4541..45f5acc26b1d 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -932,7 +932,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>  	if (dws->mem_ops.exec_op)
>  		master->mem_ops = &dws->mem_ops;
>  	master->max_speed_hz = dws->max_freq;
> -	master->flags = SPI_MASTER_GPIO_SS;
> +	master->flags = SPI_CONTROLLER_GPIO_SS;
>  	master->auto_runtime_pm = true;
>  
>  	/* Get default rx sample delay */

For the DW APB/AHB SSI driver:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

[...]

> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 06a92a3a5746..bcabae98cb7c 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -995,7 +995,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
>  				gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), activate);
>  		}
>  		/* Some SPI masters need both GPIO CS & slave_select */
> -		if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
> +		if ((spi->controller->flags & SPI_CONTROLLER_GPIO_SS) &&
>  		    spi->controller->set_cs)
>  			spi->controller->set_cs(spi, !enable);
>  	} else if (spi->controller->set_cs) {
> @@ -3020,7 +3020,7 @@ static int spi_get_gpio_descs(struct spi_controller *ctlr)
>  
>  	ctlr->unused_native_cs = ffs(~native_cs_mask) - 1;
>  
> -	if ((ctlr->flags & SPI_MASTER_GPIO_SS) && num_cs_gpios &&
> +	if ((ctlr->flags & SPI_CONTROLLER_GPIO_SS) && num_cs_gpios &&
>  	    ctlr->max_native_cs && ctlr->unused_native_cs >= ctlr->max_native_cs) {
>  		dev_err(dev, "No unused native chip select available\n");
>  		return -EINVAL;
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index cdc3addfe117..43f6c3f71a76 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -578,8 +578,7 @@ struct spi_controller {
>  #define SPI_CONTROLLER_NO_TX		BIT(2)	/* Can't do buffer write */
>  #define SPI_CONTROLLER_MUST_RX		BIT(3)	/* Requires rx */
>  #define SPI_CONTROLLER_MUST_TX		BIT(4)	/* Requires tx */
> -
> -#define SPI_MASTER_GPIO_SS		BIT(5)	/* GPIO CS must select slave */
> +#define SPI_CONTROLLER_GPIO_SS		BIT(5)	/* GPIO CS must select slave */
>  
>  	/* Flag indicating if the allocation of this struct is devres-managed */
>  	bool			devm_allocated;
> -- 
> 2.40.0.1.gaa8946217a0b
> 
